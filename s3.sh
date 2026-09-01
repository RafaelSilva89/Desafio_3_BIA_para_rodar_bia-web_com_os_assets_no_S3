#!/usr/bin/env bash
# Envia os assets gerados para o bucket do site.
# Uso interno: envio_s3 <NOME_DO_BUCKET>

function envio_s3() {
  local BUCKET="$1"

  echo "Fazendo envio para o s3..."
  echo " Iniciando envio..."

  aws s3 sync "$BIA_DIR/client/build/" "s3://$BUCKET/" \
    --delete \
    --profile formacao_aws

  echo " Envio finalizado"
}
