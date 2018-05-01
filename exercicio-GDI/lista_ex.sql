/*** Question 1  ***/
    SELECT E.nome FROM empregado E 
    WHERE E.cpf IN (SELECT G.cpf FROM graduado G) AND E.salario BETWEEN 3000 AND 4000;
    /*** Result 
    ** Marco Aurelio
    ** Gustavo Marques
    ** Leticia Gouveia
    ** Ricardo Teodoro
    ***/
/*** Question 2  ***/
    SELECT E.nome, E.cpf, E.salario FROM empregado E
    WHERE E.salario BETWEEN ((SELECT MIN(salario) FROM empregado)+1000) AND ((SELECT MAX(salario) FROM empregado)+1000);
    /*** Result 
    ** 1111
    ** 2222
    ** 3333
    ** 6666
    ** 7777
    ** 8888
    ** 9999
    ** 0
    ** 9875
    ** 6542
    ***/
/*** Question 3  ***/
    SELECT DISTINCT P.cpf FROM participa P 
    WHERE P.codigo_projeto IN (SELECT Pr.codigo FROM projeto Pr WHERE Pr.valor > (SELECT AVG(valor) FROM projeto));
    /*** Result 
    ** 2222
    ** 6666
    ** 9999
    ** 1111
    ** 7777
    ** 8888
    ** 5555
    ** 0
    ***/
/*** Question 4  ***/
/*** Question 5  ***/
    SELECT E.nome FROM empregado E
    WHERE E.sexo = 'F' 
      AND E.cpf IN (SELECT T.cpf FROM tecnico T WHERE T.ultima_serie > 8)
      AND E.cpf IN (SELECT T.cpf FROM trabalha T 
                    WHERE T.codigo_depto = 2 
                      AND T.codigo_gratif IS NULL 
                      AND T.data_trabalha BETWEEN to_date('01/01/2005', 'dd/mm/yyyy') AND to_date('12/12/2010', 'dd/mm/yyyy'));
    /*** Result 
    ** Josefa Paes
    ***/
/*** Question 6  ***/
    SELECT E.nome, E.dt_nasc, E1.nome FROM empregado E, empregado E1
    WHERE E.nome LIKE 'J%'
      AND E.cpf_lider IS NOT NULL
      AND E1.cpf = E.cpf_lider
    ORDER BY E.dt_nasc;
    /*** Result 
    ** Joaquim Carvalho | 28/04/83 | Joao da Silva
    ** Josefa Paes      | 23/11/90 | Joao da Silva
    ***/
/*** Question 7  ***/
    UPDATE trabalha SET codigo_gratif = NULL WHERE codigo_depto IN 
    (SELECT codigo FROM departamento WHERE descricao = 'Vendas');
    DELETE FROM fone WHERE cpf IN
    (SELECT cpf FROM titulacao_empregado WHERE codigo_ies IN
    (SELECT codigo FROM ies WHERE sigla = 'FIFA'));
/*** Question 8  ***/
    SELECT E.cpf FROM empregado E
    WHERE E.salario < (SELECT AVG(salario) FROM empregado)
       OR (E.salario > (SELECT MAX(E1.salario) FROM empregado E1 
                        WHERE E1.cpf IN (SELECT cpf_chefe FROM departamento)) 
                          AND E.cpf NOT IN (SELECT cpf_chefe FROM departamento));
    /*** Result 
    ** 2222
    ** 4444
    ** 5555
    ** 7777
    ** 8888
    ** 9999
    ** 0
    ** 9875
    ** 6542
    ***/
/*** Question 9  ***/
    CREATE OR REPLACE TRIGGER salarioIdoso
    BEFORE INSERT OR UPDATE ON empregado
    FOR EACH ROW
    BEGIN
    	IF (SYSDATE - :NEW.dt_nasc)/365 > 60 AND :NEW.salario < 4000 THEN
    		RAISE_APPLICATION_ERROR(-20205, 'Idosos não podem receber menos de R$4000');
    	END IF;
    END salarioIdoso;
    /
    /** Teste **/
    INSERT INTO empregado (cpf, cpf_lider, nome, dt_nasc, sexo, salario, cep)VALUES (1212, NULL, 'Gilmar Pedrosa', to_date ('21/02/1940', 'dd/mm/yyyy'), 'M', 3000.00, 401000);
/*** Question 10 ***/
    CREATE OR REPLACE PROCEDURE nomeIdade (cpfInput IN NUMBER, idade OUT NUMBER) IS
        nome VARCHAR2(50);
        nasc DATE;
    BEGIN
    	SELECT E.nome, E.dt_nasc INTO nome, nasc FROM empregado E WHERE E.cpf = cpfInput;
    	DBMS_OUTPUT.PUT_LINE(TO_CHAR(nome));
    	idade := (SYSDATE - nasc)/365;
    END nomeIdade;
    /
    /** Teste **/
    DECLARE
        idade NUMBER;
        cpf NUMBER := 2222;
    BEGIN
        nomeIdade(cpf, idade);
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(idade));
    END;
    /
