# Amplify

**Automated scientific research — from idea to publication — on the tools you already use.**

Amplify turns your LLM-powered coding assistant (Cursor, Claude Code, Windsurf, OpenClaw, etc.) into an autonomous research agent that conducts the full scientific workflow: find research questions, review literature, design experiments, execute and iterate, and write publication-ready papers. You choose how much to be involved — from hands-on collaboration at every step to simply approving gates and letting the AI drive.

---

## Why This Exists

A growing number of AI-powered research agents can automate parts of the scientific process. But most require dedicated systems, specialized deployments, or model access — impressive demos that remain out of reach for everyday researchers.

Meanwhile, millions of researchers already use LLM-powered coding assistants every day. These tools are powerful, accessible, and affordable. But when asked to "help me write a paper," they produce shallow one-shot outputs — a model trained for 1 epoch, cherry-picked metrics, fabricated references, and a report that no reviewer would accept.

**Amplify bridges this gap.**

Instead of building yet another standalone agent, we build **on top of the tools researchers already have**. If you have a coding assistant and enough LLM tokens, you have a co-scientist. No extra infrastructure. No proprietary APIs. No deployment hassle.

Amplify is a *skills-based framework* — a structured set of workflows, constraints, and multi-agent review systems that teach a general-purpose coding assistant *how to do research properly*. It doesn't replace the AI; it gives it the methodology and discipline that turn raw intelligence into publishable science.

### How You Participate

Amplify enforces human checkpoints (gates) at every critical juncture. But *how* you engage is up to you:

| Level | What You Do | Best For |
|-------|-------------|----------|
| **Hands-on** | Debate research questions, suggest method modifications, guide analysis, edit paper sections | Shaping every decision |
| **Supervisory** | Review deliverables at each gate, give high-level feedback, approve or redirect | Quality control without micro-managing |
| **Approve-and-Go** | Say "approved" at each gate and let the AI handle details autonomously | Maximum automation, minimal overhead |

All three produce the same rigorous output — gates, discipline rules, and multi-agent review panels enforce quality regardless of involvement. The difference is how much domain intuition you inject.

---

## Design Logic

### 1. Finding Research Questions That Matter

The hardest part of science — and the part most AI systems skip. "Find gaps in the literature" produces generic questions. Real researchers think deeper: reading contradictions between papers, challenging shared assumptions, transferring insights across domains.

Amplify addresses this with a **structured idea generation pipeline**:

- **6 Deep Thinking Strategies** — Contradiction Mining, Assumption Challenging, Cross-Domain Transfer, Limitation-to-Opportunity Conversion, Counterfactual Reasoning, and Trend Extrapolation. These go beyond "what papers say is missing" to "what a creative researcher would think of."
- **Multi-Idea Generation** — 5+ candidate ideas as structured cards, each with a concrete research question, novelty source, feasibility assessment, and competition analysis.
- **Automated Multi-Agent Brainstorming** — Three agents (Visionary Researcher, Pragmatic Advisor, Field Scout) debate and refine ideas through up to 5 rounds, optimizing for novelty, feasibility, and positioning simultaneously. Only the top 2–3 are presented for selection.
- **Adversarial Validation** — The chosen question faces questioning from a Senior Professor, Journal Editor, and Research Scientist. Questions that fail the novelty litmus test ("if this succeeds, what NEW knowledge exists?") are blocked before resources are invested.

This pipeline doesn't guarantee brilliance — no system can. But it reliably produces questions that are specific, novel, feasible, and well-positioned.

### 2. Enforcing the Full Scientific Workflow

The difference between a course report and a publishable paper is not writing quality — it's *process*. Amplify enforces a 7-phase workflow with 4 mandatory gates where the AI **cannot** cut corners:

- Literature reviewed before methods are designed
- Metrics locked before experiments run — no post-hoc metric shopping
- Baselines reproduced before the proposed method runs at full scale
- Results survive multi-agent adversarial review before paper writing begins
- Every section of the paper independently reviewed and polished

Each gate requires the researcher's explicit approval. The AI proposes, the human decides.

### 3. Guaranteeing Scientific Rigor

