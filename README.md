# walmart-analysis-using-mysql
This is a analysis project of Walmart using SQL.
### Objectives of the Project:
The primary objective of this project is to analyze Walmart's sales data in order to comprehend the various factors influencing the sales performance across its branches.

The dataset was sourced from the Kaggle Walmart Sales Forecasting Competition. It comprises sales transactions from three distinct Walmart branches situated in Mandalay, Yangon, and Naypyitaw. This dataset encompasses 17 columns and 1000 rows.

#### Product Analysis:
Perform an in-depth examination of the data to gain insights into various product lines, identify the top-performing product lines, and pinpoint areas for potential improvement.

#### Sales Analysis:
This analysis is focused on unraveling the sales trends of products. The outcomes of this analysis will enable us to evaluate the effectiveness of our sales strategies and determine any necessary adjustments to boost sales further.

#### Customer Analysis:
The objective of this analysis is to unveil distinct customer segments, identify purchase patterns within these segments, and assess the profitability associated with each customer segment.


### Approach Used:

### Data Preprocessing:

Data Cleaning: In this initial step, we perform a thorough data inspection to identify and handle NULL and missing values, utilizing appropriate data replacement techniques where necessary.

Database Setup: We create a database and establish tables to store and organize the data.

Data Insertion: We populate the tables with the dataset.

Null Value Assessment: We analyze the columns for the presence of NULL values. Our tables are configured to disallow NULL values, ensuring that any missing data is accounted for during data insertion.

### Feature Engineering:

Time_of_Day Column: We introduce a new column called "time_of_day" to provide insights into sales during morning, afternoon, and evening periods. This assists in understanding the time of day when most sales occur.

Day_Name Column: A new column named "day_name" is added, containing the extracted days of the week (Mon, Tue, Wed, Thur, Fri) for each transaction. This aids in identifying the busiest days of the week for each branch.

Month_Name Column: We introduce a new column named "month_name," which contains the extracted months (Jan, Feb, Mar) of each transaction. This information is valuable for determining the highest sales and profits by month.

### Exploratory Data Analysis (EDA):

We conduct exploratory data analysis to address the project's objectives and questions.

### Conclusion:

## Business Questions to Answer:

#### Generic Questions:

How many unique cities are present in the data?

Which city corresponds to each branch?


#### Product Questions:

How many unique product lines are included in the dataset?

What is the most common payment method?

Which product line has the highest sales?

What is the total revenue by month?

Which month has the highest COGS (Cost of Goods Sold)?

Which product line generates the most revenue?

Which city has the highest revenue?

Which product line incurs the highest VAT (Value Added Tax)?

Create a "Good" or "Bad" label for each product line based on whether its sales are above or below the average.

Which branch exceeds the average number of products sold?

What is the most common product line by gender?

What is the average rating for each product line?

#### Sales Questions:

Number of sales made during each time of the day per weekday.

Which customer type contributes the most revenue?

Which city has the highest tax percent/VAT?

Which customer type pays the most VAT?


#### Customer Questions:

How many unique customer types are present in the data?

How many unique payment methods are available?

What is the most common customer type?

Which customer type makes the most purchases?

What is the predominant gender among customers?

How is the gender distribution per branch?

During which time of the day do customers give the most ratings?

For each branch, when do customers provide the highest ratings?

Which day of the week receives the best average ratings?

For each branch, which day of the week has the best average ratings?


