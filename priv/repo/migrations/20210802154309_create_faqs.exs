defmodule Pento.Repo.Migrations.CreateFaqs do
  use Ecto.Migration

  def change do
    create table(:faqs) do
      add :question, :string
      add :answer, :text
      add :vote_count, :integer, default: 0

      timestamps()
    end

  end
end