Discipline skills run continuously, catching the mistakes AI agents are most prone to:

- **Metric Lock** — Evaluation criteria frozen after plan freeze; changes require explicit authorization
- **Anti-Cherry-Pick** — All seeds reported, all failures recorded, no selective reporting
- **Run-to-Completion** — No 1-epoch smoke tests as final results
- **Claim-Evidence Alignment** — Every paper claim maps to experimental evidence; unmapped claims deleted
- **Domain Sanity Check** — Results verified against known domain knowledge before reporting
- **On-Demand Literature Search** — Continuous across all phases, not a one-time task

---

## What Changes

| A bare coding assistant | With Amplify |
|-------------------------|-------------|
| Jumps straight to code | Literature review, deep thinking, and multi-agent brainstorming first |
| Research question = whatever user said | Question refined through adversarial 3-agent deliberation |
| Metrics chosen after seeing results | Metrics locked before any experiment runs |
| Single seed, best-case reported | 5 seeds, all results reported including failures |
| No baselines or weak baselines | Baseline-first execution; skipping forbidden |
| Paper written in one shot | Per-section multi-agent review + full-paper review |
| Figures as afterthoughts | Publication-quality figures enforced per venue style |
| References unverified | Every citation checked; fabrication blocked |
| One-pass, no iteration | Mandatory iteration with minimum performance bar |
| Black-box process | 15+ human decision points; 4 mandatory gates |
| Problems discovered late | Phase 4a exploratory stage catches issues early |

---

## How It Works

Amplify defines **24 skills** organized in three layers:

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
│        Workflow Layer (13 skills)            │
│  Phase 0 → 1 → 2 → 3 → 4 → 5 → 6          │
│  + deliberation, worktrees, parallel agents  │
└──────────────────────────────────────────────┘
```

- **Workflow** — "What do I do next?"
- **Discipline** — "What rules must I follow?" (active once triggered, until project end)
- **Meta-Control** — "Is this still on track?" (fires on scope creep, repeated failures, etc.)

### The 7 Phases

| Phase | What the AI does | What you decide |
|-------|-----------------|-----------------|
| **0 — Domain Anchoring** | Identifies field, generates expert persona | Confirm domain, type (M/D/C/H), resources |
| **1 — Direction Exploration** | Reviews 15–30 papers, applies 6 thinking strategies, generates 5+ ideas, runs 3-agent brainstorming | Select direction from top 2–3 refined ideas |
| **2 — Problem Validation** | Novelty litmus test, data screening, 3-agent adversarial deliberation (max 5 rounds) | Approve question or redirect |
| **3 — Method Design** | Type-specific design, 3-agent deliberation, evaluation protocol lock | Approve frozen plan |
| **4 — Experiments** | 4a: exploratory probe → decision point; 4b: full execution, baseline-first, mandatory iteration | Review 4a; proceed / adjust / return |
| **5 — Results Integration** | 3-agent story deliberation, publishability check, claim-evidence alignment | Review blueprint, request additions |
| **6 — Paper Writing** | Modular LaTeX, per-section 3-agent polishing, full-paper review, reference verification | Review sections, approve final paper |

**Gates G1–G4** sit between phases. Each requires a checklist fully satisfied *and* your explicit approval.

### Non-Linear Iteration

Research is not a straight line. Amplify supports structured returns when discoveries invalidate prior assumptions:

```
Phase 4a findings ──→ local adjustment (most common)
                  ──→ focused re-discussion (targeted Phase 3 consultation)
                  ──→ return to Phase 3 (fundamental design problem)
                  ──→ return to Phase 2 (research question is wrong)

