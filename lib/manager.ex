defmodule Manager do
  use GenServer

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def collect(order) do
    GenServer.cast(__MODULE__, {:collect, order})
  end

  def get_outstanding() do
    GenServer.call(__MODULE__, :get_outstanding)
  end

  def handle_cast({:collect, order}, orders) do
    orders = [order| orders]

    {:noreply, orders}
  end

  def handle_call(:get_outstanding, _caller, orders) do
    {:reply, orders, orders}
  end

  def init(state) do
    {:ok, state}
  end
end
