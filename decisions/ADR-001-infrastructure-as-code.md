# ADR-001: Infrastructure as Code

## Status
Implemented in reference code

## Context
Infrastructure changes require repeatability and review.

## Decision
Use parameterized Azure Bicep templates under version control.

## Alternatives Considered
Manual provisioning, Terraform or direct ARM JSON.

## Benefits
Repeatable infrastructure and native Azure integration.

## Trade-offs and Limitations
Azure-specific tooling and resource API maintenance.

## Engineering Evidence
Seven Bicep templates and three parameter files.

## Next Validation Step
Validate deployments in an authorized sandbox.

## Scope
Independent reference engineering and anonymized commercial architecture.
No customer approval or production deployment is asserted.