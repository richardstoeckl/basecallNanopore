'''
This script includes all the rules for basecalling and demultiplexing of ONT data.
- guppy basecalling
    - basecalling with guppy in simplex mode
    - get the pairs from the summary
    - filter the pairs
    - basecalling with guppy in duplex mode
    - combine simplex and duplex fastqs
    - remove duplex reads from simplex reads
- dorado basecalling
    - basecalling with dorado in simplex mode
    - split reads by barcode into temp files
    - basecalling with dorado in duplex mode
'''

# This is the Guppy pathway

## which runs need to be basecalled with guppy?
def get_guppyRuns(wildcards):
    print("get_guppyRuns: ", runsDF[runsDF['basecaller'] == 'guppy'].index)
    return runsDF[runsDF['basecaller'] == 'guppy'].index

## Simplex basecalling first
checkpoint guppy_simplex:
    input:
        reads= lookup(query="runID == '{run}' & basecaller == 'guppy'", within=runsDF, cols="pathToRawData"),
    output:
        dir=directory(os.path.join(INTERIMPATH,"{run}", "guppySimplex")),
        summary=os.path.join(INTERIMPATH,"{run}", "guppySimplex", "sequencing_summary.txt"),
        telemetry=os.path.join(INTERIMPATH,"{run}", "guppySimplex", "sequencing_telemetry.js"),
    threads: workflow.cores * 1
    log: 
        os.path.join(LOGPATH, "{run}", "logs", "guppy_simplex.log"),
    benchmark:
        os.path.join(LOGPATH, "{run}", "benchmarks", "guppy_simplex.tsv"),
    params:
        guppyPath=os.path.normpath(config["tools"]["guppy"]["guppyPath"]),
        config= lambda w: runsDF.loc[w.run, 'basecallingModel'] + '.cfg',
        barcodeKit= lambda w: runsDF.loc[w.run, 'barcodeKit'], 
        cudaString=config["tools"]["guppy"]["guppySimplex"]["cudaString"],
        chunksPerRunner=config["tools"]["guppy"]["guppySimplex"]["chunksPerRunner"],
    shell:
        """
        {params.guppyPath} \
        --config '{params.config}' \
        --device {params.cudaString} \
        --chunks_per_runner {params.chunksPerRunner} \
        -r --input_path {input.reads} \
        --min_qscore '10' \
        --compress_fastq \
        --records_per_fastq 0 \
        --do_read_splitting \
        --barcode_kits {params.barcodeKit} \
        --progress_stats_frequency 60 \
        -s {output.dir} >>{log} 2>&1
        """

## which reads are from the same molecule?
rule pairsFromSummary:
    input:
        summary= rules.guppy_simplex.output.summary,
    output:
        dir=directory(os.path.join(INTERIMPATH,"{run}", "pairsFromSummary")),
        ids=os.path.join(INTERIMPATH,"{run}", "pairsFromSummary", "pair_ids.txt"),
    log:
        os.path.join(LOGPATH, "{run}", "logs", "pairsFromSummary.log"),
    benchmark:
        os.path.join(LOGPATH, "{run}", "benchmarks", "pairsFromSummary.tsv"),
    threads: workflow.cores * 1
    conda:
        os.path.join(workflow.basedir, "envs","basecall.yaml"),
    shell:
        "duplex_tools pairs_from_summary {input.summary} {output.dir} 2> {log}"

## which reads are from the same molecule? pt.2 electric bogaloo
rule filterPairs:
    input:
        ids=rules.pairsFromSummary.output.ids,
        fastq=rules.guppy_simplex.output.dir,
    output:
        filteredIds=os.path.join(INTERIMPATH,"{run}", "pairsFromSummary", "pair_ids_filtered.txt"),
    log:
        os.path.join(LOGPATH,"{run}", "logs", "filterPairs.log"),
    benchmark:
        os.path.join(LOGPATH, "{run}", "benchmarks", "filterPairs.tsv"),
    threads: workflow.cores * 1
    conda:
        os.path.join(workflow.basedir, "envs","basecall.yaml")
    shell:
        "duplex_tools filter_pairs {input.ids} {input.fastq} 2> {log}"
        
