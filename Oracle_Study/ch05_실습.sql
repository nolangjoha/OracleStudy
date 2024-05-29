/*�⺻���� �Լ�
 �����Լ��� ��� �����͸� Ư�� �׷����� ���� ���� �� �׷쿡 ���� ����, ���, �ִ�, �ּڰ� ���� ���ϴ� �Լ��� ���Ѵ�. 
*/
/*
�� COUNT (expr)
COUNT�� ���� ��� �Ǽ�, �� ��ü �ο� ���� ��ȯ�ϴ� ���� �Լ���. ���̺� ��ü �ο�� ���� WHERE �������� �ɷ��� �ο� ���� ��ȯ�Ѵ�.
COUNT �Լ��� �Ű������� ������ expr�� NULL�� �ƴ� �ǿ� ���ؼ��� �ο��� ���� ��ȯ�Ѵ�
*/

--������̺��� ������ ���
SELECT COUNT(*) FROM employees; --107��

--�μ����̺��� ������ ���
SELECT COUNT(*) FROM departments;  --27��

--* ��� �÷����� ����� ���� �ִ�.
SELECT COUNT(employee_id)FROM employees;-- 107��
SELECT COUNT(department_id)FROM employees;--106��  -- department_id ������ �� null������ 1���� ���ܡڡڡ�

--�ߺ������� ����. ������̺� �����ϴ� �μ��ڵ��� ���� Ȯ��
SELECT DISTINCT department_id FROM employees ORDER BY 1;

SELECT COUNT(DISTINCT department_id) FROM employees ORDER BY 1; --11��


/*
�� SUM(expr)
SUM�� expr�� ��ü �հ踦 ��ȯ�ϴ� �Լ��� �Ű����� expr���� �������� �� �� �ִ�.
��� ���̺��� �޿��� �������̹Ƿ� �� ����� �޿� �Ѿ��� ���� ����.
*/
-- �� �޿����� ��ȸ.
SELECT SUM(salary)FROM employees;

/*
SUM �Լ� ���� expr �տ� DISTINCT�� �� �� �ִµ�, �̶� ���� �ߺ��� �޿��� 1���� ������ ��ü �հ踦 ��ȯ�Ѵ�.
*/
SELECT SUM(salary), SUM(DISTINCT salary)FROM employees;


/*
�� AVG(expr)
AVG�� �Ű����� ���³� ���ӻ��� COUNT, SUM�� �����ϸ� ��հ��� ��ȯ�Ѵ�.
*/
-- �޿��� ���� ���
SELECT AVG(salary), AVG(DISTINCT salary)FROM employees;

/*
�� MIN(expr), MAX(expr)
MIN�� MAX�� ���� �ּڰ��� �ִ��� ��ȯ�Ѵ�.
*/
-- �޿��߿� ���� ���� �ݾ�, ���� ū �ݾ� ���
SELECT MIN(salary), MAX( salary)FROM employees;

-- DISTINCT�� �ߺ����� �������ִ� ���̱� ������ ���⼭�� �ǹ̰� ����.
SELECT MIN(DISTINCT salary), MAX(DISTINCT salary)FROM employees;


/*
�� VARIANCE(expr), STDDEV(expr)
VARIANCE�� �л���, STDDEV�� ǥ�������� ���� ��ȯ�Ѵ�. 
�л��̶� �־��� ������ ���� ���� ��հ����� ������ ������ ���� �̸� �����ؼ� ����� ���� ���ϸ�, 
ǥ�������� �л� ���� �������̴�. �л��� ������ ����̹Ƿ�, 
������ ��迡���� ����� �߽����� ������ ��� ���� �����ϴ����� ��Ÿ���� ��ġ�� ǥ�������� ��ǥ�� ����Ѵ�.
*/
--�޿��� �л� �� ǥ������
SELECT VARIANCE(salary), STDDEV(salary)FROM employees;


