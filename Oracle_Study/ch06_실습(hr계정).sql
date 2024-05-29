-- PL/SQL

--SQL : DCL, DDL, DML, TCL 4������ �з�
--DML : SELECT, INSERT, UPDATE, DROR, MERGE ��ɾ� �н�
--SELECT : ���̺��� �����͸� ��ȸ�ϴ� ��ɾ�
/*
SELECT �÷���, �÷���,......FROM ���̺��;
*/

--SQL ��ɾ�� ��ҹ��� ���� ����.
SELECT * FROM employees;  -- ' * '�� ���̺��� ��� �÷� ��(���̸�)�� �ǹ��Ѵ�.

--��Ű�� : ���̺�� ���� �����ͺ��̽� ��ü���� ������ ������ ��� �����ϴ� �ǹ�.
SELECT * FROM HR.employees;  --���ӻ��°� HR�� �Ǿ� ������, ��Ű�� �̸��� ���� ����.

-- ������̺��� �����ȣ, �̸�, ���ڿ���, �Ի���, �޿��� ��ȸ�϶�.
SELECT employee_id, first_name || last_name, email, hire_date, salary FROM employees; 

-- SELECT * FROM employees; �߰��� ����� �ٸ� �ܾ �����Ŷ�� *�� ���߿� �������� �ϴ� �־����
-- SELECT  FROM employees; �ڵ带 ������ �ۼ����� 
-- SELECT ���ϴ� ���̺� FROM employees; �߰��� �ۼ��Ѵ�.

-- ���̺��� �÷��� �����Ͽ� ���콺�� �巡�� �ϴ� ���
--SELECT employee_id, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, SALARY from employees;
-- FIRST_NAME�� Last_NAME �÷��� �ϳ��� �����ϱ�. ||
--�����ͺ��̽������� ���ڿ��� ���� ����ǥ�� ����Ѵ�. "�� ���� �ʴ´�. 
SELECT employee_id, FIRST_NAME ||' '|| LAST_NAME, EMAIL, HIRE_DATE, SALARY from employees;

-- �÷� ��Ī ���. AS    1) �÷��� AS ��Ī
SELECT employee_id, FIRST_NAME ||' '|| LAST_NAME AS NAME, EMAIL, HIRE_DATE, SALARY from employees;

-- �÷� ��Ī ���. AS ����   2) �÷���  ��Ī
SELECT employee_id E_ID, FIRST_NAME ||' '|| LAST_NAME AS NAME, EMAIL EM, HIRE_DATE HD, SALARY SAL from employees;

--�μ����̺��� �μ����� ��ȸ�϶�.
SELECT department_name FROM departments;

--�μ����̺��� �μ��ڵ�, �μ����� ��ȸ�϶�.
SELECT department_id, department_name FROM departments;

--�����ּ�
/*
������ �ּ�
*/

--�ѱ� �̸����� ��Ī ����� �����ϴ�.
SELECT employee_id �����ȣ, manager_id �����ھ��̵� FROM employees;

--��Ī�� ������� ����� ��쿡�� "" ū����ǥ���
SELECT employee_id "��� ��ȣ", manager_id "������ ���̵�" FROM employees;

-- �׷��� �ѱ��� ����ϰ� �Ǹ� �ܵ����� ���� ������ �ٸ� �Ͱ� �Բ� ����Ҷ� ������ �ǹǷ� �ѱ� ��Ī�� ������� ����.


--<24.04.02> ����
-- ���������� ���� �ο��۾��� ����Ǿ��� ��� sqldb�������� ����
-- �н��� ������ �غ��۾�
--1)~6) ���� ���������� ����� ����� �����Ѵ�.

--1)
CREATE TABLE userTBL -- ȸ�� ���̺�
( userID  	CHAR(8) NOT NULL PRIMARY KEY, -- ����� ���̵�(PK)
  userName  	NVARCHAR2(10) NOT NULL, -- �̸�
  birthYear 	NUMBER(4) NOT NULL,  -- ����⵵
  addr	  	NCHAR(2) NOT NULL, -- ����(���,����,�泲 ������ 2���ڸ��Է�)
  mobile1	CHAR(3), -- �޴����� ����(010, 011, 016, 017, 018, 019 ��)
  mobile2	CHAR(8), -- �޴����� ������ ��ȭ��ȣ(����������)
  height    	NUMBER(3),  -- Ű
  mDate    	DATE  -- ȸ�� ������
);

--2)
CREATE TABLE buyTBL -- ȸ�� ���� ���̺�
(  idNum 	NUMBER(8) NOT NULL PRIMARY KEY, -- ����(PK)
   userID  	CHAR(8) NOT NULL, -- ���̵�(FK)
   prodName 	NCHAR(6) NOT NULL, --  ��ǰ��
   groupName 	NCHAR(4)  , -- �з�
   price     	NUMBER(8)  NOT NULL, -- �ܰ�
   amount    	NUMBER(3)  NOT NULL, -- ����
   FOREIGN KEY (userID) REFERENCES userTBL(userID)
);
--3)
INSERT INTO userTBL VALUES('LSG', '�̽±�', 1987, '����', '011', '11111111', 182, '2008-8-8');
INSERT INTO userTBL VALUES('KBS', '�����', 1979, '�泲', '011', '22222222', 173, '2012-4-4');
INSERT INTO userTBL VALUES('KKH', '���ȣ', 1971, '����', '019', '33333333', 177, '2007-7-7');
INSERT INTO userTBL VALUES('JYP', '������', 1950, '���', '011', '44444444', 166, '2009-4-4');
INSERT INTO userTBL VALUES('SSK', '���ð�', 1979, '����', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO userTBL VALUES('LJB', '�����', 1963, '����', '016', '66666666', 182, '2009-9-9');
INSERT INTO userTBL VALUES('YJS', '������', 1969, '�泲', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO userTBL VALUES('EJW', '������', 1972, '���', '011', '88888888', 174, '2014-3-3');
INSERT INTO userTBL VALUES('JKW', '������', 1965, '���', '018', '99999999', 172, '2010-10-10');
INSERT INTO userTBL VALUES('BBK', '�ٺ�Ŵ', 1973, '����', '010', '00000000', 176, '2013-5-5');

--4)
CREATE SEQUENCE idSEQ; -- ������ȣ �Է��� ���ؼ� ������ ����

--5)
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '�ȭ', NULL   , 30,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '��Ʈ��', '����', 1000, 1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'JYP', '�����', '����', 200,  1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�����', '����', 200,  5);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', 'û����', '�Ƿ�', 50,   3);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�޸�', '����', 80,  10);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'SSK', 'å'    , '����', 15,   5);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', 'å'    , '����', 15,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', 'û����', '�Ƿ�', 50,   1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�ȭ', NULL   , 30,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', 'å'    , '����', 15,   1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '�ȭ', NULL   , 30,   2);

--6)
COMMIT;


-- SELECT�� : ���̺� ����Ǿ� �ִ� ������ Ȯ��(��ȸ��ɾ�)
SELECT * FROM usertbl; -- 10��
SELECT * FROM buytbl; --12��

