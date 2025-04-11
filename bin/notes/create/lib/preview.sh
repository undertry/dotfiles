#!/run/current-system/sw/bin/bash

# ========================
# Módulo de Previsualización
# ========================

preview_note() {
  local note_file="$1"
  echo "👀 ¿Querés visualizar la nota?" >&2
  echo "1) Glow" >&2
  echo "2) Grip" >&2
  echo "3) Pandoc" >&2
  echo "4) No" >&2
  while true; do
    read -rp "Elegí una opción [1-4]: " view_choice
    case $view_choice in
      1) glow "$note_file"; break ;;
      2) grip "$note_file"; break ;;
      3)
        local HTML_FILE="${note_file%.md}.html"
        pandoc "$note_file" -s -o "$HTML_FILE"
        local html_dir
        html_dir="$(dirname "$HTML_FILE")"
        (cd "$html_dir" && live-server --quiet &)  # se ejecuta en background
        local SERVER_PID=$!
        sleep 1
        local URL="http://127.0.0.1:8080/$(basename "$HTML_FILE")"
        xdg-open "$URL"
        echo "Presioná Enter cuando termines de visualizar la nota..."
        read -r
        kill "$SERVER_PID" 2>/dev/null
        while true; do
          read -rp "🗑 ¿Borrar el HTML generado? (s/n): " borrar
          case $borrar in
            [sS]*) rm -f "$HTML_FILE"; break ;;
            [nN]*) break ;;
            *) echo "❌ Opción inválida. Responda s o n." ;;
          esac
        done
        break
        ;;
      4) break ;;
      *) echo "❌ Opción inválida. Intente de nuevo." >&2 ;;
    esac
  done
}

# ========================
# Previsualización de metadatos antes de crear la nota
# ========================

preview_metadata() {
  local tipo="$1"
  local titulo="$2"
  local tags="$3"
  local filepath="$4"
  local prioridad="$5"  # si no hay prioridad, no se muestra

  echo ""
  echo "📝 Vista previa de la nota:"
  echo "---------------------------"
  echo "Título: $titulo"
  echo "Tipo: $tipo"

  if [[ "$tipo" != "journal" ]]; then
    local category
    category=$(basename "$(dirname "$filepath")")
    echo "Categoría: $category"
    echo "Tags: $tags"
  fi

  if [[ "$tipo" == "project" && -n "$prioridad" ]]; then
    echo "Prioridad: $prioridad"
  fi

  echo "Ruta: $filepath"
  echo "---------------------------"

  while true; do
    read -rp "¿Crear esta nota? (s/n): " choice
    case "$choice" in
      [sS]*) return 0 ;;
      [nN]*) echo "❌ Nota cancelada."; exit 0 ;;
      *) echo "❌ Opción inválida. Intente con s o n." ;;
    esac
  done
}
