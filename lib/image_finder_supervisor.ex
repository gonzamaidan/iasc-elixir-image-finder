defmodule ImageFinder.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      {ImageFinder.Worker, ImageFinder.Worker},
      {ImageFinder.DymanicSupervisor, ImageFinder.DymanicSupervisor}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
