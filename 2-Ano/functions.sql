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

--Retorna as atrações recomendadas com base nas categorias preferidas do usuário:
CREATE OR REPLACE FUNCTION recomendar_atracoes(usuario_uid VARCHAR)
RETURNS TABLE (
    ID SERIAL,
    nome VARCHAR,
    descricao TEXT,
    endereco VARCHAR,
    acessibilidade BOOLEAN,
    media_classificacao DECIMAL(3, 2),
    ID_categoria INT,
    ID_tipo INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT a.ID, a.nome, a.descricao, a.endereco, a.acessibilidade, 
           a.media_classificacao, a.ID_categoria, a.ID_tipo
    FROM atracao a
    JOIN categoria c ON a.ID_categoria = c.ID
    JOIN pesquisa_perfil pp ON pp.UID_usuario = usuario_uid
    WHERE pp.festival = TRUE AND a.ID_categoria IN (
        SELECT c.ID FROM categoria c WHERE c.nome = 'Festival'
    )
    OR pp.exposicao = TRUE AND a.ID_categoria IN (
        SELECT c.ID FROM categoria c WHERE c.nome = 'Exposição'
    )
    OR pp.feira = TRUE AND a.ID_categoria IN (
        SELECT c.ID FROM categoria c WHERE c.nome = 'Feira'
    )
    OR pp.apresentacao = TRUE AND a.ID_categoria IN (
        SELECT c.ID FROM categoria c WHERE c.nome = 'Apresentação'
    );
END;
$$ LANGUAGE plpgsql;

--Retorna excursões que não terminaram ainda, com base na data atual
CREATE OR REPLACE FUNCTION mostrar_excursoes_recentes()
RETURNS TABLE (
    ID INT,
    capacidade VARCHAR(10),
    qntd_pessoas VARCHAR(10),
    preco_total DECIMAL(10, 2),
    data_inicio TIMESTAMP WITH TIME ZONE,
    data_termino TIMESTAMP WITH TIME ZONE,
    nome_atracao VARCHAR(100),
    nome_empresa VARCHAR(255)
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        e.ID,
        e.capacidade,
        e.qntd_pessoas,
        e.preco_total,
        e.data_inicio,
        e.data_termino,
        a.nome AS nome_atracao,
        emp.nome AS nome_empresa
    FROM
        excursao e
    JOIN
        atracao a ON e.ID_atracao = a.ID
    LEFT JOIN
        empresa emp ON e.ID_empresa = emp.ID
    WHERE
        e.data_termino > NOW()  -- Excursões que ainda não terminaram
        AND e.data_desativacao IS NULL;  -- Excursões que não foram desativadas
END;
$$ LANGUAGE plpgsql;

--Retorna eventos que não terminaram ainda, com base na data atual
CREATE OR REPLACE FUNCTION mostrar_eventos_recentes()
RETURNS TABLE (
    ID INT,
    data_inicio TIMESTAMP WITH TIME ZONE,
    data_termino TIMESTAMP WITH TIME ZONE,
    preco_pessoa DECIMAL(10, 2),
    ID_atracao INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        e.ID,
        e.data_inicio,
        e.data_termino,
        e.preco_pessoa,
        e.ID_atracao
    FROM
        evento e
    WHERE
        e.data_termino > NOW()  -- Apenas eventos que ainda não terminaram
        AND e.data_desativacao IS NULL;  -- Filtra eventos que não foram desativados
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
