# Script-SQL

Este repositório contém scripts SQL usados pela equipe do Systeam-Viajou para configurar e manipular os bancos de dados de suas aplicações de turismo. Os scripts abrangem desde a criação de tabelas e gatilhos até procedimentos armazenados e funções para automação e manutenção de registros.

## Estrutura do Projeto

- `1-ano/`: Contém scripts SQL para a configuração inicial do banco de dados, incluindo a criação de tabelas de usuário, perguntas, planos e outras entidades.
  - `scriptDbViajou.sql`: Script principal de criação das tabelas.
  - `scriptDataLoad.sql`: Scripts para inserção inicial de dados no banco.
- `2-ano/`: Contém scripts de evolução do banco de dados, incluindo ajustes e novas entidades.
  - `script.sql`: Script para a criação de novas tabelas e ajustes nas existentes.
  - `triggers.sql`: Contém a definição de gatilhos para logging e outras automatizações.
  - `procedures.sql`: Procedimentos armazenados para operações comuns como cadastro e atualização de dados.
  - `functions.sql`: Funções para cálculo de médias, recomendações e outras consultas complexas.

## Funcionalidades

- **Criação de Tabelas**: Scripts para a criação de todas as tabelas necessárias para as aplicações, com constraints e relações bem definidas.
- **Manipulação de Dados**: Procedimentos e funções para inserção, atualização e consulta de dados de maneira otimizada e segura.
- **Log e Triggers**: Automatização do registro de mudanças significativas nas tabelas por meio de gatilhos que acionam funções de log.
- **Recomendações e Consultas**: Funções avançadas para recomendação de atrações e visualização de eventos e excursões recentes, baseadas no perfil do usuário.

## Configuração Inicial

1. Clone o repositório:
git clone https://github.com/Systeam-Viajou/Script-SQL.git


2. Acesse o diretório relevante (e.g., `1-ano` ou `2-ano`) e execute os scripts SQL no seu sistema de gestão de banco de dados.

#### Desenvolvido com dedicação pela equipe de tecnologia *Systeam-Viajou*:

- [Gabriel Costa](https://github.com/gbrlscosta)
- [Gabrieli Oliveira](https://github.com/gabrieliolveira)
