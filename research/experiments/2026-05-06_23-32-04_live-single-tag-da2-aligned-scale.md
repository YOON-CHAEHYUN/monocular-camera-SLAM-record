# Live single-tag DA2-aligned scale

## Date

2026-05-06

## Title

Live single-tag DA2-aligned scale

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

The prior single-tag pose was geometrically valid but sampled DA2 with an unrotated RGB mask; rerun after rotating the DA2 mask to match /da2/depth_raw coordinates.

## Research Question

After DA2 ROI alignment, what DA2/single-tag-pose scale ratio is observed?

## Hypothesis

Rotating the DA2 sampling mask will remove the false 5m board reading and produce a more plausible DA2/pose_z ratio.

## Setup

- **Run directory:** `/home/jetson/colcon_ws`
- **Start time:** 2026-05-06T23:32:04+09:00
- **End time:** 2026-05-06T23:32:19+09:00
- **Exit code:** 0
- **Code commit hash:** needs verification

## Command / Config

```bash
bash -lc source\ /opt/ros/humble/setup.bash\ \&\&\ source\ /home/jetson/colcon_ws/install/setup.bash\ \&\&\ timeout\ 40s\ python3\ /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_aprilgrid_depth_check.py\ --family\ tag16h5\ --layout\ single_tags\ --max-hamming\ 2\ --preprocess\ clahe\ --margin-min\ 20\ --frames\ 40\ --min-tags\ 6\ --max-single-tag-reproj-rms\ 4.0\ --rotate-da2-mask\ --output-csv\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale.csv\ --summary-json\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_summary.json\ --debug-png\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale.png 
```

- **Config path:** /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_aprilgrid_depth_check.py
- **Important config values:** family=tag16h5 layout=single_tags preprocess=clahe max_hamming=2 margin_min=20 rotate_da2_mask=true min_tags=6 frames=40 tag_size=0.088m

## Variables

- **Independent variables:** needs verification
- **Controlled variables:** needs verification
- **Ablations:** needs verification

## Dataset / Split

- **Dataset:** live Orbbec color stream and /da2/depth_raw with AprilGrid board in front of camera
- **Split:** needs verification
- **Preprocessing:** needs verification
- **Known caveats:** hardware depth remains approximate unless color-aligned; DA2 result depends on tag black-square size being 0.088m

## Metrics

- **Primary metrics:** valid frame count, single-tag reprojection RMS, pose_z median, DA2 median, DA2/pose_z median, nominal scale
- **Secondary metrics:** needs verification
- **Qualitative checks:** needs verification

## Results

- **Fact:** The command exited with code `0`.
- **Observation:** Raw command output is saved at [command.log](../raw/experiments/2026-05-06_23-32-04_live-single-tag-da2-aligned-scale/command.log).
- **Artifact paths:** [raw experiment directory](../raw/experiments/2026-05-06_23-32-04_live-single-tag-da2-aligned-scale/)
- **Observation:** 40 valid frames were collected.
- **Observation:** Median single-tag reprojection RMS was `0.075 px`.
- **Observation:** Median pose_z was `1.143 m`.
- **Observation:** DA2 sampled median was `0.839 m` after rotating the DA2 mask
  to match `/da2/depth_raw`.
- **Observation:** Median `DA2/pose_z` was `0.734x`, implying nominal local DA2
  scale `1.36`.
- **Observation:** Hardware-depth sampled median was `0.312 m`, still
  inconsistent with the RGB pose.
- **Artifact paths:**
  `/home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale.csv`,
  `/home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_summary.json`,
  `/home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale.png`.
- **Result validity:** pose valid; DA2 scale tentative; hardware-depth ROI
  invalid or unresolved.

## Interpretation

- **Interpretation:** Rotating the DA2 sampling mask fixed the prior wrong-ROI
  failure. At this board position, DA2 is shorter than the geometric pose
  distance (`0.839 m` vs `1.143 m`), implying a local scale around `1.36`.
- **Speculation:** tentative
- **Hypothesis update:** unresolved
- **Reasoning:** The pose estimate has very low reprojection RMS and stable
  pose_z, so the RGB geometry is usable. The DA2 value is now sampled from the
  rotated DA2 coordinate system. However, the result conflicts with previous
  hardware-depth and LiDAR-derived checks, so it should not be applied as a
  global correction until repeated at another board distance and validated in
  BEV/LiDAR map space.

## Finding Updates

- No finding update recorded yet. Update [[Findings]] / [../findings.md](../findings.md) after reviewing the result.

## Failure Notes

No failure recorded by the runner. Review logs for warnings.

## Follow-up

- Repeat at a second board distance before changing DA2 params.
- Verify hardware-depth color alignment separately; current hardware ROI values
  are not physically consistent with the RGB pose.
- Compare any accepted single-tag scale candidate against BEV/LiDAR map scale.
- Update [[Findings]] / [../findings.md](../findings.md) with a link to this note.
- Update [[Open Questions]] / [../open_questions.md](../open_questions.md) and [[Next Steps]] / [../next_steps.md](../next_steps.md).
- If the experiment produced invalid results, preserve the note and mark the invalidation reason.

## Links

- [[Context]] / [../context.md](../context.md)
- [[Hypotheses]] / [../hypotheses.md](../hypotheses.md)
- [[Findings]] / [../findings.md](../findings.md)
- [[Open Questions]] / [../open_questions.md](../open_questions.md)
- [[Next Steps]] / [../next_steps.md](../next_steps.md)
