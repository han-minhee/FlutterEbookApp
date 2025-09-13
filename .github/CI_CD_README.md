# CI/CD Pipeline Documentation

This repository includes a comprehensive CI/CD pipeline built with GitHub Actions. The pipeline ensures code quality, security, and automated deployment across multiple platforms.

## Workflows Overview

### 1. **CI Workflow** (`ci.yml`)
- **Triggers**: Push to main/develop branches, Pull Requests
- **Purpose**: Core testing and building
- **Jobs**:
  - **Test**: Runs unit tests, code analysis, and formatting checks
  - **Build Android**: Creates APK and App Bundle
  - **Build Web**: Creates web build
  - **Build Linux**: Creates Linux desktop build
  - **Build Windows**: Creates Windows desktop build
  - **Build macOS**: Creates macOS desktop build

### 2. **Release Workflow** (`release.yml`)
- **Triggers**: Git tags (v*), Manual dispatch
- **Purpose**: Automated release creation and deployment
- **Features**:
  - Creates GitHub releases with changelog
  - Builds and uploads artifacts for all platforms
  - Generates platform-specific installers

### 3. **Security Workflow** (`security.yml`)
- **Triggers**: Push to main/develop, Pull Requests, Weekly schedule
- **Purpose**: Security scanning and vulnerability detection
- **Features**:
  - Dependency vulnerability scanning
  - CodeQL analysis
  - Secret scanning with TruffleHog

### 4. **Code Quality Workflow** (`code-quality.yml`)
- **Triggers**: Push to main/develop, Pull Requests
- **Purpose**: Comprehensive code quality checks
- **Features**:
  - Code formatting verification
  - Static analysis
  - Coverage reporting
  - Unused dependency detection

### 5. **Test Matrix Workflow** (`test-matrix.yml`)
- **Triggers**: Push to main/develop, Pull Requests, Weekly schedule
- **Purpose**: Multi-version testing
- **Features**:
  - Tests across multiple Flutter versions
  - Integration testing
  - Coverage reporting per version

### 6. **Web Deployment Workflow** (`deploy-web.yml`)
- **Triggers**: Push to main branch, Manual dispatch
- **Purpose**: Automated web deployment
- **Features**:
  - Builds web version
  - Deploys to GitHub Pages
  - Configurable base URL

### 7. **Documentation Workflow** (`docs.yml`)
- **Triggers**: Push to main/develop, Pull Requests, Manual dispatch
- **Purpose**: Automated documentation generation
- **Features**:
  - API documentation generation
  - Coverage report generation
  - Test report generation

### 8. **Performance Workflow** (`performance.yml`)
- **Triggers**: Push to main/develop, Pull Requests, Weekly schedule
- **Purpose**: Performance monitoring and optimization
- **Features**:
  - App size analysis
  - Memory leak detection
  - Performance metrics collection

### 9. **Issue Management Workflow** (`issue-management.yml`)
- **Triggers**: Issues and Pull Requests
- **Purpose**: Automated issue and PR management
- **Features**:
  - Automatic labeling
  - PR description validation
  - Breaking change detection

### 10. **Dependency Scan Workflow** (`dependency-scan.yml`)
- **Triggers**: Push to main/develop, Pull Requests, Weekly schedule
- **Purpose**: Dependency security and compliance
- **Features**:
  - Vulnerability scanning
  - License compliance checking
  - Duplicate dependency detection

### 11. **Format Check Workflow** (`format-check.yml`)
- **Triggers**: Push to main/develop, Pull Requests
- **Purpose**: Code formatting enforcement
- **Features**:
  - Flutter format checking
  - Import organization validation
  - Whitespace validation

## Configuration Files

### Dependabot Configuration (`.github/dependabot.yml`)
- Automated dependency updates
- Configurable update schedules
- Custom labels and reviewers
- Ignore patterns for major version updates

### Codecov Configuration (`codecov.yml`)
- Coverage reporting thresholds
- Comment formatting
- Ignore patterns for generated files

### Pre-commit Configuration (`.pre-commit-config.yaml`)
- Local development hooks
- Flutter-specific checks
- Automated formatting and testing

## Getting Started

### 1. **Enable GitHub Actions**
- Go to your repository settings
- Navigate to Actions → General
- Enable GitHub Actions for this repository

### 2. **Configure Secrets**
- Go to Settings → Secrets and variables → Actions
- Add any required secrets for deployment

### 3. **Set up Branch Protection**
- Go to Settings → Branches
- Add rules for main and develop branches
- Require status checks to pass before merging

### 4. **Enable GitHub Pages**
- Go to Settings → Pages
- Select "GitHub Actions" as source
- The web deployment workflow will handle the rest

## Customization

### Adding New Platforms
To add support for new platforms, modify the `ci.yml` workflow:

```yaml
build-new-platform:
  name: Build New Platform
  runs-on: ubuntu-latest
  needs: test
  
  steps:
  - name: Checkout repository
    uses: actions/checkout@v4
  # Add platform-specific build steps
```

### Modifying Test Matrix
To change Flutter versions tested, update the `test-matrix.yml` workflow:

```yaml
strategy:
  matrix:
    flutter-version: ['3.22.0', '3.24.0', '3.25.0']
```

### Adding New Quality Checks
To add new quality checks, modify the `code-quality.yml` workflow:

```yaml
- name: New Quality Check
  run: |
    echo "Running new quality check..."
    # Add your custom checks here
```

## Monitoring and Maintenance

### 1. **Workflow Status**
- Monitor workflow runs in the Actions tab
- Set up notifications for failed workflows
- Review logs for debugging

### 2. **Dependency Updates**
- Dependabot will create PRs for updates
- Review and merge updates regularly
- Monitor for breaking changes

### 3. **Security Alerts**
- Review security scan results
- Address vulnerabilities promptly
- Update dependencies as needed

### 4. **Performance Monitoring**
- Review performance reports
- Monitor app size trends
- Optimize based on metrics

## Troubleshooting

### Common Issues

1. **Flutter Version Mismatch**
   - Ensure Flutter version in workflows matches your local version
   - Update workflows when upgrading Flutter

2. **Dependency Issues**
   - Check for conflicting dependencies
   - Update pubspec.yaml files
   - Run `flutter pub get` locally

3. **Build Failures**
   - Check platform-specific requirements
   - Review build logs for errors
   - Test builds locally

4. **Test Failures**
   - Run tests locally with `flutter test`
   - Check for flaky tests
   - Update test expectations

### Getting Help

- Check GitHub Actions documentation
- Review Flutter CI/CD best practices
- Open issues for workflow problems
- Consult the Flutter community

## Best Practices

1. **Keep Workflows Fast**
   - Use caching where possible
   - Parallelize independent jobs
   - Remove unnecessary steps

2. **Maintain Security**
   - Use minimal permissions
   - Rotate secrets regularly
   - Review third-party actions

3. **Monitor Performance**
   - Track workflow execution times
   - Optimize slow steps
   - Use appropriate runners

4. **Document Changes**
   - Update this README when modifying workflows
   - Document new features and requirements
   - Keep configuration files organized

## Contributing

When contributing to the CI/CD pipeline:

1. Test changes in a fork first
2. Follow the existing patterns and conventions
3. Update documentation as needed
4. Submit PRs with clear descriptions
5. Ensure all workflows pass before merging

---

For questions or issues with the CI/CD pipeline, please open an issue in the repository.