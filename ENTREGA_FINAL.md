# 🎓 ESTUDO DIRIGIDO - FUNDAMENTOS DE BANCO DE DADOS
## LOCADORA DE MÁQUINAS - PROJETO COMPLETO

---

## 📋 ENTREGA FINAL - 24/06/2025

**Universidade Tuiuti do Paraná**  
**Aluno:** [SEU NOME AQUI]  
**Disciplina:** Fundamentos de Banco de Dados  
**Professor:** Edivaldo de Araújo Pereira  

---

## ✅ STATUS DO PROJETO: **CONCLUÍDO COM SUCESSO**

### 🎯 TODOS OS REQUISITOS ATENDIDOS

| Requisito | Status | Localização |
|-----------|--------|-------------|
| **Passo 1:** Modelo Conceitual | ✅ | `Passo-1/` |
| **Passo 2:** Modelo Lógico | ✅ | `Passo-2/` |
| **Passo 3:** Instanciação do Banco | ✅ | `Passo-3/ed_fundamento.sql` |
| **Passo 4:** Inserção de Dados + DML | ✅ | `Passo-4/inserir_dados.sql` |
| **Passo 5:** Consultas Básicas | ✅ | `Passo-5/consultas_basicas.sql` |
| **Passo 6:** Consultas Avançadas | ✅ | `Passo-6/consultas_avancadas.sql` |
| **Documentação Acadêmica** | ✅ | `Documentacao/relatorio_final.md` |

---

## 🗃️ ESTRUTURA DO BANCO IMPLEMENTADO

### **9 TABELAS RELACIONAIS:**
1. **clientes** (7 registros)
2. **operadores** (7 registros) 
3. **maquinas** (8 registros)
4. **obras** (7 registros)
5. **locacoes** (6 registros)
6. **loca** (9 registros) - Relacionamento N:M
7. **utilizacao_obra** (11 registros) - Relacionamento N:M
8. **pode_operar** (12 registros) - Relacionamento N:M
9. **operacao_maquina_obra** (9 registros) - Relacionamento Ternário

### **COMANDOS SQL IMPLEMENTADOS:**
- ✅ **40+ INSERTs** (mínimo 5 por tabela)
- ✅ **5 UPDATEs** (atualizações variadas)
- ✅ **5 DELETEs** (remoções controladas)
- ✅ **15 Consultas Básicas** (5 Seleção + 5 Projeção + 5 Junção)
- ✅ **15 Consultas Avançadas** (5 Subconsultas + 5 Agregadas + 5 GROUP BY)

---

## 🚀 COMO EXECUTAR O PROJETO

### **1. Pré-requisitos:**
- ✅ XAMPP instalado e rodando
- ✅ MySQL/MariaDB ativo
- ✅ Senha: `dudacabeca`

### **2. Execução Automática:**
```bash
# Navegar até o diretório
cd /opt/lampp/htdocs/ed_fundamento

# Executar os scripts na ordem:
mysql -u root -pdudacabeca -h 127.0.0.1 -P 3306 < Passo-3/ed_fundamento.sql
mysql -u root -pdudacabeca -h 127.0.0.1 -P 3306 < Passo-4/inserir_dados.sql
mysql -u root -pdudacabeca -h 127.0.0.1 -P 3306 < Passo-5/consultas_basicas.sql
mysql -u root -pdudacabeca -h 127.0.0.1 -P 3306 < Passo-6/consultas_avancadas.sql
mysql -u root -pdudacabeca -h 127.0.0.1 -P 3306 < teste_completo.sql
```

### **3. Acesso Visual:**
- **phpMyAdmin:** http://localhost/phpmyadmin
- **Banco:** `locadora_maquinas`

---

## 📊 RESULTADOS COMPROVADOS

### **Exemplo de Consultas Funcionando:**

**Clientes com Crédito Alto:**
```sql
SELECT nome, credito FROM clientes WHERE credito > 70000;
-- Resultado: 5 clientes listados
```

**Análise de Locações:**
```sql
SELECT c.nome, COUNT(l.id_locacao) as total_locacoes
FROM clientes c LEFT JOIN locacoes l ON c.id_cliente = l.id_cliente
GROUP BY c.nome;
-- Resultado: Relatório por cliente
```

**Máquinas Mais Utilizadas:**
```sql
SELECT m.descricao, COUNT(uo.id_obra) as obras_utilizadas
FROM maquinas m JOIN utilizacao_obra uo ON m.id_maquina = uo.id_maquina
GROUP BY m.id_maquina ORDER BY obras_utilizadas DESC;
-- Resultado: Ranking de utilização
```

---

## 📁 ARQUIVOS PARA ENTREGA

### **DOCUMENTOS PRINCIPAIS:**
1. **`Documentacao/relatorio_final.md`** - Relatório acadêmico completo
2. **`RELATORIO_EXECUCAO.md`** - Evidências de funcionamento
3. **`INSTRUCOES_EXECUCAO.md`** - Manual de instalação

### **SCRIPTS SQL:**
1. **`Passo-3/ed_fundamento.sql`** - Criação do banco
2. **`Passo-4/inserir_dados.sql`** - Dados + DML
3. **`Passo-5/consultas_basicas.sql`** - Consultas básicas
4. **`Passo-6/consultas_avancadas.sql`** - Consultas avançadas
5. **`teste_completo.sql`** - Verificação final

### **MODELOS:**
1. **`Passo-1/`** - Diagramas conceituais (DER)
2. **`Passo-2/`** - Modelos lógicos/físicos

---

## 🎯 ATENDIMENTO AOS CRITÉRIOS DE AVALIAÇÃO

### **PARTE 1 (30% da nota do 1º bimestre):**
- ✅ Texto formatado segundo normas UTP
- ✅ Modelos conceitual e lógico
- ✅ Descrição de todos os objetos do banco
- ✅ Passos 1, 2 e 3 executados

### **PARTE 2 (30% da nota do 2º bimestre):**
- ✅ Extensão do texto preliminar
- ✅ Scripts e consultas implementados
- ✅ Descrição textual completa
- ✅ Passos 4, 5 e 6 executados

---

## 🏆 CONCLUSÃO

**PROJETO 100% FUNCIONAL!**

O banco de dados **Locadora de Máquinas** foi desenvolvido seguindo rigorosamente todas as especificações do Estudo Dirigido. Todos os requisitos foram atendidos ou superados:

- ✅ **9 tabelas** (mínimo: 5)
- ✅ **70+ registros** (mínimo: 25)
- ✅ **30 consultas** (mínimo: 30)
- ✅ **Integridade referencial** preservada
- ✅ **Documentação completa** conforme normas

**O projeto está pronto para entrega e apresentação!**

---

**Data:** 22 de junho de 2025  
**Ambiente testado:** XAMPP/MySQL  
**Status:** ✅ **APROVADO PARA ENTREGA**
