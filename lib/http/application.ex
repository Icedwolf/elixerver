defmodule Http.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    children = [
      {Http.PlugAdapter, plug: CurrentTime, port: 8080} #start the adapter with the plug
    ]

    opts = [strategy: :one_for_one, name: Http.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
