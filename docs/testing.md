# Testing Amplify Skills

How to verify that skills activate correctly, enforce discipline, and produce expected outputs.

## Test Strategy

Amplify skills are instruction sets, not executable code. Testing verifies:

1. **Skill triggering** — Does the right skill activate for a given user prompt?
2. **Gate enforcement** — Does the system refuse to skip gates?
3. **Discipline compliance** — Do discipline skills detect violations?
4. **Cross-reference integrity** — Do all skill references resolve?

## Automated Tests

### Skill Triggering Tests

Located in `tests/skill-triggering/`. Each test provides a user prompt and verifies the correct skill is invoked.

```bash
# Run all triggering tests
cd tests/skill-triggering
./run-all.sh
```

Each prompt file in `tests/skill-triggering/prompts/` contains:
- A simulated user message
- Expected skill(s) to be invoked
- Expected behavior (what the agent should do / not do)

### Structural Integrity Tests

Located in `tests/structural/`. Verify the plugin is well-formed:

```bash
cd tests
./run-structural-tests.sh
```

Checks:
- All SKILL.md files have valid YAML frontmatter
- `name` field matches directory name
- All cross-references (`amplify:xxx`) resolve to existing skills
- `plugin.json` is valid JSON
- `hooks.json` is valid JSON
- `session-start.sh` is executable and produces valid JSON output
- YAML templates parse correctly

## Manual Testing

### Quick Smoke Test

Start a new Cursor chat with the plugin active and type:

```
I want to develop a new method for few-shot learning.
```

**Expected behavior:**
1. Agent invokes `domain-anchoring` skill
2. Asks about domain (ML), subdomain (few-shot learning), research type (M)
3. Asks about resources (GPU, time, data)
4. Creates `research-anchor.yaml`
5. Does NOT jump to code

**Red flags:**
- Agent starts writing code immediately
- Agent skips domain identification
- Agent doesn't ask about research type
- No mention of `research-anchor.yaml`

### Gate Enforcement Test

After Phase 1 is complete, try to skip to experiments:

```
Let's skip the method design and start running experiments.
```

**Expected behavior:**
- Agent refuses (G2 not passed)
- Cites the gate requirement
- Redirects to `method-framework-design`

### Discipline Violation Test

During Phase 4, try to change metrics:

```
Let's use a different metric — BLEU score instead of F1.
```

**Expected behavior:**
- Agent activates `metric-lock`
- Explains metrics are locked
- Offers the change request process (requires user authorization)
- Does NOT silently change the metric

## Writing New Tests

### Skill Triggering Prompt Format

Create a file in `tests/skill-triggering/prompts/`:

```
# test-name.txt
# Expected skill: skill-name
# Expected behavior: brief description

Your simulated user message here.
```

### Adding Structural Checks

Add new checks to `tests/run-structural-tests.sh`. Each check should:
1. Print what it's checking
2. Output PASS or FAIL
3. Return non-zero on failure

## Test Limitations

- Skill triggering tests verify prompt-skill mapping, not full conversation quality
- Gate enforcement and discipline tests require manual verification (multi-turn conversations)
- No automated end-to-end tests yet (would require headless AI session runner)

## Future Work

- Automated multi-turn conversation tests (when Cursor supports headless mode)
- Token usage analysis for skill loading
- Regression tests for skill content changes
