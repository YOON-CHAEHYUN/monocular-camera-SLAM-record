# Context

## Research Background

Current background is `needs verification`. Add the broader domain, prior assumptions, and why this research direction matters.

## Problem Definition

- **Problem:** Define loss formulations that optimize the whole STELLA Camera-Nav pipeline, not only pixel-level monocular depth error.
- **Why it matters:** The robot uses predicted depth only as an intermediate representation; navigation quality depends on BEV free-space, obstacle endpoints, map consistency, localization stability, and planner safety.
- **Target setting:** SSH-server-based experiments and accumulated research records.
- **Expected output:** loss formulations, ablation plans, and experiment records that can support paper or report writing.

## Research Scope

### In Scope

- Experiment motivation, setup, results, interpretation, and artifacts.
- Hypotheses and cumulative findings.
- Source notes connected to research questions and paper sections.
- Decisions and rationale.

### Out of Scope

- `tentative`: items that should not be treated as part of the current research claim until explicitly added.

## Current Narrative

STELLA Camera-Nav is a camera-based indoor navigation system where monocular metric depth is converted into ego-centric BEV occupancy, accumulated into a global map, matched against a map for localization, and consumed by Nav2. A depth loss that improves benchmark depth metrics may not improve navigation if it fails to preserve obstacle endpoints, free-space visibility, occlusion semantics, or temporal map stability. The research direction is therefore to formulate navigation-aware losses over the whole pipeline and test whether these losses correlate with downstream BEV, localization, and Nav2 metrics.

## Key Assumptions

- **Assumption, tentative:** LiDAR-derived ray endpoint and free-space supervision are closer to navigation success than dense pixel depth loss alone.
- **Assumption, tentative:** Differentiable soft BEV/raycasting losses can improve the runtime hard BEV occupancy output despite surrogate mismatch.
- **Assumption, tentative:** Localization likelihood-field and planning/costmap metrics should be used first for checkpoint selection and ablation, then only later as training surrogates if needed.

## Links

- [[Hypotheses]] / [hypotheses.md](hypotheses.md)
- [[Findings]] / [findings.md](findings.md)
- [[Paper Outline]] / [paper_outline.md](paper_outline.md)
- [[Navigation-Aware Loss Formulation]] / [concepts/navigation_aware_loss_formulation.md](concepts/navigation_aware_loss_formulation.md)
