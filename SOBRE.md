# Vendas Target

## Sobre

Este repositório contém uma análise de dados realizada a partir de um dataset de vendas da loja Target no Brasil. Foi realizado todo o processo de ETL (Extração, Transformação e Carga).
O Dataset está disponível [aqui](https://www.kaggle.com/datasets/devarajv88/target-dataset).

## Objetivo

Analisar as vendas da Target no Brasil e extrair insights que buscam otimizar os processos e aumentar o lucro da empresa de modo geral.

## Ferramentas

- Python (3.10.9)
- MySQL(8.0)
- Power BI (Desktop)

## Problema

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
