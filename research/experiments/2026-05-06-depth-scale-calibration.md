# Depth Scale Calibration and AprilGrid Setup

## Date

Created: 2026-05-06
Last run: 2026-05-07

## Title

- **한국어:** checkerboard/AprilGrid/AprilTag 보드 기반 DA2 depth scale 측정과 검증
- **English:** Checkerboard/AprilGrid/AprilTag board-based DA2 depth-scale measurement and validation

## Status

running

## Recording Contract

This note is organized by research purpose, not by individual run. Repeated board-pose, checkerboard, AprilGrid, AprilTag, and single-tag DA2 scale checks belong here under `## Run History`.

이 노트는 회차별 파일이 아니라 연구 목적 단위 파일이다. checkerboard, AprilGrid, AprilTag, single-tag 기반 DA2 scale 측정 반복 실행은 새 파일을 만들지 않고 `## Run History`에 누적한다.

Numerical scale estimates from this series must not be used without their reference source, valid range, invalidation notes, and artifact paths.

이 실험군의 scale 숫자는 reference source, 유효 거리 범위, invalidation note, artifact path 없이 사용하면 안 된다.

## Motivation

- **한국어:** DA2 기반 BEV map이 LiDAR map보다 커 보였지만, raw depth 비교와 BEV map scale 비교가 같은 숫자를 가리키지 않았다. 보드 기반 RGB geometric pose를 reference로 사용해 DA2 point-depth scale이 실제 거리, 프레이밍, ROI alignment에 따라 어떻게 달라지는지 확인해야 했다.
- **English:** The DA2-derived BEV map appeared larger than the LiDAR map, but raw depth comparisons and BEV map-scale comparisons did not point to the same scale. A board-based RGB geometric pose reference was needed to test how DA2 point-depth scale changes with distance, framing, and ROI alignment.

## Research Question

- **한국어:** DA2 depth에 단일 global scale correction을 적용할 수 있는가, 아니면 보드 거리/프레이밍/ROI alignment 및 BEV projection stage에 따라 scale behavior가 달라지는가?
- **English:** Can DA2 depth be corrected with one global scale factor, or does its scale behavior depend on board distance, framing, ROI alignment, and the BEV projection stage?

## Hypothesis

- **한국어:** DA2 depth error는 단일 global multiplier가 아니라 거리, target framing, sampling alignment, pipeline stage에 따라 달라질 가능성이 높다.
- **English:** DA2 depth error is likely not a single global multiplier; it may vary with range, target framing, sampling alignment, and pipeline stage.
- **Support condition / 지지 조건:** repeated board measurements produce inconsistent DA2/pose ratios while BEV/LiDAR diagnostics favor a different scale candidate.
- **Weakening condition / 약화 조건:** one scale factor aligns DA2 with board pose, hardware depth, LiDAR rays, and BEV map structure across the working range.

## Setup

- **Environment / 환경:** Jetson Ubuntu, ROS 2 Humble, STELLA N2, Orbbec Gemini 336L, DA2 metric indoor ViT-S checkpoint.
- **Workspace / 작업공간:** `/home/jetson/colcon_ws`
- **Main log / 주 로그:** `/home/jetson/colcon_ws/stella_camera_nav_experiments/docs/DEPTH_SCALE_CALIBRATION_LOG.md`
- **Results root / 결과 루트:** `/home/jetson/colcon_ws/stella_camera_nav_experiments/results`
- **Board / 보드:** visible 6x6 tag board, detected as `tag16h5`; tag black-square size treated as `0.088 m`. Earlier assumption of `tag36h11` was weakened by live detector probing.
- **DA2 topic / DA2 토픽:** `/da2/depth_raw` after DA2 image rotation; DA2 ROI masks must be rotated to match the published depth coordinate system.

## Command / Config

Representative live DA2 command:

```bash
source /opt/ros/humble/setup.bash
source /home/jetson/colcon_ws/install/setup.bash
ros2 run stella_camera_nav da2_occupancy_node --ros-args \
  --params-file /home/jetson/colcon_ws/install/stella_camera_nav/share/stella_camera_nav/config/da2_params.yaml \
  -p inference_rate:=5.0
```

Representative board scale command:

```bash
source /opt/ros/humble/setup.bash
source /home/jetson/colcon_ws/install/setup.bash
python3 /home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_aprilgrid_depth_check.py \
  --family tag16h5 \
  --layout single_tags \
  --max-hamming 2 \
  --preprocess clahe \
  --margin-min 20 \
  --frames 40 \
  --min-tags 6 \
  --max-single-tag-reproj-rms 4.0 \
  --rotate-da2-mask
```

