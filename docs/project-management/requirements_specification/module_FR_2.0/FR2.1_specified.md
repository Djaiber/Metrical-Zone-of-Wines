# Functional Requirement Specification

---

## Metadata

| Field            | Value                        |
|------------------|------------------------------|
| **ID**           | FR2-01                       |
| **Module**       | Vineyard Page — Information  |
| **Version**      | 1.0                          |
| **Status**       | Draft                        |
| **Date**        | 2026-03-21                   |
| **Author**        | David Ramirez                |
| **Reviewed by** |                              |

---

## Description

**Statement:**
> The page of each vineyard must display the general information, geographic characteristics and aggregated metrics of the vineyard, including a summary of its wines and the reviews received by both the vineyard and its wines.

**Involved Actor:**
Common consumer or expert user who accesses a vineyard's page from the vineyard listing or from a country's dashboard. No authentication is required.

---

## Conditions

**Precondition:**
- The selected vineyard exists in the system with its registered data.
- Calculated metrics are available for the vineyard.

**Postcondition:**
The user views the complete vineyard dashboard with its information and most recent metrics. Read-only operation — no data is modified.

---

## Acceptance Criteria

### General information
- [ ] **AC1:** The vineyard's name, country, region and founding year are displayed.
- [ ] **AC2:** The vineyard's website is displayed as an external link, if available.
- [ ] **AC3:** The vineyard's image or logo is displayed, if available.

### Geographic characteristics
- [ ] **AC4:** The vineyard's average altitude is displayed.
- [ ] **AC5:** The soil type is displayed.
- [ ] **AC6:** The irrigation type is displayed.
- [ ] **AC7:** The harvest season is displayed.
- [ ] **AC8:** The area in hectares is displayed.

### Production metrics
- [ ] **AC9:** The total wines marketed by the vineyard is displayed.
- [ ] **AC10:** The range of available vintage years is displayed (e.g.: 2015–2023).
- [ ] **AC11:** The average aging months of its wines is displayed.
- [ ] **AC12:** The dominant grape or grapes of the vineyard are displayed.
- [ ] **AC13:** The predominant wine type produced by the vineyard is displayed.

### Quality and price metrics
- [ ] **AC14:** The vineyard's average overall rating is displayed, calculated from the vineyard's reviews.
- [ ] **AC15:** The average rating from amateurs and experts is displayed comparatively.
- [ ] **AC16:** The highest rating recorded for the vineyard is displayed.
- [ ] **AC17:** The average price of its wines and its price range category (`budget`, `mid`,`premium`, `luxury`) are displayed.
- [ ] **AC18:** The total medals earned by the vineyard's wines are displayed, differentiated by type: gold, silver and bronze.
- [ ] **AC19:** The vineyard's prestige index is displayed (`Emerging`,`Recognized`, `Acclaimed`, `Legendary`).

### Vineyard review metrics
- [ ] **AC20:** The total reviews received by the vineyard are displayed.
- [ ] **AC21:** A summary of the best review registered for the vineyard is displayed.

### Highlighted metrics of its wines
- [ ] **AC22:** The highest rated wine of the vineyard is displayed with its score.
- [ ] **AC23:** The most reviewed wine of the vineyard is displayed with its total reviews.

### General behavior
- [ ] **AC24:** All values correspond to the most recent calculation available in the system.
- [ ] **AC25:** If no calculated metrics exist for the vineyard, an insufficient data indicator is displayed instead of empty values or errors.

---

## Priority

| Level  | Description                                      |
|--------|--------------------------------------------------|
| High   | Essential for MVP, blocks other functions        |
| Medium | Important but does not block the main flow       |
| Low    | Desirable, can be deferred to a future version   |

**Assigned Priority:** High — it is the central view of the vineyard module and access point to its wines and reviews.

---

## Dependencies

- Depends on: `FR1-03` — Vineyard filtering
- Depends on: `FR1-04` — Vineyard sorting
- Is prerequisite for: `FR2-02` — Vineyard wine listing
- Is prerequisite for: `FR2-03` — Vineyard reviews
- Is prerequisite for: `FR2-04` — Create vineyard review

---

## Notes and Change History

- The metric attributes are consistent with those defined in `FR1-03` and `FR1-04`, but focused on the individual vineyard, not the global set.

| Date      | Version | Author | Change Description |
|------------|---------|-------|------------------------|
| 2026-03-21 | 1.0     | David Ramirez       | Document creation |