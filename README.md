# Snakemake workflow: `Nanopore Basecalling`

Author: richard.stoeckl@ur.de

[![Snakemake](https://img.shields.io/badge/snakemake-≥8.10.0-brightgreen.svg)](https://snakemake.github.io)
[![GitHub actions status](https://github.com/basecallNanopore/basecallNanopore/workflows/Tests/badge.svg?branch=main)](https://github.com/richardstoeckl/basecallNanopore/actions?query=branch%3Amain+workflow%3ATests)

## About

This [Snakemake](https://snakemake.github.io) workflow simplifies the basecalling of raw Oxford Nanopore data with either [Guppy](https://help.nanoporetech.com/en/articles/6628042-how-do-i-install-stand-alone-guppy) or [Dorado](https://github.com/nanoporetech/dorado), specifically the task of **[Duplex](https://nanoporetech.com/platform/accuracy/duplex) basecalling multiplexed** data.

Currently, neither Guppy nor Dorado can do this in one simple step/command, so this is why I set up this workflow. Regardless of how many barcodes were used, this workflow will automatically adjust itself to produce the output.

## Workflow

Depending on what basecaller is specified in the `runs.csv` file, the data is either going through the Guppy or Dorado pipeline.

### Guppy
For Guppy, the following pipeline based on [best practices from Nanopore](https://community.nanoporetech.com/docs/prepare/library_prep_protocols/Guppy-protocol/v/gpb_2003_v1_revax_14dec2018/duplex-basecalling) and [members of the community](https://github.com/nanoporetech/duplex-tools/issues/25#issuecomment-1314782220) is used:

1. Basecall with Guppy in simplex mode with demultiplexing
2. Use [duplex_tools](https://github.com/nanoporetech/duplex-tools) `pairs_from_summary` to generate candidate read pairs
3. Use [duplex_tools](https://github.com/nanoporetech/duplex-tools) `filter_pairs` to check for similarity
4. Use the filtered pairs to basecall using Guppy in duplex mode and demultiplexing

### Dorado
For Dorado, a pipeline based on [recommendations from Nanopore](https://github.com/nanoporetech/dorado/issues/600#issuecomment-1915188395) is used:

1. Basecall with Dorado in simplex mode with demultiplexing enabled
2. Extract a list of ReadIDs for each barcode
3. Basecall using Dorado in duplex mode but constrain to the reads for each barcode seperately

## Usage
1. Install [conda](https://docs.conda.io/en/latest/miniconda.html) (mamba or miniconda is fine).
2. Install snakemake with:
```bash
conda install -c conda-forge -c bioconda snakemake
```
3. Install Guppy ([see these instructions](https://help.nanoporetech.com/en/articles/6628042-how-do-i-install-stand-alone-guppy)) and/or Dorado ([see these instructions](https://github.com/nanoporetech/dorado)), depending on what you want to use
3. [Download the latest release from this repo](https://github.com/richardstoeckl/basecallNanopore/releases/latest) and cd into it
4. Edit the `config/config.yaml` to provide the paths to your results/logs directories, and the paths to Dorado and/or Guppy, as well as any parameters you might want to change. You can test the setup by using the `config/runs_test.csv` sample sheet.
5. Edit the `config/runs.csv` file with the specific details for each run. Depending on what you enter here, the pipeline will automatically adjust what will be done.
5. Open a terminal in the main dir and start a dry-run of the pipeline with the following command. This will download and install all the dependencies for the pipeline (this step takes may take some time) and it will show you if you set up the paths correctly:

```bash
snakemake --use-conda -n --cores
```
6. Run the pipeline with
```bash
snakemake --use-conda --cores
```
---

## TODO and planned features
- basecall qc (pycoqc? fastp?)
- choose dorado duplex output (instead of fastq)
- somehow automate Dorado installation?

```
Copyright Richard Stöckl 2024.
Distributed under the Boost Software License, Version 1.0.
(See accompanying file LICENSE or copy at 
https://www.boost.org/LICENSE_1_0.txt)
```