# DataAnalytics-Assessment

NOTE: all amount fields are in kobo

**Assessment_Q1.sql**

 
The savings_savingsaccount table, which contains all the transactions performed by users, is used to calculate each user's funding value (in kobo). I summed the confirmed amounts and grouped them by owner_id (i.e., the user) to show the total deposit for each user.
I then left-joined this result to the plans_plan table, which contains the plan types and details for each user. The condition is_regular_savings = 1 indicates that a user has a savings plan, and is_a_fund = 1 indicates an investment plan. I used a CASE WHEN expression to count how many savings and investment plans each user has. This aggregation was also done at the user level.
After that, I joined the result with the users_customuser table to retrieve the user's name and ID. I applied a condition where both is_regular_savings = 1 and is_a_fund = 1, based on the requirement: “a query to find customers with at least one funded savings plan AND one funded investment plan.” (Emphasis on the "AND" to filter only users who have at least one of both plans.)
Finally, I ordered the results by total_deposit in descending order as instructed.



**Assessment_Q2.sql**


First, I created a CTE named transaction_count, which contains the month (in year-month format) and the count of transactions each user performed in that month. All the data was sourced from the savings_savingsaccount table.
Next, I calculated the average number of transactions per month (avg_transactions_per_month) for each user by grouping the monthly transaction counts by owner_id.
I then left-joined this CTE with the users_customuser table. For each user, I categorized their average monthly transactions into one of three categories based on the given thresholds:
"High Frequency" for averages of 10 or more


"Medium Frequency" for averages between 3 and 9


"Low Frequency" for averages below and equal to  3


Finally, I counted the number of users (customer_count) falling into each frequency category and displayed the average number of transactions per month for each category. The results were ordered by the number of users in each category in descending order.




Challenge:
I had a problem getting the average transaction per month per user at first. I wasn’t grouping by the user initially causing duplicates when I joined it to the users_customuser customers table. I solved this by making the transactions per month a sub query then using the owner_id to group by the average above it.


**Assessment_Q3.sql**


For this question, I first selected the plan_id and the latest (MAX) transaction date from the savings_savingsaccount table, filtering for transactions where the transaction_date is older than 365 days from the current date. For example, if today's date is May 19, 2025, I only consider transactions that occurred before May 19, 2024.
I grouped the data by plan_id so that the MAX function would correctly retrieve the last transaction date for each plan — since a plan can have multiple transactions, but we only need the most recent one within the specified time range.
Next, I created a Common Table Expression (CTE) called inactivity, which computes the number of inactivity days for each plan by using DATEDIFF to subtract the last transaction date from the current date.
I then left-joined the plans_plan table with the inactivity CTE to get details about each plan, including the owner_id. In the final selection, I used a CASE statement to label each plan as either "Savings" or "Investment" based on the values of is_regular_savings and is_a_fund.
Finally, I applied a condition to show only plans where either is_regular_savings = 1 or is_a_fund = 1, based on the requirement to “find active account savings OR investment” — with emphasis on the OR, meaning the user must have at least one of the two types of plans.


**Assessment_Q4.sql**


In this query, I created a CTE named transactions. Within it, I first selected each transaction (using id, which is unique) from the savings_savingsaccount table and calculated the profit_per_transaction using the formula provided (0.001 * confirmed_amount).
Then, I aggregated this data by owner_id to get:
the total number of transactions per user (total_transactions), and


the average profit per transaction (avg_profit_per_transaction).


Next, I left-joined the transactions CTE to the users_customuser table since we want to calculate Customer Lifetime Value (CLV) for all users which I did using the provided formulae.


