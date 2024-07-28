# Astronuts Code Quality Action

This action runs Astronuts code quality scans.

### Inputs

These are some of the supported input parameters of the action.
- `rootDir` - _(Optional)_ the root directory of the repository on the file system. If unspecified, its auto-detected.
- `failOnError` - _(Optional)_ If set to true, the build will fail if the code quality analysis fails. Build will pass silently otherwise.
- `language` - _(Optional)_ The language of the source code. If unspecified, its auto-detected.
- `build-system` - _(Optional)_ The build tool used to build the project. If unspecified, its auto-detected.
- `test-reports-root` - _(Optional)_ The root directory of the test reports. If unspecified, its auto-detected.
- `coverage-lib` - _(Optional)_ The coverage library used to generate coverage reports. If unspecified, its auto-detected.
- `coverage-report-paths` - _(Optional)_ comma seperated list of coverage report paths relative to root directory. 
                            If unspecified, its auto-detected based on coverage library used.

### Supported Languages
- `java`
- `typescript`
- `javascript`
- `python`

### Supported Build Tools
- `gradle`
- `maven`
- `npm`
- `pip`

### Supported Coverage Libraries for Java
- `jacoco`
- `cobertura`

Note* - we only support coverage and test reports in xml format only.

## Example usage

```yaml
uses: actions/astronuts-code-quality-action@v5
```

