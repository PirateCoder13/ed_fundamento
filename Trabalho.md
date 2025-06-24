```markdown

**JOÃO GUALBERTO BOISSA NETTO**

**JOSÉ OTAVIO CHACOROWSKI RAIMUNDO**

**BANCO DE DADOS RELACIONAL DE UM MINIMUNDO DE UMA LOCADORA DE MÁQUINAS**

**CURITIBA**

**2024**

**EDUARDA HORNING BZUNEK**

**JOÃO GUALBERTO BOISSA NETTO**

**JOSÉ OTAVIO CHACOROWSKI RAIMUNDO**

**BANCO DE DADOS RELACIONAL DE UM MINIMUNDO DE UMA LOCADORA DE MÁQUINAS**

Trabalho realizado para a matéria Banco de Dados, da Universidade Tuiuti do Paraná. Este trabalho descreve como foi realizado a implementação de um banco de dados relacional. O objetivo é desenvolver e aplicar as habilidades desenvolvidas na matéria. 

Professor: Edivaldo de Araujo Pereira

**CURITIBA**

**2024**

**RESUMO**

O projeto proposto é Mini-Mundo de uma Locadora de Máquinas que consiste na modelagem de um banco de dados para uma locadora de máquinas e equipamentos. Onde os clientes podem alugar máquinas para utilizá-las em suas obras. Cada obra pode ter diversas máquinas associadas e pode contar com operadores responsáveis pela operação dos equipamentos. Também há os outros relacionamentos que ocorrem dentro da empresa, como o processo de locação e o registro de funcionários e seus relacionamentos com máquinas e obras

**Sumário**

[PASSO 1: MODELO CONCEITUAL](#passo-1:-modelo-conceitual)

[PASSO 2: MODELO LÓGICO](#passo-2:-modelo-lógico)

[PASSO 3: BANCO INSTANCIADO](#passo-3:-banco-instanciado)

[PASSO 4: INSERÇÃO DE DADOS](#passo-4:-inserção-de-dados)

[PASSO 5: CONSULTAS BÁSICAS](#passo-5:-consultas-básicas)

[PASSO 6: CONSULTAS AVANÇADAS](#passo-6:-consultas-avançadas)

[ANÁLISE DOS RESULTADOS](#análise-dos-resultados)

[CONSIDERAÇÕES FINAIS](#considerações-finais)

# **PASSO 1: MODELO CONCEITUAL** {#passo-1:-modelo-conceitual}

![][image1]

![][image2]

Descrição:

O modelo conceitual descreve, de maneira geral, as entidades do sistema e seus relacionamentos:

* Cliente realiza Locações de Máquinas/Equipamentos.  
* Máquinas/Equipamentos podem ser operados por Operadores.  
* Máquinas/Equipamentos são utilizados em Obras.  
* Cada Operador pode operar várias máquinas em diferentes obras.

# **PASSO 2: MODELO LÓGICO** {#passo-2:-modelo-lógico}

![][image3]

Descrição:

O modelo lógico define:

* Entidades como tabelas com seus atributos.  
* Definição das chaves primárias (PK) e estrangeiras (FK).  
* Tipos de dados apropriados para cada atributo.  
* Regras de integridade referencial.

# **PASSO 3: BANCO INSTANCIADO** {#passo-3:-banco-instanciado}

\-- Criação do banco de dados

CREATE DATABASE locadora\_maquinas;

USE locadora\_maquinas;

\-- Tabela de Clientes

CREATE TABLE clientes (

    id\_cliente INT AUTO\_INCREMENT PRIMARY KEY,

    nome VARCHAR(100) NOT NULL,

    contato VARCHAR(100),

    credito DECIMAL(10,2),

    pagamento VARCHAR(50)

);

\-- Tabela de Operadores/Colaboradores/Consultores

CREATE TABLE operadores (

    id\_operador INT AUTO\_INCREMENT PRIMARY KEY,

    nome VARCHAR(100) NOT NULL,

    funcao VARCHAR(50),

    habilitacao VARCHAR(50)

);

\-- Tabela de Obras

CREATE TABLE obras (

    id\_obra INT AUTO\_INCREMENT PRIMARY KEY,

    nome VARCHAR(100) NOT NULL,

    tipo VARCHAR(50),

    localizacao VARCHAR(100),

    id\_proprietario INT,

    id\_consultor INT,

    FOREIGN KEY (id\_proprietario) REFERENCES clientes(id\_cliente),

    FOREIGN KEY (id\_consultor) REFERENCES operadores(id\_operador)

);

\-- Tabela de Máquinas/Equipamentos

CREATE TABLE maquinas (

    id\_maquina INT AUTO\_INCREMENT PRIMARY KEY,

    descricao VARCHAR(100) NOT NULL,

    tipo VARCHAR(50),

    status VARCHAR(20),

    despesa DECIMAL(10,2),

    manutencao VARCHAR(100)

);

\-- Tabela de Locações

CREATE TABLE locacoes (

    id\_locacao INT AUTO\_INCREMENT PRIMARY KEY,

    data\_inicio DATE,

    data\_fim DATE,

    status VARCHAR(20),

    retirada DATE,

    entrega DATE,

    devolucao DATE,

    id\_cliente INT,

    FOREIGN KEY (id\_cliente) REFERENCES clientes(id\_cliente)

);

\-- Tabela de relacionamento: Loca (Locações x Máquinas)

CREATE TABLE loca (

    id\_locacao INT,

    id\_maquina INT,

    PRIMARY KEY (id\_locacao, id\_maquina),

    FOREIGN KEY (id\_locacao) REFERENCES locacoes(id\_locacao),

    FOREIGN KEY (id\_maquina) REFERENCES maquinas(id\_maquina)

);

\-- Tabela de relacionamento: Utilização de Máquina em Obra

CREATE TABLE utilizacao\_obra (

    id\_maquina INT,

    id\_obra INT,

    PRIMARY KEY (id\_maquina, id\_obra),

    FOREIGN KEY (id\_maquina) REFERENCES maquinas(id\_maquina),

    FOREIGN KEY (id\_obra) REFERENCES obras(id\_obra)

);

\-- Tabela de relacionamento: Pode Operar (Máquina x Operador)

CREATE TABLE pode\_operar (

    id\_maquina INT,

    id\_operador INT,

    PRIMARY KEY (id\_maquina, id\_operador),

    FOREIGN KEY (id\_maquina) REFERENCES maquinas(id\_maquina),

    FOREIGN KEY (id\_operador) REFERENCES operadores(id\_operador)

);

\-- Tabela de relacionamento: Operação de Máquina em Obra

CREATE TABLE operacao\_maquina\_obra (

    id\_obra INT,

    id\_maquina INT,

    id\_operador INT,

    PRIMARY KEY (id\_obra, id\_maquina, id\_operador),

    FOREIGN KEY (id\_obra) REFERENCES obras(id\_obra),

    FOREIGN KEY (id\_maquina) REFERENCES maquinas(id\_maquina),

    FOREIGN KEY (id\_operador) REFERENCES operadores(id\_operador)

);

![][image4]

# **PASSO 4: INSERÇÃO DE DADOS** {#passo-4:-inserção-de-dados}

Para validar o funcionamento do banco de dados, foram inseridos dados de exemplo nas tabelas criadas:

```sql
-- Inserção de dados em Clientes
INSERT INTO clientes (nome, contato, credito, pagamento) VALUES
('Construtora ABC Ltda', 'contato@abc.com.br', 150000.00, 'Cartão'),
('Obras Silva & Cia', 'silva@obras.com', 200000.00, 'Boleto'),
('Empreiteira Santos', 'santos@empreiteira.com', 100000.00, 'PIX'),
('Construções Oliveira', 'oliveira@construcoes.com', 180000.00, 'Transferência'),
('Engenharia Costa', 'costa@engenharia.com', 120000.00, 'Cartão');