Phase 5 review   ──→ supplement experiments (return to Phase 4)
Phase 6 review   ──→ supplement experiments (return to Phase 4)
Phase 2 failure  ──→ return to Phase 1 with failure reasons as constraints
```

### Research Types

| Type | Focus | Example |
|------|-------|---------|
| **M** — Method | New algorithm or model | "A new few-shot learning method" |
| **D** — Discovery | Data-driven insights | "Gene expression patterns in cancer" |
| **C** — Tool | Software or pipeline | "A molecular docking pipeline" |
| **H** — Hybrid | Method + application | "New integration method for disease subtypes" |

---

## Key Capabilities

### Multi-Agent Deliberation

Amplify uses specialized agent panels — not single-agent reasoning — at every stage where judgment matters:

| Phase | Agents | What They Debate |
|-------|--------|-----------------|
| **1** | Visionary Researcher, Pragmatic Advisor, Field Scout | Novelty, feasibility, and positioning of research ideas |
| **2** | Senior Professor, Journal Editor, Research Scientist | Scientific significance, publishability, and feasibility |
| **3** | Type-specific (e.g., Innovation Advisor, Technical Architect, Devil's Advocate) | Soundness and completeness of method design |
| **5** | Story Architect, Devil's Advocate, Audience Specialist | Whether the narrative survives adversarial scrutiny |
| **6** | Domain Expert, Writing Editor, Adversarial Reviewer | Whether each section is publication-ready |

All panels follow the same protocol: agents evaluate → main agent incorporates feedback → all agents re-evaluate (max 5 rounds). Unresolved disagreements are escalated to the researcher.

### Continuous Literature Search

Literature retrieval runs throughout all phases — not just Phase 1:

- **Phase 1**: Broad search (15–30 papers) → autonomous PDF download → user help for paywalled papers
- **Phase 1 Deep Thinking**: On-demand search to verify insights from thinking strategies
- **Phase 3**: Search when design raises new questions
- **Phase 4**: Search when unexpected results need context
- **Phase 5–6**: Search for citations to support paper claims

The system attempts autonomous retrieval first (arXiv, open access, APIs), gracefully degrades on access failures, and asks the researcher for help with inaccessible papers — never fabricating citations.

### Discipline Enforcement

- **Metric Lock** — Metrics frozen after plan freeze; changes require explicit authorization
- **Anti-Cherry-Pick** — All seeds reported, negative results recorded, baselines enforced
- **Claim-Evidence Alignment** — Every claim maps to evidence; unmapped claims deleted
- **Run-to-Completion** — Full execution required; partial runs are not results
- **Domain Sanity Check** — Results verified against domain knowledge before reporting
- **Novelty Guard** — Known-answer questions blocked; over-analyzed datasets flagged

### Publication-Quality Figures

Venue-specific styles enforced automatically:

| Profile | Targets |
|---------|---------|
| CNS | Nature, Science, Cell family |
| CS Conference | NeurIPS, ICML, CVPR, ACL |
| IEEE | IEEE Transactions family |
| Life Science | Bioinformatics, PLOS, BMC |
| Physical Sciences | Physical Review, JACS |

All figures: ≥300 DPI, vector format (PDF/SVG), colorblind-safe, readable at print size.

### Pre-computed Baseline Support

Already have baseline results? Provide them during Phase 1 or 3. The system validates compatibility against the locked evaluation protocol and skips redundant re-runs.

---

## Getting Started

### Prerequisites

- **Cursor IDE** (primary platform; also works with Claude Code, OpenClaw, etc.)
- **Git** (for worktree-based experiment isolation)
- **LaTeX distribution** (TeX Live or MiKTeX)
- **Python 3** with `pyyaml`

### Installation

**Step 1 — Copy or symlink the plugin:**

```bash
mkdir -p ~/.cursor/skills
# Copy:
cp -r /path/to/amplify ~/.cursor/skills/amplify
# Or symlink:
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

### Verification

Type this in a new chat:

```
I want to start a research project on few-shot learning.
```

If active, the agent will invoke `domain-anchoring` and begin the structured workflow — not jump to code.

### Quick Start

```
/new-research
```

or describe your intent directly:

```
I want to develop a new method for multi-modal data integration
and apply it to disease subtype discovery.
```

| Command | When to use |
|---------|------------|
| `/new-research` | Start from scratch |
| `/design-experiment` | Jump to design (if Phase 0–1 done) |
| `/run-experiment` | Jump to execution (if plan frozen) |
| `/write-paper` | Jump to paper writing (if results ready) |

---

## Project Structure