--P.194
--Ư���� ������ �����͸� ��ȸ.(SELECT ~ FROM ~ WHERE)
/*
����)
SELECT �÷���1, �÷���2, FROM ���̺�� WHERE ���ǽ�;
*/

-- ����) �̸��� ���ȣ�� �����͸� ��ȸ�϶�.
SELECT * FROM usertbl WHERE USERNAME = '���ȣ';
SELECT * FROM usertbl WHERE USERNAME = '������';

--����) ��������� 1970�� �̻� ����ϰ�, Ű�� 182CM�̻��� �����͸� ��ȸ�϶�  -- ������ AND���� OR���� �ľ��ؾ� �Ѵ�. 
SELECT * FROM usertbl WHERE birthyear >= 1970 AND height >= 182;

--����) ��������� 1970�� �̻� ����� �ϰų�, Ű�� 182CM�̻��� �����͸� ��ȸ�϶�
SELECT * FROM usertbl WHERE birthyear >= 1970 OR height >= 182;

--����) Ű�� 180�̻��̸鼭 183������ �����͸� ��ȸ�϶�.
SELECT * FROM usertbl WHERE height >= 180 AND height <= 183;
-- ���� ������ ����.
SELECT * FROM usertbl WHERE height BETWEEN 180 AND 183;

--����)�ּҰ� �泲�̰ų� ���� �Ǵ� ��� �����͸� ��ȸ�϶�
SELECT * FROM usertbl WHERE addr = '�泲' OR addr = '����' OR addr = '���';
-- ���� ������ ����.
SELECT * FROM usertbl WHERE addr IN ('�泲', '����', '���');

--���� ������ �÷��� ��� ��Ģ������ �����ϴ�.
SELECT * FROM buytbl;
--����)�ֹ��ݾ��� ����Ͻÿ�.   -- *�� ��� �÷����� ���Ѵ�. �ٵ� ���忡�� �����Ҷ� *���� ������ ��������. ��� �ʿ��ϸ� �׳� �÷��� ��ü ��������.
-- �μ��� ���� �̸���, PRICE * AMOUNT(������ ��) AS TOT_PRICE(���Ѱ��� ���� �̸��� TOT~�� �Ѵ�) 
SELECT idnum, USERID, PRODNAME, GROUPNAME, PRICE * AMOUNT AS TOT_PRICE FROM buytbl;
--���� 1.1%�λ�
SELECT idnum, USERID, PRODNAME, GROUPNAME, PRICE * 1.1 FROM buytbl;

-- LIKE ���� ��Ī
--����) �̸� �� ���� "��" �� �� �����͸� ��ȸ�϶�.
--���ϵ� ī�� ���� % : ���̰� 0�� �̻�(���ڼ��� 0�� �̻�)�� ���ڿ�. // '��'�̶�� �ϳ��� ���ڰ� �־ ��µȴ�.
SELECT * FROM usertbl WHERE username LIKE '��%';

--����)��ü �̸��� 3���� �̸鼭, �������� ������ �����͸� ��ȸ�϶�.
-- ���ϵ� ī�幮�� _(�����) : ���̰� 1���� �ǹ�/ ����ڰ� �͵� �������. ��, �Ѱ��� ���ڸ� �;� �Ѵ�.
SELECT * FROM usertbl WHERE username LIKE '_����';
--SELECT * FROM usertbl WHERE userid LIKE '_B_'; //������ ���������� ���Ŀ�
/*LIKE ���� ���漳���� ��. 
 1) ���ڿ��� ������ �˻����ش�.
 2) LIKE�� ������ ������ ���ϵ�ī�幮�ڷ� �ؼ����� �ʰ� �Ϲݱ��� 1���� �ǹ̷� �ؼ��ȴ�.(�����߻� ����)
*/

--------------------------------------------------------------
--���� ����Ŭ https://thebook.io/006696/0063/�� ���� ���

--����) ������̺��� �޿��� 5000�� �Ѵ� �����ȣ�� ������� ��ȸ�϶�.
   SELECT  employee_id, emp_name
   FROM  employees
   WHERE   salary > 5000;

-- order by :�������� ����/�Ʒ� ��µǴ� ȭ�鿡�� ���ĵ� ���̰�, ���� ���̺��� ���ĵ� ���� �ƴϴ�.
-- �̰� ���� �ϴܿ� �ۼ��ؾ� �Ѵ�.
    SELECT  employee_id, emp_name
    FROM  employees
    WHERE  salary > 5000
    ORDER  BY employee_id;  --ORDER BY employee_id asc
-- �������� desc
    SELECT  employee_id, emp_name
    FROM  employees
    WHERE  salary > 5000
    ORDER  BY employee_id desc;  
    
-- ����)�޿��� 5000 �̻��̰� job_id�� ��IT_PROG���� ����� ��ȸ�Ѵٸ�, AND �����ڿ� job_id�� �˻��ϴ� ����
-- ��ɾ�� ��ҹ��� �������� ������, ������ ���� ��ҹ��ڸ� �����Ѵ�.
    SELECT  employee_id, emp_name
    FROM  employees
    WHERE  salary >= 5000 AND  job_id = 'IT_PROG'
    ORDER  BY employee_id;
    
-- �����ʹ� ��ҹ��ڸ� �����Ѵ�. 'IT_PROG' -> 'it_prog'
-- ��ҹ��ڴ� ���ж����� ����� ����. 
    SELECT  employee_id, emp_name
    FROM  employees
    WHERE  salary >= 5000 AND  job_id = 'it_prog'
    ORDER  BY employee_id;    
    
--����� �߰��ǽ�
-- ����)usertbl���̺��� ��������� ������������ �����Ͻÿ�.
SELECT * FROM usertbl ORDER BY birthyear ASC;  

-- ����)usertbl���̺��� Ű�� ��������, �̸��� ������������ �����Ͻÿ�.
-- ������ ������ �󿡼��� 2�� ������ �����ϴ�.
SELECT * FROM usertbl ORDER BY height DESC, username ASC;  

-- ����) USERTBL���� �ּҸ� ������������ �����Ͻÿ�.
SELECT * FROM usertbl ORDER BY ADDR ASC;  -- �ٸ� �����Ϳ� ����
SELECT ADDR FROM usertbl ORDER BY ADDR ASC;  -- ADDR �� 1����

-- DISTINCT : �ߺ��� �����͸� 1���� ����� �������� �����ϴ� ���
SELECT DISTINCT ADDR FROM USERTBL ORDER BY ADDR ASC;
-- DISTINCT�� �ǹ� ���� ��� : �Ʒ� �ڵ忡�� USERNAME�� ADDR�� ���ÿ� �����ϴ� �����Ͱ� ����. 
SELECT DISTINCT USERNAME, ADDR FROM USERTBL ORDER BY ADDR ASC; -- �ߺ��� ��� �ٳ��´�.
--���ÿ� �����Ǵ� ������ ����� DISTINCTȿ���� ���´�.

