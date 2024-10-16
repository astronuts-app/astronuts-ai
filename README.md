# Astronuts AI Code Quality Action

This action runs Astronuts code quality scans on your repository. The action integrates static code analysis, PR review, and walkthrough capabilities, using configurable settings defined in an `astronuts.yml` file.

### Inputs

These are the supported input parameters of the action:

- `token` - The GitHub token (required).
- `timeout` - _(Optional)_ The timeout for the code quality scan in milliseconds.
- `prReview` - _(Optional)_ Whether to enable PR review functionality.
- `prWalkthrough` - _(Optional)_ Whether to enable PR walkthrough functionality.
- `staticAnalysis` - _(Optional)_ Whether to enable static code analysis.

### Configuration Through `astronuts.yml`

All project-specific configurations such as directories, language, build system, and report paths should be provided via an `astronuts.yml` file. This file should be placed in the root of your repository, and it will be automatically detected during the action run.

Here are the configuration options that should be specified in the `astronuts.yml` file:

- `source-language` - The programming language used in the source code (e.g., java, typescript, etc.).
- `root-dir` - The root directory of your source code.
- `build-system` - The build tool used for your project (e.g., gradle, maven, npm).
- `fail-on-error` - Whether to fail the action if any error occurs during the analysis.
- `test-report-roots` - A comma-separated list of paths to root directories where your test reports are stored.
- `coverage-lib` - The code coverage library used in your project (e.g., jacoco, cobertura).
- `coverage-report-paths` - A comma-separated list of paths to your code coverage report files.

### Example of `astronuts.yml` Configuration

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
  metrics:
    - bugs
    - code_smells
    - coverage
    - complexity

  source-language: java                 # Set the source language (e.g., java, typescript, etc.)
  root-dir: "./src"                     # Root directory for the source code
  build-system: gradle                  # Build tool used for the project (e.g., gradle, maven, npm)
  fail-on-error: true                   # If true, the action will fail if any error occurs
  test-report-root: "./build/test-results/test" # Path to test report directories
  coverage-lib: "jacoco"                # Code coverage library used (e.g., jacoco, cobertura)
  coverage-report-paths: "build/reports/jacoco/test/jacocoTestReport.xml"  # Comma-separated list of coverage report paths
```

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

### Example Usage in GitHub Actions

Here is how to configure the GitHub Action to run Astronuts AI code quality checks:

```yaml
 - name: Run Astronuts Code Quality Checks
   uses: astronuts-app/astronuts-ai@v2.3.0
   with:
     token: ${{ secrets.GITHUB_TOKEN }}
     timeout: 29000
     prReview: true
     prWalkthrough: true
     staticAnalysis: true
