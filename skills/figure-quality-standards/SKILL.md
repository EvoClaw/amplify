---
name: figure-quality-standards
description: Use whenever generating figures or tables for a research paper — enforces publication-quality visual standards including style consistency, readability, accessibility, and venue-appropriate formatting
---

# Figure & Table Quality Standards

## Overview

Figures are the first thing reviewers look at. A sloppy figure signals sloppy science. This skill defines mandatory quality standards for every figure and table produced during Phase 4 (experiment execution) and Phase 5 (results integration), and enforced again during Phase 6 (paper writing).

**Invoke this skill** before generating any figure intended for a paper.

## Universal Figure Standards

### Resolution and Format

| Property | Requirement |
|----------|------------|
| Format | Vector (PDF or SVG) for plots; PNG at ≥300 DPI only for raster images (photos, heatmaps) |
| Minimum DPI | 300 for raster, vector preferred for all line/bar/scatter plots |
| File format for LaTeX | PDF (first choice) or EPS; avoid PNG/JPG for plots |
| Size | Match column width of target venue (typically 3.25" single column, 6.875" double column for IEEE/ACM) |

### Typography

| Property | Requirement |
|----------|------------|
| Font family | **Match venue profile** (see Venue-Specific Styles below) — sans-serif for CNS, serif for CS/IEEE |
| Axis label size | ≥ 8pt after scaling to final print size |
| Tick label size | ≥ 7pt after scaling |
| Legend text size | ≥ 7pt after scaling |
| Figure title | **OMIT** — do NOT put a title on the figure. The LaTeX `\caption{}` serves as the title. |
| Panel labels | Bold lowercase for CNS-style (**a**, **b**, **c**); uppercase for CS/IEEE (**A**, **B**, **C**) — see venue profile |

**Test:** After generating a figure, mentally scale it to its final column width. If any text becomes unreadable at that size, increase the font.

### Color

| Property | Requirement |
|----------|------------|
| Color palette | **Match venue profile** — Nature palette for CNS, Tableau 10 for CS, see below |
| Consistency | ALL figures in the same paper must use the SAME color → method mapping |
| Grayscale fallback | Figures must be distinguishable in grayscale (some venues print in B&W). Use markers/hatching in addition to color |
| Maximum colors | ≤ 8 distinct colors per figure; beyond that, use subplots |

### Layout and Readability

| Property | Requirement |
|----------|------------|
| Axis labels | Present on every axis; include units (e.g., "Accuracy (%)", "Time (s)") |
| Grid lines | Depends on venue profile: subtle for CS, often absent for CNS |
| Legend placement | Inside the plot area if space allows, otherwise outside. Never overlap data points. |
| White space | Tight layout (`bbox_inches='tight'` in matplotlib); no excessive margins |
| Aspect ratio | Standard ratios (4:3, 16:9, 1:1). Never stretched or squished. |
| Subplot spacing | Consistent spacing; shared axes where appropriate to save space |

### What Goes ON the Figure vs. IN LaTeX

<IMPORTANT>
Figures and captions are SEPARATE things. The figure is an image file (PDF/SVG). The caption is LaTeX text in `\caption{}`. Do NOT confuse them.
</IMPORTANT>

**ON the figure (in the image file itself):**
- Axis labels with units
- Tick labels
- Legend (if multiple series)
- Panel labels (**a**, **b**, **c** — positioned top-left of each subplot)
- Annotations (arrows, text callouts if needed)
- NO figure title (the caption replaces it)
- NO caption text

**IN LaTeX `\caption{}`:**
- What the figure shows (one sentence)
- Key takeaway / main observation
- Per-panel descriptions for multi-panel figures: "(**a**) Method comparison on Dataset X. (**b**) Ablation study..."
- Define abbreviations not defined in main text
- Statistical details if relevant ("Error bars indicate ± 1 std over 5 seeds")
- Must be **self-contained**: reader should understand the figure from caption alone

**LaTeX pattern:**
```latex
\begin{figure}[t]
\centering
\includegraphics[width=\columnwidth]{figures/main_comparison.pdf}
\caption{Comparison of methods on three benchmarks.
(\textbf{a}) Accuracy on Dataset X. Our method (blue) outperforms all baselines.
(\textbf{b}) Training efficiency. Our method converges 2$\times$ faster.
Error bars indicate $\pm$ 1 std over 5 random seeds.}
\label{fig:main}
\end{figure}
```

