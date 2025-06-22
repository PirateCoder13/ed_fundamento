-- ========================================
-- PASSO 4: INSERÇÃO DE DADOS NAS TABELAS
-- Locadora de Máquinas - Banco de Dados
-- ========================================

USE locadora_maquinas;

-- Inserção de dados na tabela CLIENTES (mínimo 5 registros)
INSERT INTO clientes (nome, contato, credito, pagamento) VALUES
('Construtora ABC Ltda', 'joao.silva@abc.com.br', 50000.00, 'A vista'),
('Empresa XYZ S.A.', 'maria.santos@xyz.com.br', 75000.00, '30 dias'),
('Obras e Terraplanagem DEF', 'carlos.pereira@def.com.br', 100000.00, '45 dias'),
('Jardinagem GHI', 'ana.costa@ghi.com.br', 25000.00, 'A vista'),
('Transportes JKL', 'pedro.oliveira@jkl.com.br', 80000.00, '15 dias'),
('Indústria MNO', 'lucia.fernandes@mno.com.br', 120000.00, '60 dias'),
('Construções PQR', 'roberto.alves@pqr.com.br', 90000.00, '30 dias');

-- Inserção de dados na tabela OPERADORES (mínimo 5 registros)
INSERT INTO operadores (nome, funcao, habilitacao) VALUES
('José Silva', 'Operador de Escavadeira', 'CNH categoria D, Curso de Escavadeira'),
('Maria Oliveira', 'Consultora de Obras', 'Engenharia Civil, CREA ativo'),
('Carlos Santos', 'Operador de Guindaste', 'CNH categoria E, Curso de Guindaste'),
('Ana Paula', 'Técnica em Manutenção', 'Técnico em Mecânica, NR-12'),
('Roberto Lima', 'Operador de Trator', 'CNH categoria C, Curso de Trator'),
('Fernanda Costa', 'Supervisora de Campo', 'Técnico em Segurança do Trabalho'),
('Paulo Rodrigues', 'Operador de Retroescavadeira', 'CNH categoria D, Curso específico');

-- Inserção de dados na tabela OBRAS (mínimo 5 registros)
INSERT INTO obras (nome, tipo, localizacao, id_proprietario, id_consultor) VALUES
('Condomínio Solar das Palmeiras', 'Residencial', 'Curitiba - PR', 1, 2),
('Complexo Industrial Norte', 'Industrial', 'São José dos Pinhais - PR', 6, 2),
('Shopping Center Plaza', 'Comercial', 'Londrina - PR', 3, 2),
('Parque Municipal Verde', 'Paisagismo', 'Ponta Grossa - PR', 4, 6),
('Rodovia BR-277 - Trecho 15', 'Infraestrutura', 'Foz do Iguaçu - PR', 7, 2),
('Loteamento Bela Vista', 'Residencial', 'Maringá - PR', 1, 6),
('Terminal de Cargas Sul', 'Logístico', 'Paranaguá - PR', 5, 2);

-- Inserção de dados na tabela MÁQUINAS (mínimo 5 registros)
INSERT INTO maquinas (descricao, tipo, status, despesa, manutencao) VALUES
('Escavadeira Hidráulica CAT 320D', 'Terraplenagem', 'Disponível', 2500.00, 'Revisão em dia'),
('Guindaste Liebherr 100 ton', 'Construção', 'Disponível', 5000.00, 'Manutenção preventiva realizada'),
('Trator John Deere 6110', 'Jardinagem', 'Em uso', 1500.00, 'Troca de óleo pendente'),
('Retroescavadeira JCB 3CX', 'Terraplenagem', 'Disponível', 2000.00, 'Revisão geral concluída'),
('Caminhão Munck Scania', 'Transporte', 'Manutenção', 3000.00, 'Reparo no sistema hidráulico'),
('Motoniveladora CAT 140M', 'Terraplenagem', 'Disponível', 3500.00, 'Revisão em dia'),
('Compactador de Solo Dynapac', 'Construção', 'Disponível', 1800.00, 'Manutenção em dia'),
('Pá Carregadeira CAT 950H', 'Construção', 'Em uso', 2200.00, 'Próxima revisão em 30 dias');

-- Inserção de dados na tabela LOCAÇÕES (mínimo 5 registros)
INSERT INTO locacoes (data_inicio, data_fim, status, retirada, entrega, devolucao, id_cliente) VALUES
('2025-06-01', '2025-06-30', 'Ativa', '2025-06-01', '2025-06-01', NULL, 1),
('2025-05-15', '2025-07-15', 'Ativa', '2025-05-15', '2025-05-15', NULL, 3),
('2025-04-10', '2025-05-10', 'Finalizada', '2025-04-10', '2025-04-10', '2025-05-10', 4),
('2025-06-10', '2025-08-10', 'Ativa', '2025-06-10', '2025-06-10', NULL, 6),
('2025-03-01', '2025-04-01', 'Finalizada', '2025-03-01', '2025-03-01', '2025-04-01', 2),
('2025-06-20', '2025-07-20', 'Ativa', '2025-06-20', '2025-06-20', NULL, 5),
('2025-02-15', '2025-03-15', 'Finalizada', '2025-02-15', '2025-02-15', '2025-03-15', 7);

