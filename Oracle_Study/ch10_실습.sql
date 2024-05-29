/*
�ý��� ���ܷδ� ������ ������ �� �� 0���� �����ٰų� SELECT INTO ���� ����� �����͸� ������ �� 
���ǿ� �����ϴ� �����Ͱ� ������ �߻��ϴ� ���� ���� �ִ�.
�� �ý��� ���ܴ� ����Ŭ ���ο� �̸� ���ǵ� ���ܶ�� �� �� �ִ�. 
*/

/*
    <����ó������>
 EXCEPTION WHEN ���ܸ�1 THEN ����ó�� ����1
     WHEN ���ܸ�2 THEN ����ó�� ����2
     ...
     WHEN OTHERS THEN ����ó�� ����n;
     
    <�ڹٷ� �����ϸ�>
    try{
    ���ܹ߻���������;
    }
    catch(����Ŭ����e){
    ����ó������1
    }
    catch(����Ŭ����e){
    ����ó������2
    }
*/

--PL/SQL ����
-- �Լ� �Ǵ� ���ν��� �̸����� ������ �ʰ� �Ʒ��� �ڵ带 �����ϸ�, �̸� �͸� ����̶� �Ѵ�.
DECLARE
    vi_num NUMBER :=0;
BEGIN
    vi_num := 10/0; -- ������ 0���δ� ���Ǿ�, ���� �߻��ǰ�, ��������. �Ʒ� ������ ������� ����. 
    DBMS_OUTPUT.PUT_LINE('Success');
    
    --����ó�� �۾�
    EXCEPTION WHEN OTHERS THEN   -- OHTERS : ���� ������ �� ��� �Ϲ������� ����ϴ� Ű����
    DBMS_OUTPUT.PUT_LINE('������ �߻��߽��ϴ�.');
END;

--���ν���
-- 1)����ó���� ���� ���ν���
CREATE OR REPLACE PROCEDURE ch10_no_exception_proc
IS
    vi_num NUMBER :=0;
BEGIN
    vi_num := 10/0; -- ���� �߻�����
    DBMS_OUTPUT.PUT_LINE('Success!');
END;


-- 2)����ó���� �ִ� ���ν���
CREATE OR REPLACE PROCEDURE ch10_exception_proc
IS
    vi_num NUMBER :=0;
BEGIN
    vi_num := 10/0; -- ���� �߻�����
    DBMS_OUTPUT.PUT_LINE('Success!');
    
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('������ �߻��߽��ϴ�.');
    
END;



-- ���ܰ� ���� ���ν��� ����
DECLARE
    vi_num NUMBER :=0;  -- ������� �ʴ��� ������ ������ ���� �� ��.
BEGIN
    ch10_no_exception_proc; -- ���⿡ ���ܰ� ������.
    DBMS_OUTPUT.PUT_LINE('Success!'); -- �� ������ �տ� '����ó���� ���� ���ν����� ����'�Ǿ� ���ܹ߻��̵Ǿ� ������� �ʴ´�.
END;


--���ܰ� �ִ� ���ν��� ����
DECLARE
    vi_num NUMBER :=0; -- ������� �ʴ��� ������ ������ ���� �� ��.
BEGIN
    ch10_exception_proc; --����ó���� ����
    DBMS_OUTPUT.PUT_LINE('Success!'); -- �� ������ ����ȴ�.
END;



-- ����ó���� �ִ� ���ν��� ����
CREATE OR REPLACE PROCEDURE ch10_exception_proc
IS
    vi_num NUMBER :=0;
BEGIN
    vi_num := 10/0; -- ���� �߻�����
    DBMS_OUTPUT.PUT_LINE('Success!');
    
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('������ �߻��߽��ϴ�.');
    DBMS_OUTPUT.PUT_LINE('SQL ERROR CODE:' || SQLCODE);  -- �����ڵ�
    DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE:' || SQLCODE);  -- �����޼���
    DBMS_OUTPUT.PUT_LINE(SQLERRM(SQLCODE)); 
    
END;

--���ܰ� �ִ� ���ν��� ����
DECLARE
    vi_num NUMBER :=0; -- ������� �ʴ��� ������ ������ ���� �� ��.
BEGIN
    ch10_exception_proc; --����ó���� ����
    DBMS_OUTPUT.PUT_LINE('Success!'); -- �� ������ ����ȴ�.
END;  



