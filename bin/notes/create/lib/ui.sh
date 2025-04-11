#!/run/current-system/sw/bin/bash

# ========================
# Módulo de Interfaz (UI)
# ========================

# Función: Seleccionar tipo de nota con íconos.
select_type() {
  echo "📘 ¿Qué tipo de nota querés crear?" >&2
  echo "1) 🛠 project" >&2
  echo "2) 📚 study" >&2
  echo "3) 📓 journal" >&2
  while true; do
    read -rp "Elegí una opción [1-3]: " type_choice
    case $type_choice in
      1) echo "project"; return ;;
      2) echo "study"; return ;;
      3) echo "journal"; return ;;
      *) echo "❌ Opción inválida, intente de nuevo." >&2 ;;
    esac
  done
}

# Función: Seleccionar o crear categoría (para study y project)
select_category() {
  local base_path="$1"
  mapfile -t subfolders < <(find "$base_path" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; 2>/dev/null)

  if [ ${#subfolders[@]} -eq 0 ]; then
    while true; do
      read -rp "🆕 No hay categorías. Ingresá el nombre de la nueva categoría: " new_cat
      if [[ -n "$new_cat" ]]; then
        echo "$new_cat"
        return
      else
        echo "❌ No se puede dejar vacío. Intente de nuevo." >&2
      fi
    done
  else
    echo "Categorías disponibles:" >&2
    local i=1
    for folder in "${subfolders[@]}"; do
      echo "$i) $folder" >&2
      ((i++))
    done
    echo "$i) ➕ Crear nueva categoría" >&2
    while true; do
      read -rp "Elegí una opción (número): " choice
      if [[ "$choice" -ge 1 && "$choice" -le ${#subfolders[@]} ]]; then
        echo "${subfolders[$((choice-1))]}"
        return
      elif [[ "$choice" -eq $(( ${#subfolders[@]} + 1 )) ]]; then
        while true; do
          read -rp "🆕 Ingresá el nombre de la nueva categoría: " new_cat
          if [[ -n "$new_cat" ]]; then
            echo "$new_cat"
            return
          else
            echo "❌ No se puede dejar vacío. Intente de nuevo." >&2
          fi
        done
      else
        echo "❌ Opción inválida. Intente de nuevo." >&2
      fi
    done
  fi
}

# Función: Solicitar y formatear tags (para study y project)
get_tags() {
  while true; do
    read -rp "🏷 Tags (separados por espacio): " tags_input
    if [[ -n "$tags_input" ]]; then
      echo "$(echo "$tags_input" | tr ' ' ', ')"
      return
    else
      echo "❌ Debe ingresar al menos un tag." >&2
    fi
  done
}

