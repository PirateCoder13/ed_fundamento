# SETUP DO BANCO DE DADOS COM XAMPP - LOCADORA DE MÁQUINAS

## Pré-requisitos
- XAMPP instalado na máquina
- Apache e MySQL iniciados no painel de controle do XAMPP

## Passo a Passo para Configuração

### 1. INICIANDO O XAMPP
1. Abra o **XAMPP Control Panel**
2. Clique em **Start** para:
   - **Apache** (para acessar o phpMyAdmin)
   - **MySQL** (para o banco de dados)

### 2. ACESSANDO O PHPMYADMIN
1. Abra seu navegador
2. Digite: `http://localhost/phpmyadmin`
3. Faça login (usuário padrão: `root`, sem senha)

### 3. CRIANDO O BANCO DE DADOS

#### Opção A: Via phpMyAdmin (Interface Gráfica)
1. No phpMyAdmin, clique na aba **SQL**
2. Copie e cole o conteúdo do arquivo `Passo-3/ed_fundamento.sql`
3. Clique em **Executar**

#### Opção B: Via Linha de Comando
1. Abra o **Prompt de Comando** como administrador
2. Navegue até a pasta bin do MySQL no XAMPP:
   ```cmd
   cd C:\xampp\mysql\bin
   ```
3. Execute os comandos:
   ```cmd
   mysql -u root -p
   ```
   (Pressione Enter quando pedir senha, pois por padrão não há senha)

4. Execute os scripts na ordem:
   ```cmd
   mysql -u root < "C:\Users\PirateNote\Desktop\facul\ed_fundamento\Passo-3\ed_fundamento.sql"
   mysql -u root < "C:\Users\PirateNote\Desktop\facul\ed_fundamento\Passo-4\inserir_dados.sql"
   ```

### 4. VERIFICAÇÃO NO PHPMYADMIN
1. Após executar, atualize o phpMyAdmin
2. Você deve ver o banco `locadora_maquinas` na lista à esquerda
3. Clique no banco para ver todas as 9 tabelas criadas

### 5. EXECUTANDO OS DEMAIS SCRIPTS

No phpMyAdmin, execute na ordem:

1. **Inserção de dados** - `Passo-4/inserir_dados.sql`
2. **Consultas básicas** - `Passo-5/consultas_basicas.sql`
3. **Consultas avançadas** - `Passo-6/consultas_avancadas.sql`
4. **Teste completo** - `teste_completo.sql`

### 6. TESTE RÁPIDO
Execute esta consulta no phpMyAdmin para verificar se tudo está funcionando:

```sql
USE locadora_maquinas;
SHOW TABLES;
SELECT COUNT(*) as total_clientes FROM clientes;
```

## Comandos PowerShell Alternativos

Se preferir usar PowerShell:

```powershell
# Navegar até a pasta do projeto
cd "C:\Users\PirateNote\Desktop\facul\ed_fundamento"

# Executar scripts via MySQL do XAMPP
& "C:\xampp\mysql\bin\mysql.exe" -u root < "Passo-3\ed_fundamento.sql"
& "C:\xampp\mysql\bin\mysql.exe" -u root < "Passo-4\inserir_dados.sql"
& "C:\xampp\mysql\bin\mysql.exe" -u root < "Passo-5\consultas_basicas.sql"
& "C:\xampp\mysql\bin\mysql.exe" -u root < "Passo-6\consultas_avancadas.sql"
& "C:\xampp\mysql\bin\mysql.exe" -u root < "teste_completo.sql"
```

## Possíveis Problemas e Soluções

### MySQL não inicia no XAMPP
- Verifique se não há outro MySQL rodando
- Reinicie o XAMPP como administrador
- Verifique a porta 3306 no arquivo de configuração

### Erro de permissão
- Execute o XAMPP como administrador
- Verifique se o usuário root tem privilégios

### Erro de encoding
- Certifique-se que os arquivos SQL estão salvos em UTF-8

## Estrutura Final Esperada

Após a execução completa, você terá:
- ✅ Banco `locadora_maquinas` criado
- ✅ 9 tabelas com relacionamentos
- ✅ Dados inseridos em todas as tabelas
- ✅ Consultas funcionando corretamente