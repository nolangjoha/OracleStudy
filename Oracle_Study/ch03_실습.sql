-----------------------------------24.04.08(��)-----------------------------------
/*
SELECT��
���� �⺻���� SQL������ ���̺��̳� �信 �ִ� �����͸� ��ȸ�� �� ����ϴ� �����̴�.
SQL�� �� ���󵵷� �� �� ���� ���� ����ϴ� ���� SELECT���̸�, �⺻ ������ ������ ����.

    SELECT * Ȥ�� �÷�                   --'*'�� ��ü�� �����ϴµ� �̰� �ǹ����� ȿ�������� ������� ����.
    FROM [��Ű��.]���̺�� Ȥ�� [��Ű��.]���
    WHERE ����
    ORDER BY �÷�;  
    
    <�� ������ �ݵ�� ���� �ۼ��ؾ� �Ѵ�.>
*/

--����? EMPLOYEES ���̺��� �޿�(salary)�� 5000�� �Ѵ� �����ȣ�� ������� ��ȸ
SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000
ORDER BY employee_id ASC;-- �������� ASC���� ����

SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000
ORDER BY employee_id DESC; --��������


--����? �޿��� 5000 �̻��̰� job_id�� ��IT_PROG���� ����� ��ȸ�Ѵٸ�, AND �����ڿ� job_id�� �˻��ϴ� ������ �߰��Ѵ�.
SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000 AND JOB_ID = 'IT_PROG'  -- ���ڵ����ʹ� ��ҹ��� ������ �ϹǷ� ���� �Ұ�.
ORDER BY employee_id ASC; --��������

--'it_prog'�ҹ����� �����Ͱ� �������� �ʴ´�.
SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000 AND JOB_ID = 'it_prog'  -- ���ڵ����ʹ� ��ҹ��� ������ �ϹǷ� ���� �Ұ�.
ORDER BY employee_id ASC; --��������

--����? �޿��� 5000 �̻��̰ų� job_id�� ��IT_PROG���� ���, 
--�� �޿��� 5000 �̻��� ��� Ȥ�� job_id ���� ��IT_PROG���� ����� ��ȸ
SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000 OR JOB_ID = 'IT_PROG'  -- OR �����ڿ� job_id�� �˻��ϴ� ������ �߰��Ѵ�.
ORDER BY employee_id ASC; --��������


/*
02 | INSERT��
�űԷ� �����͸� �Է��� ���� INSERT���� ����ϴµ�, ũ�� �⺻ ����, �÷��� ���� ����, INSERT ~SELECT ���·� ���� �� �ִ�.
   
    INSERT INTO [��Ű��.]���̺�� (�÷�1, �÷�2, ...)       --sqldb�� ���� ��Ű���� ���� ����
    VALUES (��1, ��2, ...);
    
    ������ ������ �ݵ�� �����ϴ� �÷��� ���� ���� ����, �׸��� ������ Ÿ���� ��ġ�ؾ߸� �Ѵ�. 
   ��ġ���� ������ ������ �߻��Ͽ� ����Ÿ�� �Էµ��� �ʴ´�.
*/
CREATE TABLE EX3_1(
    COL1    VARCHAR2(10),
    COL2    NUMBER,
    COL3    DATE
);

--������ ����
INSERT INTO EX3_1(COL1, COL2, COL3) VALUES('ABC', 10, SYSDATE);

--������ ��ȸ
SELECT *FROM EX3_1;


--�÷� ������ �ٲٴ��� VALUES���� �ִ� ���� �ٲ� ������ ���߱⸸ �ϸ� ������ ����.
INSERT INTO EX3_1 (Col3, Col1, Col2)VALUES (SYSDATE, 'DEF', 20);

--������ ��ȸ
SELECT *FROM EX3_1;

--������ Ÿ���� ������ ������ ������ �߻��Ѵ�. COL3�� DATE Ÿ���̹Ƿ� 30�� ���ڵ����� �̹Ƿ� �����߻�
INSERT INTO EX3_1 (Col1, Col2, Col3)VALUES ('ABC', 10, 30);
 
--�÷����� ������� ������ VALUES������ ���̺��� �÷� ������� �ش� �÷� ���� ����ؾ� �ϴ� ���´�.
INSERT INTO EX3_1 VALUES ('GHI', 10, SYSDATE); -- �ߵǱ� ������ ����X

--�÷��� ���� ������ ���� �÷�(�ʵ�, ��)�� NULL, DEFAULT�� ���� ���� �����ϴ�.
-- COL3 �÷��� ���� ������ ������ NULL�� ���� ���� �����ϴ�. ������ ���Խ� NULL�� ó�� �ȴ�.
INSERT INTO ex3_1  (col1, col2 ) VALUES ('GHI', 20);

--������ ��ȸ
SELECT *FROM EX3_1;

/*
INSERT ~ SELECT ����
    INSERT INTO [��Ű��.]���̺�� (�÷�1, �÷�2, ...)
    SELECT ��;
*/
--Ű����(�����)�빮��, �������� �ҹ��� ���� ���� ��Ÿ�Ϸ� �۾��ϴ� ������ �ִ�. (�ĺ��� ����)
CREATE TABLE ex3_2(
    emp_id      NUMBER,
    emp_name    VARCHAR2(100)
);

--�ǹ������� ���� ��� / �̹� ������� ���̺� �ٸ����̺� ������ �ֱ�
INSERT INTO ex3_2(emp_id, emp_name)
SELECT employee_id, emp_name FROM employees 
WHERE salary > 5000;

--������ ��ȸ
SELECT *FROM ex3_2;

--���̺� ����(���)
CREATE TABLE employees_bak
AS
SELECT employee_id, emp_name FROM employees 
WHERE Salary > 5000;

--������ ��ȸ
SELECT *FROM employees_bak;


/*
03 | UPDATE��
���̺� �ִ� ���� �����͸� ������ �� ����ϴ� ������ UPDATE���̴�.

    UPDATE [��Ű��.]���̺��
    SET �÷�1 = ���氪1,
        �÷�2 = ���氪2,
    ...
    WHERE ����;
*/
--������ ��ȸ
SELECT*FROM ex3_1;

--ex3_1���̺��� col2���� ��� 50���� �����غ���.
UPDATE ex3_1
SET col2 = 50; -- WHERE ���ǽ��� �����Ǹ�, ��� �����͸� �����ϴ� �ǹ�.

--������ ��ȸ
SELECT*FROM ex3_1;

--����? col1�� �÷����� 'ABC'�� �������� col2�÷��� ���� 100���� �����϶�.
UPDATE ex3_1            --ex3_1���̺���
SET col2 = 100          --col2���� 100���� �����ض�(���)
WHERE col1 = 'ABC';     --col1���� 'ABC'��ġ��(����)

--������ ��ȸ
SELECT*FROM ex3_1 WHERE col1 = 'ABC';

--������ ��ȸ
SELECT*FROM ex3_2 ORDER BY emp_id ASC;

--����? ex3_2���̺��� emp_id �÷��� �����Ͱ� 150�� �������� emp_name�÷��� �̸��� 'Peter Tucker Junior'�� �����Ͽ���
UPDATE ex3_2
SET emp_name = 'Peter Tucker Junior'
WHERE emp_id = 150;

--������ ��ȸ
SELECT*FROM ex3_2 WHERE emp_id = 150;


