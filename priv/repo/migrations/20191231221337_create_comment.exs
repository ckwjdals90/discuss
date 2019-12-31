defmodule Discuss.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comment) do
      add :content, :string
      add :user_id, references(:user)
      add :topic_id, references(:topic)

      timestamps()
    end

  end
end
