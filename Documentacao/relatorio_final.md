# ESTUDO DIRIGIDO - FUNDAMENTOS DE BANCO DE DADOS

**Universidade Tuiuti do Paraná**
*Credenciada por Decreto Presidencial de 07 de julho de 1997*

**FACULDADE:** Faculdade de Ciências Exatas e de Tecnologia – FACET  
**CURSO:** Tecnologia em Análise e Desenvolvimento de Sistemas  
**DISCIPLINA:** Fundamentos de Banco de Dados  
**ANO:** 2025/1 **PERÍODO:** 3º **REGIME:** Semestral **C/H:** 80  
**PROFESSOR:** Edivaldo de Araújo Pereira  

---

## PROJETO: LOCADORA DE MÁQUINAS - BANCO DE DADOS RELACIONAL

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

#### 4.1 MODELO CONCEITUAL (Passo 1)

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

#### 4.2 MODELO LÓGICO (Passo 2)

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

#### 4.3 INSTANCIAÇÃO DO BANCO (Passo 3)

O banco de dados foi criado utilizando MySQL, com todas as restrições de integridade referencial implementadas através de chaves estrangeiras. O script de criação está disponível em `Passo-3/ed_fundamento.sql`.

#### 4.4 INSERÇÃO DE DADOS (Passo 4)

Foram inseridos dados de teste em todas as tabelas, respeitando o mínimo de 5 registros por tabela:

- **7 clientes** representando diferentes tipos de empresas
- **7 operadores** com diferentes funções e habilitações
- **7 obras** de diversos tipos (residencial, industrial, comercial, etc.)
- **8 máquinas** de diferentes categorias (terraplenagem, construção, transporte, etc.)
- **7 locações** em diferentes status e períodos

**Comandos DML implementados:**
- **5 comandos UPDATE:** Atualizações de crédito, status, funções, etc.
- **5 comandos DELETE:** Remoções de relacionamentos e registros

#### 4.5 CONSULTAS BÁSICAS (Passo 5)

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

#### 4.6 CONSULTAS AVANÇADAS (Passo 6)

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

### 8. CONCLUSÃO

O projeto foi desenvolvido com sucesso, implementando um banco de dados robusto e funcional para uma locadora de máquinas. Todas as funcionalidades requeridas foram implementadas, demonstrando a aplicação prática dos conceitos de modelagem de dados, normalização e linguagem SQL.

O banco de dados suporta eficientemente as operações de uma locadora real, incluindo controle de clientes, máquinas, operadores, obras e locações, com todas as consultas necessárias para relatórios gerenciais e operacionais.

---

**Data de Entrega:** 24 de junho de 2025  
**Autor:** [Nome do Aluno]  
**Disciplina:** Fundamentos de Banco de Dados  
**Professor:** Edivaldo de Araújo Pereira
