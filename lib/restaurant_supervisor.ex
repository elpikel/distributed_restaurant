defmodule Restaurant.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, nil)
  end

  def init(_) do
    process = [
      worker(Kitchen, []),
      worker(Waiter, []),
      worker(Cashier, []),
      worker(Manager, [])
    ]
    supervise(process, strategy: :one_for_one)
  end
end