--------------------------------------------------------------------
-- ���� : 2�� �����ͺ��̽��� �����ϴ� ��ü ���캸��
/*
1. ������ ���̽���ü�� ����
2. ���̺�
*/
/*
���̺� ����
���̺��� CREATE ������ ������ �� �ִµ�, �⺻ ������ ������ ����.

    CREATE TABLE [��Ű��.]���̺��(
        �÷�1 �÷�1_������Ÿ�� [NULL, NOT NULL],
        �÷�2 �÷�2_������Ÿ�� [NULL, NOT NULL],
    ...
    )[TABLESPACE ���̺����̽���];
*/
-- CREATE TABLE ��Ű����.���̺��
-- ��Ű�� �� : ���������� �����, ������ ���°� ������ ��쿣 ����
 /*
    CREATE TABLE employees (
          EMPLOYEE_ID NUMBER(6,0) NOT NULL,
          EMP_NAME VARCHAR2(80) NOT NULL,
          ...
          SALARY NUMBER(8,2) ,
          HIRE_DATE DATE NOT NULL,
          ...
          ... );
  */
CREATE TABLE ex2_1 (
    column1 char(10),
    column2 varchar2(10),
    column3 nvarchar2(10),
    column4 number
);

-- ������ ����
-- INSERT INTO EX2_1(COLUMN1, COLUMN2) VALUES(��1, ��2);
INSERT INTO EX2_1(COLUMN1, COLUMN2) VALUES('abc', 'abc');

--LENGTH(COLUMN1):�÷��� ������ ����
--�÷��� ������������ ũ�⸦ Ȯ��. CHAR(10)�� VARCHAR2(10)�� ������
--char: ���̰� ������ ������, 2000byte, ��)�ֹι�ȣ 14�ڸ�
--varchar2 : ���̰� �������� ������, 4000byte, ��) ���̵� 8��~ 15��
SELECT COLUMN1, LENGTH(COLUMN1), COLUMN2, LENGTH(COLUMN2) FROM EX2_1; 




-----------------------------------24.04.03(��)-----------------------------------
CREATE TABLE ex2_2(
    COLUMN1 VARCHAR2(3), --3BYTE
    COLUMN2 VARCHAR2(3 BYTE),
    COLUMN3 VARCHAR2(3CHAR) -- ���� 3��(ũ��� ������� �����̵� �ѱ��̵� 3���ڰ� ���ڴ�.)
); -- ����� �Ⱥ��̸� ���ΰ�ħ(*���ΰ�ħ�� ����� ���� ũ�α׷��̶�� �Ѵ�)


--����Ŭ �����ͺ��̽� �ý���
/*
    ������, �ƶ��Ƽ���, Ư������ : 1BYTE ����.
    �ѱ� : 3BYTE. ����Ŭ ��ġȯ�漳���� ���� ������̴�. 2BYTE�� ���� �ִ�.
*/

--�Լ� : LENGTHB() : �Ű������� �����Ǵ� �������� ����Ʈ ������ Ȯ��(B�� BYTE�� B)/ BYTE���ϴ� �Լ�
SELECT LENGTHB('A'), LENGTHB(1), LENGTHB('*'), LENGTHB('��') FROM DUAL;
SELECT LENGTHB('�����') FROM DUAL; --9BYTE

--������ ���� / ���� ���ڿ� �����ʹ� ��ҹ��� ����. 'ABC', 'abc' ���ڿ� �����ͷ� �νĵȴ�.
--INSERT INTO ���̺�� (��1, ��2, ��3 ...) VALUES (��, ��, ��...);
INSERT INTO ex2_2(COLUMN1, COLUMN2, COLUMN3) VALUES ('abc', 'abc', 'abc');

--������ ��ȸ
SELECT COLUMN1, LENGTHB(COLUMN1), COLUMN2, LENGTHB(COLUMN2), COLUMN3, LENGTHB(COLUMN3) FROM ex2_2;

--�ѱ۵����� �Է½õ� ����?
--��Ű��:�׷�ȭ ���Ѽ� ����
--ORA-12899: value too large for column "SQLDB"."EX2_2"."COLUMN1" (actual: 9, maximum: 3)
INSERT INTO ex2_2(COLUMN1, COLUMN2, COLUMN3)VALUES ('ȫ�浿', 'ȫ�浿', 'ȫ�浿');

--COLUMN3 �÷��� CARCHAR2(3CHAR)�̹Ƿ�, �ѱ� 3�� ���� ������ ���� ����.
INSERT INTO ex2_2(COLUMN3) VALUES('ȫ�浿'); --CHAR�� ����ߴ� : CHAR Ÿ�Կ��� �˸°� �����Ͽ���.

--������ ��ȸ
SELECT COLUMN1, LENGTHB(COLUMN1), COLUMN2, LENGTHB(COLUMN2), COLUMN3, LENGTHB(COLUMN3) FROM ex2_2;

-- ���� ������ Ÿ��: NUMBER[(P,[S])]
--��� ���������� NUMBER ������ Ÿ������ ��ȯ�Ǿ� ����.
CREATE TABLE EX2_3(
    COL_INT INTEGER,
    COL_DEC DECIMAL,
    COL_NUM NUMBER
);

--user_tab_cols �ý��� �� : ���̺��� �÷� ������ Ȯ���ϴ� �뵵
    SELECT column_id, column_name, data_type, data_length
    FROM user_tab_cols
    WHERE table_name = 'EX2_3'  -- �� �ڸ��� ���̺� ���� �����ϸ� �÷������� ��µȴ�.
    ORDER BY column_id;           --���̺���� �����ͷ� ���(''�ȿ� ���°��� �����ͷ� ���Ǵ°Ŵ�)�� ���� �빮�ڷ� �Է� 

--��¥�� ������ Ÿ�� : DATE - �ʴ��� ���� ����, TIMESTAMP - �и���������� ���� ����.
CREATE TABLE EX2_5(
    COL_DATE DATE,
    COL_TIMESTAMP TIMESTAMP   -- �ڲ� �� �������ڸ� ���� ',' ���µ�, ���� �߻��Ѵ�. ����
 );

-- ��¥ �Լ� : SYSDATE, SYSTIMESTAMP
--������ ���� 
INSERT INTO EX2_5(COL_DATE, COL_TIMESTAMP) VALUES(SYSDATE, SYSTIMESTAMP);
--SYSDATE : �ý��� ���� ���� �ð�(�ʱ���)

--������ ��ȸ. ��µǴ� ��¥ ���� ���� : ���� > ȯ�漳�� > ������ ���̽�> NLS
SELECT * FROM EX2_5;

--�ó�����
/*
 ���̺�� : USERINFO
  �÷��� : �̸�(U_NAME) VARCHAR2(50),�ּ�(U_ADDR) VARCHAR2(100), ����ó(U_TEL)VARCHAR2(20), 
          ����(U_AGE)NUMBER, �����(U_REG) DATE
*/
CREATE TABLE USERINFO(
    U_NAME VARCHAR2(50),
    U_ADDR VARCHAR2(100),
    U_TEL VARCHAR2(20),
    U_AGE NUMBER,
    U_REG DATE
);

