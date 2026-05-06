#!/usr/bin/env bash
set -u

REPO_DIR="/home/jetson/colcon_ws/research-wiki"
CALL_DIR="$(pwd)"

usage() {
  cat <<'USAGE'
Usage:
  scripts/run_experiment.sh "Experiment title" -- <command> [args...]

Example:
  scripts/run_experiment.sh "ORB-SLAM3 monocular baseline" -- ros2 launch pkg launch.py

The command runs from the directory where this script was invoked.
It creates:
  - research/experiments/YYYY-MM-DD_HH-MM-SS_<slug>.md
  - research/raw/experiments/YYYY-MM-DD_HH-MM-SS_<slug>/command.log
Then it calls scripts/auto_sync.sh.
USAGE
}

if [ "$#" -lt 3 ]; then
  usage
  exit 2
fi

TITLE="$1"
shift

if [ "${1:-}" != "--" ]; then
  usage
  exit 2
fi
shift

if [ "$#" -eq 0 ]; then
  usage
  exit 2
fi

COMMAND=("$@")
COMMAND_TEXT="$(printf "%q " "${COMMAND[@]}")"

DATE="$(date +%Y-%m-%d)"
STAMP="$(date +%Y-%m-%d_%H-%M-%S)"
SLUG="$(printf "%s" "$TITLE" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//' | cut -c1-60)"

if [ -z "$SLUG" ]; then
  SLUG="experiment"
fi

EXP_ID="${STAMP}_${SLUG}"
EXP_DIR="$REPO_DIR/research/raw/experiments/$EXP_ID"
EXP_NOTE="$REPO_DIR/research/experiments/$EXP_ID.md"
LOG_PATH="$EXP_DIR/command.log"

mkdir -p "$EXP_DIR"

printf "Running experiment: %s\n" "$TITLE"
printf "Log: %s\n" "$LOG_PATH"

START_TIME="$(date --iso-8601=seconds)"

(
  cd "$CALL_DIR" || exit 1
  printf "$ %s\n\n" "$COMMAND_TEXT"
  "${COMMAND[@]}"
) > "$LOG_PATH" 2>&1

EXIT_CODE="$?"
END_TIME="$(date --iso-8601=seconds)"

COMMIT_HASH="$(git -C "$CALL_DIR" rev-parse HEAD 2>/dev/null || true)"

cat > "$EXP_NOTE" <<NOTE
# $TITLE

## Date

$DATE

## Title

$TITLE

## Status

$([ "$EXIT_CODE" -eq 0 ] && printf "completed" || printf "failed")

## Motivation

\`needs verification\`: Add why this experiment was run and what research gap it addresses.

## Research Question

\`needs verification\`: Add the question this experiment was intended to answer.

## Hypothesis

\`needs verification\`: Link the tested hypothesis from [[Hypotheses]] / [../hypotheses.md](../hypotheses.md).

## Setup

- **Run directory:** \`$CALL_DIR\`
- **Start time:** $START_TIME
- **End time:** $END_TIME
- **Exit code:** $EXIT_CODE
- **Code commit hash:** ${COMMIT_HASH:-needs verification}

## Command / Config

\`\`\`bash
$COMMAND_TEXT
\`\`\`

- **Config path:** needs verification
- **Important config values:** needs verification

## Variables

- **Independent variables:** needs verification
- **Controlled variables:** needs verification
- **Ablations:** needs verification

## Dataset / Split

- **Dataset:** needs verification
- **Split:** needs verification
- **Preprocessing:** needs verification
- **Known caveats:** needs verification

## Metrics

- **Primary metrics:** needs verification
- **Secondary metrics:** needs verification
- **Qualitative checks:** needs verification

## Results

- **Fact:** The command exited with code \`$EXIT_CODE\`.
- **Observation:** Raw command output is saved at [command.log](../raw/experiments/$EXP_ID/command.log).
- **Artifact paths:** [raw experiment directory](../raw/experiments/$EXP_ID/)

## Interpretation

- **Interpretation:** needs verification
- **Speculation:** tentative
- **Hypothesis update:** unresolved

## Finding Updates

- No finding update recorded yet. Update [[Findings]] / [../findings.md](../findings.md) after reviewing the result.

## Failure Notes

$([ "$EXIT_CODE" -eq 0 ] && printf "No failure recorded by the runner. Review logs for warnings." || printf "Command failed. Review [command.log](../raw/experiments/$EXP_ID/command.log) before interpreting the result.")

## Follow-up

- Ask Codex to ingest this experiment result into context, hypotheses, findings, open questions, next steps, and paper outline.

## Links

- [[Context]] / [../context.md](../context.md)
- [[Hypotheses]] / [../hypotheses.md](../hypotheses.md)
- [[Findings]] / [../findings.md](../findings.md)
- [[Open Questions]] / [../open_questions.md](../open_questions.md)
- [[Next Steps]] / [../next_steps.md](../next_steps.md)

NOTE

"$REPO_DIR/scripts/auto_sync.sh"

printf "Experiment note: %s\n" "$EXP_NOTE"
exit "$EXIT_CODE"
