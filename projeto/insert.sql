INSERT INTO Curso(codigo, nome, nota_mec) VALUES (001, 'Engenharia da Computação', 10.00);
INSERT INTO Curso(codigo, nome, nota_mec) VALUES (002, 'Letras', 8.50);
INSERT INTO Curso(codigo, nome, nota_mec) VALUES (003, 'Matemática', 9.52);
INSERT INTO Curso(codigo, nome, nota_mec) VALUES (004, 'Ciência Política', 7.60);
INSERT INTO Curso(codigo, nome, nota_mec) VALUES (005, 'Ciência da Computação', 6.20);
INSERT INTO Curso(codigo, nome, nota_mec) VALUES (006, 'Arquitetura', 8.24);

INSERT INTO Bacharelado(codigo, linha_de_pesquisa) VALUES (001, 'Informática');
INSERT INTO Bacharelado(codigo, linha_de_pesquisa) VALUES (004, 'Política');
INSERT INTO Bacharelado(codigo, linha_de_pesquisa) VALUES (005, 'Informática');
INSERT INTO Bacharelado(codigo, linha_de_pesquisa) VALUES (006, 'Urbanismo');

INSERT INTO Licenciatura(codigo, disciplinas_obrigatorias) VALUES (002, 'Metodologia');
INSERT INTO Licenciatura(codigo, disciplinas_obrigatorias) VALUES (003, 'Pedagogia');

INSERT INTO Endereco(cep, descricao) VALUES (00000, 'Rua dos Bobos');
INSERT INTO Endereco(cep, descricao) VALUES (00020, 'Rua dos Caras Dahoras');
INSERT INTO Endereco(cep, descricao) VALUES (00040, 'Rua de Cima');
INSERT INTO Endereco(cep, descricao) VALUES (00060, 'Rua de Baixo');
INSERT INTO Endereco(cep, descricao) VALUES (00080, 'Rua Esburacada');
INSERT INTO Endereco(cep, descricao) VALUES (57020, 'Rua Formosa');

INSERT INTO Aluno(cpf_aluno, data_nasc, codigo_curso, cpf_padrinho, nome, cep) VALUES (0000, to_date('07/04/1998', 'dd/mm/yyyy'), 001, NULL, 'Vitor', 00020);
INSERT INTO Aluno(cpf_aluno, data_nasc, codigo_curso, cpf_padrinho, nome, cep) VALUES (1111, to_date('26/03/1998', 'dd/mm/yyyy'), 006, 0000, 'Maria', 57020);
INSERT INTO Aluno(cpf_aluno, data_nasc, codigo_curso, cpf_padrinho, nome, cep) VALUES (2222, to_date('07/06/1998', 'dd/mm/yyyy'), 003, 1111, 'Lucas', 00080);
INSERT INTO Aluno(cpf_aluno, data_nasc, codigo_curso, cpf_padrinho, nome, cep) VALUES (3333, to_date('25/08/1998', 'dd/mm/yyyy'), 002, 2222, 'Allex', 00040);
INSERT INTO Aluno(cpf_aluno, data_nasc, codigo_curso, cpf_padrinho, nome, cep) VALUES (4444, to_date('13/11/1998', 'dd/mm/yyyy'), 005, 1111, 'Karol', 00000);
INSERT INTO Aluno(cpf_aluno, data_nasc, codigo_curso, cpf_padrinho, nome, cep) VALUES (5555, to_date('02/01/1999', 'dd/mm/yyyy'), 004, 0000, 'Sammy', 00060);

INSERT INTO Professor(cpf_professor, data_nasc, nome) VALUES (0101, to_date('29/02/1990', 'dd/mm/yyyy'), 'Roberval');
INSERT INTO Professor(cpf_professor, data_nasc, nome) VALUES (1212, to_date('21/03/1987', 'dd/mm/yyyy'), 'Cresovil');
INSERT INTO Professor(cpf_professor, data_nasc, nome) VALUES (2323, to_date('19/12/1972', 'dd/mm/yyyy'), 'Josueldo');

INSERT INTO Email(email, cpf_professor) VALUES ('roberval@sexy.com', 0101);
INSERT INTO Email(email, cpf_professor) VALUES ('cresovil@sexy.com', 1212);
INSERT INTO Email(email, cpf_professor) VALUES ('ovil1234@sexy.com', 1212);
INSERT INTO Email(email, cpf_professor) VALUES ('josueldo@sexy.com', 2323);

INSERT INTO Disciplina(codigo_disc, qnt_alunos, cpf_professor, nome) VALUES (1, 0, 0101, 'Programação');
INSERT INTO Disciplina(codigo_disc, qnt_alunos, cpf_professor, nome) VALUES (2, 0, 1212, 'História da Arquitetura');
INSERT INTO Disciplina(codigo_disc, qnt_alunos, cpf_professor, nome) VALUES (3, 0, 2323, 'Cálculo I');
INSERT INTO Disciplina(codigo_disc, qnt_alunos, cpf_professor, nome) VALUES (4, 0, 2323, 'Cálculo II');
INSERT INTO Disciplina(codigo_disc, qnt_alunos, cpf_professor, nome) VALUES (5, 0, 2323, 'Cálculo III');
INSERT INTO Disciplina(codigo_disc, qnt_alunos, cpf_professor, nome) VALUES (6, 0, 2323, 'Física I');
INSERT INTO Disciplina(codigo_disc, qnt_alunos, cpf_professor, nome) VALUES (7, 0, 2323, 'Física II');
INSERT INTO Disciplina(codigo_disc, qnt_alunos, cpf_professor, nome) VALUES (8, 0, 2323, 'Física III');

INSERT INTO Sala(codigo, capacidade, centro) VALUES (002, 050, 'CCEN');
INSERT INTO Sala(codigo, capacidade, centro) VALUES (003, 060, 'CCEN');
INSERT INTO Sala(codigo, capacidade, centro) VALUES (004, 070, 'CCEN');
INSERT INTO Sala(codigo, capacidade, centro) VALUES (005, 090, 'CCEN');
INSERT INTO Sala(codigo, capacidade, centro) VALUES (013, 120, 'Área 2');
INSERT INTO Sala(codigo, capacidade, centro) VALUES (015, 110, 'Área 2');
INSERT INTO Sala(codigo, capacidade, centro) VALUES (112, 050, 'CIN');

INSERT INTO Ic(codigo, data_inic, tema, cpf_aluno) VALUES (01, to_date('19/02/2018', 'dd/mm/yyyy'), 'IoT', 0000);
INSERT INTO Ic(codigo, data_inic, tema, cpf_aluno) VALUES (02, to_date('19/02/2017', 'dd/mm/yyyy'), 'TNA', 1111);
INSERT INTO Ic(codigo, data_inic, tema, cpf_aluno) VALUES (03, to_date('19/02/2016', 'dd/mm/yyyy'), 'PSB', 5555);

INSERT INTO Projeto(cpf_professor, titulo, descricao, investimento) VALUES (0101, 'LMS', 'Learning Management Systems', 200000.00);
INSERT INTO Projeto(cpf_professor, titulo, descricao, investimento) VALUES (1212, 'WTF', 'Wake Taller Faster', 150000.00);

INSERT INTO Cursa(cpf_aluno, codigo_disc, media) VALUES (0000, 1, 9.85);
INSERT INTO Cursa(cpf_aluno, codigo_disc, media) VALUES (2222, 5, 8.50);

INSERT INTO Aula(codigo_sala, cpf_aluno, cpf_professor, horario) VALUES (013, 2222, 2323, SYSDATE());