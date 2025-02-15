defmodule ImageFinder.DymanicSupervisor do
  use DynamicSupervisor

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def start_child(state) do
    spec = {ImageFinder.Downloader, state}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