INSERT INTO USERINFO(U_NAME, U_ADDR, U_TEL, U_AGE, U_REG) --�̰� �Ҷ� ���� ����â���� ���ϴ°� �� ��� ������� ����
    VALUES ('������ǻ���п�', '����Ư���� �����', '02-000-0000', 10, SYSDATE);

SELECT * FROM USERINFO;

--LOB ������ Ÿ�� : ��뷮 �����͸� ���� �� �� ����ϴ� ������ Ÿ��
/*
 - ������������:CLOB, NCLOB / 4000BYTE���� ū ���ڿ� ������ ����
 - �׷���, �̹���, ������ ���� ������ : BLOB
 - BFILE�� ���� ���� ������ �ƴ� �����ͺ��̽� �ܺο� �ִ� ���Ͽ� ���� ��������(�ش� ������ ����Ű�� ������)�� �����ϸ�, 
   ���� ������ ������ ���� ���� �б⸸ �����ϴ�.
*/

CREATE TABLE SAMPLE_1(
    COL1  VARCHAR2(50),
    COL2  CLOB
);

INSERT INTO SAMPLE_1(COL1, COL2) VALUES('���޷�', '�ۿ�Ȱ�� ��������, �ѹݵ��� ���� ����');
INSERT INTO SAMPLE_1(COL1, COL2) VALUES('������', '��Ǫ�������� �Ĺ��� ��ö�� ��� ���� �ǿ�� ������ �� ����');
INSERT INTO SAMPLE_1(COL1, COL2) VALUES('����ȭ', '�ֶ��� �Ĺ� ��ȯ�ڹ��� ����ȭ���� ���ػ���Ǯ');

--������ ��ȸ
SELECT * FROM SAMPLE_1;

--���� : ORDER BY COL1
SELECT * FROM SAMPLE_1 ORDER BY COL1 ASC;

--���� : ORDER BY COL2 / 
--��� : �����߻�/ COL2 �÷��� CLOB ������ Ÿ���̹Ƿ� ���ı���� �����ȵ�./DISTINCT(�ߺ��� ���� ���)�� �����ȵ�. 
--������ ���� ���� �ǹ̾��ٰ� �Ǵ�
SELECT * FROM SAMPLE_1 ORDER BY COL2 ASC; 

/*
--NULL
  :NULL�� ������ �������� �ǹ��ϸ� ���̺��� ������ �� �÷� �Ӽ��� ����Ѵ�. 
   ����Ʈ ���� NULL�̹Ƿ� ������ �������� ������ �ش� �÷��� NULL�� ����ϰ� �ȴ�.
*/
-- NULL ��� : �÷��� �����͸� �Է��ص� �ǰ�, ���ص� �ȴٴ� �ǹ�. (EX)�ڵ��� ���� ���� ��
-- NOT NULL ��� : �÷��� �����͸� �ݵ�� �Է��ؾ� �Ѵٴ� �ǹ�. (EX)���̵�, ��й�ȣ ��
CREATE TABLE SAMPLE_2(
 COL1 NUMBER, --COL1 NUMBER NULL �� ������. > NULL ���
 COL2 VARCHAR2(50) NOT NULL --NULL ����� > ���� �ݵ�� �Է��ؾ��t.
);
--NULL�� ���� �÷��� �Է��� ���� ������ �Ⱦ��� �ǳ� �پ �ȴ�.
--INSERT INTO SAMPLE_2(COL1) VALUES(1);�� (COL1)���� ���� �߻��Ѵ�. NOT NULL�� ���� �÷��̹Ƿ�.
--����:cannot insert NULL into ("SQLDB"."SAMPLE_2"."COL2")
INSERT INTO SAMPLE_2(COL2) VALUES(1);
INSERT INTO SAMPLE_2(COL1) VALUES(2);

INSERT INTO SAMPLE_2(COL1,COL2) VALUES(2, '�׽�Ʈ2');

--������ ��ȸ
SELECT * FROM SAMPLE_2;

--���� :  DBMS ������ ���� NULLó���� ���ݾ� �ٸ� �� �־�, �ǹ����� ������ ���̽� ���� NULL ������ Ȯ��

/**************************************��������******************************************/
/*�� NOT NULL
    �÷��� ������Ÿ�� NOT NULL
    ���� NULL���� �����ߵ���, �÷��� ������ �� NOT NULL ���������� ����ϸ� �ش� �÷����� '�ݵ�� �����͸� �Է�'�ؾ� �Ѵ�. 
    �� �ݵ�� ���� ��� �־�� �ϴ� �÷����� NOT NULL ���������� ����� ����Ѵ�. 
*/
CREATE TABLE EX2_6(
    COL_NULL        VARCHAR2(10),
    COL_NOT_NULL    VARCHAR2(10) NOT NULL --����Ŭ ������ �ڵ����� SYS_C007042 �������� ��ü�̸� NOT NULL�� ����.
);

--������ ����
--INSERT INTO SAMPLE_2(COL1,COL2) VALUES(2, '�׽�Ʈ2'); 
--���� ��ó�� �ۼ��ϴµ� �Ʒ�ó�� �÷����� ������ ��� ��� �ķ��� ���� �Է��Ѵٴ� �ǹ�.
INSERT INTO EX2_6 VALUES('AA','');  -- ���� : ����Ŭ������ ''(����)�� NULL�� �ǹ̷� ��� �ȴ�. --�̰� MY SQL���� ����
INSERT INTO EX2_6 VALUES('AA',NULL); -- ���� : ���� ���� �ǹ�  / -- ANSI-SQLǥ�� ���� //  < ������ �̷��� �ۼ��ض�
--���� : ORA-01400: cannot insert NULL into ("SQLDB"."EX2_6"."COL_NOT_NULL")

--�Ʒ� 2�ڵ�� ������ �����̴�.
INSERT INTO EX2_6 VALUES('AA','BB');
INSERT INTO EX2_6(COL_NULL,COL_NOT_NULL) VALUES('AA','BB');

--user_constraints �ý��� �� : ���̺��� �������� ������ Ȯ���ϴ� �뵵.
    SELECT constraint_name, constraint_type, table_name, search_condition
    FROM user_constraints
    WHERE table_name = 'EX2_6';
    
    
/*
�� UNIQUE
UNIQUE ���������� �� �״�� �ش� �÷��� ���� ���� �����ؾ� �Ѵٴ� �ǹ̴�. �� �ߺ� ���� ������� �ʴ´�.

    �÷��� ������Ÿ�� UNIQUE
    Ȥ��
    CONSTRAINTS �������Ǹ� UNIQUE(�÷���, ...)
 Ư¡ ) ���̺� UNIQUE�������� ������ ���� ����
*/
    
CREATE TABLE SAMPLE_3(
    U_NAME      VARCHAR2(50)    NOT NULL,
    SSN         CHAR(14)    UNIQUE NOT NULL -- ����Ŭ ������ SQLDB.SYS_C007045 �������� ��ü�̸����� SSN�÷��� UNIQUE���� ���� ����
);
--������ �Է�
INSERT INTO SAMPLE_3(U_NAME, SSN) VALUES('�����', '123456-1234567');

