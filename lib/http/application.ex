# lib/http/application.ex
defmodule Http.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    children = [
      {Http.PlugAdapter, plug: CurrentTime, port: 8080}
    ]

    opts = [strategy: :one_for_one, name: Http.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
