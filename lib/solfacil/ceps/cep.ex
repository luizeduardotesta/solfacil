defmodule Solfacil.Ceps.Cep do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ceps" do
    field :logradouro, :string
    field :bairro, :string
    field :complemento, :string
    field :localidade, :string
    field :uf, :string
    field :cep, :string

    timestamps()
  end

  @required [:logradouro, :bairro, :localidade, :uf, :cep]

  def changeset(cep, attrs) do
    cep
    |> cast(attrs, @required)
    |> validate_required(@required, message: "Can't be blanck")
    |> unique_constraint(:cep)
  end
end
