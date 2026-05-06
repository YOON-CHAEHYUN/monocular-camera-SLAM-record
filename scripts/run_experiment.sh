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

Before running a test, set these required context variables:
  EXP_MOTIVATION="why this test is being run"
  EXP_QUESTION="question this test answers"
  EXP_HYPOTHESIS="hypothesis under test"
  EXP_METRICS="primary metrics / qualitative checks"

Optional context variables:
  EXP_CONFIG_PATH="important config file path or N/A"
  EXP_CONFIG_VALUES="important config values"
  EXP_DATASET="bag/dataset/live hardware source"
  EXP_CAVEATS="known caveats"
  EXP_INTERPRETATION="initial interpretation after the run"
  EXP_NEXT_ACTION="next action after reviewing result"

For emergency exploratory runs only, set EXP_ALLOW_INCOMPLETE=1. The generated
note must still be completed before reporting results.

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

required_context=(EXP_MOTIVATION EXP_QUESTION EXP_HYPOTHESIS EXP_METRICS)
missing_context=()
for name in "${required_context[@]}"; do
  if [ -z "${!name:-}" ]; then
    missing_context+=("$name")
  fi
done

if [ "${#missing_context[@]}" -gt 0 ] && [ "${EXP_ALLOW_INCOMPLETE:-0}" != "1" ]; then
  printf "Missing required experiment context:\n" >&2
  for name in "${missing_context[@]}"; do
    printf "  - %s\n" "$name" >&2
  done
  printf "\nSet these variables so the experiment record captures why the test is being run.\n" >&2
  printf "Use EXP_ALLOW_INCOMPLETE=1 only for emergency exploratory runs, then complete the note before reporting results.\n" >&2
  exit 2
fi

MOTIVATION="${EXP_MOTIVATION:-needs verification: add why this experiment was run and what research gap it addresses.}"
QUESTION="${EXP_QUESTION:-needs verification: add the question this experiment was intended to answer.}"
HYPOTHESIS="${EXP_HYPOTHESIS:-needs verification: link the tested hypothesis and expected support/weaken/reject outcomes.}"
METRICS="${EXP_METRICS:-needs verification: add primary metrics and qualitative checks.}"
CONFIG_PATH="${EXP_CONFIG_PATH:-needs verification}"
CONFIG_VALUES="${EXP_CONFIG_VALUES:-needs verification}"
DATASET="${EXP_DATASET:-needs verification}"
CAVEATS="${EXP_CAVEATS:-needs verification}"
INITIAL_INTERPRETATION="${EXP_INTERPRETATION:-needs verification}"
NEXT_ACTION="${EXP_NEXT_ACTION:-Review this note and replace all needs-verification fields that affect interpretation.}"

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

## Recording Contract

This experiment note is incomplete until it records all of the following:

- why the experiment was run
- the question or hypothesis it tests
- exact setup, command, data source, and config values
- metrics and qualitative checks
- observed results and artifact paths
- interpretation, including valid/invalid/tentative/superseded status
- next action

Do not use the numeric result without this context.

## Motivation

$MOTIVATION

## Research Question

$QUESTION

## Hypothesis

$HYPOTHESIS

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

- **Config path:** $CONFIG_PATH
- **Important config values:** $CONFIG_VALUES

## Variables

- **Independent variables:** needs verification
- **Controlled variables:** needs verification
- **Ablations:** needs verification

## Dataset / Split

- **Dataset:** $DATASET
- **Split:** needs verification
- **Preprocessing:** needs verification
- **Known caveats:** $CAVEATS

## Metrics

- **Primary metrics:** $METRICS
- **Secondary metrics:** needs verification
- **Qualitative checks:** needs verification

## Results

- **Fact:** The command exited with code \`$EXIT_CODE\`.
- **Observation:** Raw command output is saved at [command.log](../raw/experiments/$EXP_ID/command.log).
- **Artifact paths:** [raw experiment directory](../raw/experiments/$EXP_ID/)
- **Result validity:** needs verification: mark valid, invalid, tentative, or superseded.

## Interpretation

- **Interpretation:** $INITIAL_INTERPRETATION
- **Speculation:** tentative
- **Hypothesis update:** unresolved
- **Reasoning:** needs verification: explain why the result should or should not affect calibration/navigation decisions.

## Finding Updates

- No finding update recorded yet. Update [[Findings]] / [../findings.md](../findings.md) after reviewing the result.

## Failure Notes

$([ "$EXIT_CODE" -eq 0 ] && printf "No failure recorded by the runner. Review logs for warnings." || printf "Command failed. Review [command.log](../raw/experiments/$EXP_ID/command.log) before interpreting the result.")

## Follow-up

- $NEXT_ACTION
- Update [[Findings]] / [../findings.md](../findings.md) with a link to this note.
- Update [[Open Questions]] / [../open_questions.md](../open_questions.md) and [[Next Steps]] / [../next_steps.md](../next_steps.md).
- If the experiment produced invalid results, preserve the note and mark the invalidation reason.

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
