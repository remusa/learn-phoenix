defmodule HelloWeb.ItemController do
  use HelloWeb, :controller

  alias Hello.Shop
  alias Hello.Shop.Item

  action_fallback HelloWeb.FallbackController

  def index(conn, _params) do
    items = Shop.list_items()
    render(conn, "index.json", items: items)
  end

  def create(conn, %{"item" => item_params}) do
    with {:ok, %Item{} = item} <- Shop.create_item(item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.item_path(conn, :show, item))
      |> render("show.json", item: item)
    end
  end

  def show(conn, %{"id" => id}) do
    item = Shop.get_item!(id)
    render(conn, "show.json", item: item)
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Shop.get_item!(id)

    with {:ok, %Item{} = item} <- Shop.update_item(item, item_params) do
      render(conn, "show.json", item: item)
    end
  end

  def delete(conn, %{"id" => id}) do
    item = Shop.get_item!(id)

    with {:ok, %Item{}} <- Shop.delete_item(item) do
      send_resp(conn, :no_content, "")
    end
  end
end
