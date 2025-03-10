USE db_target;

# INDICADORES DE VENDAS

# Total de Vendas

SELECT FORMAT(SUM(payment_value), 2) 'Total vendas' 
FROM sa_payments;

# Vendas por Horas do Dia

SELECT HOUR(order_purchase_timestamp) 'Hora', 
CONCAT('R$ ', (SUM(payment_value))) 'Vendas'
FROM sa_order o
JOIN sa_payments p ON o.order_id = p.order_id
GROUP BY HOUR(order_purchase_timestamp)
ORDER BY SUM(payment_value) DESC;

# Vendas por Dia da Semana

SELECT DAYNAME(order_purchase_timestamp) 'Dia da Semana', SUM(payment_value) 'Vendas'
FROM sa_order o
JOIN sa_payments p ON o.order_id = p.order_id
GROUP BY DAYNAME(order_purchase_timestamp)
ORDER BY SUM(payment_value) DESC;

# Número de Pedidos

SELECT COUNT(order_id) AS 'Total pedidos'
FROM sa_order;

# Ticket Médio

SELECT FORMAT(SUM(payment_value) / COUNT(order_id), 2) 'Ticket médio'
FROM sa_payments;

# Distribuição das Formas de Pagamento

SELECT payment_type 'Forma de Pagamento', COUNT(payment_type) 'Total'
FROM sa_payments
GROUP BY payment_type
ORDER BY COUNT(payment_type) DESC;

# Parcelamento Médio

SELECT FORMAT(AVG(payment_installments), 2) 'Parcelamento médio'
FROM sa_payments;

# Vendas por Faixa de Valor do Pedido

SELECT
    CASE
        WHEN p.payment_value < 50 THEN 'Menos de R$50'
        WHEN p.payment_value BETWEEN 50 AND 100 THEN 'R$50 - R$100'
        WHEN p.payment_value BETWEEN 101 AND 200 THEN 'R$101 - R$200'
        ELSE 'Mais de R$200'
    END AS 'Faixa de Valor',
    COUNT(p.order_id) 'Total Pedidos'
FROM sa_payments p
GROUP BY 1
ORDER BY 2 DESC;

# Taxa de Cancelamento de Pedidos

SELECT
    (SELECT COUNT(*) FROM sa_order WHERE order_status = 'canceled') / COUNT(*) 'Taxa de Cancelamento'
FROM sa_order;

# Clientes recorrentes

SELECT c.customer_unique_id, COUNT(o.order_id) 'Total Pedidos'
FROM sa_customers c
JOIN sa_order o ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
HAVING COUNT(o.order_id) > 1
ORDER BY 2 DESC;

# Vendedores com mais vendas

SELECT s.seller_id, COUNT(oi.product_id) 'Total Produtos Vendidos'
FROM sa_seller s
JOIN sa_order_items oi ON s.seller_id = oi.seller_id
GROUP BY s.seller_id
ORDER BY 2 DESC;

# Vendedores com maior valor de vendas

SELECT s.seller_id, CONCAT('R$ ', SUM(oi.price)) AS 'Total Vendas'
FROM sa_seller s
JOIN sa_order_items oi ON s.seller_id = oi.seller_id
GROUP BY s.seller_id
ORDER BY SUM(oi.price) DESC;

# INDICADORES DE PRODUTOS

# Produtos Mais Vendidos

SELECT p.product_id, COUNT(o.product_id) 'Total'
FROM sa_products p
LEFT JOIN sa_order_items o
ON p.product_id = o.product_id
GROUP BY p.product_id
ORDER BY COUNT(o.product_id) DESC;

# Produtos com menos vendas

SELECT p.product_id, COUNT(o.product_id) 'Total'
FROM sa_products p
LEFT JOIN sa_order_items o 
ON p.product_id = o.product_id
GROUP BY p.product_id
ORDER BY COUNT(o.product_id) ASC;

# Categorias Mais Vendidas

SELECT p.product_category, COUNT(o.product_id) 'Total'
FROM sa_products p
INNER JOIN sa_order_items o
ON p.product_id = o.product_id
GROUP BY p.product_category
ORDER BY 'Total' DESC;

# INDICADORES DE LOGÍSTICA

# Tempo Médio de Aprovação do Pagamento

SELECT ROUND(AVG(TIMESTAMPDIFF(HOUR, order_purchase_timestamp, order_approved_at)), 0) 'Tempo médio aprovação do pedido (horas)'
FROM sa_order
WHERE order_approved_at IS NOT NULL;

# Tempo Médio de Entrega

SELECT ROUND(AVG(TIMESTAMPDIFF(DAY, order_purchase_timestamp, order_delivered_customer_date)), 0) 'Tempo médio entrega (dias)'
FROM sa_order
WHERE order_delivered_customer_date IS NOT NULL;

# Pedidos Entregues no Prazo

SELECT order_id,
DATE_FORMAT(order_estimated_delivery_date, '%d/%m/%Y') 'Data estimada',
DATE_FORMAT(order_delivered_customer_date, '%d/%m/%Y') 'Data entrega'
FROM sa_order
WHERE order_delivered_customer_date <= order_estimated_delivery_date;

