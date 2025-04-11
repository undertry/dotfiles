#!/run/current-system/sw/bin/bash

# ========================
# Script Principal
# ========================

# Importar configuración y módulos
source "$(dirname "$0")/config.sh"
source "$(dirname "$0")/lib/ui.sh"
source "$(dirname "$0")/lib/note.sh"
source "$(dirname "$0")/lib/status.sh"
source "$(dirname "$0")/lib/preview.sh"

main() {
  local tipo
  tipo=$(select_type)

  local note_dir titulo tags filepath

  if [[ "$tipo" == "journal" ]]; then
    titulo=$(date +%Y-%m-%d_%H-%M-%S)
    note_dir="$NOTES_DIR/journal"
  else
    local base="$NOTES_DIR/$tipo"
    local category
    category=$(select_category "$base")
    note_dir="$base/$category"

    while true; do
      read -rp "📄 Título de la nota: " titulo
      if [[ -n "$titulo" ]]; then break
      else echo "❌ El título no puede estar vacío. Intente de nuevo." >&2
      fi
    done

    tags=$(get_tags)
  fi

  local slug
  slug=$(echo "$titulo" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
  filepath="$note_dir/$slug.md"

  preview_metadata "$tipo" "$titulo" "$tags" "$filepath"

  filepath=$(generate_note "$tipo" "$titulo" "$tags" "$note_dir")

  echo "✅ Nota creada en: $filepath"
  $EDITOR "$filepath"

  if [[ "$tipo" != "journal" ]]; then
    update_status "$filepath"
  fi

  preview_note "$filepath"

  # Actualizar índice de notas automáticamente
  "$(dirname "$0")/../utils/generate_index.sh" &
  echo "🗂 Índice actualizado automáticamente ✔"
}

main