--�ó����� employees���̺��� salary�÷����� �޿��� 8000�̻��� �����͸� 
--���� �÷����� employee_id, emp_name, email, salary�����Ǵ� ���̺� (emp_salary_8000)�� �����ض�.(���̺� ���� ��ɾ�)
CREATE TABLE emp_salary_8000
AS
SELECT employee_id, emp_name, email, salary FROM employees 
WHERE Salary >= 8000;

--������ ��ȸ
SELECT*FROM emp_salary_8000 ORDER BY employee_id ASC;


--����? employees���̺� �����ȣ�� 100�� ������ email �÷��� 'KINGS'�� �����ϰ� salary�÷��� 20000���� �����϶�.
UPDATE emp_salary_8000
SET email = 'KINGS', salary = 20000
WHERE employee_id = 100;

SELECT*FROM emp_salary_8000 WHERE employee_id = 100;

/*
--JOIN(����)������ �н��� ���� �����մϴ�.
04 | MERGE�� 
MERGE���� ������ ���ؼ� ���̺� �ش� ���ǿ� �´� �����Ͱ� ������ INSERT, ������ UPDATE�� �����ϴ� �����̴�. 
Ư�� ���ǿ� ���� � ���� INSERT��, �� �ٸ� ��쿡�� UPDATE���� �����ؾ� �� ��, 
���ſ��� �ش� ������ ó���ϴ� ������ ������ �ۼ��ؾ� ������, 
MERGE���� ���� ���п� ���� �� �������� ó���� �� �ְ� �Ǿ���.

    MERGE INTO [��Ű��.]���̺��
        USING (update�� insert�� ������ ��õ)
             ON (update�� ����)
    WHEN MATCHED THEN
           SET �÷�1 = ��1, �÷�2 = ��2, ...
    WHERE update ����
           DELETE WHERE update_delete ����
    WHEN NOT MATCHED THEN
           INSERT (�÷�1, �÷�2, ...) VALUES (��1, ��2,...)
           WHERE insert ����;
           
<�뵵 : ���θ� ��ٱ��� ���>
   - ����ڰ� ��ǰ�� ��ٱ��Ͽ� �߰� �� ��� ���� ����ڿ� ��ǰ�� ���� ������ ��ٱ��Ͽ� �����ϸ� ��������(update)
     �������� ������ ����ڿ� ��ǰ�����Ͱ� ����(insert)�ȴ�.
*/

--https://gent.tistory.com/406 MERGE���� ����
--��������_SCOTT ���� ��� 

--1) ���� ���̺� ���(DUAL)
-- �ó�����? ������̺� �����ȣ 7738�� �����ϸ� UPDATE �ϰ�, �������� ������ INSERT �۾��� ����.
-- �̷��� ����� ��ٱ��Ͽ��� ���ȴ�. ������ ��ǰ�� ������ ������ ����, ������ ��ǰ �߰�.
MERGE
    INTO emp a
    USING dual
    ON(a.empno = 7738)  
    WHEN MATCHED THEN -- ���� ������ ���̸�
    UPDATE
    SET a.deptno = 20  -- ���� UPDATE���� UPDATE emp a  SET a.deptno = 20 WHERE a.empno = 7738�� �ۼ��Ǿ�� �Ѵ�.
                       -- ������ ���� emp a�� a.empno = 7738�� �ۼ��Ǿ��� ������ ������ �����ϴ�.
    WHEN NOT MATCHED THEN
    INSERT(a.empno, a.ename, a.deptno)
    VALUES(7738,'SCOTT',20);  -- ���������� INSERT emp a(a.empno, a.ename, a.deptno) VALUES(7788,'SCOTT',20);�� �����.
                              -- UPDATE���� ���� ������ �����ۼ��� ������.


SELECT * FROM EMP WHERE empno = 7738; -- �����Ͱ� �߰��Ȱ��� Ȯ��

--2) ������ ���
-- SCOOT�������� job_history ���̺��� ����.
SELECT * 
FORM job_history a, emp b
WHERE a.empno = b.empno
AND a.empno = 7738;

MERGE
    INTO job_history a
    USING emp b
    ON(a.empno = 7738 AND a.empno = b.empno) 
    WHEN MATCHED THEN
        UPDATE
            SET a.job = b.job, a.deptno = b.deptno
    WHEN NOT MATCHED THEN
        INSERT (a.empno, a.job, a.deptno) VALUES(b.empno, b.job, b.deptno);

--DELETE�� ���
MERGE
 INTO emp a
 USING dual
 ON (a.empno = 7738)
    WHEN MATCHED THEN
        UPDATE
        SET a.deptno = 20 WHERE a.job = 'ANALYST'
    DELETE
        WHERE a.job <> 'ANALYST';














-----------------------------------24.04.08(��)-----------------------------------
/*
SELECT��
���� �⺻���� SQL������ ���̺��̳� �信 �ִ� �����͸� ��ȸ�� �� ����ϴ� �����̴�.
SQL�� �� ���󵵷� �� �� ���� ���� ����ϴ� ���� SELECT���̸�, �⺻ ������ ������ ����.

    SELECT * Ȥ�� �÷�                   --'*'�� ��ü�� �����ϴµ� �̰� �ǹ����� ȿ�������� ������� ����.
    FROM [��Ű��.]���̺�� Ȥ�� [��Ű��.]���
    WHERE ����
    ORDER BY �÷�;  
    
    <�� ������ �ݵ�� ���� �ۼ��ؾ� �Ѵ�.>
*/

--����? EMPLOYEES ���̺��� �޿�(salary)�� 5000�� �Ѵ� �����ȣ�� ������� ��ȸ
SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000
ORDER BY employee_id ASC;-- �������� ASC���� ����

SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000
ORDER BY employee_id DESC; --��������


--����? �޿��� 5000 �̻��̰� job_id�� ��IT_PROG���� ����� ��ȸ�Ѵٸ�, AND �����ڿ� job_id�� �˻��ϴ� ������ �߰��Ѵ�.
SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000 AND JOB_ID = 'IT_PROG'  -- ���ڵ����ʹ� ��ҹ��� ������ �ϹǷ� ���� �Ұ�.
ORDER BY employee_id ASC; --��������

--'it_prog'�ҹ����� �����Ͱ� �������� �ʴ´�.
SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000 AND JOB_ID = 'it_prog'  -- ���ڵ����ʹ� ��ҹ��� ������ �ϹǷ� ���� �Ұ�.
ORDER BY employee_id ASC; --��������

--����? �޿��� 5000 �̻��̰ų� job_id�� ��IT_PROG���� ���, 
--�� �޿��� 5000 �̻��� ��� Ȥ�� job_id ���� ��IT_PROG���� ����� ��ȸ
SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000 OR JOB_ID = 'IT_PROG'  -- OR �����ڿ� job_id�� �˻��ϴ� ������ �߰��Ѵ�.
ORDER BY employee_id ASC; --��������


/*
02 | INSERT��
�űԷ� �����͸� �Է��� ���� INSERT���� ����ϴµ�, ũ�� �⺻ ����, �÷��� ���� ����, INSERT ~SELECT ���·� ���� �� �ִ�.
   
    INSERT INTO [��Ű��.]���̺�� (�÷�1, �÷�2, ...)       --sqldb�� ���� ��Ű���� ���� ����
    VALUES (��1, ��2, ...);
    
    ������ ������ �ݵ�� �����ϴ� �÷��� ���� ���� ����, �׸��� ������ Ÿ���� ��ġ�ؾ߸� �Ѵ�. 
   ��ġ���� ������ ������ �߻��Ͽ� ����Ÿ�� �Էµ��� �ʴ´�.
*/
CREATE TABLE EX3_1(
    COL1    VARCHAR2(10),
    COL2    NUMBER,
    COL3    DATE
);

