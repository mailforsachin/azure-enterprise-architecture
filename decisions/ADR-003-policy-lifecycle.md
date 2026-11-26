# ADR-003: Separate Policy Definition and Assignment

## Status
Implemented in reference code

## Context
Policy authoring and activation require separate approvals.

## Decision
Maintain separate definition and assignment templates.

## Alternatives Considered
Combined deployment and immediate activation.

## Benefits
Reusable definitions and controlled activation.

## Trade-offs and Limitations
Additional deployment sequencing and dependency management.

## Engineering Evidence
infrastructure/governance/policy-definition.bicep and policy-assignment.bicep

## Next Validation Step
Establish assignment ownership and exemption governance.

## Scope
Independent reference engineering and anonymized commercial architecture.
No customer approval or production deployment is asserted.