-- Snowflake for Marketing Analytics: Analyzing Customer Behavior and Campaign Performance
//
--Introduction to Snowflake for Marketing Analytics:
--Snowflake provides a powerful platform for marketing analytics, allowing organizations to analyze customer behavior and campaign performance to make data-driven decisions. With Snowflake's scalable architecture and support for diverse data types, marketers can gain insights into customer preferences, engagement patterns, and the effectiveness of marketing campaigns across various channels.
--
--Steps to Leverage Snowflake for Marketing Analytics:
--Data Ingestion: Ingest relevant marketing data sources into Snowflake, including customer demographics, website interactions, email opens, clicks, social media interactions, and campaign data.
--
--Data Preparation: Cleanse, transform, and prepare the ingested data for analysis. This may involve data normalization, standardization, and enrichment to ensure data quality and consistency.
--
--Data Modeling: Design and implement data models tailored to marketing analytics use cases. This may include dimensional modeling for customer behavior analysis, attribution modeling for campaign performance, and data warehouses optimized for analytical queries.
--
--Analytics and Insights: Perform exploratory data analysis, segmentation analysis, customer journey analysis, and campaign performance analysis to derive actionable insights. Analyze customer behavior patterns, identify high-value customer segments, and measure the ROI of marketing campaigns.
--
--Visualization and Reporting: Visualize analytical findings and create interactive dashboards and reports to communicate insights effectively. This may involve using tools like Snowflake Snowsight, Tableau, or Power BI.
--
--Data Governance and Compliance: Ensure compliance with data privacy regulations such as GDPR (General Data Protection Regulation) and CCPA (California Consumer Privacy Act) by implementing robust data governance policies, access controls, and data encryption mechanisms within Snowflake.


--##################################################################
//

--Customer Demographics Table:--

CREATE TABLE customer_demographics (
    customer_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    email VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(20),
    country VARCHAR(50)
);


--Website Visits Table:--

CREATE TABLE website_visits (
    visit_id INT,
    customer_id INT,
    visit_datetime TIMESTAMP,
    source VARCHAR(50),
    page_visited VARCHAR(50)
);


--Campaign Data Table:--

CREATE TABLE campaign_data (
    campaign_id INT,
    campaign_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    channel VARCHAR(50),
    clicks INT,
    conversions INT
);

#####################################################

--Insert Sample Data into Customer Demographics Table:--

INSERT INTO customer_demographics (customer_id, first_name, last_name, gender, age, email, city, state, country)
VALUES
    (1, 'John', 'Doe', 'Male', 35, 'john@example.com', 'Anytown', 'NY', 'USA'),
    (2, 'Jane', 'Smith', 'Female', 28, 'jane@example.com', 'Anycity', 'CA', 'USA'),
    (3, 'Michael', 'Johnson', 'Male', 40, 'michael@example.com', 'Anothercity', 'TX', 'USA'),
    (4, 'Emily', 'Brown', 'Female', 32, 'emily@example.com', 'Yetanothercity', 'FL', 'USA'),
    -- Add more sample data rows here...
    (97, 'William', 'Martinez', 'Male', 45, 'william@example.com', 'Newcity', 'WA', 'USA'),
    (98, 'Sophia', 'Garcia', 'Female', 30, 'sophia@example.com', 'Nextcity', 'GA', 'USA'),
    (99, 'Daniel', 'Lopez', 'Male', 38, 'daniel@example.com', 'Lastcity', 'MI', 'USA'),
    (100, 'Olivia', 'Rodriguez', 'Female', 27, 'olivia@example.com', 'Finalcity', 'PA', 'USA');


--Insert Sample Data into Website Visits Table:--

INSERT INTO website_visits (visit_id, customer_id, visit_datetime, source, page_visited)
VALUES
    (1, 1, '2023-01-01 08:00:00', 'Organic', 'Home'),
    (2, 2, '2023-01-01 10:00:00', 'Paid', 'Products'),
    (3, 3, '2023-01-02 09:00:00', 'Referral', 'About Us'),
    (4, 4, '2023-01-02 11:00:00', 'Direct', 'Contact'),
    -- Add more sample data rows here...
    (97, 97, '2023-01-10 15:00:00', 'Organic', 'Home'),
    (98, 98, '2023-01-10 17:00:00', 'Paid', 'Products'),
    (99, 99, '2023-01-11 08:00:00', 'Referral', 'About Us'),
    (100, 100, '2023-01-11 10:00:00', 'Direct', 'Contact');


