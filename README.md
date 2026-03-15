🍷 Metrical Zone of Wines
Metrical Zone of Wines is a full-stack data platform designed to analyze wine regions, vineyards, and reviews through a hybrid relational and NoSQL architecture.
The system integrates MySQL for structured relational data and MongoDB for flexible review documents, enabling advanced analytics on wine quality, regional performance, and user feedback.
Developed as the final project for the Database Systems II course at Universidad El Bosque, the platform demonstrates modern database engineering practices including relational modelling, stored procedures, triggers, transaction management, and NoSQL document design.
🚀 Key Features
Wine region analytics dashboard
Hybrid SQL + NoSQL architecture
Stored procedures and database business logic
Transaction control and exception handling
MongoDB document-based reviews
Full-stack web application
Infrastructure deployed on Linux virtual machines
Database version control with Flyway
Git-based project management using Kanban
🧱 System Architecture
The platform follows a layered architecture:
React + TypeScript
        │
        ▼
Spring Boot REST API
        │
 ┌───────────────|
 ▼               ▼
MySQL 8        MongoDB 7
Relational     Reviews
Database       Documents
🛠 Technology Stack
Layer	Technology
Frontend	React 18 + TypeScript
Backend	Java 21 + Spring Boot
Relational DB	MySQL 8
NoSQL DB	MongoDB
DB Versioning	Flyway
Infrastructure	Linux Virtual Machines
Authentication	Amazon Cognito
Project Management	GitHub Projects (Kanban)
🗄 Database Features
The relational database includes:
10 normalized entities (3NF)
Stored Procedures
SQL Functions
Triggers
Transaction control (COMMIT / ROLLBACK)
Exception handling
MongoDB stores wine reviews using a flexible document schema supporting:
variable tasting notes
optional metadata
aggregation queries
📊 Project Objectives
This project demonstrates the integration of key database engineering concepts:
relational modeling and normalization
database-level business logic
hybrid persistence architectures
NoSQL document modeling
web application integration with databases
structured IT project management
📂 Repository Structure
backend/        Spring Boot API
frontend/       React + TypeScript UI
docs/           Architecture and database documentation
infrastructure/ Terraform and deployment scripts