-- ���� : ORA-00001: unique constraint (SQLDB.SYS_C007045) violated
--'123456-1234567' �ֹε�� ��ȣ�� �����Ͽ�, UNIQUE �������� �����߻�
INSERT INTO SAMPLE_3(U_NAME, SSN) VALUES('�����', '123456-1234567'); 

-- �������� ���� �� ���������� 
--1)�÷� �������� : �÷��� ���� �� �� ���  
--2)���̺� �������� : ���̺��� �÷��� ��� �����ϰ� �� �� ������ �κп� ����.

--�÷� ������ UNIQUE���������� ����. EX2_7���̺��� UNIQUE���� ���� 3���� ����Ǿ���. 
CREATE TABLE EX2_7(
    COL_UNOQUE_NULL     VARCHAR2(10)    UNIQUE, -- NULL��� / ����Ŭ ������ UNIQUE �������� �̸��� �ڵ�����
                                                -- �÷� ���� ���� : ','(������) ������ ���������� �����Ѵ�
    COL_UNOQUE_NNULL    VARCHAR2(10)    UNIQUE NOT NULL, --���� �����ؾ��Ѵ� + �ݵ�� �����͸� �Է��ؾ� �Ѵ�.
    COL_UNOQUE          VARCHAR2(10),
    CONSTRAINT UNIQUE_NM1 UNIQUE(COL_UNOQUE) ); --CONSTRAINT ���������̸� UNIQUE(�÷���)
                                                 -- �÷��� UNIQUE ���������� �ɰڴ�.
                                                -- ���̺� ���� ���� / ���忡 ���� �̰� ���� ����ҰŴ�.
                                                -- ������ �ڵ�� ���������� �������� �����Ѵ�. 

--���⼳�� : �������� ��ɾ ����ϸ�, �������� ��ü�̸��� ����Ŭ ������ �ڵ����� �������ش�.
-- �������ǰ�ü �̸��� �������� �����ϰ� �ʹٸ�, ������ ������ ���� �Ѵ�.
--��) CONSTRAINT UNIQUE_NM1 UNIQUE

--������ �Է�
INSERT INTO EX2_7 VALUES('AA', 'AA', 'AA'); -- ù��° ����

INSERT INTO EX2_7 VALUES('AA', 'AA', 'AA'); -- �ι�° ���� �� ����
--ù��° ���� UNIQUE���� �ɷ�����. �ߺ����Է� �Ұ�. ���Ͽ� ù°������ ������ ���� �� �ڴ� �غ� �ʿ䵵 �����Ƿ� ������� �ʰ� �����
--ORA-00001: unique constraint (SQLDB.SYS_C007047) violated

INSERT INTO EX2_7 VALUES('', 'BB', 'BB'); --����° ����
-- INSERT INTO EX2_7 VALUES(NULL, 'BB', 'BB'); �ǹ̰� ����. 

SELECT * FROM EX2_7;

INSERT INTO EX2_7 VALUES('', 'CC', 'CC'); --�׹�° ����
--NULL�� �ߺ� �˻翡 �ش� �ǳ�?
--����° ���࿡�� NULL�� �����ص�, NULL�� �� ����� �����ϴ�. NULL�� �ߺ���󿡼� ���� �ȴ�.
--�ٸ� �����ͺ��̽����� NULL�� �� 1���� ����ϴ� ��쵵 �ִ�.(��: MS-SQL �����ͺ��̽�)

SELECT * FROM EX2_7;

INSERT INTO EX2_7 VALUES('', 'CC', 'CC'); --�ټ���° ����
--ORA-00001: unique constraint (SQLDB.SYS_C007048) violated
--�ι�° ������ CC�ߺ��� �Է� �Ұ��� ���� ���� �߻�

COMMIT;    --- �Ϸ� �۾� �Ϸ��ϸ� COMMIT�ݵ�� �Ұ�, ���ϸ� ������ �� ���ư���.

-----------------------------------24.04.04(��)-----------------------------------

-- ���̺��÷��� 2�� �̻� ��� UNIQUE�������� �����ϱ�. (�����÷��� ������� UNIQUE�������� ����)
--���̺� �������� ������ ����ؾ� �����÷� UNIQUE���������� ���� �� �� �ִ�.

-- �����÷� ������ UNIQUE ���������� ���� ��, �� ���̺� UNIQUE���������� 2�� ����
-- ��1) �߸� �����ϰ� ���� ��
CREATE TABLE SAMPLE_4(
    COL1    NUMBER UNIQUE,
    COL2    VARCHAR2(10) UNIQUE,
    COL3    VARCHAR2(10),
    COL4    VARCHAR2(10)
);
    
-- ��2) �ùٸ��� �����ϰ� ���� �� : ���̺� ���� �������� ����ؾ� �Ѵ�.
CREATE TABLE SAMPLE_5(
    COL1    NUMBER,
    COL2    VARCHAR2(10),
    COL3    VARCHAR2(10),
    COL4    VARCHAR2(10), 
    UNIQUE(COL1, COL2) -- �÷� 2���� ��� UNIQUE�������� 1�� �������.
);

--������ ����
INSERT INTO SAMPLE_5(COL1, COL2)VALUES(1, 'A'); -- ù��° ����
INSERT INTO SAMPLE_5(COL1, COL2)VALUES(1, 'B'); -- �ι�° ����

SELECT*FROM SAMPLE_5;

INSERT INTO SAMPLE_5(COL1, COL2)VALUES(1, 'A'); -- ����° ����
-- ORA-00001: unique constraint (SQLDB.SYS_C007055) violated


/*
�� �⺻Ű
�⺻ŰPrimary key��� �ϰ� ���� �״�� ��Primary key����� �Ѵ�. 
���� ���̺� Ű�� �����ߴٶ�� �� ��, �̴� �⺻Ű�� �ǹ��Ѵ�. 
Ư¡) �⺻Ű�� UNIQUE�� NOT NULL �Ӽ��� ���ÿ� ���� ������������, ���̺� �� 1���� �⺻Ű�� ������ �� �ִ�.�ڡڡڡڡ�

�����÷��� �⺻Ű�� �����ϸ� ����Ű - �÷����� ����
�����÷��� �⺻Ű�� �����ϸ� ����Ű - ���̺� ���� ����


    �÷��� ������Ÿ�� PRIMARY KEY
    Ȥ��
    CONSTRAINTS �������Ǹ� PRIMARY KEY(�÷���, ...)
*/
CREATE TABLE EX2_8(
    COL1    VARCHAR(10)     PRIMARY KEY, -- UNIQUE�� NOT NULL�� Ư¡��� ������ �ִ�.
    COL2    VARCHAR(10)
    -- �����÷��� �⺻Ű ���� : ����Ű
);
--�����ϸ� �Խ��� ���̺�, �����̺� �� ���̺��� �����ϰ� ����¡ ����� ���� ��
--PRIMARY KEY ���������� �ڵ����� ����� ����ϸ� �ȵȴ�. �������� ������ �Ѵ�.

