# Contributing

Before contributing to this repository, please first clarify what changes you want to make through the PR, and create a
corresponding issue or feature in the form of an issue to associate your PR. In the PR, you need to clearly express your
intentions:

1. What parts were implemented or modified?
2. How compatible for these changes?

Or contact the owner of this repository via email or any other method before making changes.

Please note we have a code of conduct, please follow it in all your interactions with the project.

## Pull Request Process

1. Update README.md with the details of the changes, including example hcl blocks and [example files](./examples), if
   appropriate.
2. Once all open comments and all checklist items are resolved, your contributions will be merged! The merged PR will be
   included in the next release. The terraform-aws-vpc maintainers are responsible for updating the CHANGELOG when they
   merge.

## Checklists for contributions

- [ ] Add [semantics prefix](#semantic-pull-requests) to your PR or Commits (at least one of your commit groups)
- [ ] CI tests are passing
- [ ] README.md has been updated after any changes to variables and outputs. See https://github.com/terraform-huaweicloud-modules/terraform-huaweicloud-vpc/#doc-generation

## Semantic Pull Requests

To generate changelog, Pull Requests or Commits must have semantic and must follow conventional specs below:

- `feat:` for new features
- `fix:` for bug fixes
- `improvement:` for enhancements
- `docs:` for documentation and examples
- `refactor:` for code refactoring
- `test:` for tests
- `ci:` for CI purpose
- `chore:` for chores stuff

The `chore` prefix skipped during changelog generation. It can be used for `chore: update changelog` commit message by
example.
