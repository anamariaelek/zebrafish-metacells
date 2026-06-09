# Zebrahub Multiome SEACells analysis

This repo contains the code and data for the [SEACells](https://github.com/dpeerlab/SEACells/tree/main) analysis of the [Zebrahub-Multiome](https://www.biorxiv.org/content/10.1101/2024.10.18.618987v2) dataset. The hd5ad files for the RNA and ATAC data were downloaded from [drive](https://drive.google.com/drive/folders/1K3YDsXzr7f2kHx6_6pICMLhNwGOrWHDv) and placed in the respective `RNA` and `ATAC` directories. 

```
# RNA
gdown https://drive.google.com/file/d/1LNi5P4N2d9w1RC6zh4Pkk_y5Ke1Id-ym/view?usp=drive_link -O RNA/zf_multiome_atlas_full_RNA_v1_release.h5ad
# ATAC
gdown https://drive.google.com/file/d/12sixloWb6PY6O1V_0tODcLy4bGblduY1/view?usp=drive_link -O ATAC/zf_multiome_atlas_full_ATAC_v1_release.h5ad
```

The scripts to generate SEACells are in `scripts/SEACell_RNA_analysis.py` and `scripts/SEACell_ATAC_analysis.py`, for RNA and ATAC data respectively. I was able to run the RNA script for this dataset of ~95k cells successfully, but for the ATAC, the memory becomes a limiting factor and the job fails on HPC with 220 GiB of RAM. This is a known limitation of the SEACells algorithm (see a benchmark [here](https://www.nature.com/articles/s41467-025-56424-6/figures/2)). That's why I load the cell-to-metacell assignment from the RNA data and use those to create metacells for the ATAC data in `scripts/SEACell_ATAC_from_RNA.py`.  

The downstream analysis of the SEACells assignments is in `SEACells.ipynb`. Here I compute the correlation between SEACells in RNA and ATAC, and cluster SECells by correlation using hierarchical clustering.