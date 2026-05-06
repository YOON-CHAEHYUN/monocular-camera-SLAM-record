# Live AprilGrid orientation-invariant DA2 scale

## Date

2026-05-06

## Title

Live AprilGrid orientation-invariant DA2 scale

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

The image-grid run still had high reprojection RMS because only one grid orientation was tested; retry with all eight grid orientation variants and select the lowest-RMS pose.

## Research Question

Does orientation-invariant image-grid fitting produce a valid AprilGrid pose and DA2 scale estimate?

## Hypothesis

Trying all row/column flip and transpose variants will remove the grid-orientation ambiguity and reduce reprojection RMS below the validity threshold.

## Setup

- **Run directory:** `/home/jetson/colcon_ws`
- **Start time:** 2026-05-06T23:26:24+09:00
- **End time:** 2026-05-06T23:27:06+09:00
- **Exit code:** 124
- **Code commit hash:** needs verification

## Command / Config

```bash
bash -lc source\ /opt/ros/humble/setup.bash\ \&\&\ source\ /home/jetson/colcon_ws/install/setup.bash\ \&\&\ timeout\ 40s\ python3\ /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_aprilgrid_depth_check.py\ --family\ tag16h5\ --layout\ image_grid\ --max-hamming\ 2\ --preprocess\ clahe\ --margin-min\ 20\ --frames\ 40\ --min-tags\ 6\ --max-reproj-rms\ 6.0\ --output-csv\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_aprilgrid_orientation_scale.csv\ --summary-json\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_aprilgrid_orientation_scale_summary.json\ --debug-png\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_aprilgrid_orientation_scale.png 
```

- **Config path:** /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_aprilgrid_depth_check.py
- **Important config values:** family=tag16h5 layout=image_grid with 8 orientation variants preprocess=clahe max_hamming=2 margin_min=20 min_tags=6 frames=40 max_reproj_rms=6px

## Variables

- **Independent variables:** needs verification
- **Controlled variables:** needs verification
- **Ablations:** needs verification

## Dataset / Split

- **Dataset:** live Orbbec color/depth streams and /da2/depth_raw with AprilGrid board in front of camera
- **Split:** needs verification
- **Preprocessing:** needs verification
- **Known caveats:** still depends on AprilTag detections from max_hamming=2; reject if RMS remains high

## Metrics

- **Primary metrics:** valid frame count, selected layout variant, tag count, reprojection RMS, pose_z median, DA2/pose_z median, hardware-depth/pose_z within 2.5m
- **Secondary metrics:** needs verification
- **Qualitative checks:** needs verification

## Results

- **Fact:** The command exited with code `124`.
- **Observation:** Raw command output is saved at [command.log](../raw/experiments/2026-05-06_23-26-24_live-aprilgrid-orientation-invariant-da2-scale/command.log).
- **Artifact paths:** [raw experiment directory](../raw/experiments/2026-05-06_23-26-24_live-aprilgrid-orientation-invariant-da2-scale/)
- **Result validity:** needs verification: mark valid, invalid, tentative, or superseded.

## Interpretation

- **Interpretation:** pending review of orientation-invariant scale summary
- **Speculation:** tentative
- **Hypothesis update:** unresolved
- **Reasoning:** needs verification: explain why the result should or should not affect calibration/navigation decisions.

## Finding Updates

- No finding update recorded yet. Update [[Findings]] / [../findings.md](../findings.md) after reviewing the result.

## Failure Notes

Command failed. Review [command.log](../raw/experiments/2026-05-06_23-26-24_live-aprilgrid-orientation-invariant-da2-scale/command.log) before interpreting the result.

## Follow-up

- If valid, use the DA2/pose ratio as a near-range scale candidate and repeat at another distance.
- Update [[Findings]] / [../findings.md](../findings.md) with a link to this note.
- Update [[Open Questions]] / [../open_questions.md](../open_questions.md) and [[Next Steps]] / [../next_steps.md](../next_steps.md).
- If the experiment produced invalid results, preserve the note and mark the invalidation reason.

## Links

- [[Context]] / [../context.md](../context.md)
- [[Hypotheses]] / [../hypotheses.md](../hypotheses.md)
- [[Findings]] / [../findings.md](../findings.md)
- [[Open Questions]] / [../open_questions.md](../open_questions.md)
- [[Next Steps]] / [../next_steps.md](../next_steps.md)

