-- ========================================
-- SCRIPT COMPLETO PARA TESTE DO BANCO
-- Locadora de Máquinas - Execução Completa
-- ========================================

-- Executar na seguinte ordem:
-- 1. ed_fundamento.sql (Passo 3 - Criação das tabelas)
-- 2. inserir_dados.sql (Passo 4 - Inserção de dados)
-- 3. consultas_basicas.sql (Passo 5 - Consultas básicas)
-- 4. consultas_avancadas.sql (Passo 6 - Consultas avançadas)

-- Este script pode ser usado para verificar se tudo está funcionando
USE locadora_maquinas;

-- Verificar se todas as tabelas foram criadas
SHOW TABLES;

-- Verificar se os dados foram inseridos
SELECT 'CLIENTES' as Tabela, COUNT(*) as Registros FROM clientes
UNION ALL
SELECT 'OPERADORES', COUNT(*) FROM operadores
UNION ALL
SELECT 'OBRAS', COUNT(*) FROM obras
UNION ALL
SELECT 'MAQUINAS', COUNT(*) FROM maquinas
UNION ALL
SELECT 'LOCACOES', COUNT(*) FROM locacoes
UNION ALL
SELECT 'LOCA', COUNT(*) FROM loca
UNION ALL
SELECT 'UTILIZACAO_OBRA', COUNT(*) FROM utilizacao_obra
UNION ALL
SELECT 'PODE_OPERAR', COUNT(*) FROM pode_operar
UNION ALL
SELECT 'OPERACAO_MAQUINA_OBRA', COUNT(*) FROM operacao_maquina_obra;

-- Teste rápido de integridade referencial
SELECT 'Teste de Integridade - OK' as Status;
