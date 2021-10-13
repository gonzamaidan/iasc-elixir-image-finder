#ImageFinder.fetch "sample.txt", "out"
#ImageFinder.fetch "sample2.txt", "out"
defmodule ImageFinder.Downloader do
  use GenServer, restart: :transient

  def start_link(state) do
    {:ok, pid} = GenServer.start_link(__MODULE__, state)
    GenServer.cast(pid, :fetch_link)
    {:ok, pid}
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast(:fetch_link, {link, target_directory}) do
    IO.puts(:stdio, link)
    fetch_link(link, target_directory)
    {:stop, :normal, {link, target_directory}}
  end

  # def fetch_link(nil, _target_directory) do

  # end

  def fetch_link(link, target_directory) do
    HTTPotion.get(link).body  |> save(target_directory)
  end

  def digest(body) do
    :crypto.hash(:md5 , body) |> Base.encode16()
  end

  def save(body, directory) do
    File.write! "#{directory}/#{digest(body)}.png", body
  end


end
