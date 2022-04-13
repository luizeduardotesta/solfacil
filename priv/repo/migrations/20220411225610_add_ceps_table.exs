defmodule Solfacil.Repo.Migrations.AddCepsTable do
  use Ecto.Migration

  def change do
    create table(:ceps) do
      add :logradouro, :string
      add :bairro, :string
      add :complemento, :string
      add :localidade, :string
      add :uf, :string
      add :cep, :string

      timestamps()
    end

    create unique_index(:ceps, [:cep])
  end
end
