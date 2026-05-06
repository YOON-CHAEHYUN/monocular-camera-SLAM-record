# Live single-tag DA2-aligned scale repeat

## Date

2026-05-06

## Title

Live single-tag DA2-aligned scale repeat

## Status

tentative

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

The board was repositioned to improve visibility; repeat the DA2-aligned single-tag AprilGrid scale measurement to see whether the local scale estimate is stable.

## Research Question

After improving board visibility/position, what DA2/single-tag-pose scale ratio is observed and how does it compare to the previous 0.734x ratio?

## Hypothesis

Better board visibility will keep reprojection RMS low and may reduce variance in DA2/pose_z; if the ratio changes strongly with distance/pose, DA2 scale is not a single global factor.

## Setup

- **Run directory:** `/home/jetson/colcon_ws`
- **Start time:** 2026-05-06T23:35:14+09:00
- **End time:** 2026-05-06T23:35:55+09:00
- **Exit code:** 124
- **Code commit hash:** needs verification

## Command / Config

```bash
bash -lc source\ /opt/ros/humble/setup.bash\ \&\&\ source\ /home/jetson/colcon_ws/install/setup.bash\ \&\&\ timeout\ 40s\ python3\ /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_aprilgrid_depth_check.py\ --family\ tag16h5\ --layout\ single_tags\ --max-hamming\ 2\ --preprocess\ clahe\ --margin-min\ 20\ --frames\ 40\ --min-tags\ 6\ --max-single-tag-reproj-rms\ 4.0\ --rotate-da2-mask\ --output-csv\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_repeat.csv\ --summary-json\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_repeat_summary.json\ --debug-png\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_repeat.png 
```

- **Config path:** /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_aprilgrid_depth_check.py
- **Important config values:** family=tag16h5 layout=single_tags preprocess=clahe max_hamming=2 margin_min=20 rotate_da2_mask=true min_tags=6 frames=40 tag_size=0.088m

## Variables

- **Independent variables:** needs verification
- **Controlled variables:** needs verification
- **Ablations:** needs verification

## Dataset / Split

- **Dataset:** live Orbbec color stream and /da2/depth_raw after board repositioning
- **Split:** needs verification
- **Preprocessing:** needs verification
- **Known caveats:** hardware depth remains approximate unless color-aligned; DA2 result depends on tag black-square size being 0.088m

## Metrics

- **Primary metrics:** valid frame count, single-tag reprojection RMS, pose_z median, DA2 median, DA2/pose_z median, nominal scale, hardware-depth reference only
- **Secondary metrics:** needs verification
- **Qualitative checks:** needs verification

## Results

- **Fact:** The command exited with code `124`.
- **Observation:** Raw command output is saved at [command.log](../raw/experiments/2026-05-06_23-35-14_live-single-tag-da2-aligned-scale-repeat/command.log).
- **Artifact paths:** [raw experiment directory](../raw/experiments/2026-05-06_23-35-14_live-single-tag-da2-aligned-scale-repeat/)
- **Observation:** Only 3 valid frames were collected before timeout because most
  frames had fewer than 6 valid tag poses after filtering.
- **Observation:** Median single-tag reprojection RMS was `0.071 px`, so the
  accepted tag poses are geometrically consistent.
- **Observation:** Median pose_z was `0.701 m`.
- **Observation:** Median DA2 sampled depth was `0.935 m`, giving
  `DA2/pose_z = 1.334x` and nominal local scale `0.749`.
- **Observation:** Median hardware-depth sampled value was `0.310 m`; this is
  still not physically consistent with the RGB pose.
- **Artifact paths:**
  `/home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_repeat.csv`,
  `/home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_repeat_summary.json`,
  `/home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_repeat.png`.
- **Result validity:** tentative. Pose quality is good for accepted frames, but
  the sample count is too low for final calibration.

## Interpretation

- **Interpretation:** The repositioned board produced a different local
  DA2/pose ratio than the previous pose (`1.334x` at `0.701 m` vs `0.734x` at
  `1.143 m`). This strongly suggests the DA2 scale behavior is dependent on
  range/target/framing or that residual ROI/model assumptions remain.
- **Speculation:** tentative
- **Hypothesis update:** strengthened. A single global depth scale is not
  supported by the two board-position checks.
- **Reasoning:** The accepted tag poses have very low RMS, but only three frames
  passed the filter. The value is useful as a warning against global scaling,
  not as a final parameter.

## Finding Updates

- No finding update recorded yet. Update [[Findings]] / [../findings.md](../findings.md) after reviewing the result.

## Failure Notes

The command timed out before collecting 40 frames. This is not a hard sensor
failure because the script saved 3 valid samples, but the low sample count makes
the result tentative.

## Follow-up

- Do not change DA2 runtime scale from this 3-frame result.
- For the next board run, reduce `--min-tags` to 3 or improve lighting/framing
  so enough frames pass while preserving low reprojection RMS.
- Compare accepted board-scale candidates against BEV/LiDAR map alignment
  before changing DA2 params.
- Update [[Findings]] / [../findings.md](../findings.md) with a link to this note.
- Update [[Open Questions]] / [../open_questions.md](../open_questions.md) and [[Next Steps]] / [../next_steps.md](../next_steps.md).
- If the experiment produced invalid results, preserve the note and mark the invalidation reason.

## Links

- [[Context]] / [../context.md](../context.md)
- [[Hypotheses]] / [../hypotheses.md](../hypotheses.md)
- [[Findings]] / [../findings.md](../findings.md)
- [[Open Questions]] / [../open_questions.md](../open_questions.md)
- [[Next Steps]] / [../next_steps.md](../next_steps.md)
