UNIVERSIDADE TUIUTI DO PARANÁ
*Credenciada por Decreto Presidencial de 07 de julho de 1997*

**FACULDADE:** Faculdade de Ciências Exatas e de Tecnologia – FACET  
**CURSO:** Tecnologia em Análise e Desenvolvimento de Sistemas  
**DISCIPLINA:** Fundamentos de Banco de Dados  
**ANO:** 2025/1 **PERÍODO:** 3º **REGIME:** Semestral **C/H:** 80  
**PROFESSOR:** Edivaldo de Araújo Pereira  

---

# EDUARDA HORNING BZUNEK
# JOÃO GUALBERTO BOISSA NETTO  
# JOSÉ OTAVIO CHACOROWSKI RAIMUNDO

---

# BANCO DE DADOS RELACIONAL DE UM MINIMUNDO DE UMA LOCADORA DE MÁQUINAS

---

**Trabalho realizado para a matéria Fundamentos de Banco de Dados, da Universidade Tuiuti do Paraná. Este trabalho descreve como foi realizada a implementação de um banco de dados relacional. O objetivo é desenvolver e aplicar as habilidades desenvolvidas na matéria.**

**Professor:** Edivaldo de Araújo Pereira

---

**CURITIBA**  
**2025**

---

## RESUMO

O projeto proposto é Mini-Mundo de uma Locadora de Máquinas que consiste na modelagem de um banco de dados para uma locadora de máquinas e equipamentos. Onde os clientes podem alugar máquinas para utilizá-las em suas obras. Cada obra pode ter diversas máquinas associadas e pode contar com operadores responsáveis pela operação dos equipamentos. Também há os outros relacionamentos que ocorrem dentro da empresa, como o processo de locação e o registro de funcionários e seus relacionamentos com máquinas e obras.

O banco de dados implementado atende completamente aos requisitos estabelecidos, com 9 tabelas relacionais, mais de 70 registros inseridos e todas as consultas SQL funcionando adequadamente, demonstrando a aplicação prática dos conceitos de modelagem de dados, normalização e linguagem SQL.

---

## SUMÁRIO

1. INTRODUÇÃO
2. OBJETIVOS  
3. METODOLOGIA
4. DESENVOLVIMENTO
   - PASSO 1: MODELO CONCEITUAL
   - PASSO 2: MODELO LÓGICO
   - PASSO 3: INSTANCIAÇÃO DO BANCO DE DADOS
   - PASSO 4: INSERÇÃO DE DADOS E COMANDOS DML
   - PASSO 5: CONSULTAS BÁSICAS (SELEÇÃO, PROJEÇÃO, JUNÇÃO)
   - PASSO 6: CONSULTAS AVANÇADAS (SUBCONSULTAS, FUNÇÕES AGREGADAS, GROUP BY)
5. RESULTADOS
6. ESTRUTURA DE ARQUIVOS
7. INSTRUÇÕES DE EXECUÇÃO
8. CONSIDERAÇÕES FINAIS

---

### 1. INTRODUÇÃO

Este trabalho apresenta o desenvolvimento completo de um banco de dados relacional para suportar o sistema de uma Locadora de Máquinas. O projeto foi desenvolvido seguindo todos os passos metodológicos estabelecidos, desde a modelagem conceitual até a implementação de consultas avançadas em SQL.

### 2. OBJETIVOS

O objetivo principal deste estudo dirigido é implementar um banco de dados relacional capaz de representar o "mini-mundo" de uma Locadora de Máquinas, contemplando:

- **Máquinas/Equipamentos:** Controle de tipos, despesas e manutenção
- **Operadores/Colaboradores/Consultores:** Gestão de funções e habilitações
- **Clientes:** Identificação, crédito e formas de pagamento
- **Obras:** Tipos, localização e responsáveis
- **Locações:** Controle de itens locados e status

### 3. METODOLOGIA

O desenvolvimento seguiu rigorosamente os 6 passos estabelecidos:

1. **Passo 1:** Modelo Conceitual (DER)
2. **Passo 2:** Modelo Lógico/Físico
3. **Passo 3:** Instanciação do Banco de Dados
4. **Passo 4:** Inserção de Dados e Comandos DML
5. **Passo 5:** Consultas Básicas (Seleção, Projeção, Junção)
6. **Passo 6:** Consultas Avançadas (Subconsultas, Funções Agregadas, GROUP BY)

### 4. DESENVOLVIMENTO

### PASSO 1: MODELO CONCEITUAL

O modelo conceitual foi desenvolvido identificando as principais entidades do domínio:

