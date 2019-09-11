# lib/current_time.ex
defmodule CurrentTime do
  import Plug.Conn

  def init(options), do: options #one liner do: no end

  def call(conn, _opts) do # call/2 
    conn # takes the passed %Plug.Conn struct
    |> put_resp_content_type("text/html") # set the response type to "text/html"
    |> send_resp(200, "Hello world! the time is #{Time.to_string(Time.utc_now())}") # send the current time
  end
end
