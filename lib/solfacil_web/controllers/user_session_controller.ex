defmodule SolfacilWeb.UserSessionController do
  use SolfacilWeb, :controller

  alias Solfacil.Accounts
  alias Solfacil.Guardian

  def create(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params

    if user = Accounts.get_user_by_email_and_password(email, password) do
      {:ok, token, _claims} = Guardian.encode_and_sign(user, %{typ: "access"}, ttl: {1, :hour})

      conn
      |> put_status(:ok)
      |> render("token.json", %{token: token})
    else
      conn
      |> put_status(:unauthorized)
      |> put_view(SolfacilWeb.ErrorView)
      |> render("401.json")
    end
  end
end
