defmodule DistributedRestaurant do
  @moduledoc """
  Documentation for DistributedRestaurant.
  """

  @doc """
  Hello world.

  ## Examples

      iex> DistributedRestaurant.hello
      :world
  Waiter.start_link
  Cook.start_link
  Cashier.start_link
  Waiter.take_order(1, Models.OrderItem.init("pizza", 2))
  """
  def hello do
    :world
  end
end
