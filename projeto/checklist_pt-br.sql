--------------------------- CHECKLIST ---------------------------
-- Vitor Martins
-- vmam@cin.ufpe.br

-- Itens do checklist abordados no código seguinte
-- Descrição da ação
-- Código :)

-- 1, 6
-- Exibe os cursos que possuem nota_mec entre 7 e 9 em ordem decrescente.
SELECT * FROM Curso WHERE nota_mec BETWEEN 7 AND 9 ORDER BY nota_mec DESC;

-- 2
-- Exibe os professores que nasceram nos anos 70;
SELECT * FROM Professor WHERE data_nasc BETWEEN to_date('01/01/1970', 'dd/mm/yyyy') AND to_date('12/12/1979', 'dd/mm/yyyy');

-- 3
-- Exibe o nome das disciplinas que começam com a letra 'F'.
SELECT nome FROM Disciplina WHERE nome LIKE 'F%';

-- 4
-- Exibe o nome dos alunos que possuem Iniciação Científica.
SELECT nome FROM Aluno WHERE cpf_aluno IN (SELECT cpf_aluno FROM Ic);

-- 5
-- Exibe o nome dos alunos que não possuem padrinhos
SELECT nome FROM Aluno WHERE cpf_padrinho IS NULL;

-- 7, 24
-- Cria uma view com o nome e um email de cada professor.
CREATE VIEW P_NomeEmail AS SELECT P.nome, E.email FROM Professor P, Email E WHERE P.cpf_professor = E.cpf_professor;

-- 8, 21
-- Exibe o nome dos professores que possuem mais de um email cadastrado.
SELECT nome FROM P_NomeEmail GROUP BY nome HAVING COUNT(nome) > 1;

-- 9
-- Deleta a view.
DROP VIEW P_NomeEmail;

-- 15
-- Adiciona a coluna cr na tabela Aluno.
ALTER TABLE Aluno ADD cr NUMBER(4,2);

-- 14
-- Modifica o tipo da coluna cr da tabela Aluno.
ALTER TABLE Aluno MODIFY cr VARCHAR2(10);

-- 16
-- Deleta a coluna cr da tabela Aluno.
ALTER TABLE Aluno DROP COLUMN cr;

-- 17
-- Exibe o nome e a média geral de cada aluno.
SELECT A.nome, AVG(C.media) AS Media_Geral FROM Aluno A, Cursa C WHERE A.cpf_aluno = C.cpf_aluno GROUP BY A.nome;

-- 17, 18, 43
-- Exibe a diferença entre o valor do investimento no projeto e a média total dos investimentos de todos os projetos.
SELECT P.titulo, (P.investimento - (SELECT AVG(investimento) FROM Projeto)) AS DIFF_FROM_AVG FROM Projeto P;

-- 20
-- Exibe o nome de todos os alunos que cursam alguma disciplina.
SELECT DISTINCT A.nome FROM Aluno A, Cursa C WHERE C.cpf_aluno = A.cpf_aluno;

-- 39
-- Deleta da tabela Cursa as entradas em que a média da entrada é menor que a média daquela respectiva disciplina.
DELETE FROM Cursa C1 WHERE C1.media < (SELECT AVG(C2.media) FROM Cursa C2 WHERE C1.codigo_disc = C2.codigo_disc);

-- 42
-- Exibe a maior média geral dos alunos.
SELECT MAX(Media_Geral) AS Maior_CR FROM (SELECT A.nome, AVG(C.media) AS Media_Geral FROM Aluno A, Cursa C WHERE A.cpf_aluno = C.cpf_aluno GROUP BY A.nome);

SET serveroutput ON;

-- 88 - Registro como parâmetro de função ou procedimento
-- Recebe um registro de um aluno e imprime quem é o padrinho.
CREATE OR REPLACE PROCEDURE NomePadrinho (info Aluno%ROWTYPE) IS
    padrinho VARCHAR2(30);
BEGIN
    IF (info.cpf_padrinho IS NULL) THEN
        DBMS_OUTPUT.PUT_LINE('O(A) aluno(a) '||info.nome||' nao possui padrinho.');
    ELSE
        SELECT A.nome INTO padrinho FROM Aluno A WHERE A.cpf_aluno = info.cpf_padrinho;
        DBMS_OUTPUT.PUT_LINE('O(A) aluno(a) '||info.nome||' eh apadrinhado por '||padrinho||'.');
    END IF;
END NomePadrinho;
/

-- 89 - Função com registro como retorno
-- Retorna o registro de um aluno a partir do cpf dele.
CREATE OR REPLACE FUNCTION getAluno (v_cpf IN Aluno.cpf_aluno%TYPE) RETURN Aluno%ROWTYPE IS
    v_aluno Aluno%ROWTYPE;
BEGIN
    SELECT * INTO v_aluno FROM Aluno A WHERE A.cpf_aluno = v_cpf;
    RETURN v_aluno;
END getAluno;
/

-- Teste da função getAluno() e do procedimento NomePadrinho()
DECLARE 
    al Aluno%ROWTYPE;
BEGIN
    al := getAluno(0000);
    NomePadrinho(al);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('CPF não encontrado!');
END;
/

