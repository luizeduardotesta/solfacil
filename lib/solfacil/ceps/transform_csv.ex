defmodule Solfacil.Ceps.TransformCSV do
  @moduledoc """
    Utility module to ingest `Cep.csv`
  """

  alias Solfacil.Ceps

  def call_parser() do
    Ceps.list_ceps()
    |> parse_cep_as_csv
  end

  defp parse_cep_as_csv(ceps_list) do
    headers =
      "id; logradouro; bairro; complemento; localidade; uf; cep; inserted_at; updated_at\n"

    lines =
      Enum.map(ceps_list, fn e ->
        """
        "#{e.id}"; "#{e.cep}"; "#{e.logradouro}"; "#{e.bairro}"; "#{e.complemento}"; "#{e.localidade}";\
        "#{e.uf}"; "#{e.inserted_at}"; "#{e.updated_at}"
        """
      end)

    [headers] ++ lines
  end
end
