# MeAll Agents

This folder contains the binary installers for the **MeAll Agents** software by MeAll Technologies.

MeAll Agents is the official agent platform that enables seamless automation and integration across your infrastructure.

## Available Binaries

| Platform | Architecture | File |
|----------|-------------|------|
| Windows | x64 | `MeAllAgents-Setup-x64.exe` |
| macOS | x64 | `MeAllAgents-x64.dmg` |
| macOS | arm64 | `MeAllAgents-arm64.dmg` |
| Linux | x86 | `MeAllAgents-x86.AppImage` |

> **Note:** Download the installer that matches your operating system and CPU architecture.

## Version tracking

The mirrored upstream version is recorded in `VERSION.txt`.
The top entry in `CHANGELOG.md` is mirrored from the `meall-tech/agents` GitHub release body by copying the summary block between the first H1 heading and the first horizontal rule.

To refresh this folder from the latest release in `meall-tech/agents`, run:

```bash
./scripts/sync-meall-agents-release.sh --pull --commit --push
```

This repository also includes a scheduled workflow that polls for updates every 12 hours.
