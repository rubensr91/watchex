defmodule Watchexs.FileWatcher do
  @moduledoc """
  File watcher is a gensever that see the change files in the
  watched_dirs folders.
  """
  require Logger

  use GenServer

  @watched_dirs Application.get_env(:watchexs, :watch_dirs)

  def start_link, do: GenServer.start_link(__MODULE__, [])

  def init(_) do
    {:ok, watcher_pid} = FileSystem.start_link(dirs: watched_dirs())

    FileSystem.subscribe(watcher_pid)

    {:ok, %{watcher_pid: watcher_pid}}
  end

  def handle_info({:file_event, watcher_pid, {path, _events}},
      %{watcher_pid: watcher_pid} = state) do
    reload_or_recompile(path)
    Logger.info "Reload project."
    {:noreply, state}
  end

  def handle_info({:file_event, watcher_pid, :stop},
      %{watcher_pid: watcher_pid} = state) do
    IO.puts "File watcher stopped."

    {:noreply, state}
  end

  def handle_info(data, state) do
    IO.puts "#{inspect data}"

    {:noreply, state}
  end

  defp watched_dirs do
    Mix.Project.deps_paths()
    |> Stream.flat_map(fn {_dep_name, dir} ->
      @watched_dirs
      |> Enum.map(fn watched_dir ->
        Path.join(dir, watched_dir)
      end)
    end)
    |> Stream.concat(@watched_dirs)
    |> Enum.filter(&File.dir?/1)
  end

  defp reload_or_recompile(path) do
    if File.exists?(path) do
      Code.compiler_options(ignore_module_conflict: true)
      Code.load_file(path)
    else
      IEx.Helpers.recompile()
    end
  end
end
