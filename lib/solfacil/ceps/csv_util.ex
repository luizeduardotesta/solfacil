defmodule Solfacil.Ceps.CSVUtil do
  @moduledoc """
    Utility module to ingest `Cep.csv`
  """

  alias NimbleCSV.RFC4180, as: CSV
  alias Solfacil.{Ceps.Cep, Repo}

  def column_data(file) do
    column_names = get_column_names(file)

    file
    |> File.stream!()
    |> CSV.parse_stream(skip_headers: true)
    |> Enum.map(fn row ->
      row
      |> Enum.with_index()
      |> Map.new(fn {val, num} -> {column_names[num], val} end)
      |> create_or_skip()
    end)
  end

  def get_column_names(file) do
    file
    |> File.stream!()
    |> CSV.parse_stream(skip_headers: false)
    |> Enum.fetch!(0)
    |> Enum.with_index()
    |> Map.new(fn {val, num} -> {num, val} end)
  end

  def create_or_skip(row) do
    case Repo.get_by(Cep, cep: row["cep"]) do
      nil ->
        Repo.insert(
          %Cep{}
          |> Cep.changeset(%{
            logradouro: row["logradouro"],
            bairro: row["bairro"],
            complemento: row["complemento"],
            localidade: row["localidade"],
            uf: row["uf"],
            cep: row["cep"],
          })
        )

      cep ->
        {:ok, cep}
    end
  end
end
