defmodule Hello.ShopTest do
  use Hello.DataCase

  alias Hello.Shop

  describe "items" do
    alias Hello.Shop.Item

    @valid_attrs %{description: "some description", title: "some title"}
    @update_attrs %{description: "some updated description", title: "some updated title"}
    @invalid_attrs %{description: nil, title: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shop.create_item()

      item
    end

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Shop.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Shop.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Shop.create_item(@valid_attrs)
      assert item.description == "some description"
      assert item.title == "some title"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shop.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, %Item{} = item} = Shop.update_item(item, @update_attrs)
      assert item.description == "some updated description"
      assert item.title == "some updated title"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Shop.update_item(item, @invalid_attrs)
      assert item == Shop.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Shop.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Shop.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Shop.change_item(item)
    end
  end
end
