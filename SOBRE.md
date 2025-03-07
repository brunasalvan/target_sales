# Vendas Target

## Sobre

Este repositório contém uma análise de dados realizada a partir de um dataset de vendas da loja Target no Brasil. Foi realizado todo o processo de ETL (Extração, Transformação e Carga).
O Dataset está disponível [aqui](https://www.kaggle.com/datasets/devarajv88/target-dataset).

## Objetivo

O objetivo deste projeto é identificar fatores que impactam as vendas da Target no Brasil, como categorias de produtos, padrões de compras de clientes e o desempenho logístico. Através da análise desses dados, busco fornecer recomendações para otimizar o processo de vendas e aumentar o lucro, além de identificar oportunidades para melhorar a satisfação do cliente, ajustando a logística e campanhas direcionadas.

- Identificação de padrões de vendas
- Segmentação de clientes
- Eficiência logística

## Problema

Como otimizar as vendas da Target no Brasil, identificando padrões de consumo e segmentando clientes de acordo com suas preferências e comportamentos de compra?

- Existem períodos específicos do ano em que as vendas são mais baixas?
- Quais categorias de produtos estão tendo o melhor desempenho e quais poderiam ser melhoradas?
- Existem oportunidades de melhorar as vendas em determinadas regiões ou cidades?
- Quais grupos de clientes estão comprando mais? Como a Target pode direcionar suas campanhas para esses grupos?
- A empresa está cumprindo os prazos de entrega estimados?
- Como a logística pode ser melhorada para reduzir custos e melhorar a experiência do cliente?

## Ferramentas

- Python (3.10.9)
- MySQL(8.0)
- Power BI (Desktop)

## Procedimentos

#### Extração (Extract):
- Os dados foram extraídos de um arquivo .csv disponível no Kaggle.com.
#### Carga (Load)
- Utilizando Python, os dados foram carregados diretamente para o MySQL, onde as tabelas necessárias foram criadas.
#### Transformação (Transform):
- Dentro do MySQL foram feitas transformações para corrigir dados inconsistentes e faltantes, garantindo a qualidade da informação.
#### Carga no Power BI:
- Após a transformação, os dados foram carregados no Power BI para visualização.
#### Criação de Medidas DAX:
- No Power BI, medidas DAX foram criadas para permitir análises dinâmicas e aprofundadas dos dados, com base no script já realizado no MySQL.

## Conclusões
