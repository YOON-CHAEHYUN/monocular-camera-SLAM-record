# Live AprilTag family probe

## Date

2026-05-06

## Title

Live AprilTag family probe

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

The AprilGrid scale run detected zero tags, so the board family, image quality, and detector settings must be verified before using board pose as a scale reference.

## Research Question

Which AprilTag family/settings, if any, detect tags in the current live RGB frame?

## Hypothesis

If the board is a Kalibr AprilGrid and is visible enough, python3-apriltag should detect multiple IDs under one family; otherwise the reference setup is not ready.

## Setup

- **Run directory:** `/home/jetson/colcon_ws`
- **Start time:** 2026-05-06T23:19:47+09:00
- **End time:** 2026-05-06T23:20:16+09:00
- **Exit code:** 124
- **Code commit hash:** needs verification

## Command / Config

```bash
bash -lc source\ /opt/ros/humble/setup.bash\ \&\&\ source\ /home/jetson/colcon_ws/install/setup.bash\ \&\&\ timeout\ 12s\ python3\ /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/probe_apriltag_live.py 
```

- **Config path:** /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/probe_apriltag_live.py
- **Important config values:** families=all supported common families decimates=1.0,2.0 blurs=0.0,0.8 variants=gray,clahe,blur,upscaled

## Variables

- **Independent variables:** needs verification
- **Controlled variables:** needs verification
- **Ablations:** needs verification

## Dataset / Split

- **Dataset:** one live /camera/color/image_raw frame with board in front of camera
- **Split:** needs verification
- **Preprocessing:** needs verification
- **Known caveats:** single-frame probe; if image misses board or has glare/blur, zero detections do not disprove board type

## Metrics

- **Primary metrics:** tag count by family, detected IDs, median decode margin, saved RGB frame
- **Secondary metrics:** needs verification
- **Qualitative checks:** needs verification

## Results

- **Fact:** The command exited with code `124`.
- **Observation:** Raw command output is saved at [command.log](../raw/experiments/2026-05-06_23-19-47_live-apriltag-family-probe/command.log).
- **Artifact paths:** [raw experiment directory](../raw/experiments/2026-05-06_23-19-47_live-apriltag-family-probe/)
- **Result validity:** needs verification: mark valid, invalid, tentative, or superseded.

## Interpretation

- **Interpretation:** pending review of probe results and saved image
- **Speculation:** tentative
- **Hypothesis update:** unresolved
- **Reasoning:** needs verification: explain why the result should or should not affect calibration/navigation decisions.

## Finding Updates

- No finding update recorded yet. Update [[Findings]] / [../findings.md](../findings.md) after reviewing the result.

## Failure Notes

Command failed. Review [command.log](../raw/experiments/2026-05-06_23-19-47_live-apriltag-family-probe/command.log) before interpreting the result.

## Follow-up

- Use the best detected family/settings for solvePnP, or reposition/replace the board if zero detections persist.
- Update [[Findings]] / [../findings.md](../findings.md) with a link to this note.
- Update [[Open Questions]] / [../open_questions.md](../open_questions.md) and [[Next Steps]] / [../next_steps.md](../next_steps.md).
- If the experiment produced invalid results, preserve the note and mark the invalidation reason.

## Links

- [[Context]] / [../context.md](../context.md)
- [[Hypotheses]] / [../hypotheses.md](../hypotheses.md)
- [[Findings]] / [../findings.md](../findings.md)
- [[Open Questions]] / [../open_questions.md](../open_questions.md)
- [[Next Steps]] / [../next_steps.md](../next_steps.md)

