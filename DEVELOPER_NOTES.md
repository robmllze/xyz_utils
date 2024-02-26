# Developer Notes

## Publishing

1. Make your changes.
1. Run `dart analyze` to check for errors.
1. Run `dart fix --apply` to apply fixes.
1. Run `dart format .` to format the code.
1. Update the version number in `pubspec.yaml`.
1. Update the version number in `CHANGELOG.md`.
1. Run `dart pub publish --dry-run` to check for errors.
1. Run `dart pub publish` to publish the package.

## Deleting .DS_Store files (MacOS)

```bash
cd your/project/path
find . -name '.DS_Store' -type f -delete
```