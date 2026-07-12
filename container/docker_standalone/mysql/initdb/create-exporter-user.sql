-- Criação do usuário 'exporter' para monitoramento pelo mysqld-exporter
CREATE USER IF NOT EXISTS 'exporter'@'%' IDENTIFIED BY 'exporter123' WITH MAX_USER_CONNECTIONS 3;

-- Concedendo apenas as permissões necessárias
GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'%';

-- Aplicando as permissões
FLUSH PRIVILEGES;

