-----------------------------------24.04.08(월)-----------------------------------
/*
SELECT문
가장 기본적인 SQL문으로 테이블이나 뷰에 있는 데이터를 조회할 때 사용하는 문장이다.
SQL문 중 사용빈도로 볼 때 가장 많이 사용하는 것이 SELECT문이며, 기본 구문은 다음과 같다.

    SELECT * 혹은 컬럼                   --'*'은 전체를 선택하는데 이건 실무에서 효율문제로 사용하지 않음.
    FROM [스키마.]테이블명 혹은 [스키마.]뷰명
    WHERE 조건
    ORDER BY 컬럼;  
    
    <위 순서를 반드시 지켜 작성해야 한다.>
*/

--질의? EMPLOYEES 테이블에서 급여(salary)가 5000이 넘는 사원번호와 사원명을 조회
SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000
ORDER BY employee_id ASC;-- 오름차순 ASC생략 가능

SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000
ORDER BY employee_id DESC; --내림차순


--질의? 급여가 5000 이상이고 job_id가 ‘IT_PROG’인 사원을 조회한다면, AND 연산자와 job_id를 검색하는 조건을 추가한다.
SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000 AND JOB_ID = 'IT_PROG'  -- 문자데이터는 대소문자 구분을 하므로 주의 할것.
ORDER BY employee_id ASC; --내림차순

--'it_prog'소문자인 데이터가 존재하지 않는다.
SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000 AND JOB_ID = 'it_prog'  -- 문자데이터는 대소문자 구분을 하므로 주의 할것.
ORDER BY employee_id ASC; --내림차순

--질의? 급여가 5000 이상이거나 job_id가 ‘IT_PROG’인 사원, 
--즉 급여가 5000 이상인 사원 혹은 job_id 값이 ‘IT_PROG’인 사원을 조회
SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000 OR JOB_ID = 'IT_PROG'  -- OR 연산자와 job_id를 검색하는 조건을 추가한다.
ORDER BY employee_id ASC; --내림차순


/*
02 | INSERT문
신규로 데이터를 입력할 때는 INSERT문을 사용하는데, 크게 기본 형태, 컬럼명 생략 형태, INSERT ~SELECT 형태로 나눌 수 있다.
   
    INSERT INTO [스키마.]테이블명 (컬럼1, 컬럼2, ...)       --sqldb로 만들어서 스키마는 생략 가능
    VALUES (값1, 값2, ...);
    
    주의할 사항은 반드시 나열하는 컬럼과 값의 수와 순서, 그리고 데이터 타입이 일치해야만 한다. 
   일치하지 않으면 오류가 발생하여 데이타가 입력되지 않는다.
*/
CREATE TABLE EX3_1(
    COL1    VARCHAR2(10),
    COL2    NUMBER,
    COL3    DATE
);

--데이터 삽입
INSERT INTO EX3_1(COL1, COL2, COL3) VALUES('ABC', 10, SYSDATE);

--데이터 조회
SELECT *FROM EX3_1;


--컬럼 순서를 바꾸더라도 VALUES절에 있는 값을 바뀐 순서와 맞추기만 하면 문제가 없다.
INSERT INTO EX3_1 (Col3, Col1, Col2)VALUES (SYSDATE, 'DEF', 20);

--데이터 조회
SELECT *FROM EX3_1;

--데이터 타입을 맞추지 않으면 오류가 발생한다. COL3이 DATE 타입이므로 30은 숫자데이터 이므로 에러발생
INSERT INTO EX3_1 (Col1, Col2, Col3)VALUES ('ABC', 10, 30);
 
--컬럼명은 기술하지 않지만 VALUES절에는 테이블의 컬럼 순서대로 해당 컬럼 값을 기술해야 하는 형태다.
INSERT INTO EX3_1 VALUES ('GHI', 10, SYSDATE); -- 잘되긴 하지만 권장X

--컬럼을 생략 가능한 경우는 컬럼(필드, 열)이 NULL, DEFAULT일 경우는 생략 가능하다.
-- COL3 컬럼이 생략 가능한 이유는 NULL인 경우는 생략 가능하다. 데이터 삽입시 NULL로 처리 된다.
INSERT INTO ex3_1  (col1, col2 ) VALUES ('GHI', 20);

--데이터 조회
SELECT *FROM EX3_1;

/*
INSERT ~ SELECT 형태
    INSERT INTO [스키마.]테이블명 (컬럼1, 컬럼2, ...)
    SELECT 문;
*/
--키워드(예약어)대문자, 나머지는 소문자 형식 패턴 스타일로 작업하는 경향이 있다. (식별을 위해)
CREATE TABLE ex3_2(
    emp_id      NUMBER,
    emp_name    VARCHAR2(100)
);

--실무적으로 많이 사용 / 이미 만들어진 테이블에 다른테이블 데이터 넣기
INSERT INTO ex3_2(emp_id, emp_name)
SELECT employee_id, emp_name FROM employees 
WHERE salary > 5000;

--데이터 조회
SELECT *FROM ex3_2;

--테이블 복사(백업)
CREATE TABLE employees_bak
AS
SELECT employee_id, emp_name FROM employees 
WHERE Salary > 5000;

--데이터 조회
SELECT *FROM employees_bak;


/*
03 | UPDATE문
테이블에 있는 기존 데이터를 수정할 때 사용하는 문장이 UPDATE문이다.

    UPDATE [스키마.]테이블명
    SET 컬럼1 = 변경값1,
        컬럼2 = 변경값2,
    ...
    WHERE 조건;
*/
--데이터 조회
SELECT*FROM ex3_1;

--ex3_1테이블의 col2값을 모두 50으로 변경해보자.
UPDATE ex3_1
SET col2 = 50; -- WHERE 조건식이 생략되면, 모든 데이터를 변경하는 의미.

--데이터 조회
SELECT*FROM ex3_1;

--질의? col1의 컬럼에서 'ABC'인 데이터의 col2컬럼의 값을 100으로 변경하라.
UPDATE ex3_1            --ex3_1테이블의
SET col2 = 100          --col2값을 100으로 설정해라(결과)
WHERE col1 = 'ABC';     --col1값이 'ABC'위치에(조건)

--데이터 조회
SELECT*FROM ex3_1 WHERE col1 = 'ABC';

--데이터 조회
SELECT*FROM ex3_2 ORDER BY emp_id ASC;

--질의? ex3_2테이블에서 emp_id 컬럼의 데이터가 150인 데이터의 emp_name컬럼의 이름을 'Peter Tucker Junior'로 변경하여라
UPDATE ex3_2
SET emp_name = 'Peter Tucker Junior'
WHERE emp_id = 150;

--데이터 조회
SELECT*FROM ex3_2 WHERE emp_id = 150;


