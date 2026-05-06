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
