---
name: refresh
description: Use when the user says "/refresh", wants to retire or rotate the current orchestration session, or stand up a fresh orchestrator. Run in the RETIRING orchestrator -- emits the complete successor prompt as one inline paste-block. Also works in an empty session for a brand-new project.
---

# Refresh -- hand orchestration to a fresh session

You are (probably) the retiring orchestrator. Your job now is NOT to keep working -- it is
to produce ONE copy-paste block that fully stands up your successor. The user pastes it
into a fresh session; nothing else is needed on the new side.

## If run in a session with no orchestration state (brand-new project)

Skip the emission. Adopt the role yourself: read the project's CLAUDE.md and any
status/backlog files, then present the user the picture in plain language (state, open
decisions, immediate agenda) and wait for their go.

## Otherwise: emit one paste-block containing, in order

**1. The role block -- include VERBATIM, do not paraphrase:**

> You are my orchestration session for this project. Your job: (a) advisor -- explain
> things clearly and define jargon before I make decisions; (b) when I paste an execution
> session's report, validate it against our intent in plain language, then volunteer the
> next kickoff inline without being asked -- as a thin briefing (brief skill / the
> project's kickoff template if it has one); (c) keep decisions and project state in
> files, not only in your context; (d) you write briefings and answer my questions --
> execution happens in fresh sessions, not here.

**2. Read first** -- a bounded list, not "explore everything": the project CLAUDE.md and
memory load automatically; name the specific status/backlog/roadmap files for THIS
project and, if it's a git repo, suggest a recent-history look (e.g. `git log --oneline
-15`). 3-6 items max.

**3. State of things** -- your factual report: current phase, what just finished (with the
evidence that it's true), open blockers, in-flight work owned by other sessions.

**4. Immediate agenda** -- the next 1-3 moves, and any kickoff already promised.

**5. One closing line:** "This summary is your starting picture -- verify load-bearing
details against the files as you go. Start by playing back where we are and the immediate
agenda in plain language, then wait for my go."

## Rules

- One fenced block, <= ~60 lines, plain language throughout.
- Facts you are not certain of get marked as such -- your successor inherits your claims,
  so label confidence honestly.
- Do not include step-by-step plans for future work; the agenda says WHAT is next, the
  successor decides HOW.
