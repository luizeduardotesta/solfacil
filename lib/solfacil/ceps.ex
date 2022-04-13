defmodule Solfacil.Ceps do
  alias Solfacil.Repo
  alias Solfacil.Ceps.Cep

  import Ecto.Query

  def get_cep_by_number(cep) do
    case Repo.get_by(Cep, cep: cep) do
      nil -> {:error, :not_found}
      cep -> {:ok, cep}
    end
  end

  def create_cep(attrs) do
    %Cep{}
    |> Cep.changeset(attrs)
    |> Repo.insert!()
  end

  def get_cep_from_data(cep) do
    from(
      u in Cep,
      where: u.cep == ^cep
    )
    |> Repo.all()
  end

  def get_cep(id), do: Repo.get(Cep, id)

  def list_ceps do
    Repo.all(Cep)
  end

  def update_cep(%Cep{} = cep, attrs) do
    cep
    |> Cep.changeset(attrs)
    |> Repo.update()
  end
end
