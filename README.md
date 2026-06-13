# Context Curation Toolkit

**A simple session architecture for working with Claude Fable -- for vibe coders, solo builders, and anyone who manages AI sessions instead of writing code by hand.**

No frameworks, no servers, no subscriptions. Three small skill files, a few standing rules, and a way of organizing your chats that fits how this model actually behaves. Read this page in ten minutes, run it in five more.

---

## Start here: what Fable is like

If you just started using Claude Fable 5, here's the honest profile.

**What it does brilliantly:** Fable is Anthropic's most capable model -- a tier above Opus, built for long, autonomous, many-step work. Give it a goal and the context it can't find on its own, and it will read your whole project, make a better plan than you could write, execute it for as long as it takes, check its own work along the way, and explain what it did in plain language. When it has room to breathe, it genuinely feels like magic.

**What it does poorly:** Fable is extremely **sticky to its context**. Whatever is in the conversation window -- your instructions, its own earlier statements, the approach it tried an hour ago -- becomes load-bearing. It takes all of it seriously, permanently. Three ways this bites you:

1. **Your instructions become rails.** Spell out the steps and it will follow your steps -- faithfully, even when it would have found a better way on its own. Anthropic's own guidance for Fable says this outright: prompts written for earlier models are often too prescriptive and *reduce* output quality. A scripted Fable session performs like any older model, because the script is doing the thinking.
2. **Its own past output becomes a commitment.** A session that proposed a solution will *defend* that solution. Push back and you'll often get the same position restated with more confidence -- stubbornness, not reconsideration. It can't impartially judge work that's sitting in its own context.
3. **Long conversations accumulate framing it can't escape.** Deep into a session, it stops seeing alternatives -- not because it got dumber, but because everything it "knows" is soaked in the path it already took.

Here's the key insight: **the superpower and the flaw are the same trait.** Fable takes its context window deadly seriously. Feed it good context and freedom, and you get the magic. Feed it scripts, stale history, and its own old opinions, and you get an obedient, stubborn version of a much weaker model.

So the whole game is: **control what goes into each session's context, and be ruthless about starting fresh ones.** That's not a prompt-writing trick -- it's an architecture. Here it is.

---

## The architecture: one orchestrator, many fresh workers

You run two kinds of chat sessions, with deliberately different jobs and deliberately different contexts:

**The orchestrator** -- one long-lived chat that holds the *picture* of your project. It's your advisor and translator: it explains things in plain language, tracks where you are, helps you decide what's next, and writes the handoff for each task. Crucially, **it never writes code**. Its context stays high-level on purpose -- decisions, status, plans -- so it stays good at the one thing stickiness can't ruin: conversation and judgment about *direction*.

**Execution sessions (workers)** -- a brand-new chat for every task. Each one gets a short briefing, reads your actual project fresh, plans its own work, builds, verifies, reports back -- and is then thrown away. Workers get the "room to breathe" where Fable shines: no accumulated framing, no prior commitments, no leftover instructions from three tasks ago. Fresh context is free, and it's the single most powerful tool you have.

Why the split follows directly from the model's nature:

- A session that's been *planning* all day shouldn't also *build* -- it would be railroaded by its own plans.
- A session that *built* something shouldn't *judge* it -- it's anchored to its own work.
- A worker drowning in implementation detail shouldn't also hold your project's big picture -- and vice versa.

One sentence to remember: **you author intent, the freshest context authors plans, evidence authors trust, and no session grades its own homework.**

---

## Starting an orchestration

An orchestrator doesn't know it's an orchestrator -- you have to tell it. Open a fresh chat in your project and give it its role in plain words:

> You are my orchestration session for this project. I'm not a developer -- explain things in plain language and define jargon before I make decisions. When I paste a worker session's report, check it against what we intended, then volunteer the next task briefing without being asked. Keep decisions and project status in files, not just in this chat. You write briefings and answer my questions -- the building happens in fresh sessions, not here.

Then point it at your project's key files and let it play the picture back to you before anything starts.

Orchestrators go stale -- their picture of the project drifts from reality, and stickiness applies to them too. So **rotate them at every milestone**: that's what the **`/refresh`** skill is for. Run it in the *old* orchestrator and it emits one copy-paste block that fully boots its successor -- the role text above, what to read, where things stand, what's next. Killing an orchestrator costs you nothing if its knowledge lives in files (more on that below), so do it freely. A telltale it's overdue: the orchestrator confidently refers to something that's since changed.