/*
02 | GROUP BY ���� HAVING ��
���ݱ��� �˾ƺ� ���� �Լ��� ������ ��� ��� ��ü�� �������� �����͸� �����ߴµ�, 
��ü�� �ƴ� Ư�� �׷����� ���� �����͸� ������ ���� �ִ�. �̶� ���Ǵ� ������ �ٷ� GROUP BY ���̴�. 
�׷����� ���� �÷����̳� ǥ������ GROUP BY ���� ����ؼ� ����ϸ� GROUP BY ������ WHERE�� ORDER BY�� ���̿� ��ġ�Ѵ�.
*/
--�� �μ��� �� �޿����� ��ȸ����. 
-- ��GROUP BY�� ����ϸ� SELECT���� �÷����� ���������� ���(GROUP BY�� ��� �� �÷���, �����Լ� ��)�ؾ� �Ѵ�. 
SELECT department_id, SUM(salary)FROM employees
GROUP BY department_id
ORDER BY department_id;

SELECT department_id,COUNT(*) AS "�μ��ο�", SUM(salary) AS "�ѱ޿���", AVG(salary) AS "��ձ޿�" FROM employees
GROUP BY department_id
ORDER BY department_id;

--�ѱ� ������� ��ȸ
SELECT * FROM kor_loan_status;

/*
kor_loan_status ���̺��� ����, ������ ������� �ܾ�(������ �ʾ�)�� ��� �ְ�, 
��������(gubun)�� �����ô㺸���⡯�� ����Ÿ���⡯ �� ������ �����Ѵ�. 

�׷� 2013�� ������ ������� �� �ܾ��� ���� ����.
*/               -- ',' �� Ȯ������
SELECT period, region, SUM(loan_jan_amt) totl_jan FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY period, region;

--HAVING ���� GROUP BY�� ������ ��ġ�� GROUP BY�� ����� ������� �ٽ� ���͸� �Ŵ� ������ �����Ѵ�. 
--�� HAVING ���� ���� ���·� ����Ѵ�. ���� ���, �� ���� ������� �����ܾ��� 100�� �̻��� �Ǹ� �����Ѵٸ� 
--������ ���� ������ �ۼ��ϸ� �ȴ�.
SELECT period, region, SUM(loan_jan_amt) totl_jan FROM kor_loan_status
     WHERE period = '201311'
     GROUP BY period, region
     HAVING SUM(loan_jan_amt) > 100000;

--employees(���)���̺� ����
--1. �� �μ��� �ִ� �޿�, �ּұ޿�, ��� �޿��� ���϶�.
SELECT department_id, MAX(salary), MIN(salary), AVG(salary)
FROM employees 
GROUP BY department_id;  -- ������ �μ��ڵ带 �׷�ȭ
-- �� ���� ������ �ְ� ����
SELECT department_id AS "�μ���ȣ", MAX(salary)AS "�ִ�޿�", MIN(salary) AS "�ּұ޿�", ROUND(AVG(salary),1) AS "��ձ޿�"
FROM employees 
GROUP BY department_id  -- ������ �μ��ڵ带 �׷�ȭ
ORDER BY department_id;

-- �������������͸� ��ձ޿��� ������������ ��ȸ�϶�.
SELECT department_id AS "�μ���ȣ", MAX(salary)AS "�ִ�޿�", MIN(salary) AS "�ּұ޿�", ROUND(AVG(salary),1) AS "��ձ޿�"
FROM employees 
GROUP BY department_id  -- ������ �μ��ڵ带 �׷�ȭ
ORDER BY ROUND(AVG(salary),1);

-- �������������͸� ��ձ޿��� ���������� ��Ī��� ��ȸ�϶�.
SELECT department_id AS "�μ���ȣ", MAX(salary)AS "�ִ�޿�", MIN(salary) AS "�ּұ޿�", ROUND(AVG(salary),1) AS "��ձ޿�"
FROM employees 
GROUP BY department_id  -- ������ �μ��ڵ带 �׷�ȭ
ORDER BY "��ձ޿�";

