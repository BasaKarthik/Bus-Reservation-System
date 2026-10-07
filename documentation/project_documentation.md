# Bus Reservation System - Project Documentation

## 1. Project Overview

The Bus Reservation System is a relational database project developed using MySQL.

The system is designed to manage passengers, buses, routes, schedules, seats, bookings, payments, and cancellations.

The project demonstrates practical SQL concepts including database design, table creation, constraints, relationships, joins, aggregation, subqueries, CTEs, window functions, views, stored procedures, triggers, and data analysis.

---

## 2. Technologies Used

- MySQL
- MySQL Workbench
- SQL
- Git & GitHub

---

## 3. Database Name

```text
bus_reservation_system
```

---

## 4. Database Tables

The database contains the following 8 tables:

### 4.1 Passengers

Stores passenger information such as:

- Passenger ID
- First Name
- Last Name
- Gender
- Age
- Phone
- Email

### 4.2 Buses

Stores information about buses:

- Bus ID
- Bus Number
- Bus Type
- Total Seats
- Operator

### 4.3 Routes

Stores route information:

- Route ID
- Source
- Destination
- Distance

### 4.4 Schedules

Stores bus journey schedules:

- Schedule ID
- Bus ID
- Route ID
- Departure Date & Time
- Arrival Date & Time

### 4.5 Seats

Stores seat information for each bus:

- Seat ID
- Bus ID
- Seat Number
- Seat Type

### 4.6 Bookings

Stores passenger booking information:

- Booking ID
- Passenger ID
- Schedule ID
- Seat ID
- Booking Date
- Fare
- Booking Status

### 4.7 Payments

Stores payment information related to bookings:

- Payment ID
- Booking ID
- Amount
- Payment Method
- Payment Status
- Payment Date

### 4.8 Cancellations

Stores cancelled booking information:

- Cancellation ID
- Booking ID
- Cancellation Date
- Refund Amount
- Cancellation Reason

---

## 5. Relationships

The major relationships in the database are:

- Passengers → Bookings
- Buses → Schedules
- Buses → Seats
- Routes → Schedules
- Schedules → Bookings
- Seats → Bookings
- Bookings → Payments
- Bookings → Cancellations

The complete database relationship structure is available in the ER diagram.

---

## 6. SQL Concepts Implemented

### Basic SQL

- SELECT
- DISTINCT
- WHERE
- ORDER BY
- LIMIT
- BETWEEN
- IN
- LIKE
- Aggregate Functions

### Aggregate Functions

- COUNT()
- SUM()
- AVG()
- MIN()
- MAX()

### Advanced Query Concepts

- INNER JOIN
- GROUP BY
- HAVING
- Subqueries
- CASE Statements
- Common Table Expressions (CTEs)
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- PARTITION BY
- Date and Time Functions

### Database Objects

- Views
- Stored Procedures
- Triggers

### Constraints

- PRIMARY KEY
- FOREIGN KEY
- UNIQUE
- NOT NULL
- DEFAULT

---

## 7. Views

The project contains the following views:

### booking_details_view

Provides detailed information about bookings by combining passenger, bus, route, schedule, and seat information.

### confirmed_bookings_view

Displays only confirmed bookings.

### route_summary_view

Provides route-level booking statistics including:

- Total bookings
- Total booking value
- Average fare

---

## 8. Stored Procedures

The project contains three stored procedures:

### search_buses_by_route

Searches bus schedules based on source and destination.

### get_passenger_bookings

Retrieves booking information for a particular passenger.

### get_available_schedules

Retrieves upcoming schedules for a specified route.

---

## 9. Trigger

### after_booking_cancelled

This trigger automatically changes the related payment status to `Refunded` when a booking changes to `Cancelled`.

This demonstrates the use of automated database operations using MySQL triggers.

---

## 10. Data Analysis

The project includes SQL queries for analyzing:

- Passenger bookings
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

## 11. Project Structure

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
└── documentation/
    └── project_documentation.md
```

---

## 12. Learning Outcomes

Through this project, the following skills were developed:

- Relational database design
- SQL query writing
- Database normalization concepts
- Working with primary and foreign keys
- Data analysis using SQL
- Writing complex JOIN queries
- Using subqueries and CTEs
- Using window functions
- Creating database views
- Creating stored procedures
- Creating triggers
- Applying database constraints
- Understanding real-world database relationships
