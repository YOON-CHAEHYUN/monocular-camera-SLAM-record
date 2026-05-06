# Navigation-Aware Loss Formulation

Last updated: 2026-05-06

## Summary

**Fact:** STELLA Camera-Nav의 최종 목적은 pixel depth benchmark가 아니라 RGB monocular depth를 이용한 BEV occupancy mapping, localization, and Nav2 navigation 성능이다.

**Interpretation:** Loss formulation은 `RGB -> depth -> point cloud -> BEV -> map -> localization -> costmap/planner` 전체 파이프라인을 대상으로 설계해야 한다. Pixel depth loss는 필요한 항일 수 있지만 충분한 항은 아니다.

## Canonical Detail

Full technical note:

- [LOSS_FORMULATION_RESEARCH.md](../../../stella_camera_nav_experiments/docs/LOSS_FORMULATION_RESEARCH.md)

## Core Objective

```text
L_total =
  lambda_depth L_depth
+ lambda_ray L_endpoint
+ lambda_free L_free_space
+ lambda_occ L_occupancy
+ lambda_temp L_temporal
+ lambda_map L_mapping
+ lambda_loc L_localization
+ lambda_plan L_planning_surrogate
```

## Related Questions

- Does navigation-aware BEV/ray/free-space supervision improve downstream navigation more directly than pixel depth loss alone?
- Which loss terms correlate most strongly with Nav2 success, recovery count, and collision risk?
- How large is the surrogate gap between differentiable training-time BEV losses and runtime hard raycasting/OccupancyGrid behavior?

