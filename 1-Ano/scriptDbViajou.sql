CREATE TABLE perguntas (  
 ID SERIAL PRIMARY KEY,  
 nome VARCHAR(100) NOT NULL
); 

CREATE TABLE usuario (
 ID SERIAL PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,  
 email VARCHAR(100) NOT NULL,  
 cpf VARCHAR(11) UNIQUE NOT NULL CHECK (cpf~'^[0-9]{11}$'),  
 data_nascimento DATE NOT NULL,
 imagem VARCHAR(250),  
 nickname VARCHAR(20),  
 genero CHAR CHECK (genero in ('M', 'F', 'O')),  
 senha VARCHAR(100) NOT NULL,  
 uf VARCHAR(2) NOT NULL,  
 bairro VARCHAR(30) NOT NULL,  
 CEP VARCHAR(9) NOT NULL,  
 cidade VARCHAR(50) NOT NULL,  
 logradouro VARCHAR(100) NOT NULL,   
); 

CREATE TABLE pesquisa_perfil ( 
 ID SERIAL PRIMARY KEY,  
 respostas VARCHAR(200) NOT NULL,  
 ID_perguntas INT NOT NULL REFERENCES perguntas(ID),  
 data DATE NOT NULL,  
 hora TIME NOT NULL,
 ID_usuario INT NOT NULL REFERENCES usuario(ID)
);

CREATE TABLE telefone (
 ID SERIAL PRIMARY KEY,
 telefone VARCHAR(20) NOT NULL,  
 ID_usuario INT NOT NULL REFERENCES usuario(ID) 
); 

CREATE TABLE plano ( 
 ID SERIAL PRIMARY KEY, 
 nome VARCHAR(100) NOT NULL,  
 descricao VARCHAR(100) NOT NULL,  
 livre_propaganda BOOLEAN DEFAULT FALSE,  
 preco MONEY CONSTRAINT preco_negativo CHECK (preco >= '0.0'),
 data_criacao DATE NOT NULL DEFAULT CURRENT_DATE,
 data_atualizacao DATE NOT NULL
 
); 

CREATE TABLE usuario_plano ( 
 ID SERIAL PRIMARY KEY,  
 data_pagamento DATE NOT NULL,  
 preco MONEY NOT NULL CONSTRAINT preco_negativo CHECK (preco > '0.0'),  
 duracao VARCHAR(20) NOT NULL, 
 ID_usuario INT NOT NULL REFERENCES usuario(ID),  
 ID_plano INT NOT NULL REFERENCES plano(ID)  
); 

CREATE TABLE atracao (
 ID SERIAL PRIMARY KEY,  
 descricao VARCHAR(200) NOT NULL,  
 nome VARCHAR(50) NOT NULL,  
 endereco VARCHAR(100) NOT NULL,  
 acessibilidade BOOLEAN DEFAULT FALSE,
 categoria VARCHAR(50) NOT NULL
); 

CREATE TABLE classificacao ( 
 ID SERIAL PRIMARY KEY,  
 nota FLOAT NOT NULL CONSTRAINT nota_negativa CHECK(nota BETWEEN 1 AND 5),  
 ID_atracao INT NOT NULL REFERENCES atracao(ID),  
 ID_usuario INT NOT NULL REFERENCES usuario(ID)  
); 

CREATE TABLE imagem ( 
 ID SERIAL PRIMARY KEY,  
 url VARCHAR(200) NOT NULL,  
 ID_atracao INT NOT NULL REFERENCES atracao(ID)  
); 

CREATE TABLE pontos_turisticos (
 ID SERIAL PRIMARY KEY,
 capacidade INT NOT NULL CONSTRAINT capacidade_negativa CHECK (capacidade > 0),
 preco_entrada MONEY NOT NULL CONSTRAINT preco_entrada_negativo CHECK (preco_entrada >= '0.0'),
 ID_atracao INT NOT NULL REFERENCES atracao(ID),
 data_criacao DATE NOT NULL DEFAULT CURRENT_DATE,
 data_atualizacao DATE NOT NULL
);

CREATE TABLE excursao ( 
 ID SERIAL PRIMARY KEY,  
 nome_empresa VARCHAR(100) NOT NULL,
 capacidade INT NOT NULL CONSTRAINT capacidade_negativa CHECK (capacidade > 0),  
 duracao VARCHAR(20) NOT NULL,  
 site VARCHAR(200) NOT NULL,  
 preco_total MONEY NOT NULL CONSTRAINT preco_negativo CHECK (preco_total > '0.0'),  
 data_inicio DATE NOT NULL CHECK(data_inicio <= data_termino),  
 data_termino DATE NOT NULL,  
 ID_atracao INT NOT NULL REFERENCES atracao(ID),
 data_criacao DATE NOT NULL DEFAULT CURRENT_DATE,
 data_atualizacao DATE NOT NULL
); 

CREATE TABLE figurinhas ( 
 ID SERIAL PRIMARY KEY,  
 url VARCHAR(200) NOT NULL  
);

CREATE TABLE figu_usuario ( 
 ID SERIAL PRIMARY KEY,  
 ID_usuario INT NOT NULL REFERENCES usuario(ID),  
 ID_figurinhas INT NOT NULL REFERENCES figurinhas(ID)  
);

CREATE TABLE tour_virtual (
 ID SERIAL PRIMARY KEY,  
 descricao VARCHAR(200) NOT NULL,  
 video VARCHAR(200) NOT NULL, 
 media_classificacao FLOAT NOT NULL DEFAULT 0,  
 qnt_classificacao INT NOT NULL DEFAULT 0,
 preco MONEY NOT NULL CONSTRAINT preco_negativo CHECK (preco > '0.0'),
 ID_atracao INT NOT NULL REFERENCES atracao(ID),  
 ID_figurinhas INT NOT NULL REFERENCES figurinhas(ID),
 data_criacao DATE NOT NULL DEFAULT CURRENT_DATE,
 data_atualizacao DATE NOT NULL
); 

CREATE TABLE pagamento_tour (
 ID SERIAL PRIMARY KEY,
 data_pagamento DATE NOT NULl,
 ID_tour_virtual INT NOT NULL REFERENCES tour_virtual(ID),
 ID_usuario INT NOT NULL REFERENCES usuario(ID)
 );

CREATE TABLE eventos ( 
 ID SERIAL PRIMARY KEY, 
 faixa_etaria VARCHAR(50) NOT NULL CHECK (faixa_etaria IN ('Livre', '10+', '12+', '14+', '16+', '18+')),  
 descricao VARCHAR(200) NOT NULL,
 capacidade INT NOT NULL CONSTRAINT capacidade_negativa CHECK (capacidade > 0),  
 horario TIME NOT NULL,  
 data_inicio DATE NOT NULL,   
 data_termino DATE NOT NULL CHECK (data_termino >= data_inicio),  
 preco_pessoa MONEY NOT NULL CONSTRAINT preco_negativo CHECK (preco_pessoa >= '0.0'),
 ID_atracao INT NOT NULL REFERENCES atracao(ID),   
 ID_tour_virtual INT NOT NULL REFERENCES tour_virtual(ID),
 data_criacao DATE NOT NULL DEFAULT CURRENT_DATE,
 data_atualizacao DATE NOT NULL
); 

CREATE TABLE admin (
 ID SERIAL PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,
 email VARCHAR(100) NOT NULL,
 senha VARCHAR(100) NOT NULL,
 url_imagem VARCHAR(200),
 data_criacao DATE NOT NULL DEFAULT CURRENT_DATE,
 data_atualizacao DATE NOT NULL
);







