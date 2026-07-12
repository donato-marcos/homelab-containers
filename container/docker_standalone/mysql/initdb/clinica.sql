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

-- Inserir dados de exemplo
INSERT INTO Medico (CRM, Nome, DataAdmissao, Salario) VALUES
('CRM-SP12345', 'Dr. João Silva', '2020-03-15', 15000.00),
('CRM-SP67890', 'Dra. Maria Santos', '2019-07-20', 16000.00),
('CRM-SP54321', 'Dr. Pedro Oliveira', '2021-01-10', 14000.00);

INSERT INTO Quarto (Numero, Andar) VALUES
(101, 1),
(102, 1),
(201, 2),
(202, 2),
(301, 3);

INSERT INTO Paciente (Nome, RG, CPF, Endereco, Telefone, HorarioVisita, CRM_Medico, Numero_Quarto) VALUES
('Ana Costa', '12.345.678-9', '123.456.789-00', 'Rua A, 100', '(11) 9999-1111', '14:00:00', 'CRM-SP12345', 101),
('Carlos Lima', '98.765.432-1', '987.654.321-00', 'Av B, 200', '(11) 8888-2222', '16:30:00', 'CRM-SP67890', 102),
('Mariana Souza', '11.223.344-5', '111.222.333-44', 'Rua C, 300', '(11) 7777-3333', '15:15:00', 'CRM-SP12345', 201);

-- Consulta para verificar os dados
SELECT 
    p.Codigo,
    p.Nome AS Paciente,
    p.HorarioVisita,
    m.Nome AS MedicoResponsavel,
    m.CRM,
    q.Numero AS Quarto,
    q.Andar
FROM Paciente p
INNER JOIN Medico m ON p.CRM_Medico = m.CRM
INNER JOIN Quarto q ON p.Numero_Quarto = q.Numero;