--시나리오 employees테이블에서 salary컬럼에서 급여가 8000이상인 데이터를 
--다음 컬럼으로 employee_id, emp_name, email, salary구성되는 테이블 (emp_salary_8000)을 생성해라.(테이블 복사 명령어)
CREATE TABLE emp_salary_8000
AS
SELECT employee_id, emp_name, email, salary FROM employees 
WHERE Salary >= 8000;

--데이터 조회
SELECT*FROM emp_salary_8000 ORDER BY employee_id ASC;


--질의? employees테이블 사원번호가 100인 데이터 email 컬럼을 'KINGS'로 변경하고 salary컬럼은 20000으로 변경하라.
UPDATE emp_salary_8000
SET email = 'KINGS', salary = 20000
WHERE employee_id = 100;

SELECT*FROM emp_salary_8000 WHERE employee_id = 100;

/*
--JOIN(조인)문법을 학습한 이후 진행합니다.
04 | MERGE문 
MERGE문은 조건을 비교해서 테이블에 해당 조건에 맞는 데이터가 없으면 INSERT, 있으면 UPDATE를 수행하는 문장이다. 
특정 조건에 따라 어떤 때는 INSERT를, 또 다른 경우에는 UPDATE문을 수행해야 할 때, 
과거에는 해당 조건을 처리하는 로직을 별도로 작성해야 했지만, 
MERGE문이 나온 덕분에 이제 한 문장으로 처리할 수 있게 되었다.

    MERGE INTO [스키마.]테이블명
        USING (update나 insert될 데이터 원천)
             ON (update될 조건)
    WHEN MATCHED THEN
           SET 컬럼1 = 값1, 컬럼2 = 값2, ...
    WHERE update 조건
           DELETE WHERE update_delete 조건
    WHEN NOT MATCHED THEN
           INSERT (컬럼1, 컬럼2, ...) VALUES (값1, 값2,...)
           WHERE insert 조건;
           
<용도 : 쇼핑몰 장바구니 기능>
   - 사용자가 상품을 장바구니에 추가 할 경우 현재 사용자와 상품에 대한 정보가 장바구니에 존재하면 수량변경(update)
     존재하지 않으면 사용자와 상품데이터가 삽입(insert)된다.
*/

--https://gent.tistory.com/406 MERGE문법 참조
--연습문제_SCOTT 계정 사용 

--1) 단일 테이블 사용(DUAL)
-- 시나리오? 사원테이블에 사원번호 7738이 존재하면 UPDATE 하고, 존재하지 않으면 INSERT 작업을 하자.
-- 이러한 기능은 장바구니에서 사용된다. 동일한 상품이 있으면 수량만 변경, 없으면 상품 추가.
MERGE
    INTO emp a
    USING dual
    ON(a.empno = 7738)  
    WHEN MATCHED THEN -- 위의 조건이 참이면
    UPDATE
    SET a.deptno = 20  -- 원래 UPDATE문은 UPDATE emp a  SET a.deptno = 20 WHERE a.empno = 7738로 작성되어야 한다.
                       -- 하지만 위에 emp a와 a.empno = 7738이 작성되었기 때문에 생략이 가능하다.
    WHEN NOT MATCHED THEN
    INSERT(a.empno, a.ename, a.deptno)
    VALUES(7738,'SCOTT',20);  -- 내부적으로 INSERT emp a(a.empno, a.ename, a.deptno) VALUES(7788,'SCOTT',20);이 실행됨.
                              -- UPDATE문과 같은 사유로 생략작성이 가능함.


SELECT * FROM EMP WHERE empno = 7738; -- 데이터가 추가된것을 확인

--2) 조인을 사용
-- SCOOT계정에는 job_history 테이블이 없음.
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

--DELETE절 사용
MERGE
 INTO emp a
 USING dual
 ON (a.empno = 7738)
    WHEN MATCHED THEN
        UPDATE
        SET a.deptno = 20 WHERE a.job = 'ANALYST'
    DELETE
        WHERE a.job <> 'ANALYST';














-----------------------------------24.04.08(월)-----------------------------------
/*
SELECT문
가장 기본적인 SQL문으로 테이블이나 뷰에 있는 데이터를 조회할 때 사용하는 문장이다.
SQL문 중 사용빈도로 볼 때 가장 많이 사용하는 것이 SELECT문이며, 기본 구문은 다음과 같다.

    SELECT * 혹은 컬럼                   --'*'은 전체를 선택하는데 이건 실무에서 효율문제로 사용하지 않음.
    FROM [스키마.]테이블명 혹은 [스키마.]뷰명
    WHERE 조건
    ORDER BY 컬럼;  
    
    <위 순서를 반드시 지켜 작성해야 한다.>
*/

--질의? EMPLOYEES 테이블에서 급여(salary)가 5000이 넘는 사원번호와 사원명을 조회
SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000
ORDER BY employee_id ASC;-- 오름차순 ASC생략 가능

SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000
ORDER BY employee_id DESC; --내림차순


--질의? 급여가 5000 이상이고 job_id가 ‘IT_PROG’인 사원을 조회한다면, AND 연산자와 job_id를 검색하는 조건을 추가한다.
SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000 AND JOB_ID = 'IT_PROG'  -- 문자데이터는 대소문자 구분을 하므로 주의 할것.
ORDER BY employee_id ASC; --내림차순

--'it_prog'소문자인 데이터가 존재하지 않는다.
SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000 AND JOB_ID = 'it_prog'  -- 문자데이터는 대소문자 구분을 하므로 주의 할것.
ORDER BY employee_id ASC; --내림차순

--질의? 급여가 5000 이상이거나 job_id가 ‘IT_PROG’인 사원, 
--즉 급여가 5000 이상인 사원 혹은 job_id 값이 ‘IT_PROG’인 사원을 조회
SELECT employee_id, EMP_NAME, SALARY FROM EMPLOYEES 
WHERE salary > 5000 OR JOB_ID = 'IT_PROG'  -- OR 연산자와 job_id를 검색하는 조건을 추가한다.
ORDER BY employee_id ASC; --내림차순


/*
02 | INSERT문
신규로 데이터를 입력할 때는 INSERT문을 사용하는데, 크게 기본 형태, 컬럼명 생략 형태, INSERT ~SELECT 형태로 나눌 수 있다.
   
    INSERT INTO [스키마.]테이블명 (컬럼1, 컬럼2, ...)       --sqldb로 만들어서 스키마는 생략 가능
    VALUES (값1, 값2, ...);
    
    주의할 사항은 반드시 나열하는 컬럼과 값의 수와 순서, 그리고 데이터 타입이 일치해야만 한다. 
   일치하지 않으면 오류가 발생하여 데이타가 입력되지 않는다.
*/
CREATE TABLE EX3_1(
    COL1    VARCHAR2(10),
    COL2    NUMBER,
    COL3    DATE
);

