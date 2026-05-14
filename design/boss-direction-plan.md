# Boss-as-Puzzle Direction — Session Plan

**Direction:** Boss-as-puzzle
**Branch:** boss-direction (off experimental)
**Total hours:** 8
**Date started:** 2026-05-14

---

## Hour-by-hour plan

**Hour 1 — Clean slate**
Strip experimental branch down to just the player and charge-and-release mechanic. Wave spawner gone, upgrades gone, enemy variants gone.
End state: you can aim and shoot at nothing. Build runs without errors.

**Hour 2 — Boss skeleton**
A single enemy entity exists in the scene. It moves toward the player with one readable attack pattern (telegraph + execute). No weak point yet — just movement and attack.
End state: something is trying to kill you.

**Hour 3 — Weak point**
Add one weak point with hit detection. Shots to weak point do something meaningfully different from shots elsewhere — damage multiplier, stagger, phase change, whatever fits.
End state: there's a reason to aim carefully.

**Hour 4 — Boss loop**
Boss has a health pool, a death state, and a reset. Player can attempt the encounter, fail or succeed, and try again without restarting the scene.
End state: the encounter is repeatable.

**Hour 5 — Internal playtest**
Play it yourself. Not to validate the pillar — your own judgment doesn't count for that — but to catch anything that makes it unplayable for an external tester. Fix only blockers.
End state: an external playtester could sit down and play this without you explaining anything.

**Hour 6 — External playtest**
Get someone in front of it. Watch, don't coach. Log observations and quotes immediately after.
End state: playtest entry written in the log.

**Hour 7 — Evaluate and decide**
Read the playtest log entry against refutation and extension criteria (see current-state.md). Does the pillar survive, transform, or die? If signal is ambiguous, identify the cheapest follow-up experiment.
End state: a clear decision on whether to extend, pivot, or kill.

**Hour 8 — Buffer**
Use for slippage from hours 1–7. If on track, use for a second external playtest to strengthen the signal.

---

## Critical checkpoint

**End of hour 4:** Boss loop must be playable. If not, cut scope — simpler attack pattern, weaker hit detection, whatever gets to repeatable fastest. Do not let boss complexity eat playtest time.

---

## Scope constraints (from direction brief)

- One boss, one attack pattern, one weak point — minimum that tests the pillar
- Aiming mechanic unchanged — only touch if hours allow after hour 4
- No juice work until pillar is validated
- Strip all frantic-build features before building anything new

---

## Hours log

| Session | Hours spent | Cumulative | Notes |
|---|---|---|---|
| 2026-05-14 | 0 | 0 | Plan written, branch decision made |

*Update after each session.*
