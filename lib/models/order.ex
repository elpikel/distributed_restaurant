defmodule Models.Order do
  defstruct [
    table_number: 0,
    order_items: [],
    time_to_cook: 0,
    tax: 0,
    total: 0,
    paid: false]

  def init(table_number, order_items) do
    %Models.Order{table_number: table_number, order_items: order_items}
  end

  def add_time_to_cook(order, time_to_cook) do
    %Models.Order{order | time_to_cook: time_to_cook}
  end

  def add_calculations(order, tax, total) do
    %Models.Order{order | tax: tax, total: total, paid: true}
  end
end
