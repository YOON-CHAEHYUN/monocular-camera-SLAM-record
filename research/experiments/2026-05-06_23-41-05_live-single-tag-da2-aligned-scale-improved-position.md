# Live single-tag DA2-aligned scale improved position

## Date

2026-05-06

## Title

Live single-tag DA2-aligned scale improved position

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

The board was moved to a recommended position after the previous repeat had only 3 valid frames; rerun DA2-aligned single-tag scale measurement to obtain a more reliable sample count.

## Research Question

Does the new board position produce enough valid single-tag pose samples, and what DA2/pose_z ratio is observed?

## Hypothesis

A centered board at a less extreme distance will increase valid tag count while preserving low RMS; the resulting DA2/pose_z ratio will clarify distance/framing dependence.

## Setup

- **Run directory:** `/home/jetson/colcon_ws`
- **Start time:** 2026-05-06T23:41:05+09:00
- **End time:** 2026-05-06T23:41:24+09:00
- **Exit code:** 0
- **Code commit hash:** needs verification

## Command / Config

```bash
bash -lc source\ /opt/ros/humble/setup.bash\ \&\&\ source\ /home/jetson/colcon_ws/install/setup.bash\ \&\&\ timeout\ 40s\ python3\ /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_aprilgrid_depth_check.py\ --family\ tag16h5\ --layout\ single_tags\ --max-hamming\ 2\ --preprocess\ clahe\ --margin-min\ 20\ --frames\ 40\ --min-tags\ 6\ --max-single-tag-reproj-rms\ 4.0\ --rotate-da2-mask\ --output-csv\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_improved.csv\ --summary-json\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_improved_summary.json\ --debug-png\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_improved.png 
```

- **Config path:** /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_aprilgrid_depth_check.py
- **Important config values:** family=tag16h5 layout=single_tags preprocess=clahe max_hamming=2 margin_min=20 rotate_da2_mask=true min_tags=6 frames=40 tag_size=0.088m

## Variables

- **Independent variables:** needs verification
- **Controlled variables:** needs verification
- **Ablations:** needs verification

## Dataset / Split

- **Dataset:** live Orbbec color stream and /da2/depth_raw after moving board to improved position
- **Split:** needs verification
- **Preprocessing:** needs verification
- **Known caveats:** hardware depth remains approximate unless color-aligned; result should be compared to previous 1.143m and 0.701m board poses

## Metrics

- **Primary metrics:** valid frame count, tag_count median, single-tag reprojection RMS, pose_z median and p10/p90, DA2 median, DA2/pose_z median, nominal local scale
- **Secondary metrics:** needs verification
- **Qualitative checks:** needs verification

## Results

- **Fact:** The command exited with code `0`.
- **Observation:** Raw command output is saved at [command.log](../raw/experiments/2026-05-06_23-41-05_live-single-tag-da2-aligned-scale-improved-position/command.log).
- **Artifact paths:** [raw experiment directory](../raw/experiments/2026-05-06_23-41-05_live-single-tag-da2-aligned-scale-improved-position/)
- **Observation:** 40 valid samples were collected.
- **Observation:** Median tag count was `7`; p10-p90 was `6-9`.
- **Observation:** Median single-tag reprojection RMS was `0.082 px`;
  p10-p90 was `0.060-0.910 px`.
- **Observation:** Median pose_z was `1.705 m`; p10-p90 was
  `1.598-1.710 m`.
- **Observation:** Median DA2 sampled depth was `1.729 m`.
- **Observation:** Median `DA2/pose_z` was `1.032x`; p10-p90 was
  `0.963-1.137x`.
- **Observation:** Nominal local DA2 scale from pose_z was `0.969`.
- **Artifact paths:**
  `/home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_improved.csv`,
  `/home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_improved_summary.json`,
  `/home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_improved.png`.
- **Result validity:** valid as a board-position scale observation. Hardware
  depth remains invalid/tentative because the sampled hardware value is not
  physically consistent with RGB pose.

## Interpretation

- **Interpretation:** The improved board position produced enough samples and
  DA2 closely matched the single-tag geometric pose at this range. This is the
  strongest live board result so far.
- **Speculation:** tentative
- **Hypothesis update:** weakened for a large fixed DA2 scale correction. The
  improved-position run supports little or no local scale correction around
  `1.7 m`, while closer/poorer-framed board runs showed different ratios.
- **Reasoning:** Because the pose RMS is low and sample count is sufficient, the
  result is useful. The spread across previous board placements still argues
  against directly applying a global DA2 scale without BEV/LiDAR validation.

## Finding Updates

- No finding update recorded yet. Update [[Findings]] / [../findings.md](../findings.md) after reviewing the result.

## Failure Notes

No hard failure. Some frames still had insufficient valid tags, but 40 accepted
samples were collected.

## Follow-up

- Treat this as the preferred live board measurement so far.
- Before changing DA2 runtime scale, validate against BEV/LiDAR map alignment.
- If another board check is run, place the board near this framing and vary only
  distance deliberately.
- Update [[Findings]] / [../findings.md](../findings.md) with a link to this note.
- Update [[Open Questions]] / [../open_questions.md](../open_questions.md) and [[Next Steps]] / [../next_steps.md](../next_steps.md).
- If the experiment produced invalid results, preserve the note and mark the invalidation reason.

## Links

- [[Context]] / [../context.md](../context.md)
- [[Hypotheses]] / [../hypotheses.md](../hypotheses.md)
- [[Findings]] / [../findings.md](../findings.md)
- [[Open Questions]] / [../open_questions.md](../open_questions.md)
- [[Next Steps]] / [../next_steps.md](../next_steps.md)
