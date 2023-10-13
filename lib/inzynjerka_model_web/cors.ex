defmodule InzynjerkaModelWeb.CORS do
  @moduledoc """
  This plug sets CORS headers.
  """

  import Plug.Conn

  def init(default), do: default

  def call(conn, _default) do
    conn
    |> put_resp_header("access-control-allow-origin", "*")
    |> put_resp_header("access-control-allow-methods", "*")
    |> put_resp_header("access-control-allow-headers", "*")
  end
end
