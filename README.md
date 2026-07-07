# 🐳 Docker Stacks

Coleção de configurações e stacks Docker (via `docker-compose`) para diversos serviços de infraestrutura, monitoramento e aplicações — organizadas para uso em ambiente **standalone**, com planos de expansão futura para **Docker Swarm**.

## 📂 Estrutura

```
container/
├── docker_standalone/     # Stacks rodando em modo standalone (docker-compose)
└── docker_swarm/          # (futuro) Mesmas stacks adaptadas para Swarm
```

## 📦 Stacks disponíveis

| Stack | Descrição |
|---|---|
| `atv4_compassuol_v1` | Aplicação full-stack (backend Python + frontend com Nginx) |
| `grafana_v1` | Grafana com dashboards e datasources pré-provisionados |
| `heimdall_v1` | Dashboard de aplicações (Heimdall) |
| `isc-bind9_v1` | Servidor DNS (BIND9) primário e secundário |
| `kea-dhcp_v1` | Servidor DHCP (Kea) com suporte a IPv4/IPv6 |
| `minio_v1` | Armazenamento de objetos compatível com S3 (MinIO) |
| `monitoramento_v5` | Stack de monitoramento (Prometheus, Alertmanager, Blackbox Exporter, MySQL/SNMP Exporters) |
| `mysql_v1` | Banco de dados MySQL com scripts de inicialização |
| `nginx_v1` | Servidor web Nginx com múltiplos sites |
| `nodered_v2` | Node-RED com simulação de sensores |
| `portainer_v1` | Interface de gerenciamento de containers |
| `traefik_v1` | Proxy reverso e load balancer |
| `zabbix_v1` | Monitoramento de infraestrutura (Zabbix) |

## 🚀 Como usar

Cada stack possui seu próprio `docker-compose.yaml` e, quando necessário, arquivos `.env` de configuração (não versionados por segurança). Para subir uma stack:

```bash
cd container/docker_standalone/<nome_da_stack>
docker compose up -d
```

> ⚠️ Alguns diretórios contêm arquivos `.env`, `.env.secrets` ou similares com credenciais de exemplo. **Nunca versione dados sensíveis reais** — use os `.gitignore` já presentes como referência e ajuste conforme necessário.

---

Repositório em constante expansão, servindo como laboratório de estudos e referência para configurações de containers em ambientes de homelab.