## Duplex basecalling with Guppy      
rule guppy_duplex:
    input:
        reads=lookup(query="runID == '{run}' & basecaller == 'guppy'", within=runsDF, cols="pathToRawData"),
        filteredIds=rules.filterPairs.output.filteredIds,
    output:
        dir=directory(os.path.join(INTERIMPATH, "{run}", "guppyDuplex")),
        summary=os.path.join(INTERIMPATH, "{run}", "guppyDuplex", "sequencing_summary.txt"),
        telemetry=os.path.join(INTERIMPATH, "{run}", "guppyDuplex", "sequencing_telemetry.js"),
    threads: workflow.cores * 1
    log: 
        os.path.join(LOGPATH, "{run}", "logs", "guppy_duplex.log"),
    benchmark:
        os.path.join(LOGPATH, "{run}", "benchmarks", "guppy_duplex.tsv"),
    params:
        guppyPath=os.path.normpath(config["tools"]["guppy"]["guppyPath"]),
        config= str(lookup(query="runID == '{run}'", within=runsDF, cols="basecallingModel")) + '.cfg', # lambda w: runsDF.loc[w.sample, 'basecallingModel'],
        barcodeKit= lambda w: runsDF.loc[w.sample, 'barcodeKit'], 
        cudaString=config["tools"]["guppy"]["guppyDuplex"]["cudaString"],
        chunksPerRunner=config["tools"]["guppy"]["guppyDuplex"]["chunksPerRunner"],
    shell:
        """
        {params.guppyPath}_duplex \
            --config {params.config} \
            --device {params.cudaString} \
            --chunks_per_runner {params.chunksPerRunner} \
            -r --input_path {input.reads} \
            --min_qscore 10 \
            --compress_fastq \
            --records_per_fastq 0 \
            --duplex_pairing_mode from_pair_list \
            --duplex_pairing_file {input.filteredIds} \
            --barcode_kits {params.barcodeKit} \
            --progress_stats_frequency 60 \
            -s {output.dir} >>{log} 2>&1
        """

## concatinate all of the fastqs per barcode into one file
rule concatenateGuppy:
    input:
        simplex = lambda wildcards: checkpoints.guppy_simplex.get(**wildcards).output[0] + "/passed/" + wildcards.barcode,
        duplex = lambda wildcards: checkpoints.guppy_duplex.get(**wildcards).output[0] + "/passed/" + wildcards.barcode,
    output:
        simplex_concat = os.path.join(INTERIMPATH, "{run}", "guppySimplex", "{barcode}_concatinated.fasta"),
        duplex_concat = os.path.join(INTERIMPATH, "{run}", "guppyDuplex", "{barcode}_concatinated.fasta")
    shell:
        """
        cat {input.simplex}/*.fasta > {output.simplex_concat}
        cat {input.duplex}/*.fasta > {output.duplex_concat}
        """

## concatinate the duplex and the simplex called reads together and then remove the simplex reads that were used for duplex basecalling again
## so that there is no duplication of reads
rule joinGuppySimplexAndDuplex:
    input:
        ids = rules.filterPairs.output.filteredIds,
        simplex_concat = rules.concatenateGuppy.output.simplex_concat,
        duplex_concat = rules.concatenateGuppy.output.duplex_concat,
    output:
        final = os.path.join(INTERIMPATH, "{run}", "guppy", "{barcode}_finalReads.fasta.gz"),
    shell:
        # processes the pair_ids_filtered.txt file to put every read ID on its own line
        # read IDs from the paired_ids_filtered.txt, match them to sequence in simplex file, output every read that doesn't match
        # gzip the reads in memory and output them to a new file. This method avoids writing any temporary files to the disk.
        # see https://github.com/nanoporetech/duplex-tools/issues/25#issuecomment-1314782220
        """
        {{ awk '{{gsub(/ /,"\n"); print}}' {input.ids} | seqkit grep -v -f - {input.simplex_concat} ;  zcat -f {input.duplex_concat} ; }} | gzip - > {output.final}
        """

## helper function to get the barcodes
def get_guppyBarcodes(wildcards):
    print("get_guppyBarcodes: ", glob.glob(checkpoints.guppy_simplex.get(**wildcards).output[0] + "/passed/*"))
    return glob.glob(checkpoints.guppy_simplex.get(**wildcards).output[0] + "/passed/*")

## collect all the final files for guppy basecalling for each barcode
rule collectGuppy:
    input:
        expand(os.path.join(INTERIMPATH, "{run}", "guppy", "{barcode}_finalReads.fasta.gz"), barcode=get_guppyBarcodes, run=get_guppyRuns)
    output:
        os.path.join(INTERIMPATH, "basecalling", "{run}", "collectGuppy.flag"),
    shell:
        """
        echo "All barcodes processed" > {output}
        """





# this is the Dorado pathway

## which runs need to be basecalled with dorado?
def get_doradoRuns(wildcards):
    return runsDF[runsDF['basecaller'] == 'dorado'].index

