CREATE TABLE churn (
    customerID VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(10),
    SeniorCitizen TINYINT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(20),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(20),
    OnlineBackup VARCHAR(20),
    DeviceProtection VARCHAR(20),
    TechSupport VARCHAR(20),
    StreamingTV VARCHAR(20),
    StreamingMovies VARCHAR(20),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges DECIMAL(10,2),
    Churn VARCHAR(5)
);

DESCRIBE churn;

TRUNCATE TABLE customer_churn.churn;

LOAD DATA LOCAL INFILE "/Users/poojasubramanyam/Downloads/Customer_Churn_Analysis/Telco-Customer-Churn.csv"
INTO TABLE customer_churn.churn
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM churn;

-- Total no. of customers
SELECT COUNT(*) FROM churn;

-- Count churned vs non-churned
SELECT Churn, COUNT(*) AS churn_count
FROM churn
GROUP BY Churn;


-- Customers with high monthly charges (> 80)
SELECT customerid, MonthlyCharges
FROM Churn
WHERE MonthlyCharges > 80;


-- Customers with tenure > 12 months
SELECT customerid, tenure 
FROM churn
WHERE tenure > 12;


-- Avg monthly charges by churn
SELECT Churn, AVG(MonthlyCharges) AS avg_monthlyCharges
FROM churn
GROUP BY Churn;


-- Churn count by contract type
SELECT Contract, COUNT(Churn) AS churn_contractType
FROM churn
GROUP BY Contract;


-- Churn rate by gender
SELECT gender, COUNT(Churn) AS churn_genderType
FROM churn
GROUP BY gender;


-- Which contract type has highest churn?
SELECT Contract, COUNT(Churn) AS churn_count
FROM Churn
GROUP BY Contract
ORDER BY churn_count DESC;


-- Avg tenure of churned vs retained customers
SELECT Churn, AVG(tenure) AS avg_tenure
FROM Churn
GROUP BY Churn;


-- Customers with no tech support and churned
SELECT customerid
FROM Churn
WHERE TechSupport = "No" AND Churn = "Yes";


-- Categorize customers by tenure
SELECT customerid,
	CASE WHEN tenure < 12 THEN 'New'
		 WHEN tenure BETWEEN 12 AND 24 THEN 'Mid'
         ELSE 'Long-Term'
	END AS tenure_category
FROM Churn;


-- Revenue lost due to churn
SELECT SUM(MonthlyCharges) AS lost_revenue
FROM Churn
WHERE Churn = 'Yes';


-- Payment method preference of churned users
SELECT PaymentMethod, COUNT(Churn) AS churn_count
FROM Churn
WHERE Churn = 'Yes'
GROUP BY PaymentMethod
ORDER BY churn_count;


-- Rank customers by monthly charges
SELECT customerid, MonthlyCharges,
	RANK () OVER (ORDER BY MonthlyCharges DESC) AS cust_rank
FROM Churn;


-- Top 5 highest paying churned customers
SELECT customerid, MonthlyCharges
FROM Churn
WHERE Churn = 'Yes'
ORDER BY MonthlyCharges DESC
LIMIT 5;
-- OR through subquery
SELECT *
FROM (
    SELECT customerID, MonthlyCharges,
           RANK() OVER (ORDER BY MonthlyCharges DESC) AS rnk
    FROM churn
    WHERE Churn = 'Yes'
) t
WHERE rnk <= 5;


-- Churn rate %
SELECT 
    ROUND(100 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM churn;


-- Which service increases churn
SELECT InternetService, COUNT(*) AS total_count
FROM churn
GROUP BY InternetService;


-- Customers likely to churn
SELECT customerID
FROM churn
WHERE tenure < 12
	AND MonthlyCharges > 70
    AND TechSupport = 'No';



-- Find customers paying more than average but still churned
SELECT customerid, AVG(MonthlyCharges) AS monthly_charges
FROM churn
WHERE Churn = 'Yes'
GROUP BY customerid;


-- Churn by Contract
SELECT Contract, COUNT(*) AS total, SUM(Churn) AS churned,
ROUND(SUM(Churn)*100.0/COUNT(*),2) AS churn_rate
FROM churn
GROUP BY Contract
ORDER BY churn_rate DESC;


-- Churn by Tenure Group
SELECT tenure, COUNT(*) AS total,
	ROUND(SUM(Churn)*100.0/COUNT(*),2) AS churn_rate
FROM churn
GROUP BY tenure;


-- Churn by Payment Method
SELECT PaymentMethod,
ROUND(SUM(Churn)*100.0/COUNT(*),2) AS churn_rate
FROM churn
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;


-- High Risk Segment
SELECT Contract, PaymentMethod, COUNT(*) AS total,
SUM(Churn) AS churned
FROM churn
GROUP BY Contract, PaymentMethod
ORDER BY churned DESC;

