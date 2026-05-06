# Research Vault

This directory is a Markdown vault for accumulating research context, experiments, findings, source notes, and paper outline material. It is intended to work as plain Markdown on the SSH server and remain readable in Obsidian after Git clone or rsync.

## Navigation

- [[Context]] / [context.md](context.md): background, problem definition, scope, and assumptions.
- [[Hypotheses]] / [hypotheses.md](hypotheses.md): active and historical hypotheses.
- [[Findings]] / [findings.md](findings.md): cumulative evidence-backed findings.
- [[Open Questions]] / [open_questions.md](open_questions.md): unresolved questions and verification gaps.
- [[Next Steps]] / [next_steps.md](next_steps.md): prioritized research actions.
- [[Paper Outline]] / [paper_outline.md](paper_outline.md): evolving manuscript/report structure.
- [[Sources]] / [sources.md](sources.md): literature, datasets, articles, repos, and other references.
- [experiments/](experiments/): detailed experiment notes.
- [concepts/](concepts/): reusable concept notes.
- [decisions/](decisions/): decisions and rationale.
- [logs/](logs/): chronological activity logs.
- [raw/](raw/): raw artifacts, copied logs, configs, and source material.

## Working Principle

The vault should compile research understanding over time. New experiments and sources should update the relevant overview files, not just create isolated notes. Each important claim should remain traceable to evidence.

When adding content, distinguish:

- **Fact:** confirmed background or metadata.
- **Observation:** what was directly seen in logs, metrics, outputs, or source text.
- **Interpretation:** what the observation likely means.
- **Speculation:** plausible but unverified explanation, marked `tentative` or `needs verification`.

## Suggested Update Flow

1. Read the current context and relevant hypotheses.
2. Add the detailed source, experiment, decision, or log note.
3. Update findings with evidence links.
4. Update open questions and next steps.
5. Update the paper outline when the new information affects the manuscript argument.

## Auto-Sync

This repository includes `scripts/auto_sync.sh`, which can periodically commit vault changes and attempt to push them to `origin`. If GitHub authentication is not configured yet, the push step may fail, but the local commit remains available.

Auto-sync log file: `.auto-sync.log`

