# Processos realizados no Power BI

## Relacionamento das Tabelas
Validação e ajuste de relacionamento entre as Tabelas.

## Criação de Colunas
Criação de novas colunas:

- **Coluna `diaSemana`**: Extrai o dia da semana da compra a partir da coluna de data e hora da compra:
  ```DAX
  diaSemana = FORMAT(orders[order_purchase_timestamp], "dddd")
- **Coluna `horaCompra`**: Extrai a hora da compra a partir da coluna de data e hora da compra:
  ```DAX
  horaCompra = HOUR('orders'[order_purchase_timestamp])
- **Coluna `horaCompra`**: Extrai a hora da compra a partir da coluna de data e hora da compra:
  ```DAX
  horaCompra = HOUR('orders'[order_purchase_timestamp])

## Criação de Medidas

- **Taxa de cancelamento de pedidos**
  ```DAX
  taxaCancelamento = 
  VAR TotalPedidos = COUNT(orders[order_id])
  VAR PedidosCancelados = CALCULATE(COUNT(orders[order_id]), orders[order_status] = "canceled")

  RETURN DIVIDE(PedidosCancelados, TotalPedidos, 0)
