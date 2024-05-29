-------------------------24.04.15(��)--------------
-- [����] 
-- ���� : 2���� ���̺��� �÷����� �����͸� ���Ͽ�, ������ ���������� ���������� �����ϴ� ���.
/*
ǥ�� : ����Ŭ ���ΰ� ANSI����

������ ��������(INNER JOIN)�� �ܺ�����(OUTER JOIN)���� �����Ѵ�.
- ��������(INNER JOIN): �Ϲ����� ������ ����ϸ�, INNER JOIN.
  : �÷����� �񱳽� ��ġ�Ǵ� �����͸� ���������� ����.

- �ܺ����� (OUTER JOIN): inner join�� ����� ��ġ���� �ʴ� �����͵� ���ԵǴ� �ǹ�.
  1) LEFT OUTER JOIN
  2) RIGHT OUTER JOIN
  3) FULL OUTER JOIN
*/
--����? �����ȣ, �̸�, �μ����� ��ȸ�϶�.
/*
������̺� : �����ȣ, �̸�
�μ����̺� : �μ���
-> ���Ƿ� ���� �ϳ��� ����� ����ϰ��� �Ѵ�. 
*/
/* ����
SELECT �����ȣ, �̸�, �μ���
FROM ������̺�, �μ����̺�
WHERE ������̺�.�����ڵ� = �μ��� ���̺�.�μ��ڵ�;
*/
--------------------- ��������(INNER JOIN)-����--------------------
-- * : employees, departments���̺��� ��� �÷�
SELECT *
FROM employees, departments
WHERE employees.department_id = departments.department_id;

SELECT employee_id, emp_name, department_name  --2. ��׸� ã�Ƽ�
FROM employees, departments  --1. ���� ���̺���
WHERE employees.department_id = departments.department_id;  --3. �̷��� ������

-- ���̺� ��Ī�� ����Ͽ� INNER JOIN�ϴ� ����
SELECT a.employee_id, a.emp_name, b.department_name    --2. ���ϴ� �÷� ��Ī���� �����ؼ� �ۼ�
FROM employees a, departments b             --1. ���⼭ ���� ��Ī �����ֱ�(��Ī�� �������)
WHERE a.department_id = b.department_id;    -- 3. ���ϴ� ��� ��Ī �����ؼ� �ۼ�.

-- ù ������ ������ �ó������� "ANSI JOIN(INNER JOIN)"�� �ۼ��ϱ�.
SELECT employee_id, emp_name, department_name  
FROM employees INNER JOIN departments             -- ',' ��� INNER JOIN �ۼ�
ON employees.department_id = departments.department_id;    -- WHERE ��� ON �ۼ�

-- ANSI JOINT�� ����� ù������ "��Ī"�� ����ؼ� ǥ���غ���
SELECT e.employee_id, e.emp_name, d.department_name  
FROM employees e INNER JOIN departments d             -- ',' ��� INNER JOIN �ۼ�
ON e.department_id = d.department_id;    -- WHERE ��� ON �ۼ�

----------------------------�ó�����---------------------------------------
-- �ó����� EMP���̺�� DEPT���̺��� �����Ͽ�, �����͸� ����϶�.
SELECT e_id, e_name, d_name
FROM emp,dept
WHERE emp.d_code = dept.d_code;

-- �� �ó����� �� �����ȣ�� 1001���� ����� �ҷ�����
SELECT e_id, e_name, d_name
FROM emp,dept
WHERE emp.d_code = dept.d_code
AND emp.e_id = 1001;

-- �ι�° ������ ������ �ó������� ANSI JOIN(INNER JOIN)�� �ۼ��ϱ�.
SELECT e_id, e_name, d_name
FROM emp INNER JOIN dept
ON emp.d_code = dept.d_code;

SELECT e_id, e_name, d_name
FROM emp INNER JOIN dept       -- ','�� INNER JOIN���� �ۼ�
ON emp.d_code = dept.d_code    -- WHERE�� ON���� �ۼ�
WHERE emp.e_id = 1001;         --AND�� WHERE�� �ۼ�


