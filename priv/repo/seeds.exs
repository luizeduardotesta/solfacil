# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Solfacil.Repo.insert!(%Solfacil.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Seed `ceps` table from CSV

alias Solfacil.Ceps

cep_data = [
  %{
    logradouro: "Rua Booker Pittman, 61",
    bairro: "Chácara Santo Antônio",
    localidade: "São Paulo",
    uf: "SP",
    cep: "04719060"
  },
  %{
    logradouro: "R. Medeiros de Albuquerque, 82-154",
    bairro: "Jardim das Bandeiras",
    localidade: "São Paulo",
    uf: "SP",
    cep: "05436060"
  },
  %{
    logradouro: "Av. São João, 439",
    bairro: "República",
    localidade: "São Paulo",
    uf: "SP",
    cep: "01035000"
  }
]

Enum.each(cep_data, fn data ->
  Ceps.create_cep(data)
end)
