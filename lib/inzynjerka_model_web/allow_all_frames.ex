defmodule AllowAllFrames do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _default) do
    put_resp_header(conn, "x-frame-options", "ALLOWALL")
  end
end
