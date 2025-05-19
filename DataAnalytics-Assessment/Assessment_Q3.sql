with inactivity as 
(
select plan_id,last_transaction_date,
datediff(current_date,last_transaction_date)inactivity_days 
from 
 (
select plan_id,max(transaction_date)last_transaction_date
from savings_savingsaccount
where date(transaction_date) < date_sub(current_date,interval 365 day)
group by 1
) a
)
-- left joining plans_plan to inactivity cte because we only care about inactive plans
select a.plan_id,b.owner_id,case when b.is_regular_savings = 1 then "Savings" 
when b.is_a_fund = 1 then "Investment" end type,
a.last_transaction_date,a.inactivity_days
from inactivity a
left join plans_plan b
on a.plan_id =  b.id
where (b.is_regular_savings = 1  or b.is_a_fund = 1)
