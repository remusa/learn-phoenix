defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    plug(:accepts, ["html", "text"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(HelloWeb.Plugs.Locale, "en")
  end

  # pipeline :review_checks do
  #   plug :ensure_authenticated_user
  #   plug :ensure_user_owns_review
  # end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", HelloWeb do
    pipe_through(:browser)

    get("/", PageController, :index)

    get("/hello", HelloController, :index)
    get("/hello/:messenger", HelloController, :show)

    # resources "/users", UserController do
    #   resources "/posts", PostController, only: [:index, :show]
    # end
    # resources "/comments", CommentController, except: [:delete]
    # resources "/reviews", ReviewController

    resources("/posts", PostController)

    resources("/users", UserController)
    resources("/sessions", SessionController, only: [:new, :create, :delete], singleton: true)

    get("/redirect_test", PageController, :redirect_test)
    get("/redirect_external", PageController, :redirect_external)
  end

  scope "/cms", HelloWeb.CMS, as: :cms do
    pipe_through(:browser)

    resources("/pages", PageController)
  end

  # scope "/reviews", HelloWeb do
  #   pipe_through [:browser, :review_checks]

  #   resources "/", ReviewController
  # end

  # scope "/" do
  #   pipe_through [:authenticated_user, :ensure_admin]
  #   forward "/jobs", BackgroundJob.Plug, name: "Hello Phoenix"
  # end

  scope "/admin", HelloWeb.Admin, as: :admin do
    pipe_through(:browser)

    resources("/images", ImageController)
    resources("/reviews", ReviewController)
    resources("/users", UserController)
  end

  # Other scopes may use custom stacks.
  scope "/api", HelloWeb.Api, as: :api do
    pipe_through(:api)

    scope "/v1", V1, as: :v1 do
      # resources "/images", ImageController
      # resources "/reviews", ReviewController
      # resources "/users", UserController

      resources("/items", ItemController, except: [:new, :edit])
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through(:browser)
      live_dashboard("/dashboard", metrics: HelloWeb.Telemetry)
    end
  end

  defp authenticate_user(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Login required")
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()

      user_id ->
        assign(conn, :current_user, Hello.Accounts.get_user!(user_id))
    end
  end
end
