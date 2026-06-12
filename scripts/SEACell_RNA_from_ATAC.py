import numpy as np
import pandas as pd
import scanpy as sc
import SEACells

# Load RNA data
rna_cells = sc.read("../RNA/zf_multiome_atlas_full_RNA_v1_release.h5ad")
print(f"Single-cell RNA data: {rna_cells.shape[0]} cells and {rna_cells.shape[1]} genes")

# Load ATAC SEACell assignments
atac_seacells_asgn = pd.read_csv("../ATAC/out/ATAC_SEACell_mapping.tsv.gz", sep="\t", index_col=0)

# Add SEACell assignments to the ATAC data
rna_cells.obs["SEACell"] = atac_seacells_asgn.loc[rna_cells.obs_names, "SEACell"]
obs = rna_cells.obs

# Summarize RNA data into SEACells
rna_seacells = SEACells.core.summarize_by_SEACell(rna_cells, SEACells_label = 'SEACell', summarize_layer = 'counts')
print(f"RNA SEACells data: {rna_seacells.shape[0]} SEACells and {rna_seacells.shape[1]} genes")

# Normalize and log-transform the summarized data for downstream analysis
sc.pp.normalize_total(rna_seacells)
sc.pp.log1p(rna_seacells)

# Save summarized data
rna_seacells.write("../RNA/out_from_ATAC/SEACell_summarized_RNA.h5ad")

# Log off
print("RNA SEACells summarization complete and saved.")