# Bow Defense — Current State

**Last updated:** 2026-05-21

---

## Current pillars

**Pillar 1: Impactful shots** — Status: **validated**
- What it means: Every shot is both a meaningful tactical choice and a physically satisfying act of execution. The decision and the execution reinforce each other; neither works alone.
- Evidence: 5 external playtests completed in boss-as-puzzle direction. Pillar confirmed by Ove (playtest 5) — "the harder shots are nicer" unprompted, strategy developed organically, 20+ minute session. Multiple testers named specific shot moments, none asked for a different mechanic.

---

## One sentence: why is this game fun?

"This game is fun because when you figure out the optimal strategy under pressure, you feel powerful."

— Confirmed by playtest 5. Tester developed deliberate strategy unprompted and named harder shots as more rewarding.

---

## Current core loop

Player faces a stationary boss that telegraphs attacks by shooting particles, then launches projectile enemies at the player. After launching, the boss exposes weak points at randomized positions across its body. Player must decide each phase: shoot incoming enemies (direct threat) or shoot boss weak points (progress toward win condition). Boss jumps left/right when hit. Weak points disappear after a timer. Boss dies when health reaches zero.

Player uses charge-and-release mechanic: pull back to charge, release to fire. Charge affects damage. Knockback on enemies confirmed satisfying by multiple testers.

---

## What's been validated

- Charge-and-release mechanic is functional and not actively unpleasant
- Knockback effect on enemies feels satisfying — named by multiple testers unprompted
- Placeholder art style is acceptable for playtesting
- "I want more of this" criterion met — multiple testers asked for more variety and tactical options
- Tactical decision layer exists and is appreciated when playtesters reach it
- Pillar 1 (impactful shots) confirmed — harder shots are more rewarding, strategy emerges organically
- Criterion 4 confirmed — "the harder shots are nicer" matches the one-sentence directly

---

## What's still untested

- Whether randomized weak point positions sustain engagement across multiple runs (implemented, one partial test)
- Whether boss jumping adds meaningful variety or is noise
- Whether the full mechanical system can sustain varied challenges across a full game (criterion 5 — not met)
- Charge mechanic disconnect is a recurring issue — distance-based charge not yet explored
- Deflectable boss projectiles noted by two testers — not yet explored
- Session lengths still not consistently logged

---

## Production point status

| Criterion | Status | Notes |
|---|---|---|
| 1. Surviving pillars have playtest evidence | Met | Pillar confirmed across multiple testers, not refuted |
| 2. Core loop engaging 5+ minutes | Met | Playtest 5 ran 20+ minutes |
| 3. Playtesters say "I want more" unprompted | Met | Multiple testers asked for more variety and tactical options |
| 4. One sentence articulated, players agree | Met | "The harder shots are nicer" — Ove, unprompted |
| 5. Full mechanical system validated, sustains varied challenges | Not met | Only one mechanic validated; no complete system yet |

**Conclusion:** Criteria 1–4 met. Criterion 5 not met. Still in prototyping. Further directions needed to build and validate a complete mechanical system.

---

## Active direction

**Direction:** Boss-as-puzzle — **complete**

**Branch:** boss-direction (off experimental)

**Hours used:** ~8 of 8

**Outcome:** Pillar validated. Direction complete. Shooting mechanic confirmed as core. Next direction should explore additional mechanics that complement the validated pillar.

---

## Candidate next directions

These emerged from playtest feedback and open design questions. Each needs a falsifiable hypothesis before starting:

1. **Distance-based charge** — charge power determined by pull distance, not hold time. Multiple testers noted disconnect between visual pull and actual effect. Hypothesis: distance-based charge makes the mechanic more legible and more satisfying.

2. **Deflectable boss projectiles** — player can shoot incoming boss projectiles to cancel them. Two testers suggested this independently. Hypothesis: deflecting projectiles creates a new tactical layer that complements weak point targeting.

3. **Wave-based pressure** — return to wave enemies but designed around the validated pillar (deliberate aiming, strategic prioritization). Hypothesis: waves can create sustained pressure without collapsing into frantic swiping if enemy design forces deliberate shots.

---

## Open design questions

- How do we create pressure without overwhelming playtesters into frantic swiping?
- What kinds of strategies can players develop beyond "prioritize the biggest threat"?
- How does the game keep throwing fresh challenges so old strategies don't fully solve it?
- What extrinsic goals support the gameplay core — score, leaderboard, level progression, unlocks?
- When is shooting satisfying enough to lock the mechanic?

---

## Known recurring issues across playtests

- Charge mechanic not consistently used under pressure — players revert to quick swipes
- Objective legibility — took multiple iterations to make boss the obvious target
- Monochrome art style adds to initial confusion for some testers
- Web build framerate feels laggy — not representative of native performance
- No reward for winning with health remaining — noticed by multiple testers

---

**End of current state. Update when pillars evolve or direction ends. Append all playtests to `playtest-log.md`.**