--------���̺� 3�� ����---------
SELECT *
FROM employees, departments, job_history
WHERE employees.department_id = departments.department_id
AND departments.department_id = job_history.department_id;

-- �� ������ ANSI�������� 
SELECT *
FROM employees INNER JOIN departments
ON employees.department_id = departments.department_id
INNER JOIN job_history
ON departments.department_id = job_history.department_id;

--FULL OUTER JOIN
CREATE TABLE HONG_A  (EMP_ID INT);
CREATE TABLE HONG_B  (EMP_ID INT);

INSERT INTO HONG_A VALUES ( 10);
INSERT INTO HONG_A VALUES ( 20);
INSERT INTO HONG_A VALUES ( 40);

INSERT INTO HONG_B VALUES ( 10);
INSERT INTO HONG_B VALUES ( 20);
INSERT INTO HONG_B VALUES ( 30);

COMMIT;

SELECT * FROM HONG_A;
SELECT * FROM HONG_B;

--FULL OUTER JOIN
SELECT *
FROM HONG_A FULL OUTER JOIN HONG_B
ON hong_a.emp_id = hong_b.emp_id;



/*
�ܺ�����(OUTER JOIN)
*/
-- �� �Ϲ� ����
    --��ġ�Ǵ� �����͸� �������� �������� ��� 
    SELECT a.department_id, a.department_name, b.job_id, b.department_id
      FROM departments a,
           job_history b
     WHERE a.department_id = b.department_id;
-- ��ġ�Ǵ� ��������� ��ġ���� �ʴ� �����͵� �����Ͽ� ���. 
-- ��, job_history ���̺��� �μ���ȣ ���� �������� ������ �����. ���� job_hisotry�� ���� �μ��� ��ȸ���� �ʾҴ�. 

-- �� �ܺ� ����
    -- departments ���̺� : ��� �μ����� / job_history ���̺� : �μ��� ���� ������Ʈ ������ ����. (+) ǥ��  
    -- 1)LEFT OUTER JOIN /(31��)
    SELECT a.department_id, a.department_name, b.job_id, b.department_id
    FROM departments a, job_history b
    WHERE a.department_id = b.department_id (+) ;   -- b�� �������� �ʰ� a�� �ִ� �����͵� ���Խ��� ����ض�.
    -- b���̺��� a���̺��� �����Ͱ� ����. (+)�� �����Ͱ� �� ���� ���̺� ���δ�. ????????????????
    --�׸��� �����ͼ��� �� ���� ���̺��� ��ġ�� ���� left, right���̺� ��Ī�� �ٲ��. ??????????????

    -- 2)RIGHT OUTER JOIN /(31��)
    SELECT a.department_id, a.department_name, b.job_id, b.department_id
    FROM job_history b, departments a               -- �ڸ� �ٲٱ�
    WHERE b.department_id (+) = a.department_id;    -- �ڸ��ٲٱ�
     
    -- 1)�� 2)�� ������ ����� ����Ѵ�.

    --3) LEFT OUTER JOIN /(10��)
    -- job_history ���̺� ��ġ���� �ʴ� �μ��� �������� �ʴ´�.
    SELECT a.department_id, a.department_name, b.job_id, b.department_id
    FROM job_history b, departments a              
    WHERE b.department_id = a.department_id(+); --(+)�� �����Ͱ� �� �����ʿ� ���̸� �ǹ̰� ����.
    
    --4) INNER JOIN /(10��)
    SELECT a.department_id, a.department_name, b.job_id, b.department_id
    FROM job_history b, departments a              
    WHERE b.department_id = a.department_id;
    
    -- 3)�� 4)�� ������ ����� ����Ѵ�. / job_history�� departments�� �κ����մϴ�.
