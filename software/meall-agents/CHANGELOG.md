## 0.26.1 — September 24, 2026

MeAll Agents 0.26.1 is a hotfix release: **the downloads on the website work again**.

---
## 0.26.0 — September 24, 2026

MeAll Agents 0.26.0 introduces **Node Mode**: turn any computer running the MeAll App into a helper for one of your sandboxes — the sandbox can run commands, work with files, and browse the web on that computer, always within the permissions you set. It also introduces **Remote Node Mode**: connect a computer to a sandbox running on a remote server over your home network, Tailscale, or a secure connection — plus more reliable Cockpit, Hub, and app connections on custom network setups.

---
## 0.25.2 — September 1, 2026

MeAll Agents 0.25.2 is a hotfix release: **sandbox cards correctly show your ChatGPT subscription as connected**, **saving settings returns you to the main window instead of a broken view**, and the **password screen fully covers the app**.

---
## 0.25.1 — August 31, 2026

MeAll Agents 0.25.1 is a fix release: **the Cockpit now loads reliably when the MeAll App is connected to a remote server**, plus **smoother switching between computers** and a **staging server restart fix**.

---
## 0.25.0 — August 31, 2026

MeAll Agents 0.25.0 delivers **switching between your computer and remote servers without restarting**, **sandbox renaming**, and a **one-command install**, plus fixes for keyboard shortcuts, live connections over the local network, and Cockpit sign-ins.

---
## 0.24.0 — August 24, 2026

MeAll Agents 0.24.0 delivers **light and dark themes that follow your system**, **a matching translucent look on macOS and Windows**, a **nicer finish after creating a sandbox**, and a round of **packaging and UI fixes** — including clickable dashboard and Cockpit headers while a Hub tab is open.

---
## 0.23.0 — August 9, 2026

MeAll Agents 0.23.0 introduces **remote server mode** — run the heavy work on a server while the MeAll App on your computer acts as a lightweight remote control — plus **ready-made sandbox images**, **one-command server setup**, a comprehensive **fresh look across the dashboard, Cockpit, and settings pages**, and a redesigned **sandbox creation progress bar** — cutting first-sandbox creation from 10+ minutes to under a minute.

---
## 0.22.0 — June 21, 2026

**A quick security & reliability bump.**

This dot release updates the built-in agent engine — bringing richer messaging, stronger agent recovery, and better tools for people who build on it.

---
## 0.21.0 — June 20, 2026

**A foundation upgrade — security, resilience, and smarter tooling.**

This release focuses on the engine room. We updated the agent engine across four stable releases, hardened security, gave you parallel search superpowers, and made the system more resilient under pressure.

---
## 0.20.0 — June 20, 2026

MeAll Agents 0.20.0 adds **more reliable free-model routing**, a redesigned model picker with quality scores and pricing, and better license handling without internet — making the app more reliable offline and model selection clearer.

---
## 0.19.0 — June 18, 2026

MeAll Agents 0.19.0 adds **Hugging Face as a first-class AI provider**, giving you instant access to popular open-weight frontier models — including DeepSeek, Qwen, Llama, GLM, and GPT-OSS — through a single token. This is the first new provider since NVIDIA and opens the door to a much broader model catalog without additional API keys or subscriptions.

---
## 0.18.0 — June 14, 2026

MeAll Agents 0.18.0 introduces support for opening the MeAll Agents screen and terminals from other devices on your local network, with settings and access controls. It also includes an updated agent engine for sandboxes.

---
## 0.17.0 — May 31, 2026

MeAll Agents 0.17.0 ships the biggest upgrade yet for coding help: **automatic setup for AI coding assistants**. Your coding assistants (Copilot, Gemini CLI, Claude Code, Codex) are now found, health-checked, and configured through dedicated skill cards — no more editing settings files by hand. This release also brings Kanban task improvements and more reliable sandbox handling.

---
## 0.16.1 — May 27, 2026

MeAll Agents 0.16.1 is a focused stability patch. This release tightens Cockpit reliability when AI runs fail, stops a known broken DeepSeek route from being picked by default, and keeps more helpful guidance around for the future.

---
## 0.16.0 — May 26, 2026

MeAll Agents 0.16.0 ships sandbox updates, dark mode by default, and a tighter Cockpit experience. The biggest change: when a new agent engine version lands, your sandbox tells you — and updating is one click. No more rebuilding anything by hand in a terminal.

---

## 0.15.4 — May 12, 2026

