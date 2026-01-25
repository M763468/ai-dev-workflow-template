# AGENTS.md - Rules for AI Agents

## 1. Purpose

This document provides a set of rules and guidelines for AI agents (such as Jules, Gemini, or Codex) contributing to this repository. The goal is to ensure all contributions are safe, consistent, and aligned with the project's standards. This file serves as the "constitution" for AI agents.

## 2. Do's and Don'ts

### Do
- **Adhere to the Issue Scope**: Implement only what is explicitly defined in the `Goal`, `Scope`, and `Acceptance Criteria` of the assigned issue.
- **Follow Established Patterns**: Use existing code patterns, conventions, and architectural styles.
- **Write Necessary Tests**: Provide lightweight tests to validate your implementation, as specified in the issue.
- **Use Standard Labels**: Apply labels as defined in `docs/LABELS.md`.
- **Update Documentation**: If your changes affect user-facing behavior or system design, indicate that the README or other documentation needs to be updated.

### Don't
- **Do Not Add Unauthorized Dependencies**: Do not add, remove, or update any dependencies unless explicitly instructed to do so in the issue.
- **Do Not Implement Outside Scope**: Do not introduce any functionality or fixes that are not part of the assigned issue. If you identify a potential improvement, suggest it in a comment.
- **Do Not Change Build Configurations**: Do not modify build scripts, CI/CD pipelines, or any other repository configuration files without explicit permission.
- **Do Not Commit Directly**: All changes must be submitted through a pull request linked to the corresponding issue.

## 3. Change Policy

- **Destructive Changes**: Any change that is destructive (e.g., removing a file, altering a public API) must be explicitly approved in the issue description.
- **Large-Scale Refactoring**: Do not perform large-scale refactoring unless it is the primary goal of the assigned issue. Small, localized refactoring for clarity is acceptable.
- **Data Schema Changes**: Any modifications to data schemas or database structures require explicit sign-off from the project maintainers.

## 4. Quality Bar

- **Testing**: All code must be accompanied by tests sufficient to prove it meets the `Acceptance Criteria`. The "How to test" section of the issue should be followed precisely.
- **Linting**: Code must adhere to the project's linting standards.
- **Logging**: Add clear and concise logging for errors and important events. Avoid noisy or verbose logging.
- **PR Descriptions**: Pull request descriptions must be filled out completely, following the `.github/pull_request_template.md`. The `Related Issue` field is mandatory.

## 5. Security

- **No Secrets in Code**: Never hardcode secrets, API keys, or any other sensitive credentials in the source code. Use environment variables or a designated secrets management system.
- **Data Transmission**: Do not transmit any user data or sensitive information to external services unless it is a documented and approved part of the functionality.
- **Input Validation**: Always sanitize and validate user-provided input to prevent common vulnerabilities (e.g., XSS, SQL injection).

## 6. Project-Specific Overrides

This section is for project-level custom commands, rules, or environment-specific guidelines.

- **(Example)** All backend services must be started using `./scripts/start_backend.sh`.
- **(Example)** Before submitting, run `./tools/pre_commit_check.sh` to verify your changes.
