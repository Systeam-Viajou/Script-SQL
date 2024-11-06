CREATE UNIQUE INDEX idx_usuario_email ON usuario(email);
CREATE INDEX idx_atracao_acessivel ON atracao(id) WHERE acessibilidade = true;
