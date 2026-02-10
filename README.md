# 📊 Bank Customer Churn Analysis (SQL Project)

## 🔎 Project Overview

This project analyzes a bank customer dataset to uncover churn patterns, customer risk segments, and revenue insights using SQL.

The goal of this analysis is to:

- Identify factors driving customer churn

- Segment customers based on demographic and financial attributes

- Evaluate high-value and high-risk customers

- Support data-driven retention and business strategy decisions

This project demonstrates practical SQL skills applied to a real-world business problem.

## 🗂 Dataset Description

The dataset contains the following features:
| Column           | Description                                      |
| ---------------- | ------------------------------------------------ |
| customer_id      | Unique customer identifier                       |
| credit_score     | Customer credit rating                           |
| country          | Customer country (France, Spain, etc.)           |
| gender           | Customer gender                                  |
| age              | Customer age                                     |
| tenure           | Years with the bank                              |
| balance          | Account balance                                  |
| products_number  | Number of bank products owned                    |
| credit_card      | Whether customer owns a credit card (0/1)        |
| active_member    | Active membership status (0/1)                   |
| estimated_salary | Estimated annual salary                          |
| churn            | Whether customer left the bank (1 = Yes, 0 = No) |

## 🧠 Business Questions Solved

### 1️⃣ Customer Churn Analysis

- Calculated overall churn rate

- Compared churn rate by:

  - Country
  
  - Gender
  
  - Age group
  
  - Tenure group
  
  - Active membership
  
  - Credit card ownership
  
  - Number of products

- Identified churn behavior among:

  - Low credit score customers
  
  - High balance customers
  
  - Top 10% salary earners
 
### 2️⃣ Customer Segmentation

- Created dynamic age clusters using CASE statements

- Built tenure segments (0–2, 3–5, 6+ years)

- Segmented customers by:

  - Country + Gender
  
  - Product ownership
  
  - Credit score groups

- Ranked customers by balance within each country using window functions

### 3️⃣ Revenue & Value Analysis

- Calculated total balance per country

- Identified top 5 segments with highest average balance

- Determined country generating highest total salary

- Analyzed high-credit-score customers' average balances

### 4️⃣ Advanced SQL Techniques Used

This project demonstrates:

✔ Aggregations

- SUM()

- AVG()

- COUNT()

- ROUND()

✔ Conditional Logic

- CASE statements

- Multi-condition classification logic

✔ Segmentation & Grouping

- GROUP BY

- HAVING

- Dynamic grouping

✔ Window Functions

- RANK()

- NTILE()

- PERCENT_RANK()

✔ Common Table Expressions (CTEs)

- Used for:

  - Top 10% salary segmentation
  
  - Risk classification modeling
  
  - Dynamic average balance calculation
 
### 📈 Advanced Risk Modeling

Customers were classified into risk categories:

- High Risk

  - Low credit score
  
  - Above average balance
  
  - Churned

- Medium Risk

  - High credit score
  
  - Below average balance
  
  - Churned

- Low Risk

  - High credit score
  
  - Below average balance
  
  - Did not churn

This demonstrates business logic translation into SQL-based risk modeling.

### 🛠 Tools Used

- SQL (MySQL)

- Window Functions

- CTEs

- Business Segmentation Logic

### 🎯 What This Project Demonstrates to Recruiters

This project highlights my ability to:

- Translate business problems into SQL queries

- Perform customer segmentation and churn analysis

- Apply window functions for advanced analytics

- Build structured, readable, production-ready SQL

- Think beyond simple aggregation into business strategy
