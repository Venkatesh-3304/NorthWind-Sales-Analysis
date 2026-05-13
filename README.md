# 📊 Northwind Sales Analysis Dashboard Suite

> **Multi-dimensional Business Intelligence | 1994 – 1997**  
> Tools: Excel · SQL · Power BI

---

## 🚀 Overview

This end-to-end analytics project explores the classic **Northwind database** to uncover business insights across customers, orders, employees, products, and suppliers. The analysis combines SQL-based EDA, Excel pivot analysis, and an interactive 6-page Power BI dashboard suite — enabling data-driven decision-making across all major business functions.

---

## 🎯 Objectives

- Analyze sales performance across multiple dimensions
- Identify key revenue drivers at product, category, and supplier level
- Understand customer geographic distribution and role segmentation
- Evaluate individual employee revenue contribution
- Track order and revenue trends over time (1994–1997)
- Build an interactive, navigable Power BI dashboard suite

---

## 📂 Dataset

The Northwind dataset consists of **8 relational tables**:

| Table | Type |
|-------|------|
| Orders | Fact |
| Order Details | Fact |
| Customers | Dimension |
| Products | Dimension |
| Categories | Dimension |
| Suppliers | Dimension |
| Employees | Dimension |
| Shippers | Dimension |

---

## 🛠 Tools Used

| Tool | Purpose |
|------|---------|
| **Excel** | Data Cleaning, EDA, Pivot Analysis |
| **SQL (PostgreSQL)** | Aggregations, Joins, CTEs, Window Functions, Business Questions |
| **Power BI** | Data Modelling, DAX Measures, Interactive Dashboards |

---

## 🔗 Data Model

A **Star Schema** was designed in Power BI with `orders` and `order_details` as fact tables connected to all dimension tables. A custom `DateTable` was built for time intelligence analysis. A dedicated `_Measures` table was used to organize all DAX KPIs.

**DAX Measures Created:** Total Revenue, Total Orders, Total Customers, Total Employees, Total Suppliers, Total Products, Total Quantity Sold, Avg Order Value, Avg Product Price, Avg Tenure Years, Revenue per Employee, Category Revenue %, Max/Min Product Price, and more.

![Data Model](Dashboard%20Images/Data%20Model.png)

---

## 📊 Power BI Dashboards

### 1. 🧭 Index Dashboard — Navigation Hub

The central landing page of the suite, displaying company-wide KPIs and navigation cards to all 5 dashboards.

| KPI | Value |
|-----|-------|
| Total Orders | **830** |
| Total Revenue | **$1M** |
| Total Customers | **91** |
| Total Employees | **9** |
| Total Suppliers | **29** |
| Total Dashboards | **5** |

**What I built:** A fully navigable index page with clickable dashboard cards, each previewing the key metric and list of visuals within that dashboard. A year-level slicer (1994–1997) applies across the entire report for cross-dashboard filtering.

![Index Page](Dashboard%20Images/Index%20Page.png)

---

### 2. 👥 Customer Analysis Dashboard

**Focus:** Customer segmentation by role and geographic distribution

**What I analyzed:**
- **USA, Germany, and France** are the top 3 customer countries with 13, 11, and 11 customers respectively, followed by Brazil (9) and UK (7)
- **Sales Representatives dominate at 45.05%** of the customer base, indicating the business primarily deals with B2B sales contacts; other roles include Sales Managers (18.68%) and Accounting staff (12.09%)
- **Orders Trend** shows a steady climb from ~25 orders/month in 1994 to a peak of **50+ orders/month** in early 1996, before a sharp drop in mid-1996 (likely incomplete data for that period)
- Customer presence is concentrated across **North America and Europe** — minimal presence in Asia or other regions, indicating a geographic expansion opportunity

![Customer Analysis Dashboard](Dashboard%20Images/Customer%20Analysis%20Dashboard.png)

---

### 3. 📦 Order Performance Dashboard

**Focus:** Sales performance, revenue breakdown, and order trends

| KPI | Value |
|-----|-------|
| Total Orders | **830** |
| Total Revenue | **$1M** |
| Total Quantity Sold | **51K** |
| Avg Order Value | **$1.53K** |

**What I analyzed:**
- **Beverages ($0.27M)** and **Dairy Products ($0.23M)** are the top two revenue categories, together contributing ~50% of total revenue; Grains/Cereals and Produce are at the bottom ($0.10M each)
- **Germany and USA are tied at 122 orders each** — the highest ordering countries, followed by Brazil (83) and France (77)
- The **Order Value Distribution** shows the bulk of orders fall in the **$1K–$2.5K range (273 orders)** and **$0–$500 range (236 orders)**; very few high-value orders above $5K (only 31 total)
- Orders grew consistently from ~20/month (Aug 1994) to a **peak of ~78 orders in May 1996**, then sharply dropped in June 1996 — flagged as a data completeness issue requiring investigation

![Order Performance Dashboard](Dashboard%20Images/Order%20Performance%20Dashboard.png)

---

### 4. 🧑‍💼 Employee Analysis Dashboard

**Focus:** Employee revenue contribution, tenure, and distribution

| KPI | Value |
|-----|-------|
| Total Employees | **9** |
| Avg Tenure | **3.00 Years** |
| Revenue Generated | **$1M** |

**What I analyzed:**
- **Margaret Peacock leads with $233K** in revenue, followed by Janet Leverling ($203K) and Nancy Davolio ($192K) — the top 3 employees alone account for over **60% of total revenue**
- There is a **significant performance gap**: the top performer (Margaret Peacock, $233K) generates **3× more revenue** than the lowest (Steven Buchanan, $69K), signalling a need for performance management or territory review
- **Sales Representatives** make up the largest team title; others include Inside Sales Coordinator, Sales Manager, and Vice President
- **Ms.** is the most common title of courtesy (44.44%), followed by Mr. (33.33%), Dr. and Mrs. (11.11% each)
- **Tenure is evenly distributed** — exactly 3 employees each at 2, 3, and 4 years, with an average of 3.00 years
- Employees are split between **USA** and **UK** locations

