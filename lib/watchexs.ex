defmodule Watchexs do
  @moduledoc false

  use Application
  import Supervisor.Spec, warn: true

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: Watchexs.Supervisor]
    Supervisor.start_link(get_childrens(), opts)
  end

  defp get_childrens do
    [
      worker(Watchexs.FileWatcher, [])
    ]
  end
end
