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
Solfacil.Ceps.CSVUtil.column_data("priv/repo/data/ceps.csv")
