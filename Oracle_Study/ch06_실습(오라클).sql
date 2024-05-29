-------------------------24.04.15(월)--------------
-- [조인] 
-- 정의 : 2개의 테이블에서 컬럼끼리 데이터를 비교하여, 동일한 데이터행을 수평적으로 결합하는 기능.
/*
표준 : 오라클 조인과 ANSI조인

조인은 내부조인(INNER JOIN)과 외부조인(OUTER JOIN)으로 구분한다.
- 내부조인(INNER JOIN): 일반적인 조인을 얘기하면, INNER JOIN.
  : 컬럼끼리 비교시 일치되는 데이터를 수평적으로 결합.

- 외부조인 (OUTER JOIN): inner join의 결과에 일치되지 않는 데이터도 포함되는 의미.
  1) LEFT OUTER JOIN
  2) RIGHT OUTER JOIN
  3) FULL OUTER JOIN
*/
--질의? 사원번호, 이름, 부서명을 조회하라.
/*
사원테이블 : 사원번호, 이름
부서테이블 : 부서명
-> 질의로 인해 하나로 결과를 출력하고자 한다. 
*/
/* 문법
SELECT 사원번호, 이름, 부서명
FROM 사원테이블, 부서테이블
WHERE 사원테이블.수버코드 = 부서진 테이블.부서코드;
*/
--------------------- 내부조인(INNER JOIN)-예제--------------------
-- * : employees, departments테이블의 모든 컬럼
SELECT *
FROM employees, departments
WHERE employees.department_id = departments.department_id;

SELECT employee_id, emp_name, department_name  --2. 얘네를 찾아서
FROM employees, departments  --1. 여기 테이블에서
WHERE employees.department_id = departments.department_id;  --3. 이렇게 만들어라

-- 테이블 별칭을 사용하여 INNER JOIN하는 구문
SELECT a.employee_id, a.emp_name, b.department_name    --2. 원하는 컬럼 별칭으로 참조해서 작성
FROM employees a, departments b             --1. 여기서 먼저 별칭 정해주기(별칭은 내맘대로)
WHERE a.department_id = b.department_id;    -- 3. 원하는 결과 별칭 참조해서 작성.

-- 첫 예제와 동일한 시나리오를 "ANSI JOIN(INNER JOIN)"로 작성하기.
SELECT employee_id, emp_name, department_name  
FROM employees INNER JOIN departments             -- ',' 대신 INNER JOIN 작성
ON employees.department_id = departments.department_id;    -- WHERE 대신 ON 작성

-- ANSI JOINT을 사용한 첫예제를 "별칭"을 사용해서 표현해보기
SELECT e.employee_id, e.emp_name, d.department_name  
FROM employees e INNER JOIN departments d             -- ',' 대신 INNER JOIN 작성
ON e.department_id = d.department_id;    -- WHERE 대신 ON 작성

----------------------------시나리오---------------------------------------
-- 시나리오 EMP테이블과 DEPT테이블을 조인하여, 데이터를 출력하라.
SELECT e_id, e_name, d_name
FROM emp,dept
WHERE emp.d_code = dept.d_code;

-- 위 시나리오 중 사원번호가 1001번인 사람만 불러오기
SELECT e_id, e_name, d_name
FROM emp,dept
WHERE emp.d_code = dept.d_code
AND emp.e_id = 1001;

-- 두번째 예제와 동일한 시나리오를 ANSI JOIN(INNER JOIN)로 작성하기.
SELECT e_id, e_name, d_name
FROM emp INNER JOIN dept
ON emp.d_code = dept.d_code;

SELECT e_id, e_name, d_name
FROM emp INNER JOIN dept       -- ','를 INNER JOIN으로 작성
ON emp.d_code = dept.d_code    -- WHERE를 ON으로 작성
WHERE emp.e_id = 1001;         --AND를 WHERE로 작성


--------테이블 3개 조인---------
SELECT *
FROM employees, departments, job_history
WHERE employees.department_id = departments.department_id
AND departments.department_id = job_history.department_id;

-- 위 예제를 ANSI조인으로 
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
외부조인(OUTER JOIN)
*/
-- ① 일반 조인
    --일치되는 데이터만 수평적인 결합으로 출력 
    SELECT a.department_id, a.department_name, b.job_id, b.department_id
      FROM departments a,
           job_history b
     WHERE a.department_id = b.department_id;