A focused bug fix release — Cockpit launch is working reliably again and packaged builds run quieter behind the scenes.

### Cockpit Launch Restored

Cockpit refused to open after a sandbox rebuild because of a broken settings block. Removed, so launching works again.

### Quieter Packaged Builds

In installed builds, background services no longer spam the console. Detailed output is still available in development mode.

### Settings Saves Fixed

Two settings files were being saved with broken line endings. Corrected.

---
## 0.15.3 — May 12, 2026

Cockpit reliability improvements and polished macOS packaging.

### Scheduled Runs Work Again After Rebuild

After a sandbox rebuild, scheduled runs silently stopped working because a permission was missing. The app now makes sure the required permissions are in place — repairing them automatically before Cockpit launches, restarting the sandbox if needed so the change takes effect immediately.

### Sandbox Restarts Fixed

Restarting a sandbox from the app failed silently for sandboxes with special characters in their names. Now it works regardless of the name.

### Clearer Build Errors

When the Cockpit fails to build inside a sandbox, you now get a clear, actionable error message instead of raw technical output.

### Rebuild Does Things in the Right Order

Rebuilding a sandbox now handles permissions, tools, free-model routing, and automatic fixes in the right order.

### macOS Packaging

- Nicer disk image with background artwork, positioned app icon, and Applications shortcut
- **Quick Install script** — a file inside the disk image runs a guided installation to Applications with a progress indicator
- Proper app icon bundle and automated icon pipeline
- Unnecessary developer files excluded from the installed app

---

## 0.15.2 — May 11, 2026

Two solid improvements — automatic update checks and a sandbox recovery fix.

### Update Check & Auto-Download

MeAll Agents now checks for new versions automatically. The app periodically fetches the latest version from our server and notifies you when an update is available.

- **Automatic background checks** — a couple of times per day and on first launch after installing
- **One-click update** — when an update is available, a clear prompt in the About window lets you download the right installer for your computer (Mac with Apple chip, Mac with Intel chip, Windows, Linux)
- **Manual check** — click "Check for updates" in the About window anytime, with the last check time shown below the button

### Sandbox Recovery Fix

Sandboxes with special characters in their names (slashes and the like) can now always be found and recovered by the app — including sandboxes created before this fix.

### Bug Fixes

- **Update check on open** — opening the About window with no prior check now checks immediately, so you never see stale data
- **Sandbox recovery** — sandboxes with unusual characters in their names are now properly recoverable

---
## 0.15.1 — May 11, 2026

A focused quality release — stability fixes, better sandbox handling, and a long-standing interface fix.

### What's Fixed

**Links Now Open in Your Browser** — Clicking a web link in Cockpit used to open it in a new MeAll App window instead of your system browser. Fixed: public links go to your browser; your own local addresses stay in the app where they belong.

**More Reliable Saving & Startup** — Sandbox and server settings save more dependably, with cleaner startup sequencing behind the scenes.

**Clearer Status Feedback** — The app now shows more clearly what's starting, running, or failing — so you can see what's happening at a glance.

### Bug Fixes

