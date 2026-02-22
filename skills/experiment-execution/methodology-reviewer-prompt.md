# Methodology Reviewer Subagent Prompt Template

Use this template when dispatching a subagent to review research methodology after experiments complete. This reviews scientific rigor, NOT code quality.

```yaml
Task tool:
  description: "Review methodology for [task]"
  prompt: |
    You are reviewing research methodology, NOT code quality.

    ## What Was Implemented
    [From implementer's report — include method description, results, and files]

    ## Evaluation Protocol (LOCKED)
    [From docs/03_plan/evaluation-protocol.yaml — paste relevant sections]

    ## Your Review Checklist

    **Statistical Rigor:**
    - Are all seeds run and reported?
    - Is mean ± std (or CI) reported, not single-run numbers?
    - Is the appropriate statistical test used (as specified in evaluation protocol)?
    - Are p-values or confidence intervals provided for key comparisons?

    **Baseline Fairness:**
    - Same compute budget for all methods?
    - Same data access (no asymmetric pretrained models or extra data)?
    - Same preprocessing pipeline?
    - Same hyperparameter search budget?
    - Official baseline code used (or deviation justified in writing)?

    **Data Integrity:**
    - Train/val/test strictly separated with no overlap?
    - No information leakage (preprocessing fitted on train only)?
    - [Time series] No future data used in features or targets?
    - [ML] Leakage audit results reviewed?

    **Metric Compliance:**
    - Results reported using LOCKED primary metrics from evaluation-protocol.yaml?
    - No substitution of metrics without documented user authorization?
    - Secondary metrics clearly labeled as secondary?

    **Reproducibility:**
    - Seeds recorded and consistent across all runs?
    - Environment logged (library versions, hardware)?
    - Scripts available to re-run every experiment?
    - Configs saved alongside results?

    ## Your Report

    For each checklist section, provide one of:
    - ✅ Sound — with specific evidence (e.g., "5 seeds run, mean ± std reported in Table 2")
    - ❌ Issue — with specific details and remediation steps

    ## Summary
    - Overall methodology status: PASS / FAIL / CONDITIONAL PASS
    - Critical issues (must fix before proceeding): [list]
    - Recommendations (should fix): [list]
```

## Dispatch Checklist

Before sending this prompt, verify:

- [ ] Implementer's report is attached with full results
- [ ] Evaluation protocol section is pasted (not referenced by path — reviewer may not have file access)
- [ ] Review scope is clear (which experiments to review)
