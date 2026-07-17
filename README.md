# Corporate Data Infrastructure: Advanced Relational Schema & Transactional Query Optimization Pipeline

## Executive Summary
Raw, unindexed transaction ledgers present severe computation penalties and lack business utility without optimized query execution models. This project establishes an automated, production-grade relational database architecture inside MySQL Workbench to process structured e-commerce data matrices. By executing multi-table joins, nested conditional subqueries, performance index scaling, and abstracted view reporting layers, this project delivers a highly optimized analytical engine for corporate decision support workflows.

---

## Technical Evaluation: Core Interview Responses

### 1. What is the difference between WHERE and HAVING?
* **`WHERE`**: Filters records at the individual row level *before* any aggregate grouping strategies or mathematical summary functions are executed by the engine. It cannot interact with aggregate blocks like `SUM()` or `COUNT()`.
* **`HAVING`**: Explicitly filters compiled, aggregated row matrices *after* the execution of a `GROUP BY` clause structures the output segments.

### 2. What are the different types of joins?
* **`INNER JOIN`**: Extracts overlapping rows where key match parameters exist across both relational schemas.
* **`LEFT JOIN`**: Extracts all records from the left-hand table along with corresponding matching entries from the right-hand table, injecting `NULL` values across empty data cells.
* **`RIGHT JOIN`**: Extracts all records from the right-hand table paired with matching row variables from the left-hand architecture.
* **`FULL JOIN`**: Compiles a broad structural map combining all records from both systems, writing `NULL` placeholders across unmatched sections on either side.

### 3. How do you calculate average revenue per user (ARPU) in SQL?
ARPU is calculated by dividing the total aggregated revenue vector by the absolute unique count of purchasing users. In standard SQL syntax:
```sql
SELECT SUM(quantity * price) / COUNT(DISTINCT user_id) AS ARPU FROM transaction_ledger;
```

### 4. What are subqueries?
Subqueries are nested SQL expressions embedded inside a primary parent calculation sequence (such as a `SELECT`, `WHERE`, or `FROM` block). They pass dynamic intermediate temporary arrays up to the parent query framework to complete multi-layered conditional metrics.

### 5. How do you optimize a SQL query?
* **Index Strategy**: Deploy dedicated B-Tree or Hash indices across heavily utilized foreign keys and filter columns to circumvent performance-heavy Full Table Scans.
* **Attribute Restraint**: Explicitly state required tracking columns instead of running costly `SELECT *` routines.
* **Boundary Pruning**: Utilize structured `WHERE` constraint filters to limit the dataset layout landscape early.

### 6. What is a view in SQL?
A view is a virtual data table defined as a stored, named query block configuration. Views do not store physical rows of data duplicate arrays directly; instead, they dynamically pull active records from base schemas on-demand, protecting structural database integrity.

### 7. How would you handle null values in SQL?
Null values indicate unrecorded data fields. They are programmatically handled using distinct relational logic tools:
* **`IS NULL` / `IS NOT NULL`**: Conditional query checks used to map or isolate missing cells within table rows.
* **`COALESCE(column, fallback_parameter)`**: Evaluates variable inputs from left to right and substitutes the first non-null argument parameter to preserve calculation continuity.

---

## Database Architecture Audit
* **Schema Normalized Tables**: 4 structured schemas initialized (`users`, `products`, `orders`, `order_details`).
* **Performance Enhancements**: Generated 2 core indexing keys (`idx_orders_user_id`, `idx_order_details_order_id`) to optimize cross-table join execution latency.
* **Abstract Reporting Assets**: Implemented `view_executive_sales_summary` to provide pre-aggregated metrics.

## Deliverables Index
1. `ecommerce_analysis.sql` —— Production-grade structured query execution script.
2. `query_output_screenshot.png` —— Execution logs and grid metric confirmation screens.

