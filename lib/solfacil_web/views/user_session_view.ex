defmodule SolfacilWeb.Session.View do
  use SolfacilWeb, :view

  def render("token.json", %{token: token}) do
    %{token: token}
  end
end
