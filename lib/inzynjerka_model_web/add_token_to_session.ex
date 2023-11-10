defmodule InzynjerkaModelWeb.AddTokenToSession do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _opts) do
    params = fetch_query_params(conn)
    token = params.params["token"]
    if token do
      conn = put_session(conn, :token, token)
    end
    conn
  end
end