--������ ����
INSERT INTO EX3_1(COL1, COL2, COL3) VALUES('ABC', 10, SYSDATE);

--������ ��ȸ
SELECT *FROM EX3_1;


--�÷� ������ �ٲٴ��� VALUES���� �ִ� ���� �ٲ� ������ ���߱⸸ �ϸ� ������ ����.
INSERT INTO EX3_1 (Col3, Col1, Col2)VALUES (SYSDATE, 'DEF', 20);

--������ ��ȸ
SELECT *FROM EX3_1;

--������ Ÿ���� ������ ������ ������ �߻��Ѵ�. COL3�� DATE Ÿ���̹Ƿ� 30�� ���ڵ����� �̹Ƿ� �����߻�
INSERT INTO EX3_1 (Col1, Col2, Col3)VALUES ('ABC', 10, 30);
 
--�÷����� ������� ������ VALUES������ ���̺��� �÷� ������� �ش� �÷� ���� ����ؾ� �ϴ� ���´�.
INSERT INTO EX3_1 VALUES ('GHI', 10, SYSDATE); -- �ߵǱ� ������ ����X

--�÷��� ���� ������ ���� �÷�(�ʵ�, ��)�� NULL, DEFAULT�� ���� ���� �����ϴ�.
-- COL3 �÷��� ���� ������ ������ NULL�� ���� ���� �����ϴ�. ������ ���Խ� NULL�� ó�� �ȴ�.
INSERT INTO ex3_1  (col1, col2 ) VALUES ('GHI', 20);

--������ ��ȸ
SELECT *FROM EX3_1;

/*
INSERT ~ SELECT ����
    INSERT INTO [��Ű��.]���̺�� (�÷�1, �÷�2, ...)
    SELECT ��;
*/
--Ű����(�����)�빮��, �������� �ҹ��� ���� ���� ��Ÿ�Ϸ� �۾��ϴ� ������ �ִ�. (�ĺ��� ����)
CREATE TABLE ex3_2(
    emp_id      NUMBER,
    emp_name    VARCHAR2(100)
);

--�ǹ������� ���� ��� / �̹� ������� ���̺� �ٸ����̺� ������ �ֱ�
INSERT INTO ex3_2(emp_id, emp_name)
SELECT employee_id, emp_name FROM employees 
WHERE salary > 5000;

--������ ��ȸ
SELECT *FROM ex3_2;

--���̺� ����(���)
CREATE TABLE employees_bak
AS
SELECT employee_id, emp_name FROM employees 
WHERE Salary > 5000;

--������ ��ȸ
SELECT *FROM employees_bak;


/*
03 | UPDATE��
���̺� �ִ� ���� �����͸� ������ �� ����ϴ� ������ UPDATE���̴�.

    UPDATE [��Ű��.]���̺��
    SET �÷�1 = ���氪1,
        �÷�2 = ���氪2,
    ...
    WHERE ����;
*/
--������ ��ȸ
SELECT*FROM ex3_1;

--ex3_1���̺��� col2���� ��� 50���� �����غ���.
UPDATE ex3_1
SET col2 = 50; -- WHERE ���ǽ��� �����Ǹ�, ��� �����͸� �����ϴ� �ǹ�.

--������ ��ȸ
SELECT*FROM ex3_1;

--����? col1�� �÷����� 'ABC'�� �������� col2�÷��� ���� 100���� �����϶�.
UPDATE ex3_1            --ex3_1���̺���
SET col2 = 100          --col2���� 100���� �����ض�(���)
WHERE col1 = 'ABC';     --col1���� 'ABC'��ġ��(����)

--������ ��ȸ
SELECT*FROM ex3_1 WHERE col1 = 'ABC';

--������ ��ȸ
SELECT*FROM ex3_2 ORDER BY emp_id ASC;

--����? ex3_2���̺��� emp_id �÷��� �����Ͱ� 150�� �������� emp_name�÷��� �̸��� 'Peter Tucker Junior'�� �����Ͽ���
UPDATE ex3_2
SET emp_name = 'Peter Tucker Junior'
WHERE emp_id = 150;

--������ ��ȸ
SELECT*FROM ex3_2 WHERE emp_id = 150;


--�ó����� employees���̺��� salary�÷����� �޿��� 8000�̻��� �����͸� 
--���� �÷����� employee_id, emp_name, email, salary�����Ǵ� ���̺� (emp_salary_8000)�� �����ض�.(���̺� ���� ��ɾ�)
CREATE TABLE emp_salary_8000
AS
SELECT employee_id, emp_name, email, salary FROM employees 
WHERE Salary >= 8000;

--������ ��ȸ
SELECT*FROM emp_salary_8000 ORDER BY employee_id ASC;


--����? employees���̺� �����ȣ�� 100�� ������ email �÷��� 'KINGS'�� �����ϰ� salary�÷��� 20000���� �����϶�.
UPDATE emp_salary_8000
SET email = 'KINGS', salary = 20000
WHERE employee_id = 100;

SELECT*FROM emp_salary_8000 WHERE employee_id = 100;

/*
--JOIN(����)������ �н��� ���� �����մϴ�.
04 | MERGE�� 
MERGE���� ������ ���ؼ� ���̺� �ش� ���ǿ� �´� �����Ͱ� ������ INSERT, ������ UPDATE�� �����ϴ� �����̴�. 
Ư�� ���ǿ� ���� � ���� INSERT��, �� �ٸ� ��쿡�� UPDATE���� �����ؾ� �� ��, 
���ſ��� �ش� ������ ó���ϴ� ������ ������ �ۼ��ؾ� ������, 
MERGE���� ���� ���п� ���� �� �������� ó���� �� �ְ� �Ǿ���.

    MERGE INTO [��Ű��.]���̺��
        USING (update�� insert�� ������ ��õ)
             ON (update�� ����)
    WHEN MATCHED THEN
           SET �÷�1 = ��1, �÷�2 = ��2, ...
    WHERE update ����
           DELETE WHERE update_delete ����
    WHEN NOT MATCHED THEN
           INSERT (�÷�1, �÷�2, ...) VALUES (��1, ��2,...)
           WHERE insert ����;
*/

















/*
05 | DELETE��
���̺� �ִ� �����͸� ������ �� DELETE���� ����Ѵ�.

    �� �Ϲ� ����
    DELETE [FROM] [��Ű��.]���̺��
    WHERE delete ����; 
*/

--emp_salary_8000���̺� ���
SELECT *FROM emp_salary_8000 ORDER BY employee_id ASC;

--������ ����
DELETE FROM emp_salary_8000   --WHERE���� �̰͸� ���� ��� �����Ͱ� ���� �ȴ�.(�����ǡ�)
WHERE employee_id = 100;

--emp_salary_8000���̺� Ȯ��
SELECT *FROM emp_salary_8000 WHERE employee_id = 100;

--�ó�����? emp_salary_8000���̺� �޿��� 10000~13000������ �����͸� �����϶�
DELETE FROM emp_salary_8000
WHERE salary >= 1000 AND salary <= 13000;
/* ���� AND������ ����
DELETE FROM emp_salary_8000
WHERE salary BETWEEN 1000 AND 13000;
*/
--emp_salary_8000���̺� Ȯ��
SELECT *FROM emp_salary_8000 WHERE salary >= 1000 AND salary <= 13000;

