# Bus Reservation System

A relational database project built with **MySQL** to manage passengers, buses, routes, schedules, seats, bookings, payments, and cancellations.

This project demonstrates practical SQL skills ranging from basic queries to advanced SQL features such as **CTEs, subqueries, window functions, views, stored procedures, triggers, constraints, and business analysis**.

---

## Project Overview

The Bus Reservation System is designed to organize and manage the core operations of a bus reservation service.

The database stores:

- Passenger details
- Bus information
- Routes
- Bus schedules
- Seat information
- Bookings
- Payments
- Cancellations

The project also includes analytical SQL queries to generate useful business insights from the reservation data.

---

## Technologies Used

- **MySQL**
- **MySQL Workbench**
- **SQL**
- **Git & GitHub**

---

## Database

**Database Name:**

```text
bus_reservation_system
```

### Tables

The database contains 8 tables:

| Table | Purpose |
|---|---|
| `passengers` | Stores passenger information |
| `buses` | Stores bus details |
| `routes` | Stores source, destination, and distance |
| `schedules` | Stores bus journey schedules |
| `seats` | Stores seat information |
| `bookings` | Stores passenger bookings |
| `payments` | Stores payment details |
| `cancellations` | Stores cancelled booking and refund details |

---

## Database Relationships

The major relationships are:

```text
Passengers ───< Bookings >─── Schedules
                  │
                  ├────────── Seats
                  │
                  ├────────── Payments
                  │
                  └────────── Cancellations

Buses ───< Schedules
Buses ───< Seats

Routes ───< Schedules
```

The complete ER diagram is available in the `er-diagram` folder.

---

## SQL Concepts Demonstrated

### Basic SQL

- SELECT
- DISTINCT
- WHERE
- ORDER BY
- LIMIT
- BETWEEN
- IN
- LIKE

### Aggregate Functions

- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`

### Advanced SQL

- INNER JOIN
- GROUP BY
- HAVING
- Subqueries
- CASE statements
- Common Table Expressions (CTEs)
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- PARTITION BY
- Date and time functions

### Database Features

- Primary Keys
- Foreign Keys
- UNIQUE constraints
- NOT NULL constraints
- DEFAULT values
- Views
- Stored Procedures
- Triggers

---

## Views

Three views are included:

### `booking_details_view`

Provides detailed booking information by combining passenger, bus, route, schedule, and seat data.

### `confirmed_bookings_view`

Displays only confirmed bookings.

### `route_summary_view`

Provides route-level statistics such as:

- Total bookings
- Total booking value
- Average fare

---

## Stored Procedures

Three stored procedures are included:

### `search_buses_by_route`

Searches bus schedules based on source and destination.

### `get_passenger_bookings`

Retrieves booking information for a particular passenger.

### `get_available_schedules`

Retrieves upcoming schedules for a specified route.

Example:

```sql
CALL search_buses_by_route('Hyderabad', 'Bengaluru');
```

---

## Trigger

### `after_booking_cancelled`

Automatically changes the related payment status to `Refunded` when a booking changes to `Cancelled`.

This demonstrates how database triggers can automate related database operations.

---

## Business Analysis

The project contains SQL queries to analyze:

- Passenger booking patterns
- Route popularity
- Booking revenue
- Average fares
- Payment methods
- Payment status
- Bus operator performance
- Cancelled bookings
- Pending bookings
- Highest fare bookings
- Upcoming schedules
- Route-wise booking performance

---

## Project Structure

```text
Bus-Reservation-System/
│
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   ├── 03_insert_data.sql
│   ├── 04_basic_queries.sql
│   ├── 05_joins.sql
│   ├── 06_business_analysis.sql
│   ├── 07_advanced_queries.sql
│   ├── 08_views.sql
│   ├── 09_stored_procedures.sql
│   └── 10_triggers.sql
│
├── er-diagram/
│   └── bus_reservation_system_er_diagram.pdf
│
├── documentation/
│   └── project_documentation.md
│
└── README.md
```

---

## How to Run the Project

### 1. Clone the repository

```bash
git clone <your-github-repository-url>
```

### 2. Open MySQL Workbench

Open MySQL Workbench and connect to your MySQL server.

### 3. Run the SQL files in order

Execute the files in this sequence:

```text
01_create_database.sql
02_create_tables.sql
03_insert_data.sql
04_basic_queries.sql
05_joins.sql
06_business_analysis.sql
07_advanced_queries.sql
08_views.sql
09_stored_procedures.sql
10_triggers.sql
```

The first three files create and populate the database. The remaining files contain queries and database objects used for analysis and functionality.

---

## Learning Outcomes

This project helped develop practical skills in:

- Relational database design
- SQL query writing
- Database relationships
- Primary and foreign keys
- Data analysis using SQL
- Complex JOIN queries
- Subqueries and CTEs
- Window functions
- Views
- Stored procedures
- Triggers
- Database constraints
- Business-oriented data analysis

---

## Project Purpose

This project was created as a practical SQL portfolio project to demonstrate database design, SQL querying, data analysis, and advanced MySQL concepts.

---