--������ �Է�
-- ����Ŭ INSERT��
INSERT INTO EX2_8 VALUES('','AA'); --���� / MY-SQL������ �۵� �ȵ� ���� �ִ�.
--ORA-01400: cannot insert NULL into ("SQLDB"."EX2_8"."COL1")
-- ù��° �÷��� NULL�� �Է��� �� ����. ���� �־��.

-- ANSI-SQL INSERT��
INSERT INTO EX2_8 VALUES(NULL,'AA'); --���� ����/ MY-SQL���� ���������� �۵� �� ���̴�. 

INSERT INTO EX2_8 VALUES('AA','AA'); --ORA-00001: unique constraint (SQLDB.SYS_C007056) violated
-- ���ձ� ���̺� ��


--1) �ߺ� �����ϰ� ���� ��,
-- �����߻�. ��? : �⺻Ű�� ���̺�� �� 1���� ���� �����ϴ�. �Ʒ��� 2���� �����ϴ� �ǹ̹Ƿ� ���� �߻�.
CREATE TABLE SAMPLE_6(
    COL1    NUMBER PRIMARY KEY,
    COL2    VARCHAR2(10) PRIMARY KEY ,
    COL3    VARCHAR2(10),
    COL4    VARCHAR2(10)
); --ORA-02260: table can have only one primary key
    
-- ��2) �ùٸ��� �����ϰ� ���� �� : ���̺� ���� �������� ����ؾ� �Ѵ�.
--PRIMARY KEY �������� ��ü�̸��� ����Ŭ ������ �ڵ����� ���� ���ش�. 
-- �׷��� �������ǰ�ü �̸��� ���������� ����¡��� ���� �� ���� ���� �������ǰ�ü �̸��� �������� �������־�� �Ѵ�.
CREATE TABLE SAMPLE_7(
    COL1    NUMBER,
    COL2    VARCHAR2(10),
    COL3    VARCHAR2(10),
    COL4    VARCHAR2(10), 
    CONSTRAINTS PK_SAMPLE_7_COL1_COL2 PRIMARY KEY(COL1, COL2) -- �÷� 2���� ��� PRIMARY KEY�������� 1�� �������.
);
--���� ���̺� PRIMARY KEY(����Ű)�������� COL1, COL2 �÷��� ���ÿ� �����ϴ� �����ʹ� �ߺ� �� �� ����.
--�������� �÷��� �ϳ��� �⺻Ű�� ����� ��� �ִ� �÷������� 32���� �����ϴ�. (SAMPLE_7�� 2��)


/*
�� �ܷ�Ű �Ǵ� ����Ű
�ܷ�ŰForeign key�� ���̺� ���� ���� ������ ���Ἲ�� ���� ���������̴�.

    CONSTRAINT �ܷ�Ű�� FOREIGN KEY(�÷���, ...)
    REFERENCES ���� ���̺�(���� ���̺� �÷���, ...)
*/
--�μ� ���̺�
CREATE TABLE DEPT(
    D_CODE   NUMBER PRIMARY KEY,    -- �� �÷��� ���� �޴� ������ PRIMARY KEY OR UNIQUE������ �Ǿ��־�� �Ѵ�.
    D_NAME  VARCHAR2(20)    NOT NULL
);

--������̺� ����Ű�� �����Ǵ� ���̺�. 
--EMP�� �ִ� D_CODE�� DEPT�� �ִ� D_CODE �Ȱ��� �ʾƵ� �������.
--�Ϻ� ������̺� D_CODE�÷��� �μ����̺��� D_CODE�÷��� ������ Ÿ���� �����ؾ� �Ѵ�. 
CREATE TABLE EMP(
    E_ID   NUMBER PRIMARY KEY,
    E_NAME  VARCHAR2(20)    NOT NULL,
    D_CODE NUMBER REFERENCES DEPT(D_CODE)--�÷����� ���� (���⿡�� FOREIGN KEY�� �Է����� �ʴ´�.)
);

--������̺�
CREATE TABLE EMP(
    E_ID   NUMBER PRIMARY KEY,
    E_NAME  VARCHAR2(20)    NOT NULL,
    D_CODE NUMBER,
    FOREIGN KEY(D_CODE) REFERENCES DEPT(D_CODE) --���̺� ���� ����
);

--���̺� ���� ��ɾ�: ����Ű�� ������ ���̺� ������ ������ �ִ�. (�ڡڡڡڡ�)
DROP TABLE EMP;-- �����ϴ� ���̺��� ���� �����ؾ� �Ѵ�.
DROP TABLE DEPT;-- �����޴� ���̺��� ���߿� ���� �ؾ� �Ѵ�. 

--���̺� ����Ű ������ ����� ���� Ȯ���ϱ�
--���� > DATA MODELER > ������ ���� 
-- ������ ������������ �������� ��Ŭ�� ���� > �������� �� Ŭ��

--������ �Է�
-- 1) �μ����̺�
INSERT INTO DEPT VALUES(1, '�ѹ���');
INSERT INTO DEPT VALUES(2, '���ߺ�');
INSERT INTO DEPT VALUES(3, '������');
INSERT INTO DEPT VALUES(4, 'ȫ����');

SELECT * FROM DEPT;

--2) ������̺� 
INSERT INTO EMP VALUES(1001, '�����', 1);
INSERT INTO EMP VALUES(1002, '�����', 2);
INSERT INTO EMP VALUES(1003, 'Ȳ����', 3);
INSERT INTO EMP VALUES(1004, '�̰���', 4);

INSERT INTO EMP VALUES(1005, 'Ȳ��ȫ', 7);-- ����, DEPT���� 7�� �μ��� ����.
--ORA-02291: integrity constraint (SQLDB.SYS_C007064) violated - parent key not found
--������ �Ҷ��� ���������� ��� �ߴ� ���ѳ��´�. �۾��ϴµ� �Ž����ϱ�

/* <����Ű �������>
�ܷ�Ű�� ���� ��������� ������ ����.
1)�ݵ�� �����ϴ� ���̺��� ���� �����Ǿ�� �ϸ�, 
2)����Ű�� ���� ���̺��� �⺻Ű�� ������� �־�� �Ѵ�.
3)�ܷ�Ű�� ����� �� �ִ� �÷� ������ �ִ� 32����.
4)���� �÷��� �ܷ�Ű�� �������, �����ϴ� �÷��� �ܷ�Ű �÷��� ������ ������ ���ƾ� �Ѵ�.
*/
/* <���忡���� �ܷ�Ű ���� ����>
�ý��� ���� ���忡���� ���� ��â�⿡�� �ܷ�Ű�� �������� �ʴ´�. 
���� �߿��� ���÷� �����͸� �Է��ϰ� �����ϴ� ��찡 ����ѵ�, �ܷ�Ű�� �����ϸ� ���� ��� ������ ���� ����̴�. 
�׷��� ���� �� �׽�Ʈ �Ⱓ�� ���� ��� ���� �ý����� ����ȭ�� ���� �ܷ�Ű�� ������ ���� ����.
*/