-- 일치되는 데이터행과 일치되지 않는 데이터도 포함하여 출력. 
-- 즉, job_history 테이블을 부서번호 값을 조건으로 조인한 결과다. 따라서 job_hisotry에 없는 부서는 조회되지 않았다. 

-- ② 외부 조인
    -- departments 테이블 : 모든 부서정보 / job_history 테이블 : 부서가 일한 프로젝트 정보가 존재. (+) 표시  
    -- 1)LEFT OUTER JOIN /(31건)
    SELECT a.department_id, a.department_name, b.job_id, b.department_id
    FROM departments a, job_history b
    WHERE a.department_id = b.department_id (+) ;   -- b에 존재하지 않고 a에 있는 데이터도 포함시켜 출력해라.
    -- b테이블은 a테이블보다 데이터가 적다. (+)는 데이터가 더 적은 테이블에 붙인다. ????????????????
    --그리고 데이터수가 더 많은 테이블의 위치에 따라 left, right테이블 명칭이 바뀐다. ??????????????

    -- 2)RIGHT OUTER JOIN /(31건)
    SELECT a.department_id, a.department_name, b.job_id, b.department_id
    FROM job_history b, departments a               -- 자리 바꾸기
    WHERE b.department_id (+) = a.department_id;    -- 자리바꾸기
     
    -- 1)과 2)는 동일한 결과를 출력한다.

    --3) LEFT OUTER JOIN /(10건)
    -- job_history 테이블에 일치하지 않는 부서가 존재하지 않는다.
    SELECT a.department_id, a.department_name, b.job_id, b.department_id
    FROM job_history b, departments a              
    WHERE b.department_id = a.department_id(+); --(+)를 데이터가 더 많은쪽에 붙이면 의미가 없다.
    
    --4) INNER JOIN /(10건)
    SELECT a.department_id, a.department_name, b.job_id, b.department_id
    FROM job_history b, departments a              
    WHERE b.department_id = a.department_id;
    
    -- 3)과 4)는 동일한 결과를 출력한다. / job_history가 departments의 부분집합니다.
-------------------------24.04.16(화)-------------------------    

    --5) FULL OUTER JOIN / 오라클에서는 FUPP OUTER JOIN을 지원하지 않는다. 하고싶으면 ANSI JOIN으로 작성해야한다.
    SELECT a.department_id, a.department_name, b.job_id, b.department_id
    FROM job_history b, departments a              
    WHERE b.department_id(+) = a.department_id(+);

-- ANSI JOIN(OUTER JOIN)으로 변환작업
-- LETR OUTER JOIN
    SELECT a.department_id, a.department_name, b.job_id, b.department_id
    FROM departments a LEFT OUTER JOIN job_history b
    ON a.department_id = b.department_id;

-- RIGHT OUTER JOIN
    SELECT a.department_id, a.department_name, b.job_id, b.department_id
    FROM job_history b RIGHT OUTER JOIN  departments a 
    ON b.department_id = a.department_id;

-- FULL OUTER JOIN /왼쪽에 포함되지 않는 데이터, 오른쪽에도 포함되지 않는데이터 모두 뽑고 싶을때 사용, 그러지 않을 때 사용하면 효율 떨어짐
    SELECT a.department_id, a.department_name, b.job_id, b.department_id
    FROM job_history b FULL OUTER JOIN  departments a  
    ON b.department_id = a.department_id;



/*
셀프 조인
셀프란 말에서 알 수 있듯이, 셀프 조인(SELF-JOIN)은 서로 다른 두 테이블이 아닌 동일한 한 테이블을 사용해 조인하는 방법을 말한다.
*/
    SELECT a.employee_id, a.emp_name, b.employee_id, b.emp_name, a.department_id
    FROM employees a,employees b  -- 같은 테이블인데 별칭을 다르게 주었다. 메모리 상에서는 구조는 같지만 다르게보는..?
    WHERE a.employee_id < b.employee_id -- 사원번호 대소비교 처리 해서 수평적으로 출력
    AND a.department_id = b.department_id
    AND a.department_id = 20;

    -- 사원테이블에서 부서코드가 20인 사원을 출력하라.
    SELECT employee_id, emp_name, department_id
    FROM employees -- 
    WHERE department_id = 20; -- 조건)부서코드 20

