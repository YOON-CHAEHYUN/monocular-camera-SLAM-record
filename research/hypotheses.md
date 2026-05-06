# Hypotheses

This file tracks hypotheses over time. Keep rejected and superseded hypotheses for provenance.

## Active Hypotheses

### H1: Navigation-aware BEV/ray/free-space losses outperform pixel depth loss alone

- **Status:** tentative
- **Claim:** For STELLA Camera-Nav, losses that supervise obstacle endpoints, free-space, and BEV occupancy should improve downstream mapping/localization/Nav2 metrics more directly than optimizing pixel depth loss alone.
- **Motivation:** The runtime system consumes BEV occupancy and costmaps, not dense depth maps.
- **Expected evidence:** Ablations where `L_ray`, `L_free`, or `L_occ` improve `F1@20cm`, `IoU_free`, map artifacts, localization score variance, or Nav2 success/recovery metrics beyond a depth-only baseline.
- **Falsifying evidence:** Depth-only fine-tuning matches or exceeds navigation-aware losses on downstream metrics across held-out bags.
- **Related findings:** TBD
- **Related experiments:** TBD
- **Last updated:** 2026-05-06

### H2: Soft differentiable BEV is a useful training surrogate for runtime hard raycasting

- **Status:** tentative
- **Claim:** A differentiable soft BEV/ray endpoint module can train DA2 in a way that improves the existing runtime `da2_occupancy_node.py` hard OccupancyGrid output.
- **Motivation:** The ROS runtime BEV generator is not differentiable, but training still needs gradients from BEV-level objectives.
- **Expected evidence:** Lower soft BEV loss correlates with improved runtime `per_frame_bev_lidar_eval.py` metrics after replay.
- **Falsifying evidence:** Soft BEV losses improve while runtime hard BEV metrics regress or remain unchanged.
- **Related findings:** TBD
- **Related experiments:** TBD
- **Last updated:** 2026-05-06

## Weakened or Rejected Hypotheses

Add hypotheses here when evidence weakens or rejects them. Link to the evidence and explain the update.

## Superseded Hypotheses

Use this section when a hypothesis is replaced by a sharper version. Do not delete the original.
