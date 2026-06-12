---
name: fresh-eyes
description: Use when the user says "/fresh-eyes", suspects this session is anchored to its own solution, or when you notice yourself restating a position against repeated pushback instead of bringing new evidence. Emits a neutral first-principles prompt the user pastes into a fresh session for unbiased adjudication.
---

# Fresh Eyes -- emit a de-anchored prompt for a fresh session

This session is suspected of being anchored: you produced or championed a solution, and
your judgment about it can no longer be trusted from inside this context. Your job is NOT
to re-argue your position. It is to write the prompt that lets a fresh session judge from
first principles.

## Default mode -- emit one paste-block containing:

1. **The problem** -- goal and constraints, stated neutrally. Include the relevant facts
   and file paths a fresh session needs (pointers, not pasted content where it lives on
   disk).
2. **The candidate approaches** -- ALL of them, listed symmetrically. Do NOT reveal which
   one you proposed, prefer, or already implemented. No advocacy adjectives ("robust",
   "clean", "simpler") -- describe each in the same flat register.
3. **The objections raised** -- what the user pushed back on, in their terms.
4. **The ask, verbatim:** "From first principles: which approach best serves the goal?
   Give your reasons, the real tradeoffs, and what evidence would change your conclusion.
   You may also propose an approach not listed here."

## Blind variant -- for decisions that are expensive to reverse (or when the user asks)

Emit TWO clearly-labeled paste-blocks:

- **Block 1 (paste first):** the problem and constraints only -- no candidate approaches
  at all. Ask the fresh session to derive its own approach and commit to it.
- **Block 2 (paste only AFTER it answers):** the incumbent solution, with: "Compare this
  against your derivation. Where they differ, which is right, and why?"

If two independently-derived answers agree, that's real signal. If they disagree, that's
exactly the decision the user's attention is for.

## Honesty rules

- No leading framing, no pre-justification, no "context" that is actually argument.
- If you cannot describe an alternative fairly, say so in chat before emitting -- that
  inability is itself information about how anchored you are.
- The fresh session's verdict is not binding on the user; it is a second opinion they
  weigh.
