defmodule SolfacilWeb.Controller.CepControllerTest do
  use SolfacilWeb.ConnCase

  @valid_cep "01508020"

  describe "show/2" do
    test "Success when is a valid cep", %{conn: conn} do
      conn = get(conn, Routes.cep_path(conn, :show, @valid_cep))

      assert json_response(conn, 200)["cep"] == "01508020"
    end
  end
end
