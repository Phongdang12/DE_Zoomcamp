import pandas as pd
from sqlalchemy import create_engine
import argparse
from time import time
import os

def main(params):
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table = params.table
    url = params.url
    
    output_csv = 'taxi_zone_lookup.csv'

    os.system(f"wget {url} -O {output_csv}")


    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')
    engine.connect()

    df_zone = pd.read_csv(output_csv)
    
    df_zone.to_sql(name=table, con=engine, if_exists='append')
    print(f"Data ingested into {table} table successfully.")
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Ingest CSV data to Postgres')

    parser.add_argument('--password', help='password for postgres')
    parser.add_argument('--user', help='user name for postgres')
    parser.add_argument('--host', help='host for postgres')
    parser.add_argument('--port', type=int, help='port for postgres')
    parser.add_argument('--db', help='database name for postgres')
    parser.add_argument('--table', help='table name to ingest data into')
    parser.add_argument('--csv_file', help='CSV file to ingest')
    parser.add_argument('--url', help='URL of the CSV file to ingest') 

    args = parser.parse_args()
    
    main(args)