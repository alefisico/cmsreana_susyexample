FROM cmssw/el9:x86_64


ARG CMS_PATH=/cvmfs/cms.cern.ch
ARG CMSSW_RELEASE=CMSSW_13_0_10
ARG SCRAM_ARCH=el9_amd64_gcc11
#ARG CMSSW_RELEASE=CMSSW_10_6_8_patch1
#ARG SCRAM_ARCH=slc7_amd64_gcc700


SHELL ["/bin/bash", "-c"]

WORKDIR /code

RUN shopt -s expand_aliases && \
    set +u && \
    source ${CMS_PATH}/cmsset_default.sh; set -u && \
    cmsrel ${CMSSW_RELEASE} && \
    cd ${CMSSW_RELEASE}/src && \
    cmsenv && \
    git config --global user.name "A happy CMS user" && \
    git config --global user.email "user@cms.cern" && \
    git config --global user.github "ahappycmsuser" && \
    git cms-init && \
    git clone https://github.com/cms-nanoAOD/nanoAOD-tools.git PhysicsTools/NanoAODTools && \
    mkdir ${CMSSW_BASE}/src/SUS_ex

#ADD ZPeakAnalysis /code/${CMSSW_RELEASE}/src/AnalysisCode/ZPeakAnalysis

ADD analysis_code/Analysis /code/${CMSSW_RELEASE}/src/SUS_ex/Analysis

ADD analysis_code/Analysis2 /code/${CMSSW_RELEASE}/src/SUS_ex/Analysis2

RUN shopt -s expand_aliases && \
    set +u && \
    source ${CMS_PATH}/cmsset_default.sh; set -u && \
    cd ${CMSSW_RELEASE}/src && \
    cmsenv && \
    scram b


