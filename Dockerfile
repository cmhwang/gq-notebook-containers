FROM quay.io/jupyter/base-notebook

USER root

RUN apt-get update \
    && apt-get install -y curl build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/opt/conda/bin:${PATH}"

RUN conda install -y -c conda-forge \
    gdal \
    libnetcdf \
    hdf4 \
    hdf5

RUN conda install -y proj
RUN pip install --user numpy

USER $NB_UID

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt --no-cache-dir --no-binary rasterio

COPY world_pop_count.ipynb world_pop_count.ipynb