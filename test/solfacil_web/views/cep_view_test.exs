defmodule SolfacilWeb.CepViewTest do
  use SolfacilWeb.ConnCase, async: true
  alias SolfacilWeb.CepView

  describe "render/2" do
    test "Renderize a valid cep" do
      cep = %{
        cep: "12345678",
        logradouro: "rua de casa, 0",
        complemento: "complemento",
        bairro: "bairro",
        localidade: "localidade",
        uf: "uf"
      }

      return = CepView.render("show.json", cep: cep)

      assert return == cep
    end
  end
end
