defmodule Cashier do
  use GenServer

  def start_link(state \\ []) do
    IO.puts "Starting #{__MODULE__}..."
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def pay(order) do
    IO.puts "cashing"
    order = Models.Order.add_calculations(order, 15, 99)
    GenServer.cast(__MODULE__, {:pay, order})
  end

  def handle_cast({:pay, new_order}, old_order) do
    IO.puts "cashed"
    Manager.collect(new_order)

    {:noreply, new_order}
  end

  def init(state) do
    {:ok, state}
  end
end
