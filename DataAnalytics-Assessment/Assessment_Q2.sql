
with transaction_count as (
select owner_id,avg(count_of_transactions)avg_transactions_per_month 
from 
(
select date_format(created_on,"%Y-%m") month,owner_id, 
count(*)count_of_transactions
from savings_savingsaccount
group by 1,2
) a
group by 1
)
select case when avg_transactions_per_month >= 10 then 'High Frequency'
            when avg_transactions_per_month between 3 and 9 then 'Medium Frequency'
            else 'Low Frequency'end as frequency_category,
count(id) customer_count,ifnull(avg_transactions_per_month,0 )avg_transactions_per_month
from users_customuser a
left join transaction_count b
on a.id = b.owner_id
group by 1,3
order by count(id) desc
