defmodule InzynjerkaModelWeb.EnsureAdminPlug do
  @moduledoc false
  import Plug.Conn, only: [halt: 1, put_status: 2]

  alias Plug.Conn

  def call(conn) do
    InzynjerkaModelWeb.AuthController.ensure_admin('conn', conn)
  end


end
