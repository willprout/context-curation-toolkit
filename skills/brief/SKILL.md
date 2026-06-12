---
name: brief
description: Use whenever this session is about to write a kickoff, handoff, or briefing prompt for another session -- usually an orchestrator volunteering the next kickoff after an execution report. Not typically typed by the user. Ensures handoffs are thin briefings rendered inline, never step-by-step scripts or bare file references.
---

# Brief -- the thin kickoff template

A kickoff transfers the few things a fresh session cannot derive from the repo, and
nothing else. The fresh session is smart and fully informed once it reads the code --
prescriptive plans written before that point cap its ceiling. Constraints, context, and a
goal; not a script.

**If this project has its own kickoff template**, follow that template instead of the
section list below -- but the standing-instructions block (item 7) and the rendering rules
at the bottom still apply regardless.

## Sections -- <= ~40 lines total

1. **Goal** -- outcome-shaped, one or two sentences. What is true when this is done, not
   what activities to perform.
2. **Decisions already made** -- choices that must not be relitigated, each in one line.
   (Only real ones; don't promote preferences to decisions. Cross-cutting contracts other
   work will build against -- shared mechanisms, interfaces, naming -- count as decisions.)
3. **Discoveries paid for** -- gotchas, dead ends, root causes that cost prior sessions
   real time. The most valuable content here; never omit it to save space.
4. **Definition of done** -- the evidence that proves it: test counts, an artifact to
   open, behavior to drive in the running app.
5. **Boundaries** -- what the session may do without asking; where it must stop and report.
6. **Read first** -- file paths the session should read itself, in order. Never paste
   content that lives on disk.
7. **Standing instructions -- include VERBATIM as the closing block:**

> Read the listed files and the relevant code before planning anything. If there is a
> genuine choice of approach, present the options with tradeoffs before building;
> otherwise just proceed. Follow this project's CLAUDE.md gates and conventions where
> they exist. Verify with evidence before claiming done. End with a short plain-language
> report: what we set out to do, what is verifiably true now (with the evidence), open
> items, surprises.

## What does NOT go in a brief

- Step-by-step implementation plans or pre-chosen approaches (the fresh session plans
  after reading).
- Restatements of what's already in the repo's docs (point to them instead).
- Defensive instruction lists ("don't forget to...", "make sure you...") -- the standing
  block covers it.

## Rendering rules (always)

- Render the FULL briefing inline in chat as one fenced copy-paste block. Never hand the
  user only a file path -- the inline text is how they audit the brief before pasting it.
- If the project's convention requires the kickoff as a file too, write the file AND
  render the full text inline. Both, never file-only.
