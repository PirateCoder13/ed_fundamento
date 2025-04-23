-- Criação do banco de dados
CREATE DATABASE locadora_maquinas;
USE locadora_maquinas;

-- Tabela de Clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    contato VARCHAR(100),
    credito DECIMAL(10,2),
    pagamento VARCHAR(50)
);

-- Tabela de Operadores/Colaboradores/Consultores
CREATE TABLE operadores (
    id_operador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    funcao VARCHAR(50),
    habilitacao VARCHAR(50)
);

-- Tabela de Obras
CREATE TABLE obras (
    id_obra INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    localizacao VARCHAR(100),
    id_proprietario INT,
    id_consultor INT,
    FOREIGN KEY (id_proprietario) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_consultor) REFERENCES operadores(id_operador)
);

-- Tabela de Máquinas/Equipamentos
CREATE TABLE maquinas (
    id_maquina INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    status VARCHAR(20),
    despesa DECIMAL(10,2),
    manutencao VARCHAR(100)
);

-- Tabela de Locações
CREATE TABLE locacoes (
    id_locacao INT AUTO_INCREMENT PRIMARY KEY,
    data_inicio DATE,
    data_fim DATE,
    status VARCHAR(20),
    retirada DATE,
    entrega DATE,
    devolucao DATE,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Tabela de relacionamento: Loca (Locações x Máquinas)
CREATE TABLE loca (
    id_locacao INT,
    id_maquina INT,
    PRIMARY KEY (id_locacao, id_maquina),
    FOREIGN KEY (id_locacao) REFERENCES locacoes(id_locacao),
    FOREIGN KEY (id_maquina) REFERENCES maquinas(id_maquina)
);

-- Tabela de relacionamento: Utilização de Máquina em Obra
CREATE TABLE utilizacao_obra (
    id_maquina INT,
    id_obra INT,
    PRIMARY KEY (id_maquina, id_obra),
    FOREIGN KEY (id_maquina) REFERENCES maquinas(id_maquina),
    FOREIGN KEY (id_obra) REFERENCES obras(id_obra)
);

-- Tabela de relacionamento: Pode Operar (Máquina x Operador)
CREATE TABLE pode_operar (
    id_maquina INT,
    id_operador INT,
    PRIMARY KEY (id_maquina, id_operador),
    FOREIGN KEY (id_maquina) REFERENCES maquinas(id_maquina),
    FOREIGN KEY (id_operador) REFERENCES operadores(id_operador)
);

-- Tabela de relacionamento: Operação de Máquina em Obra
CREATE TABLE operacao_maquina_obra (
    id_obra INT,
    id_maquina INT,
    id_operador INT,
    PRIMARY KEY (id_obra, id_maquina, id_operador),
    FOREIGN KEY (id_obra) REFERENCES obras(id_obra),
    FOREIGN KEY (id_maquina) REFERENCES maquinas(id_maquina),
    FOREIGN KEY (id_operador) REFERENCES operadores(id_operador)
);
