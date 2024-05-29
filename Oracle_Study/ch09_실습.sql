/* <IF문>  
<조건이 1개일 경우>
    IF 조건 THEN
       조건 처리;
    END IF;
     
<조건이 2개일 경우>
    IF 조건 THEN
       조건 처리 1;
    ELSE
      조건 처리2;
    END IF;
     
<조건이 n개일 경우>
    IF 조건1 THEN
       조건 처리1;
    ELSIF 조건2 THEN                  ※ELSIF  <- 오타 아님. 이게 맞음
      조건 처리2;
      ...
    ELSE
       조건 처리n;
    END IF;

*/
DECLARE
    vn_num1 NUMBER :=1;
    vn_num2 NUMBER :=2;
BEGIN
    IF vn_num1 >= vn_num2 THEN
        DBMS_OUTPUT.PUT_LINE(vn_num1 || '이 큰수');
    ELSE
        DBMS_OUTPUT.PUT_LINE(vn_num2 || '이 큰수');
    END IF;
END;



DECLARE
      vn_salary NUMBER := 0;
      vn_department_id NUMBER := 0;
BEGIN
      -- 부서코드를 랜덤으로 반환하는 코드
      vn_department_id := ROUND(DBMS_RANDOM.VALUE (10, 120), -1); 

       SELECT salary
         INTO vn_salary
         FROM employees
        WHERE department_id = vn_department_id
          AND ROWNUM = 1;  -- 동일한 부서의 사원이 여러명인경우 앞에 데이터 1개만 참조 
                           --위 SELECT문의 결과중 1개만 불러온다.

      DBMS_OUTPUT.PUT_LINE(vn_salary);

      IF vn_salary BETWEEN 1 AND 3000 THEN
         DBMS_OUTPUT.PUT_LINE('낮음');
      ELSIF vn_salary BETWEEN 3001 AND 6000 THEN
         DBMS_OUTPUT.PUT_LINE('중간');
      ELSIF vn_salary BETWEEN 6001 AND 10000 THEN
         DBMS_OUTPUT.PUT_LINE('높음');
      ELSE
         DBMS_OUTPUT.PUT_LINE('최상위');
      END IF;
END;


--10~120범위의 실수값을 랜덤으로 반환
SELECT DBMS_RANDOM.VALUE(10, 120) FROM DUAL;

SELECT ROUND(DBMS_RANDOM.VALUE(10, 120), -1) FROM DUAL;



SET SERVEROUTPUT ON;

 DECLARE
      vn_salary NUMBER := 0;
      vn_department_id NUMBER := 0;
      vn_commission NUMBER := 0;
    BEGIN
      vn_department_id := ROUND(DBMS_RANDOM.VALUE (10, 120), -1);

       SELECT salary, commission_pct
         INTO vn_salary, vn_commission
         FROM employees
        WHERE department_id = vn_department_id
          AND ROWNUM = 1;

      DBMS_OUTPUT.PUT_LINE(vn_salary);

      IF vn_commission > 0 THEN
        IF vn_commission > 0.15 THEN
           DBMS_OUTPUT.PUT_LINE(vn_salary * vn_commission );
        END IF;
      ELSE
         DBMS_OUTPUT.PUT_LINE(vn_salary);
      END IF;
    END;



/*CASE문
<유형 1>
    CASE 표현식
        WHEN 결과1 THEN
             처리문1;
        WHEN 결과2 THEN
             처리문2;
        ...
        ELSE
             기타 처리문;
    END CASE;
     
    <유형 2>
    CASE WHEN 표현식1 THEN
             처리문1;
        WHEN 표현식2 THEN
             처리문2;
        ...
        ELSE
             기타 처리문;
    END CASE;
-- 다양하게 로직작업이 가능하다.
*/