-- Inserção de dados em Operadores
INSERT INTO operadores (nome, funcao, habilitacao) VALUES
('João Silva', 'Operador', 'Escavadeira'),
('Maria Santos', 'Consultor', 'Engenharia Civil'),
('Pedro Oliveira', 'Operador', 'Guincho'),
('Ana Costa', 'Supervisor', 'Segurança do Trabalho'),
('Carlos Lima', 'Operador', 'Betoneira');

-- Inserção de dados em Máquinas
INSERT INTO maquinas (descricao, tipo, status, despesa, manutencao) VALUES
('Escavadeira Hidráulica CAT 320', 'Escavadeira', 'Disponível', 500.00, 'Em dia'),
('Guincho 50 toneladas', 'Guincho', 'Disponível', 800.00, 'Em dia'),
('Betoneira 400L', 'Betoneira', 'Manutenção', 200.00, 'Pendente'),
('Retroescavadeira JCB', 'Retroescavadeira', 'Disponível', 450.00, 'Em dia'),
('Compressor de ar 200L', 'Compressor', 'Disponível', 150.00, 'Em dia');

-- Inserção de dados em Obras
INSERT INTO obras (nome, tipo, localizacao, id_proprietario, id_consultor) VALUES
('Edifício Comercial Centro', 'Comercial', 'Centro - Curitiba', 1, 2),
('Residencial Park View', 'Residencial', 'Batel - Curitiba', 2, 2),
('Galpão Industrial', 'Industrial', 'CIC - Curitiba', 3, 4),
('Shopping Mall Norte', 'Comercial', 'Capão Raso - Curitiba', 4, 2),
('Condomínio Residencial', 'Residencial', 'Água Verde - Curitiba', 5, 4);
```

# **PASSO 5: CONSULTAS BÁSICAS** {#passo-5:-consultas-básicas}

Foram desenvolvidas consultas SQL para extrair informações relevantes do banco de dados:

```sql
-- 1. Listar todos os clientes com seus dados de contato
SELECT nome, contato, credito, pagamento 
FROM clientes 
ORDER BY nome;

