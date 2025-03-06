USE db_target;

# Criação de uma Staging Area

CREATE TABLE sa_customers (SELECT * FROM tb_customers);
CREATE TABLE sa_geolocation (SELECT * FROM tb_geolocation);
CREATE TABLE sa_order (SELECT * FROM tb_order);
CREATE TABLE sa_order_items (SELECT * FROM tb_order_items);
CREATE TABLE sa_payments (SELECT * FROM tb_payments);
CREATE TABLE sa_products (SELECT * FROM tb_products);
CREATE TABLE sa_seller (SELECT * FROM tb_seller);

# Normalização de caracteres maiúsculos e minúsculos

UPDATE sa_customers
SET customer_city = CONCAT(
    UPPER(SUBSTRING(LOWER(customer_city), 1, 1)),
    SUBSTRING(LOWER(customer_city), 2)
);

UPDATE sa_geolocation
SET geolocation_city = CONCAT(
    UPPER(SUBSTRING(LOWER(geolocation_city), 1, 1)),
    SUBSTRING(LOWER(geolocation_city), 2)
);

UPDATE sa_products
SET product_category = CONCAT(
    UPPER(SUBSTRING(LOWER(product_category), 1, 1)),
    SUBSTRING(LOWER(product_category), 2)
);

UPDATE sa_seller
SET seller_city = CONCAT(
    UPPER(SUBSTRING(LOWER(seller_city), 1, 1)),
    SUBSTRING(LOWER(seller_city), 2)
);

# Caracteres especiais (sa_geolocation)

SELECT * FROM sa_geolocation;
SELECT DISTINCT geolocation_city FROM sa_geolocation;

# Ã­ | i
# Ã£ | a
# Ã§ | c
# Ã© | e
# Ã¡ | a
# Ã³ | o
# Ãº | u
# Ã¢ | a
# Ãµ | o
# Ã´| o
# Ãª | e

UPDATE sa_geolocation
SET geolocation_city = REPLACE(geolocation_city, 'Ã­', 'i')
WHERE geolocation_city LIKE '%Ã­%';

UPDATE sa_geolocation
SET geolocation_city = REPLACE(geolocation_city, 'Ã£', 'a')
WHERE geolocation_city LIKE '%Ã£%';

UPDATE sa_geolocation
SET geolocation_city = REPLACE(geolocation_city, 'Ã§', 'c')
WHERE geolocation_city LIKE '%Ã§%';

UPDATE sa_geolocation
SET geolocation_city = REPLACE(geolocation_city, 'Ã©', 'e')
WHERE geolocation_city LIKE '%Ã©%';

UPDATE sa_geolocation
SET geolocation_city = REPLACE(geolocation_city, 'Ã¡', 'a')
WHERE geolocation_city LIKE '%Ã¡%';

UPDATE sa_geolocation
SET geolocation_city = REPLACE(geolocation_city, 'Ã³', 'o')
WHERE geolocation_city LIKE '%Ã³%';

UPDATE sa_geolocation
SET geolocation_city = REPLACE(geolocation_city, 'Ãº', 'u')
WHERE geolocation_city LIKE '%Ãº%';

UPDATE sa_geolocation
SET geolocation_city = REPLACE(geolocation_city, 'Ã¢', 'a')
WHERE geolocation_city LIKE '%Ã¢%';

UPDATE sa_geolocation
SET geolocation_city = REPLACE(geolocation_city, 'Ãµ', 'o')
WHERE geolocation_city LIKE '%Ãµ%';

UPDATE sa_geolocation
SET geolocation_city = REPLACE(geolocation_city, 'Ã´', 'o')
WHERE geolocation_city LIKE '%Ã´%';

UPDATE sa_geolocation
SET geolocation_city = REPLACE(geolocation_city, 'Ãª', 'e')
WHERE geolocation_city LIKE '%Ãª%';

UPDATE sa_geolocation
SET geolocation_city = REPLACE(geolocation_city, '`', '')
WHERE geolocation_city LIKE '%`%';

UPDATE sa_geolocation
SET geolocation_city = REPLACE(geolocation_city, "'", "")
WHERE geolocation_city LIKE "%'%";

UPDATE sa_geolocation
SET geolocation_city = REPLACE(geolocation_city, 'd oeste', 'doeste')
WHERE geolocation_city LIKE '%d oeste%';

UPDATE sa_geolocation
SET geolocation_city = 'sao paulo'
WHERE geolocation_city IN ('sp','saopaulo','saÂ£o paulo');

UPDATE sa_geolocation
SET geolocation_city = 'penedo'
WHERE geolocation_city = 'penedo (itatiaia)';

UPDATE sa_geolocation
SET geolocation_city = 'guarulhos'
WHERE geolocation_city = 'guarulhos-sp';

UPDATE sa_geolocation
SET geolocation_city = 'sao bernardo do campo'
WHERE geolocation_city = 'sbcampo';

UPDATE sa_geolocation
SET geolocation_city = 'biritiba mirim'
WHERE geolocation_city = 'biritiba-mirim';

UPDATE sa_geolocation
SET geolocation_city = 'sao luiz do paraitinga'
WHERE geolocation_city = 'sao luis do paraitinga';

UPDATE sa_geolocation
SET geolocation_city = 'santa barbara doeste'
WHERE geolocation_city = 'santa barbara d oeste';

