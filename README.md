# Sales and Customer Insights Analysis for a Nigerian E-Commerce Company

## Project Overview
This project is an end-to-end Data Analyst Capstone Project built around a realistic Nigerian e-commerce business scenario. The analysis begins with raw transactional data in Excel, continues with structured analysis in SQL, and ends with an interactive Power BI dashboard for reporting business insights.
The goal of the project is to transform raw sales data into actionable insights that can help management understand revenue performance, profitability, customer behavior, product demand, discount impact, and regional trends.
This project simulates the kind of work a data analyst would do in a real business environment where data is often messy at the source and must be cleaned, validated, analyzed, and communicated clearly for decision-making.


## Business Problem
A Nigerian e-commerce company wants to evaluate its operational and sales performance across products, customers, and regions. Although the business collects detailed order-level transaction data, the data exists in raw spreadsheet format and is not yet structured for reporting.

Management needs answers to the following questions:
- Which products and categories generate the highest sales
- Which customers and segments contribute the most revenue
- Which regions are performing best or worst
- How discounts affect profitability
- How logistics and shipping costs influence margins
- How sales change over time

The project addresses these questions by building a complete analytics workflow from raw data to dashboard reporting.

## Project Objectives
The main objectives of this project are to:
- clean and standardize raw e-commerce sales data in Excel
- prepare analysis-ready CSV files for SQL import
- design a simple relational data model
- write SQL queries to analyze performance and business trends
- build an interactive Power BI dashboard for stakeholders
- present findings and recommendations based on evidence from the data.

## Tools Used
1. Microsoft Excel
Used for:
- data inspection
- cleaning missing and inconsistent values
- removing duplicates
- validating financial columns
- exporting clean CSV files
  
2. SQL
Used for:
- relational table design
- data import
- aggregation and KPI analysis
- trend analysis
- customer, product, discount, geography, and logistics analysis
  
3. Power BI
Used for:
- building KPIs
- interactive dashboard design
- visual storytelling
- business reporting and executive presentation

##Dataset Description
The dataset represents raw order-level transactions for a Nigerian e-commerce company and includes the following business areas:
- orders
- customers
- products
- categories
- locations
- payment methods
- discounts
- shipping fees
- logistics cost
- revenue
- cost of goods sold
- profit

The raw dataset was intentionally created with realistic issues such as:
- duplicate records
- inconsistent labels
- missing values
- standardization problems
- financial inconsistencies
  
This makes the project suitable for demonstrating practical data cleaning and analysis skills.

## Project Workflow
1. Excel Data Cleaning
The raw dataset was reviewed and cleaned in Excel by:
- removing duplicate order records
- standardizing category, region, payment, and status labels
- converting date fields into a consistent format
- validating sales, discount, and profit-related columns
- preparing clean flat files for SQL import
  
2. SQL Data Modeling and Analysis
The cleaned data was split into:
- orders_fact
- dim_customer
- dim_product
- dim_date
- 
SQL was used to calculate:
- total sales
- total profit
- total orders
- average order value
- monthly sales trends
- category performance
- customer ranking
- regional performance
- discount impact
- logistics cost impact

3. Power BI Dashboard Development
Power BI was used to build an interactive dashboard showing:
- KPI cards
- sales trend analysis
- regional performance
- category and product rankings
- customer performance
- discount and profitability insights
  
## Data Model
The project uses a simple star-schema style structure:
- orders_fact as the central transaction table
- dim_customer for customer attributes
- dim_product for product and category details
- dim_date for time-based reporting
  
This structure supports efficient filtering, aggregation, and visualization in Power BI.

## Key KPIs
The dashboard reports the following KPIs:
-Total Revenue
-Total Profit
-Total Orders
-Total Quantity Sold
-Average Order Value
-Profit Margin
-Average Discount Rate
-Average Logistics Cost per Order
-Return Rate
-Cancellation Rate

## Sample Business Questions Answered
This project answers questions such as:
-Which product categories contribute the most revenue
-Which products generate high sales but low profit
-Which customer segments are most valuable
-Which regions have the strongest and weakest performance
-Does high discounting improve sales enough to justify lower margins
-Which months show peak sales activity
-How much do logistics costs reduce profitability

## Dashboard Pages
Executive Overview
Shows:
-revenue
-profit
-orders
-margin
-high-level sales trend

## Product and Category Analysis
Shows:
-top categories by revenue
-top products by profit
-low-margin products
-sales by category

## Customer Analysis
Shows:
-top customers by revenue
-sales by segment
-repeat customer patterns
-average order value by customer group

## Regional and Logistics Analysis
Shows:
-sales by region
-profit by region
-shipping and logistics cost impact
-delivery and order status insights

## Discount and Profitability Analysis
Shows:
-discount rate by category
-sales versus discount
-profit versus discount band
-products or regions with poor margin performance

## Key Findings
The analysis shows that revenue is concentrated in a few high-performing categories and regions, while several products that generate strong sales contribute relatively low profit after discounting and logistics costs are considered.
A small number of customer segments and repeat buyers contribute a significant share of revenue, suggesting that customer retention and segmentation are important to business growth.
Discount-heavy transactions tend to reduce profitability, especially when combined with high logistics costs. Regional analysis also shows that some markets generate solid revenue but weaker profit margins due to fulfillment costs and discount patterns.
Overall, the project demonstrates that sales growth alone is not enough. Profitability, cost control, customer value, and operational efficiency must also be monitored closely.

## Recommendations
Based on the analysis, the business should:
-prioritize high-margin products and categories
-review products with high sales but low profit
-reduce excessive discounting where margins are already weak
-investigate high-cost delivery regions for logistics optimization
-strengthen retention strategies for high-value customers
-use dashboard monitoring to track performance continuously

## Files in This Project
Suggested repository structure:
Nigeria-Ecommerce-Capstone/
│
├── data/
│   ├── raw/
│   │   └── a_nigeria_ecommerce_raw_dataset.xlsx
│   ├── cleaned/
│   │   ├── orders_fact.csv
│   │   ├── dim_customer.csv
│   │   ├── dim_product.csv
│   │   └── dim_date.csv
│
├── excel/
│   └── cleaning_notes.xlsx
│
├── sql/
│   ├── schema.sql
│   ├── import.sql
│   ├── analysis_queries.sql
│   └── views.sql
│
├── powerbi/
│   └── nigeria_ecommerce_dashboard.pbix
│
└── README.md

## Project Value
This project demonstrates practical skills in:
-Excel data cleaning
-SQL querying
-relational data modeling
-KPI development
-dashboard design
-business storytelling
-end-to-end analytics workflow
It is well suited for a portfolio, internship application, junior analyst role, or academic capstone submission.

## Disclaimer
This is a portfolio capstone project built around a realistic Nigerian e-commerce business scenario. The dataset is simulated for educational and portfolio purposes and does not represent private internal data from any actual company.

## Author
Osinachi Chigaemezu Esinulo
Data Analyst Capstone Project
