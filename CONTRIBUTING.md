# Contributing to Devstarter

## Table of contents

* Commit style guide
* Reporting a bug
* Solving a bug
* Proposals
* Adding a new feature
* Adding a new template

### Commit style guide

Commit messages must follow a specific style:

```
[commit_type] (issue #[issue_number]): [description]
```

`commit_type` can be one of the following labels:
* `bug-fix`
* `proposal`
* `template`

If there is no corresponding issue, you can omit that part.

### Reporting a bug

If the tool presents an unexpected behaviour, make sure to report it as a bug. To do so, create an issue with the tag `bug`, describing the problem with as many detail as possible. 

### Solving a bug

To solve a bug, create a pull request with the bug fix, explain the source of the error and how it has been resolved. The bug must be previously reported and the issue will be closed with the tag `solved`.

### Proposals

To propose a new feature to the tool, create an issue with the tag `proposal`, explaining the feature to be added, why it's important to add it, and the reason behind the idea. If the proposal is accepted, the issue will be marked as `accepted`. Otherwise, the issue will not be closed, but marked as `denied`.

### Adding a new feature

To add a new feature, make sure there is an accepted proposal, then create a pull request to add new content to the project. Generally, proposals may have its own branch for testing purposes.

### Adding a new template

To add a new template, chech [templates/CONTRIBUTING.md](./templates/CONTRIBUTING.md).