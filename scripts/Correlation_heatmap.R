library(data.table)
library(ComplexHeatmap)
library(circlize)

# Load correlation matrix and annotations
corr_df <- fread("ATAC/ATAC_SEACell_correlation_matrix.tsv", header=TRUE, data.table=FALSE)
annot_df <- fread("ATAC/ATAC_SEACell_annot.tsv", header=TRUE, data.table=FALSE)
colors <- fread("RNA/RNA_cell_type_colors.tsv", header=TRUE, data.table=FALSE)

# Set row names and remove the first column
rownames(corr_df) <- corr_df[, 1]
corr_df <- corr_df[, -1]
rownames(annot_df) <- annot_df[, 1]
annot_df <- annot_df[, -1]

# Order annot_df by the same order as corr_df
annot_df <- annot_df[match(rownames(corr_df), rownames(annot_df)), ]

# Define colors for cell types
cell_types <- colors$cell_type
cell_type_colors <- setNames(colors$color, cell_types)

# Heatmap color
col_fun <- colorRamp2(
  breaks = c(-1, -0.5, 0, 0.5, 1),
  colors = c("#053061", "#4393C3", "#F7F7F7", "#D6604D", "#67001F")
)

# Plot heatmap with cell type annotations
# Don't cluster rows/columns since we will order them by the dendrograms computed in Python
hm <- ComplexHeatmap::Heatmap(
    as.matrix(corr_df), 
    name="Correlation", 
    col=col_fun, 
    show_row_names=FALSE, 
    show_column_names=FALSE, 
    cluster_rows=FALSE, 
    cluster_columns=FALSE,
    #row_split=annot_df$zebrafish_anatomy_ontology_class,
    #column_split=annot_df$zebrafish_anatomy_ontology_class,
    row_title_rot=0,
    column_title_rot=90,
    row_title_gp=gpar(fontsize=10),
    column_title_gp=gpar(fontsize=10),
    row_gap=unit(1, "mm"),
    column_gap=unit(1, "mm"),
    left_annotation = rowAnnotation(
        cell_type = annot_df$zebrafish_anatomy_ontology_class,
        col = list(cell_type = cell_type_colors),
        show_legend = FALSE
    ),
    top_annotation = HeatmapAnnotation(
        cell_type = annot_df$zebrafish_anatomy_ontology_class,
        col = list(cell_type = cell_type_colors)
    ),
    use_raster=TRUE
)

# Save heatmap as PDF
pdf("ATAC/ATAC_SEACell_correlation_heatmap.pdf", width=14, height=10)
draw(hm)
dev.off()