--예제
    DECLARE
      vn_salary NUMBER := 0; --초기값을 주지 않으면 null값이 된다.
      vn_department_id NUMBER := 0;
    BEGIN
      vn_department_id := ROUND(DBMS_RANDOM.VALUE (10, 120), -1);

       SELECT salary
         INTO vn_salary
         FROM employees
        WHERE department_id = vn_department_id
          AND ROWNUM = 1;

    DBMS_OUTPUT.PUT_LINE(vn_salary);

    CASE WHEN vn_salary BETWEEN 1 AND 3000 THEN
              DBMS_OUTPUT.PUT_LINE('낮음');
         WHEN vn_salary BETWEEN 3001 AND 6000 THEN
              DBMS_OUTPUT.PUT_LINE('중간');
         WHEN vn_salary BETWEEN 6001 AND 10000 THEN
              DBMS_OUTPUT.PUT_LINE('높음');
         ELSE
              DBMS_OUTPUT.PUT_LINE('최상위');
      END CASE;

    END;


/*LOOP문
LOOP문은 루프를 돌며 반복해서 로직을 처리하는 반복문이다. 
이러한 반복문에는 LOOP문 외에도 WHILE문, FOR문이 있는데, 먼저 가장 기본적인 형태의 반복문인 LOOP문

     LOOP
      처리문;
      EXIT [WHEN 조건];
    END LOOP;
*/
-- 구구단 3단 출력 예제
DECLARE
      vn_base_num NUMBER := 3;
      vn_cnt      NUMBER := 1;
BEGIN
      LOOP
          DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || vn_cnt || '= ' || vn_base_num * vn_cnt);
          vn_cnt := vn_cnt + 1;      -- 루프를 돌면서 vn_cnt 값은 1씩 증가됨

          EXIT WHEN vn_cnt > 9;      -- vn_cnt가 9보다 크면 루프 종료
      END LOOP;
END;

/*
WHILE문
일반적인 프로그래밍 언어에서 대표적인 반복문을 꼽으라면 WHILE문과 FOR문을 들 수 있다. 
오라클에서도 역시 이 두 문장을 제공하는데, 먼저 WHILE문에 대해 살펴 보자.

    WHILE 조건
     LOOP
      처리문;
    END LOOP;
*/
--유형1
DECLARE
      vn_base_num NUMBER := 3;
      vn_cnt      NUMBER := 1;
BEGIN
    WHILE  vn_cnt <= 9            -- vn_cnt가 9보다 작거나 같을 때만 반복 처리
    LOOP
      DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || vn_cnt || '= ' || vn_base_num * vn_cnt);
      vn_cnt := vn_cnt + 1;      -- vn_cnt 값을 1씩 증가
    END LOOP;
END;

--유형2
DECLARE
      vn_base_num NUMBER := 3;
      vn_cnt      NUMBER := 1;
BEGIN

      WHILE  vn_cnt <= 9           -- vn_cnt가 9보다 작거나 같을 때만 반복 처리
      LOOP
         DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || vn_cnt || '= ' || vn_base_num * vn_cnt);
         EXIT WHEN vn_cnt = 5;     -- vn_cnt 값이 5가 되면 루프 종료
         vn_cnt := vn_cnt + 1;     -- vn_cnt 값을 1씩 증가
      END LOOP;
END;


/*
FOR문
FOR문도 다른 프로그래밍 언어에서 사용하는 것과 비슷한 형태이다. 
오라클에서 제공하는 FOR문의 기본 유형은 다음과 같다.

    FOR 인덱스 IN [REVERSE]초깃값..최종값
    LOOP
      처리문;
    END LOOP;
*/
DECLARE
      vn_base_num NUMBER := 3;
BEGIN
       FOR i IN 1..9
       LOOP
          DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= ' || vn_base_num * i);
       END LOOP;
END;

/*
FOR 루프에서 사용하는 인덱스는 선언부에서 선언하지 않고 사용했음을 유념하자. 
이번에는 REVERSE를 사용해 순서를 바꿔 보자.
*/
DECLARE
       vn_base_num NUMBER := 3;
BEGIN
       FOR i IN REVERSE 1..9   --i값이 9~1으로 진행된다.
       LOOP
          DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= ' || vn_base_num * i);
       END LOOP;
END;


/*
CONTINUE문
CONTINUE문은 FOR나 WHILE 같은 반복문은 아니지만, 
반복문 내에서 특정 조건에 부합할 때 처리 로직을 건너뛰고 상단의 루프 조건으로 건너가 루프를 계속 수행할 때 사용한다. 
EXIT는 루프를 완전히 빠져 나오는데 반해, CONTINUE는 제어 범위가 조건절로 넘어간다
*/
-- 예제
DECLARE
       vn_base_num NUMBER := 3;
