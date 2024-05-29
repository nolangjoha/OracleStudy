-------------------24.04.18(��)-----------------------------
/*
������ ����
������ ����HierarchicalQuery �� 2���� ������ ���̺� ����� �����͸� ������ ������ ����� ��ȯ�ϴ� ������ ���Ѵ�.

������ ������
    1)���� ���� ������ ������
    2)���-�븮-����-����� ���� ����, 
    3)�Ǹź�-������ ���� �μ� ����, 
    4)������ �а�, 
���� ��ó ���� ������ ������ ���Ѵ�.
*/
SELECT department_id,

           department_name,
           0 AS PARENT_ID,
           1 as levels,
           parent_id || department_id AS sort
      FROM departments
     WHERE parent_id IS NULL
     UNION ALL
    SELECT t2.department_id,
           LPAD(' ' , 3 * (2-1)) || t2.department_name AS department_name,
           t2.parent_id,
           2 AS levels,
           t2.parent_id || t2.department_id AS sort
      FROM departments t1,
           departments t2
     WHERE t1.parent_id is null
       AND t2.parent_id = t1.department_id
     UNION ALL
    SELECT t3.department_id,
           LPAD(' ' , 3 * (3-1)) || t3.department_name AS department_name,
           t3.parent_id,
           3 as levels,
           t2.parent_id || t3.parent_id || t3.department_id as sort
      FROM departments t1,
           departments t2,
           departments t3
     WHERE t1.parent_id IS NULL
       AND t2.parent_id = t1.department_id
       AND t3.parent_id = t2.department_id
     UNION ALL
    SELECT t4.department_id,
           LPAD(' ' , 3 * (4-1)) || t4.department_name as department_name,
           t4.parent_id,
           4 as levels,
           t2.parent_id || t3.parent_id || t4.parent_id || t4.department_id AS sort
      FROM departments t1,
           departments t2,
           departments t3,
           departments t4
     WHERE t1.parent_id IS NULL
       AND t2.parent_id = t1.department_id
       AND t3.parent_id = t2.department_id
       and t4.parent_id = t3.department_id
     ORDER BY sort;



/*
������ ���� ����
������ ������ ������ ������ ����.

    SELECT expr1, expr2, ...
      FROM ���̺�
     WHERE ����
     START WITH[�ֻ��� ����]
    CONNECT BY [NOCYCLE][PRIOR ������ ���� ����];
*/

--departments(�μ�) ���̺��� ������ ���������� ����϶�.

--�ֻ��� �μ� �ѹ���ȹ�� ������ �����μ��� ����� ����
SELECT department_id, department_name
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id = parent_id;

-- ����/ ����θ� �������� �����μ��� ����϶�.
SELECT department_id, department_name
FROM departments
START WITH department_id =30  -- start with : ����� �� ��� ��������� ������ ���̳�
CONNECT BY PRIOR department_id = parent_id;    --connect by�� ���� �μ��� ����Ѵ�. // -
-- start with�� connect by�� ���� ��� �Ѵ�.

--PRIOR�� ��ġ�� ���� ��� ����� �޶�����.
-- ����/�����(department_id =30)�� �������� �����μ��� ����ض�.
SELECT department_id, department_name
FROM departments
START WITH department_id =30 
CONNECT BY PRIOR department_id = parent_id; -- ������ �Ʒ���(top down).  PRIOR�� �ڽ� �÷��� ����

SELECT department_id, department_name
FROM departments
START WITH department_id =30 
CONNECT BY department_id = PRIOR parent_id; --�Ʒ����� ����(bottom up).  PRIOR�� �θ��÷��� ����

-----
/*
�� ������ ���� ����
������ ������ ������ ������ �°� ������� ��µǴµ� ORDER BY ���� �� ������ ������ �� �ִ�.
*/
--ORDER BY ������ ���� �μ��� ��¼����� ����Ǿ�, ������ ���� ��±����� �� �� ����.
    SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL
    FROM departments
    START WITH parent_id IS NULL
    CONNECT BY PRIOR department_id  = parent_id
    ORDER BY department_name;  