--����ó�� OTHERS�� ������� �ʰ�, ZERO_DIVIDE�� ���� ���� 
    CREATE OR REPLACE PROCEDURE ch10_exception_proc
    IS
      vi_num NUMBER := 0;
    BEGIN
      vi_num := 10 / 0;
      DBMS_OUTPUT.PUT_LINE('Success!');

    EXCEPTION WHEN ZERO_DIVIDE THEN
      DBMS_OUTPUT.PUT_LINE('������ �߻��߽��ϴ�');
      DBMS_OUTPUT.PUT_LINE('SQL ERROR CODE: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE: ' || SQLERRM);
    END;
    
    
DECLARE
    vi_num NUMBER :=0; -- ������� �ʴ��� ������ ������ ���� �� ��.
BEGIN
    ch10_exception_proc; --����ó���� ����
    DBMS_OUTPUT.PUT_LINE('Success!'); -- �� ������ ����ȴ�.
END;  


--����ó������ 2�� �̻����� �ϴ� ���ν��� ����
 CREATE OR REPLACE PROCEDURE ch10_exception_proc
    IS
      vi_num NUMBER := 0;
    BEGIN
      vi_num := 10 / 0;
      DBMS_OUTPUT.PUT_LINE('Success!');

    EXCEPTION 
    WHEN ZERO_DIVIDE THEN
      DBMS_OUTPUT.PUT_LINE('����1');
      DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE1: ' || SQLCODE);
    WHEN OTHERS THEN   --OTHERS ����ó������ ������ ������ ����ؾ� �Ѵ�.
      DBMS_OUTPUT.PUT_LINE('����2');
      DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE2: ' || SQLERRM);
    END;
 
 
DECLARE
    vi_num NUMBER :=0; -- ������� �ʴ��� ������ ������ ���� �� ��.
BEGIN
    ch10_exception_proc; --����ó���� ����
    DBMS_OUTPUT.PUT_LINE('Success!'); -- �� ������ ����ȴ�.
END;     


-- SELECT INTO ���ܹ߻�
CREATE OR REPLACE PROCEDURE ch10_upd_jobid_proc
(
    p_employee_id   employees.employee_id%TYPE,
    p_job_id        jobs.job_id%TYPE
)
IS 
    vn_cnt NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO vn_cnt
    FROM JOBS
    WHERE JOB_id = P_job_id;
    
    IF vn_cnt = 0 THEN
        DBMS_OUTPUT.PUT_LINE('job_id�� ��������.');
        RETURN;
    ELSE
        UPDATE employees
           SET job_id = P_job_id
        WHERE employee_id = p_employee_id;
    END IF;
END;

-- ���� ���ν����� ����ó�� ������ ���� �ڵ�� ����
CREATE OR REPLACE PROCEDURE ch10_upd_jobid_proc
(
    p_employee_id   employees.employee_id%TYPE,
    p_job_id        jobs.job_id%TYPE
)
IS 
    vn_cnt NUMBER := 0;
BEGIN

--���ǽ��� ��ġ���� ������ ����Ŭ������ SELECT INTO ������ ���ܰ� �߻��ϵ��� ����Ǿ� �ִ�.(NO_DATA_FOUND)
    SELECT 1  -- where���� �������� ������ vn_cnt�� 1�� ���Եȴ�.
    INTO vn_cnt
    FROM JOBS
    WHERE JOB_id = P_job_id; -- ���ǽ��� false�� ���ܹ߻�.
    
    UPDATE employees
    SET job_id = P_job_id
    WHERE employee_id = p_employee_id;
    
    COMMIT;
    
    EXCEPTION
        WHEN NO_DATE_FOUND THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            DBMS_OUTPUT.PUT_LINE(p_job_id || '�� �ش��ϴ� job_id�� �����ϴ�.');
        WHEN OTERS THEN
            DBMS_OUTPUT.PUT_LINE('��Ÿ����:'|| SQLERRM);
    END; 
    
   
-- ���ν��� ���� �� SELECT�� ��� ���¸� ����ϸ� �ȵȴ�.(�߿�)
CREATE OR REPLACE PROCEDURE udp_select
IS
BEGIN
    SELECT * FROM employees; -- SELECT INTO�� �̿��� ������ �Ҵ��ϴ� ���� �����ϴ�.
END;

-- �� ������ PLS-00428: an INTO clause is expected in this SELECT statement ���� �߻