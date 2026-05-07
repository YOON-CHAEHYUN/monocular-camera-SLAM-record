# Context

## Research Background / 연구 배경

- **한국어:** STELLA Camera-Nav는 monocular depth를 직접 최종 결과로 쓰는 시스템이 아니라, 예측 depth를 ego-centric BEV occupancy, global map, localization, Nav2 planning으로 넘기는 전체 파이프라인이다. 따라서 pixel-level depth metric이 좋아져도 obstacle endpoint, free-space, occlusion, temporal map consistency가 나빠지면 실제 navigation 성능은 개선되지 않을 수 있다.
- **English:** STELLA Camera-Nav does not use monocular depth as the final output. Predicted depth is converted into ego-centric BEV occupancy, accumulated into a global map, used for localization, and consumed by Nav2 planning. Therefore, better pixel-level depth metrics may not improve navigation if obstacle endpoints, free-space, occlusion semantics, or temporal map consistency degrade.

## Problem Definition / 문제 정의

- **Problem / 문제:** Define loss formulations that optimize the whole STELLA Camera-Nav pipeline, not only pixel-level monocular depth error. / monocular depth의 pixel error만 줄이는 것이 아니라 STELLA Camera-Nav 전체 파이프라인을 개선하는 loss formulation을 정의한다.
- **Why it matters / 중요성:** The robot uses predicted depth only as an intermediate representation; navigation quality depends on BEV free-space, obstacle endpoints, map consistency, localization stability, and planner safety. / 로봇은 depth를 중간 표현으로만 쓰며, 실제 성능은 BEV free-space, obstacle endpoint, map consistency, localization stability, planner safety에 의해 결정된다.
- **Target setting / 대상 환경:** SSH-server-based experiments, ROS 2 Humble, STELLA N2 platform, Orbbec Gemini 336L, DA2 metric indoor ViT-S checkpoint, bag replay and live hardware checks. / SSH 서버 기반 실험, ROS 2 Humble, STELLA N2 플랫폼, Orbbec Gemini 336L, DA2 metric indoor ViT-S checkpoint, bag replay 및 live hardware check.
- **Expected output / 기대 산출물:** loss formulations, ablation plans, experiment records, and paper/report material. / loss formulation, ablation plan, 실험 기록, 논문/보고서 작성 재료.

## Research Scope / 연구 범위

### In Scope / 포함

- **한국어:** 실험 동기, 설정, 결과, 해석, artifact path, commit hash, command/config 기록.
- **English:** Experiment motivation, setup, results, interpretation, artifact paths, commit hashes, and command/config records.
- **한국어:** DA2 depth scale, BEV occupancy, LiDAR/Cartographer GT comparison, localization/planning downstream metrics.
- **English:** DA2 depth scale, BEV occupancy, LiDAR/Cartographer GT comparison, and downstream localization/planning metrics.
- **한국어:** 논문 구조로 옮길 수 있는 hypothesis, finding, limitation, method rationale.
- **English:** Hypotheses, findings, limitations, and method rationale that can later move into a paper structure.

### Out of Scope / 제외

- **한국어:** 근거 링크가 없는 단정적 주장. 불확실한 내용은 `tentative` 또는 `needs verification`으로 둔다.
- **English:** Strong claims without evidence links. Uncertain content stays marked as `tentative` or `needs verification`.

## Current Narrative / 현재 연구 서사

- **한국어:** 현재 핵심 문제는 DA2 depth를 어떤 방식으로 보정하거나 학습시켜야 navigation 파이프라인에서 실제로 유리한지 규명하는 것이다. 초기 실험에서는 live AprilGrid/AprilTag board 기반 point-scale 측정과 bag07 BEV/LiDAR 비교가 서로 단순히 같은 숫자를 가리키지 않았다. 특히 board 기반 single-tag 측정은 거리와 프레이밍에 따라 DA2/pose ratio가 크게 달라졌고, bag07 BEV 비교는 scale `0.75`가 `1.0`보다 map alignment에 유리하다는 증거를 보였다. 따라서 현재 해석은 “단일 global depth scale을 바로 적용하기 어렵고, depth point bias, projection/extrinsic, BEV filtering, pose/localization, GT map reference를 분리해야 한다”는 쪽이다.
- **English:** The central research problem is to determine how DA2 depth should be corrected or trained so that it helps the downstream navigation pipeline. Early experiments showed that live AprilGrid/AprilTag board point-scale measurements and bag07 BEV/LiDAR comparisons do not reduce to one simple shared scale. Single-tag board measurements varied strongly with distance and framing, while bag07 BEV comparisons favored scale `0.75` over `1.0` for map alignment. The current interpretation is that applying one global depth scale is not defensible yet; point-depth bias, projection/extrinsics, BEV filtering, pose/localization, and GT map reference must be separated.

## Key Assumptions / 핵심 가정

- **Assumption / 가정, tentative:** LiDAR-derived ray endpoint and free-space supervision are closer to navigation success than dense pixel depth loss alone. / LiDAR 기반 ray endpoint와 free-space supervision은 dense pixel depth loss보다 navigation 성공과 더 가까울 수 있다.
- **Assumption / 가정, tentative:** Differentiable soft BEV/raycasting losses can improve the runtime hard BEV occupancy output despite surrogate mismatch. / differentiable soft BEV/raycasting loss는 surrogate mismatch가 있어도 runtime hard BEV occupancy를 개선할 수 있다.
- **Assumption / 가정, tentative:** Localization likelihood-field and planning/costmap metrics should be used first for checkpoint selection and ablation, then later considered as training surrogates if needed. / localization likelihood-field와 planning/costmap metric은 먼저 checkpoint selection과 ablation에 쓰고, 필요할 때 training surrogate로 확장하는 것이 안전하다.
- **Assumption / 가정, needs verification:** DA2 scale behavior may be range-, scene-, or pipeline-stage-dependent rather than a single global multiplicative factor. / DA2 scale behavior는 단일 global multiplier가 아니라 거리, 장면, pipeline stage에 따라 달라질 수 있다.

## Links / 링크

- [[Hypotheses]] / [hypotheses.md](hypotheses.md)
- [[Findings]] / [findings.md](findings.md)
- [[Paper Outline]] / [paper_outline.md](paper_outline.md)
- [[Navigation-Aware Loss Formulation]] / [concepts/navigation_aware_loss_formulation.md](concepts/navigation_aware_loss_formulation.md)
- [[Depth Scale Calibration and AprilGrid Setup]] / [experiments/2026-05-06-depth-scale-calibration.md](experiments/2026-05-06-depth-scale-calibration.md)
