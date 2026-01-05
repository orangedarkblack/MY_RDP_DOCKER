#!/bin/bash
# Script para obtener el ID de AnyDesk del contenedor Docker

CONTAINER_NAME="remote-desktop"

echo "Obteniendo ID de AnyDesk desde el contenedor..."
ID=$(sudo docker exec -u ubuntu $CONTAINER_NAME bash -c "export DISPLAY=:99; anydesk --get-id 2>/dev/null")

if [ $? -eq 0 ]; then
    echo "ID de AnyDesk: $ID"
else
    echo "Error al obtener el ID"
fi
