# Contributing to Locket Dio Desktop

Thank you for your interest in contributing to **Locket Dio Desktop**! Whether you are fixing a bug, suggesting a new feature, improving documentation, or refining the UI/UX, all contributions are warmly welcomed and deeply appreciated.

Please take a moment to review this guide to make your contribution process as smooth as possible.

---

## 📑 Table of Contents

- [Code of Conduct](#-code-of-conduct)
- [How Can I Contribute?](#-how-can-i-contribute)
  - [Reporting Bugs](#-reporting-bugs)
  - [Suggesting Features & Enhancements](#-suggesting-features--enhancements)
  - [Working on Existing Issues](#-working-on-existing-issues)
- [Development Setup](#-development-setup)
  - [Prerequisites](#prerequisites)
  - [Getting Started](#getting-started)
  - [Running the Desktop App](#running-the-desktop-app)
  - [Running the Website](#running-the-website)
  - [Code Quality & Testing](#code-quality--testing)
- [Pull Request Guidelines](#-pull-request-guidelines)
  - [Branch Naming](#branch-naming)
  - [Commit Message Conventions](#commit-message-conventions)
  - [Submitting a PR](#submitting-a-pr)
- [Contributors](#-contributors)
- [Community & Support](#-community--support)

---

## 🤝 Code of Conduct

We are committed to providing a welcoming, inclusive, and harassment-free environment for everyone. Please be respectful, constructive, and collaborative in all issues, pull requests, and discussions.

---

## 💡 How Can I Contribute?

### 🐛 Reporting Bugs

Before creating a bug report:
1. Search the [existing Issues](https://github.com/doi2523/Locket-Desktop/issues) to ensure the bug hasn't already been reported or resolved.
2. Check if you are using the latest version of Locket Dio Desktop.

When opening a new bug report, please include:
- A clear and descriptive title.
- Steps to reproduce the issue.
- Expected behavior vs. actual behavior.
- Screenshots, recordings, or console logs if applicable.
- Your environment details:
  - Operating System (Windows 10/11, macOS Sequoia/Sonoma, etc.)
  - App version (found in **Settings → Info**).

### ✨ Suggesting Features & Enhancements

Have an idea to make Locket Dio Desktop better?
- Open a feature request under [GitHub Issues](https://github.com/doi2523/Locket-Desktop/issues) or start a thread in [Discussions](https://github.com/doi2523/Locket-Desktop/discussions).
- Clearly explain the problem your feature solves, why it would be beneficial, and any mockups or implementation ideas you have.
- For major architectural or feature changes, please discuss and get approval before investing significant time into coding a Pull Request.

### 🎯 Working on Existing Issues

- Check out issues tagged with [`good first issue`](https://github.com/doi2523/Locket-Desktop/labels/good%20first%20issue) if you are new to the codebase.
- Comment on the issue you wish to work on to let others know, preventing duplicate effort.

---

## 💻 Development Setup

### Prerequisites

Make sure you have the following tools installed:
- **Flutter SDK**: `stable` channel (Dart 3.x+). Run `flutter doctor` to verify your environment.
- **Go SDK**: `1.21+` (required to build the local background microservices `locket-grpc` and `locket-sse`).
- **FFmpeg**: Placed in system `PATH` or inside the `ffmpeg/` directory (required for video trimming, cropping, and compression).
- **Node.js**: `v20+` & npm (only required if contributing to the landing page in `apps/website`).

### Getting Started

1. **Fork the repository** on GitHub.
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/<your-username>/Locket-Desktop.git
   cd Locket-Desktop
   ```
3. **Add the upstream remote**:
   ```bash
   git remote add upstream https://github.com/doi2523/Locket-Desktop.git
   ```

### Running the Desktop App

```bash
# Install Flutter dependencies
flutter pub get

# Run on Windows
flutter run -d windows

# Run on macOS
flutter run -d macos
```

### Running the Website

If you are working on the landing page in `apps/website`:

```bash
cd apps/website
npm install
npm run dev
```

### Code Quality & Testing

Before submitting your changes, run static analysis and tests to ensure code quality:

```bash
# Analyze Flutter & Dart code
flutter analyze

# Run unit and widget tests
flutter test

# If working on apps/website:
cd apps/website
npm run lint
npm run build
```

---

## 🚀 Pull Request Guidelines

### Branch Naming

Create a descriptive topic branch from `main`:
- `feat/feature-name` (e.g., `feat/custom-reaction-picker`)
- `fix/issue-description` (e.g., `fix/window-minimize-tray`)
- `docs/topic-name` (e.g., `docs/contributing-guide`)
- `refactor/component-name` (e.g., `refactor/chat-timeline-state`)

### Commit Message Conventions

We follow [Conventional Commits](https://www.conventionalcommits.org/). This keeps the git history clean and readable:

```
<type>(<scope>): <short description>
```

**Common types:**
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation updates
- `style`: Formatting, missing semicolons, etc. (no functional code changes)
- `refactor`: Code refactoring that neither fixes a bug nor adds a feature
- `perf`: A code change that improves performance
- `test`: Adding or updating tests
- `chore`: Maintenance tasks, dependencies, build configs

*Examples:*
- `feat(chat): add context menu for copying moment links`
- `fix(tray): prevent crash when restoring window on Windows 11`
- `docs: update setup steps in CONTRIBUTING.md`

### Submitting a PR

1. Keep your PR focused on a single topic or issue. Avoid mixing unrelated changes.
2. Ensure your branch is rebased on the latest `upstream/main`.
3. Verify that `flutter analyze` passes without errors or warnings.
4. Fill in the PR description template:
   - What does this PR change and why?
   - Link the relevant issue (e.g., `Closes #12`).
   - Include screenshots or GIFs for UI/UX changes.
5. We will review your PR as soon as possible and provide feedback.

---

## 👥 Contributors

Thanks goes to these wonderful people who have contributed to Locket Dio Desktop:

<div align="center">

<a href="https://github.com/doi2523/Locket-Desktop/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=doi2523/Locket-Desktop" alt="Contributors" />
</a>

*Made with [contrib.rocks](https://contrib.rocks).*

</div>

---

## 📬 Community & Support

Need help or want to chat with the developer and other contributors?
- 💬 **Telegram Group**: [t.me/+MjfI6qspzYZmNzRl](https://t.me/+MjfI6qspzYZmNzRl)
- 🎮 **Discord**: [discord.com/invite/47buy9nMGc](https://discord.com/invite/47buy9nMGc)
- ✉️ **Email**: [doibncm2003@gmail.com](mailto:doibncm2003@gmail.com)
- 🌐 **Website**: [locket-dio.com](https://locket-dio.com)

---

<div align="center">

**[← Back to README](./README.md) | © 2025 [Locket Dio](https://locket-dio.com)**

</div>
