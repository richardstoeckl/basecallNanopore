# General configuration

To configure this workflow, modify `config/config.yaml` according to your needs, following the explanations provided in the file.

## "Main" section

Here you should provide the paths to your intermediary/results/logs directories. The `interim` directory will contain larger intermediary files. The `results` directory will contain the final output of the pipeline. The `log`directory will be used to store the log files for each step.
Here you should also write the name of your run file (see [relevant section below](#run-file-setup)).

## "Tools" section

Here you should give the paths to your guppy and/or dorado installation. Additionally you should change the given parameters to suit your compute setup.


# Run file setup

The setup of the basecall runs is specified via comma-separated values files (`.csv`).
Missing values can be specified by empty columns.

Depending on what you enter here, the pipeline will automatically adjust what will be done (e.g. which basecaller will be used and how many barcodes will be used).

You can use the `config/runs_test.csv`file as a template.