-------------------------24.04.16(ȭ)-------------------------    

    --5) FULL OUTER JOIN / ����Ŭ������ FUPP OUTER JOIN�� �������� �ʴ´�. �ϰ������ ANSI JOIN���� �ۼ��ؾ��Ѵ�.
    SELECT a.department_id, a.department_name, b.job_id, b.department_id
    FROM job_history b, departments a              
    WHERE b.department_id(+) = a.department_id(+);

-- ANSI JOIN(OUTER JOIN)���� ��ȯ�۾�
-- LETR OUTER JOIN
    SELECT a.department_id, a.department_name, b.job_id, b.department_id
    FROM departments a LEFT OUTER JOIN job_history b
    ON a.department_id = b.department_id;

-- RIGHT OUTER JOIN
    SELECT a.department_id, a.department_name, b.job_id, b.department_id
    FROM job_history b RIGHT OUTER JOIN  departments a 
    ON b.department_id = a.department_id;

-- FULL OUTER JOIN /���ʿ� ���Ե��� �ʴ� ������, �����ʿ��� ���Ե��� �ʴµ����� ��� �̰� ������ ���, �׷��� ���� �� ����ϸ� ȿ�� ������
    SELECT a.department_id, a.department_name, b.job_id, b.department_id
    FROM job_history b FULL OUTER JOIN  departments a  
    ON b.department_id = a.department_id;



/*
���� ����
������ ������ �� �� �ֵ���, ���� ����(SELF-JOIN)�� ���� �ٸ� �� ���̺��� �ƴ� ������ �� ���̺��� ����� �����ϴ� ����� ���Ѵ�.
*/
    SELECT a.employee_id, a.emp_name, b.employee_id, b.emp_name, a.department_id
    FROM employees a,employees b  -- ���� ���̺��ε� ��Ī�� �ٸ��� �־���. �޸� �󿡼��� ������ ������ �ٸ��Ժ���..?
    WHERE a.employee_id < b.employee_id -- �����ȣ ��Һ� ó�� �ؼ� ���������� ���
    AND a.department_id = b.department_id
    AND a.department_id = 20;

    -- ������̺��� �μ��ڵ尡 20�� ����� ����϶�.
    SELECT employee_id, emp_name, department_id
    FROM employees -- 
    WHERE department_id = 20; -- ����)�μ��ڵ� 20

/*
īŸ�þ� ����  //�� ANSI JOIN�� CROSS JOIN�� �����ϴ�.
īŸ�þ� ����(CATASIAN PRODUCT)�� WHERE ���� ���� ������ ���� ������ ���Ѵ�. 
�� FROM ���� ���̺��� ���������, �� ���̺� �� ���� ������ ���� �����̴�.
// ���������� �� ���� ����Ѵٰ� �Ѵ�.

���� ������ �����Ƿ� �� ����� �� ���̺� �Ǽ��� ���̴�. 
�� A ���̺� �Ǽ��� n1, B ���̺� �Ǽ��� n2��� �Ѵٸ�, ��� �Ǽ��� ��n1 * n2���� �ȴ�.
*/
-- WHERE�� : �������ǽ��� ����.
/*
1   A
2   B
3   C   
4   D
>> 1-A, 1-B, 1-C, 1-D/ 2-A,2-B,2-C,2-D~~/ : �� 16���� �����Ͱ� ���������.
*/
    SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
    FROM employees a, --107
    departments b; --27
           --�� 50��...? ?? �����ε�..?  >> �̰� ��ũ�� �����ϱ� �þ��. 2889��(107*27��)
 /*          
CROSS JOIN
<ANSI ����>
*/
    SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
    FROM employees a
    CROSS JOIN departments b;           
           
           
--������� �� �򰥸��� ���
-- < �߸��� ���> / USING�� ���� ���� b.department_id ��Ī�� �����ؾ� �Ѵ�.
    SELECT a.employee_id, a.emp_name, b.department_id, b.department_name 
    FROM employees a
    INNER JOIN departments b
    USING (department_id)  -- ON a.department_id = b.department_id // USING�� �ڵ��� ȿ�������� �ϱ� ���� ���°��̴�. ���⸸ ���� ������ ��� ���� ������ �ڵ���� �پ���.
    WHERE a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');
     