- **CLIENTES:** Empresas e pessoas físicas que locam máquinas
- **OPERADORES:** Profissionais habilitados para operar máquinas
- **MÁQUINAS:** Equipamentos disponíveis para locação
- **OBRAS:** Projetos onde as máquinas são utilizadas
- **LOCAÇÕES:** Contratos de aluguel de máquinas

**Relacionamentos identificados:**
- Cliente REALIZA Locação (1:N)
- Locação INCLUI Máquina (N:M)
- Operador PODE_OPERAR Máquina (N:M)
- Máquina É_UTILIZADA_EM Obra (N:M)
- Obra TEM Proprietário (Cliente) (N:1)
- Obra TEM Consultor (Operador) (N:1)
- Operador TRABALHA_EM Obra com Máquina (N:M:M)

### PASSO 2: MODELO LÓGICO

O modelo lógico resultou em 9 tabelas:

1. **clientes** (id_cliente, nome, contato, credito, pagamento)
2. **operadores** (id_operador, nome, funcao, habilitacao)
3. **maquinas** (id_maquina, descricao, tipo, status, despesa, manutencao)
4. **obras** (id_obra, nome, tipo, localizacao, id_proprietario, id_consultor)
5. **locacoes** (id_locacao, data_inicio, data_fim, status, retirada, entrega, devolucao, id_cliente)
6. **loca** (id_locacao, id_maquina) - Relacionamento N:M
7. **utilizacao_obra** (id_maquina, id_obra) - Relacionamento N:M
8. **pode_operar** (id_maquina, id_operador) - Relacionamento N:M
9. **operacao_maquina_obra** (id_obra, id_maquina, id_operador) - Relacionamento ternário

### PASSO 3: INSTANCIAÇÃO DO BANCO DE DADOS

O banco de dados foi criado utilizando MySQL, com todas as restrições de integridade referencial implementadas através de chaves estrangeiras. O script de criação está disponível em `Passo-3/ed_fundamento.sql`.

**Script de criação das tabelas:**

```sql
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

-- Demais tabelas com relacionamentos...
```

### PASSO 4: INSERÇÃO DE DADOS E COMANDOS DML

Foram inseridos dados de teste em todas as tabelas, respeitando o mínimo de 5 registros por tabela:

- **7 clientes** representando diferentes tipos de empresas
- **7 operadores** com diferentes funções e habilitações
- **7 obras** de diversos tipos (residencial, industrial, comercial, etc.)
- **8 máquinas** de diferentes categorias (terraplenagem, construção, transporte, etc.)
- **7 locações** em diferentes status e períodos

**Comandos DML implementados:**
- **5 comandos UPDATE:** Atualizações de crédito, status, funções, etc.
- **5 comandos DELETE:** Remoções de relacionamentos e registros

### PASSO 5: CONSULTAS BÁSICAS (SELEÇÃO, PROJEÇÃO, JUNÇÃO)

Implementadas 15 consultas demonstrando as operações relacionais fundamentais:

**Consultas de Seleção (5):**
- Clientes com crédito acima de R$ 70.000
- Máquinas disponíveis
- Operadores consultores
- Locações ativas
- Obras residenciais

**Consultas de Projeção (5):**
- Nome e contato de clientes
- Descrição e tipo de máquinas
- Nome e função de operadores
- Nome e tipo de obras
- Datas de locações

**Consultas de Junção (5):**
- Locações com nomes de clientes
- Obras com proprietários e consultores
- Máquinas locadas com detalhes
- Operadores e suas habilitações
- Operações completas em obras

### PASSO 6: CONSULTAS AVANÇADAS (SUBCONSULTAS, FUNÇÕES AGREGADAS, GROUP BY)

Desenvolvidas 15 consultas complexas demonstrando técnicas avançadas:

**Subconsultas (5):**
- Clientes que fizeram locações
- Máquinas nunca locadas
- Operadores em obras residenciais
- Clientes com crédito acima da média
- Máquinas da obra com mais equipamentos

**Funções Agregadas (5):**
- Contagem total de clientes
- Estatísticas de crédito (média, min, max)
- Análise de despesas com máquinas
- Contagem de locações por status
- Distribuição de máquinas por tipo

**GROUP BY (5):**
- Locações por cliente
- Obras por tipo
- Despesas por tipo de máquina
- Habilitações por operador
- Análise temporal de locações

### 5. RESULTADOS

O banco de dados implementado atende completamente aos requisitos estabelecidos:

✅ **Mínimo 5 tabelas:** 9 tabelas implementadas  
✅ **Mínimo 5 registros por tabela:** Todas as tabelas populadas adequadamente  
✅ **5 INSERTs, UPDATEs e DELETEs:** Implementados no Passo 4  
✅ **5 consultas de cada tipo básico:** Implementadas no Passo 5  
✅ **5 consultas avançadas de cada tipo:** Implementadas no Passo 6  

