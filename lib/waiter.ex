defmodule Waiter do
  use GenServer

  def take_order(table_number, order_items) do
    IO.puts "took order"
    order = Models.Order.init(table_number, order_items)
    GenServer.cast(__MODULE__, {:take_order, order})
  end

  def handle_cast({:take_order, new_order}, last_order) do
    Kitchen.prepare_meal(new_order)
    {:noreply, new_order}
  end

  def start_link(state \\ []) do
    IO.puts "Starting #{__MODULE__}..."
    GenServer.start_link(__MODULE__, state, name: :waiter)
  end

  def init(state), do: {:ok, state}
end
