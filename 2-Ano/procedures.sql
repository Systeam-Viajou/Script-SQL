CREATE PROCEDURE cadastrar_usuario (
    _nome VARCHAR(255),
    _email VARCHAR(255),
    _endereco VARCHAR(255),
    _cpf CHAR(11),
    _nickname VARCHAR(30),
    _imagem VARCHAR(255),
    _genero CHAR(1),
    _senha VARCHAR(255)
)
BEGIN
    INSERT INTO usuario (nome, email, endereco, cpf, nickname, imagem, genero, senha)
    VALUES (_nome, _email, _endereco, _cpf, _nickname, _imagem, _genero, _senha);
END;

CREATE PROCEDURE atualizar_plano_usuario (
    _ID_plano INT,
    _ID_usuario INT,
    _data_paga DATE
)
BEGIN
    INSERT INTO plano_usuario (ID_plano, ID_usuario, data_paga)
    VALUES (_ID_plano, _ID_usuario, _data_paga)
    ON DUPLICATE KEY UPDATE data_paga = _data_paga;
END;

CREATE PROCEDURE adicionar_classificacao (
    _nota INT,
    _ID_usuario INT,
    _ID_atracao INT
)
BEGIN
    IF _nota BETWEEN 1 AND 5 THEN
        INSERT INTO classificacao (nota, ID_usuario, ID_atracao)
        VALUES (_nota, _ID_usuario, _ID_atracao);
    ELSE
        raise exception 'Nota fora do intervalo permitido';
    END IF;
END;

CREATE PROCEDURE comprar_tour_virtual (
    _ID_usuario INT,
    _ID_tourvirtual INT,
    _data_pagamento DATE
)
BEGIN
    INSERT INTO pagamento_tourvirtual (ID_usuario, ID_tourvirtual, data_pagamento)
    VALUES (_ID_usuario, _ID_tourvirtual, _data_pagamento);
END;

CREATE PROCEDURE cadastrar_atracao (
    _nome VARCHAR(100),
    _descricao TEXT,
    _endereco VARCHAR(255),
    _acessibilidade BOOLEAN
)
BEGIN
    INSERT INTO atracao (nome, descricao, endereco, acessibilidade)
    VALUES (_nome, _descricao, _endereco, _acessibilidade);
END;

CREATE PROCEDURE adicionar_telefone (
    _telefone VARCHAR(20),
    _ID_usuario INT
)
BEGIN
    INSERT INTO telefone (telefone, ID_usuario)
    VALUES (_telefone, _ID_usuario);
END;
