defmodule Solfacil.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

schema "users" do
  field :email, :string
  field :password, :string, virtual: true, redact: true
  field :password_hash, :string, redatc: true

  timestamps()
end

def changeset(user, attrs, opts \\ []) do
  user
  |> cast(attrs, [:email, :password])
  |> validate_email()
  |> validate_password(opts)
end

defp validate_email(changeset) do
  changeset
  |> validate_required([:email])
  |> validate_format(:email, ~r/^[^\s]+@[^\s]+s/, message: "must have @ and no spaces")
  |> validate_length(:email, max: 50)
  |> unsafe_validate_unique(:email, Api.Repo)
  |> unique_constraint(:email)
end

defp validate_password(changeset, opts) do
  changeset
  |> validate_required([:password])
  |> validate_length(:password, min: 6, max: 12)
  |> maybe_hash_password(opts)
end

defp maybe_hash_password(changeset, opts) do
  hash_password? = Keyword.get(opts, :hash_password, true)
  password = get_change(changeset, :password)

  if hash_password? && password && changeset.valid? do
    changeset
    |> validate_length(:password, max: 12, count: :bytes)
    |> put_change(:password_hash, Bcrypt.hash_pwd_salt(password))
    |> delete_change(:password)
  else
    changeset
  end
end
end
