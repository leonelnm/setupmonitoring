#!/bin/bash

# Nombre de la red para nginx-proxy
NETWORK_NAME="nginx-proxy"

# Función para crear la red si no existe
create_network() {
    if ! docker network ls | grep -q "$NETWORK_NAME"; then
        echo "Creando la red Docker: $NETWORK_NAME"
        docker network create "$NETWORK_NAME"
    else
        echo "La red Docker '$NETWORK_NAME' ya existe."
    fi
}

# Función para levantar los servicios con docker compose
start_services() {
    echo "Levantando contenedores de nginx-proxy..."
    cd nginx-proxy || { echo "Directorio 'nginx-proxy' no encontrado"; exit 1; }
    docker compose up -d
    cd ..

    if [ -d "monitoring" ]; then
        echo "Levantando contenedores de monitoring..."
        cd monitoring || exit 1
        docker compose up -d
        cd ..
    else
        echo "Directorio 'monitoring' no encontrado. Omitiendo."
    fi
}

# Función para detener los servicios
stop_services() {
    echo "Deteniendo contenedores de nginx-proxy..."
    cd nginx-proxy || { echo "Directorio 'nginx-proxy' no encontrado"; exit 1; }
    docker compose down
    cd ..

    if [ -d "monitoring" ]; then
        echo "Deteniendo contenedores de monitoring..."
        cd monitoring || exit 1
        docker compose down
        cd ..
    else
        echo "Directorio 'monitoring' no encontrado. Omitiendo."
    fi
}

# Comprobar el parámetro
case "$1" in
    up)
        create_network
        start_services
        ;;
    down)
        stop_services
        ;;
    *)
        echo "Uso: $0 {up|down}"
        exit 1
        ;;
esac
