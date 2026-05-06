# Depth Scale Calibration and AprilGrid Setup

## Date

2026-05-06

## Title

DA2, LiDAR, hardware depth, and calibration-board scale checks for STELLA Camera-Nav.

## Status

running

## Recording Contract

This experiment series is incomplete until each calibration run records:

- why the run was performed
- the question or hypothesis it tests
- exact setup, command, data source, hardware state, and config values
- metrics and qualitative checks
- observed results and artifact paths
- interpretation, including valid/invalid/tentative/superseded status
- next action

Numerical scale estimates from this series must not be used without their
reference source, valid range, and invalidation notes.

## Motivation

The DA2-derived BEV map appeared slightly larger than the LiDAR map in RViz, but
raw depth comparisons produced much larger ratios that did not match the visual
map scale. This experiment series was started to determine whether the issue is
a true DA2 depth-scale error, a distance-dependent bias, a BEV projection
artifact, or an invalid comparison methodology.

This matters because the navigation stack consumes DA2-based BEV occupancy. An
incorrect scale correction could either inflate obstacles and distort maps or
over-shrink nearby obstacles and make navigation unsafe.

## Research Question

What scale correction, if any, should be applied to DA2 depth before BEV
occupancy generation, and how does that correction differ across LiDAR, hardware
depth, and AprilGrid/board-pose references?

## Hypothesis

The DA2 depth error is not a single global factor. Near-range DA2 depth may be
over-estimated more strongly than the effective BEV map scale suggests.

Supporting evidence would be:

- hardware-depth or board-pose checks showing large near-range DA2 bias,
- while LiDAR/BEV global-map comparisons show only moderate map-scale mismatch.

Weakening evidence would be:

- a single scale factor aligning DA2 with hardware depth, LiDAR rays, and BEV map
  structure across the whole 0.5-5 m working range.

## Setup

- **Environment:** Jetson Ubuntu, ROS 2 Humble, Orbbec Gemini 336L, YDLiDAR, DA2
  metric indoor ViT-S checkpoint.
- **Workspace:** `/home/jetson/colcon_ws`
- **DA2 config:** `/home/jetson/colcon_ws/install/stella_camera_nav/share/stella_camera_nav/config/da2_params.yaml`
- **Main log:** `/home/jetson/colcon_ws/stella_camera_nav_experiments/docs/DEPTH_SCALE_CALIBRATION_LOG.md`
- **Results directory:** `/home/jetson/colcon_ws/stella_camera_nav_experiments/results`

## Command / Config

Correct DA2 live command:

```bash
source /opt/ros/humble/setup.bash
source /home/jetson/colcon_ws/install/setup.bash
ros2 run stella_camera_nav da2_occupancy_node --ros-args \
  --params-file /home/jetson/colcon_ws/install/stella_camera_nav/share/stella_camera_nav/config/da2_params.yaml \
  -p inference_rate:=5.0
```

The relative params path `install/stella_camera_nav/...` fails when launched
from `~`, because it resolves under `/home/jetson/install`.

Camera + hardware depth launch used during live checks:

```bash
source /opt/ros/humble/setup.bash
source /home/jetson/colcon_ws/install/setup.bash
ros2 launch orbbec_camera gemini_330_series.launch.py \
  camera_name:=camera \
  enable_color:=true \
  enable_depth:=true \
  enable_ir:=false \
  color_depth_sync:=true \
  enable_point_cloud:=false \
  enable_colored_point_cloud:=false \
  color_width:=640 \
  color_height:=480 \
  color_fps:=30
```

## Variables

- **Independent variables:** comparison reference source, depth scale, target
  distance/pose, board detection method.
- **Controlled variables:** DA2 model checkpoint, DA2 input size 434, Orbbec
  color stream 640x480, hardware depth trusted range capped at 2.5 m.
- **Ablations:** raw DA2 rays vs LiDAR, DA2 BEV vs LiDAR BEV, pixel-aligned
  live depth comparison, angular-ray live comparison, rectangle-board pose,
  AprilGrid detector setup.

## Dataset / Split

- **Bag:** `/home/jetson/colcon_ws/bags/test_run_07`
- **Live data:** Orbbec Gemini 336L color/depth streams and live DA2 output.
- **Known caveat:** bag07 does not contain hardware depth topics.

