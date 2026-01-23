

# AI Backing Tracks – Frontend Experiment


This repository contains a **static single‑page web application** used as a demo project for an internal conference.
The goal is to showcase how a complete frontend application can be built, evolved, reviewed, and deployed **from a phone**, delegating most of the work to AI tools such as **GitHub Copilot / Codex**, while keeping a fully automated deployment pipeline.

This README is intentionally **very explicit**: it is meant to be read by humans *and* by AI coding assistants so they clearly understand the intent, constraints, and desired architecture of the project.

---


## High‑Level Goals

- Build a **simple static SPA** that displays and plays AI‑generated backing tracks
- Keep **all assets inside the repository**
- Automatically **bundle assets with the app**
- Use **Astro** (https://astro.build/) to define and run build pipelines
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

The project uses **Astro** (https://astro.build/) as the static site builder. Astro enables static export, asset bundling, and integration with modern frontend frameworks if needed.

> ❗ Do NOT introduce server‑side rendering or APIs.

---


## Repository Structure

The repository is structured so that **assets are first‑class citizens** and always shipped with the frontend. Each track lives in its own folder under `/tracks`.

```
/
├─ tracks/
│  ├─ {track-name}/
│  │  ├─ {track-name}.mp3         # Main audio asset
│  │  ├─ {track-name}.midi        # MIDI version
│  │  ├─ {track-name}.mp4         # (Optional) Video asset
│  │  ├─ {track-name}.png         # (Optional) Thumbnail/visual preview
│  │  ├─ {track-name}.json        # Main metadata and event data (see below)
│  │  ├─ youtube.json             # (Optional) YouTube metadata
│  │  ├─ ... (other optional files: .ly, .txt, etc.)
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


## Track Asset Contract & Metadata

Each backing track lives in its **own folder** under `/tracks`.

### Asset Files

- `{track-name}.mp3` – Main audio asset for playback
- `{track-name}.midi` – MIDI version of the track
- `{track-name}.mp4` – (Optional) Video asset
- `{track-name}.png` – (Optional) Thumbnail/visual preview
- `youtube.json` – (Optional) YouTube metadata for publishing or display
- `.ly`, `.txt` – (Optional) Additional files for future features (e.g., LilyPond notation, notes)

> **Note:** Optional files can be present in each track folder. Their use is not yet fully defined, but they may support future features or richer metadata.

### Main Metadata: `{track-name}.json`

Each track folder contains a `{track-name}.json` file, which acts as the **main metadata and event database** for that track. This file includes:

- Track info (title, description, bpm, key, style, tags, etc.)
- Optionally, YouTube metadata (or in a separate `youtube.json`)
- A list of "events" (e.g., note subtitles, timing, or other annotations)

#### Example `{track-name}.json` Structure

```json
{
  "title": "Blues 90 G",
  "description": "90 bpm blues backing track in G",
  "bpm": 90,
  "key": "G",
  "style": "blues",
  "tags": ["blues", "guitar", "backing track"],
  "events": [
    { "time": 0.0, "note": "G7" },
    { "time": 2.5, "note": "C7" }
    // ... more events ...
  ],
  "youtube": {
    "title": "Blues 90 G – Backing Track",
    "description": "...",
    "tags": ["blues", "guitar"]
  }
}
```

This JSON file is the **primary source of truth** for UI rendering, track playback, and future publishing workflows. The frontend should use these files as a database to list and load tracks and their metadata.

---



## Asset Bundling Strategy (Very Important)

- Assets **must not** be loaded from GitHub at runtime
- Assets **must be part of the deployed bundle**
- GitHub is used for **versioning**, not hosting

### Approach

- `/tracks` is the source of truth
- During build:
  - Astro copies `/tracks` into `/public/tracks` for static asset serving
- The frontend fetches:
  ```
  /tracks/**/{track-name}.json
  ```
  and related assets (mp3, midi, png, etc.)

This guarantees:
- Works offline
- Works on Netlify
- Zero runtime dependencies

---


## Build & Automation (Astro Build)

This project uses **Astro** (https://astro.build/) to define the build pipeline.

### Responsibilities of Astro

- Install dependencies
- Run the frontend build (`astro build`)
- Copy assets into the final output
- Produce a static artifact ready for Netlify

### Example Responsibilities (Conceptual)

- `npm ci`
- `npm run build` (runs `astro build`)
- `cp -R tracks dist/tracks`

Astro configuration lives in:

```
/astro.config.mjs
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
- Use the `{track-name}.json` files in each track folder as the main data source for the frontend
- Optional files (e.g., .ly, .txt, youtube.json) may be present and can be used for future features, but their use is not yet defined

This project is about **showing the flow**, not building a platform.