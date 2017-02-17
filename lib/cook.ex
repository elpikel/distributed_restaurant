defmodule Cook do
  use GenServer

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def prepare_meal(order) do
    IO.puts "starting meal preparation"
    order = Models.Order.add_time_to_cook(order, 2000)

    GenServer.cast(__MODULE__, {:prepare_meal, order})
  end

  def handle_cast({:prepare_meal, new_order}, last_order) do
    IO.puts "meal prepared"
    Cashier.pay(new_order)

    {:noreply, new_order}
  end

  def init(state) do
    {:ok, state}
  end
end