```
your_project/
├── docs/
│   ├── 01_intake/
│   │   └── research-anchor.yaml        ← project identity
│   ├── 02_literature/
│   │   ├── paper-list.md                ← candidates with URLs and access status
│   │   ├── literature-review.md
│   │   ├── gap-analysis.md
│   │   ├── deep-thinking-insights.md    ← insights from 6 thinking strategies
│   │   ├── brainstorming-results.md     ← idea cards + deliberation results
│   │   ├── baseline-collection.md       [Type M/H]
│   │   └── papers/                      ← downloaded PDFs
│   ├── 03_plan/
│   │   ├── method-design.md             [Type M/H]
│   │   ├── analysis-storyboard.md       [Type D/H]
│   │   ├── evaluation-protocol.yaml     ← LOCKED after G2
│   │   └── ablation-design.md           [Type M/H]
│   ├── 04_data_resource/
│   │   └── data-quality-report.md
│   ├── 05_execution/
│   │   ├── experiment-log.md
│   │   ├── baseline-results.md
│   │   └── negative-results.md          ← failures recorded
│   └── 06_report/
│       └── research-report.md
├── paper/                               ← modular LaTeX
│   ├── main.tex
│   ├── sections/
│   ├── figures/
│   └── references.bib
├── repro/                               ← reproducibility package
│   ├── run_all.sh
│   ├── environment.yml
│   └── expected_results/
├── src/
├── data/
│   ├── raw/                             ← immutable
│   └── processed/
└── experiments/
    ├── configs/
    └── results/
```

## What You Control

Amplify never makes governance decisions for you. **You** decide:

- Research direction
- Research type and target venue
- Evaluation metrics and baselines
- When results are "good enough"
- Whether to pivot, downgrade, or kill after failures
- When to start paper writing
- Final paper approval

The system proposes, analyzes, and enforces. You decide.

---

## Skills Reference

<details>
<summary><strong>Workflow Skills (13)</strong></summary>

| Skill | Phase | Purpose |
|-------|-------|---------|
| `using-amplify` | Bootstrap | Skill invocation rules and workflow priority |
| `domain-anchoring` | 0 | Domain, research type, expert persona |
| `research-direction-exploration` | 1 | Literature review, idea generation, G1 gate |
| `problem-validation` | 2 | Adversarial questioning, intent classification |
| `method-framework-design` | 3 | Type-branching design, G2 gate |
| `evaluation-protocol-design` | 3 | Metric locking for Type M/H |
| `analysis-storyboard-design` | 3 | Story line design for Type D/H |
| `experiment-execution` | 4 | Baseline-first execution, iteration, G3 gate |
| `results-integration` | 5 | Result compilation, claim-evidence check, G4 gate |
| `paper-writing` | 6 | Modular LaTeX, reference verification |
| `multi-round-deliberation` | Phase 1–6 | Multi-agent deliberation protocol (max 5 rounds) |
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
| `scope-control` | Scope expansion | Forces scope reduction discussion |
| `pivot-or-kill` | 3 consecutive failures | Presents pivot/downgrade/kill options |
| `venue-alignment` | Every gate | Checks progress vs. venue requirements |

</details>

---

## Troubleshooting

**Skills not loading:**
1. Verify: `ls -la ~/.cursor/rules/amplify-bootstrap.mdc`
2. Verify: `ls ~/.cursor/skills/amplify/skills/`
3. Cursor Settings → Rules → confirm bootstrap is **Always**
4. Restart Cursor, start a fresh chat

**Agent skipping steps:** Say: *"Read and follow the skill at `~/.cursor/skills/amplify/skills/domain-anchoring/SKILL.md`."*

**Agent modifying locked metrics:** Say: *"Metrics are locked. Any change requires my explicit authorization."*

**Updating:** If symlinked, `git pull` in the source repo. If copied, re-copy.

## Acknowledgements

Amplify's plugin architecture is adapted from [Superpowers](https://github.com/obra/superpowers) by Jesse Vincent. The scientific research workflow, all 24 skills, discipline enforcement mechanisms, and multi-agent review systems are original work.

## License

[MIT License](LICENSE) — Copyright (c) 2026 Yanlin Zhang
