defmodule Solfacil.CepsFixtures do
  def cep_fixture(attrs \\ %{}) do
    {:ok, cep} =
      attrs
      |> Enum.into(%{
        logradouro: "some logradouro",
        bairro: "some bairro",
        complemento: "some complemento",
        localidade: "some localidade",
        uf: "some logradouro",
        cep: "12345678"
      })
      |> Solfacil.Ceps.create_cep()

    cep
  end
end
