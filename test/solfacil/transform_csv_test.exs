defmodule Solfacil.TransformCSVTest do
  use Solfacil.DataCase
  alias Solfacil.Ceps

  describe "call_parser/0" do
    test "generate a CSV file" do
      csv = Ceps.TransformCSV.call_parser()

      assert Enum.count(csv) == 1

      assert [
               "id; logradouro; bairro; complemento; localidade; uf; cep; inserted_at; updated_at\n"
             ] ==
               csv
    end

    test "generate a CSV with 2 registries" do
      Ceps.create_cep(%{cep: "12345678", logradouro: "teste1"})
      Ceps.create_cep(%{cep: "87654321", logradouro: "teste2"})

      csv = Ceps.TransformCSV.call_parser()

      assert Enum.count(csv) == 3
    end
  end
end
