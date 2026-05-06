# Live AprilGrid image-grid DA2 scale

## Date

2026-05-06

## Title

Live AprilGrid image-grid DA2 scale

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

The previous tag16h5 solvePnP run failed because row-major tag ID layout caused invalid reprojection RMS; retry using image-grid-inferred tag slots so scale depends on physical tag size and spacing, not tag IDs.

## Research Question

Can image-grid AprilGrid correspondences produce a valid low-RMS pose and DA2/pose_z scale estimate?

## Hypothesis

Ignoring tag IDs and fitting the detected tag lattice will produce acceptable reprojection RMS if the board is planar and dimensions are correct.

## Setup

- **Run directory:** `/home/jetson/colcon_ws`
- **Start time:** 2026-05-06T23:24:29+09:00
- **End time:** 2026-05-06T23:25:10+09:00
- **Exit code:** 124
- **Code commit hash:** needs verification

## Command / Config

```bash
bash -lc source\ /opt/ros/humble/setup.bash\ \&\&\ source\ /home/jetson/colcon_ws/install/setup.bash\ \&\&\ timeout\ 40s\ python3\ /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_aprilgrid_depth_check.py\ --family\ tag16h5\ --layout\ image_grid\ --max-hamming\ 2\ --preprocess\ clahe\ --margin-min\ 20\ --frames\ 40\ --min-tags\ 6\ --max-reproj-rms\ 6.0\ --output-csv\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_aprilgrid_image_grid_scale.csv\ --summary-json\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_aprilgrid_image_grid_scale_summary.json\ --debug-png\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_aprilgrid_image_grid_scale.png 
```

- **Config path:** /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_aprilgrid_depth_check.py
- **Important config values:** family=tag16h5 layout=image_grid preprocess=clahe max_hamming=2 margin_min=20 min_tags=6 frames=40 max_reproj_rms=6px tag_size=0.088m spacing=0.0264m

## Variables

- **Independent variables:** needs verification
- **Controlled variables:** needs verification
- **Ablations:** needs verification

## Dataset / Split

- **Dataset:** live Orbbec color/depth streams and /da2/depth_raw with AprilGrid board in front of camera
- **Split:** needs verification
- **Preprocessing:** needs verification
- **Known caveats:** image-grid layout assumes the visible tag lattice is locally row/column sorted; absolute board origin can shift but pose_z scale should remain valid

## Metrics

- **Primary metrics:** valid frame count, tag count, reprojection RMS, pose_z median, DA2/pose_z median, hardware-depth/pose_z within 2.5m
- **Secondary metrics:** needs verification
- **Qualitative checks:** needs verification

## Results

- **Fact:** The command exited with code `124`.
- **Observation:** Raw command output is saved at [command.log](../raw/experiments/2026-05-06_23-24-29_live-aprilgrid-image-grid-da2-scale/command.log).
- **Artifact paths:** [raw experiment directory](../raw/experiments/2026-05-06_23-24-29_live-aprilgrid-image-grid-da2-scale/)
- **Result validity:** needs verification: mark valid, invalid, tentative, or superseded.

## Interpretation

- **Interpretation:** pending review of image-grid pose RMS and scale summary
- **Speculation:** tentative
- **Hypothesis update:** unresolved
- **Reasoning:** needs verification: explain why the result should or should not affect calibration/navigation decisions.

## Finding Updates

- No finding update recorded yet. Update [[Findings]] / [../findings.md](../findings.md) after reviewing the result.

## Failure Notes

Command failed. Review [command.log](../raw/experiments/2026-05-06_23-24-29_live-aprilgrid-image-grid-da2-scale/command.log) before interpreting the result.

## Follow-up

- If valid, repeat at a second distance; if invalid, use a normal chessboard or generate the exact tag ID layout.
- Update [[Findings]] / [../findings.md](../findings.md) with a link to this note.
- Update [[Open Questions]] / [../open_questions.md](../open_questions.md) and [[Next Steps]] / [../next_steps.md](../next_steps.md).
- If the experiment produced invalid results, preserve the note and mark the invalidation reason.

## Links

- [[Context]] / [../context.md](../context.md)
- [[Hypotheses]] / [../hypotheses.md](../hypotheses.md)
- [[Findings]] / [../findings.md](../findings.md)
- [[Open Questions]] / [../open_questions.md](../open_questions.md)
- [[Next Steps]] / [../next_steps.md](../next_steps.md)