BEGIN
       FOR i IN 1..9
       LOOP
          CONTINUE WHEN i=5;
          DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= ' || vn_base_num * i);
       END LOOP;
END;

/*
GOTO문
PL/SQL 코드 상에서 GOTO문을 만나면 GOTO문이 지정하는 라벨로 제어가 넘어간다. 구구단 출력 프로그램으로 예를 들어 보자.

라벨(label): 특정 구문에 이름을 부여 

*/

    DECLARE
       vn_base_num NUMBER := 3;
    BEGIN
       <<third>>    --이걸 라벨이라고 한다// 특정 코드 위치에 이름 부여
       FOR i IN 1..9
       LOOP
          DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= ' || vn_base_num * i);
          IF i = 3 THEN
             GOTO fourth;
          END IF;
       END LOOP;

       <<fourth>>
       vn_base_num := 4;
       FOR i IN 1..9
       LOOP
          DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= ' || vn_base_num * i);
       END LOOP;
    END;

-- 코드 진행 방식이 더러워서 사용을 권장하진 않음.

/*
NULL문
PL/SQL에서는 NULL문을 사용할 수 있다. 
NULL문은 아무것도 처리하지 않는 문장이다. 
아무 것도 처리하지 않는데 굳이 사용할 필요가 있을까? 
PL/SQL 코드를 작성하다 보면 가끔씩 필요할 때가 있다. 
NULL문은 보통 IF문이나 CASE문을 작성할 때 주로 사용하는데, 
조건에 따라 처리 로직을 작성하고 앞에서 작성한 모든 조건에 부합되지 않을 때, 
즉 ELSE절을 수행할 때 아무것도 처리하지 않고 싶은 경우 NULL문을 사용한다.

IF vn_variable = 'A' THEN
       처리로직1;
    ELSIF vn_variable = 'B' THEN
       처리로직2;
       ...
    ELSE NULL;
    END IF;

    CASE WHEN vn_variable = 'A' THEN
              처리로직1;
         WHEN vn_variable = 'B' THEN
              처리로직2;
         ...
         ELSE NULL;
    END CASE;
*/



/*
PL/SQL를 이용한 사용자 정의 함수, 프로시저 생성.
여기에서 말하는 함수는 사용자가 직접 로직을 구현하는 사용자 정의 함수를 말한다.
*/
/*
 CREATE OR REPLACE FUNCTION 함수 이름 (매개변수1, 매개변수2, ...)
    RETURN 데이터타입;
    IS[AS]               --DECLARE 키워드 빠짐
      변수, 상수 등 선언
BEGIN
      실행부
    　
      RETURN 반환값;
    [EXCEPTION
      예외 처리부]
END [함수 이름];
*/

-- 나머지를 구하는 함수
    CREATE OR REPLACE FUNCTION my_mod ( num1 NUMBER, num2 NUMBER )
       RETURN NUMBER             -- 반환 데이터타입은 NUMBER
    IS
       vn_remainder NUMBER := 0; -- 반환할 나머지
       vn_quotient  NUMBER := 0; -- 몫
    BEGIN
       vn_quotient  := FLOOR(num1 / num2); -- 피젯수/젯수 결과에서 정수 부분을 걸러 낸다
       vn_remainder := num1 - ( num2 * vn_quotient); --나머지 = 피제수 - ( 제수 * 몫)

       RETURN vn_remainder;  -- 나머지를 반환

    END;

/*
함수 호출
이제 실제로 함수를 호출해 보자. 
함수 호출 방식은 매개변수의 존재 유무에 따라 함수명과 매개변수를 명시하기도 하고, 
함수명만 명시하기도 한다. 
그리고 함수는 반환 값이 있으므로 SELECT 문장에서 사용할 수도 있고 PL/SQL 블록 내에서도 사용할 수 있다.

    <매개변수가 없는 함수 호출>
    함수명 혹은 함수명()
     
    <매개변수가 있는 함수 호출>
    함수명(매개변수1, 매개변수2,...)
SQL 함수와 마찬가지로 PL/SQL 함수는 SELECT문에서 사용할 수 있다. 
*/

