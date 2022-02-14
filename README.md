# tomorec

This README contains various recipes for installing a Tomorec Jupyter kernel,
downloading publically available data, and executing a sample analysis
Juptyer notebook.


# CLONE THIS REPOSITORY
First clone this repository:
1. Into a running JuptyerLab session on a JupyterHub service if you have access
   to one
2. Or on to you own computer in a terminal if you do not have access to a
   JuptyerHub service

Cloning command:
```bash
git clone git@github.com:paulscherrerinstitute/tomorec.git
```

# CREATE TOMOREC KERNEL

If you already have a JupyterHub instance running into which you can
install your own kernel, then here is a recipe for creating a Tomorec kernel
in which you can run the Tomorec notebook included in this repository.

1. Open a terminal in your JuptyerLab session (File > New > Terminal) and go
   into the Tomorec repository that you have cloned:
```bash
cd tomorec/
```

2. Create the Tomorec conda environment:
```bash
source activate base
conda env create --file jupyter-kernel/tomorec-kernel-environment.yml
```

3. After conda environment creation step is done, check that your conda
   environment exists with:
```bash
conda env list
```

   The environment should appear in your list of available environments,
   similar to:
```bash
    tomorec-kernel-environment     /home/jasbru/.conda/envs/tomorec-kernel-environment
```

4. Create the Jupyter kernel from the conda environment just created:
```bash
source activate tomorec-kernel-environment
python -m ipykernel install --user --name tomorec-kernel --display-name "Tomorec Kernel"
conda deactivate
```

5. The kernel creation step should finish quickly, then check that the kernel
   specification files exist:
```bash
jupyter kernelspec list
```

Among the kernels available, you should see something like this:
```bash
tomorec-kernel /home/jasbru/.local/share/jupyter/kernels/tomorec-kernel
```


# BUILD DOCKER IMAGE

If you do not have a JupyterHub instance available, then you can build
your own docker image which contains:
* JupyterLab
* Tomorec kernel
* Tomorec notebook

# DOWNLOAD DATA
After you have a Tomorec kernel available (created via one of the two methods
mentioned above) you can download the data from:

[data doi url](url-goes-here)

# RUN NOTEBOOK
In the JupyterLab file browser, navigate to where you have cloned this
repository and double click on the notebook:
```bash
jupyter-notebooks/tomorec-lungs-analysis.ipynb
```

![open notebook](screenshots/


From the kernel selection in the upper right hand corner of the notebook
