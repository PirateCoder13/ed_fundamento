-- ========================================
-- PASSO 5: CONSULTAS BÁSICAS (DQL)
-- Seleção, Projeção e Junção
-- ========================================

USE locadora_maquinas;

-- ========================================
-- CONSULTAS DE SELEÇÃO (mínimo 5)
-- ========================================

-- SELEÇÃO 1: Listar apenas clientes com crédito acima de 70.000
SELECT * FROM clientes 
WHERE credito > 70000.00;

-- SELEÇÃO 2: Listar apenas máquinas disponíveis
SELECT * FROM maquinas 
WHERE status = 'Disponível';

-- SELEÇÃO 3: Listar operadores que são consultores
SELECT * FROM operadores 
WHERE funcao LIKE '%Consultor%';

-- SELEÇÃO 4: Listar locações ativas
SELECT * FROM locacoes 
WHERE status = 'Ativa';

-- SELEÇÃO 5: Listar obras do tipo 'Residencial'
SELECT * FROM obras 
WHERE tipo = 'Residencial';

-- ========================================
-- CONSULTAS DE PROJEÇÃO (mínimo 5)
-- ========================================

-- PROJEÇÃO 1: Listar apenas nome e contato dos clientes
SELECT nome, contato FROM clientes;

-- PROJEÇÃO 2: Listar apenas descrição e tipo das máquinas
SELECT descricao, tipo FROM maquinas;

-- PROJEÇÃO 3: Listar apenas nome e função dos operadores
SELECT nome, funcao FROM operadores;

-- PROJEÇÃO 4: Listar apenas nome e tipo das obras
SELECT nome, tipo FROM obras;

-- PROJEÇÃO 5: Listar apenas datas de início e fim das locações
SELECT data_inicio, data_fim, status FROM locacoes;

-- ========================================
-- CONSULTAS DE JUNÇÃO (mínimo 5)
-- ========================================

-- JUNÇÃO 1: Listar locações com nome do cliente
SELECT l.id_locacao, l.data_inicio, l.data_fim, l.status, c.nome as cliente
FROM locacoes l
INNER JOIN clientes c ON l.id_cliente = c.id_cliente;

-- JUNÇÃO 2: Listar obras com nome do proprietário e consultor
SELECT o.nome as obra, o.tipo, o.localizacao, 
       c.nome as proprietario, op.nome as consultor
FROM obras o
INNER JOIN clientes c ON o.id_proprietario = c.id_cliente
INNER JOIN operadores op ON o.id_consultor = op.id_operador;

-- JUNÇÃO 3: Listar máquinas locadas com detalhes da locação
SELECT m.descricao as maquina, m.tipo, l.data_inicio, l.data_fim, 
       c.nome as cliente
FROM maquinas m
INNER JOIN loca lo ON m.id_maquina = lo.id_maquina
INNER JOIN locacoes l ON lo.id_locacao = l.id_locacao
INNER JOIN clientes c ON l.id_cliente = c.id_cliente;

-- JUNÇÃO 4: Listar operadores e as máquinas que podem operar
SELECT op.nome as operador, op.funcao, m.descricao as maquina, m.tipo
FROM operadores op
INNER JOIN pode_operar po ON op.id_operador = po.id_operador
INNER JOIN maquinas m ON po.id_maquina = m.id_maquina;

-- JUNÇÃO 5: Listar operações em obras com detalhes completos
SELECT ob.nome as obra, m.descricao as maquina, op.nome as operador,
       ob.tipo as tipo_obra, m.tipo as tipo_maquina
FROM operacao_maquina_obra omo
INNER JOIN obras ob ON omo.id_obra = ob.id_obra
INNER JOIN maquinas m ON omo.id_maquina = m.id_maquina
INNER JOIN operadores op ON omo.id_operador = op.id_operador;

-- ========================================
-- CONSULTAS ADICIONAIS ÚTEIS
-- ========================================

-- Listar todas as máquinas utilizadas em cada obra
SELECT ob.nome as obra, m.descricao as maquina, m.tipo
FROM utilizacao_obra uo
INNER JOIN obras ob ON uo.id_obra = ob.id_obra
INNER JOIN maquinas m ON uo.id_maquina = m.id_maquina
ORDER BY ob.nome, m.descricao;

-- Listar clientes e suas locações ativas
SELECT c.nome as cliente, c.contato, l.data_inicio, l.data_fim
FROM clientes c
INNER JOIN locacoes l ON c.id_cliente = l.id_cliente
WHERE l.status = 'Ativa'
ORDER BY c.nome;

-- ========================================
-- FIM DO PASSO 5
-- ========================================
