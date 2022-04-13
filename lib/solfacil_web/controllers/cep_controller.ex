defmodule SolfacilWeb.CepController do
  use SolfacilWeb, :controller

  alias CepClient.CepFinder
  alias Solfacil.Ceps

  def show(conn, %{"cep" => cep} = _params) do
    case Ceps.get_cep_by_number(cep) do
      {:error, :not_found} ->
        case CepFinder.get_cep_local(cep) do
          {:error, :bad_request} ->
            send_resp(conn, 400, "CEP inexistente")

          {:ok, cep} ->
            cep = Ceps.create_cep(cep)
            render(conn, "show.json", cep: cep)
        end

      {:ok, cep} ->
        render(conn, "show.json", cep: cep)
    end
  end

  def index(conn, _params) do
    ceps = Ceps.list_ceps()
    render(conn, "index.json", cep: ceps)
  end
end
