defmodule Cook do
  use GenServer

  def start_link(cook_id) do
    IO.puts "Starting #{__MODULE__}-#{cook_id}..."
    GenServer.start_link(
      __MODULE__, cook_id,
      name: via_tuple(cook_id)
    )
  end

  def prepare_meal(cook_id, order) do
    cond do
      Models.Order.is_expired(order) ->
        IO.puts "dropping order"
      true ->
        IO.puts "starting meal preparation"
        :timer.sleep(1000)
        order = Models.Order.add_time_to_cook(order, 2000)

        GenServer.cast(via_tuple(cook_id), {:prepare_meal, order})
    end
  end

  def handle_cast({:prepare_meal, new_order}, _last_order) do
    IO.puts "meal prepared"
    Cashier.pay(new_order)

    {:noreply, new_order}
  end

  def init(state) do
    {:ok, state}
  end

  defp via_tuple(cook_id) do
    {:via, :gproc, {:n, :l, {:cook, cook_id}}}
  end
end