## Metrics

- **Primary metrics:** DA2/reference depth ratio, suggested scale, BEV/LiDAR
  radial ratio, BEV/LiDAR F1 within 20 cm.
- **Secondary metrics:** occupied IoU, median depth error, valid sample count.
- **Qualitative checks:** RViz map overlay, saved RGB board images, invalid pose
  sanity checks.

## Results

- **Fact:** Offline bag07 evaluator output is stored in
  `/home/jetson/colcon_ws/stella_camera_nav_experiments/results/bag07_bev_scale_fit/`.
- **Observation:** bag07 raw DA2 rays had median DA2/LiDAR ratio `1.7166x`.
- **Observation:** bag07 BEV/LiDAR radial-ratio recommendation was around
  `scale=0.75`, with median BEV/LiDAR radial ratio `1.0416`.
- **Observation:** bag07 has no hardware depth topic, so hardware-depth
  comparison is unavailable for that bag.
- **Observation:** A direct resized-pixel live hardware-depth vs DA2 comparison
  produced `~3.9x`, but this was invalidated.
- **Reason invalidated:** hardware depth and DA2/color depth are not pixel
  aligned; FOV, resolution, optical centers, and rotation differ.
- **Observation:** Corrected angular-ray live comparison near range produced
  DA2/HW median ratio around `2.153x`, with hardware median `0.948 m` and DA2
  median `2.129 m`.
- **Observation:** The visible 6x6 board is likely a Kalibr AprilGrid:
  `tagSize=0.088 m`, spacing `0.0264 m`, Kalibr `tagSpacing=0.3`, likely
  `tag36h11`.
- **Observation:** OpenCV ArUco/AprilTag probing did not detect the board.
- **Fact:** `python3-apriltag` import was confirmed after user installation.
- **Observation:** Rectangle-only board-pose fallback produced `pose_z ~= 0.12 m`
  while hardware depth was around `0.407 m`; this is physically impossible.
- **Reason invalidated:** the outer-rectangle detector likely selected the wrong
  rectangle or used wrong corner correspondence.

## Interpretation

- **Interpretation:** DA2 likely overestimates near-range depth, but the effective
  BEV map scale error is smaller than raw ray comparisons suggest.
- **Interpretation:** A single global scale is risky. A distance-aware or
  piecewise correction may be needed, then must be validated again in BEV/LiDAR
  map space.
- **Interpretation:** AprilGrid pose is the correct next reference because it
  provides geometric pose from RGB camera intrinsics and avoids ambiguous
  LiDAR/BEV/pixel alignment assumptions.
- **Speculation, needs verification:** The board is `tag36h11` Kalibr AprilGrid.
  It must be confirmed by a successful dedicated AprilTag detector run.
- **Hypothesis update:** unresolved but strengthened. The evidence supports
  distance-dependent or methodology-dependent scale mismatch rather than a clean
  single-factor error.

## Finding Updates

- See [[Findings]] / [../findings.md](../findings.md), section
  `2026-05-06 Depth Scale Calibration Notes`.
- Detailed engineering log:
  `/home/jetson/colcon_ws/stella_camera_nav_experiments/docs/DEPTH_SCALE_CALIBRATION_LOG.md`

## Failure Notes

- Do not use the pixel-resize `3.9x` result.
- Do not use the rectangle-board `pose_z ~= 0.12 m` result.
- Do not use bag07 to evaluate hardware depth; hardware depth was not recorded.
- Avoid launching DA2 with a relative params path from `~`.

## Follow-up

- Implement AprilGrid detection with `python3-apriltag`.
- Build object/image corner correspondences from detected tag IDs.
- Run `solvePnP` against `/camera/color/camera_info`.
- Compare AprilGrid pose distance against DA2 depth and hardware depth inside
  the detected board mask.
- Fit DA2 correction candidates and validate in both target-pose space and BEV
  LiDAR-map space.

## Links

- [[Context]] / [../context.md](../context.md)
- [[Hypotheses]] / [../hypotheses.md](../hypotheses.md)
- [[Findings]] / [../findings.md](../findings.md)
- [[Open Questions]] / [../open_questions.md](../open_questions.md)
- [[Next Steps]] / [../next_steps.md](../next_steps.md)
