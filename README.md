# CMS REANA SUSY example

This repository contains a simple example of running a simple CMS analysis. The workflow of the analysis is defined using [Snakemake](https://snakemake.readthedocs.io/en/stable/#), and it can run on a local machine or in [CERN REANA](https://docs.reana.io/)

This tutorial is part of the [CMS Snakemake/REANA tutorial](https://alefisico.github.io/reana-tutorial/SUSYexample.html). To get more information, please follow the link.

# Step 0: Analysis container

As a good practice for reproducibility, the analysis code is included in a container. In this example, the [Dockerfile](Dockerfile) contains simple instructions on how to take a `cmssw-el9` container, set a `CMSSW` environment, clone some repositories, and copy the two directories from this repository located under [analysis_code](analysis_code/)

# Step 1: Simple analysis

To create a REANA account, follow [these instructions](https://docs.reana.io/getting-started/first-example/).

With the container prepared, one can use the following files:
 * [reana.yaml](reana.yaml)
 * [Snakefile](Snakefile)
 * [inputs.yaml](inputs.yaml)
to submit a job to REANA. This workflow takes the root file in [SUSY/](SUSY/), applies some selection, and create histograms that can be inputs to [combine](https://cms-analysis.github.io/HiggsAnalysis-CombinedLimit/latest/)

# Step 2: More complex analysis

In this step, we will pass names of datasets from DAS (defined in [datasets.sh](datasets.sh)) to `rucio` to create a list of files to process. Then it will run the analysis selection on those files, then `hadd` them, and finally create the histograms for combine. In this step, the files needed are:
 * [example2_reana.yaml](example2_reana.yaml)
 * [example2_Snakefile](example2_Snakefile)
 * [example2_inputs.yaml](example2_inputs.yaml)  
