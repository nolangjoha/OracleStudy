/*
시스템 예외로는 나눗셈 연산을 할 때 0으로 나눈다거나 SELECT INTO 절을 사용해 데이터를 가져올 때 
조건에 만족하는 데이터가 없으면 발생하는 예외 등이 있다.
즉 시스템 예외는 오라클 내부에 미리 정의된 예외라고 할 수 있다. 
*/

/*
    <예외처리구문>
 EXCEPTION WHEN 예외명1 THEN 예외처리 구문1
     WHEN 예외명2 THEN 예외처리 구문2
     ...
     WHEN OTHERS THEN 예외처리 구문n;
     
    <자바로 설명하면>
    try{
    예외발생구문포함;
    }
    catch(예외클래스e){
    예외처리구문1
    }
    catch(예외클래스e){
    예외처리구문2
    }
*/

--PL/SQL 구문
-- 함수 또는 프로시저 이름으로 만들지 않고 아래와 코드를 구성하면, 이를 익명 블록이라 한다.
DECLARE
    vi_num NUMBER :=0;
BEGIN
    vi_num := 10/0; -- 제수가 0으로는 사용되어, 예외 발생되고, 강제종료. 아래 구문이 실행되지 못함. 
    DBMS_OUTPUT.PUT_LINE('Success');
    
    --예외처리 작업
    EXCEPTION WHEN OTHERS THEN   -- OHTERS : 예외 오류를 모를 경우 일반적으로 사용하는 키워드
    DBMS_OUTPUT.PUT_LINE('오류가 발생했습니다.');
END;

--프로시저
-- 1)예외처리가 없는 프로시저
CREATE OR REPLACE PROCEDURE ch10_no_exception_proc
IS
    vi_num NUMBER :=0;
BEGIN
    vi_num := 10/0; -- 예외 발생구문
    DBMS_OUTPUT.PUT_LINE('Success!');
END;


-- 2)예외처리가 있는 프로시저
CREATE OR REPLACE PROCEDURE ch10_exception_proc
IS
    vi_num NUMBER :=0;
BEGIN
    vi_num := 10/0; -- 예외 발생구문
    DBMS_OUTPUT.PUT_LINE('Success!');
    
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('오류가 발생했습니다.');
    
END;



-- 예외가 없는 프로시저 실행
DECLARE
    vi_num NUMBER :=0;  -- 사용하지 않더라도 임의의 변수를 선언 할 것.
BEGIN
    ch10_no_exception_proc; -- 여기에 예외가 존재함.
    DBMS_OUTPUT.PUT_LINE('Success!'); -- 이 구문의 앞에 '예외처리가 없는 프로시저가 실행'되어 예외발생이되어 실행되지 않는다.
END;


--예외가 있는 프로시저 실행
DECLARE
    vi_num NUMBER :=0; -- 사용하지 않더라도 임의의 변수를 선언 할 것.
BEGIN
    ch10_exception_proc; --예외처리가 존재
    DBMS_OUTPUT.PUT_LINE('Success!'); -- 이 구문이 실행된다.
END;



-- 예외처리가 있는 프로시저 수정
CREATE OR REPLACE PROCEDURE ch10_exception_proc
IS
    vi_num NUMBER :=0;
BEGIN
    vi_num := 10/0; -- 예외 발생구문
    DBMS_OUTPUT.PUT_LINE('Success!');
    
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('오류가 발생했습니다.');
    DBMS_OUTPUT.PUT_LINE('SQL ERROR CODE:' || SQLCODE);  -- 에러코드
    DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE:' || SQLCODE);  -- 에러메세지
    DBMS_OUTPUT.PUT_LINE(SQLERRM(SQLCODE)); 
    
END;

--예외가 있는 프로시저 실행
DECLARE
    vi_num NUMBER :=0; -- 사용하지 않더라도 임의의 변수를 선언 할 것.
BEGIN
    ch10_exception_proc; --예외처리가 존재
    DBMS_OUTPUT.PUT_LINE('Success!'); -- 이 구문이 실행된다.