--Insert Sample Data into Campaign Data Table:--

INSERT INTO campaign_data (campaign_id, campaign_name, start_date, end_date, channel, clicks, conversions)
VALUES
    (1, 'Summer Sale', '2023-06-01', '2023-06-30', 'Email', 1000, 50),
    (2, 'Holiday Promo', '2023-11-01', '2023-12-31', 'Social', 2000, 100),
    (3, 'Year-End Clearance', '2023-12-15', '2023-12-31', 'Display', 1500, 75),
    (4, 'New Year Campaign', '2024-01-01', '2024-01-15', 'Paid Search', 1800, 90),
    -- Add more sample data rows here...
    (5, 'Spring Collection Launch', '2024-03-01', '2024-03-31', 'Email', 1200, 60),
    (6, 'Summer Vacation Deals', '2024-06-01', '2024-06-30', 'Social', 2200, 110),
    (7, 'Back-to-School Sale', '2024-08-01', '2024-08-31', 'Display', 1700, 85),
    (8, 'Holiday Season Campaign', '2024-11-01', '2024-12-31', 'Paid Search', 2100, 105);

##################################################################


### Analyzing Customer Demographics


-- Query to calculate the average age of customers
SELECT
    AVG(age) AS average_age
FROM
    customer_demographics;


This query calculates the average age of customers stored in the "customer_demographics" table.

### Analyzing Website Visits


-- Query to count the number of website visits by source
SELECT
    source,
    COUNT(*) AS visit_count
FROM
    website_visits
GROUP BY
    source;


This query counts the number of website visits recorded in the "website_visits" table, grouped by the source of the visit.

### Analyzing Campaign Performance


-- Query to calculate the total clicks and conversions for each campaign
SELECT
    campaign_name,
    SUM(clicks) AS total_clicks,
    SUM(conversions) AS total_conversions
FROM
    campaign_data
GROUP BY
    campaign_name;


This query calculates the total number of clicks and conversions for each marketing campaign stored in the "campaign_data" table.

#############################################################################################


Below query that combines data from multiple tables to analyze the effectiveness of marketing campaigns by calculating the conversion rate and return on investment (ROI) for each campaign:


WITH campaign_metrics AS (
    SELECT
        cd.campaign_id,
        cd.campaign_name,
        SUM(cd.clicks) AS total_clicks,
        SUM(cd.conversions) AS total_conversions,
        AVG(wv.page_visited = 'Checkout') AS conversion_rate,
        AVG(cd.conversions * cp.average_order_value) AS total_revenue,
        SUM(cd.clicks * cp.cost_per_click) AS total_cost
    FROM
        campaign_data cd
    JOIN
        website_visits wv ON cd.campaign_id = wv.campaign_id
    JOIN
        cost_per_campaign cp ON cd.campaign_id = cp.campaign_id
    WHERE
        wv.visit_datetime BETWEEN cd.start_date AND cd.end_date
    GROUP BY
        cd.campaign_id, cd.campaign_name
)
SELECT
    campaign_id,
    campaign_name,
    total_clicks,
    total_conversions,
    conversion_rate,
    total_revenue,
    total_cost,
    (total_revenue - total_cost) AS profit,
    (total_revenue / total_cost) AS ROI
FROM
    campaign_metrics
ORDER BY
    ROI DESC;


In this query:
- We first calculate campaign metrics such as total clicks, total conversions, conversion rate, total revenue, and total cost for each campaign by joining the "campaign_data" table with the "website_visits" table and "cost_per_campaign" table.
- We then calculate the profit and ROI for each campaign by subtracting the total cost from the total revenue and dividing the total revenue by the total cost respectively.
- Finally, we select and order the results by ROI in descending order to identify the most profitable campaigns.

This query provides insights into the performance of marketing campaigns by analyzing conversion rates, revenue generated, costs incurred, and overall ROI. Adjust the query as needed based on your specific marketing analytics requirements and data schema.