--�ó�����? ����� 101�Ǵ� 145�� �����͸� �����϶�
SELECT *FROM emp_salary_8000;

DELETE FROM emp_salary_8000
WHERE employee_id = 101 OR employee_id =145;

--������ ��ȸ
SELECT *FROM emp_salary_8000 
WHERE employee_id = 101 OR employee_id =145;        --10, 145 ���� �����ʹ� ���� ���̳� ���������� �޾� �� ���̴�.

COMMIT;

/*
TRUNCATE��
�����͸� ������ ���� DELETE���� ����ϴµ� �̿� ���� ����� �����ϴ� ������ �ٷ� TRUNCATE���̴�. 
DELETE���� �����͸� ������ �Ŀ� COMMIT�� �����ؾ� �����Ͱ� ������ �����ǰ�, 
�ݴ�� ROLLBACK�� �����ϸ� �����Ͱ� �����Ǳ� ������ ���͵ȴ�. 

������ DDL���� ���ϴ� TRUNCATE���� �ѹ� �����ϸ� �����Ͱ� �ٷ� �����ǰ� 
ROLLABCK�� �����ϴ��� ���� �� ���·� ���͵��� �ʴ´�. 
���� TRUNCATE������ WHERE ������ ���� �� ����.
�� ���̺� ������ ��ü�� �ٷ� �����ȴ�. 

������ ����� �����Ƿ� TRUNCATE���� ����� ���� �׻� ���Ǹ� ��￩�� �Ѵ�.

    TRUNCATE TABLE [��Ű����.]���̺��;
*/
--ǥ ����
CREATE TABLE ex3_4(
    employee_id NUMBER
);

--������ �ֱ�
INSERT INTO ex3_4 VALUES(100);

--������ ��??
SELECT*FROM ex3_4;

--�ѹ�
ROLLBACK; --���� �Է��� �����Ͱ� ��ҵ�.

--������ ��ȸ
SELECT*FROM ex3_4;

INSERT INTO ex3_4 VALUES(100);

SELECT*FROM ex3_4;

COMMIT; --�������� �����ͺ��̽� ���Ͽ� �۾������� �ݿ��ȴ�.

--���ǽ� WHERE�� ������ ������ �ȵȴ�. ROLLBACK���� �ȵ�.
TRUNCATE TABLE ex3_4; --Table EX3_4��(��) �߷Ƚ��ϴ�.
--�����͸� ���������� �����ϴ� ���� �ƴ϶� �����ϴ� �κ��� �߶���� ��. 
--ȿ���� ������ ������, �ǵ������� ����. �ſ�ſ�ſ� �����Ͽ� ����ؾ���.

ROLLBACK;

SELECT*FROM ex3_4;--�ѹ����� �ȵǾ�, ���������Ͱ� �������� ����.


/*
07 | �ǻ��÷�
�ǻ��÷�Pseudo-column�̶� ���̺��� �÷�ó�� ���������� ������ ���̺� ��������� �ʴ� �÷��� ���Ѵ�. 
SELECT �������� �ǻ��÷��� ����� �� ������, �ǻ��÷� ���� INSERT, UPDATE, DELETE �� ���� ����. 
2���� ��06.�������� ������ �н��ߴ� NEXTVAL, CURRVAL�� �ǻ��÷��� �����̴�.
*/

--1) ROWNUM : �������� ��ȯ�Ǵ� �� �ο�鿡 ���� �������� ��Ÿ���� �ǻ��÷��̴�.(������ ���� �ſ� �߿��ϰ� ��� �� ����̴�.)

SELECT ROWNUM, employee_id, emp_name FROM EMPLOYEES WHERE salary >= 5000; 

--ȭ�鿡 ��µǴ� �����͸� ����
SELECT ROWNUM, employee_id, emp_name, salary FROM EMPLOYEES
WHERE ROWNUM <= 10;

--�߰� ���� ���ǿ� �ش��ϴ� �����ʹ� ����� ����(�߿�)
SELECT ROWNUM, employee_id, emp_name, salary FROM EMPLOYEES
WHERE ROWNUM >=6 AND ROWNUM<=10; 



--2) ROWID : ROWID�� ���̺� ����� �� �ο찡 ����� �ּ� ���� ����Ű�� �ǻ��÷��̴�.
-- �� �ο츦 �ĺ��ϴ� ���̹Ƿ� ROWID�� ������ ���� ������.
SELECT ROWNUM,ROWID employee_id, emp_name, salary FROM EMPLOYEES
WHERE ROWNUM <=5;

/*
08 | ������ //NUMBER������ Ÿ�Կ� �ش��ϴ� �÷� �Ǵ� ���� �����Ϳ� ���.
������Operator�� ������ �����Ѵ�. ����Ŭ�� �پ��� �����ڸ� �����ϰ� �ִµ�, �̵��� �����ϸ� ������ ����.

���� ������: +, -, *, /
��+���� ��-���� ���� ����� 1���� ���� �����ڷ� ���� �� ���� ����� ������ ��Ÿ����. ���� �� ���� ����, 
�� ���� �����ڷ� ���� ���� ���� ������ ���� ������ �Ѵ�. �׸��� ��*���� ����, ��/���� ������ ������ �Ѵ�.

���� ������: ||
��||���� �� ���ڸ� ���̴�(�����ϴ�) ������ �����Ѵ�. ���� ������ ��� ���̺��� �����-����� ���·� �����ϴ� SELECT ���̴�.

�Է�

    SELECT employee_id || '-' || emp_name AS employee_info
      FROM employees
     WHERE ROWNUM < 5;
*/

--���̺� ��������
DESC EMPLOYEES;

SELECT employee_id, salary, commission_pct, salary*12+commission_pct AS "����" FROM employees
ORDER BY employee_id;

--���� ��� ����� NULL�� Ȯ�εǴ� ���� �÷������Ͱ� NULL�� �����ϸ�, ����� NULL�� �˴ϴ�.
SELECT 10 + 20 FROM DUAL;

--����� NULL�� �����ϸ� ����� NULL�� �ȴ�. NULL���� ����� NULL���� �Լ��� �н��ؾ� �Ѵ�.
SELECT 10 + 20 + NULL FROM DUAL; -- NULL

/*
�� ������: >, <, >=, <=, =, <>, !=, \^=
�� ������ �����ϴ� �����ڷ� ���п��� ����ϴ� �ε�ȣ�� ���ӻ��� ����. 
��, �� ���� �������� �Ǵ��ϴ� ��ȣ ������(=)�� �ݴ��� �񵿵� �����ڷδ� ��< >��, ��!=��, ��\^=���� �ִµ�, 
�� �� �������� ������ ��ȯ ����� ��� ����. 
���� ���� ���� �� ���� �Ӹ� �ƴ϶� ���ڿ� ��¥���� �� �����ϴ�.
*/

/*
�������� : https://gent.tistory.com/311
09 | ǥ���� 
ǥ����Expression�̶� �� �� �̻��� ���� ������, SQL �Լ� ���� ���յ� ���̴�. 
�� �������� Ư�� ���ǿ� ���� ���� �����ؼ� ���̴� CASE ǥ����(���� CASE���̶�� �Ѵ�)�� ���� �˾� ����.

    CASE WHEN ����1 THEN ��1
         WHEN ����2 THEN ��2
    ...
         ELSE ��Ÿ ��
    END
*/

SELECT employee_id, emp_name, department_id FROM employees ORDER BY department_id;