-- 2. Mostrar máquinas disponíveis para locação
SELECT descricao, tipo, status, despesa 
FROM maquinas 
WHERE status = 'Disponível' 
ORDER BY despesa;

-- 3. Listar operadores e suas habilitações
SELECT nome, funcao, habilitacao 
FROM operadores 
ORDER BY funcao, nome;

-- 4. Consultar obras em andamento com seus proprietários
SELECT o.nome AS obra, o.tipo, o.localizacao, c.nome AS proprietario
FROM obras o
JOIN clientes c ON o.id_proprietario = c.id_cliente
ORDER BY o.nome;

-- 5. Verificar máquinas que precisam de manutenção
SELECT descricao, tipo, status, manutencao
FROM maquinas
WHERE status = 'Manutenção' OR manutencao = 'Pendente';
```

# **PASSO 6: CONSULTAS AVANÇADAS** {#passo-6:-consultas-avançadas}

Consultas mais complexas foram desenvolvidas para análises específicas:

```sql
-- 1. Relatório de obras com consultores responsáveis
SELECT 
    o.nome AS obra,
    o.tipo,
    o.localizacao,
    c.nome AS proprietario,
    op.nome AS consultor,
    op.funcao
FROM obras o
JOIN clientes c ON o.id_proprietario = c.id_cliente
JOIN operadores op ON o.id_consultor = op.id_operador
ORDER BY o.nome;

-- 2. Análise de custos por tipo de máquina
SELECT 
    tipo,
    COUNT(*) AS quantidade,
    AVG(despesa) AS custo_medio,
    MIN(despesa) AS menor_custo,
    MAX(despesa) AS maior_custo
FROM maquinas
GROUP BY tipo
ORDER BY custo_medio DESC;