---

## The working loop

1. **Talk to your orchestrator** about what's next. When a task takes shape, it produces a **briefing** as a copy-paste block (that's the `brief` skill firing -- you never type it).
2. **Paste the briefing into a brand-new session.** The worker reads your project, makes its own plan -- and if there's a genuine fork in the road, shows you the options before building. Then it builds, verifies, and ends with a short plain-language report: *what we set out to do, what is verifiably true now (with evidence), what's open, what surprised me.*
3. **Paste that report back to the orchestrator.** It checks the outcome against the intent and volunteers the next briefing.
4. Repeat. New task, new worker -- always.

Notice that **everything travels through you as a paste-block.** Nothing hides in files you'd never open; every handoff passes under your eyes in plain English. You don't need to read code to supervise this -- you read briefings and reports.

---

## Briefings: give the worker room to breathe

Now -- and only now -- the part about handoff length. Because workers excel when unconstrained, a briefing carries **constraints, context, and a goal. Never a script.**

What a fresh session genuinely cannot figure out from your project:

1. **The goal** -- what's true when this is done. One or two sentences.
2. **Decisions already made** -- so settled questions don't get reopened.
3. **Lessons already paid for** -- the gotcha that cost a day, the dead end already explored. The most valuable content, and the most often forgotten.
4. **What "done" means** -- the proof: tests pass, the page loads, the file opens.
5. **Boundaries** -- what it may do alone; where it must stop and ask.
6. **What to read first** -- file names, not pasted content.

Everything else -- the plan, the approach, the order of steps -- the worker figures out *after* reading your project, which it does better than you can summarize. A good briefing is 20-40 lines. If yours run longer, you're scripting again, and you'll get the obedient-weak-model version of Fable.

**The self-test:** if your worker sessions would produce the same result on a weaker model, your briefings are doing the model's thinking for it. Thin them until the model surprises you again.

---

## When stickiness strikes anyway: `/fresh-eyes`

Even with this architecture, a session will sometimes fall in love with its own solution. You don't need technical knowledge to catch it -- watch the *shape* of its pushback:

