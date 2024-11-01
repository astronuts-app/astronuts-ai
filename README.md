# Astronuts AI Code Quality Action


This action performs comprehensive code quality scans on your repository, integrating static analysis, PR review, 
and interactive walkthrough features.

### GitHub Actions Configuration Example

Get started instantly by adding this configuration to your GitHub Actions workflow file; no additional setup required:

```yaml
permissions:
  contents: read
  pull-requests: write

jobs:
  Build:
    runs-on: ubuntu-latest
    steps:
      - name: Run Astronuts Code Quality Checks
        uses: astronuts-app/astronuts-ai@v3.0
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          prReview: true
          prWalkthrough: true
          staticAnalysis: true
```          
> **Note:** To enable all features for your pull requests, make sure to include this trigger in your workflow:
```yaml
on:
  pull_request:
    branches:
      - main

```

### Inputs
These are the supported input parameters of the action:
- `token` - The GitHub token (required).
- `prReview` - _(Optional)_ Whether to enable PR review functionality.
- `prWalkthrough` - _(Optional)_ Whether to enable PR walkthrough functionality.
- `staticAnalysis` - _(Optional)_ Whether to enable static code analysis.

### Required Workflow Permissions

Add these permissions to your workflow file before executing the action (required):

```yaml
permissions:
  contents: read
  pull-requests: write
  ```

### Configuration Through `astronuts.yaml`

All project-specific configurations such as directories, language, build system, and report paths should be provided via an `astronuts.yml` file. This file should be placed in the root of your repository, and it will be automatically detected during the action run.
Keep this file in root directory of  your project.
Here are the configuration options that should be specified in the `astronuts.yaml` file:

- `source-language` - The programming language used in the source code (e.g., java, typescript, etc.).
- `root-dir` - The root directory of your source code.
- `build-system` - The build tool used for your project (e.g., gradle, maven, npm).
- `fail-on-error` - Whether to fail the action if any error occurs during the analysis.
- `test-report-roots` - A comma-separated list of paths to root directories where your test reports are stored.
- `coverage-lib` - The code coverage library used in your project (e.g., jacoco, cobertura).
- `coverage-report-paths` - A comma-separated list of paths to your code coverage report files.

### Example of `astronuts.yaml` Configuration

```yaml
pr-analysis:
  walkthrough-enabled: true
  review-enabled: true
  ignore-low-priority-bugs: true
  suggest-auto-fix: true
  auto-update-title: true
  auto-update-description: true
  max-num-code-suggestions: 20
  max-files-for-auto-trigger: 500
  remove-outdated-comments: true

static-analysis:
  source-language: java
  root-dir: "./src"
  build-system: gradle
  fail-on-error: true
  test-report-root: "./build/test-results/test" 
  coverage-lib: "jacoco"
  coverage-report-paths: "build/reports/jacoco/test" 
```
> **Note**: The `astronuts.yaml` file and its configurations are optional. If not provided, default settings will be used for the code quality analysis. However, you can include the `pr-analysis` and `static-analysis` blocks if you wish to customize PR analysis or static code analysis settings.

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

> **Note**: We only support coverage and test reports in XML format.
