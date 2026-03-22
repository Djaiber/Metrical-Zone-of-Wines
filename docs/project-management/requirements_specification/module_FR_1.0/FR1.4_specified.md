# Functional Requirement Specification

---

## Metadata

| Field            | Value                        |
|------------------|------------------------------|
| **ID**           | FR1-04                       |
| **Module**       | Vineyards — Sorting          |
| **Version**      | 1.0                          |
| **Status**       | Draft                        |
| **Date**        | 2026-03-21                   |
| **Author**        | David Ramirez                |
| **Reviewed by** |                              |

---

## Description

**Statement:**
> The web application must allow the user to sort the vineyard listing by multiple criteria simultaneously, with user-defined priority and configurable direction for each criterion, so they can organize the results according to their particular interest.

**Involved Actor:**
Common consumer or expert user who is in the Vineyards section. No authentication is required. The sorting operates on the listing resulting from the active filters defined in `FR1-03`.

---

## Conditions

**Precondition:**
- The user is in the Vineyards section with the listing visible, with or without active filters.
- Vineyards are registered with their calculated metrics available.

**Postcondition:**
The vineyard listing is reorganized according to the applied sorting criteria, respecting the priority and direction defined by the user. Active filters are not affected by the sorting.

---

## Acceptance Criteria

### General sorting behavior
- [ ] **AC1:** Sorting options are visibly available in the Vineyards section, visually differentiated from the filter panel.
- [ ] **AC2:** The user can apply multiple sorting criteria simultaneously, establishing a priority order among them (the first criterion has greater weight, the second acts as tiebreaker, and so on).
- [ ] **AC3:** Each applied sorting criterion shows its active direction: ascending (↑) or descending (↓), and allows inverting it with a single action.
- [ ] **AC4:** The user can remove a sorting criterion independently without affecting the others.
- [ ] **AC5:** The user can clear all sorting criteria with a single action, restoring the default order.
- [ ] **AC6:** The listing updates when applying, modifying, or removing a criterion without reloading the entire page.
- [ ] **AC7:** Sorting operates on the set of vineyards resulting from active filters — it does not modify or remove them.

### Available sorting criteria
- [ ] **AC8:** The user can sort by **average overall rating**, in ascending or descending direction.
- [ ] **AC9:** The user can sort by **average price of their wines**, in ascending or descending direction.
- [ ] **AC10:** The user can sort by **number of wines marketed**, in ascending or descending direction.
- [ ] **AC11:** The user can sort by **number of medals obtained**, in ascending or descending direction.

### Default order
- [ ] **AC12:** When no sorting criteria are active, the listing is presented sorted by descending as default behavior.

---

## Priority

| Level  | Description                                      |
|--------|--------------------------------------------------|
| High   | Essential for MVP, blocks other functions        |
| Medium | Important but does not block the main flow       |
| Low    | Desirable, can be deferred to a future version   |

**Assigned Priority:** Medium — the listing is functional without custom sorting, but this significantly improves the experience with large data volumes.

---

## Dependencies

- Depends on: `FR1-02` — Global navigation bar
- Depends on: `FR1-03` — Vineyard filtering
- Is prerequisite for: `FR2-01` — Vineyard dashboard

---

## Notes and Change History

- Sorting by multiple criteria implies that the presentation layer must manage an ordered list of active criteria with their respective direction. This must be considered when designing the sorting panel interface.
- The default order (descending) must be visually active from when the user arrives at the section, so it is always clear under what criterion the listing is presented.
- The available sorting criteria in this FR are an intentional subset — those of greatest interest to amateurs and experts were prioritized according to the application's review focus. Additional criteria can be incorporated in future versions.

| Date      | Version | Author | Change Description |
|------------|---------|-------|------------------------|
| 2026-03-21 | 1.0     | David Ramirez     | Document creation |