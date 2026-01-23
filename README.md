

# AI Backing Tracks – Frontend Experiment

This repository contains a **static single‑page web application** used as a demo project for an internal conference.  
The goal is to showcase how a complete frontend application can be built, evolved, reviewed, and deployed **from a phone**, delegating most of the work to AI tools such as **GitHub Copilot / Codex**, while keeping a fully automated deployment pipeline.

This README is intentionally **very explicit**: it is meant to be read by humans *and* by AI coding assistants so they clearly understand the intent, constraints, and desired architecture of the project.

---

## High‑Level Goals

- Build a **simple static SPA** that displays and plays AI‑generated backing tracks
- Keep **all assets inside the repository**
- Automatically **bundle assets with the app**
- Use **Argo Build** to define and run build pipelines
- Deploy automatically to **Netlify** on every push to `main`
- Optimize for **AI‑driven development** (clear structure, conventions, intent)

---

## Core Demo Narrative (Important)

This project is part of a live demo where:

1. Code changes are requested from a **mobile phone**
2. AI (Copilot / Codex) performs the implementation
3. The human only **reviews & merges**
4. Deployment happens **automatically**
5. The result is visible live on the web

Everything in this repo should support that story.

---

## Technology Constraints & Choices

### Frontend
- Static Single Page Application
- No backend
- No authentication
- No runtime database
- All data comes from static JSON files

Framework choice is intentionally flexible, but **must remain static‑exportable**.

Examples:
- Vanilla Vite + React
- Vite + Preact
- Plain Vite + TypeScript

> ❗ Do NOT introduce server‑side rendering or APIs.

---

## Repository Structure

The repository is structured so that **assets are first‑class citizens** and always shipped with the frontend.

```
/
├─ tracks/
│  ├─ blues-in-g/
│  │  ├─ track.mp3
│  │  ├─ track.mid
│  │  ├─ video.mp4        (optional)
│  │  ├─ thumbnail.jpg
│  │  └─ meta.json
│  ├─ funk-90bpm/
│  │  └─ ...
│
├─ src/
│  ├─ app/
│  ├─ components/
│  ├─ pages/
│  └─ index.tsx
│
├─ public/
│  └─ tracks/  → generated or copied from /tracks at build time
│
├─ argo/
│  └─ build.yaml
│
├─ netlify.toml
├─ package.json
├─ README.md
```

---

## Track Asset Contract

Each backing track lives in its **own folder**.

### Required Files

- `track.mp3` – audio playback
- `track.mid` – MIDI version
- `thumbnail.(jpg|png|webp)` – visual preview
- `meta.json` – metadata

### `meta.json` Example

```json
{
  "title": "Slow Blues in G",
  "description": "12‑bar slow blues backing track in G",
  "bpm": 65,
  "key": "G",
  "style": "blues",
  "tags": ["blues", "slow", "shuffle"],
  "youtube": {
    "title": "Slow Blues in G – Guitar Backing Track",
    "description": "...",
    "tags": ["blues backing track", "guitar"]
  }
}
```

This JSON is the **single source of truth** for UI rendering and future publishing workflows.

---

## Asset Bundling Strategy (Very Important)

- Assets **must not** be loaded from GitHub at runtime
- Assets **must be part of the deployed bundle**
- GitHub is used for **versioning**, not hosting

### Approach

- `/tracks` is the source of truth
- During build:
  - `/tracks` is copied into `/public/tracks`
- The frontend fetches:
  ```
  /tracks/**/meta.json
  ```

This guarantees:
- Works offline
- Works on Netlify
- Zero runtime dependencies

---

## Build & Automation (Argo Build)

This project uses **Argo Build** to define the build pipeline.

### Responsibilities of Argo

- Install dependencies
- Run the frontend build
- Copy assets into the final output
- Produce a static artifact ready for Netlify

### Example Responsibilities (Conceptual)

- `npm ci`
- `npm run build`
- `cp -R tracks dist/tracks`

Argo configuration lives in:

```
/argo/build.yaml
```

This pipeline is triggered by **GitHub pushes**.

---

## Deployment (Netlify)

Netlify is used as the final hosting platform.

### Deployment Model

- GitHub repository connected to Netlify
- Netlify listens to:
  - pushes to `main`
- Netlify deploys the static output folder (e.g. `dist/`)

### Netlify Configuration

- Defined in `netlify.toml`
- Build command is delegated to Argo (Netlify only receives artifacts)

---

## Development Workflow (Human + AI)

1. Human creates an issue / request (often from phone)
2. AI edits code based on README + repo context
3. Human reviews diff
4. Merge to `main`
5. Argo builds
6. Netlify deploys
7. Live demo updates

This README exists to **maximize AI success** in step 2.

---

## Non‑Goals (Explicit)

- No backend
- No user accounts
- No analytics
- No server APIs
- No optimization for scale

This is a **clarity & automation demo**, not a product.

---

## Future Extensions (Out of Scope)

- YouTube upload automation
- Metadata editing UI
- MIDI visualization
- Chord timeline overlays

These ideas may appear in discussions but **must not** influence the initial implementation.

---

## Final Note for AI Assistants

If you are an AI reading this README:

- Prefer **simple solutions**
- Avoid over‑engineering
- Respect the static nature of the app
- Keep everything inspectable and deterministic
- Optimize for readability and demo impact

This project is about **showing the flow**, not building a platform.