/*
�� CHECK
���������� �˾ƺ� ������������ CHECK�� �ִ�. 
�÷��� �ԷµǴ� �����͸� üũ�� Ư�� ���ǿ� �´� �����͸� �Է� �ް� �׷��� ������ ������ ��� ����.

    CONSTRAINT üũ�� CHECK(üũ����)
*/
CREATE TABLE EX2_9 (
    NUM1    NUMBER CONSTRAINTS CHECK1 CHECK(NUM1 BETWEEN 1 AND 9), --NUM1�÷��� ���ڵ����� 1~9 ������ �Է°���
    GENDER  VARCHAR2(10)CONSTRAINTS CHECK2 CHECK(GENDER IN ('MALE', 'FEMALE')) 
    -- GENDER�÷��� ���ڵ����� 'MALE', 'FEMALE' ���ڵ����͸� �Է� ����
);

INSERT INTO EX2_9 VALUES (10,'MALE'); -- 1�� �÷� ���� �ʰ��� ���� ����
--ORA-02290: check constraint (SQLDB.CHECK1) violated  //CHECK1�� ������ Ȯ���ط�

INSERT INTO EX2_9 VALUES (5,'FEMALE');

SELECT * FROM EX2_9;

COMMIT;--Ŀ���� ����������, ������ �Է��� �͵��� �ӽû��¿� �ִ�. ������ ���������� �Է��� ������ �ݿ��� ���� Ŀ���� �ؾ��Ѵ�.

--DEFAULT(�⺻��): ���������� �ƴ����� �÷��Ӽ� ��ɾ�
CREATE TABLE EX2_10(
    COL1    VARCHAR2(10)    NOT NULL,
    COL2    VARCHAR2(10)    NULL,
    CREATE_DATE DATE DEFAULT SYSDATE  -- ���� ��ǻ���� ��¥, �ð��� �����´�.
);

--������ �Է�
-- CREATE_DATE�Է½� �����ϰ� �Ǹ� ������ ���� �� SYSDATE�� �۵��ȴ�. ��ǻ���� ��¥�� �ð��� �о�� ���Եȴ�.
INSERT INTO EX2_10(COL1, COL2)VALUES('AA',  'BB');

--CREATE_DATE�÷��� ������ ���� �Է� 
INSERT INTO EX2_10 VALUES('AA', 'BB', '2024-04-04'); --'2024-04-04'���ڿ� �����Ͱ� ��¥ �����ͷ� ����ȯ �Ǿ� ����ȴ�.

SELECT * FROM EX2_10;

----------------------�������� ����----------------------
CREATE TABLE DEPT_CONST(
    DEPTNO  NUMBER(2) CONSTRAINT DEPTCONST_DEPTNO_PK PRIMARY KEY,
    DNAME   VARCHAR2(14)CONSTRAINT DEPTCONST_DNAME_UNQ UNIQUE,
    LOC     VARCHAR2(13) CONSTRAINT DEPTCONST_LOC_NN NOT NULL
);


CREATE TABLE EMP_CONST(
    EMPNO  NUMBER(4) CONSTRAINT EMPCONST_EMPNO_PK PRIMARY KEY,
    ENAME   VARCHAR2(10) CONSTRAINT EMPCONST_ENAME_NN NOT NULL,
    JOB     VARCHAR2(9),
    TEL   VARCHAR2(20) CONSTRAINT EMPCONST_TEL_UNQ UNIQUE,
    HIREDATE DATE,
    SAL     NUMBER(7,2) CONSTRAINT EMPCONST_SAL_CHK CHECK(SAL BETWEEN 1000 AND 9999),
    COMM    NUMBER(7,2),
    DEPTNO  NUMBER(2)  CONSTRAINT EMPCONST_DEPTNO_FK REFERENCES DEPT_CONST(DEPTNO)
);

commit;


-----------------------------------24.04.05(��)-----------------------------------

-------------���θ� �����ͺ��̽� ���� ����-----------
CREATE TABLE USERS (
    id          VARCHAR2(20)    PRIMARY KEY, -- ȸ�� ���̵�
    pwd         VARCHAR2(20),    -- ȸ�� ��й�ȣ
    name        VARCHAR2(20),   --ȸ�� �̸�
    enail       VARCHAR2(40),   --ȸ�� �̸���
    zip_code    CHAR(5),        --ȸ�� �����ȣ
    address     VARCHAR2(100),  -- ȸ�� �ּ�
    phone       VARCHAR2(20),   --ȸ�� ��ȭ��ȣ
    useyn       NUMBER DEFAULT 1,   -- ȸ�� Ż�𿩺�
    regdate     DATE DEFAULT SYSDATE -- ȸ�� ������
);

CREATE TABLE PRODUCT (
    prodnum         NUMBER(5)  PRIMARY  KEY,    --��ǰ ��ȣ
    name            VARCHAR2(200),  --��ǰ �̸�
    kind            CHAR(1),    --��ǰ ���� / bag:1, wallet:2, shoes:3, acc:4
    price1          NUMBER(7),  --����
    price2          NUMBER(7),  -- �ǸŰ�
    price3          NUMBER(7),  --����
    content         VARCHAR2(1000), --��ǰ����
    image           VARCHAR2(50),   --��ǰ����
    useyn           CHAR DEFAULT 'Y',   --�Ǹ����� / �Ǹ�:'y', �Ǹ��ߴ� 'n'
    regdate         DATE        --�����
);

CREATE TABLE ADMIN (
    id      varchar2(20)  primary key,  --������ ���̵�
    pwd     varchar2(20),   --������ ��й�ȣ
    name    varchar2(20),   --������ �̸�
    email   varchar2(40),   --������ �̸���
    phone   varchar2(20)    --������ ��ȭ��ȣ
);

CREATE TABLE CART (
    cartnum     NUMBER(8)   primary key, --��ٱ��� ��ȣ
    id          VARCHAR2(20), --��ٱ��� �̿� ȸ��
    prodnum     NUMBER(5), -- ��ǰ��ȣ
    quantity    NUMBER(5)   default 1,  -- ����
    result      CHAR(1), -- ������� / �����:1, �����:2
    indate      DATE, -- īƮ���� ��¥
    Foreign Key(id) REFERENCES USERS (ID),
    Foreign Key(PRODNUM)REFERENCES PRODUCT (PRODNUM)
);

CREATE TABLE ORDERS(
    ordernum    NUMBER(10)      PRIMARY KEY,  --�ֹ���ȣ
    id          VARCHAR2(20),      --�ֹ�ȸ�� ���̵�
    indate      DATE,  --�ֹ���¥
    FOREIGN KEY(ID) REFERENCES USERS (ID)
);