--[case�� ����]
-- 1) if�� ���� /   department_id�÷��� �����Ͱ� 10���̸� New York, 20���̸� Dallas , ��Ÿ�� Unknown ��ȸ��
SELECT 
        employee_id, emp_name, department_id,
    CASE 
      WHEN department_id = 10 THEN 'New York'
      WHEN department_id = 20 THEN 'Dallas'
      ELSE 'Unknown'
      END AS department_city
FROM 
    employees
ORDER BY department_id ;

-- 2) switch ����
SELECT employee_id, emp_name, department_id,
    CASE department_id
            WHEN 10 THEN 'New York'
            WHEN 20 THEN 'Dallas'
            ELSE 'Unknown'
    END AS department_city
FROM
     employeeS
ORDER BY department_id ;

--ELSE�� ������ ��� ������ �����Ǵ� ���� ������ NULL�� ��ȯ�ȴ�.
SELECT 
        employee_id, emp_name, department_id,
    CASE 
      WHEN department_id = 10 THEN 'New York'
      WHEN department_id = 20 THEN 'Dallas'
--      ELSE 'Unknown'  --''�� NULL�� �ǹ��Ѵ�. �������� ó���ϰ� ������ ' '�� �־��ش�. 
      END AS department_city
FROM 
    employees
ORDER BY department_id ;

--�ó����� : salary(�޿�)�� 15000 �̻��̸� ��׿���, 10000�̻��̸� ������� �������� �Ϲݿ������� ����϶�.
--�����ȣ, �̸�, �޿�, ��������
SELECT 
        employee_id, emp_name, salary,
    CASE 
      WHEN salary >= 15000 THEN '��׿���'
      WHEN salary >= 10000 THEN '�������'
      ELSE '�Ϲݿ���'
      END AS salary_gubun
FROM 
    employees
ORDER BY salary ;


--��ø case�߰� �����۾� ����,
SELECT 
        employee_id, emp_name, department_id,salary,
    CASE 
      WHEN department_id = 10 THEN 
            CASE
                WHEN salary >= 15000 THEN '1���'
                WHEN salary >= 10000 THEN '2���'
                WHEN salary >= 3000 THEN '3���'
            END
      WHEN department_id = 20 THEN
            CASE
                WHEN salary >= 18000 THEN '1���'
                WHEN salary >= 15000 THEN '2���'
                WHEN salary >= 5000 THEN '3���'
            END
     WHEN department_id = 30 THEN 
            CASE
                WHEN salary >= 8000 THEN '1���'
                WHEN salary >= 5000 THEN '2���'
                WHEN salary >= 2000 THEN '3���'
            END
      ELSE ' '
      END AS salary_gubun
FROM 
    employees
ORDER BY department_id ;



/*
�� ���ǽ�
�� ���ǽ��� �� �����ڳ� ANY, SOME, ALL Ű����� ���ϴ� ���ǽ��� ���Ѵ�. 
���⼭�� ANY, SOME, ALL �񱳿� ���ؼ� �˾� ���ٵ� ���� ANY�� ���� ����.
*/
--salary(�޿�)�� 2000 �Ǵ� 3000 �Ǵ� 4000�� ������ // 1)�� 2)�� �����ϴ�.
--1) 
 SELECT employee_id, salary
 FROM employees
 WHERE salary = ANY (2000, 3000, 4000)
 ORDER BY employee_id;

--2)    
 SELECT employee_id, salary
 FROM employees
 WHERE salary = 2000 or salary = 3000 salary = 4000
 ORDER BY employee_id;

--3) salary(�޿�)rk 2000�̰�, 3000�̰�, 4000�� �����͸� ��ȸ�϶� -> ������ ���� ����, ��� ����.
 SELECT employee_id, salary
 FROM employees
 WHERE salary = ALL (2000, 3000, 4000) --�ѹ��� 2000, 3000, 4000�� �����ʹ� �������� �ʴ´�.
 ORDER BY employee_id;

--4)�޿��� 4000���� ū �����͸� ��ȸ
 SELECT employee_id, salary
 FROM employees
 WHERE salary > ALL (2000, 3000, 4000)
 ORDER BY employee_id;

--5) �޿��� 2000���� ū ������, 3000���� ū ������, 4000���� ū �����͸� ��ȸ
--ANY, SOME�� �����ϴ�. 
 SELECT employee_id, salary
 FROM employees
 WHERE salary > ANY (2000, 3000, 4000)
 ORDER BY employee_id;
   
 SELECT employee_id, salary
 FROM employees
 WHERE salary > SOME (2000, 3000, 4000)
 ORDER BY employee_id;
    
    
    
/*
    �� ���ǽ�
�� ���ǽ��� ���������� AND, OR, NOT�� ����ϴ� ���ǽ��� ���Ѵ�. 
AND�� ��� ������ �����ؾ� �ϰ� OR�� ���� ���� �� �ϳ��� �����ص� TRUE�� ��ȯ�ȴ�. 
NOT�� ���ǽ� �� ����� ����(FALSE)�� �� ���ϴ� ���, �� TRUE�� ��ȯ�Ѵ�.   
*/
-- ���� �Ʒ��� ����. �׷��� ǥ���� ���̰� �ִ� ���� : ������ ����, ���� ����� ��Ÿ������ ������ �ٸ� �� �ִ�.
--salary��� �޿� �÷��� ������ �������� ���� ������ �ٸ� �� �ִ�.
 SELECT employee_id, salary
      FROM employees
     WHERE NOT ( salary >= 2500) --salary < 2500�� ����.
     ORDER BY employee_id;

 SELECT employee_id, salary
      FROM employees
     WHERE salary < 2500
     ORDER BY employee_id;
    
 /*
 NULL ���ǽ�
NULL ���ǽ��� Ư�� ���� NULL���� ���θ� üũ�ϴ� ���ǽ��̴�. 
�ռ� UPDATE���� �˾� ���鼭 NULL���� ���δ� IS NULL�� IS NOT NULL�� üũ�Ѵٴ� ������ �н��ߴ�. 
�ٽ� ���������� Ư�� �÷� ���� NULL������ ���θ� üũ�� �� ��ȣ ������(=, < >)�� ����ϸ� ����� ������ ���Ѵ�. 
���� ���, �޿��� NULL���� Ȥ�� �ƴ��� ���θ� üũ�Ϸ��� ��salary = NULL�� Ȥ�� ��salary < > NULL�� ���·� ���ϸ� �� ?ǰ? 
��salary IS NULL�� Ȥ�� ��salary IS NOT NULLL�� ���·� ���ؾ� �Ѵ�.
 */   
--���ǽĿ��� ��� �Ǵ� IS NULL, IS NOT NULL
-- commission_pct �÷��� �����Ͱ� NULL
SELECT employee_id, emp_name, salary, commission_pct FROM employees
WHERE commission_pct IS NULL;

--commission_pct �÷��� �����Ͱ� NOT NULL
SELECT employee_id, emp_name, salary, commission_pct FROM employees
WHERE commission_pct IS NOT NULL;


/*
IN ���ǽ�
IN ���ǽ��� �������� ����� ���� ���Ե� ���� ��ȯ�ϴµ� �տ��� ����� ANY�� ����ϴ�.
*/
--�� ������ �޿��� 2000, 3000, 4000�� ���ԵǴ� ����� ������ ���
SELECT employee_id, emp_name, salary FROM employees
WHERE salary IN(2000,3000,4000); --OR�� ��ȯ�� ����

-- �� ������ �޿��� 2000, 3000, 4000�� ���Ե��� �ʴ� ����� ������ ���
-- ������ Ǯ�� ���� ��salary < > 2000 AND salary < > 3000 AND salary < > 4000���̸�, ��< >ALL���ε� �ٲ� �� �� �ִ�.
SELECT employee_id, salary 
FROM employees
WHERE salary NOT IN(2000,3000,4000); 
ORDER BY employee_id;

--EXISTS ���ǽ�: ����(join)���� �ſ�� �� ���Ŀ�

/*
LIKE ���ǽ�
LIKE ���ǽ��� ���ڿ��� ������ �˻��� �� ����ϴ� ���ǽ��̴�. 
*/
--���� ���, ��� ���̺��� ����̸��� ��A���� ���۵Ǵ� ����� ��ȸ�ϴ� ������ �ۼ��Ѵٸ� ������ ���� LIKE ���ǽ��� ����Ѵ�.
   SELECT emp_name
   FROM employees
   WHERE emp_name LIKE 'A%'
   ORDER BY emp_name;

-- �߸� ����� Like�� �����ִ�. '='�� ���� �ȵȴ�.
    SELECT emp_name
    FROM employees
    wHERE emp_name = 'A%'
    ORDER BY emp_name;

--AI�� ���۵Ǵ� ��� ����� ��ȸ�� ������.
   SELECT emp_name
   FROM employees
   WHERE emp_name LIKE 'Al%'
   ORDER BY emp_name;

/*
 ��%���� ��, ��, �߰� ��� �� �� ������ ���ǽ��� �˻��� �� ��ҹ��ڸ� �����Ѵٴ� ���� ��������. 
 ��%���ʹ� �ٸ��� ��_��(����, ������ھ�)�� ������ ���� ��ü�� �ƴ� �� ���ڸ� ���Ѵ�.
*/
CREATE TABLE ex3_5 (
    name VARCHAR2(30)
);

INSERT INTO ex3_5 VALUES('ȫ�浿');
INSERT INTO ex3_5 VALUES('ȫ���');
INSERT INTO ex3_5 VALUES('ȫ���');
INSERT INTO ex3_5 VALUES('ȫ���');
INSERT INTO ex3_5 VALUES('ȫ��');

SELECT*FROM ex3_5;

--ȫ��� �����ϴ� �̸��� ��ȸ�϶�. 
--��� : 'ȫ��'�̶� �α��ڵ� ����ִ�. %�� ���̰� 0���� �ǹ̵� ���� �� ���̴�.
SELECT*FROM ex3_5
WHERE name LIKE 'ȫ��%';

--ȫ��� �����ϴ� ��ü 3���� �̸��� ��ȸ�϶�.
SELECT*FROM ex3_5
WHERE name LIKE 'ȫ��_';


COMMIT;

ERE salary = ALL (2000, 3000, 4000) --�ѹ��� 2000, 3000, 4000�� �����ʹ� �������� �ʴ´�.
 ORDER BY employee_id;

--4)�޿��� 4000���� ū �����͸� ��ȸ
 SELECT employee_id, salary
 FROM employees
 WHERE salary > ALL (2000, 3000, 4000)
 ORDER BY employee_id;

--5) �޿��� 2000���� ū ������, 3000���� ū ������, 4000���� ū �����͸� ��ȸ
--ANY, SOME�� �����ϴ�. 
 SELECT employee_id, salary
 FROM employees
 WHERE salary > ANY (2000, 3000, 4000)
 ORDER BY employee_id;














/*
05 | DELETE��
���̺� �ִ� �����͸� ������ �� DELETE���� ����Ѵ�.

    �� �Ϲ� ����
    DELETE [FROM] [��Ű��.]���̺��
    WHERE delete ����; 
*/

--emp_salary_8000���̺� ���
SELECT *FROM emp_salary_8000 ORDER BY employee_id ASC;

--������ ����
DELETE FROM emp_salary_8000   --WHERE���� �̰͸� ���� ��� �����Ͱ� ���� �ȴ�.(�����ǡ�)
WHERE employee_id = 100;

--emp_salary_8000���̺� Ȯ��
SELECT *FROM emp_salary_8000 WHERE employee_id = 100;

--�ó�����? emp_salary_8000���̺� �޿��� 10000~13000������ �����͸� �����϶�
DELETE FROM emp_salary_8000
WHERE salary >= 1000 AND salary <= 13000;
/* ���� AND������ ����
DELETE FROM emp_salary_8000
WHERE salary BETWEEN 1000 AND 13000;
*/
--emp_salary_8000���̺� Ȯ��
SELECT *FROM emp_salary_8000 WHERE salary >= 1000 AND salary <= 13000;

--�ó�����? ����� 101�Ǵ� 145�� �����͸� �����϶�
SELECT *FROM emp_salary_8000;

DELETE FROM emp_salary_8000
WHERE employee_id = 101 OR employee_id =145;

--������ ��ȸ
SELECT *FROM emp_salary_8000 
WHERE employee_id = 101 OR employee_id =145;        --10, 145 ���� �����ʹ� ���� ���̳� ���������� �޾� �� ���̴�.

COMMIT;

/*
TRUNCATE��
�����͸� ������ ���� DELETE���� ����ϴµ� �̿� ���� ����� �����ϴ� ������ �ٷ� TRUNCATE���̴�. 
DELETE���� �����͸� ������ �Ŀ� COMMIT�� �����ؾ� �����Ͱ� ������ �����ǰ�, 
�ݴ�� ROLLBACK�� �����ϸ� �����Ͱ� �����Ǳ� ������ ���͵ȴ�. 

������ DDL���� ���ϴ� TRUNCATE���� �ѹ� �����ϸ� �����Ͱ� �ٷ� �����ǰ� 
ROLLABCK�� �����ϴ��� ���� �� ���·� ���͵��� �ʴ´�. 
���� TRUNCATE������ WHERE ������ ���� �� ����.
�� ���̺� ������ ��ü�� �ٷ� �����ȴ�. 

������ ����� �����Ƿ� TRUNCATE���� ����� ���� �׻� ���Ǹ� ��￩�� �Ѵ�.

    TRUNCATE TABLE [��Ű����.]���̺��;
*/
--ǥ ����
CREATE TABLE ex3_4(
    employee_id NUMBER
);

--������ �ֱ�
INSERT INTO ex3_4 VALUES(100);

--������ ��ȸ
SELECT*FROM ex3_4;

--�ѹ�
ROLLBACK; --���� �Է��� �����Ͱ� ��ҵ�.

--������ ��ȸ
SELECT*FROM ex3_4;

INSERT INTO ex3_4 VALUES(100);

SELECT*FROM ex3_4;

COMMIT; --�������� �����ͺ��̽� ���Ͽ� �۾������� �ݿ��ȴ�.

--���ǽ� WHERE�� ������ ������ �ȵȴ�. ROLLBACK���� �ȵ�.
TRUNCATE TABLE ex3_4; --Table EX3_4��(��) �߷Ƚ��ϴ�.
--�����͸� ���������� �����ϴ� ���� �ƴ϶� �����ϴ� �κ��� �߶���� ��. 
--ȿ���� ������ ������, �ǵ������� ����. �ſ�ſ�ſ� �����Ͽ� ����ؾ���.

ROLLBACK;

SELECT*FROM ex3_4;--�ѹ����� �ȵǾ�, ���������Ͱ� �������� ����.


