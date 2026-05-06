# Live AprilTag DA2 projection check

## Date

2026-05-07

## Title

Live AprilTag DA2 projection check

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

Point-depth checks show distance-dependent DA2/pose ratios while mapping can look large; verify whether DA2 depth projected through runtime rays lands at the expected base_link x/y from AprilTag pose.

## Research Question

In the same live frames, does DA2 ray projection place the tag ROI at the expected base_link position, or is projection/extrinsic conversion introducing scale/offset?

## Hypothesis

If mapping scale error is introduced during projection, DA2 projected base_link x/y will differ from the AprilTag-pose expected x/y beyond the point-depth ratio.

## Setup

- **Run directory:** `/home/jetson/colcon_ws`
- **Start time:** 2026-05-07T00:00:13+09:00
- **End time:** 2026-05-07T00:00:27+09:00
- **Exit code:** 0
- **Code commit hash:** needs verification

## Command / Config

```bash
bash -lc source\ /opt/ros/humble/setup.bash\ \&\&\ source\ /home/jetson/colcon_ws/install/setup.bash\ \&\&\ timeout\ 40s\ python3\ /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_apriltag_projection_check.py\ --frames\ 40\ --min-tags\ 4\ --output-csv\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_apriltag_projection_check.csv\ --summary-json\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_apriltag_projection_check_summary.json\ --debug-png\ /home/jetson/colcon_ws/stella_camera_nav_experiments/results/live_apriltag_projection_check.png 
```

- **Config path:** /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_apriltag_projection_check.py
- **Important config values:** family=tag16h5 tag_size=0.088m preprocess=clahe max_hamming=2 margin_min=20 min_tags=4 frames=40 runtime cam_x=0.10 cam_z=0.15 cam_roll=3.97

## Variables

- **Independent variables:** needs verification
- **Controlled variables:** needs verification
- **Ablations:** needs verification

## Dataset / Split

- **Dataset:** live Orbbec color stream and /da2/depth_raw at current farther board position
- **Split:** needs verification
- **Preprocessing:** needs verification
- **Known caveats:** This checks tag ROI projection only; hardware depth is not used; expected transform intentionally matches da2_occupancy_node runtime conventions

## Metrics

- **Primary metrics:** valid frame count, tag count, RMS, pose_z, expected_base_x, DA2_projected_base_x, da2_x/expected_x, dx, lateral y error
- **Secondary metrics:** needs verification
- **Qualitative checks:** needs verification

## Results

- **Fact:** The command exited with code `0`.
- **Observation:** Raw command output is saved at [command.log](../raw/experiments/2026-05-07_00-00-13_live-apriltag-da2-projection-check/command.log).
- **Artifact paths:** [raw experiment directory](../raw/experiments/2026-05-07_00-00-13_live-apriltag-da2-projection-check/)
- **Result validity:** needs verification: mark valid, invalid, tentative, or superseded.

## Interpretation

- **Interpretation:** pending review of live projection check summary
- **Speculation:** tentative
- **Hypothesis update:** unresolved
- **Reasoning:** needs verification: explain why the result should or should not affect calibration/navigation decisions.

## Finding Updates

- No finding update recorded yet. Update [[Findings]] / [../findings.md](../findings.md) after reviewing the result.

## Failure Notes

No failure recorded by the runner. Review logs for warnings.

## Follow-up

- If DA2 projected x follows point-depth ratio, proceed to per-frame BEV/LiDAR; if additional x/y error appears, inspect intrinsics/extrinsics/ray transform.
- Update [[Findings]] / [../findings.md](../findings.md) with a link to this note.
- Update [[Open Questions]] / [../open_questions.md](../open_questions.md) and [[Next Steps]] / [../next_steps.md](../next_steps.md).
- If the experiment produced invalid results, preserve the note and mark the invalidation reason.

## Links

- [[Context]] / [../context.md](../context.md)
- [[Hypotheses]] / [../hypotheses.md](../hypotheses.md)
- [[Findings]] / [../findings.md](../findings.md)
- [[Open Questions]] / [../open_questions.md](../open_questions.md)
- [[Next Steps]] / [../next_steps.md](../next_steps.md)

