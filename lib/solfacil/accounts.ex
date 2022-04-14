defmodule Solfacil.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Solfacil.Repo

  alias Solfacil.Accounts.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_user_by_id(id) do
    Repo.get(User, id)
  end

  def get_user_by_email_and_password(email, password)
      when is_binary(email) and is_binary(password) do
    with %User{password_hash: password_hash} = user <- Repo.get_by(User, email: email),
         true <- Bcrypt.verify_pass(password, password_hash) do
      user
    else
      _ -> nil
    end
  end
end
