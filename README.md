
# Amazon Garden Category Seller Analysis 📊

This project focuses on analyzing data from the Amazon marketplace to identify top-performing merchants in the Garden category. Using MySQL for data cleaning and Power BI for data visualization, key insights were derived to support the acquisitions team in targeting promising sellers.

## Table of Contents
- [Overview](#overview)
- [Data Cleaning](#data-cleaning)
- [Visualizations](#visualizations)
- [Metrics and Key Insights](#metrics-and-key-insights)
- [How to Run](#how-to-run)
- [Conclusion](#conclusion)

## Overview
The goal of this project is to analyze Amazon sellers in the Garden category and provide data-driven recommendations to the acquisitions team. We used a dataset consisting of various sellers' metrics, including product counts, ratings, and seller performance indicators. 

## Data Cleaning
Using MySQL, the dataset was cleaned and prepared for analysis. The following steps were applied:
1. **Duplicate Removal:** Eliminated all duplicate entries to ensure data accuracy.
2. **Data Standardization:** Ensured consistent formatting across key fields like rating percentages, country names, and seller URLs.
3. **Handling Null/Zero Values:** Null values and zero entries were either excluded or replaced with averages based on predefined business rules.
4. **Column Reduction:** Removed unnecessary columns, focusing only on key metrics such as rating counts and seller performance indicators.

## Visualizations
After cleaning the data, we used Power BI for visualization. Key visualizations include:
1. **Pie Chart - Seller Distribution by Country:** Shows geographical distribution of sellers, highlighting countries with the most merchants.
2. **Stacked Column Chart - Hero Product Ratings:** Displays top sellers based on the ratings of their key products.
3. **Bar Chart - Number of Ratings:** Ranks sellers by their overall rating counts.
4. **Bar Chart - Composite Score by Country:** Compares countries based on a calculated composite score.
5. **Treemap - Top Sellers by Composite Score:** Visualizes top sellers, providing insights into their market dominance.
6. **Slicer for Interactive Analysis:** Allows filtering data based on specific countries for a more tailored analysis.

## Metrics and Key Insights
- **Total Sellers Analyzed:** 1,000 sellers.
- **Total Ratings:** 266K ratings.
- **Average Positive Rating:** 84.36%.
- **Average Composite Score:** 137.51.
- **Top Performing Countries:** Germany (314 sellers) and Canada (519 sellers).
- **Top Sellers by Rating Count:** Seller 487 with 37K ratings, indicating strong customer engagement.
- **Top Product Performers:** Sellers 498 and 496 stood out for high hero product ratings.

Composite Score Formula:
```sql
Composite_Score =  
 'cleaned_data'[positive_rating_percentage] * 0.4 +  
 (1 - 'cleaned_data'[Max % of negative seller ratings - last 12 months]) * 0.2 +  
 'cleaned_data'[rating_count] * 0.4
```

## How to Run
1. **Data Cleaning:**
   - Run the provided MySQL queries to clean and prepare the dataset.
   - Eliminate duplicates, handle null values, and standardize the data.
   
2. **Data Visualization:**
   - Import the cleaned data into Power BI.
   - Use the provided visuals and slicers for interactive analysis.
   
## Conclusion
This analysis provided crucial insights into the Amazon Garden category, allowing the acquisitions team to identify top-performing sellers based on ratings, geographical distribution, and composite scores. Key performers like Seller 487 and 498 emerged as leaders in customer engagement, with countries like Germany and Canada dominating the marketplace.
