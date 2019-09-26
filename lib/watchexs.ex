defmodule Watchexs do
  @moduledoc """

  """

  # alias Cortex.{FileWatcher, Controller, Reloader, TestRunner}

  use Application
  import Supervisor.Spec, warn: true
  def start(_type, _args) do
    # cond do
    #   Mix.env in [:dev, :test] ->
    #     children =
    #       if enabled?() do
    #         children()
    #       else
    #         []
    #       end
    children =
      [
        worker(Watchexs.FileWatcher, [])
      ]

  opts = [strategy: :one_for_one, name: Watchexs.Supervisor]
  Supervisor.start_link(children, opts)
    # Supervisor.start_link(children(), strategy: :one_for_one, name: Watchex.Supervisor)

    #   true ->
    #     {:error, "Only :dev and :test environments are allowed"}
    # end
  end

  # defp children do
  #   import Supervisor.Spec, warn: false

  #   children = [
  #     worker(Watchexs.FileWatcher, [])
  #     # worker(Reloader, []),
  #     # worker(Controller, [])
  #   ]

  #   # env_specific_children =
  #   #   case Mix.env do
  #   #     :dev ->
  #   #       []
  #   #     :test ->
  #   #       [worker(TestRunner, [])]
  #   #   end

  #   # children ++ env_specific_children
  #   children
  # end

  # # defp enabled? do
  # #   case Application.get_env(:cortex, :enabled, true) do
  # #     bool when is_boolean(bool) ->
  #       bool
  #     {:system, env_var, default} ->
  #       get_system_var(env_var, default)
  #     invalid ->
  #       raise "Invalid config value for watchex `:enabled`: #{inspect invalid}"
  #   end
  # end

  # defp get_system_var(env_var, default) do
  #   case System.get_env(env_var) do
  #     nil ->
  #       default
  #     truthy when truthy in ["YES", "yes", "true", "TRUE", "1"] ->
  #       true
  #     falsey when falsey in ["NO", "no", "false", "FALSE", "0"] ->
  #       false
  #     _ ->
  #       raise "Unparsable watchex Environment Variable '#{env_var}'"
  #   end
  # end
end
