import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

type TrackMeta = {
  name?: string;
  tempo_bpm?: number;
  time_signature?: string;
  key?: string;
  mode?: string;
  style?: string;
  description?: string;
  genre?: string;
  subgenre?: string;
  difficulty?: string;
  target_instruments?: string[];
};

type TrackSummary = {
  slug: string;
  title: string;
  description: string;
  tags: string[];
  thumbnail: string | null;
  hasVideo?: boolean;
  hasAudio?: boolean;
  video?: string | null;
  audio?: string | null;
};

type TrackData = {
  slug: string;
  meta: TrackMeta;
  description: string;
  title: string;
  tags: string[];
  thumbnail: string | null;
  hasVideo?: boolean;
  hasAudio?: boolean;
  video?: string | null;
  audio?: string | null;
};

const tracksDir = fileURLToPath(new URL('../../tracks', import.meta.url));

const toTitle = (meta: TrackMeta) => {
  const titleParts: string[] = [];

  if (meta.style) {
    titleParts.push(meta.style);
  }

  if (meta.key) {
    const modePart = meta.mode ? ` ${meta.mode}` : '';
    titleParts.push(`in ${meta.key}${modePart}`);
  }

  if (meta.tempo_bpm) {
    titleParts.push(`(${meta.tempo_bpm} bpm)`);
  }

  return titleParts.join(' ').trim();
};

const toTags = (meta: TrackMeta) => {
  const tags = [
    meta.genre,
    meta.subgenre,
    meta.style,
    meta.difficulty,
    meta.time_signature ? `${meta.time_signature} time` : null,
    meta.tempo_bpm ? `${meta.tempo_bpm} bpm` : null,
    meta.key ? `${meta.key}${meta.mode ? ` ${meta.mode}` : ''}` : null,
    ...(meta.target_instruments ?? []),
  ].filter(Boolean) as string[];

  return Array.from(new Set(tags));
};

const getThumbnail = (slug: string) => {
  const thumbnailPath = path.join(tracksDir, slug, 'thumbnail.png');

  if (!fs.existsSync(thumbnailPath)) {
    return null;
  }

  const base64 = fs.readFileSync(thumbnailPath).toString('base64');
  return `data:image/png;base64,${base64}`;
};

const getTrackMedia = (slug: string) => {
  const videoPath = path.join(tracksDir, slug, `${slug}.mp4`);
  const audioPath = path.join(tracksDir, slug, `${slug}.mp3`);

  const hasVideo = fs.existsSync(videoPath);
  const hasAudio = fs.existsSync(audioPath);

  const publicVideo = hasVideo ? `/tracks/${slug}/${slug}.mp4` : null;
  const publicAudio = hasAudio ? `/tracks/${slug}/${slug}.mp3` : null;

  return { hasVideo, hasAudio, video: publicVideo, audio: publicAudio };
};

const loadTrackMeta = (slug: string) => {
  const jsonPath = path.join(tracksDir, slug, `${slug}.json`);

  if (!fs.existsSync(jsonPath)) {
    return null;
  }

  const data = JSON.parse(fs.readFileSync(jsonPath, 'utf-8')) as { meta?: TrackMeta };
  return data.meta ?? null;
};

const listTrackSlugs = () =>
  fs
    .readdirSync(tracksDir, { withFileTypes: true })
    .filter(entry => entry.isDirectory())
    .map(entry => entry.name)
    .sort((a, b) => a.localeCompare(b));

export const getTrackSummaries = (): TrackSummary[] =>
  listTrackSlugs()
    .map(slug => {
      const meta = loadTrackMeta(slug);

      if (!meta) {
        return null;
      }

      const media = getTrackMedia(slug);

      if (!media.hasVideo && !media.hasAudio) {
        return null;
      }

      return {
        slug,
        title: toTitle(meta) || slug,
        description: meta.description ?? 'No description available yet.',
        tags: toTags(meta),
        thumbnail: getThumbnail(slug),
        hasVideo: media.hasVideo,
        hasAudio: media.hasAudio,
        video: media.video,
        audio: media.audio,
      } satisfies TrackSummary;
    })
    .filter((track): track is TrackSummary => track !== null);

export const getTrackSlugs = () => listTrackSlugs();

export const getPlayableTrackSlugs = () =>
  getTrackSummaries().map(t => t.slug);

export const getTrackBySlug = (slug: string): TrackData | null => {
  const meta = loadTrackMeta(slug);

  if (!meta) {
    return null;
  }

  const media = getTrackMedia(slug);

  if (!media.hasVideo && !media.hasAudio) {
    return null;
  }

  return {
    slug,
    meta,
    title: toTitle(meta) || slug,
    description: meta.description ?? 'No description available yet.',
    tags: toTags(meta),
    thumbnail: getThumbnail(slug),
    hasVideo: media.hasVideo,
    hasAudio: media.hasAudio,
    video: media.video,
    audio: media.audio,
  } satisfies TrackData;
};
