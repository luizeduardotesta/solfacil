defmodule Solfacil.SendMailerToUserTest do
  use ExUnit.Case, async: true
  alias Swoosh.Email
  alias Solfacil.Accounts.SendMailerToUser

  describe "call/2" do
    test "If email was send" do
      filename = "test_attachment"
      on_exit(fn -> File.rm(filename) end)
      File.write!(filename, "")

      email_template = SendMailerToUser.send_email("luiz@teste.com", "test_attachment")

      assert %Email{} = email_template
      assert [{_, "luiz@teste.com"}] = email_template.to
      assert [%{filename: ^filename}] = email_template.attachments
    end
  end
end