---

## Venue-Specific Figure Styles

Read `target_venue` from `research-anchor.yaml` and select the matching profile. If unsure which profile to use, ask the user.

### Profile: CNS (Nature, Science, Cell and their sub-journals)

Nature/Science/Cell have a distinctive, recognizable figure aesthetic. Matching it signals professionalism.

| Property | CNS Standard |
|----------|-------------|
| Font | **Helvetica / Arial** (sans-serif). Nature explicitly requires this. |
| Font size | 5–7pt for figure text (Nature allows small text because figures are high-resolution) |
| Panel labels | Bold lowercase: **a**, **b**, **c**, **d** — top-left of each panel, outside plot area |
| Color palette | Nature palette: `['#E64B35', '#4DBBD5', '#00A087', '#3C5488', '#F39B7F', '#8491B4', '#91D1C2', '#DC0000', '#7E6148', '#B09C85']` |
| Background | White. No gray background. |
| Grid lines | **None** or extremely subtle. CNS figures are clean and minimal. |
| Spines | Usually left + bottom only. No top/right spines. |
| Line width | 0.5–1pt for data lines, 0.25–0.5pt for axes |
| Multi-panel | Very common. 4–8 panels per figure. Use `plt.subplot_mosaic()` for complex layouts. |
| Figure width | Single column: 89mm. Double column: 183mm. Full page: 183mm × 247mm. |
| Annotations | Clean arrows, minimal text. Let the data speak. |
| Bar plots | Thin bars, often with individual data points overlaid (strip/swarm plot on top of bars) |
| Statistical markers | Brackets with asterisks: \*, \*\*, \*\*\*, ns |

```python
CNS_STYLE = {
    'font.family': 'sans-serif',
    'font.sans-serif': ['Helvetica', 'Arial', 'DejaVu Sans'],
    'font.size': 7,
    'axes.titlesize': 8,
    'axes.labelsize': 7,
    'xtick.labelsize': 6,
    'ytick.labelsize': 6,
    'legend.fontsize': 6,
    'axes.linewidth': 0.5,
    'xtick.major.width': 0.5,
    'ytick.major.width': 0.5,
    'lines.linewidth': 1.0,
    'lines.markersize': 4,
    'axes.spines.top': False,
    'axes.spines.right': False,
    'axes.grid': False,
    'figure.dpi': 300,
    'savefig.dpi': 300,
    'savefig.bbox': 'tight',
}

NATURE_COLORS = ['#E64B35', '#4DBBD5', '#00A087', '#3C5488',
                 '#F39B7F', '#8491B4', '#91D1C2', '#DC0000',
                 '#7E6148', '#B09C85']
```

### Profile: CS Conferences (NeurIPS, ICML, ICLR, CVPR, AAAI, ACL, EMNLP)

CS conferences prioritize clarity and information density over aesthetics.

| Property | CS Conference Standard |
|----------|----------------------|
| Font | **Serif** (Times, Computer Modern) to match paper body, OR sans-serif if consistent |
| Font size | 8–10pt (larger than CNS because columns are wider) |
| Panel labels | Uppercase or "(a) (b) (c)" in caption text; less common as on-figure labels |
| Color palette | Tableau 10, ColorBrewer, or custom — must be colorblind-safe |
| Background | White |
| Grid lines | Light gray dashed — acceptable and often helpful for reading values |
| Spines | Left + bottom preferred; all four acceptable |
| Line width | 1.5–2pt for data lines (thick enough to see in projected slides too) |
| Multi-panel | 2–4 panels typical. Subfigures common. |
| Figure width | Single column: ~3.25". Double column: ~6.875" (LaTeX `\textwidth`). |
| Error bands | Shaded regions (alpha=0.2) with mean line. Very standard for learning curves. |
| Tables > figures | CS values tables highly; main results are often a table, not a figure |

