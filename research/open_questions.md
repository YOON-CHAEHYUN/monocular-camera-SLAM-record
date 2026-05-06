# Open Questions

This file tracks unresolved questions, missing evidence, and verification gaps.

## High Priority

- **Question:** Which loss term best predicts downstream Nav2 performance: pixel depth, ray endpoint, free-space, occupancy, temporal consistency, or localization likelihood?
  - **Why it matters:** It determines the main research claim and ablation order.
  - **Possible evidence:** Loss ablations evaluated with `per_frame_bev_lidar_eval.py`, global map replay, localization score, and Nav2 goal tests.
  - **Related links:** [LOSS_FORMULATION_RESEARCH.md](../../stella_camera_nav_experiments/docs/LOSS_FORMULATION_RESEARCH.md)
  - **Last updated:** 2026-05-06

- **Question:** How large is the mismatch between training-time soft BEV/raycasting and runtime hard BEV/raycasting?
  - **Why it matters:** A large mismatch could make differentiable BEV losses misleading.
  - **Possible evidence:** Compare soft loss values against runtime hard `F1@20cm`, `IoU_free`, and `ratio_med` on held-out replay.
  - **Related links:** [[Navigation-Aware Loss Formulation]] / [concepts/navigation_aware_loss_formulation.md](concepts/navigation_aware_loss_formulation.md)
  - **Last updated:** 2026-05-06

## Medium Priority

- **Question:** Should localization likelihood-field loss be used for training or only for checkpoint selection?
  - **Why it matters:** Map-based loss can overfit to map artifacts or pose initialization errors.
  - **Possible evidence:** Ablation with and without `L_localization` after BEV losses are stable.
  - **Last updated:** 2026-05-06

## Parking Lot

Add speculative questions that may become relevant later.
