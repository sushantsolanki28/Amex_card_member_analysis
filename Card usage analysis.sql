CREATE DATABASE amex_db;
USE amex_db;
SELECT * FROM tb_credit;

ALTER TABLE tb_credit 
RENAME COLUMN `index` TO credit_id;

SELECT * FROM tb_credit;
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                           FIRST BUSINESS PROBLEM
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
How does overall spending and transaction activity vary across the different
card tiers? Calculate the total spend and number of transactions for each card tier.
*/
SELECT card_type,year,exp_type,
SUM(amount) AS total_spend,
COUNT(amount) AS transaction_freq
FROM tb_credit
GROUP BY card_type,year,exp_type
ORDER BY total_spend DESC
;
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                           SECOND BUSINESS PROBLEM
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Q2:Spend by tier × category (pivot-style)
/*
How is spending distributed across different categories within each card tier? 
Analyze spend by card tier and transaction category to identify category-level spending patterns.
*/
SELECT DISTINCT city_tier,
SUM(CASE WHEN Exp_type='Bills' THEN amount ELSE 0 END) AS Bills,
SUM(CASE WHEN Exp_type='Food' THEN amount ELSE 0 END) AS Food,
SUM(CASE WHEN Exp_type='Entertainment' THEN amount ELSE 0 END) AS Entertainment,
SUM(CASE WHEN Exp_type='Grocery' THEN amount ELSE 0 END) AS Grocery,
SUM(CASE WHEN Exp_type='Fuel' THEN amount ELSE 0 END) AS Fuel,
SUM(CASE WHEN Exp_type='Travel' THEN amount ELSE 0 END) AS Travel,
SUM(amount) AS total_spend
FROM tb_credit
GROUP BY city_tier
;
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                           THIRD BUSINESS PROBLEM
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

/*
Which cities contribute the most and the least to overall card member spending? 
Identify the top 10 and bottom 10 cities based on total spend.
*/
SELECT city,
SUM(Amount) AS total_spend
FROM tb_credit
GROUP BY city
ORDER BY city DESC
LIMIT 10
;
SELECT city,
SUM(Amount) AS total_spend
FROM tb_credit
GROUP BY city
ORDER BY city 
LIMIT 10
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                           FOURTH BUSINESS PROBLEM
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

/*
For each card tier, how much does each spending category contribute to its overall spend?
Calculate the percentage of each tier's total spend represented by each category using a window function.
*/
WITH tier_expenses AS(
     SELECT city_tier,Exp_type,
     SUM(Amount) AS category_spend,
     SUM(SUM(Amount)) OVER (PARTITION BY city_tier) AS tier_total
     FROM tb_credit
   GROUP BY city_tier,Exp_type
) 
SELECT city_tier,
ROUND(SUM(CASE WHEN Exp_type='Bills' THEN category_spend/tier_total*100 ELSE 0 END ),2) AS Bills,
ROUND(SUM(CASE WHEN Exp_type='Food' THEN category_spend/tier_total*100 ELSE 0 END ),2) AS Food,
ROUND(SUM(CASE WHEN Exp_type='Entertaiment' THEN category_spend/tier_total*100 ELSE 0 END ),2) AS Entertainment,
ROUND(SUM(CASE WHEN Exp_type='Fuel' THEN category_spend/tier_total*100 ELSE 0 END ),2) AS Fuel,
ROUND(SUM(CASE WHEN Exp_type='Travel' THEN category_spend/tier_total*100 ELSE 0 END ),2) AS Travel
FROM tier_expenses
GROUP BY city_tier
;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                           FIFTH BUSINESS PROBLEM
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

/* 

Within each city tier, which cities generate the highest levels of card member spending? 
Rank cities by total spend within their respective city tiers.
*/

SELECT city_tier,city,
SUM(Amount) AS spends,
RANK() OVER(PARTITION BY city_tier 
         ORDER BY SUM(Amount) DESC) AS spend_rank
FROM tb_credit
GROUP BY city_tier,city
ORDER BY city_tier, spend_rank
;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                           SIXTH BUSINESS PROBLEM
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

/*
How does spending within each category change from one month to the next? 
Calculate the month-over-month percentage change in spend by category, using previous-period values for comparison.
*/
WITH monthly_spend AS(
SELECT DATE_FORMAT(date,'%Y-%m') AS Month,Exp_type,
SUM(Amount) AS monthly_spend
FROM tb_credit
GROUP BY DATE_FORMAT(date,'%Y-%m'),Exp_type
),
Monthly_change AS(
SELECT month,Exp_type,monthly_spend,
LAG(monthly_spend) OVER (PARTITION BY Exp_type ORDER BY Month) AS previous_month_spend
FROM monthly_spend
)
SELECT Month,monthly_spend,previous_month_spend,
ROUND((monthly_spend-previous_month_spend)/previous_month_spend*100,2) AS Month_on_month_percent
FROM Monthly_change
ORDER BY Exp_type, month;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                           SEVENTH BUSINESS PROBLEM
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------


/*
Does the festive season lead to changes in average transaction value across spending categories?
Compare festive and non-festive average transaction values for each category.
 */
SELECT year,Exp_type,
ROUND(AVG(CASE WHEN festive_season='True' THEN amount ELSE 0 END),2) AS festive_avg,
ROUND(AVG(CASE WHEN festive_season='False' THEN amount ELSE 0 END),2) AS non_festive_avg
FROM tb_credit
GROUP BY year,exp_type
ORDER BY year, Exp_type;
;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                           EIGHTH BUSINESS PROBLEM
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

/*
How does the distribution of spending across categories differ between weekdays and weekends? 
Calculate the weekday and weekend share of spending for each category.
*/

SELECT Exp_type,
ROUND(SUM(CASE WHEN is_weekend='True' THEN amount ELSE 0 END )*100/SUM(amount),2) AS Weekend_share,
ROUND(SUM(CASE WHEN is_weekend='false' THEN amount ELSE 0 END )*100/SUM(amount),2) AS Weekday_share
FROM tb_credit
GROUP BY Exp_type
;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                           NINTH BUSINESS PROBLEM
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

/*
Which card tier has the greatest concentration of transactions classified as “Very High” value?
Calculate the share of Very High bucket transactions within each card tier and identify the highest share.
*/
SELECT city_tier,
ROUND(SUM(CASE WHEN Amount_Bucket='very_High' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS very_High_Share
FROM tb_credit
GROUP BY city_tier
ORDER BY Very_High_Share DESC;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                           TENTH BUSINESS PROBLEM
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

/*
Are there cities where travel spending represents a disproportionately large share of overall spending?
Identify cities with an unusually high Travel spend share compared with their overall transaction spending.
*/
SELECT city,
ROUND(SUM(CASE WHEN Exp_type='Travel' THEN amount ELSE 0 END)*100/SUM(amount),2) AS travel_share
FROM tb_credit
GROUP BY city
ORDER BY travel_share DESC
;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                     ACTIONABLE BUSINESS RECOMMENDATION                                                         
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
/*

1.Focus on Metro markets: They contribute 55.8% of total spend,making them the strongest market for targeted campaigns.
2.Prioritize high-value customers: The top transaction segment contributes 45% of total spend,creating a clear opportunity
for premium rewards.
3.Time travel offers better: Travel spend is 4.2% higher during festive periodsand 7.5% higher on weekends.
5.Personalize by spending behavior: Category patterns provide stronger signals than card tier, which shows no
significant difference in spend.
6.Explore smaller markets digitally: Tier-3 cities contribute 20.2% of spend,suggesting potential for targeted digital campaigns.
*/

