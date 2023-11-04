defmodule InzynjerkaModelWeb.AllowAllFrames do
  @moduledoc """
  Accepts frames from localhost:4000.
  """
  import Plug.Conn

  def init(default), do: default

  def call(conn, _opts) do
    conn
    |> put_resp_header("x-frame-options", "ALLOW-FROM http://localhost:4000")
    |> put_resp_header("Content-Security-Policy", "frame-ancestors http://localhost:4000")
  end
end
