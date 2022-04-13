defmodule CepClient.CepFinder do
  def get_cep_local(cep) do
    cep
    |> request
    |> handle_result
  end

  defp request(cep) do
    :get
    |> Finch.build("https://viacep.com.br/ws/#{cep}/json/")
    |> Finch.request(MyFinch)
  end

  defp handle_result({:ok, content}) do
    case content.status do
      200 -> {:ok, Jason.decode!(content.body)}
      400 -> {:error, :bad_request}
    end
  end
end
