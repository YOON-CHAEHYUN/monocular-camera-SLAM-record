# Experiment Template

## Date

Created: YYYY-MM-DD
Last run: YYYY-MM-DD

## Title

- **한국어:** Short stable experiment title in Korean.
- **English:** Short stable experiment title in English.

## Status

planned / running / completed / failed / superseded

## Recording Contract

This note is organized by research purpose, not by individual run. Repeated runs for the same purpose must be appended under `## Run History` instead of creating separate experiment files.

Every substantive section should include both Korean and English when possible. Use paired bullets such as `한국어:` and `English:`.

This experiment note is incomplete until it records why the experiment was run, the question or hypothesis it tests, setup/config/data source, metrics, observed results, interpretation, validity status, and next action.

## Motivation

- **한국어:** 이 실험을 진행하는 이유와 연구 맥락에서 중요한 이유.
- **English:** Why this experiment is being run and why it matters in the research context.

## Research Question

- **한국어:** 이 실험이 답하려는 질문.
- **English:** The question this experiment is intended to answer.

## Hypothesis

- **한국어:** 검증하려는 가설과 어떤 결과가 지지/약화/반박/보류에 해당하는지.
- **English:** Which hypothesis this experiment tests and what outcome would support, weaken, reject, or leave it unresolved.

## Setup

- **Environment / 환경:** OS, machine, hardware, software versions.
- **Code state / 코드 상태:** branch, commit hash, relevant uncommitted changes.
- **Artifacts / 산출물:** expected output paths.

## Command / Config

```bash
# command here
```

- **Config path / config 경로:** TBD
- **Important config values / 주요 config 값:** TBD

## Variables

- **Independent variables / 독립 변수:** TBD
- **Controlled variables / 통제 변수:** TBD
- **Ablations / ablation:** TBD

## Dataset / Split

- **Dataset / 데이터셋:** TBD
- **Split / 분할:** TBD
- **Preprocessing / 전처리:** TBD
- **Known caveats / 주의점:** TBD

## Metrics

- **Primary metrics / 주 metric:** TBD
- **Secondary metrics / 보조 metric:** TBD
- **Qualitative checks / 정성 확인:** TBD

## Results

- **Fact / 사실:** concrete run metadata.
- **Observation / 관찰:** direct metric/log/output observations.
- **Artifact paths / 산출물 경로:** TBD

## Interpretation

- **한국어:** 결과가 시사하는 해석.
- **English:** What the results suggest.
- **Speculation / 추측:** tentative explanation, marked `tentative` or `needs verification`.
- **Hypothesis update / 가설 업데이트:** supported / weakened / rejected / unresolved.

## Finding Updates

- Add or update findings in [[Findings]] / [../findings.md](../findings.md).
- Link every finding to this experiment note.

## Failure Notes

- **한국어:** 실패, invalid run, 환경 문제, 배운 점을 기록한다.
- **English:** Record failures, invalid runs, environment problems, and lessons learned.
- Preserve failed attempts when they affect interpretation.

## Follow-up

- **한국어:** 다음 실험 또는 분석.
- **English:** Next experiment or analysis.
- Open questions created by this result.
- Paper outline sections affected.

## Run History

Use this section for repeated runs with the same motivation, research question, and hypothesis. Do not create a new experiment note for each run when the research purpose is the same.

### YYYY-MM-DD_HH-MM-SS

- **Start time / 시작:** TBD
- **End time / 종료:** TBD
- **Exit code / 종료 코드:** TBD
- **Run directory / 실행 디렉터리:** TBD
- **Commit hash / 커밋 해시:** TBD
- **Log / 로그:** TBD
- **Raw artifacts / 원본 산출물:** TBD
- **Command / 명령:**

```bash
# command here
```

## Links

- [[Context]] / [../context.md](../context.md)
- [[Hypotheses]] / [../hypotheses.md](../hypotheses.md)
- [[Findings]] / [../findings.md](../findings.md)
- [[Open Questions]] / [../open_questions.md](../open_questions.md)
- [[Next Steps]] / [../next_steps.md](../next_steps.md)