--�ó�����: employees ���̺��� ��å��(jon_Id)������, �ִ�޿�, �ּұ޿�, ��ձ޿��� �Ҽ��� ù°�ڸ� ���� ���϶�.
SELECT job_id AS "��å", COUNT(*)AS "������", MAX(salary)AS "�ִ�޿�", MIN(salary) AS "�ּұ޿�", ROUND(AVG(salary),1) AS "��ձ޿�"
FROM employees 
GROUP BY job_id  -- ������ �μ��ڵ带 �׷�ȭ
ORDER BY "��ձ޿�";
--�� ���̺��� 10�� �ʰ��� ��å
SELECT job_id AS "��å", COUNT(*)AS "������", MAX(salary)AS "�ִ�޿�", MIN(salary) AS "�ּұ޿�", ROUND(AVG(salary),1) AS "��ձ޿�"
FROM employees 
GROUP BY job_id  -- ������ �μ��ڵ带 �׷�ȭ
HAVING COUNT (*) > 10
ORDER BY "��ձ޿�";


/* <ROLLUP ������ ����, CUBE : �������� ����>
ROLLUP(expr1, expr2, ��)
ROLLUP�� expr�� ����� ǥ������ �������� ������ ���, �� �߰����� ���� ������ ���� �ش�. 
ROLLUP ���� ����� �� �ִ� ǥ���Ŀ��� �׷��� ���, 
�� SELECT ����Ʈ���� ���� �Լ��� ������ �÷� ���� ǥ������ �� �� ������, 
����� ǥ���� ���� ����(�����ʿ��� ���� ������)�� ���� �������� ������ ����� ��ȯ�ȴ�. 
ǥ���� ������ n���̸� n+1 ��������, ���� �������� ���� ���� ������ �����Ͱ� ����ȴ�.
*/
-- ��GROUP BY ���� ���ִ� �� ���� ū ���� ���ִ�.

--�� ������ 2013�⵵ �Ⱓ(period) ���� ������(gubun) �� �ܾ��� ���� ���̴�.
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
     FROM kor_loan_status
     WHERE period LIKE '2013%'
     GROUP BY period, gubun
     ORDER BY period;

-- 2013�� 10�� �߰��հ�
-- 2013�� 11�� �߰��հ�
-- ��ü�հ�

--GROUP BY ROLLUP(period, gubun); �÷��� +1 / 3���� ���·� ������ ��ȸ
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
      FROM kor_loan_status
     WHERE period LIKE '2013%'
     GROUP BY ROLLUP(period, gubun); -- �������� 2���̹Ƿ� 3���� ���� �����Ͽ� �����ش�.

/*
    PERIOD   GUBUN                 TOTL_JAN
    -------- -------------------- -----------------------
    201310   ��Ÿ����              676078         ���
    201310   ���ô㺸����          411415.9        ���
    201310                         1087493.9    ���
    201311   ��Ÿ����              681121.3       ���
    201311   ���ô㺸����          414236.9        ���
    201311                         1095358.2    ���
                                   2182852.1    ���
����3: �Ұ�     / GROUP BY�� ���
����2: �߰����  / 
����1: ��ü���

*/


--GROUP BY period, ROLLUP( gubun ) : ROLLUP �÷��� 1�� +1 = 2���� ���� ������ ���
--����2(period, gubun),����1(perido) �̷� ���°� ��µȴ�.
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
      FROM kor_loan_status
     WHERE period LIKE '2013%'
     GROUP BY period, ROLLUP( gubun );
/*
    PERIOD   GUBUN                 TOTL_JAN
    -------- -------------------- -----------------------
    201310   ��Ÿ����                 676078         ��2
    201310   ���ô㺸����            411415.9        ��2
    201310                        1087493.9    ��1
    201311   ��Ÿ����                681121.3       ��2
    201311   ���ô㺸����             414236.9        ��2
    201311                        1095358.2    ��1
    
    (period, gubun), (period)
*/