SELECT MY_MOD(14,3) FROM DUAL; --2
SELECT 14/3 FROM DUAL;
SELECT FLOOR(14/3) FROM DUAL; -- FLOOR()내림 함수

-- 국가명을 반환하는 함수.//매개변수와 리턴타입의 길이를 사용 안함.
    CREATE OR REPLACE FUNCTION fn_get_country_name ( p_country_id NUMBER )
       RETURN VARCHAR2         -- 국가명을 반환하므로 반환 데이터 타입은 VARCHAR2
    IS
       vs_country_name COUNTRIES.COUNTRY_NAME%TYPE;
    BEGIN
       SELECT country_name
         INTO vs_country_name
         FROM countries
        WHERE country_id = p_country_id;

       RETURN vs_country_name;  -- 국가명 반환
    END;

--함수사용
SELECT fn_get_country_name(52777)COUNT1, fn_get_country_name(10000) COUNT2 FROM DUAL;
SELECT country_name FROM countries 
WHERE country_id = 10000;

--10000번의 국가코드가 존재하지 않아 NULL 대신 '없음'문자열로 대신하는 함수 수정을 하자.
    CREATE OR REPLACE FUNCTION fn_get_country_name ( p_country_id NUMBER )
       RETURN VARCHAR2  -- 국가명을 반환하므로 반환 데이터타입은 VARCHAR2
    IS
       vs_country_name COUNTRIES.COUNTRY_NAME%TYPE;
       vn_count NUMBER := 0;
    BEGIN
       SELECT COUNT(*)
         INTO vn_count
         FROM countries
        WHERE country_id = p_country_id;

      IF vn_count = 0 THEN
         vs_country_name := '해당국가 없음';
      ELSE
       SELECT country_name
         INTO vs_country_name
         FROM countries
        WHERE country_id = p_country_id;
      END IF;

     RETURN vs_country_name;  -- 국가명 반환

    END;

SELECT fn_get_country_name(52777)COUNT1, fn_get_country_name(10000) COUNT2 FROM DUAL;


/*
프로시저
함수는 특정 연산을 수행한 뒤 결과 값을 반환하지만 
프로시저는 특정한 로직을 처리하기만 하고결과 값을 반환하지는 않는 서브 프로그램이다. 

--프로시저 안에서 함수가 사용 될 수 있다.

일반적으로 프로젝트 현장에서는 시스템 설계가 끝난 후 업무를 분할하고 
이 분할한 업무 단위로 로직을 구현해야 하는데, 개별적인 단위 업무는 주로 프로시저로 구현해 처리한다. 
즉 테이블에서 데이터를 추출해 입맛에 맞게 조작하고 그 결과를 다른 테이블에 다시 저장하거나 갱신하는 일련의 처리를 할 때 
주로 프로시저를 사용한다.

 CREATE OR REPLACE PROCEDURE 프로시저 이름
        (매개변수명1[IN |OUT | IN OUT] 데이터타입[:= 디폴트 값],
         매개변수명2[IN |OUT | IN OUT] 데이터타입[:= 디폴트 값],
         ...
        )
    IS[AS]
      변수, 상수 등 선언
    BEGIN
      실행부
    　
    [EXCEPTION
      예외 처리부]
    END [프로시저 이름];

*/

--JOBS테이블에 데이터 삽입하는 프로시저 생성
--INPUT : 입력 매개변수 / 
CREATE OR REPLACE PROCEDURE my_new_job_proc
    ( p_job_id    IN JOBS.JOB_ID%TYPE,
      p_job_title IN JOBS.JOB_TITLE%TYPE,
      p_min_sal   IN JOBS.MIN_SALARY%TYPE,
      p_max_sal   IN JOBS.MAX_SALARY%TYPE )
IS

BEGIN
      INSERT INTO JOBS ( job_id, job_title, min_salary, max_salary, create_date, update_date)
      VALUES ( p_job_id, p_job_title, p_min_sal, p_max_sal, SYSDATE, SYSDATE);

      COMMIT;
END ;

