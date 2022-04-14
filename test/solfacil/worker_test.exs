defmodule Solfacil.WorkerTest do
  use ExUnit.Case, async: true
  use Oban.Testing, repo: Solfacil.Repo

  alias Solfacil.Oban.Worker

  describe "perform/1" do
    test "Perform a oban job" do
      assert {:ok, _} = perform_job(Worker, %{email: "luiz@teste.com"})
    end
  end
end
