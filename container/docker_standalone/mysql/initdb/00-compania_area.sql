-- =============================================
-- BANCO DE DADOS: COMPANHIA AÉREA
-- Script para docker-entrypoint-initdb.d
-- =============================================

-- Criar o banco de dados
CREATE DATABASE IF NOT EXISTS companhia_aerea;
USE companhia_aerea;

-- =============================================
-- TABELA: PILOTO
-- =============================================
CREATE TABLE Piloto (
    ID_Piloto INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Numero_Registro VARCHAR(50) UNIQUE NOT NULL,
    Validade_Registro DATE NOT NULL,
    Data_Cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- TABELA: PASSAGEIRO
-- =============================================
CREATE TABLE Passageiro (
    ID_Passageiro INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(14) UNIQUE NOT NULL,
    Telefone VARCHAR(20),
    Endereco VARCHAR(200),
    Data_Cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- TABELA: VOO
-- =============================================
CREATE TABLE Voo (
    Numero_Voo VARCHAR(10) PRIMARY KEY,
    Hora_Partida TIME NOT NULL,
    Hora_Chegada TIME NOT NULL,
    Local_Partida VARCHAR(100) NOT NULL,
    Local_Destino VARCHAR(100) NOT NULL,
    ID_Piloto INT,
    Data_Cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Piloto) REFERENCES Piloto(ID_Piloto)
);

-- =============================================
-- TABELA: RESERVA
-- =============================================
CREATE TABLE Reserva (
    ID_Reserva INT PRIMARY KEY AUTO_INCREMENT,
    Numero_Voo VARCHAR(10) NOT NULL,
    ID_Passageiro INT NOT NULL,
    Numero_Cadeira VARCHAR(5) NOT NULL,
    Quantidade_Bagagens INT DEFAULT 0,
    Data_Reserva DATE NOT NULL,
    Data_Cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Numero_Voo) REFERENCES Voo(Numero_Voo),
    FOREIGN KEY (ID_Passageiro) REFERENCES Passageiro(ID_Passageiro),
    UNIQUE KEY uk_voo_cadeira (Numero_Voo, Numero_Cadeira),
    UNIQUE KEY uk_voo_passageiro (Numero_Voo, ID_Passageiro)
);

-- =============================================
-- ÍNDICES PARA MELHOR PERFORMANCE
-- =============================================
CREATE INDEX idx_voo_partida ON Voo(Hora_Partida);
CREATE INDEX idx_voo_destino ON Voo(Local_Destino);
CREATE INDEX idx_reserva_data ON Reserva(Data_Reserva);
CREATE INDEX idx_passageiro_nome ON Passageiro(Nome);

-- =============================================
-- MENSAGEM DE CONFIRMAÇÃO
-- =============================================
SELECT 'Banco de dados Companhia Aérea criado com sucesso!' AS Status;