```python
CS_STYLE = {
    'font.family': 'serif',
    'font.serif': ['Times New Roman', 'DejaVu Serif', 'Computer Modern Roman'],
    'font.size': 10,
    'axes.titlesize': 11,
    'axes.labelsize': 10,
    'xtick.labelsize': 9,
    'ytick.labelsize': 9,
    'legend.fontsize': 9,
    'axes.linewidth': 0.8,
    'lines.linewidth': 1.5,
    'lines.markersize': 6,
    'axes.spines.top': False,
    'axes.spines.right': False,
    'axes.grid': True,
    'grid.alpha': 0.3,
    'grid.linestyle': '--',
    'figure.dpi': 300,
    'savefig.dpi': 300,
    'savefig.bbox': 'tight',
}

CS_COLORS = ['#4e79a7', '#f28e2b', '#e15759', '#76b7b2',
             '#59a14f', '#edc948', '#b07aa1', '#ff9da7',
             '#9c755f', '#bab0ac']  # Tableau 10
```

### Profile: IEEE (Transactions, Conference Proceedings)

IEEE has strict formatting requirements documented in their author guidelines.

| Property | IEEE Standard |
|----------|-------------|
| Font | **Times New Roman** (mandatory) |
| Font size | 8–10pt in figures |
| Column width | Single: 3.5". Double: 7.16". |
| Color | Allowed but paper may be printed B&W — MUST be readable in grayscale |
| Captions | "Fig. 1." format (not "Figure 1") |
| Line markers | Essential — distinguish lines by marker shape, not just color |
| Grid lines | Optional, light |

```python
IEEE_STYLE = {
    'font.family': 'serif',
    'font.serif': ['Times New Roman'],
    'font.size': 9,
    'axes.titlesize': 10,
    'axes.labelsize': 9,
    'xtick.labelsize': 8,
    'ytick.labelsize': 8,
    'legend.fontsize': 8,
    'axes.linewidth': 0.6,
    'lines.linewidth': 1.2,
    'lines.markersize': 5,
    'axes.spines.top': False,
    'axes.spines.right': False,
    'axes.grid': True,
    'grid.alpha': 0.2,
    'grid.linestyle': ':',
    'figure.dpi': 300,
    'savefig.dpi': 300,
    'savefig.bbox': 'tight',
}
```

### Profile: Bioinformatics / Life Sciences (Genome Research, Bioinformatics, PNAS, eLife)

Life science journals generally follow CNS aesthetics with domain-specific plot types.

| Property | Life Science Standard |
|----------|---------------------|
| Font | **Helvetica / Arial** (following Nature/CNS tradition) |
| Style | Very close to CNS profile above |
| Domain-specific plots | Volcano plots, MA plots, heatmaps with dendrograms, Kaplan-Meier survival curves, Manhattan plots, circos plots |
| Heatmap conventions | Row/column clustering dendrograms, diverging colormap (red-white-blue for expression), annotated color bars |
| Statistical notation | Brackets with \*/\*\*/\*\*\*/ns between groups, Bonferroni-corrected p-values |
| Bar plots | Individual data points overlaid (strip/swarm), NOT just bars with error bars |

Use `CNS_STYLE` and `NATURE_COLORS` from the CNS profile.

### Profile: Physical Sciences (APS/Physical Review, ACS, RSC)

| Property | Physical Sciences Standard |
|----------|--------------------------|
| Font | **Computer Modern or Helvetica** depending on journal |
| Figure width | APS single column: 3.375". Double: 6.75". |
| Conventions | SI units on all axes, scientific notation for large/small numbers, insets common for zoomed regions |
| Color | Conservative — fewer colors, more line style variation |

Use `CS_STYLE` as base, adjust font to Computer Modern.

### How to Select a Profile

At project start (Phase 0/1), when `target_venue` is set in `research-anchor.yaml`:

1. Read the venue name
2. Map to profile:
   - Nature, Science, Cell, Nature *, Science *, Cell *, PNAS, eLife → **CNS profile**
   - NeurIPS, ICML, ICLR, CVPR, ECCV, AAAI, ACL, EMNLP, KDD, WWW → **CS profile**
   - IEEE *, any IEEE transaction or conference → **IEEE profile**
   - Bioinformatics, Genome Research, Nucleic Acids Research → **Life Science profile**
   - Physical Review *, ACS *, RSC *, J. Chem. Phys. → **Physical Sciences profile**
