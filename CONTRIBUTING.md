# Contributing

Thank you for your interest in this project!

We use *GitHub Issues* for trackings issues and features. You can make a contribution by:

1. Reporting an issue or making a feature request [here](https://github.com/barundel/terraform-aws-organizations/issues).
2. Contributing code to this project by fixing an issue or adding a new feature (see below).

Before contributing a new feature, please discuss its suitability with the project maintainers in an issue first. Thanks!

## Contribution Process

1. Fork and *git clone* [the-reop](https://github.com/barundel/terraform-aws-organizations).
2. Create a new *git branch* from the master branch where you develop your changes.
3. Create a [Pull Request](https://help.github.com/articles/about-pull-requests/) for your contribution by following the instructions in the pull request template.
4. Perform a code review with the project maintainers on the pull request. We may suggest changes, improvements or alternatives.
5. Once approved, your code will be merged into `master` and your name will be included in `AUTHORS`.

### Requirements

Pull requests have to meet the following requirements:

2. **Documentation**: Pull requests need to update the [documentation](https://github.com/barundel/terraform-aws-organizations/tree/master/README.md) together with the code change.

3. **Commits**: Commits should be as small as possible while ensuring that each commit compiles and passes tests independently. [Write good commit messages](https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html). If needed, [squash your commits](https://davidwalsh.name/squash-commits-git) prior to submission.

### Commit Message 

This repo uses semantic release when a pull request is merged. You will need to include a prefix 

Here is an example of the release type that will be done based on a commit messages:

| Commit message                                                                                                                                                                                   | Release type               |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------|
| `fix(pencil): stop graphite breaking when too much pressure applied`                                                                                                                             | Patch Release              |
| `feat(pencil): add 'graphiteWidth' option`                                                                                                                                                       | ~~Minor~~ Feature Release  |
| `perf(pencil): remove graphiteWidth option`<br><br>`BREAKING CHANGE: The graphiteWidth option has been removed.`<br>`The default graphite width of 10mm is always used for performance reasons.` | ~~Major~~ Breaking Release |