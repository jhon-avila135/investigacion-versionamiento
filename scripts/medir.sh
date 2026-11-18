#!/usr/bin/env bash
# Mide el tiempo de entrega: desde que se aprueba un cambio hasta que se ve publicado.
# Uso: ./scripts/medir.sh URL_DEL_SITIO PLATAFORMA
# Se ejecuta justo antes de fusionar el PR (GitHub) o de hacer git push gitlab main (GitLab).
URL="$1"
PLAT="$2"

if [ -z "$URL" ] || [ -z "$PLAT" ]; then
  echo "Uso: ./scripts/medir.sh URL_DEL_SITIO github|gitlab"
  exit 1
fi

leer_version() {
  curl -s "$URL?t=$(date +%s)" | grep -o 'data-version="[^"]*"' | cut -d'"' -f2
}

ANTES=$(leer_version)
INICIO=$(date +%s)
echo "Versión publicada ahora: $ANTES. Esperando la nueva..."

while [ "$(leer_version)" = "$ANTES" ]; do
  sleep 5
done

FIN=$(date +%s)
DURACION=$((FIN - INICIO))
NUEVA=$(leer_version)

[ -f mediciones.csv ] || echo "fecha,plataforma,version,segundos" > mediciones.csv
echo "$(date +%F_%T),$PLAT,$NUEVA,$DURACION" >> mediciones.csv
echo "Versión $NUEVA publicada en $DURACION segundos."