/*
프로시저 실행
함수는 반환 값을 받으므로 실행할 때 ‘호출’이라고 명명하지만 
프로시저는 ‘호출’ 혹은 ‘실행’한다고 표현하는데, 실제로는 후자를 많이 사용하는 편이다. 
프로시저는 반환 값이 없으므로 함수처럼 SELECT 절에는 사용할 수 없고 다음과 같이 실행해야 한다.

<프로시저 실행1>
    EXEC 혹은 EXECUTE 프로시저명(매개변수1 값, 매개변수2 값, ...);
*/
-- 서블릿 파일 안에 아래 프로시저 호출 문장이 존재하게 된다.
EXEC my_new_job_proc('SM_JOB1', 'Sample JOB1', 1000,5000);

SELECT *
      FROM jobs
     WHERE job_id = 'SM_JOB1';
     
--오류 : unique constraint (SQLDB.PK_JOBS) violated / 이 값은 중복으로 들어 갈 수 없다.
EXEC my_new_job_proc('SM_JOB1', 'Sample JOB1', 1000,5000);


    CREATE OR REPLACE PROCEDURE my_new_job_proc
    ( p_job_id    IN JOBS.JOB_ID%TYPE,
      p_job_title IN JOBS.JOB_TITLE%TYPE,
      p_min_sal   IN JOBS.MIN_SALARY%TYPE,
      p_max_sal   IN JOBS.MAX_SALARY%TYPE )
    IS
      vn_cnt NUMBER := 0;
    BEGIN
      -- 동일한 job_id가 있는지 체크
      SELECT COUNT(*)
        INTO vn_cnt
        FROM JOBS
       WHERE job_id = p_job_id;

      -- 없으면 INSERT
      IF vn_cnt = 0 THEN
        INSERT INTO JOBS ( job_id, job_title, min_salary, max_salary, create_date, update_date)
                  VALUES ( p_job_id, p_job_title, p_min_sal, p_max_sal, SYSDATE, SYSDATE);
      ELSE -- 있으면 UPDATE
        UPDATE JOBS
          SET job_title   = p_job_title,
              min_salary  = p_min_sal,
              max_salary  = p_max_sal,
              update_date = SYSDATE
             WHERE job_id = p_job_id;
      END IF;
      COMMIT;
    END ;

--데이터 조회 
SELECT *
      FROM jobs
     WHERE job_id = 'SM_JOB1';

EXEC my_new_job_proc('SM_JOB1', 'Sample JOB1', 2000,6000);

SELECT *
      FROM jobs
     WHERE job_id = 'SM_JOB1';

-- 매개변수명에 값 대입해서 프로시저 실행가능
EXECUTE my_new_job_proc (p_job_id => 'SM_JOB1', p_job_title => 'Sample JOB1',
                          p_min_sal => 2000, p_max_sal => 7000);

--매개변수 값을 누락하여 에러발생. 필수로 4개 사용해야 하는데 2개 사용해서 에러
EXECUTE my_new_job_proc ('SM_JOB1','Sample JOB1');


-- 매개변수에 초기값 사용
CREATE OR REPLACE PROCEDURE my_new_job_proc
    ( p_job_id    IN JOBS.JOB_ID%TYPE,
      p_job_title IN JOBS.JOB_TITLE%TYPE,
      p_min_sal   IN JOBS.MIN_SALARY%TYPE := 10,
      p_max_sal   IN JOBS.MAX_SALARY%TYPE := 100)
    IS
      vn_cnt NUMBER := 0;
    BEGIN
      -- 동일한 job_id가 있는지 체크
      SELECT COUNT(*)
        INTO vn_cnt
        FROM JOBS
       WHERE job_id = p_job_id;

      -- 없으면 INSERT
      IF vn_cnt = 0 THEN
        INSERT INTO JOBS ( job_id, job_title, min_salary, max_salary, create_date, update_date)
                  VALUES ( p_job_id, p_job_title, p_min_sal, p_max_sal, SYSDATE, SYSDATE);
      ELSE -- 있으면 UPDATE
        UPDATE JOBS
          SET job_title   = p_job_title,
              min_salary  = p_min_sal,
              max_salary  = p_max_sal,
              update_date = SYSDATE
             WHERE job_id = p_job_id;
      END IF;
      COMMIT;
    END ;
    
--매개변수에 초기값이 존재하므로, 매개변수에 2개만 사용 가능
EXECUTE my_new_job_proc ('SM_JOB1','Sample JOB1');