/*
ROLLUP�� �� �ٸ� �������� ����� �� �ִµ� ���� ���, GROUP BY expr1, ROLLUP(expr2, expr3)�� ����ߴٸ�, 
������ ��2+1=3�������� ������ ����� (expr1, expr2, expr3), (expr1, expr2), (expr1)���� ���谡 �ǰ� 
��ü �հ�� ������� �ʴ´�. �̷� ������ ����(partial) ROLLUP�̶�� �Ѵ�.
*/

/*
 GROUP BY ROLLUP(expr1, expr2, expr3)�� ����ߴٸ�,
 �÷��� 3+1 = 4 ��ü 4������ ���
 (expr1, expr2, expr3), (expr1, expr2), (expr1), ��ü �հ� 
 ��������>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>ū����
*/

/*
GROUP BY expr1, ROLLUP (expr2)
������ 1+1=2 ����2���·� ���
(expr1, expr2), (expr1)
*/



/*
CUBE(expr1, expr2, ��)
CUBE�� ROLLUP�� ����ϳ� ������ �ణ �ٸ���. 
ROLLUP�� �������� ������ ���踦 �ߴٸ�, CUBE�� ����� ǥ���� ������ ���� ������ ��� ���պ��� ������ ����� ��ȯ�Ѵ�. 
CUBE�� 2��(expr ��)���� ��ŭ �������� ���� �ȴ�. 
���� ���, expr ���� 3�̸�, ���� ����� ������ �� 2^3^ = 8���� �ȴ�.
*/

SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY CUBE(period, gubun) ;
/*GROUP BY ������ ��������� ��ü�հ谡 ��µȴ�.
--2�� CUBE �÷��� ��= 4���� ���� / 
PERIOD GUBUN                            TOTL_JAN
------ ------------------------------ ----------
                                       2182852.1   ����1(��ü�հ�)
       ��Ÿ����                        1357199.3     ����2
       ���ô㺸����                     825652.8      ����2
201310                                 1087493.9   ����3
201310 ��Ÿ����                           676078     ����4
201310 ���ô㺸����                     411415.9      ����4
201311                                 1095358.2    ����3
201311 ��Ÿ����                         681121.3      ����4
201311 ���ô㺸����                     414236.9      ����4
*/

SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY ROLLUP(period, gubun) ;  -- �÷��� 2+1= 3���� (period, gubun), (period) (��ü�հ�)
--GROUP BY CUBE(period, gubun)  --2�� �÷����� �� = 4���� (period, gubun), (period), (gubun), (��ü�հ�)


/*
GROUP BY expr1, CUBE(expr2, expr3)�� ������� ��,   
-- 2�� �÷��� �÷����� ��(2��) = 4���� ������ ���´�. �̶� GROUP BY �ڿ� expr1�� �־ �ֻ��� ������ (expr1)�̴�. 
������ ��ü�հ谡 �ֻ��� ������.--
(expr1, expr2, expr3), (expr1, expr2), (expr1, expr3), (expr1) 
�� 4����(2^2^) �������� ����ȴ�.
*/
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
      FROM kor_loan_status
     WHERE period LIKE '2013%'
     GROUP BY period, CUBE( gubun );
     
/*
PERIOD GUBUN                            TOTL_JAN
------ ------------------------------ ----------
201310                                 1087493.9  (period)
201310 ��Ÿ����                           676078    (period, gubun)
201310 ���ô㺸����                     411415.9     (period, gubun)
201311                                 1095358.2   (period)
201311 ��Ÿ����                         681121.3     (period, gubun)
201311 ���ô㺸����                     414236.9     (period, gubun)
*/
     
     
/*
����(Set)�̶�� �θ��⵵ �Ѵ�. ����(Set) �����ڴ� �̷��� ������ ������ ������� ������ �����ϴ� �����ڸ� ���ϸ�, 
�� �����δ� UNION, UNION ALL, INTERSECT, MINUS�� �ִ�.
*/

