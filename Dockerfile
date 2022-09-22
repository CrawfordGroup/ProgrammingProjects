FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y wget \
    build-essential \
    clang \
    git \ 
    gdb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get autoremove -y

ENV PATH="/usr/local/miniconda3/bin:${PATH}"
ARG PATH="/usr/local/miniconda3/bin:${PATH}"
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-py37_4.9.2-Linux-x86_64.sh \ 
    && bash Miniconda3-py37_4.9.2-Linux-x86_64.sh -p /usr/local/miniconda3 -b \
    && rm -f Miniconda3-py37_4.9.2-Linux-x86_64.sh 

RUN conda update conda
RUN conda --version
RUN conda install -c psi4 psi4 psi4-dev 
RUN conda install -c conda-forge cmake eigen julia

RUN julia -e 'using Pkg; Pkg.update(); Pkg.add("PyCall"); Pkg.add("TensorOperations")' && \
    # precompile
    julia -e 'using PyCall; using TensorOperations'

RUN ldconfig

ENTRYPOINT bash