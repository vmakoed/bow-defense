# Bow Defense — Playtest Log

[Most recent entries at top. Append-only. Do not edit past entries.]

---

## 2026-05-20 — Playtest 5 (randomized weak points, boss jumping, Ove)

**Type:** External

**Direction tested:** Boss-as-puzzle

**Player(s):** Ove Danner (fresh — had not seen the game before)

**Session length:** 20+ minutes (including post-play discussion)

---

**Pillars under test:**
- Impactful shots

---

**What you observed:**
- Initial confusion with controls — did not understand pulling direction at first (thought it might be 3D perspective)
- Once mechanic clicked, engaged immediately
- Developed strategy organically: started chaotic, then recognized static shooting enemies are bigger threat, prioritized them
- Pull distance vs. charge disconnect noticed — pulling far from center had no visible effect
- Played multiple rounds

**What the player said:**

Thinking during play:
- "Mostly, what to focus on first. Which enemies to get first."
- Strategy evolved: "I realized that the static bad guys always hit me at a predictable cadence. Probably better to shoot them first whilst making sure none of the others touch me."

Felt good:
- "The moment you hit a bad guy and they go down. It's pretty nice. The splatter animation is very satisfying."
- "Especially when you reach an enemy further away, that's very nice." — unprompted, about harder shots being more rewarding
- "The harder shots are nicer." — direct confirmation of pillar
- Sound effects satisfying

Felt frustrating:
- Charge mechanic disconnect: "The difference between what I see when I try to make that charge and what happens. I pull it back pretty far away in screen coordinates, but that doesn't help me."
- Higher charge shots could feel more satisfying
- Controls initially confusing — thought shooting direction was into or out of screen (3D interpretation)

Other feedback:
- "Add color" — monochrome abstraction adds to initial confusion
- Suggested making pull area larger for more reach
- Suggested deflecting enemy projectiles as a mechanic
- Noted charge should ideally be distance-based, not purely time-based
- Suggested boss projectiles be slower and larger so player could shoot them down
- Controls felt laggy on web build — likely a framerate/browser limitation

---

**Verdicts:**
- **Impactful shots:** survives — "the harder shots are nicer" is direct unprompted confirmation of the pillar. Tester developed a deliberate strategy without guidance. Named specific shot moments. Did not ask for a different mechanic.

---

**Decision triggered:**
Pillar confirmed. All four original production point criteria met. Fifth criterion (full mechanical system validated) not yet met — this direction has validated the shooting mechanic but not a complete mechanical system. Further prototyping directions needed before production point.

---

**Notes for future self:**
"The harder shots are nicer" is the clearest pillar confirmation yet. Tester reached the "felt powerful" moment — strategy clicked, harder shots rewarded deliberate aiming. Charge mechanic disconnect is a recurring issue across multiple testers and needs to be addressed. Distance-based charge is worth exploring as a direction. Deflectable boss projectiles noted by two testers now — worth exploring as a direction.

---

## 2026-05-17 — Playtest 4 (post-QoL improvements)

**Type:** External

**Direction tested:** Boss-as-puzzle

**Player(s):** 1 external playtester (fresh)

**Session length:** Unknown

---

**Pillars under test:**
- Impactful shots

---

**What you observed:**
- Started tactical, switched to frantic swiping once more enemies appeared on screen
- Did not charge shots at boss consistently — seemed to understand the mechanic but forgot under pressure
- Had visibility issue: was playing with index finger on mobile, right side of screen obscured by hand
- Ignored enemies until they came close, focused on boss weak points — and won using this strategy
- Got into a flow state once strategy clicked
- Did not charge shots at all times despite understanding the mechanic

**What the player said:**
- "Pulling back deals more damage" — confirmed they understood charge mechanic
- Said it became easy once they realized boss weak point positions don't change
- Was not clear if there is a score for winning with more health remaining
- Lacked visuals to indicate boss is about to change state
- Advised exploring more tactical options (like passive defenses) to allow focus on one screen area
- Felt good: pulling back deals more damage; flow state once strategy figured out
- Felt frustrating: hand obscuring screen; unclear if health remaining at win gives a score

---

**Verdicts:**
- **Impactful shots:** transforms — playtester reached flow state and described specific satisfying moments (charge mechanic, strategy payoff), but defaulted to frantic swiping under pressure. Pillar is present but requires clearer conditions to surface consistently.

---

**Decision triggered:**
Continue with adjustment — boss weak point positions should vary to maintain decision pressure after strategy is discovered. Charge mechanic needs stronger feedback loop to keep players charging under pressure.

---

**Notes for future self:**
Flow state is the signal you're looking for. It appeared once strategy clicked. The obstacle is that pressure collapses tactical play into frantic swiping before strategy can emerge. Solve that and the pillar surfaces more reliably.

---

## 2026-05-17 — Playtest 3 (boss shoots at player + basic UI labels)

**Type:** External

**Direction tested:** Boss-as-puzzle

