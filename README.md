# Astronuts Code Quality Action

This action runs Astronuts code quality scans.

### Inputs

These are some of the supported input parameters of the action.

- `sourceLanguage` - **_(Required)_** the programming language of the source code to be analyzed.
- `rootDir` - _(Optional)_ The root directory of source code. If unspecified, its auto-detected.
- `buildSystem` - _(Optional)_ The build system. If not specified, the action tries to auto-detect one. For a list of supported build systems, see documentation.
- `failOnError` - _(Optional)_ If set to true, the build will fail if the code quality analysis fails. Build will pass silently otherwise.

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

Note: If the build system is not specified, the action will attempt to auto-detect it. Currently, only one build system 
per repository is supported. If your repository utilizes multiple build systems or tools, it is recommended to explicitly 
specify the build system for which you wish to run the Astronuts code quality action to ensure accurate analysis.

## Example usage

```yaml
uses: actions/astronuts-code-quality-action@v4
with:
  sourceLanguage: 'java'
  buildSystem: 'gradle'
```

