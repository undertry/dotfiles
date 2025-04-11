#!/run/current-system/sw/bin/bash

# ========================
# Módulo de Notas
# ========================

generate_note() {
  local tipo="$1" titulo="$2" tags="$3" dir="$4"
  local filename slug filepath template_file

  if [[ "$tipo" == "journal" ]]; then
    filename="${DATETIME}.md"
  else
    if [[ -z "$titulo" ]]; then
      echo "❌ El título no puede estar vacío." >&2
      exit 1
    fi
    slug=$(echo "$titulo" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
    filename="${slug}.md"
    if [[ -f "$dir/$filename" ]]; then
      echo "❌ Ya existe una nota con ese nombre en $dir." >&2
      exit 1
    fi
  fi

  filepath="$dir/$filename"
  mkdir -p "$dir"

  # 📄 Seleccionar plantilla externa
  template_file="$TEMPLATES_DIR/${tipo}.md"
  if [[ ! -f "$template_file" ]]; then
    echo "❌ No se encontró la plantilla: $template_file" >&2
    exit 1
  fi

  # 🌐 Variables a reemplazar
  export TITLE="$titulo"
  export DATE="$DATE"
  export DATETIME="$DATETIME"
  export TAGS="$tags"

  # 🧪 Sustituir variables en plantilla
  envsubst < "$template_file" > "$filepath"

  echo "$filepath"
}
