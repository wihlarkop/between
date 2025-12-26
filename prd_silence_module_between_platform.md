# PRD: Silence Module

**Platform:** Between  
**Module:** Silence  
**Status:** MVP (Initial Focus)

---

## 1. Module Overview

Silence is the first module within the **Between** platform.

Silence allows users to consciously log periods of silence in their daily lives. It treats silence as a **first-class data object**, rather than an absence of activity.

Silence is **not** a meditation feature, focus timer, wellness tool, or productivity aid. It is strictly **observational**, not intervention-based.

Between does not help users become silent. It helps users **notice when silence already occurs**.

---

## 2. Problem Statement

Most digital systems only record explicit actions: tasks completed, messages sent, steps taken, words written. Periods of silence, pause, and inactivity are ignored, despite being a meaningful part of human experience.

As a result:
- Silence is invisible in personal data
- Reflection on silence is anecdotal and fragile
- There is no neutral way to observe patterns of quietness over time

The Silence module exists to make silence **observable without interpretation**.

---

## 3. Product Principles

1. **Silence is neutral**  
   Silence is not assumed to be good, bad, calming, or productive.

2. **No optimization**  
   The module does not optimize, encourage, or discourage silence.

3. **Conscious logging only**  
   Silence must be explicitly started and ended by the user.

4. **Non-judgmental output**  
   Insights describe what happened, not what should happen.

5. **Temporal integrity**  
   Time is the primary source of truth.

---

## 4. Target Users

- Reflective individuals
- Writers, researchers, and creative professionals
- Users who dislike habit trackers and gamified self-improvement tools
- Users interested in personal observability rather than performance

Silence is **not intended** for:
- Mental health treatment
- Guided mindfulness or meditation
- Productivity coaching

---

## 5. Core User Flow

### Primary Flow

1. User opens the Silence module
2. User taps **Start Silence**
3. A silence period begins
4. User taps **End Silence**
5. (Optional) User attaches a short context

There are:
- No reminders
- No goals
- No success metrics

---

## 6. Feature Scope

### 6.1 MVP Features

- Start a silence session
- End a silence session
- Silence session history (timeline)
- Basic descriptive statistics
- Optional context tagging

### 6.2 Explicitly Out of Scope

- Guided meditation
- Focus or pomodoro timers
- Mood or emotion tracking
- Goals, streaks, badges, or scores
- Automatic silence detection

---

## 7. Domain Model & Event Schema

### 7.1 Core Entity: Silence Session

A silence session represents one consciously logged interval of silence.

**Attributes:**
- id
- user_id
- started_at
- ended_at
- duration_seconds (derived)
- context_code (optional)
- context_note (optional)

---

### 7.2 Domain Events

#### SilenceStarted

```json
{
  "event_type": "silence_started",
  "user_id": "uuid",
  "session_id": "uuid",
  "started_at": "timestamp"
}
```

Rules:
- A user may only have one active silence session at a time

---

#### SilenceEnded

```json
{
  "event_type": "silence_ended",
  "user_id": "uuid",
  "session_id": "uuid",
  "ended_at": "timestamp",
  "duration_seconds": 300
}
```

Rules:
- `ended_at` must be later than `started_at`
- `duration_seconds` is computed by the backend

---

#### SilenceContextAttached (Optional)

```json
{
  "event_type": "silence_context_attached",
  "session_id": "uuid",
  "context_code": 3
}
```

---

## 8. Database Design (PostgreSQL)

### 8.1 Users Table

```sql
users (
  id UUID PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  created_at TIMESTAMPTZ NOT NULL
)
```

---

### 8.2 Silence Sessions Table

```sql
silence_sessions (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES users(id),

  started_at TIMESTAMPTZ NOT NULL,
  ended_at TIMESTAMPTZ NULL,

  duration_seconds INTEGER NULL,

  context_code SMALLINT NULL,
  context_note TEXT NULL,

  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
)
```

Notes:
- `ended_at` being NULL indicates an active session
- `duration_seconds` is stored only after session completion

---

### 8.3 Silence Context Reference

```sql
silence_contexts (
  code SMALLINT PRIMARY KEY,
  label TEXT NOT NULL
)
```

Example values:
- 1: alone
- 2: waiting
- 3: walking
- 4: thinking
- 5: empty

---

## 9. Constraints & Business Rules

### Technical Constraints

- Only one active silence session per user
- Enforced via partial unique index
w
```sql
CREATE UNIQUE INDEX one_active_silence_session
ON silence_sessions(user_id)
WHERE ended_at IS NULL;
```

- Minimum duration: 5 seconds
- Maximum duration: 6 hours

---

### Product Constraints

- Silence sessions cannot be edited after completion
- No manual duration input
- Context selection is optional and limited
- No performance comparisons

---

## 10. Insights & Analytics (Descriptive Only)

Examples of valid insights:
- "Most silence sessions occur between 22:00 and 00:00"
- "Your longest silence session happened on Sunday"
- "The majority of silence sessions are shorter than 3 minutes"

The system must never generate advice or recommendations.

---

## 11. Product Voice & Language

### Tone
- Calm
- Neutral
- Minimal
- Non-instructional

### Copy Examples

- "Silence started."
- "Silence ended."
- "Silence recorded."

Avoid:
- Praise
- Encouragement
- Performance language

---

## 12. Success Criteria (Qualitative)

- Users understand the purpose without tutorial overload
- Users do not feel judged or guided
- Silence data remains sparse but meaningful

---

## 13. Future Extensions (Non-MVP)

- Waiting module integration
- Cross-module temporal insights
- Export and personal data ownership tools

These extensions must not alter the core philosophy of the Silence module.

