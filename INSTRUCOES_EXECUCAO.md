# INSTRUÇÕES DE EXECUÇÃO - LOCADORA DE MÁQUINAS

## Pré-requisitos
- MySQL Server instalado e funcionando
- Acesso ao MySQL via linha de comando ou ferramenta gráfica (phpMyAdmin, Workbench, etc.)

## Ordem de Execução dos Scripts

### 1. CRIAÇÃO DO BANCO DE DADOS (Passo 3)
```sql
-- Executar: Passo-3/ed_fundamento.sql
-- Cria o banco locadora_maquinas e todas as tabelas
```

### 2. INSERÇÃO DE DADOS (Passo 4)
```sql
-- Executar: Passo-4/inserir_dados.sql
-- Insere dados de teste em todas as tabelas
-- Executa comandos UPDATE e DELETE
```

### 3. CONSULTAS BÁSICAS (Passo 5)
```sql
-- Executar: Passo-5/consultas_basicas.sql
-- Testa consultas de seleção, projeção e junção
```

### 4. CONSULTAS AVANÇADAS (Passo 6)
```sql
-- Executar: Passo-6/consultas_avancadas.sql
-- Testa subconsultas, funções agregadas e GROUP BY
```

### 5. VERIFICAÇÃO COMPLETA
```sql
-- Executar: teste_completo.sql
-- Verifica se tudo foi executado corretamente
```

## Comandos MySQL (Linha de Comando)

```bash
# Conectar ao MySQL
mysql -u root -p

# Executar os scripts na ordem
mysql -u root -p < Passo-3/ed_fundamento.sql
mysql -u root -p < Passo-4/inserir_dados.sql
mysql -u root -p < Passo-5/consultas_basicas.sql
mysql -u root -p < Passo-6/consultas_avancadas.sql
mysql -u root -p < teste_completo.sql
```

## Verificação de Funcionamento

Após executar todos os scripts, execute estas consultas para verificar:

```sql
USE locadora_maquinas;

-- Verificar se todas as tabelas existem
SHOW TABLES;

-- Verificar quantidade de registros
SELECT 'CLIENTES' as Tabela, COUNT(*) as Registros FROM clientes
UNION ALL SELECT 'OPERADORES', COUNT(*) FROM operadores
UNION ALL SELECT 'OBRAS', COUNT(*) FROM obras
UNION ALL SELECT 'MAQUINAS', COUNT(*) FROM maquinas
UNION ALL SELECT 'LOCACOES', COUNT(*) FROM locacoes;

-- Teste rápido de consulta
SELECT c.nome, COUNT(l.id_locacao) as num_locacoes
FROM clientes c
LEFT JOIN locacoes l ON c.id_cliente = l.id_cliente
GROUP BY c.id_cliente, c.nome;
```

## Estrutura Final Esperada

- **9 tabelas** criadas
- **Mínimo 5 registros** em cada tabela principal
- **Relacionamentos** funcionando corretamente
- **Consultas** executando sem erro

## Troubleshooting

### Erro de Permissão
Se houver erro de permissão no MySQL:
```sql
GRANT ALL PRIVILEGES ON locadora_maquinas.* TO 'root'@'localhost';
FLUSH PRIVILEGES;
```

### Erro de Chave Estrangeira
Se houver erro de FK constraint:
```sql
SET FOREIGN_KEY_CHECKS = 0;
-- Executar os comandos problemáticos
SET FOREIGN_KEY_CHECKS = 1;
```

### Recriar o Banco
Para recriar completamente:
```sql
DROP DATABASE IF EXISTS locadora_maquinas;
-- Depois executar novamente os scripts na ordem
```