--데이터 삽입
INSERT INTO EX3_1(COL1, COL2, COL3) VALUES('ABC', 10, SYSDATE);

--데이터 조회
SELECT *FROM EX3_1;


--컬럼 순서를 바꾸더라도 VALUES절에 있는 값을 바뀐 순서와 맞추기만 하면 문제가 없다.
INSERT INTO EX3_1 (Col3, Col1, Col2)VALUES (SYSDATE, 'DEF', 20);

--데이터 조회
SELECT *FROM EX3_1;

--데이터 타입을 맞추지 않으면 오류가 발생한다. COL3이 DATE 타입이므로 30은 숫자데이터 이므로 에러발생
INSERT INTO EX3_1 (Col1, Col2, Col3)VALUES ('ABC', 10, 30);
 
--컬럼명은 기술하지 않지만 VALUES절에는 테이블의 컬럼 순서대로 해당 컬럼 값을 기술해야 하는 형태다.
INSERT INTO EX3_1 VALUES ('GHI', 10, SYSDATE); -- 잘되긴 하지만 권장X

--컬럼을 생략 가능한 경우는 컬럼(필드, 열)이 NULL, DEFAULT일 경우는 생략 가능하다.
-- COL3 컬럼이 생략 가능한 이유는 NULL인 경우는 생략 가능하다. 데이터 삽입시 NULL로 처리 된다.
INSERT INTO ex3_1  (col1, col2 ) VALUES ('GHI', 20);

--데이터 조회
SELECT *FROM EX3_1;

/*
INSERT ~ SELECT 형태
    INSERT INTO [스키마.]테이블명 (컬럼1, 컬럼2, ...)
    SELECT 문;
*/
--키워드(예약어)대문자, 나머지는 소문자 형식 패턴 스타일로 작업하는 경향이 있다. (식별을 위해)
CREATE TABLE ex3_2(
    emp_id      NUMBER,
    emp_name    VARCHAR2(100)
);

--실무적으로 많이 사용 / 이미 만들어진 테이블에 다른테이블 데이터 넣기
INSERT INTO ex3_2(emp_id, emp_name)
SELECT employee_id, emp_name FROM employees 
WHERE salary > 5000;

--데이터 조회
SELECT *FROM ex3_2;

--테이블 복사(백업)
CREATE TABLE employees_bak
AS
SELECT employee_id, emp_name FROM employees 
WHERE Salary > 5000;

--데이터 조회
SELECT *FROM employees_bak;


/*
03 | UPDATE문
테이블에 있는 기존 데이터를 수정할 때 사용하는 문장이 UPDATE문이다.

    UPDATE [스키마.]테이블명
    SET 컬럼1 = 변경값1,
        컬럼2 = 변경값2,
    ...
    WHERE 조건;
*/
--데이터 조회
SELECT*FROM ex3_1;

--ex3_1테이블의 col2값을 모두 50으로 변경해보자.
UPDATE ex3_1
SET col2 = 50; -- WHERE 조건식이 생략되면, 모든 데이터를 변경하는 의미.

--데이터 조회
SELECT*FROM ex3_1;

--질의? col1의 컬럼에서 'ABC'인 데이터의 col2컬럼의 값을 100으로 변경하라.
UPDATE ex3_1            --ex3_1테이블의
SET col2 = 100          --col2값을 100으로 설정해라(결과)
WHERE col1 = 'ABC';     --col1값이 'ABC'위치에(조건)

--데이터 조회
SELECT*FROM ex3_1 WHERE col1 = 'ABC';

--데이터 조회
SELECT*FROM ex3_2 ORDER BY emp_id ASC;

--질의? ex3_2테이블에서 emp_id 컬럼의 데이터가 150인 데이터의 emp_name컬럼의 이름을 'Peter Tucker Junior'로 변경하여라
UPDATE ex3_2
SET emp_name = 'Peter Tucker Junior'
WHERE emp_id = 150;

--데이터 조회
SELECT*FROM ex3_2 WHERE emp_id = 150;


--시나리오 employees테이블에서 salary컬럼에서 급여가 8000이상인 데이터를 
--다음 컬럼으로 employee_id, emp_name, email, salary구성되는 테이블 (emp_salary_8000)을 생성해라.(테이블 복사 명령어)
CREATE TABLE emp_salary_8000
AS
SELECT employee_id, emp_name, email, salary FROM employees 
WHERE Salary >= 8000;

--데이터 조회
SELECT*FROM emp_salary_8000 ORDER BY employee_id ASC;


--질의? employees테이블 사원번호가 100인 데이터 email 컬럼을 'KINGS'로 변경하고 salary컬럼은 20000으로 변경하라.
UPDATE emp_salary_8000
SET email = 'KINGS', salary = 20000
WHERE employee_id = 100;

SELECT*FROM emp_salary_8000 WHERE employee_id = 100;

/*
--JOIN(조인)문법을 학습한 이후 진행합니다.
04 | MERGE문 
MERGE문은 조건을 비교해서 테이블에 해당 조건에 맞는 데이터가 없으면 INSERT, 있으면 UPDATE를 수행하는 문장이다. 
특정 조건에 따라 어떤 때는 INSERT를, 또 다른 경우에는 UPDATE문을 수행해야 할 때, 
과거에는 해당 조건을 처리하는 로직을 별도로 작성해야 했지만, 
MERGE문이 나온 덕분에 이제 한 문장으로 처리할 수 있게 되었다.

    MERGE INTO [스키마.]테이블명
        USING (update나 insert될 데이터 원천)
             ON (update될 조건)
    WHEN MATCHED THEN
           SET 컬럼1 = 값1, 컬럼2 = 값2, ...
    WHERE update 조건
           DELETE WHERE update_delete 조건
    WHEN NOT MATCHED THEN
           INSERT (컬럼1, 컬럼2, ...) VALUES (값1, 값2,...)
           WHERE insert 조건;
*/

















/*
05 | DELETE문
테이블에 있는 데이터를 삭제할 때 DELETE문을 사용한다.

    ① 일반 구문
    DELETE [FROM] [스키마.]테이블명
    WHERE delete 조건; 
*/

--emp_salary_8000테이블 사용
SELECT *FROM emp_salary_8000 ORDER BY employee_id ASC;

--데이터 삭제
DELETE FROM emp_salary_8000   --WHERE빼고 이것만 쓰면 모든 데이터가 삭제 된다.(※주의※)
WHERE employee_id = 100;

--emp_salary_8000테이블 확인
SELECT *FROM emp_salary_8000 WHERE employee_id = 100;

