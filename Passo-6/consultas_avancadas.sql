-- ========================================
-- PASSO 6: CONSULTAS AVANÇADAS (DQL)
-- Subconsultas, Funções Agregadas e GROUP BY
-- ========================================

USE locadora_maquinas;

-- ========================================
-- CONSULTAS COM SUBCONSULTAS (mínimo 5)
-- ========================================

-- SUBCONSULTA 1: Clientes que fizeram locações
SELECT nome, contato, credito 
FROM clientes 
WHERE id_cliente IN (SELECT DISTINCT id_cliente FROM locacoes);

-- SUBCONSULTA 2: Máquinas que nunca foram locadas
SELECT descricao, tipo, status 
FROM maquinas 
WHERE id_maquina NOT IN (SELECT DISTINCT id_maquina FROM loca WHERE id_maquina IS NOT NULL);

-- SUBCONSULTA 3: Operadores que trabalham em obras residenciais
SELECT nome, funcao, habilitacao 
FROM operadores 
WHERE id_operador IN (
    SELECT DISTINCT id_operador 
    FROM operacao_maquina_obra omo
    INNER JOIN obras o ON omo.id_obra = o.id_obra
    WHERE o.tipo = 'Residencial'
);

-- SUBCONSULTA 4: Clientes com crédito acima da média
SELECT nome, credito 
FROM clientes 
WHERE credito > (SELECT AVG(credito) FROM clientes);

-- SUBCONSULTA 5: Máquinas utilizadas na obra com mais máquinas
SELECT m.descricao, m.tipo 
FROM maquinas m
WHERE m.id_maquina IN (
    SELECT uo.id_maquina 
    FROM utilizacao_obra uo
    WHERE uo.id_obra = (
        SELECT id_obra 
        FROM utilizacao_obra 
        GROUP BY id_obra 
        ORDER BY COUNT(*) DESC 
        LIMIT 1
    )
);

-- ========================================
-- CONSULTAS COM FUNÇÕES AGREGADAS (mínimo 5)
-- ========================================

-- AGREGADA 1: Total de clientes cadastrados
SELECT COUNT(*) as total_clientes FROM clientes;

-- AGREGADA 2: Média de crédito dos clientes
SELECT AVG(credito) as media_credito, 
       MIN(credito) as menor_credito, 
       MAX(credito) as maior_credito 
FROM clientes;

-- AGREGADA 3: Total de despesas com máquinas
SELECT SUM(despesa) as total_despesas, 
       AVG(despesa) as media_despesa 
FROM maquinas;

-- AGREGADA 4: Número total de locações por status
SELECT status, COUNT(*) as quantidade 
FROM locacoes 
GROUP BY status;

-- AGREGADA 5: Número de máquinas por tipo
SELECT tipo, COUNT(*) as quantidade 
FROM maquinas 
GROUP BY tipo;

-- ========================================
-- CONSULTAS COM GROUP BY (mínimo 5)
-- ========================================

-- GROUP BY 1: Número de locações por cliente
SELECT c.nome as cliente, COUNT(l.id_locacao) as num_locacoes
FROM clientes c
LEFT JOIN locacoes l ON c.id_cliente = l.id_cliente
GROUP BY c.id_cliente, c.nome
ORDER BY num_locacoes DESC;

-- GROUP BY 2: Número de obras por tipo
SELECT tipo, COUNT(*) as quantidade, 
       GROUP_CONCAT(nome SEPARATOR ', ') as obras
FROM obras 
GROUP BY tipo
ORDER BY quantidade DESC;

-- GROUP BY 3: Despesa total por tipo de máquina
SELECT tipo, COUNT(*) as quantidade, 
       SUM(despesa) as despesa_total, 
       AVG(despesa) as despesa_media
FROM maquinas 
GROUP BY tipo
ORDER BY despesa_total DESC;

