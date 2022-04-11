defmodule Solfacil.Repo do
  use Ecto.Repo,
    otp_app: :solfacil,
    adapter: Ecto.Adapters.Postgres
end
