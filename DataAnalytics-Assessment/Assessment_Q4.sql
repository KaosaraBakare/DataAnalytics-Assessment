with transactions as (
select owner_id,count(*)total_transactions,avg(profit_per_transaction)avg_profit_per_transaction
from 
(
select id,owner_id,confirmed_amount,(0.001 * confirmed_amount)profit_per_transaction
from savings_savingsaccount
) a
group by 1
)


select a.id customer_id,concat(first_name," ",last_name)name,timestampdiff(month,date_joined,current_date)tenure_months,
total_transactions,((total_transactions/timestampdiff(month,date_joined,current_date))*12*avg_profit_per_transaction) estimated_clv
from users_customuser a
left join transactions b
on a.id = b.owner_id