-- ������ ������ ���� ������ ���� �ִ�./ ORDER SIBLINGS BY��� /������ ���� ���� �ο쿡 ���ؼ� ����
    SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL
    FROM departments
    START WITH parent_id IS NULL
    CONNECT BY PRIOR department_id  = parent_id
    ORDER SIBLINGS BY department_name;

/*
�� CONNECT_BY_ROOT
CONNECT_BY_ROOT�� ������ �������� �ֻ��� �ο츦 ��ȯ�ϴ� �����ڴ�. �������̹Ƿ� CONNECT_BY_ROOT �������� ǥ������ �´�.
*/
    SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL,
        CONNECT_BY_ROOT department_name AS root_name
    FROM departments
    START WITH parent_id IS NULL
    CONNECT BY PRIOR department_id  = parent_id;

/*
�� CONNECT_BY_ISLEAF
CONNECT_BY_ISLEAF�� CONNECT BY ���ǿ� ���ǵ� ���迡 ���� �ش� �ο찡 ������ �ڽ� �ο��̸� 1��, �׷��� ������ 0�� ��ȯ�ϴ� �ǻ� �÷��̴�.
 >> �����μ��� ���������� Ȯ���ϴ� ��ɾ�
*/
    SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL, CONNECT_BY_ISLEAF
    FROM departments
    START WITH parent_id IS NULL
    CONNECT BY PRIOR department_id  = parent_id;

/*
�� SYS_CONNECT_BY_PATH (colm, char)
SYS_CONNECT_BY_PATH�� ������ ���������� ����� �� �ִ� �Լ���, 
��Ʈ ��忡�� ������ �ڽ��� ����� ����� ��� ������ ��ȯ�Ѵ�. 
�� �Լ��� ù ��° �Ķ���ͷδ� �÷���, �� ��° �Ķ������ char�� �÷� �� �����ڸ� �ǹ��Ѵ�. 
�׷� �μ��� ���� ��� ������ ������ ����.
*/
    SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL,
           SYS_CONNECT_BY_PATH( department_name, '|')
    FROM departments
    START WITH parent_id IS NULL
    CONNECT BY PRIOR department_id  = parent_id;
    
/*
�÷� ���� ���Ե� ���ڴ� ����� �� ���ٴ� ���� �����ؾ� �Ѵ�. 
�� �������� ����/����δ� ��/�����ڰ� ���� �ִµ�, �����ڷ� ��/���� ����ϸ� ������ ���� ������ �߻��Ѵ�.
*/
    SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL,
           SYS_CONNECT_BY_PATH( department_name, '/')
    FROM departments
    START WITH parent_id IS NULL
    CONNECT BY PRIOR department_id  = parent_id;

/*
�� CONNECT_BY_ISCYCLE
��ġë������ �𸣰����� ����Ŭ�� ������ ������ ����(�ݺ�) �˰����� ����Ѵ�. 
������ ������ ������ ���̺� �ִ� �����Ϳ� ���� �������� ����ǹǷ�, ���������δ� ������ ���� �ڽ� ��带 ã�ư���. 
���� �˰��򿡼� ������ ���� ������ �߸� �ָ� ���ѷ����� Ÿ�� �ȴٴ� ���ε�, 
������ ���������� �θ�-�ڽ� ���� ���踦 �����ϴ� ���� �߸� �ԷµǸ� ���ѷ����� Ÿ�� ������ �߻��Ѵ�.

���� ���, ������(170)�� �θ� �μ��� ����/�����(30)�ε�, ����/������� parent_id ���� ����η� �ٲٸ� 
�� �μ��� ��ȣ ������ �Ǿ� ���ѷ����� �߻��� ���̴�. ���� Ȯ���� ����.

*/
    UPDATE departments
       SET parent_id = 170
     WHERE department_id = 30;

    SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name, LEVEL,
           parent_id
      FROM departments
      START WITH department_id = 30
    CONNECT BY PRIOR department_id  = parent_id;
