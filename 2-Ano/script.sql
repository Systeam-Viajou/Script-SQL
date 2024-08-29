CREATE TABLE plano (
    ID SERIAL PRIMARY KEY,
	nome VARCHAR(50),
    descricao TEXT,
    livre_propaganda BOOLEAN DEFAULT FALSE,
    valor DECIMAL(10, 2),
	duracao VARCHAR(10)
);

CREATE TABLE usuario (
    ID SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    data_nascimento DATE CHECK (data_nascimento < CURRENT_DATE),
    cpf VARCHAR(11) UNIQUE NOT NULL,
    nickname VARCHAR(30) UNIQUE NOT NULL,
    imagem VARCHAR(255),
    telefone VARCHAR(11) NOT NULL,
    genero CHAR(1) CHECK (genero IN ('F', 'M', 'N')),
    senha VARCHAR(255) NOT NULL
);

CREATE TABLE plano_usuario (
    ID_plano INT NOT NULL,
    ID_usuario INT NOT NULL,
    data_pagamento TIMESTAMP WITH TIME ZONE,
	data_termino TIMESTAMP WITH TIME ZONE,
    PRIMARY KEY (ID_plano, ID_usuario),
    FOREIGN KEY (ID_plano) REFERENCES plano(ID),
    FOREIGN KEY (ID_usuario) REFERENCES usuario(ID)
);

CREATE TABLE atracao (
    ID SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    endereco VARCHAR(255),
    acessibilidade BOOLEAN DEFAULT FALSE,
    media_classificacao DECIMAL(3, 2)
);

CREATE TABLE tour_virtual (
    ID SERIAL PRIMARY KEY,
    ID_atracao INT NOT NULL,
    preco DECIMAL(10, 2),
    FOREIGN KEY (ID_atracao) REFERENCES atracao(ID)
);

CREATE TABLE pagamento_tourvirtual (
    ID SERIAL PRIMARY KEY,
    ID_usuario INT NOT NULL,
    ID_tourvirtual INT NOT NULL,
    data_pagamento DATE,
    FOREIGN KEY (ID_tourvirtual) REFERENCES tour_virtual(ID),
    FOREIGN KEY (ID_usuario) REFERENCES usuario(ID)
);

CREATE TABLE usuario_figurinhas (
    ID_usuario INT NOT NULL,
    ID_figurinha INT NOT NULL, 
    PRIMARY KEY (ID_usuario, ID_figurinha),
    FOREIGN KEY (ID_usuario) REFERENCES usuario(ID)
);

CREATE TABLE eventos (
    ID SERIAL PRIMARY KEY,
    faixa_etaria VARCHAR(50),
    data_inicio TIMESTAMP WITH TIME ZONE,
    data_termino TIMESTAMP WITH TIME ZONE,
    preco_pessoa DECIMAL(10, 2),
    ID_atracao INT NOT NULL,
    FOREIGN KEY (ID_atracao) REFERENCES atracao(ID)
);

CREATE TABLE excursao (
    ID SERIAL PRIMARY KEY,
    capacidade varchar(10),
    qntd_pessoas VARCHAR(10)
    empresa VARCHAR(255),
	site_empresa VARCHAR(255),
    preco_total DECIMAL(10, 2),
    data_inicio TIMESTAMP WITH TIME ZONE,
    data_termino TIMESTAMP WITH TIME ZONE,
    ID_atracao INT NOT NULL,
    FOREIGN KEY (ID_atracao) REFERENCES atracao(ID)
);

CREATE TABLE ponto_turistico (
    ID SERIAL PRIMARY KEY,
    ID_atracao INT NOT NULL,
    FOREIGN KEY (ID_atracao) REFERENCES atracao(ID)
);


CREATE TABLE classificacao (
    ID SERIAL PRIMARY KEY,
    nota INT CHECK (nota BETWEEN 1 AND 5),
    ID_usuario INT NOT NULL,
    ID_atracao INT NOT NULL,
    FOREIGN KEY (ID_atracao) REFERENCES atracao(ID),
    FOREIGN KEY (ID_usuario) REFERENCES usuario(ID)
);

CREATE TABLE perguntas (
    ID SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE pesquisa_perfil (
    ID SERIAL PRIMARY KEY,
    resposta TEXT NOT NULL,
    ID_usuario INT NOT NULL,
	ID_pergunta INT NOT NULL,
	FOREIGN KEY (ID_pergunta) REFERENCES perguntas(ID),
    FOREIGN KEY (ID_usuario) REFERENCES usuario(ID)
);
