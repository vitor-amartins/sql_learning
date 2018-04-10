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
-- Exibe o código e o nome das disiciplinas em que a quantidade de alunos é NULL
SELECT codigo_disc, nome FROM Disciplina WHERE qnt_alunos IS NULL;

-- 7, 24
-- Cria uma view com o nome e um email de cada professor.
CREATE VIEW P_NomeEmail AS SELECT P.nome, E.email FROM Professor P, Email E WHERE P.cpf_professor = E.cpf_professor;

-- 8, 21
-- Exibe o nome dos professores que possuem mais de um email cadastrado.
SELECT nome FROM P_NomeEmail GROUP BY nome HAVING COUNT(nome) > 1;

-- 9
-- Deleta a view.
DROP VIEW P_NomeEmail;