# Live single-tag DA2-aligned scale farther

## Date

2026-05-06

## Title

Live single-tag DA2-aligned scale farther

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
- **Result validity:** needs verification: mark valid, invalid, tentative, or superseded.

## Interpretation

- **Interpretation:** pending review of farther-distance DA2-aligned single-tag scale summary
- **Speculation:** tentative
- **Hypothesis update:** unresolved
- **Reasoning:** needs verification: explain why the result should or should not affect calibration/navigation decisions.

## Finding Updates

- No finding update recorded yet. Update [[Findings]] / [../findings.md](../findings.md) after reviewing the result.

## Failure Notes

Command failed. Review [command.log](../raw/experiments/2026-05-06_23-46-26_live-single-tag-da2-aligned-scale-farther/command.log) before interpreting the result.

## Follow-up

- Add this point to the distance sweep table and decide whether another planned distance is needed.
- Update [[Findings]] / [../findings.md](../findings.md) with a link to this note.
- Update [[Open Questions]] / [../open_questions.md](../open_questions.md) and [[Next Steps]] / [../next_steps.md](../next_steps.md).
- If the experiment produced invalid results, preserve the note and mark the invalidation reason.

## Links

- [[Context]] / [../context.md](../context.md)
- [[Hypotheses]] / [../hypotheses.md](../hypotheses.md)
- [[Findings]] / [../findings.md](../findings.md)
- [[Open Questions]] / [../open_questions.md](../open_questions.md)
- [[Next Steps]] / [../next_steps.md](../next_steps.md)

