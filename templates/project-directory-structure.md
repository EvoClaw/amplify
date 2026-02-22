# Standard Research Project Directory Structure

Use this structure for all research projects managed by Amplify.

```
project_root/
├── docs/
│   ├── 01_intake/
│   │   └── research-anchor.yaml          # Global anchor (from template)
│   ├── 02_literature/
│   │   ├── paper-list.md                  # Full candidate list with URLs and access status
│   │   ├── papers/                        # Downloaded or user-provided PDFs
│   │   ├── literature-review.md           # Literature survey (deep reading table)
│   │   ├── gap-analysis.md                # Gap analysis
│   │   ├── baseline-collection.md         # Baseline collection [Type M/H]
│   │   └── problem-validation.md          # Problem validation record
│   ├── 03_plan/
│   │   ├── method-design.md               # Method design [Type M/H]
│   │   ├── analysis-storyboard.md         # Analysis storyboard [Type D/H]
│   │   ├── evaluation-protocol.yaml       # Evaluation contract [Type M/H]
│   │   └── ablation-design.md             # Ablation plan [Type M/H]
│   ├── 04_data_resource/
│   │   ├── data-inventory.md              # Data inventory
│   │   ├── data-quality-report.md         # Quality report
│   │   ├── download_data.sh               # Data acquisition script
│   │   └── leakage-audit.md               # Leakage audit [ML]
│   ├── 05_execution/
│   │   ├── experiment-log.md              # Experiment journal (ongoing)
│   │   ├── baseline-results.md            # Baseline results
│   │   ├── iteration-history.md           # Iteration records
│   │   └── negative-results.md            # Failed experiments
│   └── 06_report/
│       └── research-report.md             # Paper-level report
├── paper/
│   ├── main.tex
│   ├── preamble.tex
│   ├── sections/
│   │   ├── abstract.tex
│   │   ├── introduction.tex
│   │   ├── related-work.tex
│   │   ├── method.tex
│   │   ├── experiments.tex
│   │   ├── results.tex
│   │   ├── discussion.tex
│   │   └── conclusion.tex
│   ├── figures/
│   ├── tables/
│   ├── references.bib
│   └── supplementary/
├── repro/
│   ├── README.md
│   ├── environment.yml
│   ├── download_data.sh
│   ├── run_all.sh
│   ├── configs/
│   ├── scripts/
│   └── expected_results/
├── src/                                   # Source code
├── data/
│   ├── raw/                               # Immutable raw data
│   ├── processed/                         # Preprocessed data
│   └── splits/                            # Train/val/test splits
└── experiments/
    ├── configs/
    └── results/
```
