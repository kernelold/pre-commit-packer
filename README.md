# pre-commit-packer
Pre-commit hooks for the packer

## packer-fmt
Runs `packer fmt` with given args

Examples:

```
repos:
```

1. Runs `packer fmt` to fix the formatting and show `-diff` 

```
  - repo: https://github.com/kernelold/pre-commit-packer.git
    rev: main
    hooks:
      - id: packer-fmt
        args:
          - "-diff"

```
2. Runs `packer fmt` to fix the formatting (silent mode)

```
  - repo: https://github.com/kernelold/pre-commit-packer.git
    rev: main
    hooks:
      - id: packer-fmt

```

3. Runs `packer fmt` with `-check` option and show `-diff` (read-only)

```
  - repo: https://github.com/kernelold/pre-commit-packer.git
    rev: main
    hooks:
      - id: packer-fmt
        args:
          - "-diff"
          - "-check"

```

## packer-validate
Runs `packer validate` with given args

Examples:

1. Validate packerfiles with given vars:

```
    hooks:
      - id: packer-validate
        args: [ '-var', 'gitCommit=000', '-var', "awsAccount=0000000", '-var', 'securityGroupIds=["sg-000"]' ]

```
