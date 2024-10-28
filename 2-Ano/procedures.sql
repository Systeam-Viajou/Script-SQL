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
