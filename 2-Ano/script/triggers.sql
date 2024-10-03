--?
CREATE TRIGGER trg_log_plano
AFTER INSERT OR UPDATE OR DELETE
ON plano
FOR EACH ROW
EXECUTE FUNCTION log_plano_func();

CREATE TRIGGER trg_log_evento
AFTER INSERT OR UPDATE OR DELETE
ON evento
FOR EACH ROW
EXECUTE FUNCTION log_evento_func();


CREATE TRIGGER trg_log_excursao
AFTER INSERT OR UPDATE OR DELETE
ON excursao
FOR EACH ROW
EXECUTE FUNCTION log_excursao_func();

CREATE TRIGGER trg_log_atracao
AFTER INSERT OR UPDATE OR DELETE
ON atracao
FOR EACH ROW
EXECUTE FUNCTION log_atracao_func();


CREATE TRIGGER trg_log_ponto_turistico
AFTER INSERT OR UPDATE OR DELETE
ON ponto_turistico
FOR EACH ROW
EXECUTE FUNCTION log_ponto_turistico_func();


CREATE TRIGGER atualizar_media_apos_insercao
AFTER INSERT OR UPDATE ON classificacao
FOR EACH ROW
EXECUTE FUNCTION atualizar_media_classificacao();