--<�� �� ���>
    -- b.department_id�÷����� ��Ī�� ���� �Ǿ�� ��.
    SELECT a.employee_id, a.emp_name, department_id, b.department_name
    FROM employees a
    INNER JOIN departments b
    USING (department_id) -- ���� ������ b.department_id ��Ī�� ���־� �Ѵ�.
    WHERE a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');     

    --ON�� ��� ���� ���� department_id�� ��Ī�� �� �ٿ��� �Ѵ�.
    SELECT a.employee_id, a.emp_name, department_id, b.department_name 
    FROM employees a
    INNER JOIN departments b
    ON a.department_id = b.department_id
    WHERE a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');


---------------�������� : ������� ���̵� up--------------
/*
04 | ���� ����
���� ����Sub-Query �� �� SQL ���� �ȿ��� ������ ���Ǵ� �� �ٸ� SELECT���� �ǹ��Ѵ�. 
���� ����� ����ϴ� ������ ���� ������� �Ѵٸ�, 
�̸� ���� �߰� �ܰ� Ȥ�� ���� ������ �ϴ� SELECT���� ���� ������ �Ѵ�. 
���� ������ �Ұ��ߴ� SQL�� �� ��ȣ �ȿ� ����ִ� SELECT���� �ٷ� ���� ������ ���Ѵ�. 
�ϳ��� SQL���� �������� ���� ������ ������ ������ ��� SELECT���� ���� ������ ���� �Ǹ�, 
���� ���� ������ ���� ���� ����� �� �ִ�.

���� ������ �پ��� ���·� ���ȴ�. 
�� SELECT, FROM, WHERE �� ��ο��� ����� �� ���� �Ӹ� �ƴ϶�, 
INSERT, UPDATE, MERGE, DELETE �������� ����� �� �ִ�. 
���� ������ �� Ư���� ���¿� ���� ������ ���� ������ �� �ִ�.

<���� �������� �������� ����>
-������ ����(Noncorrelated) ���� ����
-������ �ִ� ���� ����

<���¿� ����>
-�Ϲ� ���� ����(SELECT ��)
-�ζ��� ��(FROM ��)
-��ø ����(WHERE ��)
*/

/*
1.������ ���� ���� ����
 - Ư¡ : ���������� ������ ���� �ʰ� �ܵ����� ���� �� �� �ִ�.
 - ���������� ���������� ������������ ���� �۵��Ѵ�. 
*/
-- �� ����� ��� �޿� �̻��� �޴� ��� ���� ��ȸ�ϴ� ����
--����1) ����� ��� �޿� / ���������� ���� ���� ��ȯ
SELECT AVG(salary) FROM employees;  --6461.8317~~~~

--�������� : ���� SELECT�� ���� SELECT�� / �������� : ��ȣ �� SELECT��
SELECT * FROM employees 
WHERE salary >=(SELECT AVG(salary) FROM employees); -- ���������� �̸� ����� ���´�

-- ����2)�μ� ���̺��� parent_id�� NULL�� �μ���ȣ�� ���� ����� �� �Ǽ��� ��ȯ�ϴ� ����
-- ��ȣ �� : �μ����̺��� parent_id�� NULL�� �μ���ȣ 
-- ���������� ����� �������� ��� IN Ű���� ���
    SELECT count(*)
    FROM employees
    WHERE department_id IN ( SELECT department_id
                             FROM departments
                             WHERE parent_id IS NULL);
                             
-- ���������� ����� �������� ��츸 ��ȣ, �ε�ȣ ������ ����� �����ϴ�. / �����غ��� �����Ͱ� �������� ���� ũ�� ������ �� ��ü�� �Ұ����ϴϱ� �������°� �翬�Ѱ� ����.                
    SELECT count(*)
    FROM employees
    WHERE department_id = ( SELECT department_id
                             FROM departments
                             WHERE parent_id IS NULL);
                             
    -- ��ȣ, �ε�ȣ�� �������� ������� �񱳺Ұ���, �����߻�                             
    SELECT count(*)
    FROM employees
    WHERE department_id IN (10, 20, 30); -- ��� 9                            
                             
    SELECT count(*)
    FROM employees
    WHERE department_id = (10, 20, 30);  --����                           
    
    
