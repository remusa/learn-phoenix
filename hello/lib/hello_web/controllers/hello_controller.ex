defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  action_fallback HelloWeb.MyFallbackController

  plug HelloWeb.Plugs.Locale, "en" when action in [:index]

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"messenger" => messenger}) do
    conn
    # |> Plug.Conn.assign(:messenger, messenger)
    |> assign(:messenger, messenger)
    |> assign(:receiver, "Kanye West")
    |> render("show.html")

    # render(conn, "show.html", messenger: messenger)
    # text(conn, "From messenger #{messenger}")
    # json(conn, %{id: messenger})
    # html(conn, """
    #   <html>
    #     <head>
    #         <title>Passing a Messenger</title>
    #     </head>
    #     <body>
    #       <p>From messenger #{messenger}</p>
    #     </body>
    #   </html>
    # """)

    # using fallback controller
    # with {:ok, post} <- fetch_post(id),
    #      :ok <- authorize_user(current_user, :view, post) do
    #   render(conn, "show.json", post: post)
    # end
  end
end
