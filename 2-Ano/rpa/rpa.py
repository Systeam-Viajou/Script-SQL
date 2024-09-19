import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

conn_db1 = psycopg2.connect(os.getenv('DB1_URL'))
conn_db2 = psycopg2.connect(os.getenv('DB2_URL'))

cursor_db1 = conn_db1.cursor()
cursor_db1.execute("SELECT * FROM atracao")
atracoes = cursor_db1.fetchall()
cursor_db1.close()
conn_db1.close()

atracoes_transformed = [(id_atracao, nome, descricao, endereco, acessibilidade) for id_atracao, nome, descricao, endereco, acessibilidade in atracoes]

cursor_db2 = conn_db2.cursor()
query = """
    INSERT INTO atracao (ID, nome, descricao, endereco, acessibilidade)
    VALUES (%s, %s, %s, %s, %s)
    ON CONFLICT (ID) DO UPDATE 
    SET nome = EXCLUDED.nome, descricao = EXCLUDED.descricao, endereco = EXCLUDED.endereco, 
        acessibilidade = EXCLUDED.acessibilidade
"""
cursor_db2.executemany(query, atracoes_transformed)
conn_db2.commit()
cursor_db2.close()
conn_db2.close()

print("Dados da tabela 'atracao' transferidos com sucesso!")
