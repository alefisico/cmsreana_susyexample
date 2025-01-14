#!/bin/bash

# Define the associative array
declare -A datasets
datasets=( ["WW"]="/WW_TuneCP5_13p6TeV_pythia8/Run3Summer22EENanoAODv12-130X_mcRun3_2022_realistic_postEE_v6-v2/NANOAODSIM" ["DY"]="/DYJetsToLL_M-50_TuneCP5_13p6TeV-madgraphMLM-pythia8/Run3Summer22EENanoAODv12-forPOG_130X_mcRun3_2022_realistic_postEE_v6-v2/NANOAODSIM" ["TTto2L2Nu"]="/TTto2L2Nu_TuneCP5_13p6TeV_powheg-pythia8/Run3Summer22EENanoAODv12-130X_mcRun3_2022_realistic_postEE_v6-v2/NANOAODSIM" )

# Check if the key is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <key>"
    exit 1
fi

# Get the key from the command line argument
key=$1

# Check if the key exists in the array
if [ -z "${datasets[$key]}" ]; then
    echo "Key '$key' not found in the dataset."
    exit 1
fi

# Get the value from the array
dataset=${datasets[$key]}

# Use the value in a command
echo "Using dataset path: $dataset"