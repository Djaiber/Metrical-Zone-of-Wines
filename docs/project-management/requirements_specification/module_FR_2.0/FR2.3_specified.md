# Functional Requirement Specification

---

## Metadata

| Field            | Value                          |
|------------------|--------------------------------|
| **ID**           | FR2-03                         |
| **Module**       | Vineyard Page — Reviews        |
| **Version**      | 1.0                            |
| **Status**       | Draft                          |
| **Date**        | 2026-03-21                     |
| **Author**        |  David Ramirez                              |
| **Reviewed by** |                                |

---

## Description

**Statement:**
> The vineyard page must display the reviews made to the vineyard as an entity, allowing the user to browse and filter them by reviewer type, similarly to the main reviews section but restricted to the current vineyard.

**Involved Actor:**
Common consumer or expert user who is on a vineyard's page. No authentication is required.

---

## Conditions

**Precondition:**
- The user is on a vineyard's page.
- Reviews of the vineyard are stored.

**Postcondition:**
The user views the vineyard's reviews filtered according to the selected criteria. Read-only operation — no data is modified.

---

## Acceptance Criteria

### Review listing
- [ ] **AC1:** The list of reviews made to the vineyard as an entity is displayed — it does not include reviews of its wines.
- [ ] **AC2:** Each amateur review shows: reviewer name, global rating (scale 0–100), visit date, experience description and recommendation indicator.
- [ ] **AC3:** Each expert or organization review shows: reviewer name, occupation, organization, years of experience, global rating (scale 0–100), visit date, tasting notes and pairing suggestions.
- [ ] **AC4:** The listing is presented sorted by date descending by default (most recent first).

### Review filtering
- [ ] **AC5:** The user can filter reviews by reviewer type: amateur, expert or organization.
- [ ] **AC6:** The user can filter reviews by rating range, selecting a predefined option ordered from highest to lowest.
- [ ] **AC7:** The user can apply multiple filters simultaneously.
- [ ] **AC8:** The user can clear all filters with a single action, restoring the full listing.

### General behavior
- [ ] **AC9:** If the vineyard has no registered reviews, an indicative message and invitation to create the first review are displayed.
- [ ] **AC10:** The listing updates when applying or removing filters without reloading the entire page.

---

## Priority

| Level  | Description                                      |
|--------|--------------------------------------------------|
| High   | Essential for MVP, blocks other functions        |
| Medium | Important but does not block the main flow       |
| Low    | Desirable, can be deferred to a future version   |

**Assigned Priority:** High — reviews are the core value of the application.

---
## Dependencies

- Depends on: `FR2-01` — Vineyard dashboard
- Is prerequisite for: `FR2-04` — Create vineyard review

---

## Notes and Change History

- The vineyard reviews and the reviews of its wines are separate entities in MongoDB. This FR covers exclusively the reviews whose subject is the vineyard, not a specific wine.
- The backend is responsible for querying MongoDB filtering according to the active filters.

| Date      | Version | Author | Change Description |
|------------|---------|-------|------------------------|
| 2026-03-21 | 1.0     | David Ramirez       | Document creation |