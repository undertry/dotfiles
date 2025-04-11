#!/run/current-system/sw/bin/bash

# Directorio base para las notas
NOTES_DIR="$HOME/Documents/Notes"

# Editor preferido
EDITOR="hx"

# Formato de fecha
DATE=$(date +%Y-%m-%d)
DATETIME=$(date +%Y-%m-%d_%H-%M-%S)

# Ruta base de plantillas externas
TEMPLATES_DIR="$(dirname "$0")/templates"
