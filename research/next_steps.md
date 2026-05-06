# Next Steps

This file tracks prioritized actions. Keep it practical and update it after experiments, source ingests, and major decisions.

## Now

- Implement or sketch an offline dataset exporter from bag data for RGB, camera_info, odom/EKF, LiDAR scan, LiDAR BEV teacher, and per-ray teacher.
- Create a PyTorch prototype for differentiable backprojection, soft BEV projection, and soft ray endpoint loss.
- Run a baseline replay metric table for the current DA2 raw checkpoint using `per_frame_bev_lidar_eval.py`.

## Next

- Run ablations in this order: depth-only, `L_depth + L_ray`, plus `L_free`, plus `L_occ`, then temporal/localization losses.
- Add related work notes for occupancy mapping, likelihood-field localization, differentiable rendering/projection, and planning-aware perception.
- Convert ablation results into evidence-linked findings in [[Findings]] / [findings.md](findings.md).

## Later

- Refine the paper outline after the first few findings stabilize.

## Completed

Move completed actions here with dates and links to resulting notes.
