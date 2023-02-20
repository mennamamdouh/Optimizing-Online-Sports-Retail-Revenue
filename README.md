# Optimizing-Online-Sports-Retail-Revenue

## Table of Contents ##

  - [**About the project**](#about-the-project)
  - [**About the dataset**](#about-the-dataset)
  - [**Project's Main Strategy**](#the-main-strategy-used-in-this-project)
  - [**Libraries and Packages**](#python-libraries-and-packages)
  - [**Project's Phases**](#phases-of-the-project)
    - [1.  Database Preparation ](#1--database-preparation-)
    - [2.  Data Exploration ](#2--data-exploration-)
    - [3.  Data Analysis ](#3--data-analysis-)
    - [4.  Data Visualization ](#4--data-visualization-)
  - [**Insights**](#insights)

<hr>

## **About the project** ##

This project is a **Guided Project** from DataCamp (the data is already prepared and ready to use). It is about analyzing an online sports retail company data. Its main goal is to answer some questions related to the store's products and their prices, brands, revenue, ratings and number of reviews.

<hr>

## **About the dataset** ##

This project's dataset is divided into 5 *csv* files:

1. **Info** contains product id with its name and description.
2. **Finance** contains product id with its listing price, sale price, discount, and revenue.
3. **Reviews** contains product id with its rating and number of reviews.
4. **Traffic** contains product id and it last visited date on the website.
5. **Brands** contains product id and its brand.

All files have the product id as a primary key

<hr>

## **The main strategy used in this project** ##

First, I've created a MySQL database in which data was stored. Then I've established a connection between MySQL server and Python. After that I've executed all queries in Python and retrieved the required data. Finally I've done the analysis and visualization using Python's libraries and packages.

<hr>

## **Python Libraries and Packages** ##

### 1. <u> Main Libraries and Packages: </u> ###

* **Pandas** to deal with dataframes and perform data analysis
* **Numpy** to get statistical information
* **Matplotlib** and **Seaborn** for visualization
* **mysql.connector** to deal with the database

### 2. <u> Secondary Libraries and Packages: </u> ###

* **load_dotenv** and **os** to deal with variable environment
* **HTML** and **warnings** to customize the output plots

<hr>

## **Phases of the project** ##

### 1. <u> Database Preparation </u> ###

* Creating a database with the help of MySQL Server
    ```sql
    CREATE DATABASE sports_store;
    ```
* Creating the tables (a table for each csv file)
    ```sql
    CREATE TABLE info(
        product_name VARCHAR(100),
        product_id VARCHAR(15) PRIMARY KEY,
        description VARCHAR(500)
    );
    ```

    ```sql
    CREATE TABLE finance(
        product_id VARCHAR(15) PRIMARY KEY,
        listing_price DECIMAL(6, 2),
        sale_price DECIMAL(6, 2),
        discount DECIMAL(2, 2),
        revenue DECIMAL(8,2)
    );
    ```

    ```sql
    CREATE TABLE reviews(
        product_id VARCHAR(15) PRIMARY KEY,
        rating DECIMAL(2, 1),
        reviews INT
    );
    ```

    ```sql
    CREATE TABLE traffic(
        product_id VARCHAR(15),
        last_visited DATETIME
    );
    ```

    ```sql
    CREATE TABLE brands(
        product_id VARCHAR(15),
        brand VARCHAR(15)
    );
    ```

* Importing data into these tables

    <u> Using the following lines for all files: </u>
    ```sql
    LOAD DATA LOCAL INFILE 'path\file_name.csv'
    INTO TABLE table_name
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    ```

    <u> Example: </u>
    ```sql
    LOAD DATA LOCAL INFILE 'path\info.csv'
    INTO TABLE info
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    ```

* <u> Final database structure: </u>

<p align="center">
<img src="https://user-images.githubusercontent.com/70551007/219980679-24d069fd-9490-451c-8114-710a53812f79.png" width=500>
</p>

<hr>

### 2. <u> Data Exploration </u> ###

<ul>
This step was done using 2 functions in Python:

  * **show_columns:**
    ```python
    def show_columns(table):
        '''
        This function simply shows the columns of the table specified
        :param table -> the name of the table that you want to show its columns
        '''
        cursor.execute("""SHOW COLUMNS FROM {};""".format(table))
        columns = cursor.fetchall()
        print("Columns of {} table are:".format(table))
        for number, column in enumerate(columns):
            print(str(number+1) + ") " + column[0], end="\n")
    ```
  
  * **show_first_ten_results:**
    ```python
    def show_first_ten_results(table):
        '''
        This function shows the first 10 products of the table specified
        :param table -> the name of the table that you want to show its first 10 results
        '''
        cursor.execute("""SELECT * FROM {} ORDER BY product_id LIMIT 10;""".format(table))
        columns = cursor.column_names
        results = cursor.fetchall()
        df = create_dataframe(columns, results) # To return resutls in the form of a dataframe
        return df
    ```

Using these 2 functions, I can dig more into the data and understand what each column in each table exactly represents.

</ul>

<hr>

### 3. <u> Data Analysis </u> ###

<ul>

> This phase was done using a hybrid strategy; the analysis was done in SQL and the queries are get executed using MySQL/Python Connector, and the visualization was done using Matplotlib and Seaborn libraries in Python.

<u> This phase can be divided into some steps: </u>

1. Data extraction:

    > I've used the following SQL concepts:

   * Simple queries (SELECT ... FROM ... WHERE)
   * CASE ... WHEN ... THEN
   * GROUP BY & ORDER BY
   * JOINs
   * CTEs and Subqueries
   * Some analytical functions

2. Data transformation:

    * Changing data types
    * Dealing with datetime formats

3. Data Analysis:

    * Understand the results and extracting insights

</ul>

<hr>

### 4. <u> Data Visualization </u> ###

<ul>

> This phase depends on the previous phase as we just visualize the data that we've extracted to get more patterns and understand more insights.

1. The price categories which causes the highest revenue for both brands **Adidas** and **Nike**

<ul>
<p align="center">
<img src="https://user-images.githubusercontent.com/70551007/219980749-bd505df1-b140-4917-af30-344a1ed18281.png" width=750>
</p>

> **Average** and **Expensive** price categories achieve more revenue than **Elite** which is the most expensive products.

</ul>

<br>

2. How the number of reviews affects the revenue ?

<ul>
<img src="https://user-images.githubusercontent.com/70551007/219980761-0245f9da-332e-4c06-8038-717efe4f67e8.png" width=750>
</p>

> Revenue is increasing with the number of reviews which says that people buy the product which has a greater number of reviews then the revenue increases.

</ul>

<br>

3. How does the number of reviews change along the months of the year ?

<ul>
<p align="center">
<img src="https://user-images.githubusercontent.com/70551007/219980775-b3af5e0f-053e-4c7a-b3dd-99c6503edc72.png" width=750>
</p>
</ul>

<br>

4. The pecentage of footwears and the other clothing products in the store

<ul>
<p align="center">
<img src="https://user-images.githubusercontent.com/70551007/219980847-55559407-0e6f-4307-9f95-fdb03da33ccf.png" width=500>
</p>

> The store sells footwears (85%) more than any other piece of clothing (15%).

</ul>

<br>

5. The website's number of visits along the quarters of the year

<ul>
<p align="center">
<img src="https://user-images.githubusercontent.com/70551007/219980857-edbfd214-a1c4-414b-bfc4-338a33abc9a8.png" width=750>
</p>

> Along the quarters of the year, and for both brands **Adidas** and **Nike**, the first quarter (first 3 months of the year) has a greater number of visits for products than the other quarters.

</ul>

<br>

6. Female products VS. Male products for both **Adidas** and **Nike**

<ul>
<p align="center">
<img src="https://user-images.githubusercontent.com/70551007/219980866-ed0f3ba0-4618-45aa-87e0-b98fd2e2c4c0.png" width=750>
</p>

> For both **Adidas** and **Nike**, this store has products for men more than for women.

</ul>

</ul>

<hr>

## **Insights** ##

> In addition to the previous insights, the following insights have been gathered during the analysis phase (they're explained in the [notebook](https://github.com/mennamamdouh/Optimizing-Online-Sports-Retail-Revenue/blob/temporary/Codes/Optimizing%20Online%20Sports%20Retail%20Revenue.ipynb) without using visuals).

* The store has much more **Adidas** products than **Nike** products.

* For all products, **Adidas** has an average discount of **33.45%** while **Nike** has zero!

* The top 2 best selling products are **Air Jordan 10 Retro** and **Nike Zoom Fly** from **Nike**, and they were last visited on the website in 2019 and 2018 respectively.

* Product's description length doesn't affect the rating of the product that much.

* **Adidas** pieces are much pricier than **Nike**.

* Because of the first point, **Adidas** has much greater number of reviews than **Nike** along the months of the year.
