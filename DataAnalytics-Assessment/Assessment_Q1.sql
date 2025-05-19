
select a.id as owner_id,concat(first_name," ",last_name)name,count(case when b.is_regular_savings = 1 then 1 end)savings_count,
count(case when b.is_a_fund = 1 then 1 end)investment_count,total_deposit total_deposit
from users_customuser a
left join plans_plan b
on a.id = b.owner_id
left join (
select owner_id, sum(confirmed_amount) total_deposit
 from savings_savingsaccount group by 1
 ) c
on a.id = c.owner_id
where b.is_a_fund = 1 and b.is_regular_savings = 1
group by 1,2,5,6
order by total_deposit desc

