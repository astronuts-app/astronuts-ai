# Astronuts Code Quality Action

This action runs Astronuts code quality scans.

### Inputs

These are some of the supported input parameters of the action.
- `rootDir` - _(Optional)_ The root directory of source code. If unspecified, its auto-detected.
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



## Example usage

```yaml
uses: actions/astronuts-code-quality-action@v5
```

