defmodule DiscussWeb.CommentChannel do
  use Phoenix.Channel

  alias Discuss.Posts.{Topic, Comment}
  alias Discuss.Repo

  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)
    topic = Topic
            |> Repo.get(topic_id)
            |> Repo.preload(comment: [:user])

    {:ok, %{comment: topic.comment}, assign(socket, :topic, topic)}
  end

  def handle_in(name, %{"content" => content}, socket) do
    topic = socket.assigns.topic

    changeset = topic
      |> Ecto.build_assoc(:comment)
      |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{comment: comment})
        {:reply, :okay, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}

    end
    {:reply, :ok, socket}
  end
end
