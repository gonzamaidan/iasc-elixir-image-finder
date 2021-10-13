defmodule ImageFinder.Worker do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:fetch, source_file, target_directory}, _from, state) do
    regexp = ~r/http(s?)\:.*?\.(png|jpg|gif)/
    source_file
      |> File.stream!()
      |> Stream.map(&(Regex.scan(regexp, &1)))
      # |> Enum.map(&List.first/1)
      |> Enum.map(&List.first/1)
      |> Enum.map(&(start_download(&1, target_directory)))

    {:reply, :ok, state}
  end

  def start_download(link, target_directory) do
    ImageFinder.DymanicSupervisor.start_child({link, target_directory})
    # GenServer.cast(pid, {:fetch_link, link, target_directory})
  end

end
