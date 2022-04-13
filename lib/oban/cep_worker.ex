defmodule Solfacil.Oban.CepWorker do
  use Oban.Worker, queue: :events

  @impl Oban.Worker
  def perform(_job) do
    Solfacil.Ceps.CSVUtil.column_data("CSV.txt")
  end
end
