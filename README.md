# Snakemake workflow: `Nanopore Basecalling`

Author: richard.stoeckl@ur.de

[![Snakemake](https://img.shields.io/badge/snakemake-≥8.5.0-brightgreen.svg)](https://snakemake.github.io)
[![GitHub actions status](https://github.com/<owner>/<repo>/workflows/Tests/badge.svg?branch=main)](https://github.com/richardstoeckl/basecallNanopore/actions?query=branch%3Amain+workflow%3ATests)

## Usage
1. Install [conda](https://docs.conda.io/en/latest/miniconda.html) (miniconda is fine).
2. Install snakemake with:
```bash
conda install -c conda-forge -c bioconda snakemake
```
3. Download this repo and cd into it
4. Edit the `config/config.yaml` to provide the paths to your sample sheet and results/logs directories, as well as any parameters you might want to change
5. Edit the `config/samples.csv` file with the specific details for each sample. Depending on what you enter here, the pipeline will automatically adjust what will be done.
5. Open a terminal in the main dir and start a dry-run of the pipeline with the following command. This will download and install all the dependencies for the pipeline (this step takes may take some time) and it will show you if you set up the paths correctly:
```bash
snakemake --use-conda -n --cores
```
6. Run the pipeline with
```bash
snakemake --use-conda --cores
```
---