-- GROUP BY 4: Número de máquinas que cada operador pode operar
SELECT op.nome as operador, op.funcao, COUNT(po.id_maquina) as num_maquinas
FROM operadores op
LEFT JOIN pode_operar po ON op.id_operador = po.id_operador
GROUP BY op.id_operador, op.nome, op.funcao
ORDER BY num_maquinas DESC;

-- GROUP BY 5: Análise de locações por mês
SELECT YEAR(data_inicio) as ano, MONTH(data_inicio) as mes, 
       COUNT(*) as num_locacoes,
       COUNT(CASE WHEN status = 'Ativa' THEN 1 END) as ativas,
       COUNT(CASE WHEN status = 'Finalizada' THEN 1 END) as finalizadas
FROM locacoes 
GROUP BY YEAR(data_inicio), MONTH(data_inicio)
ORDER BY ano, mes;

-- ========================================
-- CONSULTAS COMPLEXAS COMBINADAS
-- ========================================

-- COMPLEXA 1: Operadores mais ativos (com subconsulta e agregação)
SELECT op.nome as operador, COUNT(*) as operacoes_realizadas
FROM operadores op
INNER JOIN operacao_maquina_obra omo ON op.id_operador = omo.id_operador
GROUP BY op.id_operador, op.nome
HAVING COUNT(*) >= (
    SELECT AVG(operacoes) 
    FROM (
        SELECT COUNT(*) as operacoes 
        FROM operacao_maquina_obra 
        GROUP BY id_operador
    ) as subquery
)
ORDER BY operacoes_realizadas DESC;

-- COMPLEXA 2: Clientes com maior valor de crédito por tipo de pagamento
SELECT pagamento, nome, credito
FROM clientes c1
WHERE credito = (
    SELECT MAX(credito) 
    FROM clientes c2 
    WHERE c2.pagamento = c1.pagamento
)
ORDER BY pagamento;

-- COMPLEXA 3: Relatório de eficiência de máquinas
SELECT m.tipo, m.descricao,
       COUNT(CASE WHEN m.status = 'Disponível' THEN 1 END) as disponiveis,
       COUNT(CASE WHEN m.status = 'Em uso' THEN 1 END) as em_uso,
       COUNT(CASE WHEN m.status = 'Manutenção' THEN 1 END) as manutencao,
       (COUNT(CASE WHEN m.status = 'Em uso' THEN 1 END) * 100.0 / COUNT(*)) as percentual_uso
FROM maquinas m
GROUP BY m.tipo, m.descricao
ORDER BY percentual_uso DESC;

-- COMPLEXA 4: Análise de obras por consultor
SELECT op.nome as consultor, 
       COUNT(DISTINCT o.id_obra) as num_obras,
       GROUP_CONCAT(DISTINCT o.tipo) as tipos_obra,
       COUNT(DISTINCT omo.id_maquina) as maquinas_supervisionadas
FROM operadores op
INNER JOIN obras o ON op.id_operador = o.id_consultor
LEFT JOIN operacao_maquina_obra omo ON o.id_obra = omo.id_obra
GROUP BY op.id_operador, op.nome
ORDER BY num_obras DESC;

-- COMPLEXA 5: Relatório financeiro por cliente
SELECT c.nome as cliente, c.credito,
       COUNT(l.id_locacao) as num_locacoes,
       SUM(m.despesa) as custo_total_maquinas,
       AVG(m.despesa) as custo_medio_maquina,
       (c.credito - COALESCE(SUM(m.despesa), 0)) as saldo_disponivel
FROM clientes c
LEFT JOIN locacoes l ON c.id_cliente = l.id_cliente
LEFT JOIN loca lo ON l.id_locacao = lo.id_locacao
LEFT JOIN maquinas m ON lo.id_maquina = m.id_maquina
GROUP BY c.id_cliente, c.nome, c.credito
ORDER BY custo_total_maquinas DESC;

-- ========================================
-- FIM DO PASSO 6
-- ========================================
