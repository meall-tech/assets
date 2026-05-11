## 0.15.2 — May 11, 2026

Two solid improvements — an important quality-of-life feature and a Docker recovery fix.

### Update Check & Auto-Download

MeAll Agents now checks for new versions automatically. The app periodically fetches the latest version from the assets server and notifies you when an update is available.

- **Automatic background checks** — the app checks for new versions a couple of times per day and on first launch after installing
- **One-click update** — when an update is available, a clear prompt in the About modal lets you download the right installer for your platform (macOS ARM64, macOS x64, Windows, Linux)
- **Manual check** — click "Check for updates" in the About modal anytime to trigger a check on demand, with a timestamp of the last check shown below the button

### Docker Sandbox Recovery Fix

Sandboxes with special characters in their display name (slashes, backslashes, etc.) could not be properly recovered. This is now fixed.

- **Safe name slugging** — display names with special characters are converted to safe Docker container names using a stable hash so the app can always find the right container
- **Label-based lookup** — containers are now tracked by a `meall-agent` label, making recovery reliable regardless of what characters the display name contains
- **Existing sandboxes migrated** — recovery logic covers sandboxes created before this fix too

### Bug Fixes

- **Update check auto-trigger** — when opening the About modal with no prior check on record, an update check fires immediately so you are never looking at stale data
- **Docker sandbox recovery** — sandboxes with unsafe characters in their display name are now properly recoverable

---


All notable changes to MeAll Agents are here. Releases are listed from newest to oldest.

---

## 0.15.1 — May 11, 2026

A focused quality release — stability fixes, better Docker infrastructure, and a long-standing UX fix.

### What's Fixed

**Public Links Now Open in Your Browser** — When clicking a web link in Cockpit, MeAll Agents was opening it in a new Electron window instead of your system browser. That behavior is now fixed. Public URLs go to your browser; local/private URLs stay in the app where they belong.

**Smarter Docker & Server Configuration** — Sandbox and server environments have been improved with better configuration handling, cleaner container lifecycle management, and more reliable startup sequencing.

**Better UI Behavior Indicators** — The app now gives clearer visual feedback when processes are starting, running, or in an error state — so you can see what's happening at a glance.

### Bug Fixes

