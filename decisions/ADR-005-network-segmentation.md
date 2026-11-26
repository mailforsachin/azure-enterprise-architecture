# ADR-005: Network Segmentation

## Status
Implemented in reference code

## Context
Application integration and private endpoints have different network requirements.

## Decision
Separate application integration and private endpoint subnets.

## Alternatives Considered
Shared subnet or isolated virtual networks.

## Benefits
Clearer network boundaries and service delegation.

## Trade-offs and Limitations
Address planning, routing and security rule complexity.

## Engineering Evidence
infrastructure/networking/regional-foundation/main.bicep

## Next Validation Step
Implement custom NSG rules and validate connectivity.

## Scope
Independent reference engineering and anonymized commercial architecture.
No customer approval or production deployment is asserted.