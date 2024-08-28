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
