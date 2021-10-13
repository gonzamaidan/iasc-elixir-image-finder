defmodule ImageFinder.Reader do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:read, source_file, worker}, _from, state) do
    source_file
      |> File.stream!()
      |> Stream.map(IO.puts/1)

    # regexp = ~r/http(s?)\:.*?\.(png|jpg|gif)/
    # Regex.scan(regexp, content)
    #   |> Enum.map(&List.first/1)
    #   |> Enum.map(&(fetch_link &1, target_directory))
    {:no_reply}
  end


end
