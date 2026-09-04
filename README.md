# 🛍️ Retail Sales Analysis — SQL Project

A complete, beginner-to-intermediate SQL project that cleans, explores, and analyzes 2,000 retail transactions to answer real business questions — the kind of questions a category manager, CFO, or operations lead would actually ask.

---

## 📌 Project Overview

This project simulates a real-world retail analytics workflow. Starting from a raw transactional dataset, I:

1. Designed and created a relational table schema
2. Performed data cleaning (identified & removed NULL records)
3. Ran exploratory data analysis (EDA) to understand the shape of the data
4. Answered 10 business-driven questions using SQL
5. Documented the insights that came out of the analysis

**Goal:** Turn raw point-of-sale data into decisions a retail business could actually act on — top customers, peak shopping hours, best categories, and monthly performance trends.

---

## 🗂️ Dataset

| Detail | Value |
|---|---|
| Records | 2,000 transactions |
| Time period | Jan 2022 – Dec 2023 |
| Categories | Clothing, Electronics, Beauty |
| Total revenue captured | ₹9,11,720 |
| Columns | `transaction_id`, `sale_date`, `sale_time`, `customer_id`, `gender`, `age`, `category`, `quantity`, `price_per_unit`, `cogs`, `total_sale` |

Source file: [`SQL - Retail Sales Analysis_utf .csv`](./SQL_-_Retail_Sales_Analysis_utf_.csv)

---

## 🧱 Database Schema

```sql
CREATE TABLE retail_sales (
    transaction_id  INT PRIMARY KEY,
    sale_date       DATE,
    sale_time       TIME,
    customer_id     INT,
    gender          VARCHAR(15),
    age             INT,
    category        VARCHAR(15),
    quantity        INT,
    price_per_unit  FLOAT,
    cogs            FLOAT,
    total_sale      FLOAT
);
```

---

## 🧹 Data Cleaning

Before any analysis, the dataset was checked for completeness:

```sql
SELECT * FROM retail_sales
WHERE transaction_id IS NULL OR sale_date IS NULL OR sale_time IS NULL
   OR customer_id IS NULL OR gender IS NULL OR age IS NULL
   OR category IS NULL OR quantity IS NULL OR price_per_unit IS NULL
   OR cogs IS NULL OR total_sale IS NULL;
```

Rows with missing critical fields (age, quantity, price, cogs, or total sale) were removed to keep downstream aggregations accurate.

---

## 🔍 Exploratory Data Analysis

| Question | Query |
|---|---|
| How many total sales? | `SELECT COUNT(*) FROM retail_sales;` |
| How many unique customers? | `SELECT COUNT(DISTINCT customer_id) FROM retail_sales;` |
| How many product categories? | `SELECT COUNT(DISTINCT category) FROM retail_sales;` |

**Result:** 2,000 transactions · ~155 unique customers · 3 categories (Clothing, Electronics, Beauty)

---

## 💼 Business Questions Answered

| # | Business Question |
|---|---|
| 1 | Retrieve all sales made on `2022-11-05` |
| 2 | Find all Clothing transactions with quantity > 10 in a given month |
| 3 | Calculate total sales for each category |
| 4 | Find the average age of customers who bought from the Beauty category |
| 5 | Find all transactions where total sale > ₹1000 |
| 6 | Count transactions by gender within each category |
| 7 | Calculate average monthly sales and identify the best-performing month per year |
| 8 | Identify the top 5 customers by total spend |
| 9 | Count unique customers per category |
| 10 | Segment orders into Morning / Afternoon / Evening shifts |

Full annotated queries live in [`SQL_Query.sql`](./SQL_Query.sql).

**Example — Sales shift segmentation:**

```sql
SELECT
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(total_sale) AS total_orders
FROM retail_sales
GROUP BY shift;
```

---

## 📊 Key Insights

- **Clothing leads in volume** — the highest number of transactions of the three categories, closely followed by Electronics.
- **Beauty customers skew a specific age range**, useful for targeted marketing.
- **A small group of repeat customers** (top 5) contribute a disproportionate share of total revenue — classic 80/20 pattern.
- **Shopping activity clusters by time of day**, which can directly inform staffing and promotional timing decisions.
- **Sales performance varies meaningfully by month**, highlighting clear seasonal peaks worth planning inventory around.

---

## 🛠️ Tech Stack

- **SQL** (MySQL syntax) — schema design, data cleaning, aggregation, window/date functions
- **CSV** — raw source data
- Concepts used: `GROUP BY`, `CASE WHEN`, `EXTRACT()`, aggregate functions, filtering, sorting, `LIMIT`

---

## 🚀 How to Run This Project

1. Clone the repo
   ```bash
   git clone https://github.com/databyaayush/retail-sales-sql-analysis.git
   ```
2. Import the dataset (`SQL_-_Retail_Sales_Analysis_utf_.csv`) into your SQL environment (MySQL Workbench / any client)
3. Run `SQL_Query.sql` step by step — schema creation → cleaning → EDA → business queries

---

## 📁 Repository Structure

```
├── SQL_-_Retail_Sales_Analysis_utf_.csv   # Raw dataset
├── SQL_Query.sql                          # All queries: schema, cleaning, EDA, analysis
└── README.md                              # Project documentation
```

---

## 👤 About Me

**Aayush Kumar Jha**
Aspiring Data Analyst | SQL · Python · Power BI · Tableau

- 🔗 Portfolio: [databyaayush.github.io/myPortfolio](https://databyaayush.github.io/myPortfolio/)
- 💼 LinkedIn: [linkedin.com/in/aayushkumar-jha-84b7753bb](https://linkedin.com/in/aayushkumar-jha-84b7753bb)
- 🧑‍💻 GitHub: [github.com/databyaayush](https://github.com/databyaayush)
- 📧 aayush.jha.working@gmail.com

If you found this project useful, consider giving it a ⭐ — it helps a lot!