CREATE TABLE ORDER_DETAIL (
    ODNUM       NUMBER(10)  PRIMARY KEY, --�ֹ�ó�� ��ȣ
    ORDERNUM    NUMBER(10), --�ֹ���ȣ
    PRODNUM     NUMBER(5),  --��ǰ��ȣ
    QUANTITY    NUMBER(5), -- ����
    RESULT      CHAR(1)     DEFAULT 1, --ó������ / ����� :1, ����� :2
    FOREIGN KEY(ORDERNUM) REFERENCES ORDERS (ORDERNUM),
    FOREIGN KEY(PRODNUM) REFERENCES PRODUCT (PRODNUM)
);

CREATE TABLE QNA (
    QSEQ        NUMBER(5)       PRIMARY KEY, --���� ��ȣ
    SUBJECT     VARCHAR2(30),   --���� ����
    CONTENT     VARCHAR2(1000), --���� ����
    REPLY       VARCHAR2(1000), --�亯����
    ID          VARCHAR2(20),  --������ ��
    REP         CHAR(1)         DEFAULT 1, --�亯���� / �亯�� : 1, �亯�� :2
    INDATE      DATE,  -- ���ǳ�¥
    FOREIGN KEY(ID) REFERENCES USERS (ID)
    );



-- ���̺� ����
/*
 DROP TABLE [��Ű��.]���̺�� [CASCADE CONSTRAINTS]
  CASCADE CONSTRAINTS�� ���̸� ������ ���̺��� �⺻Ű�� UNIQUE Ű�� �����ϴ� 
  ���� ���Ἲ �������ǵ� �ڵ����� �����ȴ�.
*/
DROP TABLE DEPT_CONST; --EMP_CONST���̺�κ��� ������ �ް� �ִ� ���̺��̱� ������ ������ �ȵȴ�.

--�������� �߿�.
DROP TABLE EMP_CONST;
DROP TABLE DEPT_CONST;

--[CASCADE CONSTRAINTS] ���
DROP TABLE DEPT_CONST CASCADE CONSTRAINTS; --EMP_CONST���̺��� ����Ű ���������� �ڵ�����


--���̺� ����
--������ �����ߴ� �÷��� ������ Ÿ���� �����ϰų� ����, ���ο� �÷��� �߰��ϴ� ��찡 �߻�
DROP TABLE EX2_10;

CREATE TABLE EX2_10 (
    COL1        VARCHAR2(10)    NOT NULL,
    COL2        VARCHAR2(10)    NULL,
    CREATE_DATE DATE DEFAULT SYSDATE
);

/*
�� �÷��� ����: col1 �÷� �̸��� col11���� ����
    ALTER TABLE [��Ű��.]���̺�� RENAME COLUMN �������÷��� TO �������÷���;
*/
ALTER TABLE EX2_10 RENAME COLUMN COL1 TO COL11;

--�÷� ���� Ȯ��
DESC EX2_10; --���̺��� �÷����� Ȯ��


/*
�� �÷� Ÿ�� ����: col2 �÷��� VARCHAR2(10)���� VARCHAR2(30)���� ����
    ALTER TABLE [��Ű��.]���̺�� MODIFY �÷��� ������Ÿ��;
*/
ALTER TABLE EX2_10
MODIFY COL2 VARCHAR2(30);

--�÷�Ȯ��
DESC EX2_10;

/*
�� �÷� �߰�: col3 NUMBER Ÿ������ �ű� ����
    ALTER TABLE [��Ű��.]���̺�� ADD �÷��� ������Ÿ��;
*/
ALTER TABLE EX2_10
ADD COL3 NUMBER;

--�÷� Ȯ��
DESC EX2_10;

/*
�� �÷� ����: col3 �÷��� ����
    ALTER TABLE [��Ű��.]���̺�� DROP COLUMN �÷���;
*/
ALTER TABLE EX2_10
DROP COLUMN COL3;

--�÷� Ȯ��
DESC EX2_10;

/*
�� �������� �߰�: col11�� �⺻Ű �߰�
    ALTER TABLE [��Ű��.]���̺�� ADD CONSTRAINTS �������Ǹ� PRIMARY KEY (�÷���, ..);
*/
ALTER TABLE EX2_10
ADD CONSTRAINTS PK_EX2_10 PRIMARY KEY(COL11);

/*
�� �������� ����: col11���� �⺻Ű ����
    ALTER TABLE [��Ű��.]���̺�� DROP CONSTRAINTS �������Ǹ�;
*/
ALTER TABLE EX2_10
DROP CONSTRAINTS PK_EX2_10;

--�÷� Ȯ��
DESC EX2_10;


/*
���̺� ����
������Ʈ�� �ϴ� ���� ������ �ִ� ���̺��� �����ؼ� ����� ��찡 �߻��Ѵ�. 
���� ���, ����ϰ� �ִ� ���� ���̺��� ���̺��� ������ ���� �����Ѵٸ� �̸� ������ ����� �׽�Ʈ�غ��ų�, 
���̺� ������ ��ü�� ��������� ����� ���� ���� �ִ�.
    CREATE TABLE [��Ű��.]���̺�� AS
    SELECT �÷�1, �÷�2, ...
    FROM ������ ���̺��;
    
�� �⺻Ű�� ���簡 �ȵȴ�. �׷��� �ٸ� ���������� ����ȴ�.��
*/

SELECT * FROM EX2_9;

--���� : SELECT * FROM EX2_9 ���� ����� �����͸� EX2_9_1���̺��� �����Ͽ� �����ϰڴ�.
CREATE TABLE EX2_9_1 
AS 
SELECT*FROM EX2_9;   --EX2_9���̺�κ��� EX2_9_1���̺��� ���� ����ڴ�.

--Ȯ��
SELECT * FROM EX2_9_1;

--�ó����� : ������̺� �� �μ��ڵ尡 50���� �����͸� �����ϴ� ���̺� �����϶�. EMP_DEPATRMENT_ID_50
CREATE TABLE EMP_DEPARTMENT_ID_50
AS
SELECT EMPLOYEE_ID, EMP_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, SALARY, MANAGER_ID, DEPARTMENT_ID
FROM employees 
WHERE DEPARTMENT_ID = 50;

--�ó�����2: ������̺��� �޿��� 5000�̻��� �����͸� EMP_SALARY_5000���̺� ������ �����϶�.
-- �÷����� �����ȣ, ����̸�, �޿�, Ŀ�̼�, �μ��ڵ� ���
CREATE TABLE EMP_SALARY_5000
AS
SELECT employee_id, EMP_NAME, SALARY, COMMISSION_PCT, DEPARTMENT_ID  --������ ��������� ���� �����غ��� �����ͺ��� ����� Ȯ�� �� �� �ִ�.
FROM employees 
WHERE SALARY >= 5000;

--Ȯ��
SELECT * FROM EMP_SALARY_5000;

--������ �Է�
--201 �����ȣ�� ���� �� ����/ �⺻Ű�� ���簡 �ȵǾ �����ȣ 201�� �ߺ������� �����ϰ� �ȴ�.
INSERT INTO EMP_SALARY_5000 VALUES(201, 'DOCCOMSA', 20000, NULL, 20);

COMMIT;
