import numpy as np
import pandas as pd
import scanpy as sc
import SEACells

# Load ATAC data
atac_cells = sc.read("../ATAC/zf_multiome_atlas_full_ATAC_v1_release.h5ad")
print(f"Single-cell ATAC data: {atac_cells.shape[0]} cells and {atac_cells.shape[1]} peaks")

# Load RNA SEACell assignments
rna_seacells_asgn = pd.read_csv("../RNA/out/RNA_SEACell_mapping.tsv.gz", sep="\t", index_col=0)

# Add SEACell assignments to the ATAC data
atac_cells.obs["SEACell"] = rna_seacells_asgn.loc[atac_cells.obs_names, "SEACell"]
obs = atac_cells.obs

# Summarize ATAC data into SEACells
atac_seacells = SEACells.core.summarize_by_SEACell(atac_cells, SEACells_label = 'SEACell', summarize_layer = 'counts')
print(f"ATAC SEACells data: {atac_seacells.shape[0]} SEACells and {atac_seacells.shape[1]} peaks")

# Normalize and log-transform the summarized data for downstream analysis
sc.pp.normalize_total(atac_seacells)
sc.pp.log1p(atac_seacells)

# Save summarized data
atac_seacells.write("../ATAC/out_from_RNA/SEACell_summarized_ATAC.h5ad")

# Log off
print("ATAC SEACells summarization complete and saved.")