/*
PL/SQL�� ������ ������� ���� ����
PL/SQL�� ������ ���� ������ ����� Ư¡�� ��� ������ �ִٰ� �ռ� �����ߴ�. 
���ڴ� SQL�� ����� �� �ֱ� �����̰�, ���ڴ� �Ϲ� ���α׷��� ���ó�� ������ ���� �Ҵ��ϰ� 
����ó���� �� �� ������ Ư�� ����� ó���ϴ� �Լ��� ���ν����� ���� �� �ִ� ����� �����ϱ� �����̴�. 
PL/SQL�� �Ϲ� ���α׷��� ���� �ٸ� ���� ��� �ڵ尡 DB ���ο��� ������� ó�������ν� 
���� �ӵ��� ���� ���鿡�� ū ������ �ִٴ� ���̴�.

PL/SQL : �����Ͻ� ������ �����ϴ� ����.
*/

SET SERVEROUTPUT ON; -- DBSM_OUTPUT.PUT_line(vi_num); ��°���� ����ȭ�鿡�� �������� ����

-- �Ʒ� DECLARE�� �� ���� ������ ���� SET~ ������ �� 1�� �����ؾ� �Ѵ�.

-- �͸���
-- �⺻���� ����
DECLARE
    vi_num NUMBER;
BEGIN 
    vi_num := 100;      -- ':=' ��ȣ ����
    dbms_output.put_line(vi_num);
END;
-- �� ����� �� Ȱ���ϸ� ������ ��Ʈ�� ����ϰ� �� �� �ִ�.


/*
PL/SQL ����� �������
*/

/*
<����>
������ �ٸ� ���α׷��� ���� ����ϴ� ������ ������ ������ ����ο��� ���� ������ �ϰ� ����ο��� ����Ѵ�. 
���� ���� ����� ������ ����.

  ������ ������Ÿ�� := �ʱ갪;
  
  ���� ����� ���ÿ� �ʱ갪�� �Ҵ��� �� �ִµ�, 
  �ʱ갪�� �Ҵ����� ������ ������ Ÿ�Կ� ������� �� ������ �ʱ갪�� NULL�� �ȴ�. 

  ������ ������ �� �ִ� ������ Ÿ���� ũ�� �� ������ ������ �� �ִµ�, 
  �ϳ��� SQL ������ Ÿ���̰� �ٸ� �ϳ��� PL/SQL ������ Ÿ���̴�.
  ���߿�� : PL/SQL ������ Ÿ�Կ��� SQL ������ Ÿ���� ���ԵǾ� �ֱ� �����̴�.
*/
/*
<���>
����� �����ʹ� �޸� �� �� ���� �Ҵ��ϸ� ������ �ʴ´�. ��� ���� ���� ����� ����ϴ�.

    ����� CONSTANT ������Ÿ�� := �����;

����� ������ ���� �ݵ�� CONSTANT�� Ű���带 �ٿ� ������ �����ϸ�, 
������ �� �ݵ�� �ʱ�ȭ�ؾ� �ϰ� ����ο��� ����� �ٸ� ������ ������ �� ����. 
�ֳ��ϸ� �� �״�� ����� ����ϱ�!    
*/

DECLARE
    -- ���� �� ������� ��ġ
    a INTEGER := 2**2*3**2;
BEGIN
    DBMS_OUTPUT.PUT_LINE('a = ' || TO_CHAR(a));
END;

/*
<DML��>
PL/SQL ��� �󿡼� ����ϴ� ����, ���, �����ڴ� ��� �������� �뵵�� ���� ���̴�. 
������ PL/SQL ����� �ۼ��ϴ� ������ ������ ���̺� �� �ִ� �����͸� �̸����� �����ؼ� 
Ư�� ������ ���� ���𰡸� ó���ϴ� ���̸�, ���� �ַ� ���Ǵ� ���� SQL���̴�. 
SQL�� �� DDL�� PL/SQL �󿡼� ���� �� �� ����(���� ���� ����� ���� ���� �ƴϴ�) DML���� ����Ѵ�.
*/

