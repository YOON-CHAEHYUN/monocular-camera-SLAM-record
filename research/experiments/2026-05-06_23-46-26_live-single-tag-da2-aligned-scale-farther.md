# Live single-tag DA2-aligned scale farther

## Date

2026-05-06

## Title

Live single-tag DA2-aligned scale farther

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

The board was moved farther away to test whether DA2/pose_z changes nonlinearly with target distance under the same single-tag measurement method.

## Research Question

At the farther board distance, what DA2/pose_z ratio is observed, and does it continue the distance-dependent pattern?

## Hypothesis

If DA2 scale is distance-dependent, the farther position will produce a different DA2/pose_z ratio from the 1.70m improved-position result.

## Setup

- **Run directory:** `/home/jetson/colcon_ws`
- **Start time:** 2026-05-06T23:46:26+09:00
- **End time:** 2026-05-06T23:47:07+09:00
- **Exit code:** 124
- **Code commit hash:** needs verification

## Command / Config

```bash
bash -lc source\ /opt/ros/humble/setup.bash\ \&\&\ source\ /home/jetson/colcon_ws/install/setup.bash\ \&\&\ timeout\ 40s\ python3\ /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_aprilgrid_depth_check.py\ --family\ tag16h5\ --layout\ single_tags\ --max-hamming\ 2\ --preprocess\ clahe\ --margin-min\ 20\ --frames\ 40\ --min-tags\ 6\ --max-single-tag-reproj-rms\ 4.0\ --rotate-da2-mask\ --output-csv\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_farther.csv\ --summary-json\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_farther_summary.json\ --debug-png\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_farther.png 
```

- **Config path:** /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_aprilgrid_depth_check.py
- **Important config values:** family=tag16h5 layout=single_tags preprocess=clahe max_hamming=2 margin_min=20 rotate_da2_mask=true min_tags=6 frames=40 tag_size=0.088m farther board position

## Variables

- **Independent variables:** needs verification
- **Controlled variables:** needs verification
- **Ablations:** needs verification

## Dataset / Split

- **Dataset:** live Orbbec color stream and /da2/depth_raw after moving board farther away
- **Split:** needs verification
- **Preprocessing:** needs verification
- **Known caveats:** hardware depth remains approximate unless color-aligned; compare only against previous DA2-aligned single-tag board measurements

## Metrics

- **Primary metrics:** valid frame count, tag_count median, single-tag reprojection RMS, pose_z median and p10/p90, DA2 median, DA2/pose_z median, nominal local scale
- **Secondary metrics:** needs verification
- **Qualitative checks:** needs verification

## Results

- **Fact:** The command exited with code `124`.
- **Observation:** Raw command output is saved at [command.log](../raw/experiments/2026-05-06_23-46-26_live-single-tag-da2-aligned-scale-farther/command.log).
- **Artifact paths:** [raw experiment directory](../raw/experiments/2026-05-06_23-46-26_live-single-tag-da2-aligned-scale-farther/)
- **Observation:** 12 valid samples were collected before timeout.
- **Observation:** Median tag count was `7`; p10-p90 was `6-8`.
- **Observation:** Median single-tag reprojection RMS was `0.148 px`;
  p10-p90 was `0.108-0.432 px`.
- **Observation:** Median pose_z was `3.229 m`; p10-p90 was
  `3.185-3.244 m`.
- **Observation:** Median DA2 sampled depth was `1.857 m`.
- **Observation:** Median `DA2/pose_z` was `0.584x`; p10-p90 was
  `0.566-0.631x`.
- **Observation:** Nominal local DA2 scale from pose_z was `1.712`.
- **Artifact paths:**
  `/home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_farther.csv`,
  `/home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_farther_summary.json`,
  `/home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_single_tag_da2_aligned_scale_farther.png`.
- **Result validity:** tentative. Pose quality is acceptable, but the sample
  count is lower than the preferred 40 samples and DA2 ROI sometimes had too few
  valid pixels.

## Interpretation

- **Interpretation:** At the farther board position around `3.23 m`, DA2 depth
  is much shorter than the geometric pose distance. This differs from the
  improved `1.70 m` result, where DA2 was close to pose.
- **Speculation:** tentative
- **Hypothesis update:** strengthened. The distance sweep now shows strong
  distance dependence rather than a stable global scale.
- **Reasoning:** The accepted poses have low RMS and stable pose_z, so the
  trend is meaningful. Because the target is small at this distance and only 12
  samples were collected, the exact `1.71` scale should be treated as tentative.

## Finding Updates

- No finding update recorded yet. Update [[Findings]] / [../findings.md](../findings.md) after reviewing the result.

## Failure Notes

The command timed out before collecting 40 frames. Several frames had
insufficient tags or too few valid DA2 pixels. The saved 12-sample result is a
tentative distance-sweep point, not a final calibration value.

## Follow-up

- Add this point to the distance sweep table as tentative.
- For another far-distance run, reduce `--min-tags` to 4 or enlarge/improve
  board visibility, but keep RMS checks strict.
- Do not apply a global scale from this point alone; validate any candidate
  correction against BEV/LiDAR map alignment.
- Update [[Findings]] / [../findings.md](../findings.md) with a link to this note.
- Update [[Open Questions]] / [../open_questions.md](../open_questions.md) and [[Next Steps]] / [../next_steps.md](../next_steps.md).
- If the experiment produced invalid results, preserve the note and mark the invalidation reason.

## Links

- [[Context]] / [../context.md](../context.md)
- [[Hypotheses]] / [../hypotheses.md](../hypotheses.md)
- [[Findings]] / [../findings.md](../findings.md)
- [[Open Questions]] / [../open_questions.md](../open_questions.md)
- [[Next Steps]] / [../next_steps.md](../next_steps.md)
