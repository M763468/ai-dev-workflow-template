# Dependency Management

## Purpose
To check for consistency between the `requirements.txt` file and the import statements in the codebase.

## Input
- The path to the `requirements.txt` file.
- The path to the source code directory.

## Output
- A report of any inconsistencies found, such as:
  - Missing dependencies in `requirements.txt`.
  - Unused dependencies in `requirements.txt`.
  - Dependencies that are imported but not listed in `requirements.txt`.

## Steps
1. Parse the `requirements.txt` file to get a list of declared dependencies.
2. Recursively scan the source code directory for Python files.
3. For each Python file, parse the import statements to identify the imported modules.
4. Compare the set of imported modules with the set of declared dependencies.
5. Generate a report of any discrepancies found.

## Example Commands
- `pip freeze > requirements.txt`
- `pip check`
