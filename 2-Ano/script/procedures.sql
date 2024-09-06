CREATE OR REPLACE PROCEDURE cadastrar_evento(v_faixa_etaria VARCHAR, v_horario TIME, v_data_inicio DATE, v_data_termino DATE, v_preco_pessoa DECIMAL, v_id_atracao INT)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM eventos WHERE ID_atracao = v_id_atracao AND NOT (data_termino < v_data_inicio OR data_inicio > v_data_termino)) THEN
        RAISE EXCEPTION 'Atração já reservada para as datas escolhidas.';
    ELSE
        INSERT INTO eventos (faixa_etaria, horario, data_inicio, data_termino, preco_pessoa, ID_atracao)
        VALUES (v_faixa_etaria, v_horario, v_data_inicio, v_data_termino, v_preco_pessoa, v_id_atracao);
    END IF;
END;
$$;

CREATE OR REPLACE PROCEDURE avaliar_atracao(v_nota INT, v_id_usuario INT, v_id_atracao INT)
LANGUAGE plpgsql
AS $$
BEGIN
    IF v_nota < 1 OR v_nota > 5 THEN
        RAISE EXCEPTION 'Nota inválida. Deve ser entre 1 e 5.';
    ELSE
        INSERT INTO classificacao (nota, ID_usuario, ID_atracao)
        VALUES (v_nota, v_id_usuario, v_id_atracao);
    END IF;
END;
$$;


CREATE OR REPLACE PROCEDURE registrar_pagamento_tourvirtual(v_id_usuario INT, v_id_tourvirtual INT, v_data_pagamento DATE)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO pagamento_tourvirtual (ID_usuario, ID_tourvirtual, data_pagamento)
    VALUES (v_id_usuario, v_id_tourvirtual, v_data_pagamento);
END;
$$;

CREATE OR REPLACE PROCEDURE remover_usuario(v_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM usuario WHERE ID = v_id;
END;
$$;