-- Inserção de dados na tabela LOCA (relacionamento Locações x Máquinas)
INSERT INTO loca (id_locacao, id_maquina) VALUES
(1, 1), (1, 4),  -- Locação 1: Escavadeira e Retroescavadeira
(2, 2), (2, 6),  -- Locação 2: Guindaste e Motoniveladora
(3, 3),          -- Locação 3: Trator
(4, 7), (4, 8),  -- Locação 4: Compactador e Pá Carregadeira
(5, 1), (5, 6),  -- Locação 5: Escavadeira e Motoniveladora
(6, 5),          -- Locação 6: Caminhão Munck
(7, 4), (7, 7);  -- Locação 7: Retroescavadeira e Compactador

-- Inserção de dados na tabela UTILIZACAO_OBRA (Máquinas utilizadas em Obras)
INSERT INTO utilizacao_obra (id_maquina, id_obra) VALUES
(1, 1), (4, 1),  -- Obra 1: Escavadeira e Retroescavadeira
(2, 2), (6, 2), (8, 2),  -- Obra 2: Guindaste, Motoniveladora e Pá Carregadeira
(3, 4),          -- Obra 4: Trator (paisagismo)
(6, 5), (7, 5),  -- Obra 5: Motoniveladora e Compactador (rodovia)
(1, 6), (4, 6),  -- Obra 6: Escavadeira e Retroescavadeira
(5, 3), (2, 3);  -- Obra 3: Caminhão Munck e Guindaste

-- Inserção de dados na tabela PODE_OPERAR (habilitações dos operadores)
INSERT INTO pode_operar (id_maquina, id_operador) VALUES
(1, 1), (1, 7),  -- Escavadeira: José e Paulo
(2, 3),          -- Guindaste: Carlos
(3, 5),          -- Trator: Roberto
(4, 1), (4, 7),  -- Retroescavadeira: José e Paulo
(5, 3), (5, 5),  -- Caminhão Munck: Carlos e Roberto
(6, 5), (6, 7),  -- Motoniveladora: Roberto e Paulo
(7, 5),          -- Compactador: Roberto
(8, 1), (8, 5);  -- Pá Carregadeira: José e Roberto

-- Inserção de dados na tabela OPERACAO_MAQUINA_OBRA (operações específicas)
INSERT INTO operacao_maquina_obra (id_obra, id_maquina, id_operador) VALUES
(1, 1, 1),  -- Obra 1: Escavadeira operada por José
(1, 4, 7),  -- Obra 1: Retroescavadeira operada por Paulo
(2, 2, 3),  -- Obra 2: Guindaste operado por Carlos
(2, 6, 5),  -- Obra 2: Motoniveladora operada por Roberto
(2, 8, 1),  -- Obra 2: Pá Carregadeira operada por José
(4, 3, 5),  -- Obra 4: Trator operado por Roberto
(5, 6, 7),  -- Obra 5: Motoniveladora operada por Paulo
(5, 7, 5),  -- Obra 5: Compactador operado por Roberto
(6, 1, 7),  -- Obra 6: Escavadeira operada por Paulo
(6, 4, 1);  -- Obra 6: Retroescavadeira operada por José

-- ========================================
-- COMANDOS UPDATE (mínimo 5)
-- ========================================

-- UPDATE 1: Atualizar crédito de um cliente
UPDATE clientes 
SET credito = 60000.00 
WHERE id_cliente = 1;

-- UPDATE 2: Alterar status de uma máquina para manutenção
UPDATE maquinas 
SET status = 'Manutenção', manutencao = 'Reparo no motor' 
WHERE id_maquina = 3;

-- UPDATE 3: Atualizar função de um operador
UPDATE operadores 
SET funcao = 'Supervisor de Operações', habilitacao = 'CNH categoria D, Curso de Escavadeira, Liderança' 
WHERE id_operador = 1;

-- UPDATE 4: Finalizar uma locação (data de devolução)
UPDATE locacoes 
SET status = 'Finalizada', devolucao = '2025-06-22' 
WHERE id_locacao = 1;

-- UPDATE 5: Atualizar localização de uma obra
UPDATE obras 
SET localizacao = 'Curitiba - PR - Bairro Batel' 
WHERE id_obra = 1;

-- ========================================
-- COMANDOS DELETE (mínimo 5)
-- ========================================

-- DELETE 1: Remover uma operação específica
DELETE FROM operacao_maquina_obra 
WHERE id_obra = 6 AND id_maquina = 4 AND id_operador = 1;

-- DELETE 2: Remover uma habilitação de operador
DELETE FROM pode_operar 
WHERE id_maquina = 8 AND id_operador = 5;

-- DELETE 3: Remover uma utilização de máquina em obra
DELETE FROM utilizacao_obra 
WHERE id_maquina = 5 AND id_obra = 3;

-- DELETE 4: Remover um item de locação
DELETE FROM loca 
WHERE id_locacao = 7 AND id_maquina = 7;

-- DELETE 5: Remover uma locação finalizada (primeiro os relacionamentos)
DELETE FROM loca WHERE id_locacao = 5;
DELETE FROM locacoes WHERE id_locacao = 5;

-- ========================================
-- FIM DO PASSO 4
-- ========================================
