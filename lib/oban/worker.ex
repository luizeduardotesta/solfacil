defmodule Solfacil.Oban.Worker do
  use Oban.Worker, queue: :default
  alias Solfacil.Ceps.TransformCSV
  alias Solfacil.Accounts.SendMailerToUser

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"email" => email} = _args}) do
    csv = TransformCSV.call_parser()

    filename = "#{email}.csv"

    File.write!(filename, csv)

    SendMailerToUser.send_email(email, filename)
    |> Solfacil.Mailer.deliver()

    File.rm!(filename)
  end
end
