# Functional Requirement Specification

---

## Metadata

| Field            | Value                        |
|------------------|------------------------------|
| **ID**           | FR1-02                       |
| **Module**       | Navigation                   |
| **Version**      | 1.0                          |
| **Status**       | Draft                        |
| **Date**        | 2026-03-21                   |
| **Author**        | David Ramirez                |
| **Reviewed by** |                              |

---

## Description

**Statement:**
> The web application must have a persistent navigation bar that allows the user to directly access the Countries, Vineyards and Wines sections from anywhere in the application, without needing to follow a hierarchical flow.

**Involved Actor:**
Common consumer or expert user. No authentication is required. The navigation bar is visible and functional at all times regardless of the active section.

---

## Conditions

**Precondition:**
- The web application must be loaded and in any active view.

**Postcondition:**
The user is redirected to the selected section from the navigation bar, viewing the corresponding listing with its available data.

---

## Acceptance Criteria

### Navigation bar structure
- [ ] **AC1:** The navigation bar is persistently visible in all application views.
- [ ] **AC2:** The bar includes exactly three accessible sections: **Countries**, **Vineyards** and **Wines**.
- [ ] **AC3:** The active section where the user is located is visually differentiated from the others (e.g.: highlighted, underlined or another visual indicator).

### Navigation behavior
- [ ] **AC4:** When selecting **Countries**, the user is directed to the general list of countries with their aggregated metrics.
- [ ] **AC5:** When selecting **Vineyards**, the user is directed to the general list of vineyards without any previous filter applied.
- [ ] **AC6:** When selecting **Wines**, the user is directed to the general list of wines without any previous filter applied.
- [ ] **AC7:** Navigation from the bar is free — the user can jump to any section without hierarchical flow restriction.
- [ ] **AC8:** Navigation does not reload the entire page; it only directs the user to the required section.

### General behavior
- [ ] **AC9:** The navigation bar is responsive and adapts correctly to mobile and desktop devices.


---

## Priority

| Level  | Description                                      |
|--------|--------------------------------------------------|
| High   | Essential for MVP, blocks other functions        |
| Medium | Important but does not block the main flow       |
| Low    | Desirable, can be deferred to a future version   |

**Assigned Priority:** Low

---

## Dependencies

Functional requirements that must be implemented before this one.

- Depends on: FR[x]-[y]

---

## Notes and Change History

- The breadcrumb or hierarchical location indicator (e.g.: France > Bordeaux > Vineyard X) is not included in this version. It can be incorporated in a future iteration as a UX improvement.
- The Vineyards and Wines listings accessed directly from the bar will show all available records without filter. Filtering and search within each section will be specified in their corresponding FRs.
- Country is part of the navigation bar as a main section and acts as the application's entry view (`FR1-01`). The regions of each country are not an independent section in the bar — they are accessed as a subsection within each country's dashboard.

| Date      | Version | Author | Change Description |
|------------|---------|-------|------------------------|
| 2026-03-21 | 1.0     |       | Document creation |