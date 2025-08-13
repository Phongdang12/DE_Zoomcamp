# chuyển ipynb sang py: python -m jupyter nbconvert --to=script up_data.ipynb
import pandas as pd
from sqlalchemy import create_engine
from time import time
import argparse



def main(params):
    
    user=params.user
    password=params.password
    host=params.host
    port=params.port
    db=params.db
    table=params.table

    output_csv='green_tripdata_2019-10.csv'

    engine=create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')
    engine.connect()

    df=pd.read_csv(output_csv,nrows=100)
    df.lpep_pickup_datetime=pd.to_datetime(df.lpep_pickup_datetime)
    df.lpep_dropoff_datetime=pd.to_datetime(df.lpep_dropoff_datetime)


    df_inter=pd.read_csv(output_csv,iterator=True,chunksize=100000) # Đọc từng phần lần lượt 100k rows

    while True:
        t_start = time()
        df= next(df_inter)
        df.lpep_pickup_datetime=pd.to_datetime(df.lpep_pickup_datetime)
        df.lpep_dropoff_datetime=pd.to_datetime(df.lpep_dropoff_datetime)

        df.to_sql(name=table,con=engine,if_exists='append')
        t_end = time()
        print('Inserted another chunk..., took %.3f seconds' % (t_end - t_start))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Ingest CSV data to Postgres')

    parser.add_argument('--password', help='password for postgres')
    parser.add_argument('--user', help='user name for postgres')
    parser.add_argument('--host', help='host for postgres')
    parser.add_argument('--port', type=int, help='port for postgres')
    parser.add_argument('--db', help='database name for postgres')
    parser.add_argument('--table', help='table name to ingest data into')
    # parser.add_argument('--url', help='URL of the CSV file to ingest') bị cấm nên tải về sẵn luôn 

    args = parser.parse_args()
    
    main(args)