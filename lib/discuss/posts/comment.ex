defmodule Discuss.Posts.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:content, :user]}

  schema "comment" do
    field :content, :string
    belongs_to :user, Discuss.Auth.User
    belongs_to :topic, Discuss.Posts.Topic

    timestamps()
  end

  @doc false
  def changeset(comment, attrs \\ %{}) do
    comment
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