-- �ó�����? ��� ���̺��� Ư�� ����� �̸��� �μ����� ������ ����ϴ� �ڵ带 �ۼ�.
-- 1)sql ����
SELECT e.emp_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.employee_id = 100; 

-- 2)PL/SQL ����
DECLARE
    vs_emp_name     VARCHAR2(80); -- ����� ����
    vs_dep_name     VARCHAR2(20); -- �μ��� ����
BEGIN
    SELECT e.emp_name, d.department_name
    INTO vs_emp_name, vs_dep_name --�÷��� ���� ������ ��� ���
    FROM employees e, departments d    
    WHERE e.department_id = d.department_id
    AND e.employee_id = 100; 
    
    --������ ���
    DBMS_OUTPUT.put_line(vs_emp_name || ' - ' || vs_dep_name);
END;


-- ������ ������ Ÿ���� ���̺� �÷� Ÿ������ �ڵ����� %TYPE
-- ������ ���̺��.�÷���%TYPE
--<�������> ���̺��� �÷� ������ Ÿ���� ����Ǵ��� Ÿ���� �ڵ����� �ϹǷ� �ڵ� ������ �� �ʿ䰡 ����.
DECLARE
    vs_emp_name     employees.emp_name%TYPE; -- ����� ����
    vs_dep_name     departments.department_name%TYPE; -- �μ��� ����
BEGIN
    SELECT e.emp_name, d.department_name
    INTO vs_emp_name, vs_dep_name --�÷��� ���� ������ ��� ���
    FROM employees e, departments d    
    WHERE e.department_id = d.department_id
    AND e.employee_id = 100; 
    
    --������ ���
    DBMS_OUTPUT.put_line(vs_emp_name || ' - ' || vs_dep_name);
END;




/* SQL�� PL/SQL ������ Ÿ�Ժ� ���� 
SQL������ Ÿ���� PL/SQL ������Ÿ�Կ��� ����������, ���̰� �� �� ũ�� ����Ѵ�(�߿�) 
 
VARCHAR2 Ÿ���� SQL������ �ִ� ũ�Ⱑ 4000 byte����. 
������ PL/SQL������ VARCHAR2 Ÿ���� 32KB(32,767 byte)���� ����� �� �ִ�.
>>> PL/SQL�� SQL�� ������ Ÿ���� ũ�� ���̰� ������ PL/SQL�� ũ�Ⱑ �ξ� �� ũ��
*/


CREATE TABLE ch08_varchar2 (
    VAR1 VARCHAR2(5000)); -- 4000BYTE�ʰ��� �����߻�.

-- Ÿ�Լ���
CREATE TABLE ch08_varchar2 (
    VAR1 VARCHAR2(4000)); 

--������ Ÿ�� // ��� ���� �Ʒ� DECLARE ���� ����� �۵��Ѵ�.
INSERT INTO ch08_varchar2 VALUES('4000����Ʈ ũ�ⵥ����');

DECLARE
    vs_sql_varchar2     VARCHAR2(4000),
    vs_plsql_varchar2   VARCHAR2(32767)
BEGIN
    SELECT VAR1
        INTO vs_sql_varchar2
        FROM ch08_VARCHAR2;
        
        vs_plsql_varchar2 := vs_sql_varchar2 || ' = ' || vs_sql_varchar2 || ' - ' || vs_plsql_varchar2;
        
        --�� ������ ũ�⸦ ����Ѵ�.
        DBMS_OUTPUT.PUT_LINE('SQL VARCHAR2 ���� : ' || LENGTHB(vs_sql_varchar2));
        DBMS_OUTPUT.PUT_LINE('PL/SQL VARCHAR2 ���� : ' || LENGTHB(vs_sql_varchar2));
END;