--  SQL ����: ORA-01436: CONNECT BY�� ������ �߻��Ǿ����ϴ�.

-- �μ��� �����μ� ���� �߸� �ԷµǾ�, �����߻��� �ذ��ϱ� ���� ����
    SELECT department_id, LPAD(' ' , 3 * (LEVEL-1)) || department_name AS depname, LEVEL,
    CONNECT_BY_ISCYCLE IsLoop,
            parent_id
    FROM departments
    START WITH department_id = 30
    CONNECT BY NOCYCLE PRIOR department_id  = parent_id;

ROLLBACK; --����/������� PARENT_ID���� ����η� ������ UPDATE���� ���


-------------------24.04.19(��)-----------------------------
/*
�м� �Լ�AnalyticFunction �� ���̺� �ִ� �ο쿡 ���� Ư�� �׷캰�� ���� ���� ������ �� ���ȴ�. 
���� ���� ���� �� ������ �׷� ������ ����ϴµ�, �̶� GROUP BY ���� ���� ���� ���� ����� �׷캰�� �ο� ���� �پ���.
�̿� ����, ���� �Լ��� ����ϸ� �ο��� �ս� ���̵� �׷캰 ���� ���� ������ �� �� �ִ�. 
�м� �Լ����� ����ϴ� �ο캰 �׷��� ������(window)��� �θ��µ�, 
�̴� ���� �� ����� ���� �ο��� ������ �����ϴ� ������ �Ѵ�.


    �м� �Լ�(�Ű�����) OVER
       ������(PARTITION BY expr1, expr2,...
                  ORDER BY expr3, expr4...
                window ��)
*/
/*
ROW_NUMBER�� ROWNUM �ǻ� �÷��� ����� ����� �ϴµ�, 
��Ƽ������ ���ҵ� �׷캰�� �� �ο쿡 ���� ������ ��ȯ�ϴ� �Լ���. 
��� ���̺��� �μ��� ������� �ο� ���� ����� ����.
*/
    SELECT emp_name, email FROM employees;
    -- ���� 5���� ����ϱ� 
    SELECT emp_name, email FROM employees WHERE ROWNUM <=5;
    -- �߰��������� ����ϴ°� �� �� ����.(ROWNUM�� ���ݶ����� �׷���)
    SELECT emp_name, email FROM employees WHERE ROWNUM >=5 AND ROWNUM <=10;

    --GROUP BY ����. ��� ���̺��� �μ��� ����� �ο���
    SELECT department_id, COUNT(*) FROM employees
    GROUP BY department_id;
    
    -- PARTITION BY : �μ��� ���� �����ͳ��� �з��ϰڴ�. �׸��� emp_name���� �����ϰڴ�.
    -- ROW_NUMBER(): ��ȣ�� �з��Ѵ�.
    SELECT department_id, emp_name,
           ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY emp_name) dep_rows
      FROM employees;

 /*
 RANK �Լ��� ��Ƽ�Ǻ� ������ ��ȯ�Ѵ�. �μ����� �޿� ������ �Ű� ����.
ex) ����, ���� ��
*/
    SELECT department_id, emp_name, 
           salary,
           RANK() OVER  -- 2. 1���� �����͸� �����ޱ�ڴ�. 
           (PARTITION BY department_id  -- 1.�μ����� �����͸� ���ڴ�. �޿��� ������������ �����ϰڴ�. 
                        ORDER BY salary ) dep_rank
      FROM employees;
  
    -- DESC(��������)�߰�
    SELECT department_id, emp_name, 
           salary,
           RANK() OVER  -- 2. 1���� �����͸� �����ޱ�ڴ�. 
           (PARTITION BY department_id  -- 1.�μ����� �����͸� ���ڴ�. �޿��� ������������ �����ϰڴ�. 
                        ORDER BY salary DESC) dep_rank
      FROM employees;

