-- Criar o banco de dados
CREATE DATABASE Clinica;
USE Clinica;

-- Tabela MÉDICO
CREATE TABLE Medico (
    CRM VARCHAR(15) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    DataAdmissao DATE NOT NULL,
    Salario DECIMAL(10,2) NOT NULL
);

-- Tabela QUARTO
CREATE TABLE Quarto (
    Numero INT PRIMARY KEY,
    Andar INT NOT NULL
);

-- Tabela PACIENTE
CREATE TABLE Paciente (
    Codigo INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    RG VARCHAR(20) NOT NULL UNIQUE,
    CPF VARCHAR(14) NOT NULL UNIQUE,
    Endereco VARCHAR(200) NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    HorarioVisita TIME NOT NULL,
    CRM_Medico VARCHAR(15) NOT NULL,
    Numero_Quarto INT NOT NULL UNIQUE,
    
    -- Chaves estrangeiras
    FOREIGN KEY (CRM_Medico) REFERENCES Medico(CRM),
    FOREIGN KEY (Numero_Quarto) REFERENCES Quarto(Numero),
    
    -- Índices para melhor performance
    INDEX idx_medico (CRM_Medico),
    INDEX idx_quarto (Numero_Quarto)
);