# Research Vault Operating Rules

This workspace is a research Markdown vault for accumulating experiment records, source notes, hypotheses, findings, and paper-writing context. Codex must treat `research/` as a long-lived research memory, not as disposable chat output.

## Core Workflow

1. Before editing research documents, first read the existing relevant files to understand the current research context. At minimum, check `research/README.md`, `research/context.md`, `research/hypotheses.md`, `research/findings.md`, `research/open_questions.md`, `research/next_steps.md`, and `research/paper_outline.md` when updating broad research state.
2. When the user provides experiment results, logs, paper notes, code changes, or analysis results, update the relevant Markdown files directly. Do not only summarize in chat.
3. Every substantive update must record more than a summary. Capture:
   - why the experiment or analysis was done
   - which hypothesis it was meant to test
   - the experimental setup
   - variables and metrics
   - observed results
   - whether the result supports, weakens, rejects, or leaves the hypothesis unresolved
   - findings that should accumulate in `research/findings.md`
   - next actions
4. Separate confirmed facts, observations, interpretations, and speculation. Use explicit labels such as `Fact`, `Observation`, `Interpretation`, and `Speculation`.
5. Mark uncertain content as `tentative` or `needs verification`. Do not present uncertain content as established fact.
6. Each finding in `research/findings.md` must link to supporting experiment, source, log, or decision documents. Prefer both Obsidian wikilinks such as `[[Experiment Title]]` and normal Markdown links when practical.
7. Preserve experiment history. Do not delete older experiment records just because conclusions changed. Use dated notes, `superseded`, or status updates instead.
8. Avoid copying long duplicate content into multiple files. Put the canonical detail in the most relevant document, then link to it from overview files.
9. Write in a style that can later be adapted into paper sections: Introduction, Related Work, Method, Results, Discussion, and Limitations.
10. For experiments run on this SSH server, record available artifacts: log paths, config paths, command lines, dataset or split identifiers, commit hashes, environment details, output directories, and notable file paths.
11. Keep filenames and headings stable so the vault remains readable after Git clone or rsync into local Obsidian.

## File Roles

- `research/context.md`: research background, problem definition, scope, assumptions, and narrative context.
- `research/hypotheses.md`: active, weakened, rejected, and superseded hypotheses.
- `research/findings.md`: accumulated claims with evidence and status.
- `research/open_questions.md`: unresolved research questions and verification gaps.
- `research/next_steps.md`: prioritized follow-up actions.
- `research/paper_outline.md`: evolving manuscript/report outline.
- `research/sources.md`: papers, articles, datasets, repos, and other sources.
- `research/experiments/`: one Markdown file per experiment, based on `research/experiments/TEMPLATE.md`.
- `research/concepts/`: reusable concept notes and definitions.
- `research/decisions/`: important research or engineering decisions with rationale.
- `research/logs/`: dated research activity logs or session notes.
- `research/raw/`: raw inputs, copied notes, exported logs, configs, and artifacts when appropriate.

## Update Conventions

- Prefer append-only dated sections when recording new evidence.
- Use ISO dates: `YYYY-MM-DD`.
- Link evidence from summary documents to detailed documents.
- If a new result changes prior interpretation, update the affected hypothesis or finding status and add a dated note explaining why.
- If a user asks to ingest a source, connect it to research questions, hypotheses, experiment design, findings, and the paper outline instead of only writing a paper summary.
- If a user asks to reflect an experiment, create or update an experiment note first, then propagate only the distilled implications to context, hypotheses, findings, open questions, next steps, and paper outline.

