# Amplify

A complete research workflow for AI coding agents — from topic selection through experimentation to paper writing, with scientific discipline enforcement at every step.

Built on the plugin architecture of [Superpowers](https://github.com/obra/superpowers) by Jesse Vincent.

## What It Does

Amplify turns your AI coding assistant into a disciplined research collaborator. Instead of jumping straight to code, it enforces a structured workflow:

1. **Identifies your domain** and anchors the correct expert persona (an ML researcher won't review your bioinformatics paper)
2. **Reviews literature** and finds research gaps before proposing directions
3. **Validates the problem** through adversarial questioning — simulating a thesis defense
4. **Designs the method/analysis** and locks evaluation metrics before any code is written
5. **Executes experiments** with baseline-first discipline, multi-seed runs, and anti-cherry-picking
6. **Integrates results** into a coherent report with claim-evidence alignment
7. **Writes the paper** in modular LaTeX with professor-level prose and verified references

The system prevents common AI research pitfalls: changing metrics after seeing results, skipping baselines, reporting only favorable outcomes, and making claims without evidence.

## Prerequisites

- **Cursor IDE** (primary supported platform)
- **Git** (for worktree-based experiment isolation)
- **LaTeX distribution** (for paper compilation — TeX Live or MiKTeX recommended)
- **Python 3** with `pyyaml` (for YAML template handling)

## Installation

### Method 1: Manual Installation (recommended for local use)

This is the most reliable method for a plugin not published on the Cursor Marketplace.

**Step 1 — Copy the plugin to the Cursor skills directory:**

```bash
mkdir -p ~/.cursor/skills
cp -r /path/to/amplify ~/.cursor/skills/amplify
```

Or, if you keep the repo in a fixed location, use a symlink instead:

```bash
mkdir -p ~/.cursor/skills
ln -s /absolute/path/to/amplify ~/.cursor/skills/amplify
```

**Step 2 — Install the bootstrap rule:**

The plugin ships with a ready-made bootstrap rule at `install/amplify-bootstrap.mdc`. Copy it to your Cursor rules directory:

```bash
# User-level (applies to ALL projects):
mkdir -p ~/.cursor/rules
cp ~/.cursor/skills/amplify/install/amplify-bootstrap.mdc ~/.cursor/rules/

# OR project-level (applies only to one project):
mkdir -p /path/to/your-project/.cursor/rules
cp ~/.cursor/skills/amplify/install/amplify-bootstrap.mdc /path/to/your-project/.cursor/rules/
```

**Step 3 — Restart Cursor** and start a new chat session.

### Method 2: From the Cursor Marketplace

If this plugin is published on the Cursor Marketplace (or a private team marketplace), install directly in agent chat:

```
/add-plugin amplify
```

### Method 3: From a GitHub repository

If the plugin is hosted on GitHub, you can try:

```
/add-plugin <github-owner>/<repo-name>
```

Note: This requires the repository to be registered with the Cursor Marketplace. See [Publishing Plugins](https://cursor.com/marketplace/publish) for details.

### Verification

After installation, start a new Cursor chat and type:

```
I want to start a research project on few-shot learning.
```

If the plugin is active, the agent will invoke the `domain-anchoring` skill and begin the structured workflow (asking about your domain, research type, resources, etc.) instead of jumping to code.

## Quick Start

### Starting a New Research Project

Use the `/new-research` command or simply describe your research intent:

```
/new-research
```

or

```
I want to develop a new method for multi-modal data integration
and apply it to disease subtype discovery.
```

The system will guide you through:

| Step | What happens | What you do |
|------|-------------|-------------|
| **Phase 0** | Domain identification, expert persona anchoring | Confirm domain, type (M/D/C/H), resources |
| **Phase 1** | Literature review, gap analysis, direction exploration | Choose from proposed directions, confirm data readiness |
| **G1 gate** | Checklist verification | Approve to proceed |
| **Phase 2** | Adversarial problem validation | Answer defense-style questions, confirm intent |
| **Phase 3** | Method/analysis framework design, metric locking | Approve evaluation protocol, story line, baselines |
| **G2 gate** | Plan freeze | Approve frozen plan |
| **G3 gate** | Data and resource readiness | Confirm everything is in place |
| **Phase 4** | Experiment execution and iteration | Review progress, decide when results are sufficient |
| **Phase 5** | Results integration and reporting | Review report, request additions |
| **G4 gate** | Write-ready check | Say "ready to write paper" |
| **Phase 6** | Paper writing in LaTeX | Review each section, iterate until satisfied |

### Other Commands

| Command | When to use |
|---------|------------|
| `/design-experiment` | Jump to method/analysis design (if Phase 0-1 already done) |
| `/run-experiment` | Jump to experiment execution (if plan is frozen) |
| `/write-paper` | Jump to paper writing (if results are ready) |

## Research Types

The system adapts its behavior based on your research type, determined in Phase 0:

| Type | Focus | Example | Key requirements |
|------|-------|---------|-----------------|
| **M** — Method | New algorithm/model | "A new few-shot learning method" | Locked metrics, baselines, ablation, statistical significance |
| **D** — Discovery | Data-driven insights | "Analyze gene expression data" | Story line, analysis breadth, alternative hypothesis exclusion |
| **C** — Tool | Software/pipeline | "Build a molecular docking tool" | Usability, benchmarks, documentation |
| **H** — Hybrid | Method + application | "New integration method for disease subtypes" | Both M and D requirements |

## Project Structure

When you start a research project, the system creates this standard directory structure:

```
your_project/
├── docs/
│   ├── 01_intake/
│   │   └── research-anchor.yaml       ← project identity and config
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
│   │   └── negative-results.md        ← failures recorded here
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

## Key Files

### `research-anchor.yaml`

The single source of truth for your project. Created in Phase 0, updated through the workflow. Contains:

- Domain and subdomain
- Research type (M/D/C/H) — locked after confirmation
- Expert persona and reviewer focus areas
- Target venue and tier
- Value proposition and innovation point (filled in Phase 3)
- Resource inventory

**Template location:** `templates/research-anchor.yaml`

### `evaluation-protocol.yaml`

The evaluation contract for Type M and Type H projects. Locked after G2. Contains:

- Primary metrics (immutable without user authorization)
- Datasets and splits
- Random seeds (default: 42, 123, 456, 789, 1024)
- Statistical tests
- Baseline list with sources
- Fairness constraints

**Template location:** `templates/evaluation-protocol.yaml`

## Architecture

### Three Layers

```
┌─────────────────────────────────────────────┐
│       Meta-Control Layer (4 skills)         │
│  novelty-classifier, scope-control,         │
│  pivot-or-kill, venue-alignment             │
├─────────────────────────────────────────────┤
│       Discipline Layer (7 skills)           │
│  metric-lock, anti-cherry-pick,             │
│  claim-evidence-alignment,                  │
│  figure-quality-standards,                  │
│  alternative-hypothesis-check,              │
│  reproducibility-driven-research,           │
│  results-verification-protocol              │
├─────────────────────────────────────────────┤
│       Workflow Layer (12 skills)            │
│  Phase 0 → 1 → 2 → 3 → 4 → 5 → 6         │
│  + git-worktrees, parallel-agents, bootstrap│
└─────────────────────────────────────────────┘
```

- **Workflow Layer** answers "what do I do next?"
- **Discipline Layer** answers "what rules must I follow?" (active once triggered, until project end)
- **Meta-Control Layer** answers "is this still on track?" (triggered by conditions like scope creep or repeated failures)

### Four Gates

No gate can be skipped. Each requires a checklist to be fully satisfied and user approval.

| Gate | Between | Key checks |
|------|---------|-----------|
| **G1** | Exploration → Validation | Domain confirmed, literature done, venue estimated, resources checked |
| **G2** | Design → Execution | Metrics locked, method argued, baselines listed, story line approved |
| **G3** | Pre-execution → Full execution | Data ready, leakage audit passed, tools ready |
| **G4** | Results → Paper | All experiments done, claims mapped to evidence, user says "write" |

## Skills Reference

### Workflow Skills (12)

| Skill | Phase | Purpose |
|-------|-------|---------|
| `using-amplify` | Bootstrap | Establishes skill invocation rules and workflow priority |
| `domain-anchoring` | 0 | Domain, research type, expert persona, feasibility |
| `research-direction-exploration` | 1 | Three-path direction discovery, literature review, G1 gate |
| `problem-validation` | 2 | Adversarial questioning, intent classification, venue precision |
| `method-framework-design` | 3 | Type-branching design, G2 gate |
| `evaluation-protocol-design` | 3 | Metric locking for Type M/H (sub-skill) |
| `analysis-storyboard-design` | 3 | Story line design for Type D/H (sub-skill) |
| `experiment-execution` | 4 | Baseline-first execution, iteration, G3 gate, subagent dispatch with review |
| `results-integration` | 5 | Result compilation, claim-evidence check, G4 gate |
| `paper-writing` | 6 | Modular LaTeX, senior writing, reference verification |
| `using-git-worktrees` | Any | Isolated workspaces for experiment branches |
| `dispatching-parallel-agents` | Any | Run independent experiments in parallel |

### Discipline Skills (6)

| Skill | Active from | Enforces |
|-------|------------|----------|
| `metric-lock` | G2 → end | Evaluation metrics cannot change without user permission |
| `anti-cherry-pick` | Phase 4 → end | All seeds reported, failures recorded, fair baselines |
| `claim-evidence-alignment` | Phase 5–6 | Every claim maps to specific evidence |
| `figure-quality-standards` | Phase 4–6 | Publication-quality figures: style consistency, colorblind-safe, readable at print size, vector format |
| `alternative-hypothesis-check` | Phase 4–5 | Confounders excluded before mechanism claims [Type D/H] |
| `reproducibility-driven-research` | Phase 4 → end | Seeds, environment logging, scripted pipelines |
| `results-verification-protocol` | Always | Fresh evidence required before any status claim |

### Meta-Control Skills (4)

| Skill | Triggered by | Action |
|-------|-------------|--------|
| `novelty-classifier` | Phase 1, Phase 3 | Warns if novelty insufficient for target venue |
| `scope-control` | Scope expansion detected | Forces reduction discussion with user |
| `pivot-or-kill` | 3 consecutive failures | Presents pivot/downgrade/kill options to user |
| `venue-alignment` | Every gate + Phase 4 | Checks progress matches venue requirements |

## What the User Controls

The system never makes project governance decisions for you. **You** decide:

- Research direction (from options the system proposes)
- Research type classification
- Target venue
- Evaluation metrics and baselines
- When method results are "good enough"
- Whether to pivot, downgrade, or kill after failures
- When to start paper writing
- Final paper approval

The system proposes, analyzes, and enforces. You decide.

## Troubleshooting

**Skills not loading (manual installation):**

1. Verify the bootstrap rule exists: `ls -la ~/.cursor/rules/amplify-bootstrap.mdc`
2. Verify the skills directory: `ls ~/.cursor/skills/amplify/skills/`
3. Open Cursor Settings → Rules and confirm the bootstrap rule appears and is set to **Always**
4. Restart Cursor and start a fresh chat session

**Agent skipping workflow steps:** The bootstrap rule should make the agent follow the research workflow from the start. If the agent ignores it, explicitly say: "Read and follow the `domain-anchoring` skill at `~/.cursor/skills/amplify/skills/domain-anchoring/SKILL.md`."

**Agent modifying locked metrics:** This violates the `metric-lock` discipline skill. Remind the agent: "Metrics are locked. Any change requires my explicit authorization."

**Updating the plugin:** If installed via symlink, just `git pull` in the source repo. If copied, re-copy from the source.

## License

MIT License
