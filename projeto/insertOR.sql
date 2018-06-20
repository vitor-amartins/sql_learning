INSERT INTO tb_Curso VALUES (001, 'Engenharia da Computação', 10.00);
INSERT INTO tb_Curso VALUES (002, 'Letras', 8.50);
INSERT INTO tb_Curso VALUES (003, 'Matemática', 9.52);
INSERT INTO tb_Curso VALUES (004, 'Ciência Política', 7.60);
INSERT INTO tb_Curso VALUES (005, 'Ciência da Computação', 6.20);
INSERT INTO tb_Curso VALUES (006, 'Arquitetura', 8.24);

INSERT INTO tb_Bacharelado VALUES (001, 'Engenharia da Computação', 10.00, 'Informática');
INSERT INTO tb_Bacharelado VALUES (004, 'Ciência Política', 7.60, 'Política');
INSERT INTO tb_Bacharelado VALUES (005, 'Ciência da Computação', 6.20, 'Informática');
INSERT INTO tb_Bacharelado VALUES (006, 'Arquitetura', 8.24, 'Urbanismo');

INSERT INTO tb_Licenciatura VALUES (002, 'Letras', 8.50, 'Metodologia');
INSERT INTO tb_Licenciatura VALUES (003, 'Matemática', 9.52, 'Pedagogia');

INSERT INTO tb_Aluno VALUES (0000, to_date('07/04/1998', 'dd/mm/yyyy'), 'Vitor', (SELECT REF(C) FROM tb_Curso WHERE C.codigo = 001), NULL, tp_Endereco(00020, 'Rua dos Caras Dahoras'));
INSERT INTO tb_Aluno VALUES (1111, to_date('26/03/1998', 'dd/mm/yyyy'), 'Maria', (SELECT REF(C) FROM tb_Curso WHERE C.codigo = 006), (SELECT REF(A) FROM tb_Aluno WHERE A.cpf_aluno = 0000), tp_Endereco(57020, 'Rua Formosa'));
INSERT INTO tb_Aluno VALUES (2222, to_date('07/06/1998', 'dd/mm/yyyy'), 'Lucas', (SELECT REF(C) FROM tb_Curso WHERE C.codigo = 003), (SELECT REF(A) FROM tb_Aluno WHERE A.cpf_aluno = 1111), tp_Endereco(00080, 'Rua Esburacada'));
INSERT INTO tb_Aluno VALUES (3333, to_date('07/06/1998', 'dd/mm/yyyy'), 'Allex', (SELECT REF(C) FROM tb_Curso WHERE C.codigo = 002), (SELECT REF(A) FROM tb_Aluno WHERE A.cpf_aluno = 2222), tp_Endereco(00040, 'Rua de Cima'));
INSERT INTO tb_Aluno VALUES (4444, to_date('13/11/1998', 'dd/mm/yyyy'), 'Karol', (SELECT REF(C) FROM tb_Curso WHERE C.codigo = 005), (SELECT REF(A) FROM tb_Aluno WHERE A.cpf_aluno = 1111), tp_Endereco(00000, 'Rua dos Bobos'));
INSERT INTO tb_Aluno VALUES (5555, to_date('02/01/1999', 'dd/mm/yyyy'), 'Sammy', (SELECT REF(C) FROM tb_Curso WHERE C.codigo = 004), (SELECT REF(A) FROM tb_Aluno WHERE A.cpf_aluno = 0000), tp_Endereco(00060, 'Rua de Baixo'));

INSERT INTO tb_Professor VALUES (11, to_date('28/02/1990', 'dd/mm/yyyy'), 'ACM', tp_Emails(tp_Email('acm@cin.ufpe.br')));
INSERT INTO tb_Professor VALUES (22, to_date('21/03/1987', 'dd/mm/yyyy'), 'RMAS', tp_Emails(tp_Email('rmas@cin.ufpe.br')));
INSERT INTO tb_Professor VALUES (33, to_date('19/12/1972', 'dd/mm/yyyy'), 'PSGMN', tp_Emails(tp_Email('psgmn@cin.ufpe.br')));
INSERT INTO tb_Professor VALUES (44, to_date('09/10/1965', 'dd/mm/yyyy'), 'Romena', tp_Emails(tp_Email('romena@ufpe.br')));
INSERT INTO tb_Professor VALUES (55, to_date('14/07/1978', 'dd/mm/yyyy'), 'Américo', tp_Emails(tp_Email('americo@ufpe.br')));
INSERT INTO tb_Professor VALUES (66, to_date('23/05/1980', 'dd/mm/yyyy'), 'Castor', tp_Emails(tp_Email('castor@cin.ufpe.br'), tp_Email('fjclf@cin.ufpe.br')));
INSERT INTO tb_Professor VALUES (77, to_date('02/06/1985', 'dd/mm/yyyy'), 'ASG', tp_Emails(tp_Email('asg@cin.ufpe.br')));

