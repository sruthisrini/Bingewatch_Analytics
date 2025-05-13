# Bingewatch_Analytics

## Project Overview
This project analyzes streaming platform content (such as movies and TV shows) from the Netflix Shows Dataset. The project uses SQL for data extraction and Power BI for creating an interactive dashboard. 

## Objective

The main objectives of this project are:
1. **Analyze Streaming Content**: Generate insights on the platform's content such as genre distribution, top actors, content count, and more.
2. **Data Extraction with SQL**: Use SQL queries to extract and analyze data from a PostgreSQL database.
3. **Interactive Dashboard**: Create an interactive Power BI dashboard to visualize key metrics like total content, ratings, genre distribution, and top actors.
4. **Categorization**: Categorize content based on keywords in descriptions (e.g., "violent" content).


## Data Source

The dataset used in this project was extracted from [Netflix Shows Dataset on Kaggle](https://www.kaggle.com/datasets/shivamb/netflix-shows).

### Create the Main Content Table:
```sql
-- Create the main content table for the streaming platform project
CREATE TABLE bingewatch (
    show_id VARCHAR(6),
    type VARCHAR(10),
    title VARCHAR(200),
    director VARCHAR(250),
    casts VARCHAR(1000),
    country VARCHAR(200),
    date_added VARCHAR(50),
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(20),
    listed_in VARCHAR(100),
    description VARCHAR(300)
);
```
For a full list of SQL queries, please see the `bingewatch.sql` file.

## Power BI Dashboard

The Power BI dashboard is designed to visualize the key metrics derived from the SQL queries. It includes:

- **Total Content Count**
- **Ratings by Total Titles**
- **Movies and TV Shows Count**
- **Genre Distribution**
- **Top 5 Actors in Most Content**
- **Top Countries by Movies and TV Shows**
- **Content Added by Year**

You can explore the dashboard by opening the `bingewatch.pbix` file in Power BI.

### PostgreSQL and Power BI Integration:

1. **SQL Database Setup**: I used **PostgreSQL version 17** to set up and manage the database. The data was stored and queried using PostgreSQL.

2. **Importing Data into Power BI**: After finalizing the SQL queries, I imported the `bingewatch` database into Power BI using the PostgreSQL connector to bring in the data for visualization.

# Setup Instructions

1. **Clone this Repository**  
Clone the repository to your local machine:  
`git clone https://github.com/yourusername/Bingewatch-Analytics.git`

2. **Database Setup**  
Set up a PostgreSQL instance (version 17 recommended) and create the `bingewatch` table using the provided SQL code.

3. **SQL Queries**  
Use the provided SQL queries to analyze data from the `bingewatch` table.

4. **Power BI Dashboard**  
Open the `bingewatch_dashboard.pbix` file in Power BI and connect it to your PostgreSQL database to visualize the data.