CREATE TABLE exp_goods_asia (
           country VARCHAR2(10),
           seq     NUMBER,
           goods   VARCHAR2(80));

    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 1, '�������� ������');
    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 2, '�ڵ���');
    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 3, '��������ȸ��');
    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 4, '����');
    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 5,  'LCD');
    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 6,  '�ڵ�����ǰ');
    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 7,  '�޴���ȭ');
    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 8,  'ȯ��źȭ����');
    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 9,  '�����۽ű� ���÷��� �μ�ǰ');
    INSERT INTO exp_goods_asia VALUES ('�ѱ�', 10,  'ö �Ǵ� ���ձݰ�');

    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 1, '�ڵ���');
    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 2, '�ڵ�����ǰ');
    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 3, '��������ȸ��');
    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 4, '����');
    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 5, '�ݵ�ü������');
    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 6, 'ȭ����');
    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 7, '�������� ������');
    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 8, '�Ǽ����');
    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 9, '���̿���, Ʈ��������');
    INSERT INTO exp_goods_asia VALUES ('�Ϻ�', 10, '����');

COMMIT;

SELECT * FROM exp_goods_asia;

/*
UNION
UNON�� �������� �ǹ��Ѵ�. 
���� ���, �� ���� ������ ������ ������ �� ���� ����(SELECT ���)�� ��� ������ ����� ��ȯ�ȴ�. 
��UNON ��ɾ�� GOODS�÷��� �ߺ��� ����ǰ���� �ϳ��� ���Խ��� ������ش�.(�ߺ��˻�) 
*/ 

    --�ѱ� ����ǰ�� ��ȸ         --10��
    SELECT goods FROM exp_goods_asia
     WHERE country = '�ѱ�'
     ORDER BY seq;
     
    --�Ϻ� ����ǰ�� ��ȸ          --10��
    SELECT goods FROM exp_goods_asia
     WHERE country = '�Ϻ�'
     ORDER BY seq;

    --���� 2�� ������ �ϳ��� ���ļ� ���      --15�� : �ߺ�����
    SELECT goods FROM exp_goods_asia
    WHERE country = '�ѱ�'
        UNION  --�ߺ��˻� 
    SELECT goods FROM exp_goods_asia
    WHERE country = '�Ϻ�';

    -- �ߺ����� �ٺ��� ������            --20�� : �ߺ�����
    SELECT goods FROM exp_goods_asia
    WHERE country = '�ѱ�'
        UNION ALL  -- �ٺ�����.
    SELECT goods FROM exp_goods_asia
    WHERE country = '�Ϻ�';


/*
INTERSECT
INTERSECT�� �������� �ƴ� �������� �ǹ��Ѵ�. �� ������ ���տ��� ����� �׸� ������ ����.
*/
    SELECT goods
    FROM exp_goods_asia
    WHERE country = '�ѱ�'
        INTERSECT  --������
    SELECT goods
    FROM exp_goods_asia
    WHERE country = '�Ϻ�';


/*
MINUS
MINUS�� �������� �ǹ��Ѵ�. 
�� �� ������ ������ �������� �ٸ� ������ ���հ� ����� �׸��� ������ ����� ������ ����.
*/
    -- �ѱ��� �����ϴ� ǰ�� ��ȸ
    SELECT goods
    FROM exp_goods_asia
    WHERE country = '�ѱ�'
         MINUS  --������
    SELECT goods
    FROM exp_goods_asia
    WHERE country = '�Ϻ�';

    --�Ϻ��� �����ϴ� ǰ�� ��ȸ
    SELECT goods
    FROM exp_goods_asia
    WHERE country = '�Ϻ�'
         MINUS  --������
    SELECT goods
    FROM exp_goods_asia
    WHERE country = '�ѱ�';


