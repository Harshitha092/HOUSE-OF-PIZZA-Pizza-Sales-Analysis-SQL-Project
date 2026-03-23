# 🏠 HOUSE OF PIZZA  
## 🍕 Pizza Sales SQL Analysis Project  
*A complete end-to-end SQL analysis of a full year of pizza sales data using MySQL.*

---

## 📌 Project Overview  
This project analyzes a full year of pizza sales data using MySQL, solving real business questions through advanced SQL techniques — with additional queries developed independently to extend the analysis beyond standard KPIs.

It analyzes **48,620 order line items**, spanning **21,350 orders** over a full year, for a fictional pizza store — **House of Pizza**.  
Using MySQL, I performed:

- Data Exploration & Validation  
- Data Cleaning  
- KPI Development  
- Business Analysis  
- Advanced SQL (CTEs, Window Functions, Ranking)  
- Insight Generation  

The objective is to understand **customer behavior**, **high-performing products**, **revenue trends**, and **operational patterns**.

This project demonstrates strong SQL skills and the ability to translate data into **clear business recommendations**.

---

## 📂 Dataset Details  
Source: https://github.com/Ayushi0214/pizza-sales---SQL  

| Table | Columns | Rows |
|--------|-----------|--------|
| pizzas | pizza_id, pizza_type_id, size, price | 96 |
| pizza_types | pizza_type_id, name, category, ingredients | 32 |
| orders | order_id, order_date, order_time | 21,350 |
| order_details | order_details_id, order_id, pizza_id, quantity | 48,620 |

---

## 🧱 ER Diagram  
Based on schema relationships:
- One pizza type → many pizzas  
- One pizza → many order lines  
- One order → many pizzas  

*(Visual available in PPT, pg 4)*

---
## 🗂 Database Setup

### 📌 Create Database  
```sql
CREATE DATABASE houseofpizza;
USE houseofpizza;
```

### 📌 Data Import
- `pizzas.csv` & `pizza_types.csv` imported using  
  **Table Data Import Wizard** → Create new table → Verify data types → Import.

- For `orders` and `order_details`, tables were created first:
```sql
CREATE TABLE orders (
    order_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    PRIMARY KEY(order_id)
);

CREATE TABLE order_details (
    order_details_id INT NOT NULL,
    order_id INT NOT NULL,
    pizza_id TEXT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY(order_details_id)
);
```
Then CSV files were imported into these tables using **Import Wizard**.

---

## 🧪 Data Cleaning & Validation  
Before analysis, the following checks were performed:

✔ No null values in key fields  
✔ No negative or zero prices  
✔ No invalid quantities  
✔ All orders had matching order_details  
✔ Sizes standardized (S, M, L, XL, XXL)  

Dataset is **clean, complete, and ready for analysis**.

---

## 📊 Key KPIs  
From SQL results:

- **Total Revenue:** $817,860.05  
- **Total Orders:** 21,350  
- **Average Order Value (AOV):** $38.31  
- **Highest-Priced Pizza:** The Greek Pizza ($35.95)  
- **Most Ordered Size:** Large  

---

## 🔍 Business Insights

### 🍕 Product Insights
- Large & Medium sizes are the most preferred.  
- The Greek Pizza is the highest-priced item.  
- Classic & Supreme categories generate the most revenue.

### 🕒 Time-Based Insights
- **Peak Hour:** 12 PM – 1 PM (PPT pg 10 :contentReference[oaicite:5]{index=5})  
- **Top Revenue Day:** Friday  
- **Top Revenue Month:** July  

### 💰 Revenue Insights
- Top revenue pizzas:  
  - Thai Chicken Pizza  
  - Barbecue Chicken Pizza  
  - California Chicken Pizza  
- Revenue strong & consistent throughout the year

---

## 🧠 Strategic Recommendations  
Based on insights:  
- Offer **lunchtime deals (12–1 PM)** to maximize peak-hour conversion.  
- Launch **Friday special offers** to leverage the highest-performing day.  

---

## 🛠 SQL Techniques Used  
- INNER JOIN, LEFT JOIN  
- Aggregations & Grouping  
- Window Functions  
- CTEs  
- Ranking  
- Date & Time Functions  
- Data Validation Queries  

All SQL scripts are included in:
- `Houseofpizza_BusinessQuestions.sql` 
- `Houseofpizzas_DataExploration.sql`

---

## 👩‍💻 Author  
**Harshitha Salian**  
Analytics Professional | SQL · Power BI · Excel · Python  
📍 Dubai, UAE | [LinkedIn](https://www.linkedin.com/in/salianharshitha/) | [GitHub](https://github.com/Harshitha092)

---
