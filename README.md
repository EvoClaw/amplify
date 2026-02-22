# Amplify

**Turn your AI coding assistant into a research collaborator that produces publication-ready papers.**

Amplify is an agentic research automation framework. Give it a research topic, and it orchestrates the entire scientific workflow — literature review, method design, experiment execution, results analysis, and paper writing — while enforcing the discipline that separates rigorous research from quick demos.

Unlike systems that train specialized models or build standalone pipelines, Amplify works *inside* the tools you already use (Cursor, Claude Code, etc.) through a skills-based architecture. You stay in control of every scientific decision; the AI handles the execution.

---

## Why Amplify?

Without Amplify, asking an AI to "write a paper on X" typically produces:

- A model trained for 1 epoch, reported as a final result
- Cherry-picked metrics on a single seed
- A 3-page paper with fabricated references
- No baselines, no ablations, no statistical tests

**With Amplify**, the same request triggers a structured 7-phase workflow where the AI *cannot* skip baselines, *cannot* change metrics after seeing results, and *cannot* write a paper until experiments are independently verified. The result is work that could survive peer review.

### What changes concretely

| Without Amplify | With Amplify |
|----------------|-------------|
| AI jumps straight to code | Literature review and gap analysis first |
| Metrics chosen after seeing results | Metrics locked before any experiment runs |
| Single seed, best-case reported | 5 seeds, all results reported (including failures) |
| No baselines or weak baselines | Baseline-first execution; skipping is forbidden |
| Paper written in one shot | Multi-agent review panel (proofreader, domain critic, adversarial reviewer) |
| Figures as afterthoughts | Publication-quality figures enforced (CNS, IEEE, CS conference styles) |
| References unverified | Every citation checked; unverifiable references flagged |
| One-pass, no iteration | Mandatory iteration loop with minimum performance bar |
| Entire process is a black box | 15+ human decision points; 4 mandatory gates |

## How It Works

Amplify defines **23 skills** organized in three layers, enforced through **4 mandatory gates** that require your explicit approval:

```
┌──────────────────────────────────────────────┐
│        Meta-Control Layer (4 skills)         │
│  Scope guard, novelty check, venue fit,      │
│  pivot-or-kill after repeated failures       │
├──────────────────────────────────────────────┤
│        Discipline Layer (7 skills)           │
│  Metric lock, anti-cherry-pick,              │
│  claim-evidence alignment, figure quality,   │
│  alternative hypothesis, reproducibility,    │
│  results verification                        │
├──────────────────────────────────────────────┤
│        Workflow Layer (12 skills)            │
│  Phase 0 → 1 → 2 → 3 → 4 → 5 → 6          │
│  + git-worktrees, parallel-agents, bootstrap │
└──────────────────────────────────────────────┘
```

- **Workflow Layer** — "What do I do next?"
- **Discipline Layer** — "What rules must I follow?" (active once triggered, until project end)
- **Meta-Control Layer** — "Is this still on track?" (fires on scope creep, repeated failures, etc.)

### The 7 Phases