- **Config path / config 경로:** `/home/jetson/colcon_ws/stella_camera_nav_experiments/scripts/live_aprilgrid_depth_check.py`
- **Important config values / 주요 config 값:** `family=tag16h5`, `layout=single_tags`, `tag_size=0.088m`, `rotate_da2_mask=true`, strict single-tag reprojection RMS filtering.

## Variables

- **Independent variables / 독립 변수:** board detector family, grid layout method, single-tag vs full-grid solvePnP, board distance, board framing, DA2 ROI rotation, comparison reference.
- **Controlled variables / 통제 변수:** same DA2 model/checkpoint, same live camera stream, same physical board, same RGB camera intrinsics unless otherwise noted.
- **Ablations / ablation:** OpenCV detector vs `python3-apriltag`, `tag36h11` vs `tag16h5`, full-grid row-major vs image-grid vs orientation-invariant grid, unrotated DA2 mask vs rotated DA2 mask, near vs farther board distance.

## Dataset / Split

- **Dataset / 데이터셋:** live Orbbec color stream, `/da2/depth_raw`, and optional hardware depth during board measurements.
- **Bag / bag:** `/home/jetson/colcon_ws/bags/test_run_07` was used for related BEV/LiDAR scale checks, but it has no hardware depth topic.
- **Known caveats / 주의점:** hardware-depth ROI was not confirmed color-aligned; full-grid AprilGrid solvePnP had ID/layout ambiguity; single-tag pose is valid only when reprojection RMS is low and tag size is correct.

## Metrics

- **Primary metrics / 주 metric:** valid frame count, detected tag count, reprojection RMS, `pose_z`, DA2 median inside board/tag ROI, `DA2/pose_z`, nominal local scale `pose_z/DA2`.
- **Secondary metrics / 보조 metric:** hardware depth median when available, p10/p90 spread, timeout/valid-sample failure count.
- **Qualitative checks / 정성 확인:** saved debug PNG, visible board framing, physically plausible pose depth, consistency with BEV/LiDAR scale diagnostics.

## Results

- **Fact / 사실:** Initial pixel-resize hardware-depth vs DA2 comparison and rectangle-only board pose were invalidated.
- **Observation / 관찰:** The board is detectable as `tag16h5`, not the initially assumed `tag36h11`.
- **Observation / 관찰:** Full-grid AprilGrid solvePnP attempts remained invalid because reprojection RMS was too high and grid-slot/ID ambiguity remained unresolved.
- **Observation / 관찰:** Independent single-tag pose produced low reprojection RMS (`~0.07-0.15 px`) and became the usable board-pose reference.
- **Observation / 관찰:** DA2 sampling without rotating the ROI mask produced invalid depth values because `/da2/depth_raw` is in the rotated DA2 coordinate frame.
- **Observation / 관찰:** After ROI rotation, board-position results varied substantially:
  - `pose_z ~= 1.143 m`, `DA2 ~= 0.839 m`, `DA2/pose_z ~= 0.734x`, nominal scale `1.36`.
  - `pose_z ~= 0.701 m`, `DA2 ~= 0.935 m`, `DA2/pose_z ~= 1.334x`, nominal scale `0.749`, but only 3 valid samples.
  - `pose_z ~= 1.705 m`, `DA2 ~= 1.729 m`, `DA2/pose_z ~= 1.032x`, nominal scale `0.969`, strongest live board point so far.
  - `pose_z ~= 3.229 m`, `DA2 ~= 1.857 m`, `DA2/pose_z ~= 0.584x`, nominal scale `1.712`, tentative far-distance point.
- **Artifact paths / 산출물 경로:** result CSV/JSON/PNG files are under `/home/jetson/colcon_ws/stella_camera_nav_experiments/results/`; raw runner logs are under `research/raw/experiments/2026-05-06_*` and `research/raw/experiments/2026-05-07_00-00-13_live-apriltag-da2-projection-check/`.
- **Result validity / 결과 유효성:** single-tag pose geometry is usable when RMS and sample count are sufficient; a single global DA2 scale is not supported by this experiment series.

## Interpretation

