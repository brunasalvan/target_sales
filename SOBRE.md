# Vendas Target

## Sobre

Este repositório contém uma análise de dados realizada a partir de um dataset de vendas da loja Target no Brasil. Foi realizado todo o processo de ETL (Extração, Transformação e Carga).
O Dataset está disponível [aqui](https://www.kaggle.com/datasets/devarajv88/target-dataset).

## Objetivo

O objetivo deste projeto é identificar fatores que impactam as vendas da Target no Brasil, como categorias de produtos, padrões de compras de clientes e o desempenho logístico. Através da análise desses dados, busco fornecer recomendações para otimizar o processo de vendas e aumentar o lucro, além de identificar oportunidades para melhorar a satisfação do cliente, ajustando a logística e campanhas direcionadas.

- Identificação de padrões de vendas
- Segmentação de clientes
- Eficiência logística

## Ferramentas

- Python (3.10.9)
- MySQL(8.0)
- Power BI (Desktop)

<h2>Problema</h2>

**Como otimizar as vendas da Target no Brasil, identificando padrões de consumo e segmentando clientes de acordo com suas preferências e comportamentos de compra?**

- Existem períodos específicos do ano em que as vendas são mais baixas?
- Quais categorias de produtos estão tendo o melhor desempenho e quais poderiam ser melhoradas?
- Existem oportunidades de melhorar as vendas em determinadas regiões ou cidades?
- Quais grupos de clientes estão comprando mais? Como a Target pode direcionar suas campanhas para esses grupos?
- A empresa está cumprindo os prazos de entrega estimados?
- Como a logística pode ser melhorada para reduzir custos e melhorar a experiência do cliente?
</details>

<details>
<summary><h2>Procedimentos</h2></summary>

#### Extração (Extract):
- Os dados foram extraídos de um arquivo .csv disponível no Kaggle.com, [aqui](https://www.kaggle.com/datasets/devarajv88/target-dataset).
#### Carga (Load)
- Utilizando Python, os dados foram carregados diretamente para o MySQL, onde as tabelas necessárias foram criadas.

-> [1_modelo_fisico.sql](https://github.com/brunasalvan/target_sales/blob/main/1_modelo_fisico.sql)

-> [2_python_importacao_tabelas.py](https://github.com/brunasalvan/target_sales/blob/main/2_python_importacao_tabelas)
#### Transformação (Transform):
- Dentro do MySQL foram feitas transformações para corrigir dados inconsistentes e faltantes, garantindo a qualidade da informação.

-> [3_limpeza_transformacao.sql](https://github.com/brunasalvan/target_sales/blob/main/3_limpeza_transformacao.sql)
#### Carga no Power BI:
- Após a transformação, os dados foram carregados no Power BI para visualização.

-> [target_dashboard.pdf](https://github.com/brunasalvan/target_sales/blob/main/target_dashboard.pdf)
#### Criação de Medidas DAX:
- No Power BI, medidas DAX foram criadas para permitir análises dinâmicas e aprofundadas dos dados, com base no script já realizado no MySQL.

-> [5_DAX_power_bi.md](https://github.com/brunasalvan/target_sales/blob/main/5_DAX_power_bi.md)
</details>

<details>
  <summary><h2>Análise</h2></summary>

### Principais indicadores

- Faturamento total: R$ 16.008.872;
- Número total de vendas: 99.441 pedidos;
- Ticket médio: R$ 154,10;
- Parcelamento médio: 2,85 vezes;
- Taxa de cancelamento: 0,63% (baixo, o que é positivo).

### Padrões de consumo e segmentação de clientes

- Segunda e terça-feira apresentam os maiores volumes de vendas;
- Sábado tem o menor volume, sugerindo que ações promocionais podem ser testadas nesse dia;
- Os picos de vendas ocorrem entre 10h e 16h, com o maior movimento às 16h;
- Baixo volume entre 0h e 6h, indicando que ações nesse período têm pouco impacto.

**Oportunidade**: Criar campanhas promocionais concentradas nos horários de pico e testar estratégias para aumentar vendas nas manhãs de segunda-feira.

### Produtos

**Categorias mais vendidas:**
- Cama Mesa e Banho (Bed, Table & Bath) 11.115 unidades;
- Saúde e Beleza (Health & Beauty) 9.670 unidades;
- Esporte e Lazer (Sport & Leisure) 8.641;
- Móveis (Furniture) 8.334;
- Computador e acessórios (Computers & Accessories) 7.827.

**Oportunidade**: Fortalecer estoques e campanhas para as categorias mais vendidas. Analisar categorias com baixa demanda e avaliar estratégias para impulsionar suas vendas.

### Análise geográfica

- Sudeste lidera os números, com 71.000 vendas (principalmente SP, RJ e MG);
- Sul tem 15.000 vendas;
- Nordeste e Centro-Oeste juntos somam 16.000 vendas, indicando potencial de crescimento;
- Norte tem o menor volume (2.000 vendas), o que pode estar relacionado a logística e frete elevado.

**Oportunidade**: Ampliar a presença no Nordeste e Norte, testando campanhas regionais e melhorando a logística. Avaliar estratégias para reduzir custos de frete e melhorar prazos de entrega nessas regiões.

### Logística e cumprimento de prazos

- Tempo médio de entrega: 12 dias;
- 92% das entregas dentro do prazo, mas 7,87% estão atrasadas.

**Estados com maior percentual de atrasos:**
- Alagoas (23%);
- Maranhão (18,88%);
- Piauí (15,35%).

**Oportunidade**: Revisar rotas e parceiros logísticos em estados críticos. Criar alertas internos para pedidos que ultrapassam 15 dias.

**Estados com o maior custo de frete:**
- Roraima (R$ 42,98);
- Paraíba (R$ 42,72);
- Rondônia (R$ 41,07).

**Oportunidade**: Avaliar alternativas logísticas e transportadoras regionais para reduzir custos nessas localidades.

</details>

<details>
<summary><h2>Respostas ao problema apresentado</h2></summary>

- Como otimizar as vendas, identificando padrões de consumo e segmentando clientes?

**Ações recomendadas:**

✔ Criar campanhas promocionais nos horários de pico (10h-16h).

✔ Testar descontos ou cupons no sábado, que tem menor volume de vendas.

✔ Segmentar clientes por região, priorizando o Nordeste e Norte para expansão.

### Existem períodos do ano com vendas mais baixas?

Sim. Os gráficos mostram quedas em março e junho. Dezembro e janeiro têm alta, indicando forte impacto do Natal e Ano Novo.

**Ação recomendada:**

✔ Criar campanhas sazonais para períodos de baixa.

### Quais categorias de produtos têm melhor desempenho e quais podem ser melhoradas?

Bed, Table & Bath, Health & Beauty e Sport & Leisure. Categorias com menor desempenho devem ser analisadas: Computadores & Acessórios e Eletrônicos podem ter baixa demanda ou preços pouco competitivos.

### Existem oportunidades de melhorar as vendas em determinadas regiões ou cidades?

Sim. O Sudeste é dominante, mas o Nordeste e Norte têm espaço para crescimento. O frete alto pode estar desestimulando vendas nessas regiões.

**Ação recomendada:**

✔ Reduzir frete e prazos de entrega para melhorar a conversão.

### Quais grupos de clientes estão comprando mais? Como direcionar campanhas?

Perfis de compra: 63,5% das compras estão entre R$ 101 e R$ 200. Poucas compras acima de R$ 200, indicando que produtos mais caros podem estar com barreiras de conversão.

**Ação recomendada:**

✔ Criar parcelamentos atrativos para incentivar compras acima de R$ 200.

### A empresa está cumprindo os prazos de entrega?

Parcialmente. 92% das entregas estão no prazo, mas 8% ainda atrasam. O tempo médio de atraso é alto em alguns estados (AP = 48 dias!).

**Ação recomendada:**

✔ Melhorar a logística nas regiões mais afetadas e revisar transportadoras.

### Como a logística pode ser melhorada para reduzir custos e melhorar a experiência do cliente?

Problemas identificados:
- Fretes altos no Norte e Nordeste. Altos índices de atraso em estados como AP e RR. 

**Ações recomendadas:**

✔ Parcerias com transportadoras regionais para reduzir custos.

✔ Implementação de um sistema de rastreamento mais eficiente.

</details>

<details>
<summary><h2>Conclusão</h2></summary>

Em resumo, essas são as oportunidades identificadas:

✔ Investir em campanhas promocionais estratégicas (melhores horários e sazonalidade).
 
✔ Melhorar a logística e reduzir custos de frete.

✔ Segmentar melhor os clientes por região e ticket médio.

✔ Ampliar a presença no Nordeste e Norte.

</details>
