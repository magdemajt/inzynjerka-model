defmodule InzynjerkaModelWeb.AllowAllFrames do
  @moduledoc """
  Accepts x-frames from localhost:3000.
  """
  import Plug.Conn


  def init(default), do: default

  def call(conn, _opts) do
    put_resp_header(conn,"x-frame-options","ALLOW-FROM http://localhost:3000")
  end
end
