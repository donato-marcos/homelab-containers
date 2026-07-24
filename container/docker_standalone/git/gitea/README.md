```bash
# Para criar um usuário administrador no GITEA (Mude a senha depois do primeiro acesso)
 docker compose -f git/gitea/docker-compose.yaml exec -u git server gitea admin user create --username admin --password alunofatec --email admin@fatec.lab --admin
```