--시나리오? emp_salary_8000테이블 급여가 10000~13000범위의 데이터를 삭제하라
DELETE FROM emp_salary_8000
WHERE salary >= 1000 AND salary <= 13000;
/* 위의 AND구문과 동일
DELETE FROM emp_salary_8000
WHERE salary BETWEEN 1000 AND 13000;
*/
--emp_salary_8000테이블 확인
SELECT *FROM emp_salary_8000 WHERE salary >= 1000 AND salary <= 13000;

--시나리오? 사번이 101또는 145인 데이터를 삭제하라
SELECT *FROM emp_salary_8000;

DELETE FROM emp_salary_8000
WHERE employee_id = 101 OR employee_id =145;

--데이터 조회
SELECT *FROM emp_salary_8000 
WHERE employee_id = 101 OR employee_id =145;        --10, 145 등의 데이터는 추후 웹이나 스프링에서 받아 올 것이다.

COMMIT;

/*
TRUNCATE문
데이터를 삭제할 때는 DELETE문을 사용하는데 이와 같은 기능을 수행하는 문장이 바로 TRUNCATE문이다. 
DELETE문은 데이터를 삭제한 후에 COMMIT을 실행해야 데이터가 완전히 삭제되고, 
반대로 ROLLBACK을 실행하면 데이터가 삭제되기 전으로 복귀된다. 

하지만 DDL문에 속하는 TRUNCATE문은 한번 실행하면 데이터가 바로 삭제되고 
ROLLABCK을 실행하더라도 삭제 전 상태로 복귀되지 않는다. 
또한 TRUNCATE문에는 WHERE 조건을 붙일 수 없다.
즉 테이블 데이터 전체가 바로 삭제된다. 

복구할 방법이 없으므로 TRUNCATE문을 사용할 때는 항상 주의를 기울여야 한다.

    TRUNCATE TABLE [스키마명.]테이블명;
*/
--표 생성
CREATE TABLE ex3_4(
    employee_id NUMBER
);

--데이터 넣기
INSERT INTO ex3_4 VALUES(100);

--데이터 조??
SELECT*FROM ex3_4;

--롤백
ROLLBACK; --현재 입력한 데이터가 취소됨.

--데이터 조회
SELECT*FROM ex3_4;

INSERT INTO ex3_4 VALUES(100);

SELECT*FROM ex3_4;

COMMIT; --물리적인 데이터베이스 파일에 작업정보가 반영된다.

--조건식 WHERE절 문법이 지원이 안된다. ROLLBACK지원 안됨.
TRUNCATE TABLE ex3_4; --Table EX3_4이(가) 잘렸습니다.
--데이터를 물리적으로 삭제하는 것이 아니라 참조하는 부분을 잘라버린 것. 
--효과는 삭제와 같으며, 되돌릴수가 없다. 매우매우매우 주의하여 사용해야함.

ROLLBACK;

SELECT*FROM ex3_4;--롤백기능이 안되어, 삭제데이터가 복구되지 않음.


/*
07 | 의사컬럼
의사컬럼Pseudo-column이란 테이블의 컬럼처럼 동작하지만 실제로 테이블에 저장되지는 않는 컬럼을 말한다. 
SELECT 문에서는 의사컬럼을 사용할 수 있지만, 의사컬럼 값을 INSERT, UPDATE, DELETE 할 수는 없다. 
2장의 ‘06.시퀀스’ 절에서 학습했던 NEXTVAL, CURRVAL도 의사컬럼의 일종이다.
*/

--1) ROWNUM : 쿼리에서 반환되는 각 로우들에 대한 순서값을 나타내는 의사컬럼이다.(스프링 가서 매우 중요하게 사용 될 기능이다.)

SELECT ROWNUM, employee_id, emp_name FROM EMPLOYEES WHERE salary >= 5000; 

--화면에 출력되는 데이터를 제한
SELECT ROWNUM, employee_id, emp_name, salary FROM EMPLOYEES
WHERE ROWNUM <= 10;

--중간 범위 조건에 해당하는 데이터는 결과가 없다(중요)
SELECT ROWNUM, employee_id, emp_name, salary FROM EMPLOYEES
WHERE ROWNUM >=6 AND ROWNUM<=10; 



--2) ROWID : ROWID는 테이블에 저장된 각 로우가 저장된 주소 값을 가리키는 의사컬럼이다.
-- 각 로우를 식별하는 값이므로 ROWID는 유일한 값을 가진다.
SELECT ROWNUM,ROWID employee_id, emp_name, salary FROM EMPLOYEES
WHERE ROWNUM <=5;

/*
08 | 연산자 //NUMBER데이터 타입에 해당하는 컬럼 또는 숫자 데이터에 사용.
연산자Operator는 연산을 수행한다. 오라클은 다양한 연산자를 제공하고 있는데, 이들을 정리하면 다음과 같다.

수식 연산자: +, -, *, /
‘+’와 ‘-’는 연산 대상이 1개인 단항 연산자로 쓰일 때 각각 양수와 음수를 나타낸다. 또한 두 수의 연산, 
즉 이항 연산자로 사용될 때는 각각 덧셈과 뺄셈 연산을 한다. 그리고 ‘*’는 곱셈, ‘/’는 나눗셈 연산을 한다.

문자 연산자: ||
‘||’는 두 문자를 붙이는(연결하는) 연산을 수행한다. 다음 쿼리는 사원 테이블에서 “사번-사원명” 형태로 추출하는 SELECT 문이다.

입력

    SELECT employee_id || '-' || emp_name AS employee_info
      FROM employees
     WHERE ROWNUM < 5;
*/

--테이블 구조정보
DESC EMPLOYEES;

SELECT employee_id, salary, commission_pct, salary*12+commission_pct AS "연봉" FROM employees
ORDER BY employee_id;

--위의 출력 결과중 NULL로 확인되는 것은 컬럼데이터가 NULL이 존재하면, 결과가 NULL이 됩니다.
SELECT 10 + 20 FROM DUAL;

--연산시 NULL이 존재하면 결과는 NULL이 된다. NULL관련 기능은 NULL관련 함수를 학습해야 한다.
SELECT 10 + 20 + NULL FROM DUAL; -- NULL

/*
논리 연산자: >, <, >=, <=, =, <>, !=, \^=
논리 연산을 수행하는 연산자로 수학에서 사용하는 부등호와 쓰임새는 같다. 
단, 두 값이 같은지를 판단하는 등호 연산자(=)의 반대인 비동등 연산자로는 ‘< >’, ‘!=’, ‘\^=’가 있는데, 
이 세 연산자의 사용법과 반환 결과는 모두 같다. 
또한 값을 비교할 때 숫자 뿐만 아니라 문자와 날짜형도 비교 가능하다.
*/