![Employee Analysis Dashboard](Dashboard%20Images/Employee%20Analysis%20Dashboard.png)

---

### 5. 🛒 Product Analysis Dashboard

**Focus:** Product performance, pricing distribution, and category revenue

| KPI | Value |
|-----|-------|
| Avg Product Price | **$28.87** |
| Total Products | **77** |
| Revenue from Products | **$1M** |

**What I analyzed:**
- **Côte de Blaye is the single top-revenue product at ~$200K** — far ahead of #2 (Thüringer Rostbratwurst, ~$80K); its dominance is driven by premium pricing rather than high volume, as visible in the Revenue vs Quantity scatter plot
- **Beverages and Dairy Products lead in both revenue and quantity sold**, confirming their dominance across the entire catalog
- The **Revenue vs Quantity scatter** reveals most products cluster at low revenue with moderate quantity — only a handful of premium-priced products generate disproportionately high revenue with moderate sales volumes
- **Price distribution**: the majority of products are priced in the **$11–$25 range (35 products)**, followed by $26–$50 (22 products); only 7 products are priced above $50, yet they contribute significantly to revenue
- Grains/Cereals and Produce are the lowest revenue categories, suggesting limited customer demand or pricing pressure

![Product Analysis Dashboard](Dashboard%20Images/Product%20Analysis%20Dashboard.png)

---

### 6. 🚚 Supplier Analysis Dashboard

**Focus:** Supplier impact on pricing, product count, and revenue generation

| KPI | Value |
|-----|-------|
| Total Suppliers | **29** |
| Avg Product Price | **$28.87** |
| Total Products | **77** |

**What I analyzed:**
- **Aux joyeux ecclésiastiques has by far the highest average product price (~$130+)** — as the supplier of Côte de Blaye (the top revenue product), this single supplier has an outsized impact on overall revenue
- **Pavlova, Ltd. and Plutzer Lebensmittelgroßmärkte AG supply the most products (~5 each)** — making them the most catalog-diversified suppliers
- In **revenue generated**, Aux joyeux ecclésiastiques leads at ~$0.2M, followed by Plutzer Lebensmittelgroßmärkte — confirming that revenue concentration aligns with pricing power, not just product volume
- **Supplier geography spans 12+ countries** including USA, Germany, France, UK, Japan, Singapore, Australia, Brazil, and Canada — a truly global supply chain
- Revenue trend analysis shows **seasonal revenue fluctuations** across suppliers, with most suppliers peaking in early-to-mid 1996

![Supplier Analysis Dashboard](Dashboard%20Images/Supplier%20Analysis%20Dashboard.png)

---

## 💡 Key Insights Summary

| Area | Insight |
|------|---------|
| 📦 Revenue | Beverages + Dairy Products = ~50% of total revenue |
| 🌍 Geography | Germany & USA tied at 122 orders; Europe dominates customer base |
| 🧑‍💼 Employees | Top 3 employees generate 60%+ of total revenue |
| 🛒 Products | Côte de Blaye alone drives ~20% of product revenue |
| 🚚 Suppliers | 1 premium-priced supplier has outsized revenue impact |
| 📈 Trends | Orders grew 3× from 1994 to peak at 78/month in May 1996 |
| 💰 Order Value | Most orders in $1K–$2.5K range; high-value orders ($5K+) are rare |

---

## 📈 Business Recommendations

- **Double down on Beverages and Dairy** — consistently top in both revenue and volume; prioritize inventory and promotional investment
- **Investigate the June 1996 order drop** — determine if this is a data completeness issue or an actual business decline requiring corrective action
- **Address the employee performance gap** — the 3× revenue difference between top and bottom performers suggests a need for coaching, incentive realignment, or territory rebalancing
- **Leverage premium product pricing** — Côte de Blaye's success proves customers will pay for premium; explore expanding the premium product line
- **Optimize supplier contracts** — with average prices ranging from ~$5 to $130+ across 29 suppliers, consolidating or renegotiating with underperforming suppliers could improve overall margins
- **Expand in high-potential markets** — Germany and USA already lead in order volume; Brazil and France show strong existing customer bases and could yield high returns with targeted investment

---

## 📄 Deliverables

| Deliverable | File |
|-------------|------|
| Power BI Dashboard | `Northwind_Report.pbix` |
| Excel EDA | `EDA All Solutions.xlsx` |
| SQL Analysis | `EDA SQL.sql` |
| Project Documentation | `Northwind_Analytics_Doc.pdf` |
| PowerPoint Presentation | `Northwind_Sales_Analysis_PPT.pptx` |
| Dashboard Screenshots | `Dashboard Images/` |

---

## 📌 Conclusion

This project demonstrates a complete end-to-end data analytics workflow — from raw relational data through SQL EDA, Excel pivot analysis, Power BI data modelling, DAX measure development, and interactive dashboard design. The Northwind Sales Analysis Dashboard Suite surfaces actionable insights across all major business dimensions, enabling stakeholders to make informed decisions on products, customers, employees, and suppliers.

---

## 👤 Author

**Venkatesh Ravva**  
B.Tech — Artificial Intelligence & Data Science  
Chaitanya Engineering College, Visakhapatnam (2026)

[![GitHub](https://img.shields.io/badge/GitHub-Venkatesh--3304-181717?style=flat&logo=github)](https://github.com/Venkatesh-3304)
