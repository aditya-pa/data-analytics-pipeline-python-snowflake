----------------------------------------------------------------------
create or replace table yelp_bussiness(bussiness_text variant)

Copy into yelp_bussiness
from 's3://namastesql-aditya/yelp/yelp_academic_dataset_business.json'
credentials = (
    AWS_KEY_ID = 'AKIA*******RJYRJNE****'
    AWS_SECRET_KEY = 'DH/QKdq*****m7fz****o8AvTLVkTun******0i/'
)
FILE_FORMAT = (TYPE = JSON);

select * from yelp_bussiness limit 10

---------------------------------------------------------------------
create or replace table yelp_reviews (review_text variant)

Copy into yelp_reviews
from 's3://namastesql-aditya/yelp/'
credentials = (
    AWS_KEY_ID = 'AKIA*******RJYRJNE****'
    AWS_SECRET_KEY = 'DH/QKdq*****m7fz****o8AvTLVkTun******0i/'
)
FILE_FORMAT = (TYPE = JSON);
------------------------------------------------------------------------
create table tbl_yelp_bussiness as
select 
    bussiness_text:business_id:: string as business_id,
    bussiness_text:city:: string as city,
    bussiness_text:state:: string as state,
    bussiness_text:review_count:: number as review_count,
    bussiness_text:categories:: string as categories,
    bussiness_text:stars:: number as stars
from yelp_bussiness 
-------------------------------------------------------------------------

create or replace function analyse_sentiment(text string)
returns string
language python
runtime_version = '3.8'
packages = ('textblob')
handler = 'sentiment_analyzer'
as $$
from textblob import TextBlob
def sentiment_analyzer(text):
    analysis = TextBlob(text)
    if analysis.sentiment.polarity >0.3:
        return 'Positive'
    elif analysis.sentiment.polarity<0.3 and analysis.sentiment.polarity>-0.3:
        return 'Neutral'
    else:d
        return 'Negative'
    
$$

select *, analyse_sentiment(review) from review
----------------------------------------------------------------------------
create or replace table tbl_yelp_reviews as
select 
    review_text:business_id:: string as business_id,
    review_text:date:: date as review_date,
    review_text:stars:: number as star,
    review_text:user_id:: string as user_id,
    review_text:text:: string as review_text,
    analyse_sentiment(review_text) as sentiment
from yelp_reviews


select * from tbl_yelp_reviews limit 10
----------------------------------------------------------------------------
