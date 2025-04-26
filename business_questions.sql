/* 1. Find Number business in each category*/
with cte as(
select business_id,trim(A.value) as category from tbl_yelp_bussiness, lateral split_to_table(categories,',') A)
select category,count(*) count from cte group by 1 order by 2 desc
--select * from tbl_yelp_bussiness
------------------------------------------------------------------------------------------------
/*2. Find top 10 users who have reviewed the most businesses in "Restaurant" Category*/
select r.user_id,count(distinct r.business_id) number_of_review from tbl_yelp_reviews r join tbl_yelp_bussiness b on b.business_id=r.business_id 
where b.categories like '%Restaurant%'
group by 1
order by 2 desc 
limit 10
------------------------------------------------------------------------------------------------
/*3. Find most the popular categories of business (based on number of reviews)*/
with cte as(
select business_id, trim(A.value) as category from tbl_yelp_bussiness 
,lateral split_to_table(categories,',') A)
select c.category,count(*) number_of_review from cte c inner join tbl_yelp_reviews R on R.BUSINESS_ID=c.business_id
group by 1
order by 2 desc
------------------------------------------------------------------------------------------------
/*4. Find top 3 most recent reviews for each business*/
select B.business_name,review_date,review_text,sentiment 
from tbl_yelp_reviews R join tbl_yelp_bussiness B on B.BUSINESS_ID=R.business_id
qualify row_number() over(partition by b.business_id order by review_date desc) <=3
--order by 1
------------------------------------------------------------------------------------------------
/*5. Find the month with highest number of reviews*/
select 
    month(review_date),
    count(*) number_of_review
from tbl_yelp_reviews 
group by 1
order by 2 desc
limit 1
------------------------------------------------------------------------------------------------
/*6. Find percentage of 5 star reviews for each business*/
select 
    B.BUSINESS_ID,
    B.BUSINESS_NAME,
    sum(case when star = 5 then 1 else 0 end)*100.0/count(star) percentage_of_5_star
from tbl_yelp_reviews R join tbl_yelp_bussiness B 
on R.BUSINESS_ID=B.BUSINESS_ID
group  by ALL
------------------------------------------------------------------------------------------------
/*7. Find the top 5 most reviews businesses ine each city*/
select 
    b.business_id,
    b.business_name,
    b.city,
    count(*) review_count_
from tbl_yelp_bussiness B 
join tbl_yelp_reviews R on R.business_id=b.business_id
group by all
qualify row_number() over(partition by city order by review_count_ desc) <=5
order by 3 
------------------------------------------------------------------------------------------------

/* 8. Find average rating of business that have at least 100 reviews*/
select b.business_name, avg(r.star) 
from tbl_yelp_bussiness B
join tbl_yelp_reviews R on R.business_id=b.business_id
group by 1
having count(*)>=100
order by 1

------------------------------------------------------------------------------------------------
/* 9. List top 10 users who have written the most reviews along with business they reviewed*/
with top_10_reviewers as(
select user_id,count(*) no_of_review
from tbl_yelp_reviews 
group by 1
order by 2 desc
limit 10)
select B.Business_name,R.user_id from top_10_reviewers TR 
join tbl_yelp_reviews R on r.user_id=TR.user_id
join tbl_yelp_bussiness B on B.BUSINESS_ID=R.BUSINESS_ID
order by 2,1
------------------------------------------------------------------------------------------------
/*10. Find top 10 businesses with highest with highest positive sentiment reviews*/
select B.BUSINESS_ID,B.BUSINESS_NAME,count(*) count_positive_sentiment from tbl_yelp_bussiness B 
join tbl_yelp_reviews R on R.BUSINESS_ID=B.BUSINESS_ID
where R.sentiment = 'Positive'
group by 1,2
order by 3 desc
limit 10
------------------------------------------------------------------------------------------------
