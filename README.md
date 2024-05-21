# Snakemake workflow: `Nanopore Basecalling`

Author: richard.stoeckl@ur.de

[![Snakemake](https://img.shields.io/badge/snakemake-≥8.10.0-brightgreen.svg)](https://snakemake.github.io)
[![GitHub actions status](https://github.com/basecallNanopore/basecallNanopore/workflows/Tests/badge.svg?branch=main)](https://github.com/richardstoeckl/basecallNanopore/actions?query=branch%3Amain+workflow%3ATests)

## About

This [Snakemake](https://snakemake.github.io) workflow simplifies the basecalling of raw Oxford Nanopore data with either [Guppy](https://help.nanoporetech.com/en/articles/6628042-how-do-i-install-stand-alone-guppy) or [Dorado](https://github.com/nanoporetech/dorado), specifically the task of **[Duplex](https://nanoporetech.com/platform/accuracy/duplex) basecalling multiplexed** data.

Currently, neither Guppy nor Dorado can do this in one simple step/command, so this is why I set up this workflow. Regardless of how many barcodes were used, this workflow will automatically adjust itself to produce the output.



## Usage
1. Install [conda](https://docs.conda.io/en/latest/miniconda.html) (mamba or miniconda is fine).
2. Install snakemake with:
```bash
conda install -c conda-forge -c bioconda snakemake
```
3. Install Guppy ([see these instructions](https://help.nanoporetech.com/en/articles/6628042-how-do-i-install-stand-alone-guppy)) and/or Dorado ([see these instructions](https://github.com/nanoporetech/dorado)), depending on what you want to use
3. [Download this repo](https://github.com/richardstoeckl/basecallNanopore/archive/refs/heads/main.zip) and cd into it
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

```
Copyright Richard Stöckl 2024.
Distributed under the Boost Software License, Version 1.0.
(See accompanying file LICENSE or copy at 
https://www.boost.org/LICENSE_1_0.txt)
```