/*
카타시안 조인  //※ ANSI JOIN의 CROSS JOIN과 동일하다.
카타시안 조인(CATASIAN PRODUCT)은 WHERE 절에 조인 조건이 없는 조인을 말한다. 
즉 FROM 절에 테이블을 명시했으나, 두 테이블 간 조인 조건이 없는 조인이다.
// 연구목적일 때 많이 사용한다고 한다.

조인 조건이 없으므로 그 결과는 두 테이블 건수의 곱이다. 
즉 A 테이블 건수가 n1, B 테이블 건수가 n2라고 한다면, 결과 건수는 ‘n1 * n2’가 된다.
*/
-- WHERE절 : 조인조건식이 없다.
/*
1   A
2   B
3   C   
4   D
>> 1-A, 1-B, 1-C, 1-D/ 2-A,2-B,2-C,2-D~~/ : 총 16개의 데이터가 만들어진다.
*/
    SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
    FROM employees a, --107
    departments b; --27
           --왜 50건...? ?? 복붙인데..?  >> 이거 스크롤 내리니까 늘어난다. 2889건(107*27건)
 /*          
CROSS JOIN
<ANSI 문법>
*/
    SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
    FROM employees a
    CROSS JOIN departments b;           
           
           
--문법사용 중 헷갈리는 경우
-- < 잘못된 경우> / USING을 썼을 때는 b.department_id 별칭을 생략해야 한다.
    SELECT a.employee_id, a.emp_name, b.department_id, b.department_name 
    FROM employees a
    INNER JOIN departments b
    USING (department_id)  -- ON a.department_id = b.department_id // USING는 코딩을 효율적으로 하기 위해 나온것이다. 여기만 봐도 ㅐㅜ을 사용 했을 때보다 코드양이 줄었다.
    WHERE a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');
     
--<잘 된 경우>
    -- b.department_id컬럼명이 별칭이 생략 되어야 함.
    SELECT a.employee_id, a.emp_name, department_id, b.department_name
    FROM employees a
    INNER JOIN departments b
    USING (department_id) -- 여기 때문에 b.department_id 별칭을 없애야 한다.
    WHERE a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');     

    --ON을 사용 했을 때는 department_id에 별칭을 꼭 붙여야 한다.
    SELECT a.employee_id, a.emp_name, department_id, b.department_name 
    FROM employees a
    INNER JOIN departments b
    ON a.department_id = b.department_id
    WHERE a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');


---------------서브쿼리 : 여기부터 난이도 up--------------
/*
04 | 서브 쿼리
서브 쿼리Sub-Query 란 한 SQL 문장 안에서 보조로 사용되는 또 다른 SELECT문을 의미한다. 
최종 결과를 출력하는 쿼리를 메인 쿼리라고 한다면, 
이를 위한 중간 단계 혹은 보조 역할을 하는 SELECT문을 서브 쿼리라 한다. 
조인 절에서 소개했던 SQL문 중 괄호 안에 들어있는 SELECT문이 바로 서브 쿼리에 속한다. 
하나의 SQL문을 기준으로 메인 쿼리를 제외한 나머지 모든 SELECT문을 서브 쿼리로 보면 되며, 
따라서 서브 쿼리는 여러 개를 사용할 수 있다.

서브 쿼리는 다양한 형태로 사용된다. 
즉 SELECT, FROM, WHERE 절 모두에서 사용할 수 있을 뿐만 아니라, 
INSERT, UPDATE, MERGE, DELETE 문에서도 사용할 수 있다. 
서브 쿼리는 그 특성과 형태에 따라 다음과 같이 구분할 수 있다.

<메인 쿼리와의 연관성에 따라>
-연관성 없는(Noncorrelated) 서브 쿼리
-연관성 있는 서브 쿼리

<형태에 따라>
-일반 서브 쿼리(SELECT 절)
-인라인 뷰(FROM 절)
-중첩 쿼리(WHERE 절)
*/

/*
1.연관성 없는 서브 쿼리
 - 특징 : 메인쿼리에 영향을 받지 않고 단독으로 실행 될 수 있다.
 - 연관성없는 서브쿼리는 메인쿼리보다 먼저 작동한다. 
*/
-- 전 사원의 평균 급여 이상을 받는 사원 수를 조회하는 쿼리
--유형1) 사원의 평균 급여 / 서브쿼리가 단일 행을 반환
SELECT AVG(salary) FROM employees;  --6461.8317~~~~