**Player(s):** 1 external playtester (fresh, mobile)

**Session length:** Unknown

---

**Pillars under test:**
- Impactful shots

---

**What you observed:**
- Did not understand the goal
- Prioritized quick swipes over charged shots to clear enemies
- Did not charge shots — felt game was unbalanced because was dealing little damage as a result
- Reminded of Angry Birds — expected a relaxed, at-your-own-pace experience; reality was more frantic
- Did not intuit that killing weak spots does not despawn enemies
- Charge mechanic not immediately understood
- Knockback effect on enemies more obviously communicated than charge affecting damage

**What the player said:**
- "Where is my health?"
- "Not intuitive that killing weak spots does not despawn enemies"
- "Feels like less suitable for quick sessions on mobile — more a game to sit down with, not something you'd play on the bus"
- "Appreciated balance with tactics and choice where to shoot at any given moment"
- "Knockback effect is more obvious than charge affecting damage"
- "For first time playtesters, let the player win on the first level"
- Felt frustrating to lose without understanding why

---

**Verdicts:**
- **Impactful shots:** survives weakly — playtester named tactical choice and appreciated it directly, but could not access the pillar consistently due to legibility issues (charge mechanic unclear, objective unclear, health not visible).

---

**Decision triggered:**
Continue with adjustment — add health bar with label, charge bar with label, boss health bar with label. Slow enemies, reduce enemy arrow damage. Get build into another playtester's hands immediately.

---

**Notes for future self:**
"Appreciated balance with tactics and choice where to shoot" is the pillar showing up in playtester language unprompted. That's the signal. Legibility problems are burying it.

---

## 2026-05-17 — Playtest 2 (difficulty tuned, spawn delay added)

**Type:** External

**Direction tested:** Boss-as-puzzle

**Player(s):** 2 external playtesters (fresh)

**Session length:** Unknown

---

**Pillars under test:**
- Impactful shots

---

**What you observed:**
- Tester 1: started tactical, discovered weak points through experimentation, made an arc shot over the boss — deliberate tactical aiming
- Tester 1: relationship between weak points and boss damage not immediately clear
- Tester 2: felt immediate panic when enemies closed in — noted this positively
- Tester 2: confused by three blocks appearing simultaneously
- Both testers beat the boss after difficulty tuning
- Boss felt too easy after tweaks from Viktar's perspective

**What the player said:**
- Tester 1: recognized boss health reducing and took it as a hint
- Tester 1: "fun to shoot in general" — health bar going down gave number-goes-up satisfaction
- Tester 1: weak point phases not intuitive — timing between phases, why boss only takes damage for limited time
- Tester 2: "not much to it"
- Tester 2: "felt nice to hit the block right before it hits you"
- Tester 2: "appreciated seeing bullet trajectory"
- Both: asked for more juice and variety

---

**Verdicts:**
- **Impactful shots:** survives — tester 1 made an unprompted arc shot and named specific satisfying moments. Tester 2 described hitting block before it hits you as feeling good. Neither asked for a different mechanic or faster shooting.

---

**Decision triggered:**
Continue — pillar survives. Legibility of weak point mechanic is main obstacle. Boss shooting directly at player identified as next change to make threat more apparent.

---

**Notes for future self:**
Arc shot over the boss is the clearest pillar evidence so far. Tester discovered it themselves, executed it deliberately, and it worked. That's what you're building toward.

---

## 2026-05-17 — Playtest 1 (first external playtest, base boss build)

**Type:** External

**Direction tested:** Boss-as-puzzle

**Player(s):** 1 external playtester (fresh)

**Session length:** Unknown

---

**Pillars under test:**
- Impactful shots

---

**What you observed:**
- Ignored boss entirely, shot only at spawned enemies in survival mode
- Did not understand there was a win condition
- Did not attempt to shoot boss weak points
- All attention on enemies that attacked directly
- After nudge in post-interview: noted boss as cool addition, appreciated need to aim carefully when enemy spawns between boss and player

**What the player said:**
- (Post-nudge) "Boss is a cool addition"
- "Too difficult — window to shoot weak points is too short, enemies respawn too soon"
- "Did not have time to think — was fixed on killing enemies"
- "Would want more visual clarity when hitting the boss"
- Thinking during play: "What do I need to do? How do I shoot? Where do I shoot? Hard to think, feeling overwhelmed"
- Felt good: enemy knockback
- Felt frustrating: "What am I supposed to do?"

---

**Verdicts:**
- **Impactful shots:** no verdict — test did not run cleanly. Playtester played a different game (survival) than designed. Nudge required before boss was noticed. Evidence tainted.

---

**Decision triggered:**
Continue with adjustment — objective not legible. Implement spawn delay until player lands first hit on boss. Reduce difficulty: spawn timeout 1s → 3s, hurt areas visible 10s → 20s.

---

**Notes for future self:**
Null result, not a refutation. The pillar wasn't tested — the objective wasn't understood. Fix legibility first, then test again.
