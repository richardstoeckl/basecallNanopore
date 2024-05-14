'''
This script is used to define the helper functions that are used in the Snakefile.
- create a dataframe with the basecall settings
'''

runsDF = pd.read_csv(runFile, sep=",").set_index("runID", drop=False)
RUNS = runsDF.runID.to_list()
