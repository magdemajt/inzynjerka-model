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

  def get_config(key), do: Application.get_env(:inzynjerka_model, key)

  def is_admin(nil), do: false

  def is_admin(token) do
    role_service_url = get_config(:role_service_url)
    response = HTTPoison.get(role_service_url, [{"Authorization", token}])
    response |> case do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body |> Jason.decode |> case do
          {:ok, parsed} -> Map.get(parsed, "data") |> Map.get("role") |> Kernel.==("admin")
          _other -> false
        end
      _other -> false
    end
  end


  def ensure_admin('token', token) do
    auth_token = token |> is_admin
  end

  def ensure_admin('conn', conn) do

    auth_token = Conn.get_req_header(conn, "authorization") |> is_admin |> maybe_halt(conn)
  end

  def authenticate(conn, params) do
    # redirect to query param redirect

    valid_paths = ["model_settings", "questions", "question_statistics"]

    redirect_path = params["redirect"] |> case do
      nil -> :other
      path -> if String.starts_with?(path, valid_paths) do
        "/" <> path
      else
        :other
      end
    end

    if redirect_path == :other do
      # throw 400
      send_resp(conn, 400, "")
    else
      token = params["token"]

      if token do
        conn |> put_session(:token, token) |> redirect(to: redirect_path)
      else
        send_resp(conn, 401, "unauthorized")
      end
    end
  end
end
