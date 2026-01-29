# Template Integration

## Purpose
To handle the post-import process of integrating this repository's AI workflow into an existing project. This includes updating `AGENTS.md` and ensuring document consistency.

## Input
- The root path of the existing project where the template is being integrated.

## Output
- An updated `AGENTS.md` file in the target project.
- A consistency report for project documentation.
- A summary of the integration actions performed.

## Steps
1. **Locate `AGENTS.md`:** Scan the root of the target project for an `AGENTS.md` file.
2. **Update `AGENTS.md`:**
   - If `AGENTS.md` exists, append the AI workflow rules, guidelines, and available skills.
   - If `AGENTS.md` does not exist, create one using the template from this repository.
3. **Check Documentation:** Review existing documentation (e.g., `CONTRIBUTING.md`, `README.md`) for potential conflicts or overlaps with the imported AI workflow documents.
4. **Harmonize Documentation:**
   - Add references in existing documents to the new AI workflow documentation to ensure consistency.
   - For example, link from `CONTRIBUTING.md` to the AI development process outlined in `docs/ai-workflow/WORKFLOW.md`.
5. **Verify File Placement:** Confirm that the workflow files (`.github/`, `docs/ai-workflow/`, `.agents/skills/`) have been copied to the correct locations in the target project.
6. **Report on Integration:** Provide a summary of all changes made and flag any files that may require manual review and merging.

## Example Commands
This skill primarily relies on file system operations to read, create, and update files.
- `ls -a <target_project_root>`
- `cat <target_project_root>/AGENTS.md`
