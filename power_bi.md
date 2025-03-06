# Processos realizados no Power BI

## Relacionamento das Tabelas
Validação e ajuste de relacionamento entre as Tabelas.

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

-**`PrazoEntrega`:** Coluna condicional para classificar a entrega como dentro do prazo, ou em atraso
  ```DAX
  PrazoEntrega = 
  IF(orders[order_delivered_customer_date] <= orders[order_estimated_delivery_date], "No Prazo", "Atraso")

- **`Regiao`:** Coluna condicional para classificar a região do país do cliente
  ```DAX
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

## Criação de Medidas

- **Ticket médio**
  ```DAX
  TicketMedio = DIVIDE([SomaPedidos], (COUNT(payments[order_id])))

- **Soma total dos pedidos**
  ```DAX
  SomaPedidos = SUM(payments[payment_value])
- **Taxa de cancelamento de pedidos**
  ```DAX
  TaxaCancelamento = 
  VAR TotalPedidos = COUNT(orders[order_id])
  VAR PedidosCancelados = CALCULATE(COUNT(orders[order_id]), orders[order_status] = "canceled")

  RETURN DIVIDE(PedidosCancelados, TotalPedidos, 0)

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
