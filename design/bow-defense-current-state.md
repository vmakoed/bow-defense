# Bow Defense — Current State

**Last updated:** 2026-05-14

---

## Current pillars

**Pillar 1: Impactful shots** — Status: **under test**
- What it means: Every shot is both a meaningful tactical choice and a physically satisfying act of execution. The decision and the execution reinforce each other; neither works alone.
- Evidence: Articulated through methodology conversation, not yet validated by playtest. Previous playtests gave mixed signals — physicality alone tested poorly in self-reflection; decision pressure was never cleanly tested. The combined pillar has not been tested at all.

---

## Current core loop

Player aims a charged bow at enemies approaching from random directions, using touch-based pull-back-and-release mechanics. Current build (experimental branch) includes random spawn positions around the player, multiple enemy variants, and an upgrade system that increases arrow power and spawn rate. Game becomes increasingly frantic over time as upgrades and spawn rate scale.

---

## What's been validated

- Charge-and-release mechanic is functional and not actively unpleasant — playtesters used it without complaint
- Placeholder art style is appealing despite being intended as temporary
- (No specific impactful-shots evidence yet — the pillar has not been tested)

---

## What's still untested

- The pillar itself (impactful shots)
- Whether the current frantic build supports the pillar or undermines it
- All three proposed experimental directions (boss-as-puzzle, twin arrows, hold-to-curve)

---

## Active direction

**Direction:** Boss-as-puzzle

**Started:** [fill in when coding starts]

**Hours used so far:** 0 of 8

**Hypothesis:** A single enemy designed as a puzzle — specific weak points, readable attack patterns, deliberate openings — will create both tactical choice and physical execution pressure, testing "impactful shots" more cleanly than wave-based combat. If shots feel impactful in this stripped context, the pillar is real. If they don't, the pillar isn't there.

**Per-pillar refutation criteria:**

- **Impactful shots would be refuted if:** playtesters take shots quickly without aiming carefully, OR describe the encounter as "easy" or "boring" rather than tense, OR don't talk about specific shots when asked, OR ask for more enemies/waves to make it interesting.

**What playtest evidence would tell you to extend past 8 hours:**
- A playtester says something like "I want more bosses like this" or "what's the next one?"
- A playtester describes a specific shot moment unprompted
- A playtester restarts the encounter to try a different approach
- A playtester shows the *productive* kind of frustration (wanting to master it) rather than the bad kind (wanting it to be easier)

**Kill criteria:**
- Playtester(s) lose interest within 5 minutes
- Playtester(s) describe it as a boring fight or compare it unfavorably to standard waves
- You can't articulate, after building it, what makes any specific shot in this encounter feel different from a shot in the current build
- You hit 8 hours without a playable boss encounter (scope was too big for the test)

**Scope notes for this direction:**
- One boss, one attack pattern, one weak point — minimum that tests the pillar
- Strip all current frantic-build features that don't serve the test: upgrades, multiple enemy types, random spawn waves
- Keep the existing charge-and-release aiming mechanic unchanged
- Placeholder art is fine; no juice work until pillar is validated

---

## Open questions

- Does the current charge-and-release mechanic have enough expressive range to support puzzle-style shot decisions, or will the boss need to be designed around its limitations?
- How is "boss reset" handled if the player wants to try again? Is it instant or does it require something?
- Is the boss visible from the start, or does it have an approach phase?

---

## Decision queue

- Which branch to build the boss direction on (main vs. experimental). Experimental has more features that need stripping; main may need less rework but is missing some quality-of-life code from experimental.
- Whether to do any aiming-mechanic tweaks before testing the pillar, or to commit to "current aiming + boss design only"
- Which playtesters to recruit for this specific test (people who haven't played bow defense before would give cleaner signal)

---

**End of current state. Update when pillars evolve or this direction ends. Append all playtests to `playtest-log.md`.**
