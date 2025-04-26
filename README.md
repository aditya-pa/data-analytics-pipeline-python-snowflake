# Data Analytics Pipeline using Python and Snowflake

## Project Overview

In this project, I analyzed Yelp's open business dataset by building a data pipeline using Python and Snowflake. The process involves multiple stages such as data extraction, transformation, sentiment analysis, and answering business questions based on the dataset. The project uses AWS S3 for storage, Snowflake for querying, and Python for performing sentiment analysis using UDF (User Defined Functions).

### Steps Involved:

1. **Data Download**:
   - The data was downloaded from [Yelp Business Open Dataset](https://business.yelp.com/data/resources/open-dataset/).

2. **Data Partitioning and Upload to AWS S3**:
   - The downloaded data was split into 30 parts using Python.
   - Each part was uploaded into a specified folder within an AWS S3 bucket.

3. **AWS S3 Setup**:
   - The business data was pushed into the same folder in S3.
   - A new AWS user was created with read access to the S3 bucket. Credentials were generated to access data in Snowflake.

4. **Data Fetch and Transformation in Snowflake**:
   - Data was fetched into Snowflake using the `VARIANT` datatype since it was in JSON format.
   - Two new tables, `reviews` and `businesses`, were created by accessing JSON keys. For example, `review_text` and `business_id` were extracted as columns.

5. **Sentiment Analysis Using UDF**:
   - A User Defined Function (UDF) was created in Snowflake to analyze sentiment based on the review text using Python's `TextBlob`.
   - The sentiment was categorized as ‘Positive’, ‘Negative’, or ‘Neutral’, and this data was included in the new review table.

6. **Answering Business Questions**:
   - After creating the two new tables, I answered 10 critical business-related questions using SQL queries in Snowflake.

---

## Project Flow

![Project Flow](https://github.com/aditya-pa/data-analytics-pipeline-python-snowflake/blob/main/Picture.png) <!-- Replace this link with your actual image link -->

---

## Files in the Project

1. **Python Code** (`data-partition.ipynb`):
   - The Python script to split the data and upload it to AWS S3.
   - Sentiment analysis using the `TextBlob` library, creating a UDF in Snowflake.

2. **SQL Code to Create Tables & UDF** (`create_tables.sql`):
   - SQL script to create tables in Snowflake from JSON data.
   - UDF to analyze sentiment in the review text.

3. **SQL Code for Business Questions** (`business_questions.sql`):
   - SQL queries used to answer 10 key business questions based on the Yelp dataset.

---

## 10 Business Questions Answered

1. **Find the Number of Businesses in Each Category**
2. **Find Top 10 Users Who Have Reviewed the Most Businesses in "Restaurant" Category**
3. **Find Most Popular Categories of Business (Based on Number of Reviews)**
4. **Find Top 3 Most Recent Reviews for Each Business**
5. **Find the Month with the Highest Number of Reviews**
6. **Find Percentage of 5-Star Reviews for Each Business**
7. **Find the Top 5 Most Reviewed Businesses in Each City**
8. **Find Average Rating of Businesses that Have At Least 100 Reviews**
9. **List Top 10 Users Who Have Written the Most Reviews Along with the Businesses They Reviewed**
10. **Find Top 10 Businesses with the Highest Positive Sentiment Reviews**

---

## Documentation

You can access the detailed documentation and screenshots of the results from the following PDF:

[Project Documentation PDF](link_to_pdf_with_screenshot) <!-- Replace this with your actual PDF link -->