3. If venue is unclear or not listed, ask user: *"Which figure style matches your target venue? (1) CNS/Nature style (2) CS conference style (3) IEEE style (4) Other — please describe"*
4. Write the selected profile to `src/plot_style.py` and use it for ALL figures

## Figure Type Selection Guide

| Data type | Recommended figure | Avoid |
|-----------|-------------------|-------|
| Method A vs B vs C on multiple datasets | Grouped bar chart or table | Pie chart |
| Performance vs hyperparameter | Line plot with error bands | Scatter without connection |
| Ablation (component contribution) | Grouped bar chart or stacked bar | Line plot (components aren't ordered) |
| Training dynamics | Line plot (x: epoch, y: metric) with shaded std | Bar chart |
| Feature importance / attention | Heatmap with annotated values | 3D plots |
| Distribution comparison | Violin plot or box plot | Overlapping histograms |
| Embedding visualization | t-SNE/UMAP scatter with class colors | PCA (usually uninformative for high-dim) |
| Qualitative examples | Grid of input→output pairs | Random cherry-picked singles |
| Architecture diagram | Clean schematic (tikz, draw.io, or programmatic) | Hand-drawn or overly complex |
| Confusion matrix | Annotated heatmap with numbers in cells | Plain matrix without annotations |

## Style Template

At project start, create `src/plot_style.py` based on the selected venue profile. This file is imported by every plotting script.

```python
import matplotlib.pyplot as plt
import matplotlib as mpl

# ──────────────────────────────────────────────
# SELECT ONE profile based on target venue.
# See Venue-Specific Figure Styles section above.
# Copy the matching STYLE dict and COLORS list here.
# ──────────────────────────────────────────────

# Example: CS conference profile (NeurIPS, ICML, etc.)
STYLE_CONFIG = CS_STYLE   # Replace with CNS_STYLE, IEEE_STYLE, etc.
COLORS = CS_COLORS         # Replace with NATURE_COLORS, etc.

mpl.rcParams.update(STYLE_CONFIG)
```

Save as `src/plot_style.py` and import in every plotting script. This ensures ALL figures have consistent, venue-appropriate style.

### Method-Color Mapping

At the start of the project, define a global color mapping and use it everywhere:

```python
METHOD_COLORS = {
    'Ours': COLORS[0],       # Always blue
    'Baseline A': COLORS[1], # Always orange
    'Baseline B': COLORS[2], # Always red
    'Baseline C': COLORS[3], # Always teal
    'Ablation': COLORS[4],   # Always green
}
```

Store this mapping in `src/plot_style.py` and update it as methods are added. Never assign colors ad-hoc per figure.

## Table Standards

| Property | Requirement |
|----------|------------|
| Format | `booktabs` style in LaTeX (`\toprule`, `\midrule`, `\bottomrule`); no vertical lines |
| Best result | **Bold** the best value in each column/metric |
| Second best | Underline the second best (if comparing ≥4 methods) |
| Uncertainty | Always report mean ± std (or CI); bare numbers without variance are unacceptable |
| Alignment | Decimal-aligned numbers; consistent decimal places per column |
| Significance | Mark statistically significant improvements (e.g., † or * with p-value in caption) |
| Our method highlight | Use light gray row shading or clear label; never bury it in the middle |

### LaTeX Table Template

```latex
\begin{table}[t]
\centering
\caption{Main results on [datasets]. Best in \textbf{bold}, second best \underline{underlined}.
$\dagger$: statistically significant improvement over best baseline ($p < 0.05$, paired t-test).}
\label{tab:main}
\begin{tabular}{@{}lccc@{}}
\toprule
Method & Dataset A & Dataset B & Dataset C \\
\midrule
Baseline 1 & $83.2 \pm 0.4$ & $76.1 \pm 0.8$ & $91.3 \pm 0.2$ \\
Baseline 2 & $\underline{85.1 \pm 0.3}$ & $77.4 \pm 0.6$ & $\underline{92.0 \pm 0.3}$ \\
Baseline 3 & $84.7 \pm 0.5$ & $\underline{78.2 \pm 0.5}$ & $91.8 \pm 0.4$ \\
\midrule
Ours & $\mathbf{87.3 \pm 0.2}^\dagger$ & $\mathbf{80.1 \pm 0.4}^\dagger$ & $\mathbf{93.5 \pm 0.2}^\dagger$ \\
\bottomrule
\end{tabular}
\end{table}
```

## Per-Figure Quality Checklist

Before including ANY figure in the paper, verify every item.

### Figure file (the image itself):

- [ ] **Venue profile applied** — using the correct style from `src/plot_style.py`?
- [ ] **Readable at print size** — scale to final column width; all text ≥ 7pt (CNS: ≥ 5pt)?
- [ ] **Axis labels present** — with units (e.g., "Accuracy (%)", "Time (s)")?
- [ ] **No figure title** — title belongs in LaTeX `\caption{}`, not on the figure
- [ ] **Legend present** — if multiple series; not overlapping data?
- [ ] **Panel labels** — if multi-panel: bold **a**, **b**, **c** (CNS) or **(A)**, **(B)**, **(C)** (CS/IEEE) top-left?
- [ ] **Color consistent** — same method = same color as all other figures?
- [ ] **Colorblind safe** — distinguishable without color (markers, line styles, hatching)?
- [ ] **Error bars / variance** — shown where applicable (shaded region or error bars)?
- [ ] **Vector format** — PDF/SVG for plots (not PNG/JPG)?
- [ ] **No chartjunk** — no 3D effects, no excessive decoration, no rainbow gradients?
- [ ] **White space optimized** — tight layout, no giant margins?

### LaTeX side (in the `.tex` file):

- [ ] **`\caption{}` self-contained** — reader understands figure from caption alone, without reading body text?
- [ ] **`\caption{}` describes each panel** — for multi-panel: "(**a**) ... (**b**) ..."?
- [ ] **`\caption{}` states key takeaway** — not just "Results on Dataset X" but what the results show?
- [ ] **`\caption{}` notes statistical details** — "Error bars: ± 1 std over 5 seeds" or similar?
- [ ] **`\label{fig:xxx}`** present and descriptive?
- [ ] **`\includegraphics` width** — matches venue column width (`\columnwidth` or `\textwidth`)?
- [ ] **Referenced in text** — every figure is `\ref{}`'d in the body text; no orphaned figures?

## Anti-Patterns — NEVER Do These

| Anti-pattern | Why it's bad | What to do instead |
|-------------|-------------|-------------------|
| Default matplotlib style (white bg, thin lines, small fonts) | Unreadable at print size | Apply the style template above |
| Rainbow colormap for categorical data | Perceptually nonlinear, colorblind-hostile | Use qualitative palette (Tableau 10, ColorBrewer) |
| 3D bar charts or pie charts | Distort proportions, waste ink | 2D grouped bar chart |
| Inconsistent colors across figures | Reader can't track methods | Global method-color mapping |
| Screenshots of terminal output | Unreadable, unprofessional | Proper table or formatted code block |
| Figures without error bars | Results look unreliable | Always show variance (std, CI, min-max) |
| Tiny axis labels that need zooming | Will be illegible in print | ≥ 8pt at final size |
| Cherry-picked qualitative examples | Misleading | Show representative range (good + average + failure) |

## Integration with Workflow

This skill should be invoked:

1. **Phase 4 (experiment-execution)**: When generating any experimental figure — apply style template, use method-color mapping
2. **Phase 5 (results-integration)**: When producing the content outline — verify all planned figures meet standards; run the per-figure checklist
3. **Phase 6 (paper-writing)**: Before including each figure in a `.tex` file — final quality check; verify LaTeX `\includegraphics` path and caption

## Rationalization Prevention

| Excuse | Reality |
|--------|---------|
| "I'll fix the figures later" | You won't. Style issues compound. Apply the template from the first plot. |
| "Default matplotlib looks fine" | On screen at 100%, maybe. At conference poster or PDF zoom, it's unreadable. |
| "Color doesn't matter" | 8% of men are colorblind. Reviewers print in B&W. Color always matters. |
| "Error bars clutter the plot" | Error bars ARE the data. Without them, your plot is a lie. |
| "One quick plot is fine for now" | Quick plots become final figures 90% of the time. Do it right the first time. |