SELECT COUNT(order_id) 'Pedidos entregues no prazo'
FROM sa_order
WHERE order_delivered_customer_date <= order_estimated_delivery_date;

# Pedidos Atrasados

SELECT order_id,
DATE_FORMAT(order_estimated_delivery_date, '%d/%m/%Y') 'Data estimada',
DATE_FORMAT(order_delivered_customer_date, '%d/%m/%Y') 'Data entrega'
FROM sa_order
WHERE order_delivered_customer_date > order_estimated_delivery_date;

SELECT COUNT(order_id) 'Total pedidos entregues fora do prazo'
FROM sa_order
WHERE order_delivered_customer_date > order_estimated_delivery_date;

SELECT 
    order_id, 
    DATE_FORMAT(order_estimated_delivery_date, '%d/%m/%Y') AS 'Data estimada', 
    DATE_FORMAT(order_delivered_customer_date, '%d/%m/%Y') AS 'Data entrega',
    DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) AS 'Dias atraso'
FROM sa_order
WHERE DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) >= 1
ORDER BY DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) DESC;

# Frete por Faixa de Valor do Pedido

SELECT
    CASE
        WHEN oi.price < 50 THEN 'Menos de R$50'
        WHEN oi.price BETWEEN 50 AND 100 THEN 'R$50 - R$100'
        WHEN oi.price BETWEEN 101 AND 200 THEN 'R$101 - R$200'
        ELSE 'Mais de R$200'
    END AS 'Faixa de Valor',
    CONCAT('R$ ', ROUND(AVG(oi.freight_value), 1)) 'Frete Médio'
FROM sa_order_items oi
GROUP BY 1
ORDER BY 2 DESC;

# Custo Médio do Frete

SELECT CONCAT('R$', FORMAT(AVG(freight_value), 2)) 'Custo médio frete'
FROM sa_order_items;

# Frete Médio por Estado

SELECT c.customer_state 'Estado', 
CONCAT('R$', FORMAT(AVG(oi.freight_value), 2)) 'Custo médio frete' 
FROM sa_order_items oi
INNER JOIN sa_order o
ON o.order_id = oi.order_id
INNER JOIN sa_customers c
ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY CONCAT('R$', FORMAT(AVG(oi.freight_value), 2)) DESC;

# Tempo Médio de Envio por Estado

SELECT c.customer_state 'Estado', 
ROUND(AVG(TIMESTAMPDIFF(HOUR, o.order_approved_at, o.order_delivered_carrier_date))) 'Média dias para envio'
FROM sa_order o
INNER JOIN sa_customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY ROUND(AVG(TIMESTAMPDIFF(HOUR, o.order_approved_at, o.order_delivered_carrier_date))) DESC;

# Tempo Médio de Entrega por Estado

SELECT 
    c.customer_state,
    AVG(DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp)) 'tempo_medio_entrega'
FROM tb_order o
JOIN tb_customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY tempo_medio_entrega DESC;

# Percentual de Pedidos Entregues no Prazo

SELECT 
    COUNT(CASE WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 1 END) * 100.0 
    / COUNT(*) AS percentual_no_prazo
FROM tb_order;


# INDICADORES GEOGRÁFICOS

# Estados com Mais Pedidos

SELECT c.customer_state 'Estado',
COUNT(o.order_id) 'Total Pedidos'
FROM sa_customers c
INNER JOIN sa_order o
ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY COUNT(o.order_id) DESC;

# Distribuição das Vendas por Cidade

SELECT c.customer_city 'Cidade',
COUNT(o.order_id) 'Total Vendas'
FROM sa_customers c
INNER JOIN sa_order o
ON c.customer_id = o.customer_id
GROUP BY c.customer_city
ORDER BY COUNT(o.order_id) DESC;

# Vendas por região do Brasil

SELECT
    CASE
        WHEN c.customer_state IN ('AM', 'RR', 'AP', 'PA', 'TO', 'RO', 'AC') THEN 'Norte'
        WHEN c.customer_state IN ('MA', 'PI', 'CE', 'RN', 'PB', 'PE', 'AL', 'SE', 'BA') THEN 'Nordeste'
        WHEN c.customer_state IN ('GO', 'MT', 'MS', 'DF') THEN 'Centro-Oeste'
        WHEN c.customer_state IN ('SP', 'RJ', 'MG', 'ES') THEN 'Sudeste'
        WHEN c.customer_state IN ('RS', 'SC', 'PR') THEN 'Sul'
        ELSE 'Outras'
    END AS 'Região',
    COUNT(o.order_id) AS 'Total Pedidos'
FROM sa_customers c
JOIN sa_order o ON c.customer_id = o.customer_id
GROUP BY 1
ORDER BY 2 DESC;

# Origem dos Vendedores

SELECT CONCAT(seller_city, ', ', seller_state) AS 'Origem',
COUNT(seller_id) AS 'Total'
FROM sa_seller
GROUP BY seller_city, seller_state
ORDER BY COUNT(seller_id) DESC;