--���� ����� ���� ����
/*
50�� �μ����� ������ �޿��� �޴� ����� ������ ������ ��ȯ�ƴµ�
(2��) �� ���� ������ �� �� �ǳʶپ�(4��) �Ű����ٴ� ���� ��������. 
���� 2���� 3���̶�� ���� ������ 5���� �� ���̴�.
*/
    -- DENSE_RANK �Լ��� RANK�� ��������� ���� ������ ������ ���� ������ �� �� �ǳʶ��� �ʰ� �Ű�����.
    SELECT department_id, emp_name,
           salary,
           DENSE_RANK() OVER (PARTITION BY department_id
                              ORDER BY salary ) dep_rank
      FROM employees;


/*
�м� �Լ��� ���� �о߰� �ſ� ����. 
���� ���, Ư�� ���ǿ� �´� ���� Ȥ�� ���� n���� �����͸� �����ϴ� TOP n ������ ���� �ۼ��� �� �ִ�. 

�ó����� : �� �μ����� �޿��� ���� 3�������� ����� �����ϴ� ������ �ۼ��� ����.

�Է�
*/
            -- �� SELECT���� FROM������ ����Ѵ�.(�ζ��κ�)
            SELECT department_id, emp_name,
                  salary,
                  DENSE_RANK() OVER 
                  (PARTITION BY department_id ORDER BY salary desc) dep_rank
             FROM employees;

    -- �� SELECT���� FROM �ڿ� �ֱ�(�ζ��κ�)
    -- FROM���� �������� : TOPn����
    SELECT *
    FROM ( SELECT department_id, emp_name,
                  salary,
                  DENSE_RANK() OVER (PARTITION BY department_id
                                     ORDER BY salary desc) dep_rank
             FROM employees
         )
    WHERE dep_rank <= 3;

/*���� ���̺� INSERT
���� ���̺� INSERT ������ �� �ϳ��� INSERT �������� ���� ���� INSERT ���� �����ϴ� ȿ���� �� �� ���� �Ӹ� �ƴ϶� 
Ư�� ���ǿ� �´� �����͸� Ư�� ���̺� �Էµǰ� �� �� �ִ� �����̴�.

    INSERT ALL| FIRST
    WHEN ����1 THEN
    ��INTO [��Ű��.]���̺��(�÷�1, �÷�2, ...) VALUES(��1, ��2, ...)
    WHEN ����2 THEN
    ��INTO [��Ű��.]���̺��(�÷�1, �÷�2, ...) VALUES(��1, ��2, ...)
        ...
     ELSE
    �� INTO [��Ű��.]���̺��(�÷�1, �÷�2, ...) VALUES(��1, ��2, ...)
    SELECT ��;
*/

--���� ���� INSERT���� �� ���� ó��

CREATE TABLE ex7_3 (
           emp_id    NUMBER,
           emp_name  VARCHAR2(100));
           
CREATE TABLE ex7_4 (
           emp_id    NUMBER,
           emp_name  VARCHAR2(100));

INSERT INTO ex7_3 VALUES (101, 'ȫ�浿');
INSERT INTO ex7_3 VALUES (102, '������');

-- ����1
INSERT ALL
      INTO ex7_3 VALUES (103, '������')
      INTO ex7_3 VALUES (104, '�����ҹ�')
SELECT * FROM DUAL;

ROLLBACK;

--����2
INSERT ALL
      INTO ex7_3 VALUES (emp_id, emp_name)
    SELECT 103 emp_id, '������' emp_name
      FROM DUAL
     UNION ALL
    SELECT 104 emp_id, '�����ҹ�' emp_name
      FROM DUAL;

--����3 : ���� ���� ���̺� INSERT�� ������ ���� �ִ�. 
 INSERT ALL
      INTO ex7_3 VALUES (105, '������')
      INTO ex7_4 VALUES (105, '������')
    SELECT *
      FROM DUAL;