--����3)�μ� ���̺��� parent_id�� NULL�� �μ���ȣ�� ���� ����� �� �Ǽ��� ��ȯ�ϴ� ����
-- ����Ű : �÷� 2�� �̻��� ��� ���� ��� (�ϳ��� ����.)
    SELECT employee_id, emp_name, job_id
    FROM employees
    WHERE (employee_id, job_id ) IN ( SELECT employee_id, job_id
                                      FROM job_history);
                                        
    
/*
2. ������ �ִ� ���� ����
���� �������� �������� �ִ� ���� ����, �� ���� ���̺�� ���� ������ �ɸ� ���� ������ ���Ѵ�.
<����> ������������ ����ϴ� �÷����� ���������� �÷����� �����ϰ� �ִ� ����.
- �������� ������ �õ��ϰ� ������ �Ұ��ϸ� ���������� ������ �ٲ��.
- ���������� ������ ������ ������������ ����� ����.
*/
/*
<EXISTS()�Լ� ����>
 - () ��ȣ�ȿ� ����� �����ϸ� TRUE, �������� ������ FLASE�� ��ȯ�Ѵ�.
*/
-- �Ʒ� �� ���� ����.
SELECT 1 FROM dual WHERE 1 = 0; -- ���ǽ��� false�� ��� �����ʹ� ��µ��� ����.
SELECT 1 FROM dual WHERE 1 != 0; -- ���ǽ��� true�� ��� ������ 1�� ��µ�.

-- EXIST �Լ��� ���������� �����Ͱ� �������� �ʾƼ� false, ��°���� ����.
SELECT * FROM departments WHERE EXISTS(SELECT 1 FROM dual WHERE 1 = 0);  
-- EXIST �Լ��� ���������� �����Ͱ� �����ؼ� true, ��°���� �ִ�.
SELECT * FROM departments WHERE EXISTS(SELECT 1 FROM dual WHERE 1 != 0); 


--����1) ���������� �ܵ����� �������� ��� �����߻�
    SELECT a.department_id, a.department_name
    FROM departments a  
    WHERE EXISTS ( SELECT 1 --���⿡ �ٸ� ���ڸ� �ᵵ ������ ����? �ٸ� ���ڸ� �� �ʿ�?? �ܼ��� ���� ���°� �۾��ϱ� ����. // ��·�� ����� �����ϸ� ��.
                   FROM job_history b
                   WHERE a.department_id = b.department_id );  -- 6�� / �ߺ��� department_id�÷��� �����Ͱ� ���ŵ�. 
                                                               -- ���ο��� ��Ī�� �����ؼ� ����ϰ� �ִ�.

    -- ���� ����(�ϱ�)
    SELECT department_id FROM departments; --27��
    SELECT department_id FROM job_history; --10��
    /*
    �������� departments���̺��� 27���� �����Ͱ� 
    �ϳ��� ���������� a.department_id = b.departmene_id 
    1)��ġ�ϸ� 1�� �����ͷ� ���  
        EXISTS�� true�� �Ǿ� a.department_id�� ���������� ��ȯ�ȴ�.
    2)�ݴ�� ��ġ���� ������ EXISTS�� FALSE�� �Ǿ� 1�� ��µ��� �ʴ´�.
        ��ġ���� �ʴ� a.department_id�� ���������� ��ȯ���� ���Ѵ�.
    <���> ���������� ��ȯ�� ������ ���� �÷��� a.department_id, a.department_name�� ��µȴ�.
    */

-- ������ �ִ� ���������� �������� ��ȯ
    SELECT a.department_id, a.department_name
    FROM departments a  
    WHERE EXISTS ( SELECT 1
                   FROM job_history b
                   WHERE a.department_id = b.department_id );  -- 6�� / �ߺ��� department_id�÷��� �����Ͱ� ���ŵ�. 