/*
문법참조 : https://gent.tistory.com/311
09 | 표현식 
표현식Expression이란 한 개 이상의 값과 연산자, SQL 함수 등이 결합된 식이다. 
이 절에서는 특정 조건에 따라 값을 변경해서 보이는 CASE 표현식(흔히 CASE문이라고도 한다)에 대해 알아 보자.

    CASE WHEN 조건1 THEN 값1
         WHEN 조건2 THEN 값2
    ...
         ELSE 기타 값
    END
*/

SELECT employee_id, emp_name, department_id FROM employees ORDER BY department_id;

--[case문 유형]
-- 1) if문 유형 /   department_id컬럼이 데이터가 10번이면 New York, 20번이면 Dallas , 기타는 Unknown 조회라가
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

-- 2) switch 유형
SELECT employee_id, emp_name, department_id,
    CASE department_id
            WHEN 10 THEN 'New York'
            WHEN 20 THEN 'Dallas'
            ELSE 'Unknown'
    END AS department_city
FROM
     employeeS
ORDER BY department_id ;

--ELSE를 생략한 경우 조건이 만족되는 것이 없으면 NULL로 반환된다.
SELECT 
        employee_id, emp_name, department_id,
    CASE 
      WHEN department_id = 10 THEN 'New York'
      WHEN department_id = 20 THEN 'Dallas'
--      ELSE 'Unknown'  --''은 NULL을 의미한다. 공백으로 처리하고 싶으면 ' '로 넣어준다. 
      END AS department_city
FROM 
    employees
ORDER BY department_id ;

--시나리오 : salary(급여)가 15000 이상이면 고액연봉, 10000이상이면 우수연봉 나머지는 일반연봉으로 출력하라.
--사원번호, 이름, 급여, 연봉구분
SELECT 
        employee_id, emp_name, salary,
    CASE 
      WHEN salary >= 15000 THEN '고액연봉'
      WHEN salary >= 10000 THEN '우수연봉'
      ELSE '일반연봉'
      END AS salary_gubun
FROM 
    employees
ORDER BY salary ;


--중첩 case추가 연산작업 가능,
SELECT 
        employee_id, emp_name, department_id,salary,
    CASE 
      WHEN department_id = 10 THEN 
            CASE
                WHEN salary >= 15000 THEN '1등급'
                WHEN salary >= 10000 THEN '2등급'
                WHEN salary >= 3000 THEN '3등급'
            END
      WHEN department_id = 20 THEN
            CASE
                WHEN salary >= 18000 THEN '1등급'
                WHEN salary >= 15000 THEN '2등급'
                WHEN salary >= 5000 THEN '3등급'
            END
     WHEN department_id = 30 THEN 
            CASE
                WHEN salary >= 8000 THEN '1등급'
                WHEN salary >= 5000 THEN '2등급'
                WHEN salary >= 2000 THEN '3등급'
            END
      ELSE ' '
      END AS salary_gubun
FROM 
    employees
ORDER BY department_id ;



/*
비교 조건식
비교 조건식은 논리 연산자나 ANY, SOME, ALL 키워드로 비교하는 조건식을 말한다. 
여기서는 ANY, SOME, ALL 비교에 대해서 알아 볼텐데 먼저 ANY를 살펴 보자.
*/
--salary(급여)가 2000 또는 3000 또는 4000인 데이터 // 1)과 2)는 동일하다.
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

--3) salary(급여)rk 2000이고, 3000이고, 4000인 데이터를 조회하라 -> 논리적인 문제 존재, 결과 없음.
 SELECT employee_id, salary
 FROM employees
 WHERE salary = ALL (2000, 3000, 4000) --한번에 2000, 3000, 4000인 데이터는 존재하지 않는다.
 ORDER BY employee_id;

--4)급여가 4000보다 큰 데이터를 조회
 SELECT employee_id, salary
 FROM employees
 WHERE salary > ALL (2000, 3000, 4000)
 ORDER BY employee_id;

--5) 급여가 2000보다 큰 데이터, 3000보다 큰 데이터, 4000보다 큰 데이터를 조회
--ANY, SOME은 동일하다. 
 SELECT employee_id, salary
 FROM employees
 WHERE salary > ANY (2000, 3000, 4000)
 ORDER BY employee_id;
   
 SELECT employee_id, salary
 FROM employees
 WHERE salary > SOME (2000, 3000, 4000)
 ORDER BY employee_id;
    
    
    
/*
    논리 조건식
논리 조건식은 조건절에서 AND, OR, NOT을 사용하는 조건식을 말한다. 
AND는 모든 조건을 만족해야 하고 OR는 여러 조건 중 하나만 만족해도 TRUE를 반환된다. 
NOT은 조건식 평가 결과가 거짓(FALSE)일 때 원하는 결과, 즉 TRUE를 반환한다.   
*/
-- 위와 아래가 같다. 그런데 표현의 차이가 있는 이유 : 성능의 차이, 같은 결과를 나타내지만 성능이 다를 수 있다.
--salary라는 급여 컬럼에 데이터 분포도에 따라 성능이 다를 수 있다.
 SELECT employee_id, salary
      FROM employees
     WHERE NOT ( salary >= 2500) --salary < 2500과 동일.
     ORDER BY employee_id;

 SELECT employee_id, salary
      FROM employees
     WHERE salary < 2500
     ORDER BY employee_id;
    
 /*
 NULL 조건식
NULL 조건식은 특정 값이 NULL인지 여부를 체크하는 조건식이다. 
앞서 UPDATE문을 알아 보면서 NULL인지 여부는 IS NULL과 IS NOT NULL로 체크한다는 내용을 학습했다. 
다시 강조하지만 특정 컬럼 값이 NULL인지의 여부를 체크할 때 등호 연산자(=, < >)를 사용하면 제대로 비교하지 못한다. 
예를 들어, 급여가 NULL인지 혹은 아닌지 여부를 체크하려면 “salary = NULL” 혹은 “salary < > NULL” 형태로 비교하면 안 ?품? 
“salary IS NULL” 혹은 “salary IS NOT NULLL” 형태로 비교해야 한다.
 */   
--조건식에서 사용 되는 IS NULL, IS NOT NULL
-- commission_pct 컬럼의 데이터가 NULL
SELECT employee_id, emp_name, salary, commission_pct FROM employees
WHERE commission_pct IS NULL;

--commission_pct 컬럼의 데이터가 NOT NULL
SELECT employee_id, emp_name, salary, commission_pct FROM employees
WHERE commission_pct IS NOT NULL;


/*
IN 조건식
IN 조건식은 조건절에 명시한 값이 포함된 건을 반환하는데 앞에서 배웠던 ANY와 비슷하다.
*/
--이 쿼리는 급여가 2000, 3000, 4000에 포함되는 사원을 추출한 결과
SELECT employee_id, emp_name, salary FROM employees
WHERE salary IN(2000,3000,4000); --OR로 변환이 가능

