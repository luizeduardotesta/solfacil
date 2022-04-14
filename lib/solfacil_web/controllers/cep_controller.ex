defmodule SolfacilWeb.CepController do
  use SolfacilWeb, :controller

  alias CepClient.CepFinder
  alias Solfacil.Ceps
  alias Solfacil.Oban.Worker

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

  def csv_sender(conn, %{"email" => email}) do
    %{"email" => email}
    |> Worker.new()
    |> Oban.insert()

    render(conn, "sender.json")
  end
end
