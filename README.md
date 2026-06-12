# Fable Thin-Briefing Workflow

A lightweight workflow for orchestrating Claude Code sessions in the Fable era.

This is a real working setup, distilled from daily use. The premise: Fable-class models changed where the value is. Older workflows compensated for weaker models with heavy scaffolding: long step-by-step handoff prompts, multiple review rounds, anxious context budgets. With a stronger model, those compensations often cost more than they save.

This repo replaces them with three small Claude Code skills, a few standing rules, and two habits.

It is designed for people who run one long-lived orchestrator session that hands work to fresh, disposable execution sessions. The ideas still apply if you work in single sessions.

## What You Get

- `brief`: produces thin, outcome-shaped kickoff prompts for fresh sessions.
- `fresh-eyes`: emits a neutral second-opinion prompt when a session may be anchored to its own solution.
- `refresh`: rotates a stale orchestration session into a fresh successor.
- Standing `CLAUDE.md` rules for handoffs, pushback, session endings, and verification.

## Quick Install

Clone the repo and run the installer:

```bash
git clone https://github.com/willprout/fable-thin-briefing-workflow.git
cd fable-thin-briefing-workflow
./scripts/install.sh
```

Restart open Claude Code sessions after installing.

The installer copies:

- `skills/brief/SKILL.md` to `~/.claude/skills/brief/SKILL.md`
- `skills/fresh-eyes/SKILL.md` to `~/.claude/skills/fresh-eyes/SKILL.md`
- `skills/refresh/SKILL.md` to `~/.claude/skills/refresh/SKILL.md`
- the standing rules in `claude/CLAUDE.md` into `~/.claude/CLAUDE.md`

## Manual Install

Each skill is one file at `~/.claude/skills/<name>/SKILL.md`. The filename must be exactly `SKILL.md`.

```bash
mkdir -p ~/.claude/skills/brief
mkdir -p ~/.claude/skills/fresh-eyes
mkdir -p ~/.claude/skills/refresh

cp skills/brief/SKILL.md ~/.claude/skills/brief/SKILL.md
cp skills/fresh-eyes/SKILL.md ~/.claude/skills/fresh-eyes/SKILL.md
cp skills/refresh/SKILL.md ~/.claude/skills/refresh/SKILL.md
```

Then add the standing rules from `claude/CLAUDE.md` to your `~/.claude/CLAUDE.md`.

## The Core Ideas

### 1. A Detailed Plan Caps a Strong Model's Ceiling

A handoff prompt is written by the session that knows the least. It has not read the code yet; the fresh execution session will.

Every prescriptive step in a long handoff is a guess by the less-informed party, imposed as a constraint on the more-informed one. With weaker models, that trade was often worth it because the plan acted as a floor. With a Fable-class model, it can become a ceiling.

The brief should transfer intent, constraints, and discoveries, not a script.

### 2. Only a Few Things Cannot Be Derived From the Repo

The handoff payload is small:

- Goal
- Decisions already made
- Discoveries paid for
- Definition of done
- Boundaries
- Files to read

Everything else, including the plan, approach, and ordering, is usually better derived by the fresh session after it reads the repo.

### 3. Sessions Anchor to Their Own Solutions

A session that produced solution X has X woven into its context as a commitment. Challenge it and you may no longer be talking to a thinker; you may be talking to an advocate.

The tell is the shape of the pushback. Healthy pushback brings new evidence and engages your actual point. Anchored pushback restates the position with more confidence.

When that happens, stop arguing and use `/fresh-eyes`.

### 4. Trust Evidence, Not Claims

Every substantive session ends with a short plain-language report:

- What we set out to do
- What is verifiably true now
- The evidence
- Open items
- Surprises

"The edit succeeded" is not verification. Reopening the artifact is.

### 5. Be the Transport Layer

Everything that crosses sessions renders inline in chat as a copy-paste block:

- Kickoffs
- Reports
- Fresh-eyes prompts
- Orchestrator handoffs

Do not let a session say only "I wrote it to a file." The inline text is how you audit what crosses contexts.

### 6. Rotate Sessions on Task Boundaries, Not Context Anxiety

Long context degrades strong models less than it used to. The durable problem is anchoring, not raw capability.

New goal, fresh session. Keep project state in files, so the answer to "if I killed this session right now, what would I lose?" is always "nothing important."

## The Loop

1. In the orchestrator, talk through what is next. When a task crystallizes, it volunteers a thin kickoff.
2. Paste the kickoff into a fresh execution session.
3. The execution session reads the repo, plans its own work, builds, verifies with evidence, and ends with a plain-language report.
4. Paste the report back to the orchestrator.
5. If a session starts defending its own solution, run `/fresh-eyes` and take the prompt to a fresh session.
6. At a phase boundary, run `/refresh` to stand up a successor orchestrator.

The pattern underneath: you author intent, the freshest context authors plans, evidence authors trust, and no session grades its own homework.

## Repository Layout

```text
.
|--- claude/
|   `--- CLAUDE.md
|--- scripts/
|   `--- install.sh
`--- skills/
    |--- brief/
    |   `--- SKILL.md
    |--- fresh-eyes/
    |   `--- SKILL.md
    `--- refresh/
        `--- SKILL.md
```

## License

MIT
