# Bag07 per-frame BEV LiDAR scale check

## Date

2026-05-07

## Title

Bag07 per-frame BEV LiDAR scale check

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

After live projection check showed DA2 far-board projection remains short, evaluate bag07 per-frame ego BEV vs LiDAR before global map accumulation to identify whether map-size error appears before or after accumulation.

## Research Question

In bag07 ego-frame per-frame comparison, does DA2 BEV appear radially larger or smaller than LiDAR scan BEV at scale 1.0, and what single-scale sweep is preferred?

## Hypothesis

If global mapping is the main source, per-frame DA2 BEV should not show the same large-map behavior; if projection/occupancy is the source, per-frame radial ratios will already show mismatch.

## Setup

- **Run directory:** `/home/jetson/colcon_ws`
- **Start time:** 2026-05-07T00:02:28+09:00
- **End time:** 2026-05-07T00:02:56+09:00
- **Exit code:** 0
- **Code commit hash:** needs verification

## Command / Config

```bash
bash -lc source\ /opt/ros/humble/setup.bash\ \&\&\ source\ /home/jetson/colcon_ws/install/setup.bash\ \&\&\ python3\ /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/fit_bev_scale_bag.py\ --bag\ /home/jetson/colcon_ws/bags/test_run_07/test_run_07_0.db3\ --out\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/bag07_per_frame_bev_lidar_20260507\ --frames\ 24\ --scale-min\ 0.70\ --scale-max\ 1.20\ --scale-step\ 0.025 
```

- **Config path:** /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/fit_bev_scale_bag.py
- **Important config values:** bag=test_run_07 frames=24 scale=0.70..1.20 step=0.025 current DA2 projection constants

## Variables

- **Independent variables:** needs verification
- **Controlled variables:** needs verification
- **Ablations:** needs verification

## Dataset / Split

- **Dataset:** /home/jetson/colcon_ws/bags/test_run_07/test_run_07_0.db3 color images and /scan
- **Split:** needs verification
- **Preprocessing:** needs verification
- **Known caveats:** offline DA2 inference and LiDAR scan comparison before global map accumulation; hardware depth not present in bag07

## Metrics

- **Primary metrics:** scale sweep F1 within 20cm, BEV/LiDAR radial ratio, raw DA2/LiDAR ray ratio, per-frame overlays
- **Secondary metrics:** needs verification
- **Qualitative checks:** needs verification

## Results

- **Fact:** The command exited with code `0`.
- **Observation:** Raw command output is saved at [command.log](../raw/experiments/2026-05-07_00-02-28_bag07-per-frame-bev-lidar-scale-check/command.log).
- **Artifact paths:** [raw experiment directory](../raw/experiments/2026-05-07_00-02-28_bag07-per-frame-bev-lidar-scale-check/)
- **Result validity:** needs verification: mark valid, invalid, tentative, or superseded.

## Interpretation

- **Interpretation:** pending review of per-frame BEV/LiDAR report
- **Speculation:** tentative
- **Hypothesis update:** unresolved
- **Reasoning:** needs verification: explain why the result should or should not affect calibration/navigation decisions.

## Finding Updates

- No finding update recorded yet. Update [[Findings]] / [../findings.md](../findings.md) after reviewing the result.

## Failure Notes

No failure recorded by the runner. Review logs for warnings.

## Follow-up

- If per-frame mismatch is small but global map mismatch remains, proceed to global accumulation/pose check; otherwise inspect projection/height-filter/occupancy.
- Update [[Findings]] / [../findings.md](../findings.md) with a link to this note.
- Update [[Open Questions]] / [../open_questions.md](../open_questions.md) and [[Next Steps]] / [../next_steps.md](../next_steps.md).
- If the experiment produced invalid results, preserve the note and mark the invalidation reason.

## Links

- [[Context]] / [../context.md](../context.md)
- [[Hypotheses]] / [../hypotheses.md](../hypotheses.md)
- [[Findings]] / [../findings.md](../findings.md)
- [[Open Questions]] / [../open_questions.md](../open_questions.md)
- [[Next Steps]] / [../next_steps.md](../next_steps.md)