--에디터 조회시 매개변수의 초기값이 사용 되어 있다.
    SELECT * 
    FROM JOBS 
    WHERE JOB_ID = 'SM_JOB1';
/*
최소, 최대 급여매개변수를 전달하지 않았어도 디폴트 값을 설정하면 이 값이 매개변수에 할당되어 처리되었음을 알 수 있다.
한가지 주의할점은 디폴트 값은 IN매개변수에만 사용 할 수 있다.
*/    

--OUT, IN OUT 매개변수를 이용한 프로시저 작업
-- 데이터를 삽입 또는 수정날짜를 받아오는 프로시저

CREATE OR REPLACE PROCEDURE my_new_job_proc
    ( p_job_id    IN JOBS.JOB_ID%TYPE,
      p_job_title IN JOBS.JOB_TITLE%TYPE,
      p_min_sal   IN JOBS.MIN_SALARY%TYPE := 10,
      p_max_sal   IN JOBS.MAX_SALARY%TYPE := 100 )
      p_upd_date  OUT JOBS.UPDATE_DATE%TYPE )
    IS
      vn_cnt NUMBER := 0;
      vn_cur_datec JOBS.UPDATE_DATE%TYPE := SYSDATE;
    BEGIN

      -- 동일한 job_id가 있는지 체크
      SELECT COUNT(*)
        INTO vn_cnt
        FROM JOBS
       WHERE job_id = p_job_id;

      -- 없으면 INSERT
      IF vn_cnt = 0 THEN
        INSERT INTO JOBS ( job_id, job_title, min_salary, max_salary, create_date, update_date)
                  VALUES ( p_job_id, p_job_title, p_min_sal, p_max_sal, vn_cur_date, vn_cur_date);

      ELSE -- 있으면 UPDATE
        UPDATE JOBS
          SET job_title  = p_job_title,
             min_salary  = p_min_sal,
             max_salary  = p_max_sal,
             update_date = vn_cur_date
        WHERE job_id = p_job_id;
      END IF;

     -- OUT 매개변수에 일자 할당(작업한 날짜)
     p_upd_date : = vn_cur_date;

      COMMIT;
    END ;
    
SET SERVEROUTPUT ON;    
    
--OUT 매개변수가 있는 프로시저 실행
DECLARE
    vd_cur_date JOBS.UPDATE_DATE%TYPE; --프로시저 p_upd_date OUT JOBS.UPDATE_DATE%TYPE 매개변수로 부터 값을 받는 목적
BEGIN
    -- 프로시저 단속실행시는 EXEX키워드 사용. 하지만 단독이 아닌 경우는 반드시 제외 해야 한다. 
    -- EXEC my_new_job_proc('SM_JOB1','Sample JOB1', 2000,6000, vd_cur_date);  -- EXEC 때문에 에러발생    
    SELECT * FROM JOBS WHERE JOB_ID = 'SM_JOB1';
    DBMS_OUTPUT.PUT_LINE(vd_cur_date);
END;





--------------------------24.04.23(화)-----------------

/*

*/

CREATE OR REPLACE PROCEDURE my_new_job_proc
    ( p_job_id    IN  JOBS.JOB_ID%TYPE,
      p_job_title IN  JOBS.JOB_TITLE%TYPE,
      p_min_sal   IN  JOBS.MIN_SALARY%TYPE := 10,
      p_max_sal   IN  JOBS.MAX_SALARY%TYPE := 100
      --p_upd_date  OUT JOBS.UPDATE_DATE%TYPE
    )
    IS
      vn_cnt NUMBER := 0;
      vn_cur_date JOBS.UPDATE_DATE%TYPE := SYSDATE;
    BEGIN
      -- 1000 보다 작으면 메시지 출력 후 빠져 나간다
      IF p_min_sal < 1000 THEN
         DBMS_OUTPUT.PUT_LINE('최소 급여값은 1000 이상이어야 합니다');
         RETURN;  -- 프로시저 종료되고, 아래 구문은 실행되지 않는다.
      END IF;

      -- 동일한 job_id가 있는지 체크
      SELECT COUNT(*)
        INTO vn_cnt
        FROM JOBS
       WHERE job_id = p_job_id;
END;




