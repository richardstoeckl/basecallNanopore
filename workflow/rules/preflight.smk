"""

Copyright Richard Stöckl 2024.
Distributed under the Boost Software License, Version 1.0.
(See accompanying file LICENSE or copy at 
https://www.boost.org/LICENSE_1_0.txt)

"""

"""
This script is used to define the helper functions that are used in the Snakefile.
- create a dataframe with the basecall settings
"""

runsDF = pd.read_csv(runFile, sep=",").set_index("runID", drop=False)
RUNS = runsDF.runID.to_list()
