defmodule Solfacil.Ceps.Cep do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ceps" do
    field :street, :string
    field :neighborhood, :string
    field :complement, :string
    field :city, :string
    field :state, :string
    field :postal_code, :string

    timestamps()
  end

  @required [:street, :neighborhood, :complement, :city, :state, :postal_code]

  def changeset(cep, attrs) do
    cep
    |> cast(attrs, @required)
    |> validate_required(@required, message: "Can't be blanck")
    |> unique_constraint(:postal_code)
  end
end
