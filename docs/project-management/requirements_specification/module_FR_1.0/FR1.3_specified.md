# Functional Requirement Specification

---

## Metadata

| Field            | Value                        |
|------------------|------------------------------|
| **ID**           | FR1-03                       |
| **Module**       | Vineyards — Filtering        |
| **Version**      | 1.0                          |
| **Status**       | Draft                        |
| **Date**        | 2026-03-21                   |
| **Author**        | David Ramirez                |
| **Reviewed by** |                              |

---

## Description

**Statement:**
> The web application must allow the user to filter the vineyard listing according to location, production and review performance categories, so they can find vineyards of interest without browsing the full list.

**Involved Actor:**
Common consumer or expert user who accesses the Vineyards section from the navigation bar. No authentication is required.

---

## Conditions

**Precondition:**
- The user is in the Vineyards section.
- Vineyards are registered in the system with their production data and calculated metrics available.

**Postcondition:**
The vineyard listing updates showing only those that meet the applied filters. If no vineyard meets the criteria, an indicative message is displayed. Filters can be removed to restore the full listing.

---

## Acceptance Criteria

### General filter system behavior
- [ ] **AC1:** Filters are visibly available in the Vineyards section.
- [ ] **AC2:** It is possible to apply multiple filters simultaneously — the listing reflects the intersection of all active filters.
- [ ] **AC3:** The user can clear all active filters with a single action, restoring the full listing.
- [ ] **AC4:** Each active filter is visible as an individual indicator that can be removed independently.
- [ ] **AC5:** The listing updates when applying or removing a filter without reloading the entire page.
- [ ] **AC6:** If no vineyard matches the applied filters, an indicative message is displayed instead of an empty list without context.

### Filters by location
- [ ] **AC7:** The user can filter vineyards by **country**, selecting one or more countries from the available list.
- [ ] **AC8:** The user can filter vineyards by **region**, selecting one or more regions. The list of available regions is narrowed to the selected country if this filter is active.

### Filters by production
- [ ] **AC9:** The user can filter by **predominant wine type** of the vineyard: red, white, rosé or sparkling.
- [ ] **AC10:** The user can filter by **dominant grape**, selecting one or more varieties from the available list.
- [ ] **AC11:** The user can filter by **price range** of the vineyard's wines: `budget`, `mid`, `premium` or `luxury`.
- [ ] **AC12:** The user can filter by **number of wines marketed**, selecting a predefined option ordered from highest to lowest.

### Filters by review performance
- [ ] **AC13:** The user can filter by **average overall rating**, selecting a predefined option ordered from highest to lowest.
- [ ] **AC14:** The user can filter by **average expert rating**, selecting a predefined option ordered from highest to lowest.
- [ ] **AC15:** The user can filter by **average consumer rating**, selecting a predefined option ordered from highest to lowest.
- [ ] **AC16:** The user can filter by **number of reviews received**, selecting a predefined option ordered from highest to lowest.
- [ ] **AC17:** The user can filter vineyards that have **at least one medal** registered in any of their wines.

---

## Priority

| Level  | Description                                      |
|--------|--------------------------------------------------|
| High   | Essential for MVP, blocks other functions        |
| Medium | Important but does not block the main flow       |
| Low    | Desirable, can be deferred to a future version   |

**Assigned Priority:** Medium — the vineyard listing is functional without filters, but these are essential for usability with large data volumes.

---

## Dependencies

- Depends on: `FR1-02` — Global navigation bar
- Is prerequisite for: `FR1-04` — Vineyard sorting
- Is prerequisite for: `FR2-01` — Vineyard dashboard

---

## Notes and Change History

- The region filter (AC8) depends on the country filter to narrow its options. If no country is selected, all available regions are shown.
- The price ranges (`budget`, `mid`, `premium`, `luxury`) share the same scale defined in the system configuration FR, also referenced in `FR1-01`.
- The sorting of the resulting listing is specified in `FR1-04` as an independent FR.

| Date      | Version | Author | Change Description |
|------------|---------|-------|------------------------|
| 2026-03-21 | 1.0     | David Ramirez | Document creation |