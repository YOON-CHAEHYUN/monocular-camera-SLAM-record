# Findings

This file contains cumulative findings that are backed by linked evidence. Each finding should link to supporting experiment, source, log, or decision documents.

이 파일은 근거 링크가 있는 누적 finding을 관리한다. 각 finding은 관련 experiment, source, log, decision 문서로 추적 가능해야 한다.

## Finding Entry Template

### F-YYYYMMDD-XX: Finding

- **Finding / 발견:** Concise claim. / 간결한 주장.
- **Status / 상태:** supported / tentative / weakened / rejected
- **Evidence / 근거:** Link to experiments, sources, logs, or decisions. / 실험, 출처, 로그, 결정 문서 링크.
- **Interpretation / 해석:** What the evidence suggests and what remains uncertain. / 근거가 시사하는 점과 아직 불확실한 점.
- **Implication / 함의:** Why this matters for the research direction or paper argument. / 연구 방향이나 논문 주장에 왜 중요한지.
- **Related hypotheses / 관련 가설:** Link to relevant hypotheses.
- **Related experiments / 관련 실험:** Link to relevant experiment notes.
- **Last updated / 마지막 업데이트:** YYYY-MM-DD

## Current Findings

### F-20260506-01: Board-based DA2 point-scale checks do not support one global scale

- **Finding / 발견:** Live checkerboard/AprilGrid/AprilTag board measurements show DA2/pose ratios that vary strongly across board distance, framing, and ROI alignment. / live checkerboard/AprilGrid/AprilTag board 기반 측정에서 DA2/pose ratio가 board 거리, 프레이밍, ROI 정렬에 따라 크게 달라졌다.
- **Status / 상태:** tentative
- **Evidence / 근거:** [[Depth Scale Calibration and AprilGrid Setup]] / [experiments/2026-05-06-depth-scale-calibration.md](experiments/2026-05-06-depth-scale-calibration.md)
- **Interpretation / 해석:** The board-pose reference is useful only after detector family, grid layout, tag-size, reprojection RMS, and DA2 rotated-mask alignment are controlled. The strongest live board point so far is the improved-position run around `1.705 m`, where DA2/pose was `1.032x`, but a farther run around `3.229 m` produced `0.584x`. / board pose reference는 detector family, grid layout, tag size, reprojection RMS, DA2 rotated-mask alignment가 통제된 뒤에만 유효하다. 현재 가장 강한 live board 측정은 `1.705 m` improved-position run으로 DA2/pose가 `1.032x`였지만, `3.229 m` farther run은 `0.584x`였다.
- **Implication / 함의:** Do not apply a large fixed DA2 scale correction from one board run. Board-based scale must be treated as a diagnostic for distance/framing dependence and then validated in BEV/LiDAR map space. / 단일 board run에서 큰 고정 DA2 scale correction을 적용하면 안 된다. board 기반 scale은 거리/프레이밍 의존성 진단으로 보고, BEV/LiDAR map space에서 다시 검증해야 한다.
- **Related hypotheses / 관련 가설:** DA2 scale behavior is not a single global multiplicative factor. / DA2 scale은 단일 global multiplier가 아닐 수 있다.
- **Related experiments / 관련 실험:** [[Depth Scale Calibration and AprilGrid Setup]] / [experiments/2026-05-06-depth-scale-calibration.md](experiments/2026-05-06-depth-scale-calibration.md)
- **Last updated / 마지막 업데이트:** 2026-05-07
### F-20260507-01: Bag07 BEV/LiDAR comparisons favor DA2 scale 0.75 over 1.0, but not as a universal correction

- **Finding / 발견:** In bag07 BEV/LiDAR comparisons, `scale=0.75` consistently aligned better than `scale=1.0` in per-frame and global-map diagnostics. / bag07 BEV/LiDAR 비교에서 `scale=0.75`는 per-frame 및 global-map diagnostic에서 `scale=1.0`보다 일관되게 더 잘 맞았다.
- **Status / 상태:** tentative
- **Evidence / 근거:** [bag07 per-frame scale check](experiments/2026-05-07_00-02-28_bag07-per-frame-bev-lidar-scale-check.md), [bag07 key overlays](experiments/2026-05-07_00-04-35_bag07-per-frame-bev-lidar-key-overlays.md), [bag07 official Cartographer GT note](experiments/2026-05-07_01-28-07_bag07-official-stella-cartographer-lidar-gt.md)
- **Interpretation / 해석:** The mapping-stage comparison supports `0.75` as a bag07 candidate, but absolute overlap remains low and the GT/reference pipeline changed during diagnosis. / mapping-stage 비교는 `0.75`를 bag07 후보로 지지하지만, absolute overlap은 낮고 GT/reference pipeline이 진단 과정에서 바뀌었다.
- **Implication / 함의:** Scale choice should be evaluated with official STELLA Cartographer GT and separated from pose/localization, front-FOV-vs-360 observation mismatch, and global map accumulation effects. / scale 선택은 official STELLA Cartographer GT로 평가해야 하며, pose/localization, front-FOV-vs-360 observation mismatch, global map accumulation effect와 분리해야 한다.
- **Related hypotheses / 관련 가설:** Navigation-aware BEV metrics are more relevant than raw pixel-depth scale alone. / raw pixel-depth scale보다 navigation-aware BEV metric이 더 중요하다.
- **Related experiments / 관련 실험:** [bag07 official Cartographer GT note](experiments/2026-05-07_01-28-07_bag07-official-stella-cartographer-lidar-gt.md)
- **Last updated / 마지막 업데이트:** 2026-05-07

### F-20260507-02: The current LiDAR GT source matters

- **Finding / 발견:** Earlier `slam_toolbox` LiDAR maps from `/scan_fov` are diagnostic only; official STELLA Cartographer maps from full `/scan` and `/odom` should be the current GT candidate for bag07. / 이전 `/scan_fov` 기반 `slam_toolbox` LiDAR map은 diagnostic으로만 써야 하며, full `/scan`과 `/odom`을 사용한 official STELLA Cartographer map을 bag07의 현재 GT 후보로 써야 한다.
- **Status / 상태:** supported for current workflow
- **Evidence / 근거:** [bag07 RViz clean scale100 LiDAR GT diagnosis](experiments/2026-05-07_00-53-23_bag07-rviz-clean-scale100-lidar-gt-diagnosis.md), [official Cartographer GT note](experiments/2026-05-07_01-28-07_bag07-official-stella-cartographer-lidar-gt.md)
- **Interpretation / 해석:** A forward-FOV filtered scan map can bias conclusions about DA2/BEV alignment. / forward-FOV filtered scan map은 DA2/BEV alignment 결론을 왜곡할 수 있다.
- **Implication / 함의:** Future bag07 comparisons should cite the GT map path `stella_camera_nav_experiments/results/lidar_gt/stella_cartographer_official_bag07_20260507/map.yaml`. / 향후 bag07 비교는 GT map path `stella_camera_nav_experiments/results/lidar_gt/stella_cartographer_official_bag07_20260507/map.yaml`를 기준으로 기록해야 한다.
- **Related hypotheses / 관련 가설:** Evaluation reference quality affects apparent BEV scale findings. / evaluation reference 품질이 BEV scale finding에 영향을 준다.
- **Related experiments / 관련 실험:** [official Cartographer GT note](experiments/2026-05-07_01-28-07_bag07-official-stella-cartographer-lidar-gt.md)
- **Last updated / 마지막 업데이트:** 2026-05-07
