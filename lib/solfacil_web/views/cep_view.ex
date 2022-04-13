defmodule SolfacilWeb.CepView do
  use SolfacilWeb, :view

  def render("show.json", %{cep: cep}) do
    %{
      logradouro: cep.logradouro,
      bairro: cep.bairro,
      complemento: cep.complemento,
      localidade: cep.localidade,
      uf: cep.uf,
      cep: cep.cep
    }
  end
end
