CREATE OR REPLACE TYPE tp_Curso AS OBJECT(
    codigo NUMBER,
    nome VARCHAR2(50),
    nota_mec NUMBER(4,2)
) NOT FINAL;
/

CREATE OR REPLACE TYPE tp_Bacharelado UNDER tp_Curso (
    linha_pesquisa VARCHAR2(50)
) FINAL;
/

CREATE OR REPLACE TYPE tp_Licenciatura UNDER tp_Curso (
    disciplinas_obrigatorias VARCHAR2(50)
) FINAL;
/

CREATE OR REPLACE TYPE tp_Endereco AS OBJECT(
    cep NUMBER,
	descricao VARCHAR2(30),
    CONSTRUCTOR FUNCTION tp_Endereco(cep NUMBER) RETURN SELF AS RESULT
) FINAL;
/

CREATE OR REPLACE TYPE BODY tp_Endereco AS
    CONSTRUCTOR FUNCTION tp_Endereco(cep NUMBER)
    RETURN SELF AS RESULT IS
    BEGIN
        SELF.descricao = 'Sem nome';
        RETURN;
    END;
END;
/

CREATE OR REPLACE TYPE tp_Aluno AS OBJECT(
    cpf_aluno NUMBER,
	data_nasc DATE,
	nome VARCHAR2(50),
	ref_curso REF tp_Curso,
	ref_padrinho REF tp_Aluno,
    endereco tp_Endereco
) FINAL;
/

CREATE OR REPLACE TYPE tp_Email AS OBJECT(
    email VARCHAR2(50),
) FINAL;
/

CREATE OR REPLACE TYPE tp_Emails AS VARRAY(3) OF tp_Email;
/

CREATE OR REPLACE TYPE tp_Professor AS OBJECT(
    cpf_professor NUMBER,
    data_nasc DATE,
    nome VARCHAR2(50),
    emails tp_Emails
) FINAL;
/

CREATE OR REPLACE TYPE tp_Disciplina AS OBJECT(
    codigo_disc NUMBER,
	qnt_alunos NUMBER,
	ref_professor REF tp_Professor,
	nome VARCHAR2(50)
) FINAL;
/

CREATE OR REPLACE TYPE tp_Sala AS OBJECT(
    codigo NUMBER,
	capacidade NUMBER,
	centro VARCHAR2(50)
) FINAL;
/

CREATE OR REPLACE TYPE tp_Ic AS OBJECT(
    codigo NUMBER,
	data_inic DATE,
	tema VARCHAR2(100),
	ref_aluno REF tp_Aluno
) FINAL;
/

CREATE OR REPLACE TYPE tp_Projeto AS OBJECT(
    cpf_professor NUMBER,
    ref_professor REF tp_Professor,
	titulo VARCHAR2(100),
	descricao VARCHAR2(200),
	investimento NUMBER(10,2)
) FINAL;
/

CREATE OR REPLACE TYPE tp_Cursa AS OBJECT(
    cpf_aluno NUMBER,
	codigo_disc NUMBER,
    ref_aluno REF tp_Aluno,
    ref_disciplina REF tp_Disciplina,
    media NUMBER(4,2)
) FINAL;
/

CREATE OR REPLACE TYPE tp_Aula AS OBJECT(
    codigo_sala NUMBER,
    cpf_aluno NUMBER,
    cpf_professor NUMBER,
    horario TIMESTAMP,
    ref_aluno REF tp_Aluno,
    ref_sala REF tp_Sala,
    ref_professor REF tp_Professor
) FINAL;
/