--메인쿼리 : 앞쪽 SELECT가 메인 SELECT문 / 서브쿼리 : 괄호 안 SELECT문
SELECT * FROM employees 
WHERE salary >=(SELECT AVG(salary) FROM employees); -- 서브쿼리는 미리 만들어 놓는다

-- 유형2)부서 테이블에서 parent_id가 NULL인 부서번호를 가진 사원의 총 건수를 반환하는 쿼리
-- 괄호 안 : 부서테이블에서 parent_id가 NULL인 부서번호 
-- 서브쿼리의 결과가 여러행인 경우 IN 키워드 사용
    SELECT count(*)
    FROM employees
    WHERE department_id IN ( SELECT department_id
                             FROM departments
                             WHERE parent_id IS NULL);
                             
-- 서브쿼리의 결과가 단일행일 경우만 등호, 부등호 연산자 사용이 가능하다. / 생각해보면 데이터가 여러개면 누가 크고 작은지 비교 자체가 불가능하니까 에러나는게 당연한것 같다.                
    SELECT count(*)
    FROM employees
    WHERE department_id = ( SELECT department_id
                             FROM departments
                             WHERE parent_id IS NULL);
                             
    -- 등호, 부등호는 여러개의 결과값과 비교불가능, 에러발생                             
    SELECT count(*)
    FROM employees
    WHERE department_id IN (10, 20, 30); -- 출력 9                            
                             
    SELECT count(*)
    FROM employees
    WHERE department_id = (10, 20, 30);  --오류                           
    
    
--유형3)부서 테이블에서 parent_id가 NULL인 부서번호를 가진 사원의 총 건수를 반환하는 쿼리
-- 복합키 : 컬럼 2개 이상을 묶어서 만들 경우 (하나로 본다.)
    SELECT employee_id, emp_name, job_id
    FROM employees
    WHERE (employee_id, job_id ) IN ( SELECT employee_id, job_id
                                      FROM job_history);
                                        
    
/*
2. 연관성 있는 서브 쿼리
메인 쿼리와의 연관성이 있는 서브 쿼리, 즉 메인 테이블과 조인 조건이 걸린 서브 쿼리를 말한다.
<보충> 서브쿼리에서 사용하는 컬럼명이 메인쿼리의 컬럼명을 참조하고 있는 형태.
- 조인으로 접근을 시도하고 접근이 불가하면 서브쿼리로 방향을 바꿔라.
- 절대적이진 않지만 조인이 서브쿼리보다 기능이 좋다.
*/
/*
<EXISTS()함수 사용법>
 - () 괄호안에 결과가 존재하면 TRUE, 존재하지 않으면 FLASE를 반환한다.
*/
-- 아래 두 식의 차이.
SELECT 1 FROM dual WHERE 1 = 0; -- 조건식이 false일 경우 데이터는 출력되지 않음.
SELECT 1 FROM dual WHERE 1 != 0; -- 조건식이 true일 경우 데이터 1이 출력됨.

-- EXIST 함수는 서브쿼리에 데이터가 존재하지 않아서 false, 출력결과가 없다.
SELECT * FROM departments WHERE EXISTS(SELECT 1 FROM dual WHERE 1 = 0);  
-- EXIST 함수는 서브쿼리에 데이터가 존재해서 true, 출력결과가 있다.
SELECT * FROM departments WHERE EXISTS(SELECT 1 FROM dual WHERE 1 != 0); 


