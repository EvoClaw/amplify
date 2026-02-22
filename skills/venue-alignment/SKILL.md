---
name: venue-alignment
description: Use at every gate checkpoint and periodically during experiments to verify that project progress matches the target venue's requirements in terms of experiment scale, novelty depth, and evidence quality
---

# Venue Alignment (Meta-Control Layer)

## Overview

A project that meets Tier C standards but targets a Tier A venue will be rejected. A project that exceeds Tier A standards but targets a Tier C venue wastes effort. This skill keeps project ambition and execution aligned with the target venue at every stage.

**Check venue alignment at every gate and periodically during Phase 4 execution.**

## Gate-Specific Checks

### G1 — Direction Validated

*"Is the identified gap significant enough for [venue]?"*

- Compare the claimed gap against recent publications at the target venue
- A gap that is incremental for Tier A may be sufficient for Tier B
- If gap is insufficient → warn user, suggest venue adjustment

### G2 — Plan Frozen

*"Does the method/analysis design have enough depth for [venue]?"*

- Count innovation points, analysis dimensions, planned contributions
- Compare depth against accepted papers at the target venue
- If design is shallow for the target tier → warn user before freezing

### G3 — Experiments Complete

*"Is the planned experiment scale sufficient for [venue]?"*

- Check baseline count, dataset count, ablation coverage, statistical rigor
- Compare against the venue tier requirements table below
- If scale falls short → warn user, suggest scaling up or adjusting venue

### G4 — Paper Ready

*"Does the evidence package (figures, tables, statistics) meet [venue] standards?"*

- Count figures, tables, statistical tests, ablation studies
- Check completeness against the venue tier requirements
- If evidence is thin → warn user before submission

## Venue Tier Requirements Reference

| Requirement | Tier A | Tier B | Tier C |
|-------------|--------|--------|--------|
| **Baselines** | 5–8 strong, recent | 3–5 | 2–3 |
| **Datasets** | 3–5 | 2–3 | 1–2 |
| **Ablation** | Full component ablation | Key components | Optional |
| **Statistics** | CI + significance test | mean ± std | mean ± std |
| **Novelty** | Clear, significant advance | Solid contribution | Incremental or applied |
| **Analysis depth** | Multi-angle, comprehensive | Adequate coverage | Focused |

## Misalignment Response

If current progress falls short of venue requirements at any gate:

1. **State the gap clearly:** *"Current experiment scale has 3 baselines; [venue] typically expects 5–8."*
2. **Present two options:**
   - □ **Scale up:** add the missing baselines/datasets/analyses to meet the target
   - □ **Adjust venue:** downgrade to a venue where current progress is sufficient
3. **Record the decision** in `research-anchor.yaml` under `venue_target`

Never silently accept misalignment. The user must make an informed decision.

## Red Flags — STOP

- Targeting Tier A with fewer than 5 baselines
- Targeting Tier A without significance tests
- Claiming "the contribution is strong enough" without evidence comparison
- Skipping venue checks at gate transitions
- Refusing to consider venue adjustment when evidence is thin

## The Bottom Line

```
Match ambition to evidence. Match evidence to venue.
Misalignment in either direction wastes effort.
```
