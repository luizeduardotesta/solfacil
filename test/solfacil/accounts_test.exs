defmodule Solfacil.AccountsTest do
  use Solfacil.DataCase
  use Oban.Testing, repo: Solfacil.Repo

  alias Solfacil.Accounts
  alias Solfacil.Accounts.User

  describe "create_user/1" do
    test "Success when create a user" do
      valid_user = %{email: "luiz@teste.com", password: "12345678"}

      user = Accounts.create_user(valid_user)

      assert match?(%User{}, user)
      assert user.name == "luiz@teste.com"
      assert user.login == "12345678"
    end

    test "Error when create a user" do
      assert_raise Ecto.InvalidChangesetError, fn -> Accounts.create_user(%{}) end
    end
  end
end
