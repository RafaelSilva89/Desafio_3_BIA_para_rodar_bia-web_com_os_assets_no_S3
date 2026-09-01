#!/usr/bin/env bash
# Gera os assets estaticos do React da BIA.
# Uso interno: build <URL_DA_API>

function build() {
  local API_URL="$1"

  echo "Fazendo build do react..."
  echo "  projeto: $BIA_DIR"
  echo "  API que vai para o bundle: $API_URL"

  cd "$BIA_DIR" || return 1

  npm install --loglevel=error
  npm install --prefix client --legacy-peer-deps --loglevel=error

  echo " Iniciando build..."
  VITE_API_URL="$API_URL" npm run build --prefix client
  echo " Build finalizado"

  cd - > /dev/null
}
