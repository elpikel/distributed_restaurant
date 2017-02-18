defmodule Models.Order do
  use Timex

  defstruct [
    id: "",
    table_number: 0,
    order_items: [],
    time_to_cook: 0,
    tax: 0,
    total: 0,
    paid: false,
    expires_at: Timex.now]

  def init(table_number, order_items) do
    time_to_wait = Enum.random(1..10)
    expires_at = Timex.shift(Timex.now, seconds: time_to_wait)

    %Models.Order{
      id: UUID.uuid1(),
      table_number: table_number,
      order_items: order_items,
      expires_at: expires_at
    }
  end

  def add_time_to_cook(order, time_to_cook) do
    %Models.Order{order | time_to_cook: time_to_cook}
  end

  def add_calculations(order, tax, total) do
    %Models.Order{order | tax: tax, total: total, paid: true}
  end

  def is_expired(order) do
    if Timex.compare(Timex.now, order.expires_at) == 1 do
      true
    else
      false
    end
  end
end
