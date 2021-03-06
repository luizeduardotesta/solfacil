defmodule Solfacil.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Solfacil.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        password: "some password"
      })
      |> Solfacil.Accounts.create_user()

    user
  end
end
