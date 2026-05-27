# MeAll Technologies — Assets

This is the official public assets repository for **MeAll Technologies**. It is used to distribute binaries, installers, and other documents to the public.

## Contents

- **[software/](software/)** — Downloadable binary software published by MeAll Technologies.

## Working without automatic Git LFS downloads

This repository uses Git LFS for large binary assets such as `.exe`, `.dmg`, and `.AppImage` files. If you only need to update regular Git-tracked files like workflows, scripts, or Markdown, you can keep LFS enabled but skip automatic binary downloads in your local clone.

For a fresh clone, skip the initial LFS download during checkout:

```bash
GIT_LFS_SKIP_SMUDGE=1 git clone git@github.com:meall-tech/assets.git
cd assets
git lfs install --local --skip-smudge
```

If you already have the repository cloned, enable the same behavior for the current clone with:

```bash
git lfs install --local --skip-smudge
```

With that setting in place:

- `git pull` still updates normal files as usual.
- LFS-tracked files stay as lightweight pointer files until you request them explicitly.
- The setting is local to your clone and does not affect other contributors or CI.

When you actually need the mirrored binaries, fetch only those files explicitly:

```bash
git lfs pull --include="software/meall-agents/*"
```