# Tabela sa_order (OK)

SELECT * FROM sa_order;
SELECT DISTINCT order_status FROM sa_order;

# Tabela sa_payments (OK)

SELECT * FROM sa_payments;
SELECT DISTINCT payment_type FROM sa_payments;

# Tabela sa_products

SELECT * FROM sa_products;
SELECT DISTINCT product_category, product_id FROM sa_products;

UPDATE sa_products
SET product_category = NULL
WHERE product_category = '';

# Tabela sa_seller

SELECT * FROM sa_seller;
SELECT DISTINCT seller_city, seller_state FROM sa_seller;
SELECT DISTINCT seller_state FROM sa_seller;

UPDATE sa_seller
SET seller_city = 'sao paulo'
WHERE seller_city IN ('sp', 'sao paulo - sp', 'sp / sp', 'sao paulo sp', 'sao paulo / sao paulo', 'sao paluo', 'sao paulop', 'sao pauo', 'saÌƒo paulo' );

UPDATE sa_seller
SET seller_city = 'sao bernardo do campo'
WHERE seller_city IN ('sbc/sp', 'sbc', 'sao bernardo do capo');

UPDATE sa_seller
SET seller_city = 'lages'
WHERE seller_city = 'lages - sc';

UPDATE sa_seller
SET seller_city = 'maua'
WHERE seller_city = 'maua/sao paulo';

UPDATE sa_seller
SET seller_city = 'mogi das cruzes'
WHERE seller_city IN ('mogi das cruses', 'mogi das cruzes / sp') ;

UPDATE sa_seller
SET seller_city = NULL
WHERE seller_city = '04482255';

UPDATE sa_seller
SET seller_city = 'rio de janeiro'
WHERE seller_city IN ('rio de janeiro / rio de janeiro', 'rio de janeiro \rio de janeiro', 'rio de janeiro, rio de janeiro, brasil', 'rio de janeiro \rio de janeiro');

UPDATE sa_seller
SET seller_city = 'barbacena'
WHERE seller_city = 'barbacena/ minas gerais';

UPDATE sa_seller
SET seller_city = 'ribeirao preto'
WHERE seller_city IN ('ribeirao preto / sao paulo', 'ribeirao pretp');

UPDATE sa_seller
SET seller_city = 'jacarei'
WHERE seller_city = 'jacarei / sao paulo';

UPDATE sa_seller
SET seller_city = 'carapicuiba'
WHERE seller_city = 'carapicuiba / sao paulo';

UPDATE sa_seller
SET seller_city = 'cariacica'
WHERE seller_city = 'cariacica / es';

UPDATE sa_seller
SET seller_city = 'cascavel'
WHERE seller_city = 'cascavael';

UPDATE sa_seller
SET seller_city = 'taboao da serra'
WHERE seller_city = 'tabao da serra';

UPDATE sa_seller
SET seller_city = "sao miguel do oeste"
WHERE seller_city = "sao miguel d'oeste";

UPDATE sa_seller
SET seller_city = 'sao jose dos pinhais'
WHERE seller_city = 'sao jose dos pinhas';

UPDATE sa_seller
SET seller_city = 'sao jose do rio preto'
WHERE seller_city IN ('sao jose do rio pret', 's jose do rio preto');

UPDATE sa_seller
SET seller_city = 'santo andre'
WHERE seller_city IN ('santo andre/sao paulo', 'sando andre');

UPDATE sa_seller
SET seller_city = "santa barbara doeste"
WHERE seller_city IN ("santa barbara d oeste", "santa barbara d'oeste", "santa barbara dÂ´oeste");

UPDATE sa_seller
SET seller_city = 'belo horizonte'
WHERE seller_city = ('belo horizont');

UPDATE sa_seller
SET seller_city = 'sao jose do rio pardo'
WHERE seller_city = 'scao jose do rio pardo';

UPDATE sa_seller
SET seller_city = 'balneario camboriu'
WHERE seller_city = 'balenario camboriu';

# Valores em branco para NULL

SELECT product_category
FROM sa_products
WHERE product_category IS NULL;

SELECT DISTINCT product_category, product_id
FROM sa_products;

UPDATE sa_products
SET product_category = NULL
WHERE product_id IN (
    '017457b0013d01d5a5a4a020ed1f14b9',
    '0103863bf3441460142ec23c74388e4c',
    '00ab8a8b9fe219511dc3f178c6d79698',
    '0082684bb4a60a862baaf7a60a5845ed',
    '05f581382fca988fec41f4a3de0e0fda',
    '05feccd482d35726d6f80e60df25db86',
    '06ddfdf210c7e0259854ee543215088d',
    '05cf9ac595f28386ee763c98cbc2bad0',
    '0538b3ea14af3cc3ee6bdaf940367cee',
    '0533c5ec3a042521493cfb6e12d6befd',
    '0502d1a36be75bd36b452f31c6ed264a',
    '04f8b8f9921310178d65bcba23fbe639',
    '03706dca83513062fe74967a71b5fc78',
    '036a6272d538ae862d248339c4c9adeb',
    '033fe931444d66d788d53aca5b7b22d5',
    '0292b46c30348496b1be04eeb440bdb5',
    '014fcf6bd5cd4c7ee29fb3bb618c445e',
    '00d62b338366db4c4aec8547ea8f928e'
);