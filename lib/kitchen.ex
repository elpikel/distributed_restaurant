defmodule Kitchen do
  use GenServer
  @name :Kitchen
  @pool_size 3

  def start_link(state \\ []) do
    IO.puts "Starting #{__MODULE__}..."
    GenServer.start_link(__MODULE__, state, name: @name)
    CooksSupervisor.start_link(@pool_size)
  end

  def init(_state) do
    {:ok, {-1, []}}
  end

  def prepare_meal(order) do
    GenServer.cast(@name, {:prepare_meal, order})
  end

  def handle_cast({:prepare_meal, order}, {last_started, orders}) do
    cook = choose_cook(last_started)

    cond do
      Enum.any?(orders, fn(o) -> o.id == order.id end) ->
        IO.puts "order already handled #{order.id}"
      true ->
        Cook.prepare_meal(cook, order)
        orders = [order | orders]
    end

    {:noreply, {cook, orders}}
  end

  defp choose_cook(last_started) do
    rem((last_started + 1), 3)
  end
end
