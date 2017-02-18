defmodule Kitchen do
  use GenServer
  @name :Kitchen

  def start_link(state \\ []) do
    IO.puts "Starting #{__MODULE__}..."
    GenServer.start_link(__MODULE__, state, name: @name)
  end

  def init(state) do
    cooks = start_cooks

    {:ok, {cooks, -1}}
  end

  def start_cooks do
    for index <- 0..2, into: Map.new do
      {:ok, pid} = Cook.start_link
      {index, pid}
    end
  end

  def prepare_meal(order) do
    GenServer.cast(@name, {:prepare_meal, order})
  end

  def handle_cast({:prepare_meal, order}, {cooks, last_started}) do
    cook_no = rem((last_started + 1), 3)

    cook = Map.get(cooks, cook_no)

    IO.inspect Process.info(cook, :message_queue_len)

    Cook.prepare_meal(cook, order)
    {:noreply, {cooks, cook_no}}
  end
end
