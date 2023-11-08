defmodule InzynjerkaModelWeb.Router do
  use InzynjerkaModelWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {InzynjerkaModelWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :allow_frames
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug InzynjerkaModelWeb.CORS
  end

  pipeline :allow_frames do
    plug InzynjerkaModelWeb.AllowAllFrames
  end

  pipeline :add_token_to_session do
    plug InzynjerkaModelWeb.AddTokenToSession
  end

  pipeline :only_guest_live do
    plug InzynjerkaModelWeb.EnsureQueryParamGuest
  end

  pipeline :protected_api do
    plug InzynjerkaModelWeb.EnsureAdminPlug
  end

  pipeline :protected_live do
    plug InzynjerkaModelWeb.EnsureQueryParamAdmin
  end

  scope "/", InzynjerkaModelWeb do
    pipe_through [:browser, :add_token_to_session, :only_guest_live ]

    live "/", AuthLoaderLive.Index, :index
  end

  scope "/", InzynjerkaModelWeb do
    pipe_through [:browser,:add_token_to_session, :protected_live]

    live "/home", AuthLoaderLive.Home, :index

    live "/model_settings", ModelSettingsLive.Index, :index
    live "/model_settings/new", ModelSettingsLive.Index, :new
    live "/model_settings/:id/edit", ModelSettingsLive.Index, :edit

    live "/model_settings/:id", ModelSettingsLive.Show, :show
    live "/model_settings/:id/show/edit", ModelSettingsLive.Show, :edit

    live "/questions", QuestionLive.Index, :index
    live "/questions/new", QuestionLive.Index, :new
    live "/questions/:id/edit", QuestionLive.Index, :edit

    live "/questions/:id", QuestionLive.Show, :show
    live "/questions/:id/show/edit", QuestionLive.Show, :edit

  end

  # Other scopes may use custom stacks.
   scope "/", InzynjerkaModelWeb do
     pipe_through :api

     post "/chatbot", ChatbotController, :chatbot
   end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:inzynjerka_model, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: InzynjerkaModelWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
