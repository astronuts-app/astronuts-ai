# Astronuts Code Quality Action

This action runs Astronuts code quality scans.

### Inputs

These are some of the supported input parameters of action.

- `projectKey` - **_(Required)_** the unique key of the project.
- `authToken` - **_(Required)_** the Astronuts authentication token for your organization.
- `sourceLanguage` - **_(Required)_** the programming language of teh source code to be analyzed.
- `rootDir` - The root directory of source code.


## Example usage

```yaml
uses: actions/astronuts-code-quality-action@v0.0.7-alpha
with:
  projectKey: 'my-custom-project'
  authToken: ${{ secrets.ASTRONUTS_AUTH_TOKEN }}
  sourceLanguage: 'java'
  rootDir: 'my-root-dir'
  
```



