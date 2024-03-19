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

## macOS and Linux

### Fetching Generators
```bash
rm -rf ___generators/
git clone https://github.com/robmllze/___generators.git
dart pub get -C ___generators
rm -rf ___generators/.git
```

### Adding the Workflow
```bash
rm -rf .github/
git clone https://github.com/robmllze/pub.dev_package_workflow.git .github
rm -rf .github/.git
```

### Deleting .DS_Store files
```bash
cd your/project/path
find . -name '.DS_Store' -type f -delete
```

## Windows

### Fetching Generators
```bash
rmdir /s /q ___generators/
git clone https://github.com/robmllze/___generators.git
dart pub get -C ___generators
rmdir /s /q ___generators/.git
```

### Adding the Workflow
```bash
rmdir /s /q .github/
git clone https://github.com/robmllze/pub.dev_package_workflow.git .github
rmdir /s /q .github/.git
```