- Public links open in system browser from Cockpit (#118)
- Memory search falls back to a working provider
- Device permissions repaired automatically in sandbox environments
- Consistent code formatting in chat messages

---
## 0.15.0 — May 7, 2026

MeAll Agents 0.15.0 makes AI free. This release puts ModelRelay inside every sandbox — it tries out free coding models across top providers live and automatically sends your requests to the best available one.

### ModelRelay — Free AI, Automatically

ModelRelay runs inside every sandbox and sends each request to the best available free model.

- **auto-fastest** — The default continuously weighs speed and capability to pick the right model for each request
- **100% savings on AI** — Free models first, paid keys as fallback
- **Built-in dashboard** — Watch routing decisions, provider health, and available models from the interface
- **Zero-config** — Already inside the sandbox and starts automatically

### Ollama — Local Models, One Click Away

Full Ollama integration with download, setup, and model management directly from Settings. Badges make model origins clear at a glance.

### NVIDIA as a First-Class Provider

Native NVIDIA key integration. Add your key in Settings and models appear immediately with proper badges.

### Kami — Professional Document Generation

Typeset one-pagers, resumes, slide decks, letters, and portfolios on warm parchment with ink-blue accents. Install with one click from the skill list.

### Bug Fixes

- **Agent instructions kept intact** — Skill guides no longer get cut off when a sandbox is created
- **Provider setup** — Cleaner key and address handling when adding providers
- **Model list alignment** — Fixed alignment in the settings model list

---
## 0.14.0 — May 5, 2026

Your agent now has a cockpit. MeAll Agents 0.14.0 ships a full operational control surface for your sandbox — agent fleet control, workspace browser, kanban board, scheduled runs, session history, and more. Plus a fresh look with simple icons and a cohesive light/dark theme system.

### Cockpit — Your Agent's Operating Surface

Click **Cockpit** on the sandbox card and it opens ready to go with no setup.

- **Agent fleet control** — Run multiple agents from one place, each with its own workspace, memory, and skills
- **Workspace browser & editor** — Browse files, edit documents, view rendered documents, inspect PDFs — live while the agent runs
- **Kanban task board** — Delegate work onto a structured board; agents propose, you decide
- **Scheduled runs** — See, create, and manage scheduled agent runs with clear labels
- **Session history** — Inspect what helpers have been doing without losing your main thread
- **Memory & settings editing** — Inspect and edit agent memory, settings, and skills from the interface
- **Rich output** — Charts, file comparisons, highlighted code, image previews, structured tool views
- **Token usage & cost tracking** — See what your agent is spending in real time

### Fresh New Look

- Shared design with custom fonts, surfaces, borders, and accents
- Simple icon system replacing emoji labels across all pages
- Sticky header with rounded corners and subtle accent line
- Refined windows, buttons, and loading indicators throughout
- Dark theme with proper depth instead of just inverted colors

### Sandboxes

- Cockpit updates ship with the sandbox and install during setup
- Bundled starter skills (starting with task boards) sync into the agent workspace automatically

### Bug Fixes

- Agent Chat input freeze fixed
- Clearer scheduling window

---
## 0.13.0 — April 22, 2026

Your agent now has its own web chat — branded, personalized, and accessible from anywhere. Plus smart device approval that just works.

### OpenWebUI Skill

A full web chat for your agent that you can brand and personalize. It reads your agent's identity card to create a tailored model card — name, emoji, description.

- **One-command setup** — branding and access details all handled automatically
- **MeAll Agents styling** — dark theme, custom sign-in page, logo, and icon
- **Start, stop, restart, and logs** — manage it like any other service
- **Remote access** — automatically reachable from outside your network when started

### Agent Chat — Smart Device Approval

Connecting a new device used to ask for approval every single time. The app now remembers approved devices:

- **Automatic approval** — pending requests are approved and the terminal reloads
- **Remembered devices** — approved once, skipped from then on
- **Reliable detection** — connection problems are caught with a fallback timer for tricky cases

### Todo Skill — Lists That Don't Lose Items

Agents used to sometimes edit the task file directly instead of going through the app, and changes would silently disappear. That path is now closed — lists stay consistent.

### Bug Fixes

- Fixed sandbox update notifications so new sandboxes get the pinned version instead of the latest
- Agent setup instructions applied after startup instead of too early
- Chat channel setup fixed for Slack and Discord

---
## 0.12.1 — April 19, 2026

A new GitHub skill, a cleaner model list for people who don't run local models, and an improved editing guide.

### GitHub Skill

Your agent can manage GitHub repositories, issues, pull requests, and releases — all from the sandbox.

- **Easy sign-in** — log in from the settings page, no terminal needed
- **Full repository access** — repos, issues, pull requests, releases
- **Settings screen** — install, sign in, and manage with status cards

### Ollama Toggle

Don't run local models? A switch in Settings hides the Ollama section entirely when you don't need it.

### Proof Editor — Collaborative Editing Guide

Updated guidance for editing a document someone is actively changing:

- Read, snapshot, edit one block, re-read
- What to avoid when collaborating on docs
- When to leave the document alone instead of rewriting it

### Bug Fixes

- **OpenRouter connection** — Fixed a wrong server address that broke the integration

---
## 0.12.0 — April 15, 2026

A built-in Todo app, smarter shared folders for agents, and more reliable sign-in through shared links.

### Todo App

A shared task manager running inside the sandbox — you and your agent see the same list in real time.

- **Built-in web screen** with drag-and-drop, light/dark themes, and auto-refresh
- **Full task API** — create, reorder, and clear completed tasks programmatically
- **Start, stop, and restart** from the settings page — no terminal needed
- **"Open Todo App" button** opens it in a new tab

### Shared Folders — Agent Awareness

Agents now understand shared folders explicitly: available in the sandbox, two-way, live sync. No more guessing where to look.

### Sign-In Through Shared Links

Opening a shared password-protected link used to silently drop some request types. Sign-in and the Todo app now work reliably through shared links.

### Bug Fixes

- Todo items get IDs automatically when missing
- Empty delete requests are rejected instead of silently succeeding

---
## 0.11.0 — April 14, 2026

Interface polish, service controls, sticky headers, and an updated agent engine.

### Skill Service Management

Start, stop, and restart file-sharing and remote-access services directly from the settings page. Logs refresh automatically every few seconds.

### Save Configuration Flow

- Step-by-step progress with animated overlay
- Clear indicator follows the current saving step
- Save button shows progress while saving
- One restart applies all configuration changes

### Sticky Headers

Fixed header across all pages — main screen, settings, snapshots, and workspace browser.

---
## 0.10.0 — April 13, 2026

Major upgrade shipping an updated agent engine, password protection, and a new screen for configuring how your agent behaves.

### Password Protection

- Lock screen with password for the MeAll App and its connections
- Choose how long you stay signed in (1h, 4h, 8h, 24h, always)
- Slows down repeated wrong guesses

### Agent Behavior Settings

- **Active Memory** — a dedicated memory helper that pulls in your relevant preferences before each reply
- **Dreaming** — automatically compiles what the agent learns into a knowledge wiki

### ElevenLabs Voice Settings

Voice and speech settings in plain language. Voice features turn on automatically when you install the skill.

### Reliability & Performance

- **One restart applies everything** — all settings changes take effect together
- **Settings survive restarts** — features you turn on stay on after a restart
- **Settings open fast** — even with lots of providers configured

### Bug Fixes

- Features turn on and off reliably, even on brand-new sandboxes
- Fixed a sign-in gap in the workspace file browser
- Fixed license activation timing

---
## 0.9.6 — April 13, 2026

Docker is now built in. New installs just work — no setup needed. Existing installs carry over on first launch.

---
## 0.9.5 — April 12, 2026

Windows fixes — large skill setups transfer cleanly, folder picking handles Windows paths, shared folders work, and packaged builds include everything the terminal needs.

### Bug Fixes

- **Skill setups** — Large skill files transfer without hitting Windows limits
- **Folder picker** — Backslash paths handled correctly
- **Shared folders** — Work on Windows as they do everywhere else
- **Built-in terminal** — Packaged builds include everything it needs

---
## 0.9.4 — April 12, 2026

Hand-picked models with quality scores. All model lists now show real agent benchmark results.

### Provider Updates

- **OpenAI** — Newest small model added, old ones removed
- **Anthropic** — Model names fixed so scores and availability display correctly
- **Groq** — Full refresh with current production and preview models
- **OpenRouter** — Latest Claude and GPT models added
- **Ollama Cloud** — Expanded from 4 to 12 models, sorted by quality score

Each model card now shows a **quality score** (% of tasks completed) and **average price** per task.

---
## 0.9.3 — April 12, 2026

Feedback system, clearer agent prompts, and a fix for disappearing setup instructions.

### Feedback System

Send bug reports and suggestions directly from the app. No account needed.

### Clearer Agent Prompts

The agent's standing instructions were expanded:

- **Knows its environment** — Agents understand they run inside MeAll Agents sandboxes
- **Skills catalog** — Agents proactively suggest turning on skills instead of working around them
- **File sharing + remote access guidance** — Agents suggest the right skills for sharing files and reaching the sandbox remotely
- **Feedback coaching** — Agents suggest sending feedback when you hit issues
- **Respects your level** — Agents ask and respect how technical you want them to be

### Setup Instructions Fix

Adding skills before first saving a sandbox used to corrupt the setup instructions. Fixed: skills install cleanly, guidance is added once the workspace is ready.

---
## 0.9.2 — April 10, 2026

### New Skill: Slack Use

Connect chats, read and send messages, list channels, and react — even when Slack isn't how you talk to the agent.

- **Two sign-in modes** — workspace app or browser session
- **Full lifecycle** — Install, edit, and remove from Settings
- **Works on Apple Silicon** — Intel tools run transparently

---
## 0.9.1 — April 9, 2026

### New Skill: Airbnb Search

Search listings directly from the agent — prices, ratings, and booking links, no extra sign-in required.

### New Models

Added the newest compact model to the local model list.

---
## 0.9.0 — April 9, 2026

A major release introducing voice messages, document conversion, Slack & Discord support, product key activation, guided setup, and simpler virtualization — one built-in engine, no extra setup.

### ElevenLabs Voice Skill

Full voice messages with 25+ voice options in English, German, Spanish, Italian, and Portuguese. Voice preview and selection in the settings page.

### MarkItDown Skill

Convert PDFs, Word files, spreadsheets, presentations, web pages, images, audio, videos, and more to clean text. Installs self-contained.

### Slack & Discord Notifications

Connect notification channels with step-by-step bot setup guides.

### Product Key Activation

Sign in with your license key in three guided steps: welcome, setup check, ready.

### Guided Setup

3-step first launch: Welcome → Setup Check → Ready. The app detects automatically when your computer is ready.

### Bug Fixes

- New sandboxes always use the tested version instead of sometimes grabbing the newest
- Setup instructions applied at the right moment
- Chat channel setup fixed for Slack and Discord

---
## 0.8.0 — April 5, 2026

Major release: built-in terminal, skills system, local AI models, Telegram groups support, and one built-in engine.

### Built-in Terminal

A terminal that works the same on Mac, Windows, and Linux — no extra terminal app needed.

### Skills System

- **Composio** — Manage skills with easy sign-in
- **Tunnel** — Share your sandbox publicly with a password-protected link
- **Workspace Browser** — Browse and download your agent's files from a web page
- **Proof Editor** — Edit documents together with your agent

### Ollama Integration

Check what's installed, download models with live progress, cancel anytime, and watch progress in the app.

### Telegram Groups Support

Manage Telegram groups and channels from settings.

---
## 0.7.2 — March 15, 2026

More startup fixes for Macs that show "Unknown system error" on launch.

### Improvements

- Automatic detection when the wrong system version was installed
- Accurate startup environment detection
- Longer fallback wait, clearer error message with system details

---
## 0.7.1 — March 15, 2026

Hotfix for startup problems in v0.7.0. Falls back to your computer's own Node.js automatically when the built-in one doesn't fit.

---
## 0.7.0 — March 15, 2026

Built-in sandbox engine and portable backups.

### Sandbox Engine

Built-in engine support across Mac, Linux, and Windows. Sudo access and sandbox rebuilds from the interface.

### Portable Backups

Back up a whole sandbox and restore it on another computer without losing anything.

### Shared Folder Management

Redesigned screen for managing shared folders between your computer and the sandbox.

---
## 0.6.0 — March 6, 2026

Central settings screen, provider setup guides, dark mode, and Terms and Conditions.

### Settings Screen

One organized place for all settings instead of scattered screens.

### Provider Setup Guides

Step-by-step guides inside the app for connecting AI providers and channels.

### Dark Mode

Light and dark themes you can switch anytime.

---
## 0.5.1 — February 15, 2026

Performance improvements, one log file, and new models.

### Faster Startup

- Automatic performance tuning on Windows
- 8GB memory and 4 processors configured for you
- Sandboxes kept separate on Windows

### One Log File

All logs in one place with precise timing.

---
## 0.5.0 — February 13, 2026

Multi-platform downloads, automated quality checks, and sandbox backups.

### Multi-Platform Downloads

Ready-made downloads for Mac (Intel + Apple chip), Windows, and Linux on every release.

### Automated Quality Checks

Spelling, formatting, and tests run automatically on every proposed change.

### Sandbox Backups

Create, restore, and delete complete sandbox backups.

---
## 0.4.3 — February 11, 2026

Your chat bot answers immediately after you save settings — no restart dance.

---
## 0.4.2 — February 9, 2026

New default addresses so nothing clashes with your other apps:

- **App and connections:** 3001 → **6969**
- **Screens in your browser:** 3000 → **9696**

---
## 0.4.1 — February 9, 2026

Windows fixes: automatic names and setup files included where needed.

---
## 0.4.0 — February 9, 2026

Simpler, faster API key setup. Save any combination of providers in one go.

- Set up all your AI providers in one operation
- Saving takes seconds instead of half a minute
- No unnecessary restarts while saving

---
## 0.3.0 — February 6, 2026

Full packaging for Mac and Windows. Installs like a normal app, auto-updates included.

---
## 0.2.1 — February 5, 2026

Stop button added to the sandbox menu.

---
## 0.2.0 — February 5, 2026

Security hardening, full keyboard control, high-contrast support, and a unified header.

---
## 0.1.0 — February 5, 2026

First release. Setup works end to end with the core features.

- Works on Windows, Mac, and Linux
- Sandboxes for your agents
- Connect any AI provider
- Telegram integration
- Shared folders with your computer
- Keeps running in the background
