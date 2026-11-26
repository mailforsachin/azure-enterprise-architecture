# ADR-006: Environment-Aware Private DNS

## Status
Implemented in reference code

## Context
Private connectivity depends on reliable DNS resolution.

## Decision
Use a private DNS zone and environment-derived storage suffix.

## Alternatives Considered
Hardcoded cloud suffix or custom DNS infrastructure.

## Benefits
Reduced hardcoded cloud dependencies.

## Trade-offs and Limitations
Private DNS alone does not establish private connectivity.

## Engineering Evidence
infrastructure/networking/private-dns-foundation.bicep

## Next Validation Step
Implement private endpoints and validate DNS resolution.

## Scope
Independent reference engineering and anonymized commercial architecture.
No customer approval or production deployment is asserted.