defmodule Discuss.Posts.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topic" do
    field :title, :string
    belongs_to :user, Discuss.Auth.User
    has_many :comment, Discuss.Posts.Comment

    timestamps()
  end

  @doc false
  def changeset(topic, attrs \\ %{}) do
    topic
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
