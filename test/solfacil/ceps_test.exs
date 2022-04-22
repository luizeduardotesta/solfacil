defmodule Solfacil.CepsTest do
  use Solfacil.DataCase

  alias Solfacil.Ceps

  describe "get_cep_by_number/1" do
    test "Success when existent cep" do
      Ceps.create_cep(%{
        logradouro: "logradouro",
        bairro: "bairro",
        complemento: "complemento",
        localidade: "localidade",
        uf: "uf",
        cep: "12345678"
      })

      {:ok, retrieve_cep} = Ceps.get_cep_by_number("12345678")

      assert match?(%Solfacil.Ceps.Cep{}, retrieve_cep)
      assert retrieve_cep.cep == "12345678"
    end

    test "Error when inexistent cep" do
      retrieve_user = Ceps.get_cep_by_number("")

      assert retrieve_user == {:error, :not_found}
    end
  end

  describe "list_ceps/0" do
    test "Returns all ceps" do
      valid_cep = %{
        logradouro: "logradouro",
        bairro: "bairro",
        complemento: "complemento",
        localidade: "localidade",
        uf: "uf",
        cep: "12345678"
      }

      cep = Ceps.create_cep(valid_cep)

      assert Ceps.list_ceps() == [cep]
    end
  end

  describe "get_cep/1" do
    test "Success when get the cep by the id" do
      valid_cep = %{
        logradouro: "logradouro",
        bairro: "bairro",
        complemento: "complemento",
        localidade: "localidade",
        uf: "uf",
        cep: "12345678"
      }

      cep = Ceps.create_cep(valid_cep)

      assert Ceps.get_cep(cep.id) == cep
    end
  end

  describe "create_cep/1" do
    test "Success when create a cep" do
      valid_cep = %{
        logradouro: "logradouro",
        bairro: "bairro",
        localidade: "localidade",
        uf: "uf",
        cep: "12345678"
      }

      cep = Ceps.create_cep(valid_cep)

      assert match?(%Solfacil.Ceps.Cep{}, cep)
      assert cep.logradouro == "logradouro"
      assert cep.bairro == "bairro"
      assert cep.localidade == "localidade"
      assert cep.uf == "uf"
      assert cep.cep == "12345678"
    end

    test "Error when create a cep" do
      assert_raise Ecto.InvalidChangesetError, fn -> Ceps.create_cep(%{}) end
    end
  end

  describe "update_cep/2" do
    test "Success when cep is upadated" do
      valid_cep = %{
        logradouro: "logradouro",
        bairro: "bairro",
        localidade: "localidade",
        uf: "uf",
        cep: "12345678"
      }

      cep = Ceps.create_cep(valid_cep)
      update_attrs = %{cep: "12345679"}

      assert {:ok, cep} = Ceps.update_cep(cep, update_attrs)
      assert cep.cep == "12345679"
    end

    test "Error when invalid cep is updated" do
      valid_cep = %{
        logradouro: "logradouro",
        bairro: "bairro",
        localidade: "localidade",
        uf: "uf",
        cep: "12345678"
      }

      cep = Ceps.create_cep(valid_cep)
      update_attrs = %{cep: nil}

      assert {:error, %Ecto.Changeset{}} = Ceps.update_cep(cep, update_attrs)
    end
  end
end