- **Healthy pushback brings new evidence** and engages your actual point. (Often it's right -- you want a model that challenges you.)
- **Anchored pushback restates.** Same position, more confidence, nothing new: *"what I suggested really is the best approach."*

The moment you see restatement instead of engagement, **stop arguing** -- you're talking to an advocate now, not a thinker. Run **`/fresh-eyes`** in that session. It writes a neutral, first-principles prompt -- the problem, the constraints, every candidate approach described evenly, *without revealing which one it was defending* -- and you paste that into a brand-new session for an unbiased verdict. Two minutes of fresh judgment versus days of building on a defended-but-wrong approach.

Use it a handful of times per project -- at genuinely important decisions, or when a session digs in. More than that and you've reinvented bureaucracy.

---

## A word on effort levels

Claude Code has a dial most new users never touch: `/effort` controls how hard the model thinks before acting -- more effort means deeper reasoning and better judgment, at the cost of more tokens and slower turns. It pairs naturally with the architecture:

- **Workers: `high`.** A good default for execution sessions -- strong reasoning across many build-and-verify turns without burning tokens on routine steps. If a worker dawdles or over-deliberates on simple tasks, this is the right setting, not higher.
- **Orchestrator: `xhigh`.** The orchestrator takes few turns, and every one of them is pure judgment -- what's next, does this report match intent, what goes in the briefing. Spending extra thinking on those few turns is cheap insurance against a bad plan that a worker then faithfully executes.
- **`ultracode`, when the budget allows.** If your setup supports it, typing `ultracode` in a prompt (or `/effort ultracode`) unlocks multi-agent orchestration -- Claude fans out whole teams of subagents inside one session. Two places it genuinely earns its cost: **large, sweeping changes** (audits, migrations, anything touching many files at once), and a **heavyweight version of fresh-eyes** -- instead of one second opinion, several independent skeptics each try to tear the solution down, and only findings that survive come back to you. It's token-hungry, so treat it as a tool you reach for deliberately, not a default.

None of this is mandatory -- the architecture works at any setting. But if results feel shallow, effort is the first dial to check before blaming the model.

---

## The habits that hold it together

- **Evidence, not claims.** Every session ends by reporting what is *verifiably* true -- tests run, page actually loaded, file reopened -- never just "I made the changes."
- **Keep project state in files, not in chat memory.** Decisions, status, to-dos live in your project folder. The test: *"if I closed this session right now, what would I lose?"* The right answer is **nothing that isn't written down** -- that's what makes workers disposable and orchestrator rotation painless.
- **New goal, new session.** Fresh context is free. A session nursed through five tasks is a session marinating in its own framing.
- **Hard rules deserve hard enforcement.** Anything that must *never* happen -- pushing straight to production, spending money -- belongs in real guardrails (permission rules, branch protection), not prompt text. Prompt rules are advice; guardrails are physics. Smarter models are also better at rationalizing.

---

## What's in this repo

This repo contains the three skills and one shared Claude Code rule file that make the workflow concrete:

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

- `skills/brief/SKILL.md` teaches Claude to write thin, copy-pasteable task briefings instead of step-by-step scripts.
- `skills/fresh-eyes/SKILL.md` emits a neutral second-opinion prompt when a session may be anchored to its own solution.
- `skills/refresh/SKILL.md` rotates an old orchestrator into a fresh successor without losing the project picture.
- `claude/CLAUDE.md` contains standing rules for handoffs, plans, pushback, session endings, and verification.
- `scripts/install.sh` copies the skills into your local Claude Code skills folder and appends the standing rules if they are not already present.

---

## Installation

### Quick install

Clone this repo and run the installer:

```bash
git clone https://github.com/willprout/context-curation-toolkit.git
cd context-curation-toolkit
./scripts/install.sh
```

Then restart any open Claude Code sessions so they load the new skills and standing rules.

The installer copies:

- `skills/brief/SKILL.md` to `~/.claude/skills/brief/SKILL.md`
- `skills/fresh-eyes/SKILL.md` to `~/.claude/skills/fresh-eyes/SKILL.md`
- `skills/refresh/SKILL.md` to `~/.claude/skills/refresh/SKILL.md`
- `claude/CLAUDE.md` into `~/.claude/CLAUDE.md`, if the handoff rules are not already there

### Manual install

If you prefer to install by hand, create the three skill folders:

```bash
mkdir -p ~/.claude/skills/brief
mkdir -p ~/.claude/skills/fresh-eyes
mkdir -p ~/.claude/skills/refresh
```

Copy the skill files:

```bash
cp skills/brief/SKILL.md ~/.claude/skills/brief/SKILL.md
cp skills/fresh-eyes/SKILL.md ~/.claude/skills/fresh-eyes/SKILL.md
cp skills/refresh/SKILL.md ~/.claude/skills/refresh/SKILL.md
```

Then add the contents of `claude/CLAUDE.md` to your `~/.claude/CLAUDE.md` file. Create it if it does not exist.

Restart open Claude Code sessions after installing.

---

## FAQ

**Do I need to be a programmer?**
No -- this system was built by a non-programmer, and that's the point. Your job is reading briefings and reports (plain English), making decisions, and noticing when a session is defending instead of thinking. The model handles the code; the architecture keeps you genuinely in charge anyway.

**Does this work with models other than Fable?**
The habits (evidence over claims, fresh eyes, state in files) help with any model. But thin briefings specifically assume a model smart enough to out-plan your script -- that's Fable-class. On weaker models, detailed step-by-step prompts are still the right call.

**Isn't a long-lived orchestrator exactly the "sticky session" you warned about?**
Yes -- which is why it never builds anything (nothing to get anchored to), keeps its knowledge in files, and gets rotated with `/refresh` at every milestone. The orchestrator is allowed to live longer because its job is conversation and judgment, not producing solutions to defend.

**What if a worker session does something wrong?**
That's what "definition of done" and the evidence-backed report are for -- you see what was verified and what wasn't, in plain language. And because every task runs in its own disposable session against your version-controlled project, a bad session is cheap: discard it, add what you learned to the briefing's *lessons* (not new step-by-step instructions), and start fresh.

## License

MIT
