# project


# PlatinumRx Data Analyst Assignment

## Overview
This repository contains solutions for all three phases of the PlatinumRx DA assignment:
SQL, Spreadsheets, and Python.

---

## Folder Structure

```
Data_Analyst_Assignment/
│
├── SQL/
│   ├── 01_Hotel_Schema_Setup.sql    # Hotel table creation + sample data
│   ├── 02_Hotel_Queries.sql         # Part A — Questions 1–5
│   ├── 03_Clinic_Schema_Setup.sql   # Clinic table creation + sample data
│   └── 04_Clinic_Queries.sql        # Part B — Questions 1–5
│
├── Spreadsheets/
│   └── Ticket_Analysis.xlsx         # Three sheets: ticket, feedbacks, Analysis
│
├── Python/
│   ├── 01_Time_Converter.py         # Minutes → "X hrs Y minutes"
│   └── 02_Remove_Duplicates.py      # Remove duplicate characters from string
│
└── README.md
```

---

## Phase 1 — SQL

### Hotel System (Part A)

| Q | Approach |
|---|----------|
| Q1 – Last booked room per user | `ROW_NUMBER()` window function partitioned by `user_id`, ordered by `booking_date DESC`, keep rank = 1 |
| Q2 – Total billing per booking (Nov 2021) | `JOIN` bookings → booking_commercials → items; `SUM(item_quantity * item_rate)`; filter by year/month |
| Q3 – Bills > 1000 (Oct 2021) | Aggregate at `bill_id` level; `HAVING SUM(...) > 1000` |
| Q4 – Most/least ordered item per month | CTE aggregates quantity per month+item; `RANK()` ASC for least, DESC for most |
| Q5 – 2nd highest bill customer per month | `DENSE_RANK()` on per-user monthly totals; filter `rank = 2` |

### Clinic System (Part B)

| Q | Approach |
|---|----------|
| Q1 – Revenue by sales channel | `GROUP BY sales_channel`, `SUM(amount)` |
| Q2 – Top 10 customers | `GROUP BY uid`, `SUM(amount) DESC`, `LIMIT 10` |
| Q3 – Month-wise revenue, expense, profit | Two CTEs (revenue & expense) joined on month; `profit = revenue - expense`; CASE for status |
| Q4 – Most profitable clinic per city | Per-clinic profit CTE + `RANK()` by city; keep rank = 1 |
| Q5 – 2nd least profitable clinic per state | Same profit CTE + `DENSE_RANK()` ASC by state; keep rank = 2 |

> **Note:** Queries use `@target_year` and `@target_month` variables (MySQL syntax).
> For PostgreSQL, replace with `EXTRACT(YEAR FROM ...)` and use `$target_year` parameters.

---

## Phase 2 — Spreadsheets

**File:** `Spreadsheets/Ticket_Analysis.xlsx`

### Sheet: `ticket`
Raw ticket data with columns: `ticket_id`, `created_at`, `closed_at`, `outlet_id`, `cms_id`.

### Sheet: `feedbacks`
Feedback data. The `ticket_created_at` column (column D) is auto-populated using:
```
=IFERROR(VLOOKUP(A2, ticket!$E:$B, 2, FALSE), "Not Found")
```
- **Lookup value:** `cms_id` in feedbacks (column A)
- **Table array:** ticket sheet, columns E→B (cms_id → created_at)
- **Col index:** 2 (returns `created_at`)
- `IFERROR` handles unmatched IDs gracefully

### Sheet: `Analysis`
- **Helper columns** (E & F) compute per-ticket:
  - `Same Day?` → `=IF(INT(created_at) = INT(closed_at), "Yes", "No")`
  - `Same Hour of Same Day?` → `=IF(AND(INT(C)=INT(D), HOUR(C)=HOUR(D)), "Yes", "No")`
- **Summary table** uses `COUNTIFS` to aggregate per outlet:
  - Same-day ticket count
  - Same-hour-of-same-day ticket count

---

## Phase 3 — Python

### `01_Time_Converter.py`
```python
hours   = total_minutes // 60   # integer division
minutes = total_minutes % 60    # remainder
```
Handles edge cases: 0 minutes, exact hours, negative input.

### `02_Remove_Duplicates.py`
```python
result = ""
for char in input_string:
    if char not in result:
        result += char
```
Preserves first-occurrence order. Uses only a loop (no sets/dicts) as required.

---

## Assumptions

- SQL dialect: **MySQL 8.0+** (uses `YEAR()`, `MONTH()`, `MONTHNAME()`, window functions).
- Sample data was synthesised to match the schema structure shown in the PDF.
- Spreadsheet formulas use Excel/Google Sheets syntax.
- Python scripts use standard library only (no third-party packages).
