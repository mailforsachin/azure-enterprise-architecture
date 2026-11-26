# ADR-002: Audit-First Governance

## Status
Implemented in reference code

## Context
Immediate enforcement may disrupt existing workloads.

## Decision
Introduce Azure Policy audit controls before enforcement.

## Alternatives Considered
Immediate deny policies or manual compliance checks.

## Benefits
Compliance visibility with reduced operational disruption.

## Trade-offs and Limitations
Audit controls do not prevent noncompliant deployments.

## Engineering Evidence
infrastructure/governance/regional-audit.bicep

## Next Validation Step
Review findings and approve enforcement separately.

## Scope
Independent reference engineering and anonymized commercial architecture.
No customer approval or production deployment is asserted.