/*
07 | �ǻ��÷�
�ǻ��÷�Pseudo-column�̶� ���̺��� �÷�ó�� ���������� ������ ���̺� ��������� �ʴ� �÷��� ���Ѵ�. 
SELECT �������� �ǻ��÷��� ����� �� ������, �ǻ��÷� ���� INSERT, UPDATE, DELETE �� ���� ����. 
2���� ��06.�������� ������ �н��ߴ� NEXTVAL, CURRVAL�� �ǻ��÷��� �����̴�.
*/

--1) ROWNUM : �������� ��ȯ�Ǵ� �� �ο�鿡 ���� �������� ��Ÿ���� �ǻ��÷��̴�.(������ ���� �ſ� �߿��ϰ� ��� �� ����̴�.)

SELECT ROWNUM, employee_id, emp_name FROM EMPLOYEES WHERE salary >= 5000; 

--ȭ�鿡 ��µǴ� �����͸� ����
SELECT ROWNUM, employee_id, emp_name, salary FROM EMPLOYEES
WHERE ROWNUM <= 10;

--�߰� ���� ���ǿ� �ش��ϴ� �����ʹ� ����� ����(�߿�)
SELECT ROWNUM, employee_id, emp_name, salary FROM EMPLOYEES
WHERE ROWNUM >=6 AND ROWNUM<=10; 



--2) ROWID : ROWID�� ���̺� ����� �� �ο찡 ����� �ּ� ���� ����Ű�� �ǻ��÷��̴�.
-- �� �ο츦 �ĺ��ϴ� ���̹Ƿ� ROWID�� ������ ���� ������.
SELECT ROWNUM,ROWID employee_id, emp_name, salary FROM EMPLOYEES
WHERE ROWNUM <=5;

/*
08 | ������ //NUMBER������ Ÿ�Կ� �ش��ϴ� �÷� �Ǵ� ���� �����Ϳ� ���.
������Operator�� ������ �����Ѵ�. ����Ŭ�� �پ��� �����ڸ� �����ϰ� �ִµ�, �̵��� �����ϸ� ������ ����.

���� ������: +, -, *, /
��+���� ��-���� ���� ����� 1���� ���� �����ڷ� ���� �� ���� ����� ������ ��Ÿ����. ���� �� ���� ����, 
�� ���� �����ڷ� ���� ���� ���� ������ ���� ������ �Ѵ�. �׸��� ��*���� ����, ��/���� ������ ������ �Ѵ�.

���� ������: ||
��||���� �� ���ڸ� ���̴�(�����ϴ�) ������ �����Ѵ�. ���� ������ ��� ���̺��� �����-����� ���·� �����ϴ� SELECT ���̴�.

�Է�

    SELECT employee_id || '-' || emp_name AS employee_info
      FROM employees
     WHERE ROWNUM < 5;
*/

--���̺� ��������
DESC EMPLOYEES;

SELECT employee_id, salary, commission_pct, salary*12+commission_pct AS "����" FROM employees
ORDER BY employee_id;

--���� ��� ����� NULL�� Ȯ�εǴ� ���� �÷������Ͱ� NULL�� �����ϸ�, ����� NULL�� �˴ϴ�.
SELECT 10 + 20 FROM DUAL;

--����� NULL�� �����ϸ� ����� NULL�� �ȴ�. NULL���� ����� NULL���� �Լ��� �н��ؾ� �Ѵ�.
SELECT 10 + 20 + NULL FROM DUAL; -- NULL

/*
�� ������: >, <, >=, <=, =, <>, !=, \^=
�� ������ �����ϴ� �����ڷ� ���п��� ����ϴ� �ε�ȣ�� ���ӻ��� ����. 
��, �� ���� �������� �Ǵ��ϴ� ��ȣ ������(=)�� �ݴ��� �񵿵� �����ڷδ� ��< >��, ��!=��, ��\^=���� �ִµ�, 
�� �� �������� ������ ��ȯ ����� ��� ����. 
���� ���� ���� �� ���� �Ӹ� �ƴ϶� ���ڿ� ��¥���� �� �����ϴ�.
*/

/*
�������� : https://gent.tistory.com/311
09 | ǥ���� 
ǥ����Expression�̶� �� �� �̻��� ���� ������, SQL �Լ� ���� ���յ� ���̴�. 
�� �������� Ư�� ���ǿ� ���� ���� �����ؼ� ���̴� CASE ǥ����(���� CASE���̶�� �Ѵ�)�� ���� �˾� ����.

    CASE WHEN ����1 THEN ��1
         WHEN ����2 THEN ��2
    ...
         ELSE ��Ÿ ��
    END
*/

SELECT employee_id, emp_name, department_id FROM employees ORDER BY department_id;

--[case�� ����]
-- 1) if�� ���� /   department_id�÷��� �����Ͱ� 10���̸� New York, 20���̸� Dallas , ��Ÿ�� Unknown ��ȸ��
SELECT 
        employee_id, emp_name, department_id,
    CASE 
      WHEN department_id = 10 THEN 'New York'
      WHEN department_id = 20 THEN 'Dallas'
      ELSE 'Unknown'
      END AS department_city
FROM 
    employees
ORDER BY department_id ;

-- 2) switch ����
SELECT employee_id, emp_name, department_id,
    CASE department_id
            WHEN 10 THEN 'New York'
            WHEN 20 THEN 'Dallas'
            ELSE 'Unknown'
    END AS department_city
FROM
     employeeS
ORDER BY department_id ;

--ELSE�� ������ ��� ������ �����Ǵ� ���� ������ NULL�� ��ȯ�ȴ�.
SELECT 
        employee_id, emp_name, department_id,
    CASE 
      WHEN department_id = 10 THEN 'New York'
      WHEN department_id = 20 THEN 'Dallas'
--      ELSE 'Unknown'  --''�� NULL�� �ǹ��Ѵ�. �������� ó���ϰ� ������ ' '�� �־��ش�. 
      END AS department_city
FROM 
    employees
ORDER BY department_id ;

--�ó����� : salary(�޿�)�� 15000 �̻��̸� ��׿���, 10000�̻��̸� ������� �������� �Ϲݿ������� ����϶�.
--�����ȣ, �̸�, �޿�, ��������
SELECT 
        employee_id, emp_name, salary,
    CASE 
      WHEN salary >= 15000 THEN '��׿���'
      WHEN salary >= 10000 THEN '�������'
      ELSE '�Ϲݿ���'
      END AS salary_gubun
FROM 
    employees
ORDER BY salary ;


--��ø case�߰� �����۾� ����,
SELECT 
        employee_id, emp_name, department_id,salary,
    CASE 
      WHEN department_id = 10 THEN 
            CASE
                WHEN salary >= 15000 THEN '1���'
                WHEN salary >= 10000 THEN '2���'
                WHEN salary >= 3000 THEN '3���'
            END
      WHEN department_id = 20 THEN
            CASE
                WHEN salary >= 18000 THEN '1���'
                WHEN salary >= 15000 THEN '2���'
                WHEN salary >= 5000 THEN '3���'
            END
     WHEN department_id = 30 THEN 
            CASE
                WHEN salary >= 8000 THEN '1���'
                WHEN salary >= 5000 THEN '2���'
                WHEN salary >= 2000 THEN '3���'
            END
      ELSE ' '
      END AS salary_gubun
FROM 
    employees
ORDER BY department_id ;



