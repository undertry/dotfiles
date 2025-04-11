#!/run/current-system/sw/bin/bash

# ========================
# Módulo de Estado
# ========================

update_status() {
  local note_file="$1"

  while true; do
    read -rp "🟢 ¿Finalizaste esta nota? [s/n]: " FINISH
    case $FINISH in
      [sS]*)
        local end_date
        end_date=$(date +%Y-%m-%d)

        # Actualizar frontmatter
        sed -i "s/^status: In progress/status: Finished/" "$note_file"
        sed -i "s/^end_date: \"\"/end_date: \"$end_date\"/" "$note_file"

        # Actualizar estado visible en el cuerpo de la nota
        sed -i "s/^⏳ Estado: In progress/✅ Estado: Finalizado/" "$note_file"

        break
        ;;
      [nN]*) break ;;
      *) echo "❌ Por favor, responda s o n." >&2 ;;
    esac
  done
}
