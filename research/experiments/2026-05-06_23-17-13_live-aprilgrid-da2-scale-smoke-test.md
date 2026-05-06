# Live AprilGrid DA2 scale smoke test

## Date

2026-05-06

## Title

Live AprilGrid DA2 scale smoke test

## Status

failed

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

DA2 BEV scale mismatch cannot be trusted from LiDAR-only or pixel-aligned depth comparisons; AprilGrid gives an RGB geometric pose reference for scale.

## Research Question

Does the 6x6 AprilGrid pose provide a stable reference distance, and what DA2/reference scale is observed live?

## Hypothesis

The board pose will show DA2 near-range depth overestimation, but the ratio may differ from bag-level BEV/LiDAR scale.

## Setup

- **Run directory:** `/home/jetson/colcon_ws`
- **Start time:** 2026-05-06T23:17:13+09:00
- **End time:** 2026-05-06T23:17:39+09:00
- **Exit code:** 124
- **Code commit hash:** needs verification

## Command / Config

```bash
bash -lc source\ /opt/ros/humble/setup.bash\ \&\&\ source\ /home/jetson/colcon_ws/install/setup.bash\ \&\&\ timeout\ 25s\ python3\ /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_aprilgrid_depth_check.py\ --frames\ 30\ --min-tags\ 2\ --max-reproj-rms\ 6.0\ --output-csv\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_aprilgrid_depth_check_smoke.csv\ --summary-json\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_aprilgrid_depth_check_smoke_summary.json\ --debug-png\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_aprilgrid_depth_check_smoke.png 
```

- **Config path:** /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_aprilgrid_depth_check.py
- **Important config values:** family=tag36h11 tag_rows=6 tag_cols=6 tag_size=0.088m tag_spacing=0.0264m min_tags=2 frames=30 timeout=25s

## Variables

- **Independent variables:** needs verification
- **Controlled variables:** needs verification
- **Ablations:** needs verification

## Dataset / Split

- **Dataset:** live Orbbec color/depth streams plus /da2/depth_raw with board in front of camera
- **Split:** needs verification
- **Preprocessing:** needs verification
- **Known caveats:** hardware-depth ROI is approximate unless color-aligned; first run is detector smoke test

## Metrics

- **Primary metrics:** detected tag count, solvePnP reprojection RMS, pose_z, DA2/pose_z, hardware-depth/pose_z within 2.5m
- **Secondary metrics:** needs verification
- **Qualitative checks:** needs verification

## Results

- **Fact:** The command exited with code `124`.
- **Observation:** Raw command output is saved at [command.log](../raw/experiments/2026-05-06_23-17-13_live-aprilgrid-da2-scale-smoke-test/command.log).
- **Artifact paths:** [raw experiment directory](../raw/experiments/2026-05-06_23-17-13_live-aprilgrid-da2-scale-smoke-test/)
- **Result validity:** needs verification: mark valid, invalid, tentative, or superseded.

## Interpretation

- **Interpretation:** pending log review after live AprilGrid detector run
- **Speculation:** tentative
- **Hypothesis update:** unresolved
- **Reasoning:** needs verification: explain why the result should or should not affect calibration/navigation decisions.

## Finding Updates

- No finding update recorded yet. Update [[Findings]] / [../findings.md](../findings.md) after reviewing the result.

## Failure Notes

Command failed. Review [command.log](../raw/experiments/2026-05-06_23-17-13_live-aprilgrid-da2-scale-smoke-test/command.log) before interpreting the result.

## Follow-up

- If tags are detected, repeat with min_tags>=4 and more frames; if not, adjust board pose/lighting/family.
- Update [[Findings]] / [../findings.md](../findings.md) with a link to this note.
- Update [[Open Questions]] / [../open_questions.md](../open_questions.md) and [[Next Steps]] / [../next_steps.md](../next_steps.md).
- If the experiment produced invalid results, preserve the note and mark the invalidation reason.

## Links

- [[Context]] / [../context.md](../context.md)
- [[Hypotheses]] / [../hypotheses.md](../hypotheses.md)
- [[Findings]] / [../findings.md](../findings.md)
- [[Open Questions]] / [../open_questions.md](../open_questions.md)
- [[Next Steps]] / [../next_steps.md](../next_steps.md)

