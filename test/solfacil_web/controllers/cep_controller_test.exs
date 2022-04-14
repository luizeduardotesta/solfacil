defmodule SolfacilWeb.Controller.CepControllerTest do
  use SolfacilWeb.ConnCase, async: true

  alias Solfacil.Oban.Worker
  use Oban.Testing, repo: Solfacil.Repo

  @valid_cep "01508020"

  describe "show/2" do
    test "Success when is a valid cep", %{conn: conn} do
      conn = get(conn, Routes.cep_path(conn, :show, @valid_cep))

      assert json_response(conn, 200)["cep"] == "01508020"
    end

    test "Error when is a invalid cep", %{conn: conn} do
      conn = get(conn, Routes.cep_path(conn, :show, "0000000"))

      assert conn.status == 400
    end
  end

  describe "csv_sender/2" do
    test "when an email was sended", %{conn: conn} do
      valid_body = %{"email" => "luiz@haha.com"}
      conn = post(conn, Routes.cep_path(conn, :csv_sender, valid_body))

      assert response_body = json_response(conn, 202)
      assert_enqueued(worker: Worker, args: valid_body)
      assert response_body == %{"status" => "Email Sended"}
    end
  end
end
