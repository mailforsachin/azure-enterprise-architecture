# ADR-004: Environment-Specific Governance Baselines

## Status
Implemented in reference code

## Context
Production and nonproduction have different requirements.

## Decision
Group custom policies into baseline and nonproduction initiatives.

## Alternatives Considered
One universal initiative or individual policies.

## Benefits
Consistent, reusable governance controls.

## Trade-offs and Limitations
Initiative lifecycle and exception management.

## Engineering Evidence
infrastructure/governance/initiatives/customer-baselines.bicep

## Next Validation Step
Review initiative applicability before assignment.

## Scope
Independent reference engineering and anonymized commercial architecture.
No customer approval or production deployment is asserted.