| Phase | What the AI does | What you decide |
|-------|-----------------|-----------------|
| **0 — Domain Anchoring** | Identifies your field, anchors expert persona | Confirm domain, research type (M/D/C/H), resources |
| **1 — Direction Exploration** | Reviews literature, analyzes gaps, proposes 3 directions | Choose direction, confirm data readiness |
| **2 — Problem Validation** | Simulates a thesis defense — adversarial questioning | Answer challenges, confirm research intent |
| **3 — Method Design** | Designs method/analysis, locks evaluation protocol | Approve metrics, baselines, and frozen plan |
| **4 — Experiment Execution** | Runs baselines first, then your method, iterates ≥3 rounds | Review progress, decide when results suffice |
| **5 — Results Integration** | Multi-agent discussion (story architect, devil's advocate, audience specialist) | Review report, request additions |
| **6 — Paper Writing** | Modular LaTeX, multi-agent review panel, reference verification | Review each section, approve final paper |

**Gates G1–G4** sit between phases. No gate can be skipped. Each requires a checklist to be fully satisfied *and* your explicit approval.

### Research Types

The system adapts to your research:

| Type | Focus | Example |
|------|-------|---------|
| **M** — Method | New algorithm/model | "A new few-shot learning method" |
| **D** — Discovery | Data-driven insights | "Analyze gene expression patterns in cancer" |
| **C** — Tool | Software/pipeline | "Build a molecular docking pipeline" |
| **H** — Hybrid | Method + application | "New integration method for disease subtypes" |

## Key Capabilities

### Scientific Discipline Enforcement

- **Metric Lock** — Evaluation metrics are frozen after G2. Any change requires your explicit authorization.
- **Anti-Cherry-Pick** — All seeds reported, negative results recorded, baseline comparisons enforced.
- **Claim-Evidence Alignment** — Every claim in the paper must map to specific experimental evidence.
- **Run-to-Completion** — No 1-epoch smoke tests reported as final results. The AI must demonstrate execution completion (convergence, stability, or method-appropriate termination).

### Autonomous Literature Review

The AI attempts to find and download papers on its own first. When access fails (paywalls, institutional barriers), it reports exactly which papers it couldn't get and asks you to help — then automatically resumes once you provide them.

### Multi-Agent Review Panels

At critical stages, Amplify dispatches specialized subagents for independent review:

- **Phase 5** — Story Architect, Devil's Advocate, and Audience Specialist debate results interpretation
- **Phase 6** — Proofreader, Domain Critic, and Adversarial Reviewer critique the paper draft
- Reviews can trigger a **return to Phase 4** if experiment gaps are identified

### Publication-Quality Figures

Venue-specific figure styles are enforced automatically:

| Profile | Targets |
|---------|---------|
| CNS | Nature, Science, Cell family journals |
| CS Conference | NeurIPS, ICML, CVPR, ACL |
| IEEE | IEEE Transactions family |
| Life Science | Bioinformatics, PLOS, BMC |
| Physical Sciences | Physical Review, JACS |

All figures: ≥300 DPI, vector format (PDF/SVG), colorblind-safe palettes, readable at print size.

### Pre-computed Baseline Support

If you already have baseline results from previous work, you can provide them during Phase 1 or Phase 3. The system validates compatibility and skips redundant re-runs.

## Prerequisites

- **Cursor IDE** (primary platform; also works with Claude Code, OpenClaw, etc.)
- **Git** (for worktree-based experiment isolation)
- **LaTeX distribution** (TeX Live or MiKTeX for paper compilation)
- **Python 3** with `pyyaml`

## Installation

### Method 1: Manual Installation (recommended)

**Step 1 — Copy or symlink the plugin:**

```bash
mkdir -p ~/.cursor/skills
# Copy:
cp -r /path/to/amplify ~/.cursor/skills/amplify
# Or symlink (if you keep the repo in a fixed location):
ln -s /absolute/path/to/amplify ~/.cursor/skills/amplify
```

**Step 2 — Install the bootstrap rule:**

```bash
# User-level (all projects):
mkdir -p ~/.cursor/rules
cp ~/.cursor/skills/amplify/install/amplify-bootstrap.mdc ~/.cursor/rules/

# OR project-level (one project only):
mkdir -p /path/to/your-project/.cursor/rules
cp ~/.cursor/skills/amplify/install/amplify-bootstrap.mdc /path/to/your-project/.cursor/rules/
```

**Step 3 — Restart Cursor** and start a new chat session.

### Method 2: Cursor Marketplace

If published on the Cursor Marketplace:

```
/add-plugin amplify
```

### Method 3: From GitHub

```
/add-plugin EvoClaw/amplify
```

Note: Requires the repo to be registered with the Cursor Marketplace.

### Verification

Start a new chat and type:

```
I want to start a research project on few-shot learning.
```

If active, the agent will invoke `domain-anchoring` and begin the structured workflow — not jump to code.

## Quick Start

```
/new-research
```

or describe your intent directly:

```
I want to develop a new method for multi-modal data integration
and apply it to disease subtype discovery.
```

### Other Commands

| Command | When to use |
|---------|------------|
| `/design-experiment` | Jump to design (if Phase 0–1 done) |
| `/run-experiment` | Jump to execution (if plan frozen) |
| `/write-paper` | Jump to paper writing (if results ready) |

## Project Structure

When you start a research project, the system creates:

```
your_project/
├── docs/
│   ├── 01_intake/
│   │   └── research-anchor.yaml       ← project identity
│   ├── 02_literature/
│   │   ├── literature-review.md
│   │   ├── gap-analysis.md
│   │   └── baseline-collection.md     [Type M/H]
│   ├── 03_plan/
│   │   ├── method-design.md           [Type M/H]
│   │   ├── analysis-storyboard.md     [Type D/H]
│   │   ├── evaluation-protocol.yaml   ← LOCKED after G2
│   │   └── ablation-design.md         [Type M/H]
│   ├── 04_data_resource/
│   │   └── data-quality-report.md
│   ├── 05_execution/
│   │   ├── experiment-log.md
│   │   ├── baseline-results.md
│   │   └── negative-results.md        ← failures recorded
│   └── 06_report/
│       └── research-report.md
├── paper/                              ← modular LaTeX
│   ├── main.tex
│   ├── sections/
│   ├── figures/
│   └── references.bib
├── repro/                              ← reproducibility package
│   ├── run_all.sh
│   ├── environment.yml
│   └── expected_results/
├── src/                                ← your code
├── data/
│   ├── raw/                            ← immutable
│   └── processed/
└── experiments/
    ├── configs/
    └── results/
```

## What You Control

Amplify never makes governance decisions for you. **You** decide:

- Research direction (from options the system proposes)
- Research type classification
- Target venue
- Evaluation metrics and baselines
- When results are "good enough"
- Whether to pivot, downgrade, or kill after failures
- When to start paper writing
- Final paper approval

The system proposes, analyzes, and enforces. You decide.

## Skills Reference

<details>
<summary><strong>Workflow Skills (12)</strong></summary>

| Skill | Phase | Purpose |
|-------|-------|---------|
| `using-amplify` | Bootstrap | Skill invocation rules and workflow priority |
| `domain-anchoring` | 0 | Domain, research type, expert persona, feasibility |
| `research-direction-exploration` | 1 | Direction discovery, literature review, G1 gate |
| `problem-validation` | 2 | Adversarial questioning, intent classification |
| `method-framework-design` | 3 | Type-branching design, G2 gate |
| `evaluation-protocol-design` | 3 | Metric locking for Type M/H |
| `analysis-storyboard-design` | 3 | Story line design for Type D/H |
| `experiment-execution` | 4 | Baseline-first execution, iteration, G3 gate |
| `results-integration` | 5 | Result compilation, claim-evidence check, G4 gate |
| `paper-writing` | 6 | Modular LaTeX, reference verification |
| `using-git-worktrees` | Any | Isolated workspaces for experiment branches |
| `dispatching-parallel-agents` | Any | Run independent experiments in parallel |

</details>

<details>
<summary><strong>Discipline Skills (7)</strong></summary>

| Skill | Active from | Enforces |
|-------|------------|----------|
| `metric-lock` | G2 → end | Metrics immutable without user permission |
| `anti-cherry-pick` | Phase 4 → end | All seeds reported, failures recorded |
| `claim-evidence-alignment` | Phase 5–6 | Every claim maps to evidence |
| `figure-quality-standards` | Phase 4–6 | Publication-quality, venue-specific figures |
| `alternative-hypothesis-check` | Phase 4–5 | Confounders excluded [Type D/H] |
| `reproducibility-driven-research` | Phase 4 → end | Seeds, environment, scripted pipelines |
| `results-verification-protocol` | Always | Fresh evidence before status claims |

</details>

<details>
<summary><strong>Meta-Control Skills (4)</strong></summary>

| Skill | Triggered by | Action |
|-------|-------------|--------|
| `novelty-classifier` | Phase 1, 3 | Warns if novelty insufficient for venue |
| `scope-control` | Scope expansion | Forces reduction discussion |
| `pivot-or-kill` | 3 consecutive failures | Presents pivot/downgrade/kill options |
| `venue-alignment` | Every gate + Phase 4 | Checks progress vs. venue requirements |

</details>

## Troubleshooting

**Skills not loading:**
1. Verify bootstrap rule: `ls -la ~/.cursor/rules/amplify-bootstrap.mdc`
2. Verify skills directory: `ls ~/.cursor/skills/amplify/skills/`
3. Open Cursor Settings → Rules → confirm bootstrap is set to **Always**
4. Restart Cursor, start a fresh chat

**Agent skipping steps:** Say explicitly: *"Read and follow the `domain-anchoring` skill at `~/.cursor/skills/amplify/skills/domain-anchoring/SKILL.md`."*

**Agent modifying locked metrics:** Remind it: *"Metrics are locked. Any change requires my explicit authorization."*

**Updating:** If installed via symlink, `git pull` in the source repo. If copied, re-copy.

## Acknowledgements

Amplify's plugin architecture is adapted from [Superpowers](https://github.com/obra/superpowers) by Jesse Vincent. The scientific research workflow, all 23 skills, discipline enforcement mechanisms, and multi-agent review systems are original work.

## License

[MIT License](LICENSE) — Copyright (c) 2026 Yanlin Zhang
