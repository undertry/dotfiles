#!/run/current-system/sw/bin/bash

# ========================
# Script para mostrar resumen de notas
# ========================

SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/notes/create/config.sh"

# 🔎 Extraer el estado de una nota
get_status_from_file() {
  local file="$1"
  grep -E '^status: ' "$file" | cut -d' ' -f2- | tr -d '"'
}

# 📂 Mostrar notas no finalizadas
list_unfinished_notes() {
  local type="$1"
  local label="$2"
  local dir="$NOTES_DIR/$type"
  [[ ! -d "$dir" ]] && return

  local found=0
  while read -r file; do
    status=$(get_status_from_file "$file")
    if [[ "$status" == "In progress" ]]; then
      if [[ $found -eq 0 ]]; then
        echo -e "\n📂 $label no finalizados:"
        found=1
      fi
      title=$(grep -m 1 '^# ' "$file" | sed 's/^# //')
      [[ -z "$title" ]] && title="$(basename "$file")"
      echo "- $title ($(realpath --relative-to="$NOTES_DIR" "$file"))"
    fi
  done < <(find "$dir" -type f -name '*.md')
}

# 📝 Tareas pendientes desde todo.md
list_pending_tasks() {
  local todo_file="$NOTES_DIR/todo/todo.md"
  [[ ! -f "$todo_file" ]] && return

  local pending
  pending=$(grep '^\* \[ \]' "$todo_file")

  if [[ -n "$pending" ]]; then
    echo -e "\n📝 Tareas pendientes (TODO):"
    echo "$pending" | sed -E 's/^\* \[ \] (.*)  🗓 .*/- \1/'
  else
    echo -e "\n📝 Tareas pendientes (TODO):"
    echo "✅ No hay tareas pendientes."
  fi
}

# ========================
# Mostrar resumen con filtros
# ========================

echo -e "📊 Resumen Diario de Notas"
echo "==============================="

SHOW_TODO=1
SHOW_PROJECT=1
SHOW_STUDY=1

# Filtros
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --todo) SHOW_PROJECT=0; SHOW_STUDY=0 ;;
    --project) SHOW_TODO=0; SHOW_STUDY=0 ;;
    --study) SHOW_TODO=0; SHOW_PROJECT=0 ;;
    *) echo "❌ Parámetro desconocido: $1"; exit 1 ;;
  esac
  shift
done

[[ "$SHOW_TODO" -eq 1 ]] && list_pending_tasks
[[ "$SHOW_PROJECT" -eq 1 ]] && list_unfinished_notes "project" "Proyectos"
[[ "$SHOW_STUDY" -eq 1 ]] && list_unfinished_notes "study" "Estudios"

echo -e "\n✅ Fin del resumen."
