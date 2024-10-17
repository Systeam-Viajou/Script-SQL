CREATE TABLE role (
    ID SERIAL PRIMARY KEY,
    nome VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE usuario (
    uid VARCHAR(255) PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE,
    email VARCHAR(255) UNIQUE NOT NULL,
    data_nascimento DATE CHECK (data_nascimento < CURRENT_DATE),
    nickname VARCHAR(30) UNIQUE NOT NULL,
    telefone VARCHAR(11) NOT NULL,
    genero CHAR(1),
    senha VARCHAR(255) NOT NULL,
    ID_role INT,
    FOREIGN KEY (ID_role) REFERENCES role(ID)
);

CREATE TABLE plano (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50),
    descricao VARCHAR(100),
    livre_propaganda BOOLEAN DEFAULT FALSE,
    valor DECIMAL(10, 2),
    duracao VARCHAR(20),
    data_desativacao TIMESTAMP
);

CREATE TABLE plano_usuario (
    id SERIAL PRIMARY KEY,
    ID_plano INT NOT NULL,
    ID_usuario VARCHAR(255) NOT NULL,
    data_pagamento TIMESTAMP WITH TIME ZONE,
    data_termino TIMESTAMP WITH TIME ZONE,
    PRIMARY KEY (ID_plano, ID_usuario),
    FOREIGN KEY (ID_plano) REFERENCES plano(ID),
    FOREIGN KEY (ID_usuario) REFERENCES usuario(uid)
);

CREATE TABLE categoria (
    ID SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_desativacao TIMESTAMP
);

CREATE TABLE atracao (
    ID SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    endereco VARCHAR(255),
    acessibilidade BOOLEAN DEFAULT FALSE,
    media_classificacao DECIMAL(3, 2),
    ID_categoria INT,
    data_desativacao TIMESTAMP,
    CONSTRAINT fk_categoria FOREIGN KEY (ID_categoria) REFERENCES categoria(ID)
);

CREATE TABLE pagamento_tour_virtual (  
    ID SERIAL PRIMARY KEY,  
    ID_usuario VARCHAR(255) NOT NULL,  
    ID_tourvirtual INT NOT NULL,  
    data_pagamento DATE,
    FOREIGN KEY (ID_usuario) REFERENCES usuario(uid)  
);

CREATE TABLE usuario_figurinha (
    ID SERIAL PRIMARY KEY,
    ID_usuario VARCHAR(255) NOT NULL,
    ID_figurinha INT NOT NULL, 
    FOREIGN KEY (ID_usuario) REFERENCES usuario(uid)
);

CREATE TABLE evento (
    ID SERIAL PRIMARY KEY,
    data_inicio TIMESTAMP WITH TIME ZONE,
    data_termino TIMESTAMP WITH TIME ZONE,
    preco_pessoa DECIMAL(10, 2),
    ID_atracao INT NOT NULL,
    data_desativacao TIMESTAMP,
    FOREIGN KEY (ID_atracao) REFERENCES atracao(ID)
);

CREATE TABLE empresa (
    ID SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    site_empresa VARCHAR(255),
    data_desativacao TIMESTAMP
);

CREATE TABLE excursao (
    ID SERIAL PRIMARY KEY,
    capacidade varchar(10),
    qntd_pessoas VARCHAR(10),
    preco_total DECIMAL(10, 2),
    data_inicio TIMESTAMP WITH TIME ZONE,
    data_termino TIMESTAMP WITH TIME ZONE,
    ID_atracao INT NOT NULL,
    ID_empresa INT,
    data_desativacao TIMESTAMP,
    FOREIGN KEY (ID_atracao) REFERENCES atracao(ID),
    FOREIGN KEY (ID_empresa) REFERENCES empresa(ID)
);

CREATE TABLE ponto_turistico (
    ID SERIAL PRIMARY KEY,
    ID_atracao INT NOT NULL,
    data_desativacao TIMESTAMP,
    FOREIGN KEY (ID_atracao) REFERENCES atracao(ID)
);

CREATE TABLE classificacao (
    ID SERIAL PRIMARY KEY,
    nota FLOAT CHECK (nota BETWEEN 1 AND 5),
    ID_usuario VARCHAR(255) NOT NULL,
    ID_atracao INT NOT NULL,
    FOREIGN KEY (ID_atracao) REFERENCES atracao(ID),
    FOREIGN KEY (ID_usuario) REFERENCES usuario(uid)
);

CREATE TABLE pesquisa_perfil (
    ID SERIAL PRIMARY KEY,
    UID_usuario VARCHAR(255) NOT NULL REFERENCES usuario(uid),
    show BOOLEAN DEFAULT false,
    festival BOOLEAN DEFAULT false,
    exposicao BOOLEAN DEFAULT false,
    feira BOOLEAN DEFAULT false,
    apresentacao BOOLEAN DEFAULT false,
    data_resposta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--tabelas de log
CREATE TABLE log_plano (
    log_id SERIAL PRIMARY KEY,
    id_plano INT,
    operacao VARCHAR(10),
    data_operacao TIMESTAMP WITH TIME ZONE
);

CREATE TABLE log_tour_virtual (
    log_id SERIAL PRIMARY KEY,
    id_tour_virtual INT,
    operacao VARCHAR(10),
    data_operacao TIMESTAMP WITH TIME ZONE
);

CREATE TABLE log_eventos (
    log_id SERIAL PRIMARY KEY,
    id_evento INT,
    operacao VARCHAR(10),
    data_operacao TIMESTAMP WITH TIME ZONE
);

CREATE TABLE log_excursao (
    log_id SERIAL PRIMARY KEY,
    id_excursao INT,
    operacao VARCHAR(10),
    data_operacao TIMESTAMP WITH TIME ZONE
);

CREATE TABLE log_classificacao (
    log_id SERIAL PRIMARY KEY,
    id_classificacao INT,
    operacao VARCHAR(10),
    data_operacao TIMESTAMP WITH TIME ZONE
);


CREATE TABLE log_atracao (
    log_id SERIAL PRIMARY KEY,
    id_atracao INT,
    operacao VARCHAR(10),
    data_operacao TIMESTAMP WITH TIME ZONE
);

CREATE TABLE log_ponto_turistico (
    log_id SERIAL PRIMARY KEY,
    id_pónto_turistico INT,
    operacao VARCHAR(10),
    data_operacao TIMESTAMP WITH TIME ZONE
);

