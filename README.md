### Motivação

Aplicação desenvolvida afim de aumentar os conehcimento em TDD


### Descrição

O sistema em questão compõe uma API Ror ainda em desenvolvimento onde:

1 - É possível cadastrar usuarios e efetuar login com devise

### Detalhes técnicos/Decisões técnicas tomadas

O projeto, que ainda encontra-se em desenvolvimento, utiliza das seguintes tecnologias: RubyOnRails (tradução/locale de models, controllers e/ou views somente em pt-BR), utilização RSpec, Factorygirl, Faker gem, Devise e PostgreSQL.
Tais gems foram adotadas para melhor desenvolvimento utilizando o TDD como premissa básica para seu desenvolvimento. A arquitetura ficou por parte do padro MVC do rails, não sendo necessárias modificações arquiteturais.

### Como compilar/rodar o projeto e os testes

- Baixe a copia código do repositório:

  - `> git@github.com:toniesteves/task-manager-api.git`

  - Va para a raiz do dir do projeto e instale as dependências com os comandos:

  - `> cd task-manager-api`

  - `> bundle install`

  - `> rake db:create`

  - `> rake db:migrate`

  - Para iniciar o server local, digitar os seguintes comandos na raiz do projeto:

  - `> rails server`
  
  - Para execução dos testes execute:
   
  - `> bundle exec spring rspec spec`

   

