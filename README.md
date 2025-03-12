# Target Sales

## About

This repository contains a data analysis based on a sales dataset from the Target store in Brazil. The entire ETL (Extract, Transform, Load) process was performed.
The dataset is available [here](https://www.kaggle.com/datasets/devarajv88/target-dataset).

## Objective

The goal of this project is to identify factors that impact Target's sales in Brazil, such as product categories, customer purchasing patterns, and logistical performance. Through data analysis, I aim to provide recommendations to optimize the sales process and increase profit, as well as identify opportunities to enhance customer satisfaction by adjusting logistics and targeted campaigns.

- Identifying sales patterns
- Customer segmentation
- Logistical efficiency

## Tools

- Python (3.10.9)
- MySQL (8.0)
- Power BI (Desktop)

## Problem

**How to optimize Target's sales in Brazil by identifying consumption patterns and segmenting customers based on their preferences and purchasing behaviors?**

- Are there specific periods of the year when sales are lower?
- Which product categories perform best, and which could be improved?
- Are there opportunities to increase sales in certain regions or cities?
- Which customer groups are buying more? How can Target better direct its campaigns to these groups?
- Is the company meeting the estimated delivery deadlines?
- How can logistics be improved to reduce costs and enhance customer experience?

<details>
<summary><h2>Procedures</h2></summary>

#### Extraction (Extract):
- The data was extracted from a .csv file available on Kaggle.com, [here](https://www.kaggle.com/datasets/devarajv88/target-dataset).

#### Load:
- Using Python, the data was directly loaded into MySQL, where the necessary tables were created.

-> [1_modelo_fisico.sql](https://github.com/brunasalvan/target_sales/blob/main/1_modelo_fisico.sql)

-> [2_python_importacao_tabelas.ipynb](https://github.com/brunasalvan/target_sales/blob/main/2_python_importacao_tabelas.ipynb)

#### Transformation (Transform):
- Within MySQL, transformations were applied to correct inconsistent and missing data, ensuring data quality.

-> [3_limpeza_transformacao.sql](https://github.com/brunasalvan/target_sales/blob/main/3_limpeza_transformacao.sql)

#### Exploratory Analysis:
- I analyzed the data by running SQL queries to extract the key indicators.

-> [4_queries.sql](https://github.com/brunasalvan/target_sales/blob/main/4_queries.sql)

#### Loading into Power BI:
- After transformation, the data was loaded into Power BI for visualization.

-> [target_dashboard.pdf](https://github.com/brunasalvan/target_sales/blob/main/target_dashboard.pdf)

#### Creating DAX Measures:
- In Power BI, DAX measures were created to enable dynamic and in-depth data analysis based on MySQL-transformed data.

-> [5_DAX_power_bi.md](https://github.com/brunasalvan/target_sales/blob/main/5_DAX_power_bi.md)

</details>

<details>
<summary><h2>Analysis</h2></summary>

### Key Indicators

- Total revenue: R$ 16,008,872;
- Total sales: 99,441 orders;
- Average ticket: R$ 154.10;
- Average installment: 2.85 times;
- Cancellation rate: 0.63% (low, which is positive).

### Consumption Patterns and Customer Segmentation

- Monday and Tuesday show the highest sales volumes;
- Saturday has the lowest volume, suggesting that promotional actions could be tested on this day;
- Sales peaks occur between 10 AM and 4 PM, with the highest movement at 4 PM;
- Low volume between 12 AM and 6 AM, indicating that actions during this period have little impact.

**Opportunity**: Create promotional campaigns focused on peak hours and test strategies to increase sales on Monday mornings.

### Products

**Top-Selling Categories:**
- Bed, Table & Bath – 11,115 units;
- Health & Beauty – 9,670 units;
- Sports & Leisure – 8,641 units;
- Furniture – 8,334 units;
- Computers & Accessories – 7,827 units.

**Opportunity**: Strengthen stock and campaigns for the best-selling categories. Analyze low-demand categories and evaluate strategies to boost their sales.

### Geographic Analysis

- The Southeast leads in sales, with 71,000 sales (mainly SP, RJ, and MG);
- The South has 15,000 sales;
- The Northeast and Central-West together account for 16,000 sales, indicating growth potential;
- The North has the lowest volume (2,000 sales), which may be related to logistics and high shipping costs.

**Opportunity**: Expand presence in the Northeast and North by testing regional campaigns and improving logistics. Evaluate strategies to reduce freight costs and improve delivery times in these regions.

### Logistics and Delivery Compliance

- Average delivery time: 12 days;
- 92% of deliveries are on time, but 7.87% are delayed.

**States with the highest delay rates:**
- Alagoas (23%);
- Maranhão (18.88%);
- Piauí (15.35%).

**Opportunity**: Review routes and logistics partners in critical states. Create internal alerts for orders exceeding 15 days.

**States with the highest freight costs:**
- Roraima (R$ 42.98);
- Paraíba (R$ 42.72);
- Rondônia (R$ 41.07).

**Opportunity**: Evaluate alternative logistics and regional carriers to reduce costs in these locations.

</details>

<details>
<summary><h2>Problem Solutions</h2></summary>

- **How to optimize sales by identifying consumption patterns and segmenting customers?**

**Recommended Actions:**

✔ Create promotional campaigns during peak hours (10 AM-4 PM).

✔ Test discounts or coupons on Saturdays, which have lower sales volumes.

✔ Segment customers by region, prioritizing the Northeast and North for expansion.

### Are there specific periods of the year with lower sales?
Yes. Graphs show declines in March and June. December and January are high, indicating a strong impact from Christmas and New Year.

**Recommended Action:**

✔ Create seasonal campaigns for low-sales periods.

### Which product categories perform best, and which could be improved?
Bed, Table & Bath, Health & Beauty, and Sports & Leisure. Low-performing categories should be analyzed: Computers & Accessories and Electronics may have low demand or uncompetitive prices.

### Are there opportunities to improve sales in certain regions or cities?
Yes. The Southeast dominates, but the Northeast and North have room for growth. High freight costs may be discouraging sales in these regions.

**Recommended Action:**

✔ Reduce freight and delivery times to improve conversion.

### Which customer groups buy more? How to direct campaigns?
Purchasing profiles: 63.5% of purchases are between R$ 101 and R$ 200. Few purchases exceed R$ 200, indicating barriers for higher-priced products.

**Recommended Action:**

✔ Offer attractive installment plans to encourage purchases over R$ 200.

### Is the company meeting delivery deadlines?
Partially. 92% of deliveries are on time, but 8% are still delayed. The average delay time is high in some states (AP = 48 days!).

**Recommended Action:**

✔ Improve logistics in the most affected regions and review transport providers.

### How can logistics be improved to reduce costs and enhance customer experience?
Identified problems:
- High freight costs in the North and Northeast. High delay rates in states like AP and RR.

**Recommended Actions:**

✔ Partner with regional carriers to reduce costs.

✔ Implement a more efficient tracking system.

</details>

<details>
<summary><h2>Conclusion</h2></summary>

In summary, these are the identified opportunities:

✔ Invest in strategic promotional campaigns (best hours and seasonality).

✔ Improve logistics and reduce freight costs.

✔ Better segment customers by region and average ticket.

✔ Expand presence in the Northeast and North.

</details>
