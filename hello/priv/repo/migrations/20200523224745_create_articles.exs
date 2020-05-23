defmodule Hello.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :body, :string

      timestamps()
    end

  end
end
