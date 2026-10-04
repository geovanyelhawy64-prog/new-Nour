# UNIVERSAL AUTONOMOUS AGENT PROTOCOL (UAAP-v2)

## 1. ENVIRONMENTAL AUTO-DISCOVERY (First Action Upon Entry)
Before generating or modifying any code, inspect the root directory to dynamically determine the project ecosystem:
- Detect Runtime & Package Manager: Look for `package.json` (Node/Bun/Pnpm), `pyproject.toml`/`requirements.txt` (Python), `Cargo.toml` (Rust), `go.mod` (Go), `composer.json` (PHP), or `pom.xml`/`build.gradle` (Java).
- Detect Test & Lint Harness: Identify existing test runners (pytest, vitest, jest, cargo test, etc.) and linters (eslint, ruff, clippy).
- Never install unrequested dependencies or change the detected package manager without explicit permission.

## 2. RESOURCE & NETWORK DEFENSE (Zero-Lag & Zero-Bandwidth Mode)
- CLI-Only Verification: ALL verifications MUST run via headless terminal commands (unit tests, build checks, linter runs).
- Visual Prohibition: NEVER trigger browser recordings, web page screenshots, or graphical inspection tools. Keep communications purely text-based.
- Context Minimization: Read ONLY the specific functions and files related to the task. Avoid reading lockfiles, massive bundle outputs (`dist/`, `build/`), logs, or vendor directories (`node_modules/`, `venv/`).

## 3. AUTONOMOUS STATE ENGINE & PROGRESSION
- Single Active Task Focus: Work on exactly ONE objective at a time. If the user gives a high-level goal, break it down internally into sequential steps.
- Self-Contained Documentation: Track ongoing state by maintaining or checking `TASKS.md` in the root:
  - Format: `- [ ] Task ID: Description (Target files)`.
  - Mark completed tasks with `- [x]` only AFTER terminal verification succeeds with Exit Code 0.
- Atomic File Operations: Modify only the target files specified. Do not perform global refactors or modify adjacent, working features.

## 4. STRICT ERROR HANDLING & FAIL-SAFE (The Two-Strike Rule)
- Attempt 1 (Fix): On terminal/test failure, parse the exact stack trace and apply a logical fix.
- Attempt 2 (Alternative): If the same error or a cascading failure occurs, attempt an alternative, minimal approach.
- Strike 2 (Hard Stop): If the error persists after two consecutive attempts, STOP execution immediately.
  - DO NOT enter random trial-and-error loops.
  - Output a structured Root Cause Analysis (RCA):
    1. Failed Command & Exit Code.
    2. Primary Error Message.
    3. Root Hypothesis (Why it failed).
    4. Actionable decision required from the user.

## 5. QUALITY & ARCHITECTURAL STANDARDS
- Zero Placeholders: Writing mock placeholders (`// TODO: implement`, `pass`, `# later`) is strictly prohibited. Provide production-ready, fully realized logic.
- Backward Compatibility: Ensure new modifications do not break existing tests or public API contracts.
- Clean Output: When yielding execution, summarize changes in 3 bullet points or fewer: Modified Files, Test Command Run, and Status.