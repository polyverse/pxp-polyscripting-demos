echo "Running under mode: $MODE"

echo "$(date) Obtaining current git sha for tagging the docker image"

echo "Starting wordpress with docker compose"
MODE=$1 docker-compose up
