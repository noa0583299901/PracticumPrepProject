# Practicum Prep Project

## Real Estate Agency Management System

---

# Project Overview

This project is a full-stack application developed as a preparation project for the practicum course.

The system manages real estate properties, agents, and the selling/renting process of apartments.

The architecture follows a **three-layer structure**:

**Angular Client → .NET Web API → SQL Server Database**

All communication with the database is performed using **Stored Procedures only**, as required by the project instructions.

---

# Technologies

**Database**
SQL Server

**Server Side**
.NET Web API (C#)

**Client Side**
Angular

---

# System Architecture

The system is built using three layers.

### Client (Angular)

Responsible for:

* UI
* routing
* forms
* calling the API

### API (.NET Web API)

Responsible for:

* receiving requests from Angular
* executing Stored Procedures
* returning the result

### Database (SQL Server)

Responsible for:

* storing system data
* running all business operations through Stored Procedures

### Data Flow

Angular → API → SQL Server → API → Angular

The API does **not contain SQL queries**.
It only executes Stored Procedures.

---

# Database Structure

The database contains four main tables.

## Apartments (Main Table)

Stores the real estate properties.

Fields:

* ApartmentID
* Title
* Description
* Price
* CityID
* StatusID
* AgentID
* CreatedDate

Relationships:

* CityID → Cities table
* StatusID → Statuses table
* AgentID → Agents table

---

## Cities

Stores the list of cities.

Fields:

* CityID
* CityName

Example values:

* New York, NY
* Miami, FL
* Chicago, IL

---

## Statuses

Stores property status values.

Examples:

* For Sale
* For Rent
* Sold

Fields:

* StatusID
* StatusName

---

## Agents

Stores the real estate agents.

Fields:

* AgentID
* FullName
* Email

Agents are responsible for managing apartments in the system.

---

# Stored Procedures

All database operations are implemented using Stored Procedures.

Main procedures:

### CreateApartment

Creates a new property.

### UpdateApartment

Updates an existing property.

### GetApartmentById

Returns full details of a specific property including joined information.

### GetAllApartments

Returns the list of all properties.

Supports search and filtering.

### DeleteApartment

Deletes a property from the system.

---

Additional procedures used by the system:

### GetAllCities

Returns the list of cities.

### GetAllStatuses

Returns the list of statuses.

### GetAllAgents

Returns the list of agents.

### GetApartmentsByAgent

Returns apartments that belong to a specific agent.

---

# API

The API contains **one endpoint only**, according to the project requirements.

### Endpoint

POST

/api/exec

---

### Request structure

The request contains:

* procedureName
* parameters

Example request:

```
{
 "procedureName": "GetApartmentById",
 "parameters": {
   "ApartmentID": 1
 }
}
```

The API executes the requested Stored Procedure and returns the result to Angular.

The API contains **no business logic** and serves only as a bridge between Angular and SQL Server.

---

# Angular Application

The Angular application contains one service and multiple components.

## Service

### data.service.ts

Responsible for sending all requests to the API endpoint.

All API calls are executed through:

/api/exec

---

# Main Screens

The system contains the following screens.

---

## 1. List Screen

Displays all apartments in the system.

Features:

* search by title
* filter by city
* filter by status
* filter by price range
* add apartment
* view details
* edit apartment
* delete apartment (agent only)

Apartments are displayed using modern **property cards with images**.

---

## 2. Create / Edit Screen

Implemented using **Reactive Forms**.

Features:

* create a new apartment
* update existing apartment
* validation for required fields
* dropdown lists for related data:

  * cities
  * statuses
  * agents

All data is retrieved from the database using Stored Procedures.

---

## 3. Details Screen

Displays full information about a specific apartment.

Includes:

* title
* description
* price
* city name
* status name
* agent name
* created date

The page is designed with a **modern property layout**.

---

## Agent Login

Agents can log in using their **email**.

After login:

* the agent sees only their apartments
* the agent can edit apartments
* the agent can delete apartments
* the agent can add new apartments

Regular users can browse the system without logging in.

---

# How to Run the Project

## Database

Run the SQL script that creates:

* tables
* relationships
* stored procedures

Using SQL Server Management Studio.

---

## API

Open the API project in Visual Studio.

Run the project.

The API will be available at:

```
https://localhost:xxxx/api/exec
```

---

## Angular Client

Open the client folder.

Run:

```
npm install
ng serve
```

Then open the browser:

```
http://localhost:4200
```

---

# Additional Features

The system also includes:

* modern responsive UI
* property cards with images
* filtering system
* agent login system
* clean architecture between Angular, API, and SQL

---

# Project Purpose

This project demonstrates a complete full-stack system using:

* Angular
* .NET Web API
* SQL Server with Stored Procedures

The goal is to practice real-world architecture and data flow between the three layers of the system.
