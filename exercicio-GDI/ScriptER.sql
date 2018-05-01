DROP TABLE trabalha;
DROP TABLE gratificacao;
DROP TABLE departamento;
DROP TABLE participa;
DROP TABLE atividade;
DROP TABLE projeto;
DROP TABLE titulacao_empregado;
DROP TABLE ies;
DROP TABLE grau;
DROP TABLE tecnico;
DROP TABLE graduado;
DROP TABLE fone;
DROP TABLE empregado;
DROP TABLE endereco;

CREATE TABLE endereco (
	cep NUMBER,
	descricao VARCHAR2(30) NOT NULL,
	CONSTRAINT endereco_pk PRIMARY KEY (cep)
);
CREATE TABLE empregado (
	cpf NUMBER,
	cpf_lider NUMBER,
	nome VARCHAR2(50) NOT NULL,
	dt_nasc DATE NOT NULL,
	sexo CHAR(1) NOT NULL,
	salario DECIMAL(6,2) NOT NULL,
	cep NUMBER NOT NULL,
	CONSTRAINT empregado_pk PRIMARY KEY (cpf),
	CONSTRAINT empregado_fk2 FOREIGN KEY (cep) REFERENCES endereco(cep),
	CONSTRAINT empregado_fk FOREIGN KEY (cpf_lider) REFERENCES empregado (cpf),
	CONSTRAINT empregado_check CHECK (sexo = 'M' OR sexo = 'F')
);
CREATE TABLE fone (
	cpf NUMBER, 
	fone VARCHAR2(9),
	CONSTRAINT fone_pk PRIMARY KEY (cpf, fone),
	CONSTRAINT fone_fk FOREIGN KEY (cpf) REFERENCES empregado (cpf)
);
CREATE TABLE graduado (
	cpf NUMBER,
	CONSTRAINT graduado_pk PRIMARY KEY (cpf),
	CONSTRAINT graduado_empregado_fk FOREIGN KEY (CPF) REFERENCES empregado (cpf)
);
CREATE TABLE tecnico (
	cpf NUMBER,
	ultima_serie NUMBER NOT NULL,
	CONSTRAINT tecnico_pk PRIMARY KEY (cpf),
	CONSTRAINT tecnico_empregado_fk FOREIGN KEY (CPF) REFERENCES empregado (cpf)
);
CREATE TABLE grau(
	codigo NUMBER,
	tipo VARCHAR2(30) NOT NULL,
	CONSTRAINT codigo_grau_pk PRIMARY KEY (codigo)
);
CREATE TABLE ies (
	codigo NUMBER,
	nome VARCHAR2(30) NOT NULL,
	sigla VARCHAR2(5) NOT NULL,
	CONSTRAINT ies_pk PRIMARY KEY (codigo)
);
CREATE TABLE titulacao_empregado (
	cpf NUMBER, 
	codigo_grau NUMBER NOT NULL,
	data_titulacao DATE NOT NULL,
	codigo_ies NUMBER NOT NULL,
	CONSTRAINT titulacao_pk PRIMARY KEY (cpf, data_titulacao),
	CONSTRAINT titulacao_empregado_fk FOREIGN KEY (cpf) REFERENCES graduado (cpf),
	CONSTRAINT titulacao_grau_fk FOREIGN KEY (codigo_grau) REFERENCES grau (codigo),
	CONSTRAINT titulacao_ies_fk FOREIGN KEY (codigo_ies) REFERENCES ies (codigo)
);
CREATE TABLE projeto (
	codigo NUMBER,
	descricao VARCHAR2(30) NOT NULL,
	valor DECIMAL(8,2) NOT NULL,
	CONSTRAINT codigo_projeto_pk PRIMARY KEY (codigo)
);

CREATE TABLE atividade (
	codigo NUMBER,
	descricao VARCHAR2(30) NOT NULL,
	CONSTRAINT codigo_atividade_pk PRIMARY KEY (codigo)
);
CREATE TABLE participa (
	codigo_projeto NUMBER,
	codigo_atividade NUMBER,
	cpf NUMBER,
	CONSTRAINT participa_pk PRIMARY KEY (codigo_projeto,codigo_atividade,cpf),
	CONSTRAINT participa_codigo_projeto_fk FOREIGN KEY (codigo_projeto) REFERENCES projeto (codigo),
	CONSTRAINT participa_codigo_atividade_fk FOREIGN KEY (codigo_atividade) REFERENCES atividade (codigo),
	CONSTRAINT participa_CPF_fk FOREIGN KEY (cpf) REFERENCES Empregado (cpf)
);
CREATE TABLE departamento (
	cpf_chefe NUMBER UNIQUE NOT NULL, 
	codigo NUMBER,
	descricao VARCHAR2(30) NOT NULL,
	CONSTRAINT departamento_pk PRIMARY KEY (codigo),
	CONSTRAINT departamento_fk FOREIGN KEY (cpf_chefe) REFERENCES empregado (cpf)
);
CREATE TABLE gratificacao (
	codigo NUMBER,
	descricao VARCHAR2(30) NOT NULL,
	CONSTRAINT codigo_gratificacao_pk PRIMARY KEY (codigo)
);
CREATE TABLE trabalha (
	cpf NUMBER, 
	codigo_depto NUMBER NOT NULL,
	data_trabalha DATE NOT NULL,
	codigo_gratif NUMBER,
	CONSTRAINT trabalha_pk PRIMARY KEY (cpf, codigo_depto,data_trabalha),
	CONSTRAINT trabalha_empregado_fk FOREIGN KEY (CPF) REFERENCES Empregado (CPF),
	CONSTRAINT trabalha_departamento_fk FOREIGN KEY (codigo_depto) REFERENCES departamento (codigo),
	CONSTRAINT trabalha_gratificacao_fk FOREIGN KEY (codigo_gratif) REFERENCES gratificacao (codigo)
);