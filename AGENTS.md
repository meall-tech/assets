# Repository agent instructions

This repository is the **public distribution mirror** for MeAll Technologies assets. For MeAll Agents specifically, the source of truth for releases is the private repository **`meall-tech/agents`**. Do **not** create releases for MeAll Agents in this repository; sync the published binaries from the upstream release instead.

## MeAll Agents release sync

Use this workflow whenever you are asked to verify or refresh the public MeAll Agents installers:

1. Make sure the local checkout is on `main`.
2. Fast-forward from `origin/main`.
3. Read `software/meall-agents/VERSION.txt` if it exists. If it does not exist, treat the sync as required.
4. Query the latest GitHub release in `meall-tech/agents` with `gh`.
5. If the latest upstream version is newer than the tracked version, download the required binaries, replace the mirrored files in `software/meall-agents/`, and update `VERSION.txt`.
6. Commit and push the result on `main`.

## Preferred command

Run the repository automation instead of handling the files manually:

```bash
./scripts/sync-meall-agents-release.sh --pull --commit --push
```

That command:

- requires the checkout to be on `main`,
- fast-forwards from `origin/main`,
- compares `software/meall-agents/VERSION.txt` with the latest `meall-tech/agents` release,
- downloads only the mirrored public binaries when an update is needed,
- normalizes the filenames to this repository's expected structure,
- updates `software/meall-agents/VERSION.txt`,
- commits and pushes the result.

## Sync workflow trigger

Use the workflow only as a manual trigger via `workflow_dispatch`.

- Workflow file: `.github/workflows/sync-meall-agents.yml`
- Manual trigger: supported through `workflow_dispatch`
- Secret required: `MEALL_RELEASE_SYNC_TOKEN`

`MEALL_RELEASE_SYNC_TOKEN` should be a token that can:

- read releases from the private `meall-tech/agents` repository,
- push commits to `meall-tech/assets`.

The workflow checks out `main`, fast-forwards it, runs the sync script, and only creates a commit when the mirrored assets actually change.

## Expected mirrored files

Only these release assets should be mirrored into `software/meall-agents/`:

| Upstream release asset | Public filename in this repo |
| --- | --- |
| `MeAll.Agents.Setup.<version>.exe` | `MeAllAgents-Setup-x64.exe` |
| `MeAll.Agents-<version>.dmg` | `MeAllAgents-x64.dmg` |
| `MeAll.Agents-<version>-arm64.dmg` | `MeAllAgents-arm64.dmg` |
| `MeAll.Agents-<version>.AppImage` | `MeAllAgents-x86.AppImage` |

Ignore the zip archives, portable executable, checksum file, and any other non-mirrored release artifacts unless the repository structure is intentionally changed.

## Requirements

- `gh` must be installed and authenticated with access to `meall-tech/agents`.
- Git LFS must remain enabled for `.exe`, `.dmg`, and `.AppImage` assets in this repository.
- If `--pull` is used, the working tree must be clean before running the script.

## Manual verification

After a sync, confirm that:

- `software/meall-agents/VERSION.txt` matches the upstream release tag without a leading `v`,
- the four mirrored binaries exist with the expected filenames,
- `git status --short` only shows the intended asset updates and version bump.
