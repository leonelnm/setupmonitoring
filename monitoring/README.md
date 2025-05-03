# VPS Monitoring (Prometheus + Grafana + Node Exporter)

Este setup en Docker te da un stack completo para monitorear tu VPS:

- **Prometheus**: recolecta métricas.
- **Node Exporter**: métricas del sistema host (CPU, RAM, red...).
- **Grafana**: dashboards visuales para tus métricas.

## Uso

1. Clona el repositorio en tu VPS:

```bash
git clone https://github.com/tuusuario/vps-monitoring.git
cd vps-monitoring
```

2. Levanta todo con Docker Compose:

```bash
docker compose up -d
```

3. Accede a:

- Prometheus: http://TU-IP:9090
- Grafana: http://TU-IP:3000 (usuario: `admin`, contraseña: `admin`)

4. En Grafana, añade Prometheus como datasource (URL: `http://prometheus:9090`)

5. Importa dashboards públicos desde [Grafana.com/dashboards](https://grafana.com/grafana/dashboards/)

