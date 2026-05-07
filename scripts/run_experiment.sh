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
  - research/experiments/<stable-purpose-slug>.md
  - research/raw/experiments/YYYY-MM-DD_HH-MM-SS_<slug>/command.log
Repeated runs with the same title append to the same experiment note instead of
creating a new note each time. Use the same title for the same research purpose.
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
EXP_NOTE="$REPO_DIR/research/experiments/$SLUG.md"
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

if [ ! -f "$EXP_NOTE" ]; then
  cat > "$EXP_NOTE" <<NOTE
# $TITLE

## Date

Created: $DATE
Last run: $DATE

## Title

- **한국어:** $TITLE
- **English:** $TITLE

## Status

$([ "$EXIT_CODE" -eq 0 ] && printf "completed" || printf "failed")

## Recording Contract

This note is organized by research purpose, not by individual run. Repeated
runs for the same purpose must be appended under `## Run History` instead of
creating separate experiment files.

Every substantive section should include both Korean and English when possible.
Use paired bullets such as `한국어:` and `English:` rather than separate duplicate
files.

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

- **한국어:** $MOTIVATION
- **English:** $MOTIVATION

## Research Question

- **한국어:** $QUESTION
- **English:** $QUESTION

## Hypothesis

- **한국어:** $HYPOTHESIS
- **English:** $HYPOTHESIS

## Setup

- **Environment / 환경:** needs verification
- **Code state / 코드 상태:** ${COMMIT_HASH:-needs verification}
- **Artifact root / 산출물 루트:** [raw experiment directory](../raw/experiments/$EXP_ID/)

## Command / Config

Latest run command:

\`\`\`bash
$COMMAND_TEXT
\`\`\`

- **Config path:** $CONFIG_PATH
- **Important config values:** $CONFIG_VALUES

## Variables

- **Independent variables / 독립 변수:** needs verification
- **Controlled variables / 통제 변수:** needs verification
- **Ablations / Ablation:** needs verification

## Dataset / Split

- **Dataset / 데이터셋:** $DATASET
- **Split / 분할:** needs verification
- **Preprocessing / 전처리:** needs verification
- **Known caveats / 주의점:** $CAVEATS

## Metrics

- **Primary metrics / 주 metric:** $METRICS
- **Secondary metrics / 보조 metric:** needs verification
- **Qualitative checks / 정성 확인:** needs verification

## Results

- **Fact / 사실:** The latest command exited with code \`$EXIT_CODE\`.
- **Observation / 관찰:** Raw command output is saved at [command.log](../raw/experiments/$EXP_ID/command.log).
- **Artifact paths / 산출물 경로:** [raw experiment directory](../raw/experiments/$EXP_ID/)
- **Result validity / 결과 유효성:** needs verification: mark valid, invalid, tentative, or superseded.

## Interpretation

- **한국어:** $INITIAL_INTERPRETATION
- **English:** $INITIAL_INTERPRETATION
- **Speculation / 추측:** tentative
- **Hypothesis update / 가설 업데이트:** unresolved
- **Reasoning / 판단 근거:** needs verification: explain why the result should or should not affect calibration/navigation decisions.

## Finding Updates

- No finding update recorded yet. Update [[Findings]] / [../findings.md](../findings.md) after reviewing the result.

## Failure Notes

- **한국어:** $([ "$EXIT_CODE" -eq 0 ] && printf "러너 기준 실패는 기록되지 않았다. 경고 여부는 로그를 검토해야 한다." || printf "명령이 실패했다. 결과 해석 전에 [command.log](../raw/experiments/$EXP_ID/command.log)를 검토해야 한다.")
- **English:** $([ "$EXIT_CODE" -eq 0 ] && printf "No failure recorded by the runner. Review logs for warnings." || printf "Command failed. Review [command.log](../raw/experiments/$EXP_ID/command.log) before interpreting the result.")

## Follow-up

- **한국어:** $NEXT_ACTION
- **English:** $NEXT_ACTION
- Update [[Findings]] / [../findings.md](../findings.md) with a link to this note.
- Update [[Open Questions]] / [../open_questions.md](../open_questions.md) and [[Next Steps]] / [../next_steps.md](../next_steps.md).
- If the experiment produced invalid results, preserve the note and mark the invalidation reason.

## Run History

### $STAMP

- **Start time / 시작:** $START_TIME
- **End time / 종료:** $END_TIME
- **Exit code / 종료 코드:** $EXIT_CODE
- **Run directory / 실행 디렉터리:** \`$CALL_DIR\`
- **Commit hash / 커밋 해시:** ${COMMIT_HASH:-needs verification}
- **Log / 로그:** [command.log](../raw/experiments/$EXP_ID/command.log)
- **Raw artifacts / 원본 산출물:** [raw experiment directory](../raw/experiments/$EXP_ID/)
- **Command / 명령:**

\`\`\`bash
$COMMAND_TEXT
\`\`\`

## Links

- [[Context]] / [../context.md](../context.md)
- [[Hypotheses]] / [../hypotheses.md](../hypotheses.md)
- [[Findings]] / [../findings.md](../findings.md)
- [[Open Questions]] / [../open_questions.md](../open_questions.md)
- [[Next Steps]] / [../next_steps.md](../next_steps.md)

NOTE
else
  sed -i "0,/^Last run:/s/^Last run:.*/Last run: $DATE/" "$EXP_NOTE"

  if ! grep -Fqx "## Run History" "$EXP_NOTE"; then
    cat >> "$EXP_NOTE" <<'NOTE'

## Run History
NOTE
  fi

  cat >> "$EXP_NOTE" <<NOTE

### $STAMP

- **Start time / 시작:** $START_TIME
- **End time / 종료:** $END_TIME
- **Exit code / 종료 코드:** $EXIT_CODE
- **Run directory / 실행 디렉터리:** \`$CALL_DIR\`
- **Commit hash / 커밋 해시:** ${COMMIT_HASH:-needs verification}
- **Log / 로그:** [command.log](../raw/experiments/$EXP_ID/command.log)
- **Raw artifacts / 원본 산출물:** [raw experiment directory](../raw/experiments/$EXP_ID/)
- **Command / 명령:**

\`\`\`bash
$COMMAND_TEXT
\`\`\`

- **Initial interpretation / 초기 해석:** $INITIAL_INTERPRETATION
- **Next action / 다음 액션:** $NEXT_ACTION

NOTE
fi

"$REPO_DIR/scripts/auto_sync.sh"

printf "Experiment note: %s\n" "$EXP_NOTE"
exit "$EXIT_CODE"
