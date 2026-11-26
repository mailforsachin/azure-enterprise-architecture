# ADR-010: Identity-First Architecture

## Status
Proposed reference architecture

## Context
Application components require authorized resource access.

## Decision
Prefer Entra ID, managed identities and least-privilege RBAC.

## Alternatives Considered
Stored credentials and application-managed secrets.

## Benefits
Reduced long-lived credential exposure.

## Trade-offs and Limitations
Role design and service compatibility require validation.

## Engineering Evidence
Conceptual architecture and storage authentication settings.

## Next Validation Step
Implement identities and scoped role assignments.

## Scope
Independent reference engineering and anonymized commercial architecture.
No customer approval or production deployment is asserted.