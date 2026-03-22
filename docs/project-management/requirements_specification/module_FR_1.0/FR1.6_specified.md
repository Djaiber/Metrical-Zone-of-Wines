# Functional Requirement Specification

---

## Metadata

| Field            | Value                        |
|------------------|------------------------------|
| **ID**           | FR1-06                       |
| **Module**       | Wines — Sorting              |
| **Version**      | 1.0                          |
| **Status**       | Draft                        |
| **Date**        | 2026-03-21                   |
| **Author**        | David Ramirez                |
| **Reviewed by** |                              |

---

## Description

**Statement:**
> The web application must allow the user to sort the wine listing by multiple criteria simultaneously, with user-defined priority and configurable direction for each criterion.

**Involved Actor:**
Common consumer or expert user who is in the Wines section. No authentication is required. The sorting operates on the listing resulting from the active filters defined in `FR1-05`.

---

## Conditions

**Precondition:**
- The user is in the Wines section with the listing visible, with or without active filters.
- Wines are registered with their calculated metrics available.

**Postcondition:**
The wine listing is reorganized according to the applied sorting criteria, respecting the priority and direction defined by the user. Active filters are not affected by the sorting.

---

## Acceptance Criteria

### General sorting behavior
- [ ] **AC1:** Sorting options are visibly available in the Wines section, visually differentiated from the filter panel.
- [ ] **AC2:** The user can apply multiple sorting criteria simultaneously, establishing a priority order among them (the first criterion has greater weight, the following act as tiebreakers).
- [ ] **AC3:** Each applied sorting criterion shows its active direction: ascending (↑) or descending (↓), and allows inverting it with a single action.
- [ ] **AC4:** The user can remove a sorting criterion independently without affecting the others.
- [ ] **AC5:** The user can clear all sorting criteria with a single action, restoring the default order.
- [ ] **AC6:** The listing updates when applying, modifying, or removing a criterion without reloading the entire page.
- [ ] **AC7:** Sorting operates on the set of wines resulting from active filters — it does not modify or remove them.

### Available sorting criteria
- [ ] **AC8:** The user can sort by **average overall rating**, ascending or descending.
- [ ] **AC9:** The user can sort by **average expert rating**, ascending or descending.
- [ ] **AC10:** The user can sort by **average price**, ascending or descending.
- [ ] **AC11:** The user can sort by **number of reviews received**, ascending or descending.
- [ ] **AC12:** The user can sort by **number of medals obtained**, ascending or descending.
- [ ] **AC13:** The user can sort by **vintage year**, from most recent to oldest or vice versa.
- [ ] **AC14:** The user can sort by **production volume**, ascending or descending — useful for identifying limited edition wines.
- [ ] **AC15:** The user can sort by **aging time**, ascending or descending.

### Default order
- [ ] **AC16:** When no sorting criteria are active, the listing is presented sorted by descending as default behavior.

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
- Depends on: `FR1-05` — Wine filtering
- Is prerequisite for: `FR3-01` — Wine dashboard

---

## Notes and Change History

- The category of bottles produced allows expert users to identify limited edition wines (low production) versus mass-produced wines, relevant data for collectors and sommeliers.
- The default order (descending) must be visually active from when the user arrives at the section.
- Criteria AC8 and AC9 allow comparing general perception versus expert perception when sorting — useful combination for users who want to identify wines overvalued or underestimated by the general public.

| Date      | Version | Author | Change Description |
|------------|---------|-------|------------------------|
| 2026-03-21 | 1.0     | David Ramirez      | Document creation |