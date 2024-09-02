CREATE TABLE perguntas (  
 ID SERIAL PRIMARY KEY,  
 nome VARCHAR(100) NOT NULL
); 

CREATE TABLE pesquisa_perfil ( 
 ID SERIAL PRIMARY KEY,  
 respostas VARCHAR(150) NOT NULL,  
 ID_perguntas INT NOT NULL REFERENCES perguntas(ID),  
 data DATE NOT NULL,  
 hora TIME NOT NULL
);

CREATE TABLE usuario (
 ID SERIAL PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,  
 email VARCHAR(50) NOT NULL,  
 cpf VARCHAR(11) UNIQUE NOT NULL,  
 imagem VARCHAR(250),  
 nickname VARCHAR(20),  
 genero CHAR CHECK (genero in ('H', 'M', 'O'),  
 senha VARCHAR(20) NOT NULL,  
 uf VARCHAR(2) NOT NULL,  
 bairro VARCHAR(30) NOT NULL,  
 CEP VARCHAR(9) NOT NULL,  
 cidade VARCHAR(30) NOT NULL,  
 logradouro VARCHAR(50) NOT NULL,   
 ID_pesquisa_perfil INT NOT NULL REFERENCES pesquisa_perfil(ID)
); 

CREATE TABLE telefone (
 ID SERIAL PRIMARY KEY,
 telefone VARCHAR(20) NOT NULL,  
 ID_usuario INT NOT NULL REFERENCES Usuario(ID) 
); 

CREATE TABLE plano ( 
 ID SERIAL PRIMARY KEY, 
 nome VARCHAR(100) NOT NULL,  
 descricao VARCHAR(100) NOT NULL,  
 livre_propaganda BOOLEAN DEFAULT FALSE,  
 preco MONEY CONSTRAINT preco_negativo CHECK (preco > 0) 
); 

CREATE TABLE usuario_plano ( 
 ID SERIAL PRIMARY KEY,  
 data_pagamento DATE NOT NULL,  
 valor MONEY NOT NULL CONSTRAINT valor_negativo CHECK (valor > 0),  
 duracao VARCHAR(10) NOT NULL, 
 ID_usuario INT NOT NULL REFERENCES usuario(ID),  
 ID_plano INT NOT NULL REFERENCES plano(ID)  
); 

CREATE TABLE atracao (
 ID SERIAL PRIMARY KEY,  
 descricao VARCHAR(100) NOT NULL,  
 nome VARCHAR(30) NOT NULL,  
 endereco VARCHAR(50) NOT NULL,  
 acessibilidade BOOLEAN DEFAULT FALSE
 -- media_classificacao FLOAT NOT NULL
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

CREATE TABLE excursao ( 
 ID SERIAL PRIMARY KEY,  
 capacidade INT NOT NULL CHECK (capacidade > 0),  
 duracao VARCHAR(10) NOT NULL,  
 site VARCHAR(200) NOT NULL,  
 preco_total MONEY NOT NULL,  
 data_inicio DATE NOT NULL CHECK(data_inicio < data_termino),  
 data_termino DATE NOT NULL,  
 ID_atracao INT NOT NULL REFERENCES atracao(ID)  
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
 descricao VARCHAR(100) NOT NULL,  
 midia VARCHAR(200) NOT NULL,  
 media_classificacao FLOAT NOT NULL,  
 ID_atracao INT NOT NULL REFERENCES atracao(ID),  
 ID_figurinhas INT NOT NULL REFERENCES figurinhas(ID),  
 quant_classificacao INT NOT NULL  
); 

CREATE TABLE conteudo_tour ( 
 ID SERIAL PRIMARY KEY,  
 ID_tour_virtual INT NOT NULL REFERENCES tour_virtual(ID),  
 video VARCHAR(200) NOT NULL  
); 

CREATE TABLE eventos ( 
 ID SERIAL PRIMARY KEY, 
 faixa_etaria VARCHAR(20) NOT NULL,  
 capacidade INT NOT NULL CHECK (capacidade > 0),  
 horario TIME NOT NULL,  
 data_termino DATE NOT NULL CHECK (data_termino > data_inicio),  
 preco_pessoa FLOAT NOT NULL CONSTRAINT preco_negativo CHECK (preco_pessoa > 0),   
 ID_atracao INT NOT NULL REFERENCES atracao(ID),  
 data_inicio DATE NOT NULL,  
 descricao VARCHAR(100) NOT NULL,  
 ID_tour_virtual INT NOT NULL REFERENCES tour_virtual(ID)  
); 

