#!/run/current-system/sw/bin/bash

source "$(dirname "$0")/../create/config.sh"

INDEX_FILE="$NOTES_DIR/index.md"

# 🏷️ Extraer título (de H1 o del frontmatter si querés adaptarlo más)
get_title() {
  local file="$1"
  grep -m 1 '^# ' "$file" | sed 's/^# //' || echo "(Sin título)"
}

# 📌 Extraer estado desde el frontmatter
get_status() {
  local file="$1"
  local status
  status=$(grep -i '^status:' "$file" | awk -F': ' '{print $2}' | tr -d '"')

  case "$status" in
    Finished) echo "✅ Finalizada" ;;
    In*progress) echo "🔄 En progreso" ;;
    Logged) echo "📝 Registrada" ;;
    *) echo "📄 Sin estado" ;;
  esac
}

# 🧾 Formato por entrada
format_entry() {
  local file="$1"
  local title status date relpath
  title="$(get_title "$file")"
  status="$(get_status "$file")"
  date="$(date -r "$file" +%Y-%m-%d)"
  relpath="${file#$NOTES_DIR/}"
  echo "- [$title]($relpath) - $status ($date)"
}

# 📂 Imprimir sección por tipo
print_section() {
  local type="$1" icon="$2" title="$3"
  local dir="$NOTES_DIR/$type"

  [[ ! -d "$dir" ]] && return

  local total
  total=$(find "$dir" -name '*.md' | wc -l)
  (( total == 0 )) && return

  echo -e "\n## $icon $title ($total notas)" >> "$INDEX_FILE"

  if [[ "$type" == "journal" ]]; then
    find "$dir" -name '*.md' -printf "%T@ %p\n" | sort -nr | cut -d' ' -f2- | while read -r file; do
      format_entry "$file" >> "$INDEX_FILE"
    done
  else
    find "$dir" -type f -name '*.md' | sort | while read -r file; do
      format_entry "$file" >> "$INDEX_FILE"
    done
  fi
}

# 🏁 Construcción del índice
{
  echo "# 📂 Índice de Notas"
  echo
  echo "- [🧠 Estudio](#estudio)"
  echo "- [🚀 Proyectos](#proyectos)"
  echo "- [📝 Diario](#diario)"
  echo
  echo "---"
} > "$INDEX_FILE"

# 🧠 🚀 📝 Secciones
print_section "study" "🧠" "Estudio"
print_section "project" "🚀" "Proyectos"
print_section "journal" "📝" "Diario"