INSERT INTO tb_Disciplina VALUES (01, 0050, (SELECT REF(P) FROM tb_Professor WHERE P.cpf_professor = 11), 'IP');
INSERT INTO tb_Disciplina VALUES (02, 0050, (SELECT REF(P) FROM tb_Professor WHERE P.cpf_professor = 33), 'AVLC');
INSERT INTO tb_Disciplina VALUES (03, 0020, (SELECT REF(P) FROM tb_Professor WHERE P.cpf_professor = 66), 'Desenvolvimento iOS');
INSERT INTO tb_Disciplina VALUES (04, 0050, (SELECT REF(P) FROM tb_Professor WHERE P.cpf_professor = 44), 'Cálculo I');
INSERT INTO tb_Disciplina VALUES (05, null, (SELECT REF(P) FROM tb_Professor WHERE P.cpf_professor = 44), 'Cálculo II');
INSERT INTO tb_Disciplina VALUES (06, null, (SELECT REF(P) FROM tb_Professor WHERE P.cpf_professor = 44), 'Cálculo III');
INSERT INTO tb_Disciplina VALUES (07, null, (SELECT REF(P) FROM tb_Professor WHERE P.cpf_professor = 55), 'Física I');
INSERT INTO tb_Disciplina VALUES (08, null, (SELECT REF(P) FROM tb_Professor WHERE P.cpf_professor = 55), 'Física II');
INSERT INTO tb_Disciplina VALUES (09, null, (SELECT REF(P) FROM tb_Professor WHERE P.cpf_professor = 55), 'Física III');
INSERT INTO tb_Disciplina VALUES (10, 0030, (SELECT REF(P) FROM tb_Professor WHERE P.cpf_professor = 22), 'Métodos Numéricos');

INSERT INTO tb_Sala VALUES (002, 050, 'CCEN');
INSERT INTO tb_Sala VALUES (003, 060, 'CCEN');
INSERT INTO tb_Sala VALUES (004, 070, 'CCEN');
INSERT INTO tb_Sala VALUES (005, 090, 'CCEN');
INSERT INTO tb_Sala VALUES (013, 120, 'Área 2');
INSERT INTO tb_Sala VALUES (015, 110, 'Área 2');
INSERT INTO tb_Sala VALUES (112, 050, 'CIN');

INSERT INTO tb_Ic VALUES (01, to_date('19/02/2018', 'dd/mm/yyyy'), 'IoT', (SELECT REF(A) FROM tb_Aluno WHERE A.cpf_aluno = 0000));
INSERT INTO tb_Ic VALUES (02, to_date('19/02/2017', 'dd/mm/yyyy'), 'TNA', (SELECT REF(A) FROM tb_Aluno WHERE A.cpf_aluno = 1111));
INSERT INTO tb_Ic VALUES (03, to_date('19/02/2016', 'dd/mm/yyyy'), 'PSB', (SELECT REF(A) FROM tb_Aluno WHERE A.cpf_aluno = 5555));

INSERT INTO tb_Projeto VALUES (77, (SELECT REF(P) FROM tb_Professor WHERE P.cpf_professor = 77), 'LMS', 'Learning Management Systems', 200000.00);
INSERT INTO tb_Projeto VALUES (22, (SELECT REF(P) FROM tb_Professor WHERE P.cpf_professor = 22), 'OTI', 'Otimization', 15000.00);
INSERT INTO tb_Projeto VALUES (66, (SELECT REF(P) FROM tb_Professor WHERE P.cpf_professor = 66), 'GIT', 'Code Analytics', 100000.00);

INSERT INTO tb_Cursa VALUES (0000, 1, (SELECT REF(A) FROM tb_Aluno WHERE A.cpf_aluno = 0000), (SELECT REF(D) FROM tb_Disciplina WHERE D.codigo_disc = 1), 10.0);
INSERT INTO tb_Cursa VALUES (0000, 2, (SELECT REF(A) FROM tb_Aluno WHERE A.cpf_aluno = 0000), (SELECT REF(D) FROM tb_Disciplina WHERE D.codigo_disc = 2), 9.50);
INSERT INTO tb_Cursa VALUES (2222, 5, (SELECT REF(A) FROM tb_Aluno WHERE A.cpf_aluno = 2222), (SELECT REF(D) FROM tb_Disciplina WHERE D.codigo_disc = 5), 8.50);
INSERT INTO tb_Cursa VALUES (2222, 1, (SELECT REF(A) FROM tb_Aluno WHERE A.cpf_aluno = 2222), (SELECT REF(D) FROM tb_Disciplina WHERE D.codigo_disc = 1), 5.00);
INSERT INTO tb_Cursa VALUES (4444, 10, (SELECT REF(A) FROM tb_Aluno WHERE A.cpf_aluno = 4444), (SELECT REF(D) FROM tb_Disciplina WHERE D.codigo_disc = 10), 4.00);

alter session set nls_timestamp_format = 'dd/mm/yyyy hh24:mi:ss.ff';

INSERT INTO tb_Aula VALUES (003, 2222, 11, '12/04/2018 08:00:00.00', (SELECT REF(A) FROM tb_Aluno WHERE A.cpf_aluno = 2222), (SELECT REF(S) FROM tb_Sala WHERE S.codigo = 003), (SELECT REF(P) FROM tb_Professor WHERE P.cpf_professor = 11));
INSERT INTO tb_Aula VALUES (004, 2222, 33, '12/04/2018 10:00:00.00', (SELECT REF(A) FROM tb_Aluno WHERE A.cpf_aluno = 2222), (SELECT REF(S) FROM tb_Sala WHERE S.codigo = 004), (SELECT REF(P) FROM tb_Professor WHERE P.cpf_professor = 33));
INSERT INTO tb_Aula VALUES (004, 2222, 33, '10/04/2018 08:00:00.00', (SELECT REF(A) FROM tb_Aluno WHERE A.cpf_aluno = 2222), (SELECT REF(S) FROM tb_Sala WHERE S.codigo = 004), (SELECT REF(P) FROM tb_Professor WHERE P.cpf_professor = 33));
INSERT INTO tb_Aula VALUES (003, 2222, 11, '10/04/2018 10:00:00.00', (SELECT REF(A) FROM tb_Aluno WHERE A.cpf_aluno = 2222), (SELECT REF(S) FROM tb_Sala WHERE S.codigo = 003), (SELECT REF(P) FROM tb_Professor WHERE P.cpf_professor = 11));