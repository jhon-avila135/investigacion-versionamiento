#!/usr/bin/env bash
# Mide el tiempo de entrega: desde que se aprueba un cambio hasta que se ve publicado.
# Uso: ./scripts/medir.sh URL_DEL_SITIO PLATAFORMA [VERSION_ESPERADA]
# Se ejecuta justo antes de fusionar el PR (GitHub) o de hacer git push gitlab main (GitLab).
# Para GitLab conviene pasar la versión esperada: git rev-parse --short=8 HEAD
URL="$1"
PLAT="$2"
ESPERADA="$3"
SEGUIDAS=3   # lecturas seguidas iguales para dar el despliegue por terminado

if [ -z "$URL" ] || [ -z "$PLAT" ]; then
  echo "Uso: ./scripts/medir.sh URL_DEL_SITIO github|gitlab [VERSION_ESPERADA]"
  exit 1
fi

leer_version() {
  curl -s "$URL?t=$(date +%s%N)" | grep -o 'data-version="[^"]*"' | cut -d'"' -f2
}

ANTES=$(leer_version)
INICIO=$(date +%s)
echo "Versión publicada ahora: $ANTES. Esperando la nueva..."

# Mientras se propaga, el sitio puede responder con versiones distintas según el
# servidor. Solo cuenta cuando la nueva versión se lee varias veces seguidas.
# Una respuesta vacía (consulta fallida) tampoco cuenta.
CANDIDATA=""
IGUALES=0
while [ "$IGUALES" -lt "$SEGUIDAS" ]; do
  ACTUAL=$(leer_version)
  if [ -n "$ESPERADA" ]; then
    case "$ACTUAL" in "$ESPERADA"*) VALIDA=1 ;; *) VALIDA=0 ;; esac
  else
    if [ -n "$ACTUAL" ] && [ "$ACTUAL" != "$ANTES" ]; then VALIDA=1; else VALIDA=0; fi
  fi
  if [ "$VALIDA" -eq 1 ] && [ "$ACTUAL" = "$CANDIDATA" ]; then
    IGUALES=$((IGUALES + 1))
  elif [ "$VALIDA" -eq 1 ]; then
    CANDIDATA="$ACTUAL"
    IGUALES=1
    FIN=$(date +%s)
  else
    CANDIDATA=""
    IGUALES=0
  fi
  sleep 3
done

DURACION=$((FIN - INICIO))
[ -f mediciones.csv ] || echo "fecha,plataforma,version,segundos" > mediciones.csv
echo "$(date +%F_%T),$PLAT,$CANDIDATA,$DURACION" >> mediciones.csv
echo "Versión $CANDIDATA publicada en $DURACION segundos."