## download the basecalling model if needed
rule dorado_download:
    output:
        flag=touch(os.path.join(INTERIMPATH, "{run}", "doradoDownload.flag")),
    threads: workflow.cores * 1
    log: 
        os.path.join(LOGPATH, "{run}", "logs", "doradoDownload.log"),
    params:
        doradoPath=os.path.normpath(config["tools"]["dorado"]["doradoPath"]),
        config= lambda w: runsDF.loc[w.run, 'basecallingModel'],
    shell:
        """
        {params.doradoPath} download --model {params.config} > {log}
        """

## basecall the raw data in simplex mode
rule dorado_simplex:
    input:
        model=rules.dorado_download.output.flag,
        reads= lookup(query="runID == '{run}' & basecaller == 'dorado'", within=runsDF, cols="pathToRawData"),
    output:
        bam=os.path.join(INTERIMPATH, "{run}", "doradoSimplex", "basecalled.bam"),
    threads: workflow.cores * 1
    log: 
        os.path.join(LOGPATH, "{run}", "logs", "doradoSimplex.log"),
    benchmark:
        os.path.join(LOGPATH, "{run}", "benchmarks", "doradoSimplex.tsv"),
    params:
        doradoPath=os.path.normpath(config["tools"]["dorado"]["doradoPath"]),
        config= lambda w: runsDF.loc[w.run, 'basecallingModel'],
        barcodeKit= lambda w: runsDF.loc[w.run, 'barcodeKit'], 
        cudaString=config["tools"]["dorado"]["doradoSimplex"]["cudaString"],
    shell:
        """
        {params.doradoPath} basecaller \
        --device {params.cudaString} \
        --kit-name {params.barcodeKit} \
        {params.config} \
        {input.reads} > {output.bam} 2> {log}
        """

## split the reads by barcode
checkpoint getReadIDsPerBarcode:
    input:
        bam=rules.dorado_simplex.output.bam,
    output:
        dir=directory(os.path.join(INTERIMPATH, "{run}", "doradoSimplex", "readIDsPerBarcode")),
    threads: workflow.cores * 1
    params:
        doradoPath=os.path.normpath(config["tools"]["dorado"]["doradoPath"]),
    shell:
        # 1. run "dorado summary" on the bam file
        # 2. use everything but the first line for the next command (the first line is just the header)
        # 3. append the content of the second column (the ID column) into a file that is named in the last column (the barcode column) + "_readIDs.txt"
        """
        mkdir -p {output.dir}
        {params.doradoPath} summary {input.bam} | tail -n +2 | awk '{{print $2 >> "{output.dir}/" $NF "_readIDs.txt"}}'
        """

## helper function to get the barcodes
def get_doradoBarcodes(wildcards):
    checkpoint_output = checkpoints.getReadIDsPerBarcode.get(**wildcards).output[0]
    return glob_wildcards(os.path.join(checkpoint_output, "{barcode}_readIDs.txt")).barcode

## basecall with dorado in duplex mode for each of the barcodes seperately
checkpoint dorado_duplex:
    input:
        indir=lookup(query="runID == '{run}' & basecaller == 'dorado'", within=runsDF, cols="pathToRawData"),
        readIDs=lambda w: checkpoints.getReadIDsPerBarcode.get(**w).output[0] + "/{barcode}_readIDs.txt",
    output:
        fastq=os.path.join(INTERIMPATH, "{run}", "doradoDuplex", "{barcode}_duplex.fastq"),
    log:
        os.path.join(LOGPATH, "{run}", "logs", "{barcode}_doradoDuplex.log"),
    threads: workflow.cores * 1
    params:
        doradoPath=os.path.normpath(config["tools"]["dorado"]["doradoPath"]),
        config= lambda w: runsDF.loc[w.run, 'basecallingModel'],
        barcodeKit= lambda w: runsDF.loc[w.run, 'barcodeKit'], 
        cudaString=config["tools"]["dorado"]["doradoDuplex"]["cudaString"],
    shell:
        """
        {params.doradoPath} duplex \
        --read-ids {input.readIDs} \
        --device {params.cudaString} \
        {params.config} \
        --emit-fastq \
        {input.indir} > {output.fastq} 2> {log}
        """

## flag to colelct all dorado outputs
rule collectDorado:
    input:
        dorado=collect(rules.dorado_duplex.output.fastq, run=get_doradoRuns, barcode=get_doradoBarcodes),
    output:
        flag=touch(os.path.join(INTERIMPATH, "basecalling","{run}", "collectDorado.flag"))



# collect all runs
rule collectAll:
    input:
        guppy=collect(rules.collectGuppy.output, run=get_guppyRuns),
        dorado=collect(rules.collectDorado.output, run=get_doradoRuns),
    output:
        flag=touch(os.path.join(INTERIMPATH, "basecalling","{run}", "collectAll.flag")),