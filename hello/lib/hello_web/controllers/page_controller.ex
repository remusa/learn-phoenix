defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  def index(conn, _params) do
    # render(conn, "index.html")

    conn
    |> put_layout("app.html")
    |> put_status(202)
    |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    |> put_flash(:error, "Let's pretend we have an error.")
    |> render(:index)

    # redirect
    # redirect(conn, to: "/redirect_test")

    # response without body
    # conn
    # |> put_resp_content_type("text/plain")
    # |> send_resp(201, "")

    # setting the Content Type
    # conn
    # |> put_resp_content_type("text/xml")
    # |> render("index.xml", content: some_xml_content)

    # flash messages + redirect
    # conn
    # |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    # |> put_flash(:error, "Let's pretend we have an error.")
    # |> redirect(to: Routes.page_path(conn, :redirect_test))
  end

  def redirect_test(conn, _params) do
    render(conn, "index.html")
  end

  def redirect_external(conn, _params) do
    redirect(conn, external: "https://elixir-lang.org/")
  end

  def path_helpers(conn, _params) do
    redirect(conn, to: Routes.page_path(conn, :redirect_test))
  end
end
