# Astronuts Code Quality Action

This action runs Astronuts code quality scans.

### Inputs

These are some of the supported input parameters of the action.

- `sourceLanguage` - **_(Required)_** the programming language of the source code to be analyzed.
- `rootDir` - The root directory of source code.


## Example usage

```yaml
uses: actions/astronuts-code-quality-action@master
with:
  sourceLanguage: 'java'
```

