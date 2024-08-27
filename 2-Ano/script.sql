-- Figurinhas e conteúdos estão no banco de dados NoSQL (MongoDB)
CREATE TABLE plano (
    ID INT PRIMARY KEY,
    descricao TEXT,
    livre_propaganda BOOLEAN DEFAULT FALSE,
    valor DECIMAL(10, 2)
);

CREATE TABLE usuario (
    ID INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    endereco VARCHAR(255),
    cpf CHAR(11) UNIQUE NOT NULL,
    nickname VARCHAR(30) UNIQUE NOT NULL,
    imagem VARCHAR(255),
    genero CHAR(1),
    senha VARCHAR(255) NOT NULL
);

CREATE TABLE telefone (
    telefone VARCHAR(20) PRIMARY KEY,
    ID_usuario INT NOT NULL,
    FOREIGN KEY (ID_usuario) REFERENCES usuario(ID)
);

CREATE TABLE atracao (
    ID INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    endereco VARCHAR(255),
    acessibilidade BOOLEAN DEFAULT FALSE
);

CREATE TABLE conteudo_tour_virtual (
    ID INT PRIMARY KEY,
    descricao TEXT,
    media_classificacao DECIMAL(3, 2)
);

CREATE TABLE tour_virtual (
    ID INT PRIMARY KEY,
    ID_conteudo_tour INT NOT NULL,
    ID_atracao INT NOT NULL,
    preco DECIMAL(10, 2),
    FOREIGN KEY (ID_atracao) REFERENCES atracao(ID),
    FOREIGN KEY (ID_conteudo_tour) REFERENCES conteudo_tour_virtual(ID)
);

CREATE TABLE usuario_figurinhas (
    ID_usuario INT NOT NULL,
    ID_figurinhas VARCHAR(24) NOT NULL,  -- Assumindo que o ID da figurinha seja um ObjectId do MongoDB
    PRIMARY KEY (ID_usuario, ID_figurinhas),
    FOREIGN KEY (ID_usuario) REFERENCES usuario(ID)
);

CREATE TABLE eventos (
    ID INT PRIMARY KEY,
    faixa_etaria VARCHAR(50),
    horario TIME,
    data_inicio DATE,
    data_termino DATE,
    preco_pessoa DECIMAL(10, 2),
    ID_atracao INT NOT NULL,
    FOREIGN KEY (ID_atracao) REFERENCES atracao(ID)
);

CREATE TABLE excursao (
    ID INT PRIMARY KEY,
    capacidade varchar(10),
    duracao TIME,
    site VARCHAR(255),
    preco_total DECIMAL(10, 2),
    data_inicio DATE,
    data_termino DATE,
    ID_atracao INT NOT NULL,
    FOREIGN KEY (ID_atracao) REFERENCES atracao(ID)
);

CREATE TABLE turismo (
    ID INT PRIMARY KEY,
    ID_atracao INT NOT NULL,
    FOREIGN KEY (ID_atracao) REFERENCES atracao(ID)
);

CREATE TABLE classificacao (
    ID INT PRIMARY KEY,
    nota INT CHECK (nota BETWEEN 1 AND 5),
    ID_usuario INT NOT NULL,
    ID_atracao INT NOT NULL,
    FOREIGN KEY (ID_atracao) REFERENCES atracao(ID),
    FOREIGN KEY (ID_usuario) REFERENCES usuario(ID)
);

CREATE TABLE pesquisa_perfil (
    ID INT PRIMARY KEY,
    respostas TEXT NOT NULL,
    ID_usuario INT NOT NULL,
    FOREIGN KEY (ID_usuario) REFERENCES usuario(ID)
);

CREATE TABLE perguntas (
    ID INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    ID_pesquisa_perfil INT NOT NULL,
    FOREIGN KEY (ID_pesquisa_perfil) REFERENCES pesquisa_perfil(ID)
);

CREATE TABLE plano_usuario (
    ID_plano INT NOT NULL,
    ID_usuario INT NOT NULL,
    data_paga DATE,
    PRIMARY KEY (ID_plano, ID_usuario),
    FOREIGN KEY (ID_plano) REFERENCES plano(ID),
    FOREIGN KEY (ID_usuario) REFERENCES usuario(ID)
);

CREATE TABLE pagamento_tourvirtual (
    ID INT PRIMARY KEY,
    ID_usuario INT NOT NULL,
    ID_tourvirtual INT NOT NULL,
    data_pagamento DATE,
    FOREIGN KEY (ID_tourvirtual) REFERENCES tour_virtual(ID),
    FOREIGN KEY (ID_usuario) REFERENCES usuario(ID)
);
