-- Função de log para media_classificacao de
CREATE OR REPLACE FUNCTION atualizar_media_classificacao()
RETURNS TRIGGER AS $$
DECLARE
    nova_media DECIMAL(3,2);
BEGIN
    -- Calcula a nova média das notas para a atração
    SELECT AVG(nota) INTO nova_media
    FROM classificacao
    WHERE ID_atracao = NEW.ID_atracao;

    -- Atualiza a média de classificação na tabela 'atracao'
    -- Se não houver avaliações, a média ficará como NULL
    UPDATE atracao
    SET media_classificacao = nova_media
    WHERE ID = NEW.ID_atracao;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Função de log para 'plano'
CREATE OR REPLACE FUNCTION log_plano_func()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_plano (id_plano, operacao, data_operacao)
    VALUES (COALESCE(NEW.ID, OLD.ID), TG_OP, NOW());
    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- Função de log para 'tour virtual'
CREATE OR REPLACE FUNCTION log_tour_virtual_func()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_tour_virtual (id_tour_virtual, operacao, data_operacao)
    VALUES (COALESCE(NEW.ID, OLD.ID), TG_OP, NOW());
    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- Função de log para 'eventos'
CREATE OR REPLACE FUNCTION log_eventos_func()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_eventos (id_evento, operacao, data_operacao)
    VALUES (COALESCE(NEW.ID, OLD.ID), TG_OP, NOW());
    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- Função de log para 'excursão'
CREATE OR REPLACE FUNCTION log_excursao_func()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_excursao (id_excursao, operacao, data_operacao)
    VALUES (COALESCE(NEW.ID, OLD.ID), TG_OP, NOW());
    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- Função de log para 'classificação'
CREATE OR REPLACE FUNCTION log_classificacao_func()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_classificacao (id_classificacao, operacao, data_operacao)
    VALUES (COALESCE(NEW.ID, OLD.ID), TG_OP, NOW());
    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- Função de log para 'atração'
CREATE OR REPLACE FUNCTION log_atracao_func()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_atracao (id_atracao, operacao, data_operacao)
    VALUES (COALESCE(NEW.ID, OLD.ID), TG_OP, NOW());
    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- Função de log para 'ponto turístico'
CREATE OR REPLACE FUNCTION log_ponto_turistico_func()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_ponto_turistico (id_ponto_turistico, operacao, data_operacao)
    VALUES (COALESCE(NEW.ID, OLD.ID), TG_OP, NOW());
    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;
