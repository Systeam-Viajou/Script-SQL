CREATE OR REPLACE PROCEDURE calcular_idade(v_id_usuario VARCHAR)
LANGUAGE plpgsql
AS $$
DECLARE
    v_data_nascimento DATE;
    v_idade INT;
BEGIN
    SELECT data_nascimento INTO v_data_nascimento
    FROM usuario
    WHERE uid = v_id_usuario;

    v_idade := EXTRACT(YEAR FROM AGE(CURRENT_DATE, v_data_nascimento));

    UPDATE usuario
    SET idade = v_idade
    WHERE uid = v_id_usuario;
END;
$$;

CREATE OR REPLACE PROCEDURE avaliar_atracao(v_nota FLOAT, v_id_usuario INT, v_id_atracao INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validação da nota
    IF v_nota < 1 OR v_nota > 5 THEN
        RAISE EXCEPTION 'Nota inválida. Deve ser entre 1 e 5.';
    ELSE
        -- Inserir a classificação
        INSERT INTO classificacao (nota, ID_usuario, ID_atracao)
        VALUES (v_nota, v_id_usuario, v_id_atracao);
    END IF;
END;
$$;