-- 이 쿼리는 급여가 2000, 3000, 4000에 포함되지 않는 사원을 추출한 결과
-- 조건을 풀어 쓰면 “salary < > 2000 AND salary < > 3000 AND salary < > 4000”이며, “< >ALL”로도 바꿔 쓸 수 있다.
SELECT employee_id, salary 
FROM employees
WHERE salary NOT IN(2000,3000,4000); 
ORDER BY employee_id;

--EXISTS 조건식: 조인(join)문법 매우고 난 이후에

/*
LIKE 조건식
LIKE 조건식은 문자열의 패턴을 검색할 때 사용하는 조건식이다. 
*/
--예를 들어, 사원 테이블에서 사원이름이 ‘A’로 시작되는 사원을 조회하는 쿼리를 작성한다면 다음과 같이 LIKE 조건식을 사용한다.
   SELECT emp_name
   FROM employees
   WHERE emp_name LIKE 'A%'
   ORDER BY emp_name;

-- 잘못 쓴경우 Like가 빠져있다. '='이 들어가면 안된다.
    SELECT emp_name
    FROM employees
    wHERE emp_name = 'A%'
    ORDER BY emp_name;

--AI로 시작되는 모든 사원을 조회한 쿼리다.
   SELECT emp_name
   FROM employees
   WHERE emp_name LIKE 'Al%'
   ORDER BY emp_name;

/*
 ‘%’는 앞, 뒤, 중간 어디나 올 수 있으며 조건식을 검색할 때 대소문자를 구분한다는 점을 주의하자. 
 ‘%’와는 다르게 ‘_’(밑줄, 언더스코어)는 나머지 글자 전체가 아닌 한 글자만 비교한다.
*/
CREATE TABLE ex3_5 (
    name VARCHAR2(30)
);

INSERT INTO ex3_5 VALUES('홍길동');
INSERT INTO ex3_5 VALUES('홍길용');
INSERT INTO ex3_5 VALUES('홍길상');
INSERT INTO ex3_5 VALUES('홍길상동');
INSERT INTO ex3_5 VALUES('홍길');

SELECT*FROM ex3_5;

--홍길로 시작하는 이름을 조회하라. 
--결과 : '홍길'이란 두글자도 들어있다. %는 길이가 0개의 의미도 포함 된 것이다.
SELECT*FROM ex3_5
WHERE name LIKE '홍길%';

--홍길로 시작하는 전체 3글자 이름을 조회하라.
SELECT*FROM ex3_5
WHERE name LIKE '홍길_';


COMMIT;

ERE salary = ALL (2000, 3000, 4000) --한번에 2000, 3000, 4000인 데이터는 존재하지 않는다.
 ORDER BY employee_id;

--4)급여가 4000보다 큰 데이터를 조회
 SELECT employee_id, salary
 FROM employees
 WHERE salary > ALL (2000, 3000, 4000)
 ORDER BY employee_id;

--5) 급여가 2000보다 큰 데이터, 3000보다 큰 데이터, 4000보다 큰 데이터를 조회
--ANY, SOME은 동일하다. 
 SELECT employee_id, salary
 FROM employees
 WHERE salary > ANY (2000, 3000, 4000)
 ORDER BY employee_id;














/*
05 | DELETE문
테이블에 있는 데이터를 삭제할 때 DELETE문을 사용한다.

    ① 일반 구문
    DELETE [FROM] [스키마.]테이블명
    WHERE delete 조건; 
*/

--emp_salary_8000테이블 사용
SELECT *FROM emp_salary_8000 ORDER BY employee_id ASC;

--데이터 삭제
DELETE FROM emp_salary_8000   --WHERE빼고 이것만 쓰면 모든 데이터가 삭제 된다.(※주의※)
WHERE employee_id = 100;

--emp_salary_8000테이블 확인
SELECT *FROM emp_salary_8000 WHERE employee_id = 100;

--시나리오? emp_salary_8000테이블 급여가 10000~13000범위의 데이터를 삭제하라
DELETE FROM emp_salary_8000
WHERE salary >= 1000 AND salary <= 13000;
/* 위의 AND구문과 동일
DELETE FROM emp_salary_8000
WHERE salary BETWEEN 1000 AND 13000;
*/
--emp_salary_8000테이블 확인
SELECT *FROM emp_salary_8000 WHERE salary >= 1000 AND salary <= 13000;

--시나리오? 사번이 101또는 145인 데이터를 삭제하라
SELECT *FROM emp_salary_8000;

DELETE FROM emp_salary_8000
WHERE employee_id = 101 OR employee_id =145;

--데이터 조회
SELECT *FROM emp_salary_8000 
WHERE employee_id = 101 OR employee_id =145;        --10, 145 등의 데이터는 추후 웹이나 스프링에서 받아 올 것이다.

COMMIT;

/*
TRUNCATE문
데이터를 삭제할 때는 DELETE문을 사용하는데 이와 같은 기능을 수행하는 문장이 바로 TRUNCATE문이다. 
DELETE문은 데이터를 삭제한 후에 COMMIT을 실행해야 데이터가 완전히 삭제되고, 
반대로 ROLLBACK을 실행하면 데이터가 삭제되기 전으로 복귀된다. 

하지만 DDL문에 속하는 TRUNCATE문은 한번 실행하면 데이터가 바로 삭제되고 
ROLLABCK을 실행하더라도 삭제 전 상태로 복귀되지 않는다. 
또한 TRUNCATE문에는 WHERE 조건을 붙일 수 없다.
즉 테이블 데이터 전체가 바로 삭제된다. 

복구할 방법이 없으므로 TRUNCATE문을 사용할 때는 항상 주의를 기울여야 한다.

    TRUNCATE TABLE [스키마명.]테이블명;
*/
--표 생성
CREATE TABLE ex3_4(
    employee_id NUMBER
);

--데이터 넣기
INSERT INTO ex3_4 VALUES(100);

--데이터 조회
SELECT*FROM ex3_4;

--롤백
ROLLBACK; --현재 입력한 데이터가 취소됨.

--데이터 조회
SELECT*FROM ex3_4;

INSERT INTO ex3_4 VALUES(100);

SELECT*FROM ex3_4;

COMMIT; --물리적인 데이터베이스 파일에 작업정보가 반영된다.

--조건식 WHERE절 문법이 지원이 안된다. ROLLBACK지원 안됨.
TRUNCATE TABLE ex3_4; --Table EX3_4이(가) 잘렸습니다.
--데이터를 물리적으로 삭제하는 것이 아니라 참조하는 부분을 잘라버린 것. 
--효과는 삭제와 같으며, 되돌릴수가 없다. 매우매우매우 주의하여 사용해야함.

