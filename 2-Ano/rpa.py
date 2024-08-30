import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()



conn = psycopg2.connect(
    host=os.getenv('POSTGRES_HOST'),
    database='nome_do_banco',
    user=os.getenv('POSTGRES_USER'),
    password=os.getenv('POSTGRES_PASSWORD') 
)

cursor = conn.cursor()

cursor.execute("SELECT version();")

db_version = cursor.fetchone()
print(db_version)

cursor.close()
conn.close()
