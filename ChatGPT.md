# ChatGPT Project Instructions for AI Backing Tracks

Welcome to the AI Backing Tracks project! This document provides essential context and instructions for using ChatGPT or any LLM agent to contribute effectively to this repository. Please read carefully and follow these guidelines to ensure consistency and maintainability.

## Project Purpose
- This is a static single-page application (SPA) for browsing and playing AI-generated backing tracks.
- All assets (audio, video, metadata) are stored in the repository under `/tracks` and bundled with the frontend.
- There is **no backend**, no authentication, and no runtime database. All data comes from static JSON files.
- The build and deployment pipeline uses Astro (https://astro.build/) and Netlify.

## Key Principles
- **Static, deterministic, and inspectable:** All content is versioned and reviewable in the repo.
- **No dynamic server logic:** All data and assets are static and served directly.
- **Simplicity and clarity:** Prefer readable, maintainable solutions over complex abstractions.

## Track Data Model & Files
- **Canonical reference:** For all logic, file structure, and metadata related to tracks, always use the skill defined in `.github/skills/track/SKILL.md`.
- **Do not duplicate or hardcode** track structure or metadata logic elsewhere—refer to the skill file for all implementation details.
- **Track assets:** Each track is a folder in `/tracks` containing required and optional files (see the skill for details).
- **Asset playback order, metadata fallback, and error handling** are all defined in the track skill.

## Build & Deployment
- The build process uses Astro as the static site builder. See `.github/skills/astro/SKILL.md` for Astro-specific guidance.
- During build, Astro copies `/tracks` to `/public/tracks` for static asset serving.
- The frontend fetches `/tracks/**/{track-name}.json` and related assets at runtime.

## Contribution Guidelines
- **Respect the static nature** of the app—no server-side code or runtime DBs.
- **All track management, file structure, formats, and metadata logic** must follow the track skill as the single source of truth.
- **Document any new conventions or changes** clearly in the README or the relevant skill file.
- **For Astro work,** always check and leverage the skill in `.github/skills/astro/SKILL.md`.

## Directory Structure (Partial)
- `/tracks/` — All track folders and assets
- `/src/` — Astro source code
- `/public/` — Static assets (populated at build)
- `.github/skills/track/SKILL.md` — Track data model and conventions
- `.github/skills/astro/SKILL.md` — Astro build and usage conventions

## How to Use This Project with ChatGPT
- When asking ChatGPT to make changes, **always reference the skills** for track and Astro logic.
- Do not summarize or duplicate skill content—**link or refer to the skill files**.
- If you add new features or change conventions, **update the relevant skill file and README**.
- Keep everything deterministic, static, and easy to review.

---

Thank you for helping keep this project clear, maintainable, and demo-friendly!