/*** Question 11 ***/
    CREATE OR REPLACE FUNCTION empregadosAtividade (atividade NUMBER) RETURN NUMBER IS
        contador NUMBER;
        CURSOR emps IS (SELECT * FROM empregado E WHERE E.cpf IN (SELECT P.cpf FROM participa P WHERE P.codigo_atividade = atividade));
        emp empregado%ROWTYPE;
    BEGIN
    	contador := 0;
        OPEN emps;
    	LOOP
            FETCH emps INTO emp;
            EXIT WHEN emps%NOTFOUND;
    		DBMS_OUTPUT.PUT_LINE('CPF: '||TO_CHAR(emp.cpf)||' Nome: '||TO_CHAR(emp.nome));
    		contador := contador + 1;
    	END LOOP;
        CLOSE emps;
    	RETURN contador;
    END empregadosAtividade;
    /
    /** Teste **/
    BEGIN
        DBMS_OUTPUT.PUT_LINE(to_char(empregadosAtividade(1)));
    END;
    /
/*** Question 12 ***/
    CREATE OR REPLACE PROCEDURE novoChefe (v_cod_depto IN departamento.codigo%TYPE, v_cpf IN OUT empregado.cpf%TYPE) IS
        v_old_cpf departamento.cpf_chefe%TYPE;
    BEGIN
        SELECT cpf_chefe INTO v_old_cpf FROM departamento WHERE codigo = v_cod_depto;
        UPDATE departamento SET cpf_chefe = v_cpf WHERE codigo = v_cod_depto;
        v_cpf := v_old_cpf;
    END novoChefe;
    /
    DECLARE
        v_cpf departamento.cpf_chefe%TYPE;
        v_cod departamento.codigo%TYPE;
    BEGIN
        v_cod := 1;
        v_cpf := 7777;
        WHILE v_cod < 4 LOOP
            novoChefe(v_cod, v_cpf);
            v_cod := v_cod + 1;
        END LOOP
    END;
    /
/*** Question 13 ***/
    CREATE OR REPLACE TRIGGER qntEmpregados
    AFTER INSERT OR DELETE ON empregado
    DECLARE
        novaQnt NUMBER;
    BEGIN
        SELECT COUNT(cpf) INTO novaQnt FROM empregado;
        DBMS_OUTPUT.PUT_LINE(to_char(novaQnt));
    END;
    /
    /** Teste **/
    INSERT INTO empregado (cpf, cpf_lider, nome, dt_nasc, sexo, salario, cep) VALUES (8456, 0000, 'Fulado de Tal', to_date ('15/01/1998', 'dd/mm/yyyy'), 'M',5500.00, 774100);
/*** Question 14 ***/
/*** Question 15 ***/
    DECLARE
        CURSOR emps IS (SELECT * FROM empregado E WHERE E.cpf_lider = 1111 AND E.salario > 3500);
        emp empregado%ROWTYPE;
    BEGIN
        OPEN emps;
        LOOP
            FETCH emps INTO emp;
            EXIT WHEN emps%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(emp.nome);
        END LOOP;
        CLOSE emps;
    END;
    /
    /*** Result 
    ** Josefa Paes
    ** Joaquim Carvalho
    ** Gilmar Pedrosa
    ***/
/*** Question 16 ***/
    CREATE OR REPLACE TRIGGER valorProjeto
    BEFORE INSERT OR UPDATE ON projeto
    FOR EACH ROW
    BEGIN
        IF :NEW.valor > 100000 OR :NEW.valor < 1500 THEN
            RAISE_APPLICATION_ERROR(-20120, 'Um projeto nao pode ter este valor');
        END IF;
    END valorProjeto;
    /
    /** Teste **/
    INSERT INTO Projeto (codigo, descricao, valor) VALUES (8, 'Projeto 8', 152000.00);
/*** Question 17 ***/
    CREATE OR REPLACE PROCEDURE projetosValorN (valorP IN projeto.valor%TYPE) IS
        CURSOR projs IS (SELECT * FROM projeto WHERE projeto.valor = valorP);
        prj projeto%ROWTYPE;
        contador NUMBER := 0;
    BEGIN
        OPEN projs;
        LOOP
            FETCH projs INTO prj;
            EXIT WHEN projs%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Desc.: '|| prj.descricao);
            contador := contador + 1;
        END LOOP;
        CLOSE projs;
        DBMS_OUTPUT.PUT_LINE(contador);
    END projetosValorN;
    /
    /** Teste **/
    EXEC projetosValorN(5000);
/*** Question 18 ***/
    ALTER TABLE fone MODIFY COLUMN fone varchar(10);
    CREATE OR REPLACE PROCEDURE add9 IS
    BEGIN
        UPDATE fone E SET E.fone = ('9'||E.fone);
    END add9;
    /