END;  



--예외처리 OTHERS를 사용하지 않고, ZERO_DIVIDE로 예외 실행 
    CREATE OR REPLACE PROCEDURE ch10_exception_proc
    IS
      vi_num NUMBER := 0;
    BEGIN
      vi_num := 10 / 0;
      DBMS_OUTPUT.PUT_LINE('Success!');

    EXCEPTION WHEN ZERO_DIVIDE THEN
      DBMS_OUTPUT.PUT_LINE('오류가 발생했습니다');
      DBMS_OUTPUT.PUT_LINE('SQL ERROR CODE: ' || SQLCODE);
      DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE: ' || SQLERRM);
    END;
    
    
DECLARE
    vi_num NUMBER :=0; -- 사용하지 않더라도 임의의 변수를 선언 할 것.
BEGIN
    ch10_exception_proc; --예외처리가 존재
    DBMS_OUTPUT.PUT_LINE('Success!'); -- 이 구문이 실행된다.
END;  


--예외처리명을 2개 이상으로 하는 프로시저 변경
 CREATE OR REPLACE PROCEDURE ch10_exception_proc
    IS
      vi_num NUMBER := 0;
    BEGIN
      vi_num := 10 / 0;
      DBMS_OUTPUT.PUT_LINE('Success!');

    EXCEPTION 
    WHEN ZERO_DIVIDE THEN
      DBMS_OUTPUT.PUT_LINE('오류1');
      DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE1: ' || SQLCODE);
    WHEN OTHERS THEN   --OTHERS 예외처리명을 마지막 순서로 사용해야 한다.
      DBMS_OUTPUT.PUT_LINE('오류2');
      DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE2: ' || SQLERRM);
    END;
 
 
DECLARE
    vi_num NUMBER :=0; -- 사용하지 않더라도 임의의 변수를 선언 할 것.
BEGIN
    ch10_exception_proc; --예외처리가 존재
    DBMS_OUTPUT.PUT_LINE('Success!'); -- 이 구문이 실행된다.
END;     


-- SELECT INTO 예외발생
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
        DBMS_OUTPUT.PUT_LINE('job_id가 없습ㄴ디ㅏ.');
        RETURN;
    ELSE
        UPDATE employees
           SET job_id = P_job_id
        WHERE employee_id = p_employee_id;
    END IF;
END;

-- 위의 프로시저를 예외처리 로직이 사용된 코드로 변경
CREATE OR REPLACE PROCEDURE ch10_upd_jobid_proc
(
    p_employee_id   employees.employee_id%TYPE,
    p_job_id        jobs.job_id%TYPE
)
IS 
    vn_cnt NUMBER := 0;
BEGIN

--조건식이 일치하지 않으면 오라클에서는 SELECT INTO 구문이 예외가 발생하도록 설계되어 있다.(NO_DATA_FOUND)
    SELECT 1  -- where값이 존재하지 않으면 vn_cnt에 1이 대입된다.
    INTO vn_cnt
    FROM JOBS
    WHERE JOB_id = P_job_id; -- 조건식이 false면 예외발생.
    
    UPDATE employees
    SET job_id = P_job_id
    WHERE employee_id = p_employee_id;
    
    COMMIT;
    
    EXCEPTION
        WHEN NO_DATE_FOUND THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            DBMS_OUTPUT.PUT_LINE(p_job_id || '에 해당하는 job_id가 없습니다.');
        WHEN OTERS THEN
            DBMS_OUTPUT.PUT_LINE('기타에러:'|| SQLERRM);
    END; 
    
   
-- 프로시저 생성 시 SELECT문 결과 형태를 사용하면 안된다.(중요)
CREATE OR REPLACE PROCEDURE udp_select
IS
BEGIN
    SELECT * FROM employees; -- SELECT INTO를 이용한 변수에 할당하는 것은 가능하다.
END;

-- 위 구문은 PLS-00428: an INTO clause is expected in this SELECT statement 에러 발생