### 6. ESTRUTURA DE ARQUIVOS

```
ed_fundamento/
├── README.md
├── Passo-1/
│   ├── diagramaBasico.png
│   └── diagramaCompleto.jpg
├── Passo-2/
│   └── ed_fundamentos.pdf
├── Passo-3/
│   ├── ed_fundamento.sql
│   ├── ed_fundamentos.pdf
│   └── image.png
├── Passo-4/
│   └── inserir_dados.sql
├── Passo-5/
│   └── consultas_basicas.sql
├── Passo-6/
│   └── consultas_avancadas.sql
├── Documentacao/
│   └── relatorio_final.md
└── teste_completo.sql
```

### 7. INSTRUÇÕES DE EXECUÇÃO

Para executar o projeto completo:

1. **Criar o banco:** Execute `Passo-3/ed_fundamento.sql`
2. **Inserir dados:** Execute `Passo-4/inserir_dados.sql`
3. **Testar consultas básicas:** Execute `Passo-5/consultas_basicas.sql`
4. **Testar consultas avançadas:** Execute `Passo-6/consultas_avancadas.sql`
5. **Verificação geral:** Execute `teste_completo.sql`

## RESULTADOS E VALIDAÇÃO

### 8.1 EXECUÇÃO COMPLETA

O projeto foi executado com sucesso em ambiente XAMPP/MySQL no Windows, demonstrando total funcionalidade do banco de dados desenvolvido. Todos os scripts foram testados e validados, gerando os resultados esperados.

**Ambiente de Teste:**
- Sistema Operacional: Windows
- SGBD: MySQL (via XAMPP)
- Ferramenta: phpMyAdmin + PowerShell
- Data de Execução: 24 de junho de 2025

### 8.2 MÉTRICAS DE SUCESSO

**Estrutura Implementada:**
- ✅ 9 tabelas relacionais criadas
- ✅ 70+ registros inseridos (superando o mínimo de 25)
- ✅ Relacionamentos N:M e ternário funcionais
- ✅ Integridade referencial preservada

**Comandos SQL Executados:**
- ✅ 40+ comandos INSERT (superando o mínimo de 25)
- ✅ 5 comandos UPDATE funcionais
- ✅ 5 comandos DELETE controlados
- ✅ 30 consultas SQL (15 básicas + 15 avançadas)

### 8.3 EXEMPLOS DE FUNCIONAMENTO

**Consulta de Crédito Alto:**
```sql
SELECT nome, credito FROM clientes WHERE credito > 70000;
```
Resultado: 5 clientes com crédito superior a R$ 70.000

**Análise de Locações:**
```sql
SELECT c.nome, COUNT(l.id_locacao) as total_locacoes
FROM clientes c LEFT JOIN locacoes l ON c.id_cliente = l.id_cliente
GROUP BY c.nome;
```
Resultado: Relatório detalhado por cliente

**Máquinas por Tipo:**
```sql
SELECT tipo, COUNT(*) as quantidade 
FROM maquinas GROUP BY tipo;
```
Resultado: Distribuição das 8 máquinas por categoria

## CONSIDERAÇÕES FINAIS

O projeto foi desenvolvido com sucesso, implementando um banco de dados robusto e funcional para uma locadora de máquinas. Todas as funcionalidades requeridas foram implementadas, demonstrando a aplicação prática dos conceitos de modelagem de dados, normalização e linguagem SQL.

O banco de dados desenvolvido foi capaz de representar o mini-mundo de uma locadora de máquinas, atendendo às necessidades de locação, gestão de máquinas, operação em obras e administração de clientes. O sistema suporta eficientemente as operações de uma locadora real, incluindo controle de clientes, máquinas, operadores, obras e locações, com todas as consultas necessárias para relatórios gerenciais e operacionais.

Todos os objetivos estabelecidos no Estudo Dirigido foram alcançados:
- ✅ Modelagem conceitual e lógica adequada
- ✅ Implementação de banco normalizado com integridade referencial
- ✅ Inserção de dados realísticos e comandos DML funcionais
- ✅ Consultas básicas e avançadas operacionais
- ✅ Documentação técnica completa

O projeto demonstra domínio dos conceitos fundamentais de banco de dados e capacidade de aplicá-los em cenários práticos do mundo real.

---

**Data de Entrega:** 24 de junho de 2025  
**Autores:** Eduarda Horning Bzunek, João Gualberto Boissa Netto, José Otavio Chacorowski Raimundo  
**Disciplina:** Fundamentos de Banco de Dados  
**Professor:** Edivaldo de Araújo Pereira
