# Requisitos No Funcionales

---

## RNF1 — Usabilidad

**RNF1-01** The user interface must be intuitive and consistent across all sections, allowing both enthusiast and expert users to navigate the application without prior training.

**RNF1-02** The application must be responsive and adapt correctly to desktop and mobile devices, ensuring a functional experience on both form factors.

**RNF1-03** The application must display informative messages in all empty or error states, so the user always understands what happened and what they can do next.

**RNF1-04** All interactive elements such as buttons, filters and forms must provide visible feedback upon user interaction.

---

## RNF2 — Rendimiento

**RNF2-01** The main views of the application must load in under 3 seconds under normal network conditions.

**RNF2-02** Filter and sorting operations must reflect results in under 1 second without requiring a full page reload.

**RNF2-03** The application must remain functional and responsive with a moderate dataset, considered sufficient for academic demonstration purposes.

---

## RNF3 — Mantenibilidad

**RNF3-01** The source code must be organized following a clear and consistent folder and naming structure, separating frontend, backend and database layers.

**RNF3-02** The backend must expose a documented API that clearly separates the communication between the relational database (MySQL) and the non-relational database (MongoDB).

**RNF3-03** SQL stored procedures and triggers must be documented inline describing their purpose and the metrics they affect.

**RNF3-04** The codebase must avoid duplicated logic — shared behaviors such as filter and sorting patterns used across multiple sections must be implemented as reusable components or functions.