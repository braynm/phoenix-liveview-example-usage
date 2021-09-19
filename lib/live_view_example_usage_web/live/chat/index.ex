defmodule LiveViewExampleUsageWeb.ChatLive do
  use Phoenix.LiveView
  alias LiveViewExampleUsageWeb.Presence

  def mount(_params, session, socket) do
    socket = redirect_to_login(session["user"], socket)

    if connected?(socket) do
      join_topics_and_track_presence(session["user"])
    end

    chats = topics(session["user"])

    socket =
      socket
      |> assign(user: session["user"])
      |> assign(chats: transform_chat_list(session["user"], chats))

    send(self(), :chat_statuses_on_mount)

    {:ok, socket}
  end

  def handle_info(:chat_statuses_on_mount, socket) do
    chats =
      Enum.map(socket.assigns.chats, fn chat ->
        case Map.fetch(Presence.list(chat.chat), chat.name) do
          :error -> chat
          _ -> %{chat | online: true}
        end
      end)

    socket =
      socket
      |> assign(chats: chats)

    {:noreply, socket}
  end

  def handle_info(%{event: "presence_diff", topic: topic, payload: payload}, socket) do
    send(self(), {:map_user_leaves_status, topic, payload.leaves})
    send(self(), {:map_user_joins_status, topic, payload.joins})
    {:noreply, socket}
  end

  def handle_info({:map_user_leaves_status, topic, leaves}, socket) do
    user = Map.keys(leaves) |> List.first()

    socket =
      if user !== nil && user !== socket.assigns.user do
        chats = update_chat_list_online_status(topic, socket.assigns.chats, false)
        assign(socket, chats: chats)
      else
        socket
      end

    {:noreply, socket}
  end

  def handle_info({:map_user_joins_status, topic, joins}, socket) do
    user = Map.keys(joins) |> List.first()

    socket =
      if user !== nil && user !== socket.assigns.user do
        chats = update_chat_list_online_status(topic, socket.assigns.chats, true)
        assign(socket, chats: chats)
      else
        socket
      end

    {:noreply, socket}
  end

  def handle_info({:send_message_to_other, payload}, socket) do
    socket =
      socket
      |> push_event("new_message", payload)

    {:noreply, socket}
  end

  def handle_event("send_message", payload, socket) do
    message = %{
      "message" => payload["value"],
      "chat" => payload["chat"],
      "user" => socket.assigns.user
    }

    Phoenix.PubSub.broadcast_from!(
      LiveViewExampleUsage.PubSub,
      self(),
      payload["chat"],
      {:send_message_to_other, message}
    )

    socket =
      socket
      |> push_event("new_message", message)

    {:noreply, socket}
  end

  defp transform_chat_list(logged_in_user, topics) do
    Enum.map(topics, fn topic ->
      %{
        chat: topic,
        name: LiveViewExampleUsage.Chat.room_list_append_chat_name(logged_in_user, topic),
        online: false
      }
    end)
  end

  defp topics(logged_in_user) do
    users =
      Enum.map(LiveViewExampleUsage.Chat.user_list(), fn user -> Map.get(user, :username) end)

    # Example chat room list for logged-in user "FRODO":
    # Normalize list first by, sorting each item pair (e.g frodo, sam) alphabetically
    # > ["chat:frodo-sam", "chat:aragorn-frodo", "chat:frodo-gandalf"]
    LiveViewExampleUsage.Chat.user_to_chat_room_list(
      logged_in_user,
      users
    )
  end

  defp join_topics_and_track_presence(logged_in_user) do
    topics = topics(logged_in_user)

    Enum.map(topics, fn topic ->
      LiveViewExampleUsageWeb.Endpoint.subscribe(topic)

      Presence.track(
        self(),
        topic,
        logged_in_user,
        %{}
      )
    end)
  end

  defp redirect_to_login(nil, socket), do: redirect(socket, to: "/chat/login")
  defp redirect_to_login(_user, socket), do: socket

  defp update_chat_list_online_status(topic, chats, value) do
    Enum.map(
      chats,
      fn
        %{chat: ^topic} = chat ->
          %{chat | online: value}

        chat ->
          chat
      end
    )
  end
end
