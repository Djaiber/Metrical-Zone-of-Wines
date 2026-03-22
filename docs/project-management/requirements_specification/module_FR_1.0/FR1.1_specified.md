# Functional Requirement Specification

---

## Metadata

| Field            | Value                              |
|------------------|------------------------------------|
| **ID**           | FR 1.01 |
| **Module**       | User interface, Landing page       |
| **Version**      | 1.0                                |
| **Status**       | Draft   |
| **Date**        | 2026-03-21                         |
| **Author**        | David Ramirez                                   |
| **Reviewed by** |                                    |

---

## Description

**Statement:**
> The web application must display a dashboard of information for each country

**Involved Actor:**
All users, regardless of their type (amateur, expert), should view the same information. 

---

## Conditions

**Precondition:**
- Countries must be registered in the system with at least one vineyard and one associated wine.
- Metrics must be calculated and available for each country.

---
**Postcondition:**
-The user views the list of countries with their most recent aggregated metrics. Read-only operation — no data is modified.

---
## Acceptance Criteria

List of verifiable conditions that confirm the requirement was implemented correctly.

### Country identity information
- [ ] **AC1:** The country's name and visual indicator (flag or code) are displayed.
### Inventory metrics
- [ ] **AC2:** The total number of vineyards registered in the country is displayed.
- [ ] **AC3:** The total number of wines marketed in the country is displayed.
- [ ] **AC4:** The total number of reviews received in the country is displayed as a popularity indicator.
### General quality metrics
- [ ] **AC5:** The average overall rating of wines from the country is displayed, calculated from all reviews regardless of reviewer type (amateur, critic, organization).
- [ ] **AC6:** The exclusive average rating from critics and organizations is displayed.
- [ ] **AC7:** The exclusive average rating from common consumers is displayed.
- [ ] **AC8:** The highest rating recorded in the country is displayed.
- [ ] **AC9:** The country's prestige index is displayed—a calculated value that summarizes its overall performance.
  
### Price metrics
- [ ] **AC10:** The average price of wines from the country in USD is displayed.
- [ ] **AC11:** The price range category is displayed: `budget`, `mid`, `premium`, or `luxury`, derived from the average price.
### Production and style metrics
- [ ] **AC12:** The country's dominant grapes are displayed; there can be more than one.
- [ ] **AC13:** The predominant wine type in the country is displayed.
- [ ] **AC14:** The average aging months of wines from the country is displayed.
 
### Recognition metrics
- [ ] **AC15:** The best vintage year of the country according to reviews is displayed.
- [ ] **AC16:** The wine with the highest number of medals in the country is displayed.
- [ ] **AC17:** The total count of medals earned by wines from the country is displayed, differentiated by type: gold, silver, and bronze.
 
## Priority

| Level  | Description                                      |
|--------|--------------------------------------------------|
| High   | Essential for MVP, blocks other functions    |
| Medium  | Important but does not block the main flow    |
| Low   | Desirable, can be deferred to a future version   |

**Assigned Priority:**  
High

---
## Dependencies

Functional requirements that must be implemented before this one.

- Depends on: FR[x]-[y]

---

## Notes and Change History

 
| Date      | Version | Author | Change Description |
|------------|---------|-------|------------------------|
| 2026-03-21 | 1.0     | David Ramirez      | Document creation |