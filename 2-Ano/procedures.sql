CREATE OR REPLACE PROCEDURE avaliar_atracao(v_nota FLOAT, v_uid_usuario VARCHAR, v_id_atracao INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validação da nota
    IF v_nota < 1 OR v_nota > 5 THEN
        RAISE EXCEPTION 'Nota inválida. Deve ser entre 1 e 5.';
    ELSE
        -- Inserir a classificação
        INSERT INTO classificacao (nota, ID_usuario, ID_atracao)
        VALUES (v_nota, v_uid_usuario, v_id_atracao);
    END IF;
END;
$$;

CREATE OR REPLACE PROCEDURE atualizar_nome(v_uid_usuario VARCHAR, v_nickname VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE usuario SET nickname = v_nickname
    WHERE uid = v_uid_usuario;
END;
$$;

CREATE OR REPLACE PROCEDURE cadastro_usuario(
    v_uid_usuario VARCHAR,
    v_nickname VARCHAR,
    v_nome VARCHAR,
    v_sobrenome VARCHAR,
    v_cpf VARCHAR,
    v_email VARCHAR,
    v_data_nascimento DATE,
    v_telefone VARCHAR,
    v_genero CHAR,
    v_senha VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO usuario (uid, nickname, nome, sobrenome, cpf, email, data_nascimento, telefone, genero, senha, id_role)
    VALUES (v_uid_usuario, v_nickname, v_nome, v_sobrenome, v_cpf, v_email, v_data_nascimento, v_telefone, v_genero, v_senha, 2);
END;
$$;
