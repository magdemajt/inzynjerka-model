defmodule InzynjerkaModelWeb.EnsureQueryParamGuest do
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2, halt: 1]

  alias Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    params = fetch_query_params(conn)
    token = params.params["token"]
    if token do
      InzynjerkaModelWeb.AuthController.is_admin(token) |> case do
        false -> conn
        _other -> conn
                |> redirect(to: "/home")
                |> halt()
      end
    else
      conn
    end
  end
end