- Public URLs open in system browser from Cockpit (#118)
- Memory search default provider fallback
- Gateway device scope repair for Docker environments
- Consistent markdown code formatting across the codebase

---

## 0.15.0 — May 7, 2026

MeAll Agents 0.15.0 makes AI free. This release ships ModelRelay inside every sandbox — a smart local router that live-benchmarks free coding models across top providers and automatically routes your requests to the best available one.

### ModelRelay — Free AI, Automatically

ModelRelay runs inside every sandbox as a local OpenAI-compatible router that benchmarks free models across trusted providers (NVIDIA, Groq, OpenRouter, Google) and routes each request to the best available one.

- **auto-fastest** — The default model continuously evaluates speed and capability to pick the right model for each request
- **100% savings on AI** — Routes through free-tier models first, paid keys as fallback
- **Built-in dashboard** — Monitor routing decisions, provider health, and available models from the UI
- **Zero-config** — Ships inside the sandbox and starts automatically

### Ollama — Local Models, One Click Away

Full Ollama integration with pull, configure, and model management directly from the Settings UI. Provider badges make model origins clear at a glance.

### NVIDIA as a First-Class Provider

Native NVIDIA API key integration. Add your key in Settings and models appear immediately with proper badges.

### Kami — Professional Document Generation

Typeset one-pagers, resumes, slide decks, letters, and portfolios on warm parchment with ink-blue accents. Install with one click from the skill list.

### Bug Fixes

- **AGENTS.md truncation** — Fixed `bootstrapMaxChars` to 20000 to prevent skill descriptions from being silently stripped on sandbox creation
- **Provider config API types** — Corrected baseUrl and models format for clean provider registration
- **Provider badge positioning** — Fixed alignment in the settings/models list

---

## 0.14.0 — May 5, 2026

Your agent now has a cockpit. MeAll Agents 0.14.0 ships a full operational control surface for your sandbox — agent fleet control, workspace browser, kanban board, cron scheduling, session tree, and more. Plus a visual overhaul with flat icons, glass-morphism header, and a cohesive dark/light theme system.

### Cockpit — Your Agent's Operating Surface

Click **Cockpit** from the machine card and it opens in a new window — ready to go with no setup.

- **Agent fleet control** — Run multiple agents from one place, each with its own workspace, subagents, memory, and skills
- **Workspace browser & editor** — Browse files, edit documents, view rendered markdown, inspect PDFs — live while the agent runs
- **Kanban task board** — Delegate work onto a structured board; agents create proposals, you control the flow
- **Cron scheduling** — See, create, and manage scheduled agent runs with clear labeling
- **Session tree** — Inspect subagent activity without losing your main thread
- **Memory & config editing** — Inspect and edit agent memory, config, and skills from the UI
- **Rich output** — Charts, diffs, syntax-highlighted code, image previews, structured tool rendering
- **Token usage & cost tracking** — See what your agent is spending in real time

### Visual Overhaul

- Shared design system with custom properties for fonts, surfaces, borders, and accents
- Flat icon system replacing emoji-based labels across all pages
- Sticky glass header with rounded corners and subtle accent line
- Refined modal, button, and spinner styles throughout
- Dark theme with proper elevated surfaces instead of just color inversion

### Docker Integration

- Cockpit source is vendored and built inside the Docker container during setup
- Bundled cockpit skills (starting with `kanban`) auto-sync into the agent workspace
- `node_modules/.bin` now on PATH inside containers

### Bug Fixes

- Agent Chat input freeze regression fixed
- Cron dialog clarity improvements

---

## 0.13.0 — April 22, 2026

Your agent now has its own web chat — branded, personalized, and accessible from anywhere. Plus smart device pairing that Just Works™.

### OpenWebUI Skill

A full self-hosted web interface for your agent, powered by OpenWebUI and connected to OpenClaw. Reads your agent's `IDENTITY.md` to create a personalized model card — name, emoji, description.

- **One-command setup** — branding, config, and model entries all done automatically
- **MeAll Agents branding** — dark theme, custom login page, logo, and favicon
- **Service management** — start, stop, restart, and logs via `service.sh`
- **Remote access** — automatically spins up a Cloudflare tunnel when started

### Agent Chat — Smart Device Pairing

OpenClaw 2026.4.21 hardened the TUI's device pairing requirements, causing "Pairing required" on every open. The app now handles this automatically:

- **Automatic pairing** — approves pending requests and reloads the terminal
- **Persistent device ID** — saved to VM config, skipped on subsequent opens
- **Robust detection** — catches `GatewayClientRequestError` and has a 5-second fallback timer for edge cases

### Todo Skill — API Warning

Agents were sometimes editing `todos.json` directly instead of using the API, causing changes to silently disappear. SKILL.md now includes an explicit warning about always using the API.

### OpenClaw 2026.4.21

Bundled OpenClaw bumped to 2026.4.21. Existing users can update via **Settings → Advanced Setup → Update Sandbox Version**.

---

## 0.12.1 — April 19, 2026

A new GitHub skill, an Ollama toggle for cleaner model selection, and battle-tested Proof Editor documentation.

### GitHub Skill

Agents can manage GitHub repositories, issues, PRs, and CI — all from the sandbox using the `gh` CLI.

- **Device flow and PAT authentication** — log in from the settings page without TTY
- **Full `gh` CLI access** — repos, issues, PRs, actions, releases, gists
- **Settings UI** — install, authenticate, and manage with status cards

### Ollama Toggle

Not everyone uses local models. A global toggle in the Settings modal lets you hide the Ollama provider card entirely when it's not needed.

### Proof Editor — Collaborative Editing Guide

Updated SKILL.md with guidance on how to edit a doc that humans are actively changing:

- The Reliable Edit Loop — read, snapshot, edit one block, re-read
- Anti-patterns for collaborative docs
- When NOT to use `rewrite.apply`

### OpenClaw 2026.4.15

Bundled OpenClaw bumped to 2026.4.15.

### Bug Fixes

- **OpenRouter provider** — Fixed wrong API base URL (`https://openrouter.ai/v1` → `https://openrouter.ai/api/v1`)

---

## 0.12.0 — April 15, 2026

A built-in Todo app, smarter shared folder awareness for agents, and a reworked auth gate that speaks the full HTTP vocabulary.

### Todo App

A shared task manager running inside the sandbox — agent and user see the same list in real time.

- **Web UI at port 7001** with drag-and-drop, dark/light theme, and auto-refresh
- **JSON API** (`/api/todos`) — full CRUD plus reorder and clear-completed
- **Service controls** from the configure page — start, stop, and restart without a terminal
- **"Open Todo App" button** that opens the UI in a new tab

### Shared Folders — Agent Awareness

Agents now understand shared folders explicitly: available at `/mnt/<folder>`, bidirectional, real-time sync. No more guessing where to look.

### Auth Gate — Full HTTP Method Support

The Tunnel skill's auth gate previously only handled GET and POST. All other methods were silently dropped. Refactored to properly proxy PUT, PATCH, DELETE — unblocking the Todo app API through the tunnel.

### CI — Split Release & QA Build Workflows

Release and QA builds are now separate workflows — faster CI, no platform filter confusion, and manual platform selection for quick testing.

### Bug Fixes

- Todo API auto-generates UUIDs for missing IDs
- `DELETE /api/todos?id=` with empty ID returns 400 instead of silently succeeding

---

## 0.11.0 — April 14, 2026

UI polish, skill service management, sticky headers, and OpenClaw 2026.4.14.

### Skill Service Management

Start, stop, and restart Tunnel and Workspace Browser directly from the configure page. Structured logging with auto-refresh every 3 seconds.

### Save Configuration Flow

- Step-by-step progress tracking with animated overlay
- Active border indicator follows the current saving step
- Save button disabled with spinner during save operations
- Single gateway restart for all configuration changes

### Sticky Headers

Fixed/sticky header across all pages — index, configure, snapshots, and workspace browser.

### OpenClaw 2026.4.14

Bundled OpenClaw bumped from 2026.4.12 to 2026.4.14 — 50+ bug fixes, no breaking changes.

---

## 0.10.0 — April 13, 2026

Major upgrade shipping OpenClaw 2026.4.12, password protection, and a new agent behavior configuration UI.

### Password Protection

- Lock screen with password authentication for the MeAll Agents UI and API
- Configurable session expiry (1h, 4h, 8h, 24h, never)
- Login rate limiting

### Agent Behavior Configuration

- **Active Memory** — dedicated memory sub-agent that pulls in relevant preferences before each reply
- **Dreaming** — enables the memory-wiki knowledge compilation stack

### ElevenLabs TTS Improvements

TTS provider and voice configuration written directly to `openclaw.json`. Auto-enable of ElevenLabs plugin during skill install.

### Reliability & Performance

- **Single-restart save flow** — all config changes batched and applied in one gateway restart
- **Post-finalize re-apply** — plugin enables and channel enables automatically retried after restart
- Config reads via direct `cat openclaw.json` (~3s → ~0.3s)

### OpenClaw 2026.4.12

Sandbox engine upgraded from 2026.3.24 to 2026.4.12 — 11 stable releases of new capabilities and fixes including Active Memory plugin, Memory Wiki / Dreaming stack, video & music generation tools, strict SSRF defaults, and Ollama vision support.

### Bug Fixes

- Plugin enable/disable fails on fresh sandboxes — now retried automatically post-finalize
- Workspace browser auth bypass for the `/browse` endpoint
- License gate race condition

---

## 0.9.6 — April 13, 2026

Docker is now the default virtualization engine. New installs automatically use Docker — no configuration needed. Existing installs are migrated on first launch.

---

## 0.9.5 — April 12, 2026

Windows compatibility fixes.

### Bug Fixes

- **Skill script transfer** — Large scripts no longer exceed Windows' 32,767 character command-line limit. All transfers now use stdin piping
- **Folder picker** — Backslash paths properly escaped for `onclick` attribute injection
- **Shared folders** — Docker inspect commands now work on Windows via argument arrays instead of single-quoted Go templates
- **Folder browser security** — Added Windows drive letter detection
- **Agent Chat and Sandbox Shell** — `web/node_modules` now included in packaged builds

---

## 0.9.4 — April 12, 2026

Model curation and benchmark scores. All model lists modernized with real agent benchmark data.

### Provider Updates

- **OpenAI** — Added `gpt-5.4-mini` (83%), removed legacy models
- **Anthropic** — Fixed model IDs to use hyphenated form, `claude-sonnet-4.6` correctly shows 85%
- **Groq** — Complete overhaul with current production and preview models
- **OpenRouter** — Added `anthropic/claude-sonnet-4.6` and `openai/gpt-5.4`
- **Ollama Cloud** — Expanded from 4 to 12 models, sorted by benchmark score

Each model card now shows an **Agent Score** (% task completion) and **Avg Price** per task.

---

## 0.9.3 — April 12, 2026

Feedback system, smarter agent prompts, and a critical skill injection race condition fix.

### Feedback System

Users can submit bug reports and suggestions directly from the app via the **💬 Feedback** button. Submissions go to MeAll Technologies via Supabase.

### Smarter Agent Prompts

AGENTS.md has been significantly expanded:

- **Runtime awareness** — Agents understand they run inside MeAll Agents powered by OpenClaw
- **Skills catalog** — Agents proactively suggest enabling skills instead of attempting inferior workarounds
- **Workspace Browser + Tunnel guidance** — Agents suggest skills for file sharing and remote access
- **Feedback coaching** — Agents proactively suggest submitting feedback when users hit issues
- **Technical preference** — Agents ask and respect the user's technical comfort level

### Skill Injection Race Condition Fix

Installing skills before saving sandbox configuration for the first time was corrupting AGENTS.md. Fixed: skills deploy files without touching AGENTS.md, deferred instructions injected once workspace is ready.

---

## 0.9.2 — April 10, 2026

### New Skill: Slack Use

Agents can read and send Slack messages, list channels, react to messages, and read canvas documents — even when Slack is not your communication channel with the agent.

- **Two authentication modes** — App Token (xoxb/xoxp) or Browser Session (xoxd + xoxc)
- **Full skill lifecycle** — Install, edit, and remove from the Settings UI
- **arm64 support** — x86_64 binary runs transparently on Apple Silicon via QEMU

### UI Improvements

- Skill card content no longer clipped by `max-height: 200px`
- Compact inline pill-style auth mode selector

---

## 0.9.1 — April 9, 2026

### New Skill: Airbnb Search

Search Airbnb listings directly from the agent — prices, ratings, and booking links with no API key required.

### New Models

Added GLM-5.1:cloud to the Ollama models list.

---

## 0.9.0 — April 9, 2026

A major release introducing ElevenLabs voice, MarkItDown document conversion, Slack & Discord support, product key activation, onboarding, and the removal of WSL2 in favor of Multipass + Docker.

### ElevenLabs Voice Skill

Full ElevenLabs TTS integration with 25+ voice options and guaranteed support for English, German, Spanish, Italian, and Portuguese. Voice preview and selection UI in the configure page.

### MarkItDown Skill

Convert PDF, Word, Excel, PowerPoint, HTML, images, audio, YouTube videos, CSV, JSON, and more to Markdown. Installs in an isolated Python venv.

### Slack & Discord Channel Support

Full CRUD for Slack channels and Discord guilds. Auto-enable with proper schema initialization. HowTo onboarding guides for bot tokens.

### Product Key Activation

License key activation and validation system with MeAll Technologies' licenses backend. Gate sequence: Terms of Service → License → Onboarding.

### Onboarding Experience

3-step onboarding for first-time users: Welcome → Docker Setup → Ready. Live polling auto-detects Docker availability. Onboarding state persisted in localStorage.

### Architecture

**WSL2 removed.** Virtualization now uses Multipass or Docker only.

### Bug Fixes

- OpenClaw version pinning fixed — new sandboxes pull pinned image version instead of `:latest`
- AGENTS.md injection moved to post-start polling loop
- Channel initialization fixed for Slack and Discord

---

## 0.8.0 — April 5, 2026

Major release: embedded terminal, skills system, Ollama integration, Telegram groups support, and WSL2 removal.

### Embedded Terminal (TUI)

Cross-platform terminal using `node-pty` — no external emulator dependencies. Consistent behavior across macOS, Windows, and Linux.

### Skills System

- **Composio** — Full skill management with OAuth authentication
- **Tunnel** — Cloudflared tunnels with password-protected auth gate
- **Workspace Browser** — Python HTTP file browser at port 7000
- **Proof Editor** — Collaborative markdown editing

### Ollama Integration

Status check, model pull with real-time SSE progress, cancel endpoint, and pull progress modal in the web UI.

### Telegram Groups Support

Telegram groups management with configuration endpoints and UI integration.

### Architecture

**WSL2 backend removed.** Multipass and Docker are the only supported engines.

---

## 0.7.2 — March 15, 2026

Further startup resilience improvements for macOS "Unknown system error -86" issues.

### Improvements

- Broadened architecture mismatch detection
- Switched to `app.isPackaged` for accurate environment detection
- Extended fallback timeout to 2 seconds
- Improved error dialog with runtime architecture info

---

## 0.7.1 — March 15, 2026

Hotfix for critical startup issues in v0.7.0. Automatic fallback to system Node.js when bundled binary is incompatible with the host architecture.

---

## 0.7.0 — March 15, 2026

Native Docker support and portable snapshots.

### Docker Virtualization Engine

Native Docker support across macOS, Linux, and Windows (via Docker Desktop). Sudo access and sandbox rebuilds from the UI.

### Portable Snapshots

Engine-agnostic snapshots — create in one engine, restore in another without losing state.

### Shared Folder Management

Redesigned UI for managing shared folders between host and sandbox.

### Technical

- Electron migrated to CommonJS (`.cjs`)
- Backend refactoring in `commands.js`, `wsl.js`, and `multipass.js`

---

## 0.6.0 — March 6, 2026

Centralized settings modal, provider configuration guides, dark mode, and Terms and Conditions.

### Settings Modal

Refactored to a streamlined, centralized, reusable modal component.

### Provider Setup Guides

Dynamic "How-To" modal system providing in-context configuration guides for AI providers and channels.

### Dark Mode

Seamless light/dark mode toggling adapted globally.

---

## 0.5.1 — February 15, 2026

WSL2 performance improvements, unified logging, and OpenRouter model additions.

### WSL2 Optimization

- `.wslconfig` management API
- 8GB Memory, 4 Processors auto-configuration
- Port isolation per sandbox on Windows

### Unified Logging

All logs written to `~/meall-agents/`. Execution timing with millisecond precision.

---

## 0.5.0 — February 13, 2026

Multi-platform binaries, automated CI/CD, and sandbox snapshots.

### Multi-Platform Binaries

Automatic builds for macOS (Intel + ARM64), Windows (x64), and Linux (x64 + ARM64) on every release.

### Automated QA

ESLint, Prettier, and test runner enforced on every pull request.

### Sandbox Snapshots

Create, restore, export/import, and delete complete sandbox state backups.

---

## 0.4.3 — February 11, 2026

Telegram bot now responds immediately after saving configuration — plugin auto-enabled on bot token save.

---

## 0.4.2 — February 9, 2026

Changed default ports to avoid conflicts:

- **Backend API:** 3001 → **6969**
- **Web UI:** 3000 → **9696**

---

## 0.4.1 — February 9, 2026

Windows VM fixes: auto-increment naming and setup script bundling.

---

## 0.4.0 — February 9, 2026

API key configuration redesign. `.env` approach with intelligent batch processing and smart change detection.

- Configure any combination of 8 providers in one operation
- 30-40s operations now take 5-10s
- Skip unnecessary gateway restarts

---

## 0.3.0 — February 6, 2026

Full Electron packaging for macOS and Windows. Native `.app` for macOS, NSIS installer for Windows. Bundled Node.js binary.

---

## 0.2.1 — February 5, 2026

Stop button added to VM dropdown menu.

---

## 0.2.0 — February 5, 2026

Security hardening (command injection and XSS prevention), full keyboard navigation, ARIA accessibility, and unified header with glowing logo.

---

## 0.1.0 — February 5, 2026

Foundation release. End-to-end setup with core features working.

- Cross-platform support (Windows, macOS, Linux)
- Virtualized agent sandboxes
- Multi-provider AI configuration
- Telegram integration
- Host folder mounting
- Keep-alive mechanisms

Everything works. First version ready for testing and feedback.

