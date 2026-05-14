# Playtest Log Template

**Purpose:** The evidence trail. Every playtest that produces learning gets an entry. This is your proof when claiming pillars are validated, and the record of how the game evolved during prototyping.

**Living document?** Append-only. Never edit or delete existing entries. New entries go at the top (most recent first) so the latest learning is always visible.

**Where it lives:** `/design/playtest-log.md` in the project repo.

---

## How to use this template

**When to add an entry:** After any playtest (internal or external) that produced learning. Routine "does the build still run" testing doesn't need an entry. If you observed something or a player said something that shifted your thinking, log it.

**Verdict discipline:** Per-pillar verdicts are *optional* per entry. Only assign a verdict when the playtest genuinely moved your thinking on that pillar. Most entries will just describe observations and leave verdicts unspoken — that's correct.

**When pillars die:** When a playtest entry assigns "dies" to a pillar, also update `current-state.md` to remove that pillar from the active list. The log entry is the evidence; the state doc reflects the consequence.

**Internal vs. external:** Log both, but mark which. External playtest evidence carries more weight — your own playtesting is biased toward the game you want to make.

---

## TEMPLATE BELOW THIS LINE

---

# [Game Title] — Playtest Log

[Most recent entries at top. Append-only. Do not edit past entries.]

---

## [YYYY-MM-DD] — [Short title for this playtest]

**Type:** Internal / External

**Direction tested:** [Name of the experimental direction this build represents]

**Build version / commit:** [git hash or build label, if applicable]

**Player(s):** [Self / Name or initials of external playtester / number of external playtesters]

**Session length:** [How long they played]

---

**Pillars under test (per direction brief):**
- Pillar A: [name]
- Pillar B: [name]

---

**What you observed:**
[Bullet list. Concrete behaviors — what the player actually did, where they hesitated, where they smiled, where they got stuck. Avoid interpretation here; just describe.]

- [Observation]
- [Observation]

---

**What the player said:**
[Direct quotes where possible. Both during play and after.]

- "[Quote]"
- "[Quote]"

[For self-playtests, write down your own gut reactions while playing. These are weaker evidence than external feedback but still worth capturing.]

---

**Verdicts (only fill in pillars where this playtest actually shifted your thinking):**

- **Pillar A:** [survives / transforms / dies] — [1-2 sentence justification tying back to observation or quote above]
- **Pillar B:** [no shift — leave blank or omit]

[Most entries should have zero or one verdict. Multiple verdicts in one entry is rare and means a major pivot.]

---

**Decision triggered:**
[What you're going to do as a result of this playtest. Options:]
- Continue current direction (no change)
- Continue with adjustment: [what specifically]
- Extend direction past 8-hour cap (requires external playtest evidence supporting this)
- End direction — graduate to next direction
- End direction — kill it (move on)
- Pivot project — pillars changed enough that the game is becoming something different

---

**Notes for future self:**
[Anything else worth remembering — surprises, ideas, things to test next time. Keep short.]

---

## [Older entry below, same structure]

---

## How entries should feel

Good entry: short, concrete, verdicts only where earned, decision is clear.

Bad entry: paragraphs of interpretation, verdicts assigned to every pillar by default, no clear decision.

If you find yourself writing long entries, ask whether you're processing in real-time (fine, but trim before committing) or rationalizing a foregone conclusion (bad — the log loses its value if entries are written to justify decisions you'd already made).

---

**End of template. Remember: append-only. Past entries are evidence, not drafts.**
