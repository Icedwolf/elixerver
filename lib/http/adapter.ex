# lib/http/adapter.ex
defmodule Http.PlugAdapter do #Plugadapter for current_time.ex
  def dispatch(request, plug) do #pass to current_time.ex(plug)
    %Plug.Conn{
      adapter: {Http.PlugAdapter, request},
      owner: self()
    }
    |> plug.call([]) # call plug call function with the Plug.Conn
  end

  def send_resp(socket, status, headers, body) do
    response = "HTTP/1.1 #{status}\r\n#{headers(headers)}\r\n#{body}"

    Http.send_response(socket, response)
    {:ok, nil, socket}
  end

  def child_spec(plug: plug, port: port) do
    Http.child_spec(port: port, dispatch: &dispatch(&1, plug))
  end

  defp headers(headers) do
    Enum.reduce(headers, "",fn {key, value}, acc ->
      acc <> key <> ": " <> value <> "\n\r"
    end)
  end
end