/* ���� �������� ���ѻ���
�� ���� �����ڷ� ����Ǵ� �� SELECT���� SELECT ����Ʈ�� ������ ������
Ÿ���� ��ġ�ؾ� �Ѵ�

*/
/*  --- ���� : �÷� ���� ��ġ���� ����./ �÷����� �����ؾ� ���� ���� ��.

    SELECT goods   --�÷� 1��
    FROM exp_goods_asia
    WHERE country = '�ѱ�'
         UNION
    SELECT seq, goods   --�÷�2��
    FROM exp_goods_asia
    WHERE country = '�Ϻ�';
*/
    -- �÷��� ��ġ ���״��� ���� ����.
    SELECT seq,goods   --�÷� ��
    FROM exp_goods_asia
    WHERE country = '�ѱ�'
         UNION
    SELECT seq, goods   --�÷�2��
    FROM exp_goods_asia
    WHERE country = '�Ϻ�';

/*  --���� : �÷��� ������ Ÿ���� �ٸ���.
    SELECT seq             -- ���� �÷� 1��
    FROM exp_goods_asia
    WHERE country = '�ѱ�'
         UNION
    SELECT goods           -- ���� �÷�1��
    FROM exp_goods_asia
    WHERE country = '�Ϻ�';

*/

/*
�� ���� �����ڷ� SELECT ���� ������ �� ORDER BY���� �� ������ ���忡���� ����� �� �ִ�
*/
     SELECT goods
     FROM exp_goods_asia
     WHERE country = '�ѱ�'
        ORDER BY goods  -- �߰��� ORDER BY�� ����ϸ� ���� �߻�.
     UNION
     SELECT goods
     FROM exp_goods_asia
     WHERE country = '�Ϻ�';

-- ���� ������ �����ϸ� ������ ����.
     SELECT goods
     FROM exp_goods_asia
     WHERE country = '�ѱ�'
     UNION
     SELECT goods
     FROM exp_goods_asia
     WHERE country = '�Ϻ�'
          ORDER BY goods;  -- ORDER BY ���� ������ �������� �ʴ�. 
                           -- ��ü�� ���� ���(������ ���)�� �����ϴ� �ǹ̷� ��� �ȴ�. 


/*
�� BLOB, CLOB, BFILE Ÿ���� �÷��� ���ؼ��� ���� �����ڸ� ����� �� ����
�� UNION, INTERSECT, MINUS �����ڴ� LONG�� �÷����� ����� �� ����
*/

/*
GROUPING SETS ��
GROUPING SETS�� ROLLUP�̳� CUBEó�� GROUP BY ���� ����ؼ� �׷� ������ ���Ǵ� ���̴�.
�� �� �� �������� �Ұ��ϴ� ������ GROUPING SETS ���� �׷� �����̱� �ϳ� UNION ALL ������ ���� �ֱ� �����̴�. 
���� ���, GROUPING SETS (expr1, expr2, expr3)�� GROUP BY ���� ������� ��, 
��ȣ �ȿ� �ִ� �� ǥ���ĺ��� ���� ���谡 �̷������. 

�� ���� ����� ((GROUP BY expr1) UNION ALL (GROUP BY expr2) UNION ALL (GROUP BY expr3)) ���°� �ȴ�.
*/
    SELECT period, gubun, SUM(loan_jan_amt) totl_jan
    FROM kor_loan_status
    WHERE period LIKE '2013%'
    GROUP BY GROUPING SETS(period, gubun);  -- ((GROUP BY (period) UNION ALL (GROUP BY(gubun)) �� ���� ��.


     SELECT period, gubun, region, SUM(loan_jan_amt) totl_jan
     FROM kor_loan_status
     WHERE period LIKE '2013%'
     AND region IN ('����', '���')
     GROUP BY GROUPING SETS(period, (gubun, region));  -- ((GROUP BY (period) UNION ALL (GROUP BY gubun, region) �� ���� ��.