- **한국어:** checkerboard/AprilGrid류 live board 측정은 DA2 point-depth가 단순한 global scale error가 아니라는 쪽을 강화한다. 특히 가장 신뢰할 수 있는 `1.705 m` run은 DA2와 pose가 거의 맞았지만, farther run은 DA2가 크게 짧게 나왔다. 따라서 이 실험군은 직접 scale 값을 적용하기보다, DA2 scale behavior의 거리/프레이밍/ROI 의존성을 보여주는 진단 근거로 사용해야 한다.
- **English:** The live checkerboard/AprilGrid-style board measurements strengthen the interpretation that DA2 point-depth error is not a simple global scale error. The strongest `1.705 m` run showed DA2 close to pose, while the farther run showed DA2 much shorter than pose. This series should therefore be used as diagnostic evidence for distance/framing/ROI dependence rather than as a direct scale parameter source.
- **Speculation / 추측:** tentative. The discrepancy between board point-depth behavior and bag07 BEV/LiDAR scale may be caused by pipeline-stage effects, including ray projection, height filtering, occupancy thresholding, global map accumulation, and localization/pose reference quality.
- **Hypothesis update / 가설 업데이트:** strengthened for "no single global DA2 scale"; unresolved for the exact correction model.

## Finding Updates

- Added/updated [[Findings]] / [../findings.md](../findings.md), especially `F-20260506-01`.
- This note is the canonical evidence link for board/checkerboard/AprilGrid/AprilTag scale measurement attempts.

## Failure Notes

- **한국어:** pixel-resize hardware-depth comparison `~3.9x`는 FOV/해상도/optical center/rotation mismatch 때문에 invalid.
- **English:** The pixel-resize hardware-depth comparison around `~3.9x` is invalid due to FOV, resolution, optical-center, and rotation mismatch.
- **한국어:** rectangle-only board pose `pose_z ~= 0.12 m`는 물리적으로 불가능해 invalid.
- **English:** The rectangle-only board pose `pose_z ~= 0.12 m` is physically impossible and invalid.
- **한국어:** full-grid AprilGrid runs are invalid for scale because reprojection RMS remained high.
- **English:** Full-grid AprilGrid runs are invalid for scale because reprojection RMS remained high.
- **한국어:** unrotated DA2 ROI single-tag result is invalid for DA2 scale because it sampled the wrong image region.
- **English:** The unrotated DA2 ROI single-tag result is invalid for DA2 scale because it sampled the wrong image region.

## Follow-up

- **한국어:** 새 board scale run을 할 때는 이 파일의 `## Run History`에 추가하고, 같은 목적의 새 파일을 만들지 않는다.
- **English:** New board-scale runs should be appended to `## Run History` in this file; do not create a new file for the same purpose.
- **한국어:** 다음 검증은 board point-scale 값 자체보다 BEV/LiDAR/Cartographer GT alignment와의 일관성을 확인해야 한다.
- **English:** The next validation should focus on consistency with BEV/LiDAR/Cartographer GT alignment rather than using board point-scale values directly.
- **한국어:** far-distance board run은 target 크기와 valid DA2 pixel 수를 개선한 뒤 반복한다.
- **English:** Repeat far-distance board runs with better target visibility and enough valid DA2 pixels.

## Run History

### 2026-05-06 offline/live setup and invalid comparisons

- **한국어:** bag07에는 hardware depth topic이 없어서 hardware-depth scale 평가는 live에서만 가능했다. pixel-resize live comparison과 rectangle-only board pose는 invalid 처리했다.
- **English:** bag07 did not contain hardware-depth topics, so hardware-depth scale evaluation had to be live-only. The pixel-resize live comparison and rectangle-only board pose were invalidated.
- **Artifacts / 산출물:** `/home/jetson/colcon_ws/stella_camera_nav_experiments/docs/DEPTH_SCALE_CALIBRATION_LOG.md`

### 2026-05-06_23-17-13 live AprilGrid smoke test

- **Purpose / 목적:** check whether the initially assumed `tag36h11` AprilGrid could provide a scale reference.
- **Result / 결과:** failed/timed out; no usable scale estimate.
- **Log / 로그:** [command.log](../raw/experiments/2026-05-06_23-17-13_live-aprilgrid-da2-scale-smoke-test/command.log)

### 2026-05-06_23-19-47 live AprilTag family probe

- **Purpose / 목적:** identify which tag family is detectable in the live frame.
- **Result / 결과:** board detection path moved from assumed `tag36h11` to `tag16h5`.
- **Log / 로그:** [command.log](../raw/experiments/2026-05-06_23-19-47_live-apriltag-family-probe/command.log)

