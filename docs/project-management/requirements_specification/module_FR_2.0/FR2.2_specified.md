# Functional Requirement Specification

---

## Metadata

| Field            | Value                          |
|------------------|--------------------------------|
| **ID**           | FR2-02                         |
| **Module**       | Vineyard Page — Wines          |
| **Version**      | 1.0                            |
| **Status**       | Draft                          |
| **Date**        | 2026-03-21                     |
| **Author**        | David Ramirez                  |
| **Reviewed by** |                                |

---

## Description

**Statement:**
> The vineyard page must display the list of wines it markets, allowing the user to explore the vineyard's products without leaving its dashboard.

**Involved Actor:**
Common consumer or expert user who is on a vineyard's page. No authentication is required.

---

## Conditions

**Precondition:**
- The user is on a vineyard's page.
- The vineyard has at least one wine registered in the system.

**Postcondition:**
The user views the list of wines from the vineyard. Read-only operation — no data is modified.

---

## Acceptance Criteria

### Wine listing
- [ ] **AC1:** The list of all wines marketed by the vineyard is displayed.
- [ ] **AC2:** Each wine in the listing shows at minimum: name, wine type, vintage year, average price and average overall rating.
- [ ] **AC3:** The listing is restricted exclusively to the wines of the current vineyard — wines from other vineyards are not shown.
- [ ] **AC4:** Each wine in the listing is a link that takes the user to that wine's dashboard (`FR3-01`).

### Filtering and sorting
- [ ] **AC5:** The user can filter the wines in the listing by wine type, grape variety, vintage year and price range, following the same categories defined in `FR1-05` but applied only to the wines of the vineyard.
- [ ] **AC6:** The user can sort the listing by average rating, price and vintage year, following the same criteria defined in `FR1-06` but applied only to the wines of the vineyard.

### General behavior
- [ ] **AC7:** If the vineyard has no registered wines, an indicative message is displayed instead of an empty list without context.

---

## Priority

| Level  | Description                                      |
|--------|--------------------------------------------------|
| High   | Essential for MVP, blocks other functions        |
| Medium | Important but does not block the main flow       |
| Low    | Desirable, can be deferred to a future version   |

**Assigned Priority:** High — it is the main functionality of the vineyard page and prerequisite to access each wine's dashboard.

---

## Dependencies

- Depends on: `FR2-01` — Vineyard dashboard
- Depends on: `FR1-05` — Wine filtering *(category reference)*
- Depends on: `FR1-06` — Wine sorting *(criteria reference)*
- Is prerequisite for: `FR3-01` — Wine dashboard

---

## Notes and Change History

- The filters and sorting of AC5 and AC6 are a subset of those defined in `FR1-05` and `FR1-06` — the same logic is reused but applied to the vineyard context. It is not necessary to redefine the categories, only restrict their scope.
- A wine belongs exclusively to one vineyard — there are no wines shared between vineyards. This restriction is guaranteed by the data model.

| Date      | Version | Author | Change Description |
|------------|---------|-------|------------------------|
| 2026-03-21 | 1.0     | David Ramirez      | Document creation |