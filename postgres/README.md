# PostgreSQL + pgAdmin en Docker

Este proyecto monta un **servidor PostgreSQL** y un **pgAdmin** (interfaz web de administración) dentro de un VPS usando Docker.
La configuración está preparada para que:

* **PostgreSQL** solo sea accesible desde la red interna de Docker (`database-net`).
* **pgAdmin** esté disponible vía navegador con HTTPS detrás de **nginx-proxy**.
* Las credenciales y datos sensibles se manejen mediante un archivo `.env`.

---

## 🚀 Requisitos previos

* Docker y Docker Compose instalados en el VPS.
* Un `nginx-proxy` y `acme-companion` ya corriendo (para certificados HTTPS).
* Un dominio apuntando al VPS (ejemplo: `pgadmin.tu-dominio.com`).
* Crear red de docker `docker network create name-net`

---

## 📂 Estructura del proyecto

```
.
├── docker-compose.yml
├── .env.example   # ejemplo de variables de entorno
├── .env           # tu configuración real (NO subir a git)
└── data/
    ├── postgres/  # datos persistentes de PostgreSQL
    └── pgadmin/   # datos persistentes de pgAdmin
```

---

## ⚙️ Configuración

1. Copia el archivo de ejemplo y edítalo:

   ```bash
   cp .env.example .env
   nano .env
   ```

2. Ajusta las variables con tus datos (usuario, contraseñas, dominio, correo).

3. Levanta los servicios:

   ```bash
   docker compose up -d
   ```

4. Verifica que los contenedores estén corriendo:

   ```bash
   docker ps
   ```

5. Accede a **pgAdmin** en tu navegador:

   ```
   https://pgadmin.tu-dominio.com
   ```

6. Desde pgAdmin, crea conexiones a PostgreSQL usando:

   * **Host**: `postgres` (nombre del servicio en `docker-compose`)
   * **Puerto**: `5432`
   * **Usuario** y **Password**: los definidos en tu `.env`

---

## 🗄️ Backup & Restore (opcional)

Hacer backup manual:

```bash
docker exec -t postgres-main pg_dumpall -U $POSTGRES_USER > backups/dump.sql
```

Restaurar backup:

```bash
cat backups/dump.sql | docker exec -i postgres-main psql -U $POSTGRES_USER
```

---

## 🔒 Recomendaciones de seguridad

* Nunca expongas `5432` en el `docker-compose`.
* Usa usuarios separados para cada aplicación (`CREATE USER` + `GRANT`).
* Limita el acceso a pgAdmin con usuarios y contraseñas fuertes.
* Haz backups regulares.

---

# Variables para PostgreSQL

POSTGRES_USER=admin
POSTGRES_PASSWORD=super-secret-pass

# Variables para pgAdmin

PGADMIN_DEFAULT_EMAIL=[admin@example.com](mailto:admin@example.com)
PGADMIN_DEFAULT_PASSWORD=super-secret-pgadmin

# Dominio donde se servirá pgAdmin

PGADMIN_DOMAIN=pgadmin.tu-dominio.com
