defmodule LiveViewExampleUsage.Chat do
  def serialize_chat_name(user1, user2) do
    [user1, user2] = Enum.sort([user1, user2])
    "chat:#{user1}-#{user2}"
  end

  @spec user_to_chat_room_list(String.t(), list(String.t())) :: list(String.t())
  def user_to_chat_room_list(user_id, user_list) do
    user_list
    |> Enum.reject(fn user -> user === user_id end)
    |> Enum.map(&serialize_chat_name(user_id, &1))
  end

  @spec room_list_append_chat_name(String.t(), String.t()) :: String.t()
  def room_list_append_chat_name(user, chat) do
    chat
    |> String.replace("chat:", "")
    |> String.split("-")
    |> Enum.reject(fn user_in_chat -> user_in_chat === user end)
    |> List.first()
  end

  @spec user_list() :: list(map())
  def user_list do
    [
      %{
        username: "sam",
        name: "Sam"
      },
      %{
        username: "frodo",
        name: "Frodo"
      },
      %{
        username: "aragorn",
        name: "Aragorn"
      },
      %{
        username: "gandalf",
        name: "Gandalf"
      }
    ]
  end
end
