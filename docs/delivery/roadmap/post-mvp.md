# Post-MVP Roadmap

This document captures the planned product evolution after the MVP ships. It preserves the phased structure from `docs/01-product/product-roadmap.md` and adds the features explicitly deferred from MVP scope.

See [mvp/scope.md](../mvp/scope.md) for the boundaries of what ships in Phase 1.

---

## Deferred from MVP

These items were in scope discussions but deliberately moved out to keep the MVP focused:

| Item | Reason Deferred |
|------|-----------------|
| **Programs** (FA-04) | Programs are collections of routines targeting a specific goal (Muscle-Ups, Planche, Leg Day, Upper Body). The domain distinction from Routines requires more design. Deferred to Phase 2. |
| **Community and social challenges** (FA-09) | Community engagement features risk scope creep for a solo-maintained MVP. Deferred to Phase 2. |
| **AI coaching** (FA-11) | AI recommendations require training data from real usage patterns that only exist post-launch. Deferred to Phase 3. |

---

## Phase 2 · Intelligent Guidance

**Theme:** Move from basic tracking to informed guidance.

**Capabilities:**
- **Programs** — Goal-oriented collections of routines (e.g. Muscle-Ups, Planche, Upper Body, Leg Day). Users follow a structured progression toward a specific end goal.
- **Adaptive progression suggestions** — Suggest weight, rep, or volume adjustments based on recent performance history.
- **Recovery-aware workload guidance** — Surface rest day recommendations based on training load and history.
- **Better trend analytics and alerts** — Weekly and monthly trend visualizations with threshold-based alerts for consistency drops.
- **Community and social challenges** — Shared challenge boards, streak comparisons, and peer accountability features.

**Entry criteria:** MVP is live with at least 4 weeks of real usage data.

---

## Phase 3 · AI Coaching Layer

**Theme:** Personalized, explainable coaching at scale.

**Capabilities:**
- **AI coaching recommendations** (FA-11) — Daily training suggestions derived from user history, goals, and patterns.
- **Goal path planning** — AI-generated progression plans toward stated goals.
- **Explainable guidance** — Every recommendation includes an explanation of why it was generated so users trust it.
- **Longitudinal insight summaries** — Monthly and quarterly summaries of key patterns and achievements.

**Entry criteria:** Phase 2 delivered; sufficient training data from active users.

---

## Phase 4 · Connected Ecosystem

**Theme:** Extend reach to external data sources and coach relationships.

**Capabilities:**
- **Wearable integrations** — Import heart rate, HRV, and recovery data from wearables.
- **Advanced recovery intelligence** — Combine wearable signals with training load for smarter rest recommendations.
- **Expanded modality support** — Support for additional movement types beyond calisthenics (e.g. weightlifting, mobility, cardio).
- **Coach and mentor workflows** — Let coaches create programs for athletes and track their progress.

**Entry criteria:** Phase 3 delivered; sufficient user base to justify integration investment.

---

## Phase 5 · Fitness Operating System

**Theme:** Become the long-term intelligence layer for a user's fitness life.

**Capabilities:**
- **Highly personalized lifecycle guidance** — Adapt plans to life stages, injury history, and evolving goals.
- **Multi-year adaptation intelligence** — Detect and respond to long-term performance trends.
- **Natural-language planning and reflection** — Let users interact with their training plan in plain language.

**Entry criteria:** Phase 4 delivered; sustained active user base with multi-year history.

---

## Roadmap Principles

From `docs/01-product/product-roadmap.md`:
- Ship independent user value each phase.
- Build reusable foundations before scaling complexity.
- Validate before adding intelligence.
- Prefer capability maturity over feature count.
