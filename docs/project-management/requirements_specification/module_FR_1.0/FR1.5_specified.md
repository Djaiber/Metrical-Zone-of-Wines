# Functional Requirement Specification

---

## Metadata

| Field            | Value                        |
|------------------|------------------------------|
| **ID**           | FR1-05                       |
| **Module**       | Wines — Filtering            |
| **Version**      | 1.0                          |
| **Status**       | Draft                        |
| **Date**        | 2026-03-21                   |
| **Author**        | David Ramirez                |
| **Reviewed by** |                              |

---

## Description

**Statement:**
> The web application must allow the user to filter the wine listing according to origin, wine characteristics, price and review performance categories, so they can find wines of interest without browsing the full list.

**Involved Actor:**
Common consumer or expert user who accesses the Wines section from the navigation bar. No authentication is required.

---

## Conditions

**Precondition:**
- The user is in the Wines section.
- Wines are registered in the system with their data and calculated metrics available.

**Postcondition:**
The wine listing updates showing only those that meet the applied filters. If no wine meets the criteria, an indicative message is displayed. Filters can be removed to restore the full listing.

---

## Acceptance Criteria

### General filter system behavior
- [ ] **AC1:** Filters are visibly available in the Wines section.
- [ ] **AC2:** It is possible to apply multiple filters simultaneously — the listing reflects the intersection of all active filters.
- [ ] **AC3:** The user can clear all active filters with a single action, restoring the full listing.
- [ ] **AC4:** Each active filter is visible as an individual indicator that can be removed independently.
- [ ] **AC5:** The listing updates when applying or removing a filter without reloading the entire page.
- [ ] **AC6:** If no wine matches the applied filters, an indicative message is displayed instead of an empty list without context.

### Filters by origin
- [ ] **AC7:** The user can filter wines by **country**, selecting one or more countries from the available list.
- [ ] **AC8:** The user can filter wines by **region**, selecting one or more regions. The list of available regions is narrowed to the selected country if this filter is active.

> **Note:** Filtering by vineyard is not available in this section. To explore the wines of a specific vineyard, the user must access that vineyard's dashboard.

### Filters by wine characteristics
- [ ] **AC9:** The user can filter by **wine type**: red, white, rosé or sparkling.
- [ ] **AC10:** The user can filter by **grape variety**, selecting one or more varieties from the available list.
- [ ] **AC11:** The user can filter by **vintage year**, selecting a predefined option ordered from most recent to oldest.
- [ ] **AC12:** The user can filter by **aging time**, selecting a predefined option ordered from highest to lowest.
- [ ] **AC13:** The user can filter by **aging container type**: oak, stainless steel, concrete or others.
- [ ] **AC14:** The user can filter wines labeled as **natural wine**.

### Filters by price
- [ ] **AC15:** The user can filter by **price range** (`price_range`): `budget`, `mid`, `premium` or `luxury`, following the same scale defined in the system configuration FR.

### Filters by review performance
- [ ] **AC16:** The user can filter by **average overall rating**, selecting a predefined option ordered from highest to lowest.
- [ ] **AC17:** The user can filter by **average expert rating**, selecting a predefined option ordered from highest to lowest.
- [ ] **AC18:** The user can filter by **average consumer rating**, selecting a predefined option ordered from highest to lowest.
- [ ] **AC19:** The user can filter by **number of reviews received**, selecting a predefined option ordered from highest to lowest.
- [ ] **AC20:** The user can filter wines that have **at least one medal** registered.
- [ ] **AC21:** The user can filter by **medal type**: gold, silver or bronze.

---

## Priority

| Level  | Description                                      |
|--------|--------------------------------------------------|
| High   | Essential for MVP, blocks other functions        |
| Medium | Important but does not block the main flow       |
| Low    | Desirable, can be deferred to a future version   |

**Assigned Priority:** Medium — the wine listing is functional without filters, but these are essential for usability with large data volumes.

---

## Dependencies

- Depends on: `FR1-02` — Global navigation bar
- Is prerequisite for: `FR1-06` — Wine sorting
- Is prerequisite for: `FR3-01` — Wine dashboard

---

## Notes and Change History

- Filtering by vineyard was deliberately excluded from this section. The vineyard → its wines navigation is addressed in each vineyard's dashboard (`FR2-01`), keeping the general listing manageable.
- AC8 depends on AC7 to narrow the available regions. If no country is selected, all available regions are shown.
- The predefined values for rating, aging and review filters are illustrative — the exact ranges are defined in the system configuration FR.
- AC21 allows combining with AC20 for greater precision (e.g.: only wines with gold medal).

| Date      | Version | Author | Change Description |
|------------|---------|-------|------------------------|
| 2026-03-21 | 1.0     | David Ramirez      | Document creation |