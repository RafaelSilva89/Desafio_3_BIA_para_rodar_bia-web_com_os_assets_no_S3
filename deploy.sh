#!/usr/bin/env bash
# Deploy do front-end da BIA para o S3.
# Uso: ./deploy.sh <ambiente> <URL_DA_API>

set -e

AMBIENTE="$1"
API_URL="$2"

BUCKET_NAME="${BUCKET_NAME:-desafios-fundamentais-aws1-bia}"
BIA_DIR="${BIA_DIR:-$HOME/DESAFIOS-FUNDAMENTAIS/bia}"

# check if my var AMBIENTE is equals to hom ou prd
if [ "$AMBIENTE" != "hom" ] && [ "$AMBIENTE" != "prd" ]; then
  echo "Ambiente invalido"
  echo
  echo "Uso:     ./deploy.sh <ambiente> <URL_DA_API>"
  echo "Exemplo: ./deploy.sh hom http://SEU-IP-DA-API"
  exit 1
fi

if [ -z "$API_URL" ]; then
  echo "Erro: informe a URL da API."
  echo "Exemplo: ./deploy.sh $AMBIENTE http://SEU-IP-DA-API"
  exit 1
fi

if [ ! -d "$BIA_DIR/client" ]; then
  echo "Erro: projeto da BIA nao encontrado em $BIA_DIR"
  echo "Ajuste a variavel BIA_DIR ou clone o projeto:"
  echo "  git clone https://github.com/henrylle/bia \"$BIA_DIR\""
  exit 1
fi

cd "$(dirname "$0")"
export BIA_DIR

. ./react.sh
. ./s3.sh

echo "Vou iniciar deploy no ambiente: $AMBIENTE"
echo "O endereco da API sera: $API_URL"
echo "Bucket de destino: $BUCKET_NAME"
echo
echo "Fazendo deploy..."

build "$API_URL"

envio_s3 "$BUCKET_NAME"

echo
echo "Finalizado"
echo "Site: http://$BUCKET_NAME.s3-website-us-east-1.amazonaws.com"
