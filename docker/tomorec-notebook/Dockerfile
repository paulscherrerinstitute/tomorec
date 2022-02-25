# Start from the base-notebook image
ARG BASE_CONTAINER=base-notebook:local
FROM $BASE_CONTAINER

# root user for installing apt packages
USER root

# Install libraries needed
RUN apt-get update --yes \
 && apt-get install --yes --no-install-recommends \
    clinfo \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Default user for installing conda packages
ARG NB_USER=${NB_USER}
ARG NB_UID=${NB_UID}
ARG NB_GID=${NB_GID}
USER ${NB_UID}

# Tomorec conda environment creation
COPY jupyter-kernel/tomorec-kernel-environment.yml \
     /tmp/tomorec-kernel-environment.yml
RUN conda env create --file /tmp/tomorec-kernel-environment.yml

# Tomopy patch
COPY jupyter-kernel/tomopy-1.10.0-upsample_factor.patch \
    /tmp/tomopy-1.10.0-upsample_factor.patch
RUN $CONDA_DIR/bin/conda install --quiet --yes patch
RUN patch -u $CONDA_DIR/envs/tomorec-kernel-environment/lib/python3.7/site-packages/tomopy/prep/alignment.py \
    -i /tmp/tomopy-1.10.0-upsample_factor.patch

# Tomorec kernel creation
RUN $CONDA_DIR/envs/tomorec-kernel-environment/bin/python \
    -m ipykernel install --name tomorec-kernel --prefix=$CONDA_DIR/ \
    --display-name "Tomorec Kernel"

# Install extensions
RUN $CONDA_DIR/bin/conda install --quiet --yes jupyterlab-favorites \
    jupyterlab-system-monitor

# Clean-up and fix the permissions
RUN conda clean --all -f -y \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete
RUN fix-permissions "${HOME}" \
 && fix-permissions "${CONDA_DIR}"
