# Findings

This file contains cumulative findings that are backed by linked evidence. Each finding should link to supporting experiment, source, log, or decision documents.

## Finding Entry Template

### F-YYYYMMDD-XX: Finding

- **Finding:** Concise claim.
- **Status:** supported / tentative / weakened / rejected
- **Evidence:** Link to experiments, sources, logs, or decisions.
- **Interpretation:** What the evidence suggests and what remains uncertain.
- **Implication:** Why this matters for the research direction or paper argument.
- **Related hypotheses:** Link to relevant hypotheses.
- **Related experiments:** Link to relevant experiment notes.
- **Last updated:** YYYY-MM-DD

## Current Findings

No findings recorded yet.
# 2026-05-06 Depth Scale Calibration Notes

Detailed log:

```text
/home/jetson/colcon_ws/stella_camera_nav_experiments/docs/DEPTH_SCALE_CALIBRATION_LOG.md
```

Current status:

- Bag07 contains color, IMU, odom, scan, TF, but no hardware depth topic.
- DA2 raw depth appears larger than LiDAR on raw ray comparisons, but the BEV
  map does not look globally 1.7x oversized.
- Bag07 BEV/LiDAR radial-ratio sanity check suggests a DA2 depth scale around
  `0.75` for BEV map alignment.
- Live hardware-depth vs DA2 pixel-resize comparison was invalidated.
- Live angular-ray comparison near 1 m showed DA2/HW around `2.15x`, but this
  should be treated as a near-range scene check, not final calibration.
- The visible 6x6 tag board is likely a Kalibr AprilGrid:
  `tagSize=0.088 m`, absolute spacing `0.0264 m`, Kalibr `tagSpacing=0.3`,
  likely family `tag36h11`.
- OpenCV ArUco/AprilTag detection did not work on the board; the dedicated
  `python3-apriltag` detector is installed and should be used next.
- Rectangle-only board pose was invalidated because the estimated pose depth was
  physically impossible.
- 2026-05-06 live AprilTag family probe found the board is detectable as
  `tag16h5`, not `tag36h11`.
- Full-grid AprilGrid solvePnP attempts remain invalid because reprojection RMS
  is too high; ID layout and grid-slot ambiguity are unresolved.
- Independent single-tag pose is geometrically stable
  (`RMS ~= 0.076 px`, `pose_z ~= 1.144 m`), but the sampled DA2/HW depth values
  are invalid as scale estimates until ROI alignment is fixed. DA2 depth is
  published after a 180-degree image rotation, while the current checker sampled
  it with an unrotated RGB mask.
- After rotating the DA2 sampling mask to match `/da2/depth_raw`, single-tag
  pose remained stable (`RMS ~= 0.075 px`, `pose_z ~= 1.143 m`) and DA2 sampled
  median became `0.839 m`, or `DA2/pose_z ~= 0.734x` with nominal local scale
  `1.36`. This is tentative and must be repeated at another distance before
  changing runtime DA2 parameters.
- A repositioned-board repeat collected only 3 valid samples but had low pose
  RMS (`~0.071 px`) and produced `pose_z ~= 0.701 m`, `DA2 ~= 0.935 m`, or
  `DA2/pose_z ~= 1.334x` with nominal local scale `0.749`. The disagreement
  with the previous board pose strengthens the finding that a single global DA2
  scale is not defensible yet.
- The improved-position board repeat collected 40 samples with low RMS
  (`~0.082 px`) and produced `pose_z ~= 1.705 m`, `DA2 ~= 1.729 m`, or
  `DA2/pose_z ~= 1.032x` with nominal local scale `0.969`. This is the strongest
  live board measurement so far and weakens the case for applying a large fixed
  DA2 depth scale correction.
- A farther-distance repeat collected 12 samples with acceptable RMS
  (`~0.148 px`) and produced `pose_z ~= 3.229 m`, `DA2 ~= 1.857 m`, or
  `DA2/pose_z ~= 0.584x` with nominal local scale `1.712`. This tentative point
  supports distance-dependent behavior and further weakens a single global DA2
  scale correction.
- The discrepancy between shorter DA2 board depth and larger-looking DA2 maps
  should be treated as a pipeline-stage problem, not a contradiction. The likely
  causes to separate are point-depth bias, ray/extrinsic projection, height
  filtering, BEV grid metadata, global map accumulation/pose, and LiDAR
  reference mismatch.
