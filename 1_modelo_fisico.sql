CREATE DATABASE db_target;

USE db_target;

CREATE TABLE tb_customers (
    customer_id CHAR(32) PRIMARY KEY,
    customer_unique_id CHAR(32),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(32),
    customer_state CHAR(2)
);

CREATE TABLE tb_geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat FLOAT(40),
    geolocation_lng FLOAT(40),
    geolocation_city VARCHAR(38),
    geolocation_state CHAR(2)
);

CREATE TABLE tb_order (
    order_id VARCHAR(32) PRIMARY KEY,
    customer_id CHAR,
    order_status VARCHAR(11),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME,
    FOREIGN KEY (customer_id) REFERENCES tb_customers (customer_id)
);

CREATE TABLE tb_payments (
    order_id CHAR(32),
    payment_sequential INT,
    payment_type VARCHAR(11),
    payment_installments INT,
    payment_value DECIMAL (10,2),
    FOREIGN KEY (order_id) REFERENCES tb_order (order_id)
);

CREATE TABLE tb_products (
    product_id CHAR(32) PRIMARY KEY,
    product_category VARCHAR(48),
);

CREATE TABLE tb_seller (
    seller_id CHAR(32) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR (40),
    seller_state CHAR(2)
);

CREATE TABLE tb_order_items (
    order_id CHAR,
    order_item_id INT,
    product_id CHAR,
    seller_id CHAR,
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL (10,2),
    FOREIGN KEY (order_id) REFERENCES tb_order (order_id),
    FOREIGN KEY (product_id) REFERENCES tb_products (product_id),
    FOREIGN KEY (seller_id) REFERENCES tb_seller (seller_id)
);




