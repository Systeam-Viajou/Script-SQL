--?
CREATE TRIGGER trg_log_plano
AFTER INSERT OR UPDATE OR DELETE
ON plano
FOR EACH ROW
EXECUTE FUNCTION log_plano_func();


CREATE TRIGGER trg_log_tour_virtual
AFTER INSERT OR UPDATE OR DELETE
ON tour_virtual
FOR EACH ROW
EXECUTE FUNCTION log_tour_virtual_func();


CREATE TRIGGER trg_log_eventos
AFTER INSERT OR UPDATE OR DELETE
ON eventos
FOR EACH ROW
EXECUTE FUNCTION log_eventos_func();


CREATE TRIGGER trg_log_excursao
AFTER INSERT OR UPDATE OR DELETE
ON excursao
FOR EACH ROW
EXECUTE FUNCTION log_excursao_func();


CREATE TRIGGER trg_log_classificacao
AFTER INSERT OR UPDATE OR DELETE
ON classificacao
FOR EACH ROW
EXECUTE FUNCTION log_classificacao_func();

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


