# Processos realizados no Power BI

## Relacionamento das Tabelas
Validação e ajuste de relacionamento entre as Tabelas.

## Criação da Tabela Calendário
Para trabalhar com dados temporais de forma eficiente.
  ```DAX
  Calendario = 
  VAR Data_Inicial = DATE(2016, 1, 1)
  VAR Data_Final = DATE(2018, 12, 31)
  RETURN
    ADDCOLUMNS (
        CALENDAR (Data_Inicial, Data_Final), 
        "Ano", YEAR([Date]),
        "Mês", MONTH([Date]),
        "Trimestre", QUARTER([Date]),
        "Dia", DAY([Date]),
        "Dia da Semana", FORMAT([Date], "dddd"),
        "Nome do Mês", FORMAT([Date], "mmmm"),
        "Ano-Mês", FORMAT([Date], "YYYY-MM"),
        "Semana do Ano", WEEKNUM([Date], 2)
    )
```
## Criação de Colunas
Criação de novas colunas:

- **`DiaSemana`:** Extrai o dia da semana da compra a partir da coluna de data e hora da compra:
  ```DAX
  DiaSemana = FORMAT(orders[order_purchase_timestamp], "dddd")

- **`HoraCompra`:** Extrai a hora da compra a partir da coluna de data e hora da compra:
  ```DAX
  HoraCompra = HOUR('orders'[order_purchase_timestamp])

- **`TotalVendas`:** Faz a contagem de vendas para cada vendedor
  ```DAX
  TotalVendas = COUNTROWS(RELATEDTABLE(order_items))

- **`FaixaValor`:** Coluna condicional para classificar o valor de cada pedido por faixas (Menos de R$50, R$50 - R$100, R$101 - R$200 e Mais de R$200)
  ```DAX
  FaixaValor = 
    IF(payments[payment_value] < 50, "Menos de R$50",
        IF(payments[payment_value] <= 100, "R$50 - R$100",
            IF(payments[payment_value] <= 200, "R$101 - R$200", "Mais de R$200")
        )
    )

- **`FaixaValorProduto`:** Coluna condicional para classificar o valor de cada produto por faixas (Menos de R$50, R$50 - R$100, R$101 - R$200 e Mais de R$200)
  ```DAX
    SWITCH(
        TRUE(),
        order_items[price] < 50, "Menos de R$50",
        order_items[price] >= 50 && order_items[price] <= 100, "R$50 - R$100",
        order_items[price] >= 101 && order_items[price] <= 200, "R$101 - R$200",
        "Mais de R$200"
      );

- **`PrazoEntrega`:** Coluna condicional para classificar a entrega como dentro do prazo, ou em atraso
  ```DAX
  PrazoEntrega = 
  IF(orders[order_delivered_customer_date] <= orders[order_estimated_delivery_date], "No Prazo", "Atraso")


  Regiao = 
  SWITCH(
    TRUE(),
    customers[customer_state] IN {"AM", "RR", "AP", "PA", "TO", "RO", "AC"}, "Norte",
    customers[customer_state] IN {"MA", "PI", "CE", "RN", "PB", "PE", "AL", "SE", "BA"}, "Nordeste",
    customers[customer_state] IN {"GO", "MT", "MS", "DF"}, "Centro-Oeste",
    customers[customer_state] IN {"SP", "RJ", "MG", "ES"}, "Sudeste",
    customers[customer_state] IN {"RS", "SC", "PR"}, "Sul",
    "Desconhecido"
  )

- **`FaturamentoVendedor`:** Coluna que retorna o valor total de faturamento para cada vendedor
  ```DAX
  FaturamentoVendedor = 
  VAR TotalVendas = 
    SUMX(
        RELATEDTABLE('order_items'), 
        CALCULATE(
            SUM('payments'[payment_value])
        )
    )
  RETURN 
    TotalVendas

- **`Nome`:** Coluna para inserir o nome dos principais vendedores presentes no dashboard
  ```DAX
  Nome = 
  SWITCH(
    'sellers'[seller_id],
    "1025f0e2d44d7041d6cf58b6550e0bfa", "Fernando Torres",
    "4a3ca9315b744ce9f8e9374361493884", "Gilberto Santos",
    "7c67e1448b00f6e969d365cea6b010ab", "Cintia Lagos",
    "25be943a321c8938947bdaabca979a90", "Gisele Ramos",
    "7c67e1448b00f6e969d365cea6b010ab", "Humberto Neves",
    "4869f7a5dfa277a7dca6462dcf3b52b2", "Carlos Nascimento",
    "53243585a1d6dc2643021fd1853d8905", "Claudia Alves",
    BLANK()
  )
  