-- ���ι���
SELECT a.department_id, a.department_name
FROM departments a, job_history b
WHERE a.department_id = b.department_id  -- 10�� ���, �ߺ��� ������ ���� ���žȵ�.

-- DISTINCT ���
SELECT DISTINCT a.department_id, a.department_name
FROM departments a, job_history b
WHERE a.department_id = b.department_id  -- 6�� ���.
    
    
-- ����2)���� ���� �ȿ��� ���� �������� ���� '�μ� ���̺��� �μ���ȣ'�� 'job_history ���̺��� �μ���ȣ'�� ���� ���� ��ȸ
    SELECT a.employee_id,
               ( SELECT b.emp_name
                   FROM employees b
                  WHERE a.employee_id = b.employee_id) AS emp_name,
               a.department_id,
               ( SELECT b.department_name
                   FROM departments b
                  WHERE a.department_id = b.department_id) AS dep_name
    FROM job_history a;
    
    --1
    SELECT departments.department_name
    FROM departments, job_history
    WHERE job_history.department_id = departments.department_id;
    
    --2
    SELECT employees.emp_name
    FROM employees, job_history 
    WHERE job_history.employee_id = employees.employee_id
    
    
    
    
    -- ���ۼ���
    /*
    job_history ���̺� 10���� �����Ͱ� �ϳ��� 
    ���������� ���ǽ� WHERE a.department_id = b.department_id ���� ��ġ�ϸ� ��ȯ
    ��ġ���� ������ ������������ ��������.
    <���> ��ġ�Ǵ� �����͸� �������� SELECT a.employee_id, a.department_id ��µȴ�.
    */
    
    
-------------------------24.04.17(��)-------------------------  
/*
�ζ��� ��
FROM ���� ����ϴ� ���� ������ �ζ��� ��InlineView ��� �Ѵ�. 
���� FROM ������ ���̺��̳� �䰡 ���µ�, ���� ������ FROM ���� ����� �ϳ��� ���̺��̳� ��ó�� ����� �� �ִ�. 
�並 ��ü�ϸ� �ϳ��� �������� SELECT���̹Ƿ� FROM ���� ����ϴ� ���� ������ �ϳ��� ��� �� �� �־ 
�ζ��� ���� �̸��� ���� ���̴�.
*/
/*
SELECT * FROM ���̺�� �Ǵ� ��� ;
SELECT * FROM (������ ���� ��������); / �̶� ���������� �ζ��� ���� �Ѵ�. 
*/
-- ����1
 SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
      FROM employees a,
           departments b,
           ( SELECT AVG(c.salary) AS avg_salary
               FROM departments b,
                    employees c
              WHERE b.parent_id = 90  -- ��ȹ��
                AND b.department_id = c.department_id ) d
     WHERE a.department_id = b.department_id
       AND a.salary > d.avg_salary;

-- ����2 /�̰� ����Ǯ�� ���� ������ �ľ��ϱ�
SELECT a.*
      FROM ( SELECT a.sales_month, ROUND(AVG(a.amount_sold)) AS month_avg
               FROM sales a,
                    customers b,
                    countries c
              WHERE a.sales_month BETWEEN '200001' AND '200012'
                AND a.cust_id = b.CUST_ID
                AND b.COUNTRY_ID = c.COUNTRY_ID
                AND c.COUNTRY_NAME = 'Italy' -- ��Ż����
              GROUP BY a.sales_month
           )  a,
           ( SELECT ROUND(AVG(a.amount_sold)) AS year_avg
               FROM sales a,
                    customers b,
                    countries c
              WHERE a.sales_month BETWEEN '200001' AND '200012'
                AND a.cust_id = b.CUST_ID
                AND b.COUNTRY_ID = c.COUNTRY_ID
                AND c.COUNTRY_NAME = 'Italy' -- ��Ż����
           ) b
     WHERE a.month_avg > b.year_avg ;


