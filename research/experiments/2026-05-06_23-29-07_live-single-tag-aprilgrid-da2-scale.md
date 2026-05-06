# Live single-tag AprilGrid DA2 scale

## Date

2026-05-06

## Title

Live single-tag AprilGrid DA2 scale

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

Full-grid AprilGrid pose remained high-RMS, so use each detected 8.8cm tag as an independent square pose reference and take median pose_z for DA2 scale.

## Research Question

What DA2/pose_z scale is observed when pose_z is estimated from independent tag16h5 square markers?

## Hypothesis

Single-tag square pose will avoid grid ID/layout ambiguity and provide a lower-risk near-range scale reference.

## Setup

- **Run directory:** `/home/jetson/colcon_ws`
- **Start time:** 2026-05-06T23:29:07+09:00
- **End time:** 2026-05-06T23:29:20+09:00
- **Exit code:** 0
- **Code commit hash:** needs verification

## Command / Config

```bash
bash -lc source\ /opt/ros/humble/setup.bash\ \&\&\ source\ /home/jetson/colcon_ws/install/setup.bash\ \&\&\ timeout\ 40s\ python3\ /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_aprilgrid_depth_check.py\ --family\ tag16h5\ --layout\ single_tags\ --max-hamming\ 2\ --preprocess\ clahe\ --margin-min\ 20\ --frames\ 40\ --min-tags\ 6\ --max-single-tag-reproj-rms\ 4.0\ --output-csv\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_aprilgrid_scale.csv\ --summary-json\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_aprilgrid_scale_summary.json\ --debug-png\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_aprilgrid_scale.png 
```

- **Config path:** /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_aprilgrid_depth_check.py
- **Important config values:** family=tag16h5 layout=single_tags preprocess=clahe max_hamming=2 margin_min=20 min_tags=6 frames=40 tag_size=0.088m max_single_tag_reproj_rms=4px

## Variables

- **Independent variables:** needs verification
- **Controlled variables:** needs verification
- **Ablations:** needs verification

## Dataset / Split

- **Dataset:** live Orbbec color/depth streams and /da2/depth_raw with AprilGrid board in front of camera
- **Split:** needs verification
- **Preprocessing:** needs verification
- **Known caveats:** single-tag pose uses tag black square size only; hamming=2 detections are accepted only if per-tag reprojection RMS passes

## Metrics

- **Primary metrics:** valid frame count, valid single-tag pose count, median single-tag reprojection RMS, median pose_z, DA2/pose_z median, hardware-depth/pose_z within 2.5m
- **Secondary metrics:** needs verification
- **Qualitative checks:** needs verification

## Results

- **Fact:** The command exited with code `0`.
- **Observation:** Raw command output is saved at [command.log](../raw/experiments/2026-05-06_23-29-07_live-single-tag-aprilgrid-da2-scale/command.log).
- **Artifact paths:** [raw experiment directory](../raw/experiments/2026-05-06_23-29-07_live-single-tag-aprilgrid-da2-scale/)
- **Observation:** 40 valid frames were collected.
- **Observation:** Median single-tag reprojection RMS was `0.076 px`.
- **Observation:** Median pose_z was `1.144 m`.
- **Observation:** DA2 sampled median was `5.123 m`, giving nominal
  `DA2/pose_z = 4.490x` and scale `0.223`.
- **Observation:** Hardware-depth sampled median was `0.413 m`, giving nominal
  `HW/pose_z = 0.361x`.
- **Artifact paths:**
  `/home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_aprilgrid_scale.csv`,
  `/home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_aprilgrid_scale_summary.json`,
  `/home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_aprilgrid_scale.png`.
- **Result validity:** pose estimate valid; sampled DA2/HW scale values invalid
  until ROI alignment is corrected.

## Interpretation

 - **Interpretation:** The single-tag geometric pose is reliable enough to use
  as a reference because RMS is below 0.1 px and pose_z is stable. The DA2 and
  hardware-depth sampled values are not reliable scale estimates yet.
- **Speculation:** tentative
- **Hypothesis update:** unresolved
- **Reasoning:** `da2_occupancy_node.py` rotates RGB by 180 degrees before DA2
  inference and publishes `/da2/depth_raw` in that rotated coordinate system.
  The checker sampled DA2 using an unrotated RGB tag mask, so the 5.1 m DA2
  median likely comes from the wrong image region. Hardware depth is also not
  confirmed color-aligned, and its 0.31-0.42 m values contradict the 1.14 m
  pose.

## Finding Updates

- No finding update recorded yet. Update [[Findings]] / [../findings.md](../findings.md) after reviewing the result.

## Failure Notes

No failure recorded by the runner. Review logs for warnings.

## Follow-up

- Rotate the DA2 sampling mask by 180 degrees before indexing `/da2/depth_raw`.
- Verify or replace hardware-depth sampling with a color-aligned depth topic.
- Re-run single-tag pose-vs-DA2 scale after ROI alignment is fixed.
- Update [[Findings]] / [../findings.md](../findings.md) with a link to this note.
- Update [[Open Questions]] / [../open_questions.md](../open_questions.md) and [[Next Steps]] / [../next_steps.md](../next_steps.md).
- If the experiment produced invalid results, preserve the note and mark the invalidation reason.

## Links

- [[Context]] / [../context.md](../context.md)
- [[Hypotheses]] / [../hypotheses.md](../hypotheses.md)
- [[Findings]] / [../findings.md](../findings.md)
- [[Open Questions]] / [../open_questions.md](../open_questions.md)
- [[Next Steps]] / [../next_steps.md](../next_steps.md)