- **`FotoVendedor`:** Coluna para inserir a URL da foto da vendedora do mês
  ```DAX
  FotoVendedor = 
  SWITCH(
    'sellers'[seller_id],
    "25be943a321c8938947bdaabca979a90", "https://www.olhodigital.com.br/wp-content/uploads/2023/03/foto_cracha02b.fw_.png",
    BLANK()
  )

## Criação de Medidas

- **Número total de pedidos**
  ```DAX
  TotalVendas = COUNT(orders[order_id])
  
- **Faturamento total**
  ```DAX
  Faturamento = SUM(payments[payment_value])

- **Ticket médio**
  ```DAX
  TicketMedio = DIVIDE([Faturamento], (COUNT(payments[order_id])))

- **Taxa de cancelamento de pedidos**
  ```DAX
  TaxaCancelamento = 
  VAR TotalVendas = COUNT(orders[order_id])
  VAR PedidosCancelados = CALCULATE(COUNT(orders[order_id]), orders[order_status] = "canceled")

  RETURN DIVIDE(PedidosCancelados, TotalVendas, 0)

- **Parcelamento médio dos pedidos**
  ```DAX
  ParcelamentoMedio = AVERAGE(payments[payment_installments])

- **Tempo médio de aprovação dos pedidos**
  ```DAX
  TempoAprovacao = 
  VAR TempoEmHoras = AVERAGEX(
    FILTER(
        orders, 
        NOT(ISBLANK(orders[order_approved_at]))  -- Filtra apenas pedidos com aprovação
    ),
    DATEDIFF(
        orders[order_purchase_timestamp], 
        orders[order_approved_at], 
        HOUR
    )
  )
  RETURN
    FORMAT(TempoEmHoras, "0") & " h"

- **Tempo médio de entrega dos pedidos**
  ```DAX
  TempoEntrega = 
  VAR TempoEmDias = AVERAGEX(
    FILTER(
        orders, 
        NOT(ISBLANK(orders[order_delivered_customer_date]))  -- Filtra apenas pedidos com aprovação
    ),
    DATEDIFF(
        orders[order_purchase_timestamp], 
        orders[order_delivered_customer_date], 
        DAY
    )
  )
  RETURN
    FORMAT(TempoEmDias, "0") & " d"

- **Total de pedidos atrasados**
  ```DAX
  PedidosAtrasados = 
  CALCULATE(
    COUNT(orders[PrazoEntrega]),
    orders[PrazoEntrega] = "Atraso"
  )
  
- **Total de pedidos no prazo**
  ```DAX
  PedidosNoPrazo = 
  CALCULATE(
    COUNT(orders[PrazoEntrega]),
    orders[PrazoEntrega] = "No Prazo"
  )

- **Frete médio**
  ```DAX
  FreteMedio = AVERAGE(order_items[freight_value])

- **Faturamento do mês de agosto de 2018 para cada vendedor (último mês ativo da base de dados)**
  ```DAX
  FaturamentoVendedorAgosto2018 = 
  VAR TotalVendas = 
    SUMX(
        RELATEDTABLE('order_items'), 
        CALCULATE(
            SUM('payments'[payment_value]),
            YEAR('orders'[order_purchase_timestamp]) = 2018,
            MONTH('orders'[order_purchase_timestamp]) = 8
        )
    )
  RETURN 
    TotalVendas

- **Percentual de entregas fora do prazo**
  ```DAX
  PercentualEntregasForaDoPrazo = 
  VAR TotalPedidos = COUNT( orders[order_id] )
  VAR PedidosforaPrazo = 
    CALCULATE(
        COUNT( orders[order_id] ),
        orders[order_delivered_customer_date] > orders[order_estimated_delivery_date]
    )
  RETURN 
    DIVIDE( PedidosforaPrazo, TotalPedidos, 0 ) * 100

- **Percentual de entregas dentro do prazo**
  ```DAX
  PercentualEntregasNoPrazo = 
  VAR TotalPedidos = COUNT( orders[order_id] )
  VAR PedidosNoPrazo = 
    CALCULATE(
        COUNT( orders[order_id] ),
        orders[order_delivered_customer_date] <= orders[order_estimated_delivery_date]
    )
  RETURN 
    DIVIDE( PedidosNoPrazo, TotalPedidos, 0 ) * 100
