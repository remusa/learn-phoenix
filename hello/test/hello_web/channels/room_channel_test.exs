defmodule HelloWeb.RoomChannelTest do
  use HelloWeb.ChannelCase

  setup do
    {:ok, _, socket} =
      UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(RoomChannel, "room:lobby")

    %{socket: socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push(socket, "ping", %{"hello" => "there"})
    assert_reply(ref, :ok, %{"hello" => "there"})
  end

  test "shout broadcasts to room:lobby", %{socket: socket} do
    push(socket, "shout", %{"hello" => "all"})
    assert_broadcast("shout", %{"hello" => "all"})
  end
end
