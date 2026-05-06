# Bag07 per-frame BEV LiDAR key overlays

## Date

2026-05-07

## Title

Bag07 per-frame BEV LiDAR key overlays

## Status

completed

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

The user requested grid visualization at each validation stage; rerun the bag07 per-frame BEV/LiDAR evaluator with fixed key-scale overlays for visual comparison between current scale and best sweep scale.

## Research Question

Visually, how do scale=0.75 and scale=1.0 DA2 BEV grids compare against LiDAR in the same selected frames?

## Hypothesis

The key-scale overlays will show whether the per-frame mismatch at scale=1.0 is a radial oversize/occupancy issue visible before global accumulation.

## Setup

- **Run directory:** `/home/jetson/colcon_ws`
- **Start time:** 2026-05-07T00:04:35+09:00
- **End time:** 2026-05-07T00:05:05+09:00
- **Exit code:** 0
- **Code commit hash:** needs verification

## Command / Config

```bash
bash -lc source\ /opt/ros/humble/setup.bash\ \&\&\ source\ /home/jetson/colcon_ws/install/setup.bash\ \&\&\ python3\ /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/fit_bev_scale_bag.py\ --bag\ /home/jetson/colcon_ws/bags/test_run_07/test_run_07_0.db3\ --out\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/bag07_per_frame_bev_lidar_20260507\ --frames\ 24\ --scale-min\ 0.70\ --scale-max\ 1.20\ --scale-step\ 0.025\ --viz-scales\ 0.75\,1.0\ --viz-frame-count\ 6 
```

- **Config path:** /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/fit_bev_scale_bag.py
- **Important config values:** bag=test_run_07 frames=24 scale=0.70..1.20 step=0.025 viz_scales=0.75,1.0 viz_frame_count=6

## Variables

- **Independent variables:** needs verification
- **Controlled variables:** needs verification
- **Ablations:** needs verification

## Dataset / Split

- **Dataset:** /home/jetson/colcon_ws/bags/test_run_07/test_run_07_0.db3 color images and /scan
- **Split:** needs verification
- **Preprocessing:** needs verification
- **Known caveats:** This rerun is primarily to add visual overlay artifacts; quantitative values should match the prior per-frame run.

## Metrics

- **Primary metrics:** key-scale overlay PNGs, scale sweep F1/IoU, BEV/LiDAR radial ratio
- **Secondary metrics:** needs verification
- **Qualitative checks:** needs verification

## Results

- **Fact:** The command exited with code `0`.
- **Observation:** Raw command output is saved at [command.log](../raw/experiments/2026-05-07_00-04-35_bag07-per-frame-bev-lidar-key-overlays/command.log).
- **Artifact paths:** [raw experiment directory](../raw/experiments/2026-05-07_00-04-35_bag07-per-frame-bev-lidar-key-overlays/)
- **Result validity:** needs verification: mark valid, invalid, tentative, or superseded.

## Interpretation

- **Interpretation:** pending visual and report review
- **Speculation:** tentative
- **Hypothesis update:** unresolved
- **Reasoning:** needs verification: explain why the result should or should not affect calibration/navigation decisions.

## Finding Updates

- No finding update recorded yet. Update [[Findings]] / [../findings.md](../findings.md) after reviewing the result.

## Failure Notes

No failure recorded by the runner. Review logs for warnings.

## Follow-up

- Use these overlays to decide whether per-frame mismatch is already present before global map accumulation.
- Update [[Findings]] / [../findings.md](../findings.md) with a link to this note.
- Update [[Open Questions]] / [../open_questions.md](../open_questions.md) and [[Next Steps]] / [../next_steps.md](../next_steps.md).
- If the experiment produced invalid results, preserve the note and mark the invalidation reason.

## Links

- [[Context]] / [../context.md](../context.md)
- [[Hypotheses]] / [../hypotheses.md](../hypotheses.md)
- [[Findings]] / [../findings.md](../findings.md)
- [[Open Questions]] / [../open_questions.md](../open_questions.md)
- [[Next Steps]] / [../next_steps.md](../next_steps.md)

