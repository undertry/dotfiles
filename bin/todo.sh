#!/run/current-system/sw/bin/bash

# ========================
# Script para TODO continuo limpio y automático
# ========================

source "$HOME/bin/notes/create/config.sh"

TODO_FILE="$NOTES_DIR/todo/todo.md"
mkdir -p "$(dirname "$TODO_FILE")"

# 🧹 Archivar automáticamente si es un nuevo día
auto_archive_done_tasks() {
  local last_date new_date temp_file done_tasks
  last_date=$(grep -oP '\d{4}-\d{2}-\d{2}' "$TODO_FILE" | head -1)
  new_date=$(date +%Y-%m-%d)

  if [[ "$last_date" != "$new_date" ]]; then
    done_tasks=$(grep '^\* \[x\]' "$TODO_FILE")
    if [[ -n "$done_tasks" ]]; then
      temp_file=$(mktemp)
      echo "# 🗒 Lista de Tareas" > "$temp_file"
      grep -v '^\* \[x\]' "$TODO_FILE" | sed '/^#/d;/^$/d' >> "$temp_file"
      echo -e "\n---\n📦 Tareas completadas (archivadas el $new_date)" >> "$temp_file"
      echo "$done_tasks" >> "$temp_file"
      mv "$temp_file" "$TODO_FILE"
      echo "✅ Tareas completadas archivadas correctamente."
    fi
  fi
}

# ✅ Agregar tareas
append_todo() {
  local task
  echo "📝 Agregar nueva tarea (enter vacío para terminar):"
  while true; do
    read -rp "* " task
    [[ -z "$task" ]] && break
    # Evitar encabezados duplicados
    grep -q '# 🗒 Lista de Tareas' "$TODO_FILE" || echo "# 🗒 Lista de Tareas" > "$TODO_FILE"
    # Eliminar espacios en blanco al final
    sed -i '/^$/d' "$TODO_FILE"
    echo "* [ ] $task  🗓 $(date +%Y-%m-%d)" >> "$TODO_FILE"
  done
}

# ✏️ Editar lista
open_todo() {
  $EDITOR "$TODO_FILE"
}

# 🚀 Menú principal
main() {
  [[ ! -f "$TODO_FILE" ]] && echo "# 🗒 Lista de Tareas" > "$TODO_FILE"

  auto_archive_done_tasks

  echo "📌 ¿Qué querés hacer?"
  echo "1) ➕ Agregar tareas"
  echo "2) ✏️ Editar lista completa"
  echo "3) ❌ Salir"
  read -rp "Elegí una opción [1-3]: " opt

  case "$opt" in
    1) append_todo ;;
    2) open_todo ;;
    *) echo "🚪 Saliendo." ;;
  esac
}

main
