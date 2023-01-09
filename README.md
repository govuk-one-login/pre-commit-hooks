# GOV.UK OneLogin pre-commit hooks

This repo contains common pre-commit hooks used across the GOV.UK OneLogin programme.

## Using the hooks

To use the hooks from this repo, you must add the following to the `.pre-commit-config.yaml` at root of your repo:

```yaml
  - repo: https://github.com/alphagov/di-pre-commit-hooks.git
    rev: <latest tag number>
    hooks:
      # One or more hook IDs
      - id: <hook-id>
```

For example, to use the `terraform-format` and `terraform-validate` hooks:

```yaml
  - repo: https://github.com/alphagov/di-pre-commit-hooks.git
    rev: 0.0.1
    hooks:
      - id: terraform-format
      - id: terraform-validate
```

## Hooks

### Spotless Apply

This is a simple wrapper for running `./gradlew spotlessApply` in a Java repo that has the Spotless plugin enabled.

It is included as a convenience to reduce the amount of repeated "boilerplate" code across multiple repos.

```yaml
  - repo: https://github.com/alphagov/di-pre-commit-hooks.git
    rev: 0.0.1
    hooks:
      - id: gradle-spotless-apply
```

### Terraform Format

This is script that will run `terraform fmt` in any directories containing changes to Terraform files.

The script uses Docker rather than relying on a local installation of Terraform.

To use this script:

```yaml
  - repo: https://github.com/alphagov/di-pre-commit-hooks.git
    rev: 0.0.1
    hooks:
      - id: terraform-format
```

If `terraform-format` modifies any files, the pre-commit hook will fail.

N.B. this hook will run against all files in the directory, not just files changed in the commit.

#### Terraform Version

The hook will attempt to determine the Terraform version to use by looking for `.terraform-version` either in the
directory containing the changed Terraform files or its parent directory (similar to `tfenv`). If a specific version
cannot be determined it will pull the Docker image with the `latest` tag.

### Terraform Validate

This is script that will run `terraform validate` in any directories containing changes to Terraform files.

The script uses Docker rather than relying on a local installation of Terraform.

To use this script:

```yaml
  - repo: https://github.com/alphagov/di-pre-commit-hooks.git
    rev: 0.0.1
    hooks:
      - id: terraform-validate
```

As discussed above the hook will attempt to auto-detect the Terraform version.
