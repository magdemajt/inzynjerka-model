defmodule InzynjerkaModelWeb.AuthController do
  use InzynjerkaModelWeb, :controller


  defp maybe_halt(true, conn), do: conn

  defp maybe_halt(_any, conn) do
    # TODO: figure out a better way to handle this
    conn
    |> put_status(401)
    |> Controller.json(%{error: %{status: 401, message: "Unauthorized access"}})
    |> halt()
  end

  def get_config(key), do: Application.get_env(:inzynjerka_model) |> Map.fetch(key)

  def is_admin(token) do
    secret = get_config(:role_service_secret)
    role_service_url = get_config(:role_service_url)
    HTTPoison.get(role_service_url, %{"authorization" => token, "secret" => secret}) |> case do
      {:ok, %HTTPoison.Response{status_code: 200, body: %{ role: role }}} -> role == :admin
      _other -> false
    end
  end

  def ensure_admin(conn) do
    auth_token = Conn.get_req_header(conn, "authorization") |> is_admin |> maybe_halt(conn)
  end
end
