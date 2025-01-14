# Define output folder
# output_dir = "$REANA_WORKSPACE"
output_dir = "."

# Define the final target rule
rule all:
    input:
        config["output_file"]

# Rule for skimming
rule skimming:
    input:
        config["nanoaod_file"]
    output:
        "output/skimming/DY_Skim.root"
    params:
        selection = '"(nMuon>0&&nTau>0&&HLT_IsoMu24)"',
        N = 1000
    container:
        "docker://gitlab-registry.cern.ch/cms-analysis/analysisexamples/snakemake-reana-examples/cmsreana_susyexample:latest"
    shell:
        """
        mkdir -p {output_dir}/output/skimming
        cd /code/CMSSW_13_0_10/src && \
        source /cvmfs/cms.cern.ch/cmsset_default.sh && \
        cmsenv && \
        python3 PhysicsTools/NanoAODTools/scripts/nano_postproc.py \
            {output_dir}/output/skimming {output_dir}/{input} \
            --bi /code/CMSSW_13_0_10/src/SUS_ex/Analysis/scripts/keep_in.txt \
            --bo /code/CMSSW_13_0_10/src/SUS_ex/Analysis/scripts/keep_out.txt \
            -c {params.selection} \
            -I SUS_ex.Analysis.DiTau_analysis analysis_mutaumc \
            -N {params.N}
        """

# Rule for datacarding
rule datacarding:
    input:
        "output/skimming/DY_Skim.root"
    output:
        config['output_file']
    params:
        year = "2022postEE"
    container:
        "docker://gitlab-registry.cern.ch/cms-analysis/analysisexamples/snakemake-reana-examples/cmsreana_susyexample:latest"
    shell:
        """
        mkdir -p {output_dir}/output/datacards
        cd /code/CMSSW_13_0_10/src/SUS_ex/Analysis2 && \
        source /cvmfs/cms.cern.ch/cmsset_default.sh && \
        cmsenv && \
        ./FinalSelection_mutau.exe {params.year} {output_dir}/{input} {output_dir}/{output} DY DY
        """
