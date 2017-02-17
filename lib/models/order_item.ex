defmodule Models.OrderItem do
  defstruct [name: "", quantity: 0]

  def init(name, quantity) do
    %Models.OrderItem{name: name, quantity: quantity}
  end
end