### 2026-05-06_23-21-59 to 23-26-24 full-grid attempts

- **Purpose / 목적:** test full-grid `solvePnP` with `tag16h5`, image-grid layout, and orientation-invariant layout.
- **Result / 결과:** invalid for scale because reprojection RMS and layout ambiguity remained unresolved.
- **Logs / 로그:** [tag16h5](../raw/experiments/2026-05-06_23-21-59_live-aprilgrid-tag16h5-da2-scale/command.log), [image-grid](../raw/experiments/2026-05-06_23-24-29_live-aprilgrid-image-grid-da2-scale/command.log), [orientation](../raw/experiments/2026-05-06_23-26-24_live-aprilgrid-orientation-invariant-da2-scale/command.log)

### 2026-05-06_23-29-07 single-tag pose with unrotated DA2 ROI

- **Purpose / 목적:** avoid grid-layout ambiguity by using each tag as an independent square pose reference.
- **Result / 결과:** pose valid (`RMS ~= 0.076 px`, `pose_z ~= 1.144 m`), DA2/HW depth invalid because the ROI did not match DA2 rotated coordinates.
- **Log / 로그:** [command.log](../raw/experiments/2026-05-06_23-29-07_live-single-tag-aprilgrid-da2-scale/command.log)

### 2026-05-06_23-32-04 DA2-aligned single-tag scale

- **Purpose / 목적:** rotate DA2 ROI mask to match `/da2/depth_raw`.
- **Result / 결과:** `pose_z ~= 1.143 m`, `DA2 ~= 0.839 m`, `DA2/pose_z ~= 0.734x`, nominal scale `1.36`; tentative.
- **Log / 로그:** [command.log](../raw/experiments/2026-05-06_23-32-04_live-single-tag-da2-aligned-scale/command.log)

### 2026-05-06_23-35-14 repositioned repeat

- **Purpose / 목적:** test repeatability after changing board visibility/position.
- **Result / 결과:** only 3 valid samples; `pose_z ~= 0.701 m`, `DA2 ~= 0.935 m`, `DA2/pose_z ~= 1.334x`, nominal scale `0.749`; tentative.
- **Log / 로그:** [command.log](../raw/experiments/2026-05-06_23-35-14_live-single-tag-da2-aligned-scale-repeat/command.log)

### 2026-05-06_23-41-05 improved board position

- **Purpose / 목적:** obtain enough valid samples at a better board pose.
- **Result / 결과:** 40 valid samples, `RMS ~= 0.082 px`, `pose_z ~= 1.705 m`, `DA2 ~= 1.729 m`, `DA2/pose_z ~= 1.032x`, nominal scale `0.969`; strongest live board point so far.
- **Log / 로그:** [command.log](../raw/experiments/2026-05-06_23-41-05_live-single-tag-da2-aligned-scale-improved-position/command.log)

### 2026-05-06_23-46-26 farther board position

- **Purpose / 목적:** check range dependence at a farther distance.
- **Result / 결과:** 12 valid samples, `RMS ~= 0.148 px`, `pose_z ~= 3.229 m`, `DA2 ~= 1.857 m`, `DA2/pose_z ~= 0.584x`, nominal scale `1.712`; tentative far-distance evidence.
- **Log / 로그:** [command.log](../raw/experiments/2026-05-06_23-46-26_live-single-tag-da2-aligned-scale-farther/command.log)

### 2026-05-07_00-00-13 AprilTag DA2 projection check

- **Purpose / 목적:** check whether runtime projection/extrinsic conversion adds extra scale/offset beyond the DA2 point-depth ratio.
- **Result / 결과:** far-board expected base_x was `~3.335 m`; DA2-projected base_x was `~2.019 m`, `DA2/expected_x ~= 0.610x`, matching the short DA2 point-depth behavior rather than proving projection alone makes DA2 points too large.
- **Log / 로그:** [command.log](../raw/experiments/2026-05-07_00-00-13_live-apriltag-da2-projection-check/command.log)

## Links

- [[Context]] / [../context.md](../context.md)
- [[Hypotheses]] / [../hypotheses.md](../hypotheses.md)
- [[Findings]] / [../findings.md](../findings.md)
- [[Open Questions]] / [../open_questions.md](../open_questions.md)
- [[Next Steps]] / [../next_steps.md](../next_steps.md)