--예제1) 서브쿼리만 단독으로 실행했을 경우 에러발생
    SELECT a.department_id, a.department_name
    FROM departments a  
    WHERE EXISTS ( SELECT 1 --여기에 다른 숫자를 써도 되지만 굳이? 다른 숫자를 쓸 필욘?? 단순한 숫자 쓰는게 작업하기 편함. // 어쨌든 결과가 존재하면 됨.
                   FROM job_history b
                   WHERE a.department_id = b.department_id );  -- 6건 / 중복된 department_id컬럼의 데이터가 제거됨. 
                                                               -- 메인에서 별칭을 참조해서 사용하고 있다.

    -- 동작 설명(암기)
    SELECT department_id FROM departments; --27건
    SELECT department_id FROM job_history; --10건
    /*
    메인쿼리 departments테이블의 27건의 데이터가 
    하나씩 서브쿼리의 a.department_id = b.departmene_id 
    1)일치하면 1이 데이터로 출력  
        EXISTS는 true가 되어 a.department_id가 메인쿼리로 반환된다.
    2)반대로 일치하지 않으면 EXISTS는 FALSE가 되어 1이 출력되지 않는다.
        일치하지 않는 a.department_id는 메인쿼리로 반환되지 못한다.
    <결과> 메인쿼리로 반환된 데이터 행의 컬럼명 a.department_id, a.department_name만 출력된다.
    */

-- 연관성 있는 서브쿼리를 조인으로 변환
    SELECT a.department_id, a.department_name
    FROM departments a  
    WHERE EXISTS ( SELECT 1
                   FROM job_history b
                   WHERE a.department_id = b.department_id );  -- 6건 / 중복된 department_id컬럼의 데이터가 제거됨. 

-- 조인문법
SELECT a.department_id, a.department_name
FROM departments a, job_history b
WHERE a.department_id = b.department_id  -- 10건 출력, 중복된 데이터 행이 제거안됨.

-- DISTINCT 사용
SELECT DISTINCT a.department_id, a.department_name
FROM departments a, job_history b
WHERE a.department_id = b.department_id  -- 6건 출력.
    
    
-- 예제2)서브 쿼리 안에서 메인 쿼리에서 사용된 '부서 테이블의 부서번호'와 'job_history 테이블의 부서번호'가 같은 건을 조회
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
    
    
    
    
    -- 동작설명
    /*
    job_history 테이블 10건의 데이터가 하나씩 
    서브쿼리의 조건식 WHERE a.department_id = b.department_id 에서 일치하면 반환
    일치하지 않으면 메인쿼리에서 버려진다.
    <결과> 일치되는 데이터만 메인쿼리 SELECT a.employee_id, a.department_id 출력된다.
    */
    
    
-------------------------24.04.17(수)-------------------------  
/*
인라인 뷰
FROM 절에 사용하는 서브 쿼리를 인라인 뷰InlineView 라고 한다. 
원래 FROM 절에는 테이블이나 뷰가 오는데, 서브 쿼리를 FROM 절에 사용해 하나의 테이블이나 뷰처럼 사용할 수 있다. 
뷰를 해체하면 하나의 독립적인 SELECT문이므로 FROM 절에 사용하는 서브 쿼리도 하나의 뷰로 볼 수 있어서 
인라인 뷰라는 이름이 붙은 것이다.
*/
/*
SELECT * FROM 테이블명 또는 뷰명 ;
SELECT * FROM (연관성 없는 서브쿼리); / 이때 서브쿼리를 인라인 뷰라고 한다. 
*/
-- 유형1
 SELECT a.employee_id, a.emp_name, b.department_id, b.department_name
      FROM employees a,
           departments b,
           ( SELECT AVG(c.salary) AS avg_salary
               FROM departments b,
                    employees c
              WHERE b.parent_id = 90  -- 기획부
                AND b.department_id = c.department_id ) d
     WHERE a.department_id = b.department_id
       AND a.salary > d.avg_salary;

-- 유형2 /이건 문제풀이 말고 구조만 파악하기
SELECT a.*
      FROM ( SELECT a.sales_month, ROUND(AVG(a.amount_sold)) AS month_avg
               FROM sales a,
                    customers b,
                    countries c
              WHERE a.sales_month BETWEEN '200001' AND '200012'
                AND a.cust_id = b.CUST_ID
                AND b.COUNTRY_ID = c.COUNTRY_ID
                AND c.COUNTRY_NAME = 'Italy' -- 이탈리아
              GROUP BY a.sales_month
           )  a,
           ( SELECT ROUND(AVG(a.amount_sold)) AS year_avg
               FROM sales a,
                    customers b,
                    countries c
              WHERE a.sales_month BETWEEN '200001' AND '200012'
                AND a.cust_id = b.CUST_ID
                AND b.COUNTRY_ID = c.COUNTRY_ID
                AND c.COUNTRY_NAME = 'Italy' -- 이탈리아
           ) b
     WHERE a.month_avg > b.year_avg ;


