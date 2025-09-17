# create

Generate code and content with intelligent templating and pattern learning.

## Syntax

```bash
/prefix:create [type] [target] [options]
```

## Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `type` | `docs` | Generation type: docs, tests, component, api, config, template, mock, schema |
| `target` | `.` | Target location for generated content |

## Options

| Option | Description |
|--------|-------------|
| `--format=type` | Output format (json, yaml, markdown, html, etc.) |
| `--prp` | Activate Project Requirements Proposal methodology |
| `--prp=template` | Create from existing template patterns |
| `--prp=validation` | Validate blueprint against codebase patterns |
| `--prp=fast` | Quick blueprint generation for simple features |
| `--from-analysis` | Use insights from previous understand analysis |
| `--template=name` | Use specific template for generation |
| `--help` | Show detailed help information |

## Examples

```bash
# Generate API documentation
/prefix:create docs --format=api

# Create React component
/prefix:create component UserProfile

# Generate tests from analysis
/prefix:create tests --from-analysis

# Create configuration files
/prefix:create config database --format=yaml

# PRP blueprint creation
/prefix:create . --prp --from-analysis

# Generate mock data
/prefix:create mock users --format=json

# Create schema from template
/prefix:create schema --template=rest-api
```

## Generation Types

| Type | Description | Common Formats |
|------|-------------|----------------|
| `docs` | Documentation generation | markdown, html, api |
| `tests` | Test file creation | spec, test, unit |
| `component` | UI/code components | react, vue, angular |
| `api` | API definitions | openapi, swagger, json |
| `config` | Configuration files | yaml, json, toml |
| `template` | Template creation | mustache, jinja2 |
| `mock` | Mock data generation | json, yaml, csv |
| `schema` | Schema definitions | json-schema, graphql |

## PRP Integration

The `--prp` flag activates blueprint-driven creation:

- **Full Blueprint**: `--prp` alone generates comprehensive implementation
- **Template-Based**: `--prp=template` creates from existing patterns
- **Validation**: `--prp=validation` validates against codebase patterns
- **Fast Track**: `--prp=fast` for simple feature generation

## Workflows

**Component Creation Workflow**:

```bash
/prefix:understand components/ --quick   # Analyze existing patterns
/prefix:create component Button --prp    # Generate with blueprint
/prefix:improve component --style        # Apply style improvements
```

**API Development Workflow**:

```bash
/prefix:create api users --format=openapi
/prefix:create tests api/users --from-analysis
/prefix:secure api/ --baseline
```

## See Also

- [`understand`](understand.md) - Analyze before generation for better context
- [`improve`](improve.md) - Enhance generated code quality
- [`secure`](secure.md) - Security review of generated code
- [`ship`](ship.md) - Validate generated code before deployment
