defmodule Watchexs.GenserverTest do
  @moduledoc false
  require Logger

  use GenServer

  def start_link, do: GenServer.start_link(__MODULE__, [])

  def init(_) do
    {:ok, %{}, 1000}
  end

  def handle_info(:timeout, state) do
    {:noreply, state, 1000}
  end
end