ROLLBACK;

SELECT*FROM ex3_4;--롤백기능이 안되어, 삭제데이터가 복구되지 않음.


/*
07 | 의사컬럼
의사컬럼Pseudo-column이란 테이블의 컬럼처럼 동작하지만 실제로 테이블에 저장되지는 않는 컬럼을 말한다. 
SELECT 문에서는 의사컬럼을 사용할 수 있지만, 의사컬럼 값을 INSERT, UPDATE, DELETE 할 수는 없다. 
2장의 ‘06.시퀀스’ 절에서 학습했던 NEXTVAL, CURRVAL도 의사컬럼의 일종이다.
*/

--1) ROWNUM : 쿼리에서 반환되는 각 로우들에 대한 순서값을 나타내는 의사컬럼이다.(스프링 가서 매우 중요하게 사용 될 기능이다.)

SELECT ROWNUM, employee_id, emp_name FROM EMPLOYEES WHERE salary >= 5000; 

--화면에 출력되는 데이터를 제한
SELECT ROWNUM, employee_id, emp_name, salary FROM EMPLOYEES
WHERE ROWNUM <= 10;

--중간 범위 조건에 해당하는 데이터는 결과가 없다(중요)
SELECT ROWNUM, employee_id, emp_name, salary FROM EMPLOYEES
WHERE ROWNUM >=6 AND ROWNUM<=10; 



--2) ROWID : ROWID는 테이블에 저장된 각 로우가 저장된 주소 값을 가리키는 의사컬럼이다.
-- 각 로우를 식별하는 값이므로 ROWID는 유일한 값을 가진다.
SELECT ROWNUM,ROWID employee_id, emp_name, salary FROM EMPLOYEES
WHERE ROWNUM <=5;

/*
08 | 연산자 //NUMBER데이터 타입에 해당하는 컬럼 또는 숫자 데이터에 사용.
연산자Operator는 연산을 수행한다. 오라클은 다양한 연산자를 제공하고 있는데, 이들을 정리하면 다음과 같다.

수식 연산자: +, -, *, /
‘+’와 ‘-’는 연산 대상이 1개인 단항 연산자로 쓰일 때 각각 양수와 음수를 나타낸다. 또한 두 수의 연산, 
즉 이항 연산자로 사용될 때는 각각 덧셈과 뺄셈 연산을 한다. 그리고 ‘*’는 곱셈, ‘/’는 나눗셈 연산을 한다.

문자 연산자: ||
‘||’는 두 문자를 붙이는(연결하는) 연산을 수행한다. 다음 쿼리는 사원 테이블에서 “사번-사원명” 형태로 추출하는 SELECT 문이다.

입력

    SELECT employee_id || '-' || emp_name AS employee_info
      FROM employees
     WHERE ROWNUM < 5;
*/

--테이블 구조정보
DESC EMPLOYEES;

SELECT employee_id, salary, commission_pct, salary*12+commission_pct AS "연봉" FROM employees
ORDER BY employee_id;

--위의 출력 결과중 NULL로 확인되는 것은 컬럼데이터가 NULL이 존재하면, 결과가 NULL이 됩니다.
SELECT 10 + 20 FROM DUAL;

--연산시 NULL이 존재하면 결과는 NULL이 된다. NULL관련 기능은 NULL관련 함수를 학습해야 한다.
SELECT 10 + 20 + NULL FROM DUAL; -- NULL

/*
논리 연산자: >, <, >=, <=, =, <>, !=, \^=
논리 연산을 수행하는 연산자로 수학에서 사용하는 부등호와 쓰임새는 같다. 
단, 두 값이 같은지를 판단하는 등호 연산자(=)의 반대인 비동등 연산자로는 ‘< >’, ‘!=’, ‘\^=’가 있는데, 
이 세 연산자의 사용법과 반환 결과는 모두 같다. 
또한 값을 비교할 때 숫자 뿐만 아니라 문자와 날짜형도 비교 가능하다.
*/

/*
문법참조 : https://gent.tistory.com/311
09 | 표현식 
표현식Expression이란 한 개 이상의 값과 연산자, SQL 함수 등이 결합된 식이다. 
이 절에서는 특정 조건에 따라 값을 변경해서 보이는 CASE 표현식(흔히 CASE문이라고도 한다)에 대해 알아 보자.

    CASE WHEN 조건1 THEN 값1
         WHEN 조건2 THEN 값2
    ...
         ELSE 기타 값
    END
*/

SELECT employee_id, emp_name, department_id FROM employees ORDER BY department_id;

--[case문 유형]
-- 1) if문 유형 /   department_id컬럼이 데이터가 10번이면 New York, 20번이면 Dallas , 기타는 Unknown 조회라가
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

-- 2) switch 유형
SELECT employee_id, emp_name, department_id,
    CASE department_id
            WHEN 10 THEN 'New York'
            WHEN 20 THEN 'Dallas'
            ELSE 'Unknown'
    END AS department_city
FROM
     employeeS
ORDER BY department_id ;

--ELSE를 생략한 경우 조건이 만족되는 것이 없으면 NULL로 반환된다.
SELECT 
        employee_id, emp_name, department_id,
    CASE 
      WHEN department_id = 10 THEN 'New York'
      WHEN department_id = 20 THEN 'Dallas'
--      ELSE 'Unknown'  --''은 NULL을 의미한다. 공백으로 처리하고 싶으면 ' '로 넣어준다. 
      END AS department_city
FROM 
    employees
ORDER BY department_id ;

--시나리오 : salary(급여)가 15000 이상이면 고액연봉, 10000이상이면 우수연봉 나머지는 일반연봉으로 출력하라.
--사원번호, 이름, 급여, 연봉구분
SELECT 
        employee_id, emp_name, salary,
    CASE 
      WHEN salary >= 15000 THEN '고액연봉'
      WHEN salary >= 10000 THEN '우수연봉'
      ELSE '일반연봉'
      END AS salary_gubun
FROM 
    employees
ORDER BY salary ;


--중첩 case추가 연산작업 가능,
SELECT 
        employee_id, emp_name, department_id,salary,
    CASE 
      WHEN department_id = 10 THEN 
            CASE
                WHEN salary >= 15000 THEN '1등급'
                WHEN salary >= 10000 THEN '2등급'
                WHEN salary >= 3000 THEN '3등급'
            END
      WHEN department_id = 20 THEN
            CASE
                WHEN salary >= 18000 THEN '1등급'
                WHEN salary >= 15000 THEN '2등급'
                WHEN salary >= 5000 THEN '3등급'
            END
     WHEN department_id = 30 THEN 
            CASE
                WHEN salary >= 8000 THEN '1등급'
                WHEN salary >= 5000 THEN '2등급'
                WHEN salary >= 2000 THEN '3등급'
            END
      ELSE ' '
      END AS salary_gubun
