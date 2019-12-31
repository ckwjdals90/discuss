defmodule Discuss.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:email]}

  schema "user" do
    field :email, :string
    field :provider, :string
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end
