docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v c:/Users/Admin/Downloads/Zoomcamp/2_docker_sql/ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  --network=pg-network \
  --name pg-database \
  postgres:latest


  docker run -it \
    -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
    -e PGADMIN_DEFAULT_PASSWORD="root" \
    -p 8080:80 \
    --network=pg-network \
    --name pgadmin \
    dpage/pgadmin4

  python ingest_data.py \
    --user=postgres \
    --password=postgres \
    --host=localhost \
    --port=5432 \
    --db=ny_taxi \
    --table=green_taxi_trip
    # Bị cấm nên tải về sẵn luôn
    # --url https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2021-01.parquet


  python ingest_zones.py \
    --user=postgres \
    --password=postgres \
    --host=localhost \
    --port=5432 \
    --db=ny_taxi \
    --table=zones \
    --url=https://d37ci6vzurychx.cloudfront.net/misc/taxi_zone_lookup.csv


  docker build -t taxi_ingest:latest . # built image từ Dockerfile



docker-compose build --no-cache
docker-compose up -d : chạy ngầm ko log->làm đc lệnh khác
docker-compose up -> chạy foreground, có log
docker-compose down
docker-compose logs

pgcli -h localhost -p 5432 -U root -d ny_taxi # pgcli là client tương tự như psql nhưng có autocomplete, syntax highlight
