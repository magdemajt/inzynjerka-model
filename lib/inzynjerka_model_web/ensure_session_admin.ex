defmodule MyAppWeb.Plugs.EnsureSessionAdmin do
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2, halt: 1]

  alias Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    token = get_session(conn, :token)
    if token do
      InzynjerkaModelWeb.AuthController.is_admin(token) |> case do
        true -> conn
        _other -> conn
                |> put_flash(:error, "You must be logged in to access that page")
                |> redirect(to: "/")
                |> halt()
      end
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: "/")
      |> halt()
    end
  end
end
