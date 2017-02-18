defmodule DistributedRestaurant do
  @moduledoc """
  Documentation for DistributedRestaurant.
  """

  @doc """
  Hello world.

  ## Examples

      iex> DistributedRestaurant.hello
      :world
  Restaurant.Supervisor.start_link
  for n <- 1..200, do: Waiter.take_order(1, Models.OrderItem.init("pizza", 2))
  Manager.get_outstanding
  """
  def hello do
    :world
  end
end