-- 3. Clientes com maior potencial de crédito
SELECT 
    nome,
    contato,
    credito,
    CASE 
        WHEN credito >= 150000 THEN 'Alto'
        WHEN credito >= 100000 THEN 'Médio'
        ELSE 'Baixo'
    END AS categoria_credito
FROM clientes
ORDER BY credito DESC;

-- 4. Status geral do parque de máquinas
SELECT 
    status,
    COUNT(*) AS quantidade,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM maquinas)), 2) AS percentual
FROM maquinas
GROUP BY status;
```

# **ANÁLISE DOS RESULTADOS** {#análise-dos-resultados}

O banco de dados implementado demonstrou eficiência na organização e recuperação das informações da locadora de máquinas. Os principais benefícios observados foram:

## **Organização de Dados**
- **Estruturação clara** das entidades e relacionamentos
- **Integridade referencial** garantida através das chaves estrangeiras
- **Normalização adequada** evitando redundâncias

## **Funcionalidades Implementadas**
- **Gestão de clientes** com controle de crédito e formas de pagamento
- **Controle de máquinas** incluindo status e manutenção
- **Administração de obras** com vínculo aos proprietários e consultores
- **Relacionamentos complexos** entre máquinas, operadores e obras

## **Capacidades de Consulta**
- **Consultas simples** para operações básicas do dia a dia
- **Relatórios analíticos** para tomada de decisões gerenciais
- **Agregações e estatísticas** para controle financeiro e operacional

# **CONSIDERAÇÕES FINAIS** {#considerações-finais}

O projeto desenvolvido foi capaz de representar de forma eficiente o mini-mundo de uma locadora de máquinas, atendendo às necessidades de locação, gestão de máquinas, operação em obras e administração de clientes.

## **Objetivos Alcançados**

O sistema de banco de dados implementado conseguiu:

1. **Modelar adequadamente** as entidades e relacionamentos do negócio
2. **Implementar estruturas** que garantem a integridade dos dados
3. **Fornecer flexibilidade** para consultas e relatórios diversos
4. **Suportar operações** essenciais de uma locadora de máquinas

## **Benefícios do Sistema**

- **Centralização** de todas as informações da locadora
- **Controle eficiente** do status das máquinas e manutenções
- **Gestão integrada** de clientes, obras e operadores
- **Facilidade** na geração de relatórios gerenciais
- **Escalabilidade** para crescimento futuro do negócio

## **Possibilidades de Expansão**

O modelo desenvolvido permite futuras expansões, como:

- **Módulo financeiro** com controle de pagamentos e inadimplência
- **Sistema de agendamento** para otimização do uso das máquinas
- **Controle de estoque** de peças e componentes para manutenção
- **Dashboard gerencial** com indicadores de performance
- **Integração** com sistemas de GPS para rastreamento das máquinas

## **Aprendizados Obtidos**

Este trabalho proporcionou a aplicação prática dos conceitos fundamentais de banco de dados:

- **Modelagem conceitual e lógica** de sistemas reais
- **Implementação** de estruturas relacionais
- **Desenvolvimento** de consultas SQL complexas
- **Análise** de requisitos de negócio
- **Validação** através de dados e consultas de teste

O projeto demonstra a importância dos bancos de dados relacionais na organização e gestão eficiente de informações empresariais, consolidando os conhecimentos adquiridos na disciplina.

---

## **REFERÊNCIAS**

- ELMASRI, R.; NAVATHE, S. B. **Sistemas de Banco de Dados**. 7ª ed. São Paulo: Pearson, 2019.
- DATE, C. J. **Introdução a Sistemas de Bancos de Dados**. 8ª ed. Rio de Janeiro: Elsevier, 2004.
- SILBERSCHATZ, A.; GALVIN, P. B.; GAGNE, G. **Fundamentos de Sistemas de Banco de Dados**. 6ª ed. São Paulo: McGraw-Hill, 2012.
- Material didático da disciplina Banco de Dados - Universidade Tuiuti do Paraná, 2024.
