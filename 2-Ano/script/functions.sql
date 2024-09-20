CREATE OR REPLACE FUNCTION atualizar_media_classificacao()
RETURNS TRIGGER AS $$
DECLARE
    nova_media DECIMAL(3,2);
BEGIN
    SELECT AVG(nota) INTO nova_media
    FROM classificacao
    WHERE ID_atracao = NEW.ID_atracao;

    UPDATE atracao
    SET media_classificacao = nova_media
    WHERE ID = NEW.ID_atracao;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_plano_func()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_plano (id_plano, operacao, data_operacao)
    VALUES (NEW.ID, TG_OP, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_tour_virtual_func()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_tour_virtual (id_tour_virtual, operacao, data_operacao)
    VALUES (NEW.ID, TG_OP, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_eventos_func()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_eventos (id_evento, operacao, data_operacao)
    VALUES (NEW.ID, TG_OP, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_excursao_func()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_excursao (id_excursao, operacao, data_operacao)
    VALUES (NEW.ID, TG_OP, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_classificacao_func()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_classificacao (id_classificacao, operacao, data_operacao)
    VALUES (NEW.ID, TG_OP, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_atracao()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_atracao (id_atracao, operacao, data_operacao)
    VALUES (NEW.ID, TG_OP, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_ponto_turistico_func()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_ponto_turistico (id_pónto_turistico, operacao, data_operacao)
    VALUES (NEW.ID, TG_OP, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;