FROM 
    employees
ORDER BY department_id ;



/*
비교 조건식
비교 조건식은 논리 연산자나 ANY, SOME, ALL 키워드로 비교하는 조건식을 말한다. 
여기서는 ANY, SOME, ALL 비교에 대해서 알아 볼텐데 먼저 ANY를 살펴 보자.
*/
--salary(급여)가 2000 또는 3000 또는 4000인 데이터 // 1)과 2)는 동일하다.
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

--3) salary(급여)rk 2000이고, 3000이고, 4000인 데이터를 조회하라 -> 논리적인 문제 존재, 결과 없음.
 SELECT employee_id, salary
 FROM employees
 WHERE salary = ALL (2000, 3000, 4000) --한번에 2000, 3000, 4000인 데이터는 존재하지 않는다.
 ORDER BY employee_id;

--4)급여가 4000보다 큰 데이터를 조회
 SELECT employee_id, salary
 FROM employees
 WHERE salary > ALL (2000, 3000, 4000)
 ORDER BY employee_id;

--5) 급여가 2000보다 큰 데이터, 3000보다 큰 데이터, 4000보다 큰 데이터를 조회
--ANY, SOME은 동일하다. 
 SELECT employee_id, salary
 FROM employees
 WHERE salary > ANY (2000, 3000, 4000)
 ORDER BY employee_id;
   
 SELECT employee_id, salary
 FROM employees
 WHERE salary > SOME (2000, 3000, 4000)
 ORDER BY employee_id;
    
    
    
/*
    논리 조건식
논리 조건식은 조건절에서 AND, OR, NOT을 사용하는 조건식을 말한다. 
AND는 모든 조건을 만족해야 하고 OR는 여러 조건 중 하나만 만족해도 TRUE를 반환된다. 
NOT은 조건식 평가 결과가 거짓(FALSE)일 때 원하는 결과, 즉 TRUE를 반환한다.   
*/
-- 위와 아래가 같다. 그런데 표현의 차이가 있는 이유 : 성능의 차이, 같은 결과를 나타내지만 성능이 다를 수 있다.
--salary라는 급여 컬럼에 데이터 분포도에 따라 성능이 다를 수 있다.
 SELECT employee_id, salary
      FROM employees
     WHERE NOT ( salary >= 2500) --salary < 2500과 동일.
     ORDER BY employee_id;

 SELECT employee_id, salary
      FROM employees
     WHERE salary < 2500
     ORDER BY employee_id;
    
 /*
 NULL 조건식
NULL 조건식은 특정 값이 NULL인지 여부를 체크하는 조건식이다. 
앞서 UPDATE문을 알아 보면서 NULL인지 여부는 IS NULL과 IS NOT NULL로 체크한다는 내용을 학습했다. 
다시 강조하지만 특정 컬럼 값이 NULL인지의 여부를 체크할 때 등호 연산자(=, < >)를 사용하면 제대로 비교하지 못한다. 
예를 들어, 급여가 NULL인지 혹은 아닌지 여부를 체크하려면 “salary = NULL” 혹은 “salary < > NULL” 형태로 비교하면 안 되고 
“salary IS NULL” 혹은 “salary IS NOT NULLL” 형태로 비교해야 한다.
 */   
--조건식에서 사용 되는 IS NULL, IS NOT NULL
-- commission_pct 컬럼의 데이터가 NULL
SELECT employee_id, emp_name, salary, commission_pct FROM employees
WHERE commission_pct IS NULL;

--commission_pct 컬럼의 데이터가 NOT NULL
SELECT employee_id, emp_name, salary, commission_pct FROM employees
WHERE commission_pct IS NOT NULL;


/*
IN 조건식
IN 조건식은 조건절에 명시한 값이 포함된 건을 반환하는데 앞에서 배웠던 ANY와 비슷하다.
*/
--이 쿼리는 급여가 2000, 3000, 4000에 포함되는 사원을 추출한 결과
SELECT employee_id, emp_name, salary FROM employees
WHERE salary IN(2000,3000,4000); --OR로 변환이 가능

-- 이 쿼리는 급여가 2000, 3000, 4000에 포함되지 않는 사원을 추출한 결과
-- 조건을 풀어 쓰면 “salary < > 2000 AND salary < > 3000 AND salary < > 4000”이며, “< >ALL”로도 바꿔 쓸 수 있다.
SELECT employee_id, salary 
FROM employees
WHERE salary NOT IN(2000,3000,4000); 
ORDER BY employee_id;

--EXISTS 조건식: 조인(join)문법 매우고 난 이후에

/*
LIKE 조건식
LIKE 조건식은 문자열의 패턴을 검색할 때 사용하는 조건식이다. 
*/
--예를 들어, 사원 테이블에서 사원이름이 ‘A’로 시작되는 사원을 조회하는 쿼리를 작성한다면 다음과 같이 LIKE 조건식을 사용한다.
   SELECT emp_name
   FROM employees
   WHERE emp_name LIKE 'A%'
   ORDER BY emp_name;

-- 잘못 쓴경우 Like가 빠져있다. '='이 들어가면 안된다.
    SELECT emp_name
    FROM employees
    wHERE emp_name = 'A%'
    ORDER BY emp_name;

--AI로 시작되는 모든 사원을 조회한 쿼리다.
   SELECT emp_name
   FROM employees
   WHERE emp_name LIKE 'Al%'
   ORDER BY emp_name;

/*
 ‘%’는 앞, 뒤, 중간 어디나 올 수 있으며 조건식을 검색할 때 대소문자를 구분한다는 점을 주의하자. 
 ‘%’와는 다르게 ‘_’(밑줄, 언더스코어)는 나머지 글자 전체가 아닌 한 글자만 비교한다.
*/
CREATE TABLE ex3_5 (
    name VARCHAR2(30)
);

INSERT INTO ex3_5 VALUES('홍길동');
INSERT INTO ex3_5 VALUES('홍길용');
INSERT INTO ex3_5 VALUES('홍길상');
INSERT INTO ex3_5 VALUES('홍길상동');
INSERT INTO ex3_5 VALUES('홍길');

SELECT*FROM ex3_5;

--홍길로 시작하는 이름을 조회하라. 
--결과 : '홍길'이란 두글자도 들어있다. %는 길이가 0개의 의미도 포함 된 것이다.
SELECT*FROM ex3_5
WHERE name LIKE '홍길%';

--홍길로 시작하는 전체 3글자 이름을 조회하라.
SELECT*FROM ex3_5
WHERE name LIKE '홍길_';


COMMIT;