/*** Question 19 ***/
    CREATE VIEW supervisionadosJoao AS
    SELECT * FROM empregado E WHERE E.cpf_lider = (SELECT cpf FROM empregado E1 WHERE E1.nome = 'Joao da Silva');
/*** Question 20 ***/
/*** Question 21 ***/
    SELECT TE.codigo_ies, COUNT(DISTINCT T.cpf) FROM trabalha T, titulacao_empregado TE 
    WHERE T.codigo_gratif IS NOT NULL AND TE.cpf = T.cpf GROUP BY TE.codigo_ies;
/*** Question 22 ***/
    CREATE OR REPLACE PACKAGE question22 IS
        FUNCTION dadosProjeto (v_codigo IN projeto.codigo%TYPE) RETURN projeto%ROWTYPE;
        PROCEDURE detalhesProjeto (v_projeto IN projeto%ROWTYPE);
    END question22;
    /
    CREATE OR REPLACE PACKAGE BODY question22 IS
        FUNCTION dadosProjeto (v_codigo IN projeto.codigo%TYPE) RETURN projeto%ROWTYPE IS
            v_projeto projeto%ROWTYPE;
        BEGIN
            SELECT * INTO v_projeto FROM projeto WHERE codigo = v_codigo;
            RETURN v_projeto;
        END dadosProjeto;

        PROCEDURE detalhesProjeto (v_projeto IN projeto%ROWTYPE) IS
        BEGIN
            DBMS_OUTPUT.PUT_LINE(v_projeto.descricao);
        END detalhesProjeto;
    END question22;
    /
/*** Question 23 ***/
    CREATE OR REPLACE TRIGGER qntEmpregadosMasculinos
    AFTER INSERT ON empregado
    DECLARE
        novaQnt NUMBER;
    BEGIN
        SELECT COUNT(cpf) INTO novaQnt FROM empregado WHERE sexo = 'M';
        DBMS_OUTPUT.PUT_LINE('A dona aranha subiu pela parede, veio a chuva forte e a derrubou');
    END;
    /
    /** Teste **/
    -- DELETE FROM empregado WHERE cpf = 8456;
    -- INSERT INTO empregado (cpf, cpf_lider, nome, dt_nasc, sexo, salario, cep) VALUES (8456, 0000, 'Fulado de Tal', to_date ('15/01/1998', 'dd/mm/yyyy'), 'M',5500.00, 774100);
/*** Question 24 ***/
    CREATE OR REPLACE PROCEDURE detalhesFunc (cpfIn IN empregado.cpf%TYPE) IS
        v_nome empregado.nome%TYPE;
        v_sexo empregado.sexo%TYPE;
        v_salario empregado.salario%TYPE;
    BEGIN
        SELECT E.nome, E.sexo, E.salario INTO v_nome, v_sexo, v_salario FROM empregado E WHERE E.cpf = cpfIn;
        DBMS_OUTPUT.PUT_LINE('Nome: '||v_nome); 
        DBMS_OUTPUT.PUT_LINE('Sexo: '||v_sexo); 
        DBMS_OUTPUT.PUT_LINE('Salario: '||v_salario); 
    END detalhesFunc;
    /
    /** Teste **/
    EXEC detalhesFunc(1111);
/*** Question 25 ***/
    CREATE OR REPLACE TRIGGER aumento
    AFTER INSERT ON participa
    FOR EACH ROW
    DECLARE
        v_salario empregado.salario%TYPE;
    BEGIN
        SELECT E.salario INTO v_salario FROM empregado E WHERE E.cpf = :NEW.cpf;
        UPDATE empregado E SET E.salario = (v_salario + 50) WHERE E.cpf = :NEW.cpf;
    END;
    /
/*** Question 26 ***/
    CREATE TABLE cpfEven(
        cpf NUMBER,
        CONSTRAINT cpfEven_pk PRIMARY KEY (cpf)
    );
    CREATE TABLE cpfOdd(
        cpf NUMBER,
        CONSTRAINT cpfOdd_pk PRIMARY KEY (cpf)
    );
    CREATE OR REPLACE PROCEDURE cpfEvenOdd IS
        CURSOR emps IS SELECT cpf FROM empregado;
        v_cpf empregado.cpf%TYPE;
    BEGIN
        OPEN emps;
        LOOP
            FETCH emps INTO v_cpf;
            EXIT WHEN emps%NOTFOUND;
            IF MOD(v_cpf, 2) = 0 THEN
                INSERT INTO cpfEven(cpf) VALUES (v_cpf);
            ELSE
                INSERT INTO cpfOdd(cpf) VALUES (v_cpf);
            END IF;
        END LOOP;
        CLOSE emps;
    END cpfEvenOdd;
    /
