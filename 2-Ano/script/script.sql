CREATE TABLE plano (
    ID SERIAL PRIMARY KEY,
	nome VARCHAR(50),
    descricao TEXT,
    livre_propaganda BOOLEAN DEFAULT FALSE,
    valor DECIMAL(10, 2),
	duracao VARCHAR(10)
);

CREATE TABLE usuario (
    uid VARCHAR(255) PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    -- email VARCHAR(255) UNIQUE NOT NULL,
    data_nascimento DATE CHECK (data_nascimento < CURRENT_DATE),
    nickname VARCHAR(30) UNIQUE NOT NULL,
    imagem VARCHAR(255),
    -- telefone VARCHAR(11) NOT NULL,
    genero CHAR(1) CHECK (genero IN ('F', 'M', 'N')),
    -- senha VARCHAR(255) NOT NULL
    ID_role INT NOT NULL,
    FOREIGN KEY (ID_role) REFERENCES role(ID),
);
CREATE TABLE role (
    ID SERIAL PRIMARY KEY,
    nome VARCHAR(50) UNIQUE NOT NULL
)

CREATE TABLE plano_usuario (
    ID_plano INT NOT NULL,
    ID_usuario VARCHAR(255) NOT NULL,
    data_pagamento TIMESTAMP WITH TIME ZONE,
	data_termino TIMESTAMP WITH TIME ZONE,
    PRIMARY KEY (ID_plano, ID_usuario),
    FOREIGN KEY (ID_plano) REFERENCES plano(ID),
    FOREIGN KEY (ID_usuario) REFERENCES usuario(uid)
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
    ID_usuario VARCHAR(255) NOT NULL,
    ID_tourvirtual INT NOT NULL,
    data_pagamento DATE,
    FOREIGN KEY (ID_tourvirtual) REFERENCES tour_virtual(ID),
    FOREIGN KEY (ID_usuario) REFERENCES usuario(uid)
);

CREATE TABLE usuario_figurinhas (
    ID_usuario VARCHAR(255) NOT NULL,
    ID_figurinha INT NOT NULL, 
    PRIMARY KEY (ID_usuario, ID_figurinha),
    FOREIGN KEY (ID_usuario) REFERENCES usuario(uid)
);

CREATE TABLE eventos (
    ID SERIAL PRIMARY KEY,
    data_inicio TIMESTAMP WITH TIME ZONE,
    preco_pessoa DECIMAL(10, 2),
    ID_atracao INT NOT NULL,
    FOREIGN KEY (ID_atracao) REFERENCES atracao(ID)
);

CREATE TABLE excursao (
    ID SERIAL PRIMARY KEY,
    capacidade varchar(10),
    qntd_pessoas VARCHAR(10),
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
    ID_usuario VARCHAR(255) NOT NULL,
    ID_atracao INT NOT NULL,
    FOREIGN KEY (ID_atracao) REFERENCES atracao(ID),
    FOREIGN KEY (ID_usuario) REFERENCES usuario(uid)
);

CREATE TABLE perguntas_perfil (
    ID SERIAL PRIMARY KEY,
    pergunta VARCHAR(200) NOT NULL
);

CREATE TABLE pesquisa_perfil (
    ID SERIAL PRIMARY KEY,
    UID_usuario VARCHAR(255) NOT NULL REFERENCES usuario(uid),
    ID_perguntas_perfil INT NOT NULL REFERENCES perguntas_perfil(ID),
    resposta BOOLEAN NOT NULL,
    data_resposta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



--tabelas de log

CREATE TABLE log_plano (
    log_id SERIAL PRIMARY KEY,
    plano_id INT,
    operacao VARCHAR(10),
    data_operacao TIMESTAMP WITH TIME ZONE
	--delete_old int
);

CREATE TABLE log_tour_virtual (
    log_id SERIAL PRIMARY KEY,
    tour_virtual_id INT,
    operacao VARCHAR(10),
    data_operacao TIMESTAMP WITH TIME ZONE
);

CREATE TABLE log_eventos (
    log_id SERIAL PRIMARY KEY,
    evento_id INT,
    operacao VARCHAR(10),
    data_operacao TIMESTAMP WITH TIME ZONE
);

CREATE TABLE log_excursao (
    log_id SERIAL PRIMARY KEY,
    excursao_id INT,
    operacao VARCHAR(10),
    data_operacao TIMESTAMP WITH TIME ZONE
);

CREATE TABLE log_classificacao (
    log_id SERIAL PRIMARY KEY,
    classificacao_id INT,
    operacao VARCHAR(10),
    data_operacao TIMESTAMP WITH TIME ZONE
);

CREATE TABLE log_ponto_turistico (
    log_id SERIAL PRIMARY KEY,
    ponto_turistico_id INT,
    operacao VARCHAR(10),
    data_operacao TIMESTAMP WITH TIME ZONE
);