# Track Skill for AI Backing Tracks Project

This skill defines the internal data model, file structure, and conventions for handling tracks in the AI Backing Tracks project. Use this as the authoritative reference for all track-related logic, asset handling, and metadata parsing.

## Track Folder Structure
- Each track lives in its own folder under `/tracks/{track-name}/`.
- Naming: Use lowercase, dashes for spaces, and avoid special characters (e.g., `blues-90-g/`).

## Required/Expected Files per Track
- `{track-name}.mp3` – Main audio asset (preferred for playback)
- `{track-name}.mp4` – (Optional) Video asset (preferred over mp3 if present)
- `{track-name}.midi` – MIDI version
- `{track-name}.png` – (Optional) Thumbnail/visual preview
- `{track-name}.json` – Main metadata and event data (see below)
- `youtube.json` – (Optional) YouTube metadata
- `.ly`, `.txt` – (Optional) Additional files for future features

## File Format and Data Model
- Only `.midi` is used for MIDI files (not `.mid`).
- The frontend should always prefer mp4 > mp3 > midi for playback, in that order, if available.
- The `{track-name}.json` file is the single source of truth for each track.
- All tracks should use the same schema, which can be inferred from existing JSON files in `/tracks`.
- This file contains:
  - Track info (title, description, bpm, key, style, tags, etc.)
  - An array of `events` (e.g., note subtitles, timing, or other annotations)
  - Optionally, YouTube metadata (or in a separate `youtube.json`)
- If metadata is missing or incomplete, provide sensible fallback values or error states in the UI.

## Usage
- Always use this skill when implementing, parsing, or displaying track data.
- Do not hardcode or assume file formats or schema—refer to this skill for the canonical structure.
- Document any changes to the track data model here and in the README.
