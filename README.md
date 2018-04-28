### Motivação

Aplicação desenvolvida afim de aumentar os conehcimento em TDD

## Dependências Básicas

- S.O. Linux ou VM ou Container ou MacOS(brew)
- Ruby >= v2.4.x
- Rails >= v5.1.x
- RubyGems
- Rake
- Bundler

### Descrição

O sistema em questão compõe uma API Ror ainda em desenvolvimento onde:

1 - É possível cadastrar usuarios e efetuar login com devise

### Detalhes técnicos/Decisões técnicas tomadas

O projeto, que ainda encontra-se em desenvolvimento, utiliza das seguintes tecnologias: RubyOnRails (tradução/locale de models, controllers e/ou views somente em pt-BR), utilização RSpec, Factorygirl, Faker gem, Devise e PostgreSQL.
Tais gems foram adotadas para melhor desenvolvimento utilizando o TDD como premissa básica para seu desenvolvimento. A arquitetura ficou por parte do padro MVC do rails, não sendo necessárias modificações arquiteturais.

### Instalação (console)

- Baixe a copia código do repositório:

  `> git clone git@github.com:wellisonsi/devops.git`

- Va para a raiz do dir do projeto e instale as dependências com os comandos:

  `> cd task-manager-api`

  `> bundle install`

### Iniciar o Banco de Dados (console)

- Para iniciar o Banco de Dados, digitar os seguintes comandos na raiz do projeto :


** ambiente "development"

- `> rails db:create`

- `> rails db:migrate`


### Iniciar Server Local (console)

- Para iniciar o server local, digitar os seguintes comandos na raiz do projeto:

  - `> rails server` (ambiente development)


### Testes e Cobertura

  - `> rails db:test:prepare`

  - `> rspec spec`

  - RSpec coverage report disponível em ativamanager-api/coverage.


  - Para execução dos testes execute:

  - `> bundle exec spring rspec spec`
