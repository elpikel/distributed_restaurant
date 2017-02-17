defmodule OrderTest do
  use ExUnit.Case
  doctest Models.Order

  test "can create order" do
    order = Models.Order.init(3, [Models.OrderItem.init("pizza", 2)])

    assert order.table_number == 3
    assert Enum.at(order.order_items, 0).quantity == 2
    assert Enum.at(order.order_items, 0).name == "pizza"
  end

  test "can add cook time" do
    order = Models.Order.init(3, [Models.OrderItem.init("pizza", 2)])
    order = Models.Order.add_time_to_cook(order, 2000)

    assert order.time_to_cook == 2000
  end

  test "can add calculations" do
    order = Models.Order.init(3, [Models.OrderItem.init("pizza", 2)])
    order = Models.Order.add_calculations(order, 15, 33)

    assert order.tax == 15
    assert order.total == 33
  end
end