/*
���ǿ� ���� ���� INSERT
*/
TRUNCATE TABLE ex7_3;
TRUNCATE TABLE ex7_4;


INSERT ALL
      WHEN department_id = 30 THEN
      INTO ex7_3 VALUES (employee_id, emp_name)
      WHEN department_id = 90 THEN
      INTO ex7_4 VALUES (employee_id, emp_name)
    SELECT department_id, employee_id, emp_name FROM  employees;
/*
SELECT department_id, employee_id, emp_name FROM  employees; �� ���� ����� ���Ե����ͷ� ����ϰڴ�.
- department_id = 30 �����Ͱ� 30�̸� ex7_3���̺� ������ ����
- department_id = 90 �����Ͱ� 30�̸� ex7_4���̺� ������ ����

SELECT department_id, employee_id, emp_name FROM  employees;�� �����ͷ� ����ϱ�� �Ͽ�����
ǥ ����� �����͸� ������ ���̺�� ���� �������� �Ѵ�. 
*/
SELECT * FROM ex7_3;  --6��
SELECT * FROM ex7_4;  --3��


 CREATE TABLE ex7_5 (
           emp_id    NUMBER,
           emp_name  VARCHAR2(100));

 INSERT ALL
      WHEN department_id = 30 THEN
        INTO ex7_3 VALUES (employee_id, emp_name)
      WHEN department_id = 90 THEN
        INTO ex7_4 VALUES (employee_id, emp_name)
      ELSE
        INTO ex7_5 VALUES (employee_id, emp_name)
    SELECT department_id, employee_id, emp_name FROM  employees;

SELECT * FROM ex7_3;  -- �μ�30�� ������
SELECT * FROM ex7_4;  -- �μ� 90�� ������
SELECT * FROM ex7_5;  -- �μ� 30, 90 �̿��� ������


TRUNCATE TABLE ex7_3;
TRUNCATE TABLE ex7_4;


--1) 
INSERT ALL
      WHEN employee_id < 116 THEN
        INTO ex7_3 VALUES (employee_id, emp_name)
      WHEN salary < 5000 THEN
        INTO ex7_4 VALUES (employee_id, emp_name)
    SELECT department_id, employee_id, emp_name,  salary
      FROM employees
     WHERE department_id = 30;
/*
<���>
-- ALL�� WHEN ���� �ش��ϴ� ���� ��� �����ͷ� INSERT�Ѵ�. 
-- ex7_3���̺� �� �����Ͱ� ���Ǹ� ������ ex7_4���� ����.
>> emp_id : 115 �� �����Ͱ� ex7_3, ex7_4���̺� ��� INSERT �Ǿ���.
*/
     
     
--2) 115���� �����Ͱ� WHEN employee_id < 116 THEN ���� TRUE�� �Ǿ� ex7_3�����Ͱ� ���Եǰ�,
-- WHEN salary < 5000 THEN �������� 115�� �����Ͱ� �����Ǵ��� ���Ե��� �ʴ´�.
INSERT FIRST
      WHEN employee_id < 116 THEN
        INTO ex7_3 VALUES (employee_id, emp_name)
      WHEN  salary < 5000 THEN  
        INTO ex7_4 VALUES (employee_id, emp_name)
    SELECT department_id, employee_id, emp_name,  salary
      FROM employees
     WHERE department_id = 30;
/*
<���>
-- FIRST�� ALL���� �ٸ��� ù��° WHEN������ �����Ͱ� INSERT �ǰ� 
   �ش� �������� �ι�° WHEN�� ���ǿ� �´� �����Ͱ� �ִ���
   �̹� ù���� WHEN������ INSERT �Ǿ��� ������ �ι�° WHEN������ ���� �ʴ´�.
>> emp_id : 115 �� �����Ͱ� ex7_3���̺��� INSERT �Ǿ���.
*/


SELECT * FROM ex7_3;  
SELECT * FROM ex7_4;


