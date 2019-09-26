defmodule Watchexs do
  @moduledoc """

  """

  use Application
  import Supervisor.Spec, warn: true
  def start(_type, _args) do
    children =
      [
        worker(Watchexs.FileWatcher, [])
      ]

    opts = [strategy: :one_for_one, name: Watchexs.Supervisor]
    Supervisor.start_link(children, opts)

  end

end
