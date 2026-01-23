import fs from 'node:fs';
import path from 'node:path';

const repoRoot = path.resolve(new URL('..', import.meta.url).pathname, '..');
const srcDir = path.resolve(process.cwd(), 'tracks');
const destDir = path.resolve(process.cwd(), 'public', 'tracks');

if (!fs.existsSync(srcDir)) {
  console.log('No tracks directory found at', srcDir);
  process.exit(0);
}

try {
  if (fs.existsSync(destDir)) {
    fs.rmSync(destDir, { recursive: true, force: true });
  }

  const copyDir = (src, dest) => {
    fs.mkdirSync(dest, { recursive: true });
    for (const entry of fs.readdirSync(src, { withFileTypes: true })) {
      const srcPath = path.join(src, entry.name);
      const destPath = path.join(dest, entry.name);
      if (entry.isDirectory()) {
        copyDir(srcPath, destPath);
      } else {
        fs.copyFileSync(srcPath, destPath);
      }
    }
  };

  copyDir(srcDir, destDir);
  console.log('Synced tracks to', destDir);
} catch (err) {
  console.error('Failed to sync tracks:', err);
  process.exit(1);
}
