defmodule Solfacil.Accounts.SendMailerToUser do
  import Swoosh.Email

  def send_email(email, path) do

    new()
    |> to({"name", email})
    |> from({"Solfacil", "solfacil@example.com"})
    |> subject("Hello, My Man!")
    |> html_body("<h1>Hello name</h1>")
    |> text_body("Hello name\n")
    |> attachment(path)
  end
end