/*
�� ���ǽ�
�� ���ǽ��� �� �����ڳ� ANY, SOME, ALL Ű����� ���ϴ� ���ǽ��� ���Ѵ�. 
���⼭�� ANY, SOME, ALL �񱳿� ���ؼ� �˾� ���ٵ� ���� ANY�� ���� ����.
*/
--salary(�޿�)�� 2000 �Ǵ� 3000 �Ǵ� 4000�� ������ // 1)�� 2)�� �����ϴ�.
--1) 
 SELECT employee_id, salary
 FROM employees
 WHERE salary = ANY (2000, 3000, 4000)
 ORDER BY employee_id;

--2)    
 SELECT employee_id, salary
 FROM employees
 WHERE salary = 2000 or salary = 3000 salary = 4000
 ORDER BY employee_id;

--3) salary(�޿�)rk 2000�̰�, 3000�̰�, 4000�� �����͸� ��ȸ�϶� -> ������ ���� ����, ��� ����.
 SELECT employee_id, salary
 FROM employees
 WHERE salary = ALL (2000, 3000, 4000) --�ѹ��� 2000, 3000, 4000�� �����ʹ� �������� �ʴ´�.
 ORDER BY employee_id;

--4)�޿��� 4000���� ū �����͸� ��ȸ
 SELECT employee_id, salary
 FROM employees
 WHERE salary > ALL (2000, 3000, 4000)
 ORDER BY employee_id;

--5) �޿��� 2000���� ū ������, 3000���� ū ������, 4000���� ū �����͸� ��ȸ
--ANY, SOME�� �����ϴ�. 
 SELECT employee_id, salary
 FROM employees
 WHERE salary > ANY (2000, 3000, 4000)
 ORDER BY employee_id;
   
 SELECT employee_id, salary
 FROM employees
 WHERE salary > SOME (2000, 3000, 4000)
 ORDER BY employee_id;
    
    
    
/*
    �� ���ǽ�
�� ���ǽ��� ���������� AND, OR, NOT�� ����ϴ� ���ǽ��� ���Ѵ�. 
AND�� ��� ������ �����ؾ� �ϰ� OR�� ���� ���� �� �ϳ��� �����ص� TRUE�� ��ȯ�ȴ�. 
NOT�� ���ǽ� �� ����� ����(FALSE)�� �� ���ϴ� ���, �� TRUE�� ��ȯ�Ѵ�.   
*/
-- ���� �Ʒ��� ����. �׷��� ǥ���� ���̰� �ִ� ���� : ������ ����, ���� ����� ��Ÿ������ ������ �ٸ� �� �ִ�.
--salary��� �޿� �÷��� ������ �������� ���� ������ �ٸ� �� �ִ�.
 SELECT employee_id, salary
      FROM employees
     WHERE NOT ( salary >= 2500) --salary < 2500�� ����.
     ORDER BY employee_id;

 SELECT employee_id, salary
      FROM employees
     WHERE salary < 2500
     ORDER BY employee_id;
    
 /*
 NULL ���ǽ�
NULL ���ǽ��� Ư�� ���� NULL���� ���θ� üũ�ϴ� ���ǽ��̴�. 
�ռ� UPDATE���� �˾� ���鼭 NULL���� ���δ� IS NULL�� IS NOT NULL�� üũ�Ѵٴ� ������ �н��ߴ�. 
�ٽ� ���������� Ư�� �÷� ���� NULL������ ���θ� üũ�� �� ��ȣ ������(=, < >)�� ����ϸ� ����� ������ ���Ѵ�. 
���� ���, �޿��� NULL���� Ȥ�� �ƴ��� ���θ� üũ�Ϸ��� ��salary = NULL�� Ȥ�� ��salary < > NULL�� ���·� ���ϸ� �� �ǰ� 
��salary IS NULL�� Ȥ�� ��salary IS NOT NULLL�� ���·� ���ؾ� �Ѵ�.
 */   
--���ǽĿ��� ��� �Ǵ� IS NULL, IS NOT NULL
-- commission_pct �÷��� �����Ͱ� NULL
SELECT employee_id, emp_name, salary, commission_pct FROM employees
WHERE commission_pct IS NULL;

--commission_pct �÷��� �����Ͱ� NOT NULL
SELECT employee_id, emp_name, salary, commission_pct FROM employees
WHERE commission_pct IS NOT NULL;


/*
IN ���ǽ�
IN ���ǽ��� �������� ����� ���� ���Ե� ���� ��ȯ�ϴµ� �տ��� ����� ANY�� ����ϴ�.
*/
--�� ������ �޿��� 2000, 3000, 4000�� ���ԵǴ� ����� ������ ���
SELECT employee_id, emp_name, salary FROM employees
WHERE salary IN(2000,3000,4000); --OR�� ��ȯ�� ����

-- �� ������ �޿��� 2000, 3000, 4000�� ���Ե��� �ʴ� ����� ������ ���
-- ������ Ǯ�� ���� ��salary < > 2000 AND salary < > 3000 AND salary < > 4000���̸�, ��< >ALL���ε� �ٲ� �� �� �ִ�.
SELECT employee_id, salary 
FROM employees
WHERE salary NOT IN(2000,3000,4000); 
ORDER BY employee_id;

--EXISTS ���ǽ�: ����(join)���� �ſ�� �� ���Ŀ�

/*
LIKE ���ǽ�
LIKE ���ǽ��� ���ڿ��� ������ �˻��� �� ����ϴ� ���ǽ��̴�. 
*/
--���� ���, ��� ���̺��� ����̸��� ��A���� ���۵Ǵ� ����� ��ȸ�ϴ� ������ �ۼ��Ѵٸ� ������ ���� LIKE ���ǽ��� ����Ѵ�.
   SELECT emp_name
   FROM employees
   WHERE emp_name LIKE 'A%'
   ORDER BY emp_name;

-- �߸� ����� Like�� �����ִ�. '='�� ���� �ȵȴ�.
    SELECT emp_name
    FROM employees
    wHERE emp_name = 'A%'
    ORDER BY emp_name;

--AI�� ���۵Ǵ� ��� ����� ��ȸ�� ������.
   SELECT emp_name
   FROM employees
   WHERE emp_name LIKE 'Al%'
   ORDER BY emp_name;

/*
 ��%���� ��, ��, �߰� ��� �� �� ������ ���ǽ��� �˻��� �� ��ҹ��ڸ� �����Ѵٴ� ���� ��������. 
 ��%���ʹ� �ٸ��� ��_��(����, ������ھ�)�� ������ ���� ��ü�� �ƴ� �� ���ڸ� ���Ѵ�.
*/
CREATE TABLE ex3_5 (
    name VARCHAR2(30)
);

INSERT INTO ex3_5 VALUES('ȫ�浿');
INSERT INTO ex3_5 VALUES('ȫ���');
INSERT INTO ex3_5 VALUES('ȫ���');
INSERT INTO ex3_5 VALUES('ȫ���');
INSERT INTO ex3_5 VALUES('ȫ��');

SELECT*FROM ex3_5;

--ȫ��� �����ϴ� �̸��� ��ȸ�϶�. 
--��� : 'ȫ��'�̶� �α��ڵ� ����ִ�. %�� ���̰� 0���� �ǹ̵� ���� �� ���̴�.
SELECT*FROM ex3_5
WHERE name LIKE 'ȫ��%';

--ȫ��� �����ϴ� ��ü 3���� �̸��� ��ȸ�϶�.
SELECT*FROM ex3_5
WHERE name LIKE 'ȫ��_';


COMMIT;

