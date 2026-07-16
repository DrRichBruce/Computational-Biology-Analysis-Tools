# Computational Biology Analysis Tools

**Computational Biology Analysis Tools** is a collection of R-based analytical workflows developed during translational biology research, covering statistical modelling, quantitative pathology, immunoreactivity analysis, tissue remodelling assessment, transcriptomics, and scientific visualisation.

The repository contains practical examples of mixed-effects modelling, multivariate statistical analysis, histological image analysis, immunostaining quantification, RNA-seq workflows, and biological data visualisation.

These workflows were developed to support rigorous, reproducible analysis of complex biological datasets while generating outputs suitable for publication, biological interpretation, and downstream hypothesis generation.

---

## Key Features

### Statistical Modelling

- Linear mixed-effects models (LMER)
- Hierarchical modelling of biological data
- Repeated-measures analysis
- Treatment-response modelling
- Multivariate analysis of variance (MANOVA)
- Confidence interval estimation
- Effect size and model-fit evaluation

### Quantitative Pathology

- Airway remodelling analysis
- Histological tissue quantification
- Collagen deposition assessment
- Extracellular matrix remodelling analysis
- Morphometric measurement workflows
- Image-analysis derived data interpretation

### Immunoreactivity Analysis

- Immunohistochemistry quantification
- Immunofluorescence analysis
- Biomarker intensity measurements
- Technical replicate handling
- Biological replicate modelling
- Hierarchical mixed-effects analysis of image-derived datasets

### Transcriptomics

- RNA-seq workflow examples
- DESeq2 analysis pipelines
- SARTools-based differential expression analysis
- Gene expression visualisation
- Heatmap generation
- Exploratory transcriptomic analysis

### Scientific Visualisation

- Publication-ready plots
- Predicted-response curves
- Treatment comparison plots
- Heatmaps
- Statistical diagnostics
- Exploratory data visualisation

### Reproducible Research

- Structured analytical workflows
- Annotated statistical modelling examples
- Reusable code templates
- Research-oriented analysis pipelines
- Transparent reporting approaches

---

## Repository Contents

### Basic_Heatmap.R

Generates clustered heatmaps from gene expression datasets.

#### Typical Applications

- RNA-seq visualisation
- Differential expression exploration
- Gene clustering
- Sample quality assessment
- Exploratory transcriptomics

#### Key Features

- Log-transformed expression visualisation
- Hierarchical clustering
- Custom colour palettes
- Publication-quality heatmaps

---

### MANOVA.R

Performs multivariate analysis of variance (MANOVA) across multiple biological outcomes simultaneously.

#### Typical Applications

- Histology studies
- Multi-endpoint biological experiments
- Treatment effect assessments
- Tissue-remodelling studies

#### Why Use MANOVA?

Biological systems often generate several related outcome variables. MANOVA allows these outcomes to be analysed together rather than performing multiple independent tests, reducing false-positive findings and improving statistical interpretation.

---

### linear_mixed_model_collagen_analysis.R

A mixed-effects modelling workflow designed to investigate collagen deposition across airway dimensions while accounting for repeated measurements within animals.

#### Typical Applications

- Airway remodelling studies
- Collagen quantification
- Histological image analyses
- Preclinical disease models

#### Why Use Mixed Models?

Biological datasets frequently contain multiple measurements collected from the same animal.

Traditional methods assume observations are independent and can therefore inflate significance.

This workflow:

- Accounts for repeated sampling
- Models biological variation between animals
- Separates treatment effects from anatomical variation
- Generates treatment-specific prediction curves

---

### remodelling_areas_analysis.R

A comprehensive mixed-effects modelling workflow for quantitative tissue remodelling analysis.

#### Typical Applications

- Airway pathology
- Histological remodelling studies
- Extracellular matrix analysis
- Morphometric measurements
- Tissue compartment quantification

#### Analytical Challenges Addressed

Many pathology datasets contain:

- Multiple measurements from the same animal
- Strong airway-size dependence
- Skewed biological measurements
- Large biological variability

To address these issues the workflow:

- Log-transforms outcomes to stabilise variance
- Mean-centres anatomical variables
- Accounts for repeated measurements
- Tests treatment-by-size interactions
- Generates biologically interpretable model predictions

#### Why This Matters

Without accounting for airway size and repeated measures, apparent treatment effects may simply reflect differences in anatomy or sampling structure.

This workflow helps isolate genuine biological effects.

---

### Immunoreactivity_Mixed_Effects_Analysis.R

A hierarchical modelling workflow for quantitative immunostaining and image-analysis datasets.

#### Typical Applications

- Immunohistochemistry
- Immunofluorescence
- Biomarker quantification
- Protein expression studies
- Microscopy-based intensity analysis

#### Analytical Challenges Addressed

Image-analysis datasets often contain:

- Biological replicates
- Technical replicates
- Multiple wells or fields of view
- Non-independent observations

This workflow uses mixed-effects models to separate:

- Biological variation
- Technical variation
- Treatment-associated effects

resulting in more robust statistical inference.

---

### RNAseq_Differential_Expression_Workflow.R

An RNA-seq differential expression workflow based on the SARTools and DESeq2 framework.

#### Typical Applications

- Bulk RNA-seq analysis
- Differential gene expression
- PCA and clustering
- Quality-control analysis
- Transcriptomic profiling

#### Included Functionality

- featureCounts import
- Differential expression analysis
- Sample clustering
- PCA visualisation
- Automated reporting
- Annotated result export

#### Note

This workflow is based on established SARTools and DESeq2 methodologies and was adapted from training materials before being applied to transcriptomic research projects.

The script is included as an example of a practical transcriptomic analysis workflow rather than a novel software implementation.

---

## Technology Stack

- R
- lme4
- lmerTest
- dplyr
- RColorBrewer
- gplots
- DESeq2
- SARTools
- r2glmm

---

## Use Cases

This repository is intended to support:

- Translational biology research
- Computational biology workflows
- Quantitative pathology
- Histological image analysis
- Immunostaining analysis
- Experimental treatment evaluation
- RNA-seq projects
- Differential expression analysis
- Exploratory transcriptomics
- Scientific visualisation

---

## Design Principles

The workflows in this repository are based on several core principles:

- Statistical transparency
- Reproducibility
- Biological interpretability
- Appropriate handling of repeated observations
- Robust modelling of hierarchical datasets
- Clear visualisation of complex biological data

The goal is not to provide a software package, but rather a collection of practical analytical workflows that can be adapted to a wide variety of biological research questions.

---

## Future Development

Planned enhancements include:

- Additional transcriptomic workflows
- Gene set enrichment analysis examples
- Automated model diagnostics
- Expanded visualisation templates
- Publication-ready figure pipelines
- Reproducible reporting workflows
- Machine-learning assisted biological analyses

---

## Author

**Dr Richard Bruce**

Research Project Officer  
Bristol Veterinary School

### Interests

- Translational Biology
- Computational Biology
- Transcriptomics
- AI for Life Sciences
- Data Science
- Scientific Software Development

---

## Project Origins

These workflows were developed during translational biology research during my PhD investigating the effects of negative allosteric modulators of the calcium-sensing receptor on airway remodelling, extracellular matrix deposition, tissue pathology, immunoreactivity, and transcriptomic changes associated with disease processes in vivo and in vitro.

The repository combines statistical and computational approaches used to analyse, model, visualise, and interpret complex biological datasets generated from experimental studies. Some workflows were developed directly during research projects, while others represent adapted applications of established analytical frameworks used in computational biology and bioinformatics.
