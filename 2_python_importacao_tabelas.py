{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "4db456b4",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Requirement already satisfied: mysql-connector-python in c:\\users\\bruna\\anaconda3\\lib\\site-packages (9.2.0)Note: you may need to restart the kernel to use updated packages.\n",
      "\n"
     ]
    }
   ],
   "source": [
    "pip install mysql-connector-python"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "267a1bec",
   "metadata": {},
   "outputs": [],
   "source": [
    "import mysql.connector\n",
    "import csv\n",
    "import pandas as pd"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "8767305b",
   "metadata": {},
   "outputs": [],
   "source": [
    "mydb = mysql.connector.connect(\n",
    "  host=\"localhost\",   #192.168.2.108\n",
    "  user=\"root\",\n",
    "  password=\"**********\",\n",
    "  database=\"db_target\"\n",
    ")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "c9b3832e",
   "metadata": {},
   "outputs": [],
   "source": [
    "df = pd.read_csv(r'C:\\\\Users\\\\bruna\\\\Documents\\\\target\\\\payments.csv')"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "f0113c60-6dc0-4dbf-a593-d5719f161441",
   "metadata": {},
   "outputs": [],
   "source": [
    "df.info()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "003e50c6",
   "metadata": {},
   "outputs": [],
   "source": [
    "mycursor = mydb.cursor()\n",
    "mydb.commit()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "e589ce9a",
   "metadata": {},
   "outputs": [],
   "source": [
    "# TABELA GEOLOCATION\n",
    "\n",
    "with open('C:\\\\Users\\\\bruna\\\\Documents\\\\target\\\\geolocation.csv', 'r') as file:\n",
    "    reader = csv.reader(file)\n",
    "    next(reader)  \n",
    "    for row in reader:\n",
    "        sql = \"INSERT INTO tb_geolocation (geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city, geolocation_state) VALUES (%s, %s, %s, %s, %s)\"\n",
    "        val = (row[0], row[1], row[2], row[3], row[4])  \n",
    "        try:\n",
    "            mycursor.execute(sql, val)\n",
    "        except mysql.connector.Error as err:\n",
    "            print(f\"Erro ao inserir linha: {row}\")  \n",
    "            print(f\"Erro: {err}\") \n",
    "            mydb.rollback()  # \n",
    "            break \n",
    "\n",
    "mydb.commit()\n",
    "mydb.close()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "434ea9a8-56c0-448f-a2f4-8ce63220c92d",
   "metadata": {},
   "outputs": [],
   "source": [
    "# TABELA ORDERS\n",
    "\n",
    "with open('C:\\\\Users\\\\bruna\\\\Documents\\\\target\\\\orders.csv', 'r') as file:\n",
    "    reader = csv.reader(file)\n",
    "    next(reader)  \n",
    "    for row in reader:\n",
    "        sql = \"INSERT INTO tb_order (order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at, order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date) VALUES (%s, %s, %s, %s, %s, %s)\"\n",
    "        val = (row[0], row[1], row[2], row[3], row[4], row[5])  \n",
    "        try:\n",
    "            mycursor.execute(sql, val)\n",
    "        except mysql.connector.Error as err:\n",
    "            print(f\"Erro ao inserir linha: {row}\")  \n",
    "            print(f\"Erro: {err}\") \n",
    "            mydb.rollback()  # \n",
    "            break \n",
    "\n",
    "mydb.commit()\n",
    "mydb.close()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "933ddc0f-0b66-4e07-b450-18587728e922",
   "metadata": {},
   "outputs": [],
   "source": [
    "# TABELA PAYMENTS\n",
    "\n",
    "with open('C:\\\\Users\\\\bruna\\\\Documents\\\\target\\\\payments.csv', 'r') as file:\n",
    "    reader = csv.reader(file)\n",
    "    next(reader)  \n",
    "    for row in reader:\n",
    "        sql = \"INSERT INTO tb_payments (order_id, payment_sequential, payment_type, payment_installments, payment_value) VALUES (%s, %s, %s, %s, %s)\"\n",
    "        val = (row[0], row[1], row[2], row[3], row[4])\n",
    "        try:\n",
    "            mycursor.execute(sql, val)\n",
    "        except mysql.connector.Error as err:\n",
    "            print(f\"Erro ao inserir linha: {row}\")\n",
    "            print(f\"Erro: {err}\")\n",
    "            mydb.rollback()\n",
    "            break\n",
    "\n",
    "mydb.commit()\n",
    "mydb.close()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "70c74421-77d7-4832-bccf-f273db7299c4",
   "metadata": {},
   "outputs": [],
   "source": [
    "# TABELA ORDER_ITEMS\n",
    "\n",
    "with open('C:\\\\Users\\\\bruna\\\\Documents\\\\target\\\\order_items.csv', 'r') as file:\n",
    "    reader = csv.reader(file)\n",
    "    next(reader)  \n",
    "    for row in reader:\n",
    "        sql = \"INSERT INTO tb_order_items (order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value) VALUES (%s, %s, %s, %s, %s, %s, %s)\"\n",
    "        val = (row[0], row[1], row[2], row[3], row[4], row[5], row[6])  \n",
    "        try:\n",
    "            mycursor.execute(sql, val)\n",
    "        except mysql.connector.Error as err:\n",
    "            print(f\"Erro ao inserir linha: {row}\")  \n",
    "            print(f\"Erro: {err}\") \n",
    "            mydb.rollback()  # \n",
    "            break \n",
    "\n",
    "mydb.commit()\n",
    "mydb.close()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "e7d2affe-db18-4fdb-8eb1-6c9f6f0afb4a",
   "metadata": {},
   "outputs": [],
   "source": [
    "# TABELA PRODUCTS\n",
    "\n",
    "with open('C:\\\\Users\\\\bruna\\\\Documents\\\\target\\\\products.csv', 'r') as file:\n",
    "    reader = csv.reader(file)\n",
    "    next(reader)  \n",
    "    for row in reader:\n",
    "        sql = \"INSERT INTO tb_products (product_id, product_category) VALUES (%s, %s)\"\n",
    "        val = (row[0], row[1])\n",
    "        try:\n",
    "            mycursor.execute(sql, val)\n",
    "        except mysql.connector.Error as err:\n",
    "            print(f\"Erro ao inserir linha: {row}\")  \n",
    "            print(f\"Erro: {err}\") \n",
    "            mydb.rollback()  # \n",
    "            break \n",
    "\n",
    "mydb.commit()\n",
    "mydb.close()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "8ed9bbf8-e50b-4960-943b-69a197cc43bb",
   "metadata": {},
   "outputs": [],
   "source": [
    "# TABELA SELLER\n",
    "\n",
    "with open('C:\\\\Users\\\\bruna\\\\Documents\\\\target\\\\sellers.csv', 'r') as file:\n",
    "    reader = csv.reader(file)\n",
    "    next(reader)  \n",
    "    for row in reader:\n",
    "        sql = \"INSERT INTO tb_seller (seller_id, seller_zip_code_prefix, seller_city, seller_state) VALUES (%s, %s, %s, %s)\"\n",
    "        val = (row[0], row[1], row[2], row[3])  \n",
    "        try:\n",
    "            mycursor.execute(sql, val)\n",
    "        except mysql.connector.Error as err:\n",
    "            print(f\"Erro ao inserir linha: {row}\")  \n",
    "            print(f\"Erro: {err}\") \n",
    "            mydb.rollback()  # \n",
    "            break \n",
    "\n",
    "mydb.commit()\n",
    "mydb.close()"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python [conda env:base] *",
   "language": "python",
   "name": "conda-base-py"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.10.9"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
