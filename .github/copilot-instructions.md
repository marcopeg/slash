
# IMPORTANT: At the start of every new chat, you MUST explicitly read the following skill files into the chat context before proceeding with any coding or answering questions:

- `.github/skills/track/SKILL.md` (for all track logic, file structure, and metadata)
- `.github/skills/astro/SKILL.md` (for all Astro-specific knowledge or tasks)

You must ensure the full contents of these files are loaded into the chat context before you begin any work. Do not rely on references alone. This is required for every new chat session.


# Acceptance Criteria for Astro Coding Tasks

Whenever you are given a coding task that involves fixing or changing code for Astro, you MUST run the build process (`npm run build`) and ensure that the project builds successfully before considering the task complete. Only report the task as done if the build passes without errors. This is a required acceptance criteria for all code-level Astro work.

# GitHub Copilot Instructions for AI Backing Tracks Project

Welcome, Copilot! This file provides explicit instructions and context to help you contribute effectively to the AI Backing Tracks project. Please follow these guidelines to ensure your code and suggestions align with the project's goals and structure.

## Project Overview
- This is a static single-page application (SPA) for browsing and playing AI-generated backing tracks.
- All assets (audio, video, metadata) are stored in the repository under `/tracks` and bundled with the frontend.
- There is no backend, no authentication, and no runtime database. All data comes from static JSON files.
- The build and deployment pipeline uses Astro (https://astro.build/) and Netlify.
- Whenever Astro-specific knowledge or tasks are required, prefer using the skill defined in `.github/skills/astro/SKILL.md` for guidance and implementation details.


## Track Data Model & Files
For all logic, file structure, and metadata related to tracks, always use the skill defined in `.github/skills/track/SKILL.md`.
This skill is the canonical reference for:
- Track folder and file naming conventions
- Required and optional files per track
- The internal data model and JSON schema for tracks
- Asset playback preference order
- Metadata fallback and error handling

Do not duplicate or hardcode track structure in this file—refer to the track skill for all implementation details.

## Build & Deployment
- The build process uses Astro (https://astro.build/) as the static site builder. More details will be provided in the future.
- During build, Astro copies `/tracks` to `/public/tracks` for static asset serving.
- The frontend fetches `/tracks/**/{track-name}.json` and related assets at runtime.

## General Guidelines
- Prefer simple, readable solutions. Avoid over-engineering.
- Respect the static, inspectable nature of the app.
- Keep everything deterministic and easy to review.
- For all track management, file structure, formats, and metadata logic, always use the skill in `.github/skills/track/SKILL.md` as the single source of truth. Do not duplicate or summarize this information here.
- Document any new conventions or changes clearly in the README or the relevant skill file.
- When working with Astro, always check and leverage the skill in `.github/skills/astro/SKILL.md` to ensure best practices and project consistency.

---

Thank you for helping keep this project clear, maintainable, and demo-friendly!
