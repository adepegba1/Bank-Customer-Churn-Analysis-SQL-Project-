USE bank_db;
-- 🔹 Basic Analysis (Foundational SQL)

-- 1. Calculate the overall churn rate of customers in the dataset.
SELECT 
		ROUND(SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM bank;

-- 2. Find the total number of customers and churn rate per country.
SELECT
		country,
		COUNT(churn) total_customer,
		ROUND(SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM bank
GROUP BY country;

-- 3. Determine the average credit score of customers who churned vs those who stayed
SELECT
		churn,
		ROUND(AVG(credit_score), 2) AS average_credit_score
FROM bank
GROUP BY churn;

-- 4. Calculate the average account balance for churned and non-churned customers.
SELECT
		churn,
		ROUND(AVG(balance), 2) AS average_balance
FROM bank
GROUP BY churn;

-- 5. Find the average estimated salary grouped by gender and churn status.
SELECT
		gender,
		churn,
		ROUND(AVG(estimated_salary), 2) AS average_balance
FROM bank
GROUP BY churn, gender;

-- 🔹 Customer Segmentation

-- 6. Segment customers into age groups (e.g., 18–30, 31–40, 41–50, 51+) and calculate churn rate for each group.
SELECT
		CASE 
			WHEN age BETWEEN 18 AND 30 THEN '18-30'
            WHEN age BETWEEN 31 AND 40 THEN '31-40'
            WHEN age BETWEEN 41 AND 50 THEN '41-50'
            ELSE '51+'
		END AS 'Age_group',
        ROUND(SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS Churn_Rate
FROM bank
GROUP BY Age_group;


-- 7. Identify churn rate by tenure group (e.g., 0–2 years, 3–5 years, 6+ years).
SELECT
		CASE 
			WHEN tenure BETWEEN 0 AND 2 THEN '0-2 years'
            WHEN tenure BETWEEN 3 AND 5 THEN '3-5 years'
            ELSE '6+ years'
		END AS 'Tenure_clustering',
        ROUND(SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS Churn_Rate
FROM bank
GROUP BY Tenure_clustering;

-- 8. Compare churn rates between active and inactive members.
SELECT 
		CASE
			WHEN active_member = 1 THEN 'Active Member'
            ELSE 'Inactive Member' END AS 'Member_grouping',
        ROUND(SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS Churn_rate
FROM bank
GROUP BY active_member;

-- 9. Analyze whether customers with a credit card have lower churn rates.
SELECT 
		CASE
			WHEN credit_card = 1 THEN 'Credit Card'
            ELSE 'No Credit Card' END AS 'Credit Card Grouping',
        ROUND(SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS Churn_rate
FROM bank
GROUP BY credit_card;

-- 10. Determine churn rate by number of products owned.
SELECT 
		products_number,
        ROUND(SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS Churn_rate
FROM bank
GROUP BY products_number;


-- 🔹 Revenue & Value Analysis

-- 11. Calculate the total balance held by customers per country.
SELECT 
		country,
        ROUND(SUM(balance), 2) AS 'Total_balance'
FROM bank
GROUP BY country
ORDER BY Total_balance DESC;

-- 12. Find the top 5 customer segments (country + gender) with the highest average balance.
SELECT 
    country,
    gender,
    ROUND(AVG(balance), 2) AS avg_balance
FROM bank
GROUP BY country, gender
ORDER BY avg_balance DESC
LIMIT 5;

-- 13. Identify the average salary of customers who own more than 2 products.
SELECT 
		ROUND(AVG(estimated_salary),2) AS 'Average_Estimated_salary'
FROM bank
WHERE products_number > 2;

-- 14. Determine which country generates the highest total estimated salary.
SELECT 
		country,
        ROUND(SUM(estimated_salary),2) AS 'Total_Salary'
FROM bank
GROUP BY country
ORDER BY Total_Salary DESC
LIMIT 1;

-- 15. Calculate the average balance of high-credit-score customers (credit_score > 700).
SELECT
	ROUND(AVG(balance),2) AS avg_balance_high_credit
FROM bank
WHERE credit_score > 700;

-- 🔹 Risk & Behavioral Analysis

-- 16. Identify customers with low credit scores (< 500) and calculate their churn rate.
SELECT 
    ROUND(SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM bank
WHERE credit_score < 500;

-- 17. Find the correlation pattern between high balance (> 100,000) and churn.
SELECT
    CASE 
        WHEN balance > 100000 THEN 'High Balance'
        ELSE 'Low Balance'
    END AS balance_group,
    ROUND(SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM bank
GROUP BY balance_group;

-- 18. Rank customers by balance within each country using a window function.
SELECT 
    customer_id,
    country,
    balance,
    RANK() OVER (PARTITION BY country ORDER BY balance DESC) AS balance_rank
FROM bank;

-- 19. Identify the top 10% highest salary earners and analyze their churn behavior.
WITH salary_ranked AS (
    SELECT 
        customer_id,
        estimated_salary,
        churn,
        PERCENT_RANK() OVER (ORDER BY estimated_salary) AS salary_rank
    FROM bank
)

SELECT 
    COUNT(*) AS total_top_10_percent,
    ROUND(SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM salary_ranked
WHERE salary_rank >= 0.9;


-- 20. Using a CASE statement, classify customers as:
-- High Risk (low credit score + above average balance + churned)
-- Medium Risk (high credit score + below average balance + churned)
-- Low Risk (high credit score + below average balance  + not churned)
-- Then calculate the number of customers in each category.
WITH avg_balance_cte AS (
    SELECT AVG(balance) AS avg_balance
    FROM bank
)

SELECT 
    CASE
        WHEN credit_score < 500 
             AND balance > avg_balance 
             AND churn = 1 THEN 'High Risk'
             
        WHEN credit_score >= 500 
             AND balance <= avg_balance 
             AND churn = 1 THEN 'Medium Risk'
             
        WHEN credit_score >= 500 
             AND balance <= avg_balance 
             AND churn = 0 THEN 'Low Risk'
             
        ELSE 'Other'
    END AS risk_category,
    
    COUNT(*) AS total_customers

FROM bank
CROSS JOIN avg_balance_cte
GROUP BY risk_category
ORDER BY total_customers DESC;
