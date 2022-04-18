Solfacil
Uma api REST.

Proposal Problem
1. O usuário vai chamar um endpoint passando um cep para buscar um endereço,
caso o cep já exista na base de dados retornar o endereço para o usuário,
caso contrário buscar o endereço no ws https://viacep.com.br/ws/CEP/json/ e 
esse novo endereço será salvo dentro da base de dados.

2. Foi elaborado um endpoint para gerar um CSV com todos os endereços salvos
da na base de dados e utilizando processamento assíncrono enviando um email
para o usuário contendo esse CSV.

requisito_bônus
1. Utilizei o Guardian para garantir a segurança da nossa api, por meio de 
um token de autorização para o login do usuário.

In lococal Setup
Instalar as deps mix deps.get
Criar o banco mix ecto.setup
Rodar os seeds mix run priv/repo/seeds.exs
Start Phoenix mix phx.server
Rodar os testes mix test
Database
PostgreSQL

username: postgres
password: postgres

Using
Você pode usar postman/insomnia ou algo similar pra fazer os request de endpoin abaixo:

Primeiro Endpoint
get /ceps/:cep
{
  "ceps": { 
    "logradouro": "Av. São João, 439", 
    "bairro": "República"
    "localidade": "São Paulo"
    "uf": "SP"
    "cep": "01035000"
  }
}

Segundo Endpoint
get /ceps/csv/:email

O email gerado pelo swoosh podera ser acessado utilizando a porta: 4001

Made by
Luiz Eduardo Testa Santos