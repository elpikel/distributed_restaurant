defmodule Waiter do
  use GenServer
  @name :Waiter

  def take_order(table_number, order_items) do
    IO.puts "took order"
    order = Models.Order.init(table_number, order_items)
    chances = Enum.random(1..10)

    cond do
      chances > 8 ->
        GenServer.cast(@name, {:take_order, order})
        GenServer.cast(@name, {:take_order, order})
      true ->
        GenServer.cast(@name, {:take_order, order})
    end
  end

  def handle_cast({:take_order, new_order}, _last_order) do
    Kitchen.prepare_meal(new_order)
    {:noreply, new_order}
  end

  def start_link(state \\ []) do
    IO.puts "Starting #{__MODULE__}..."
    GenServer.start_link(__MODULE__, state, name: @name)
  end

  def init(state), do: {:ok, state}
end
