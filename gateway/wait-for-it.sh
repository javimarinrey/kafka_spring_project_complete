#!/usr/bin/env bash
set -e
TIMEOUT=60
HOST=""
PORT=""
CMD=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --timeout=*)
      TIMEOUT="${1#*=}"
      shift
      ;;
    --)
      shift
      CMD="$@"
      break
      ;;
    *)
      if [[ -z "$HOST" ]]; then
        HOST="${1%%:*}"
        PORT="${1##*:}"
      fi
      shift
      ;;
  esac
done

echo "Waiting for $HOST:$PORT..."
start_ts=$(date +%s)
while ! nc -z "$HOST" "$PORT"; do
  sleep 1
  now_ts=$(date +%s)
  elapsed=$((now_ts - start_ts))
  if [ "$elapsed" -ge "$TIMEOUT" ]; then
    echo "Timeout after $TIMEOUT seconds waiting for $HOST:$PORT"
    exit 1
  fi
done

echo "$HOST:$PORT is available, starting command..."
exec $CMD
