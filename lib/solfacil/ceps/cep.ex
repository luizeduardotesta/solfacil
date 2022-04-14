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

  @required [:logradouro, :bairro, :complemento, :localidade, :uf, :cep]

  def changeset(cep, attrs) do
    cep
    |> cast(attrs, @required)
    |> validate_cep()
  end

  defp validate_cep(changeset) do
    changeset
    |> validate_required([:cep])
    |> digit_remove()
    |> validate_length(:cep, is: 8, message: "cep must have 8 digits")
    |> unsafe_validate_unique(:cep, Solfacil.Repo)
    |> unique_constraint(:cep)
  end

  defp digit_remove(changeset) do
    cep = get_change(changeset, :cep)

    if cep do
      changeset
      |> put_change(:cep, String.replace(cep, ~r/[^\d]/, ""))
    else
      changeset
    end
  end
end
