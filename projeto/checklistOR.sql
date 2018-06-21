SELECT I.get_tema() FROM tb_Ic I WHERE I.codigo = 01;
/

SELECT C.Estrelas() FROM tb_Curso C ORDER BY C.nota_mec;
/

SET SERVEROUTPUT ON;
/

DECLARE
    v_prof tp_Professor;
    v_nome VARCHAR2(50);
    v_cpf NUMBER;
    v_data DATE;
    result NUMBER;
BEGIN
    SELECT P.nome, P.cpf_professor, P.data_nasc INTO v_nome, v_cpf, v_data FROM tb_Professor P WHERE P.cpf_professor = 11;
    v_prof := NEW tp_Professor(v_cpf, v_data, v_nome, NULL);
    SELECT P.age_compare(v_prof) INTO result FROM tb_Professor P WHERE P.codigo = 22;

    IF (result = 1) THEN
        DBMS_OUTPUT.PUT_LINE(v_nome || 'é mais velho');
    ELSIF (result = 0) THEN
        DBMS_OUTPUT.PUT_LINE(v_nome || 'tem a mesma idade');
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_nome || 'é mais novo');
    END IF;
END;
/

ALTER TYPE tp_Aluno ADD ATTRIBUTE (saldoRU NUMBER) CASCADE;
/

ALTER TYPE tp_Aluno MODIFY ATTRIBUTE (saldoRU NUMBER(5,2)) CASCADE;
/

ALTER TYPE tp_Aluno DROP ATTRIBUTE (saldoRU) CASCADE;
/

ALTER TYPE tp_Curso ADD ATTRIBUTE (qntGraduados NUMBER) CASCADE;
/

ALTER TYPE tp_Curso DROP ATTRIBUTE (qntGraduados) INVALIDATE;
/

DECLARE
    b1 tp_Bacharelado;
BEGIN
    SELECT VALUE(B) INTO b1 FROM tb_Bacharelado B WHERE codigo = 001;
    b1.get_nota_mec();
END;
/

SELECT * FROM TABLE(SELECT P.emails FROM tb_Professor P WHERE P.cpf_professor = 66);
/

CREATE TYPE tp_nt_email AS TABLE OF tp_Email;
/

SELECT * FROM tb_Aluno A WHERE A.nome LIKE '_a%';
/
SELECT * FROM tb_Curso C WHERE C.nota_mec BETWEEN 7.0 AND 8.0;
/
SELECT * FROM tb_Aluno A ORDER BY A.nome;
/

CREATE OR REPLACE TRIGGER valor_invest
BEFORE INSERT OR UPDATE ON tb_Projeto
FOR EACH ROW
BEGIN
    IF (:NEW.investimento < 1000) THEN
        RAISE_APPLICATION_ERROR(20201, 'Valor de investimento muito baixo');
    END IF;
END valor_invest;
/

CREATE OR REPLACE TRIGGER lock_cursos
BEFORE DELETE ON tb_Curso
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(20202, 'Não é possível excluir cursos');
END lock_cursos;
/

CREATE OR REPLACE TRIGGER limit_cursos
BEFORE INSERT ON tb_Curso
BEGIN
    RAISE_APPLICATION_ERROR(20202, 'Não é possível adicionar mais cursos');
END limit_cursos;
/

SELECT C.nome FROM tb_Curso C WHERE C.codigo IN (SELECT C.codigo FROM tb_Curso C WHERE C.nota_mec >= 7.0);
/

CREATE TABLE tb_Aluno2 OF tp_Aluno (
    cpf_aluno PRIMARY KEY,
    nome NOT NULL,
    data_nasc NOT NULL,
    ref_curso SCOPE IS tb_Curso,
    ref_padrinho WITH ROWID REFERENCES tb_Aluno,
    endereco NOT NULL
);
/

DROP TABLE tb_Aluno2;
/