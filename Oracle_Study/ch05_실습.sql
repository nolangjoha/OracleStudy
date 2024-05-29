/*기본집계 함수
 집계함수란 대상 데이터를 특정 그룹으로 묶은 다음 이 그룹에 대해 총합, 평균, 최댓값, 최솟값 등을 구하는 함수를 말한다. 
*/
/*
① COUNT (expr)
COUNT는 쿼리 결과 건수, 즉 전체 로우 수를 반환하는 집계 함수다. 테이블 전체 로우는 물론 WHERE 조건으로 걸러진 로우 수를 반환한다.
COUNT 함수는 매개변수로 들어오는 expr이 NULL이 아닌 건에 대해서만 로우의 수를 반환한다
*/

--사원테이블의 데이터 행수
SELECT COUNT(*) FROM employees; --107건

--부서테이블의 데이터 행수
SELECT COUNT(*) FROM departments;  --27건

--* 대신 컬럼명을 사용할 수가 있다.
SELECT COUNT(employee_id)FROM employees;-- 107건
SELECT COUNT(department_id)FROM employees;--106건  -- department_id 데이터 중 null데이터 1건을 제외★★★

--중복데이터 제거. 사원테이블에 존재하는 부서코드의 수를 확인
SELECT DISTINCT department_id FROM employees ORDER BY 1;

SELECT COUNT(DISTINCT department_id) FROM employees ORDER BY 1; --11건


/*
② SUM(expr)
SUM은 expr의 전체 합계를 반환하는 함수로 매개변수 expr에는 숫자형만 올 수 있다.
사원 테이블에서 급여가 숫자형이므로 전 사원의 급여 총액을 구해 보자.
*/
-- 총 급여액을 조회.
SELECT SUM(salary)FROM employees;

/*
SUM 함수 역시 expr 앞에 DISTINCT가 올 수 있는데, 이때 역시 중복된 급여는 1번만 셈해진 전체 합계를 반환한다.
*/
SELECT SUM(salary), SUM(DISTINCT salary)FROM employees;


/*
③ AVG(expr)
AVG는 매개변수 형태나 쓰임새는 COUNT, SUM과 동일하며 평균값을 반환한다.
*/
-- 급여에 대한 평균
SELECT AVG(salary), AVG(DISTINCT salary)FROM employees;

/*
④ MIN(expr), MAX(expr)
MIN과 MAX는 각각 최솟값과 최댓값을 반환한다.
*/
-- 급여중에 가장 적은 금액, 가장 큰 금액 출력
SELECT MIN(salary), MAX( salary)FROM employees;

-- DISTINCT는 중복값을 제거해주는 것이기 때문에 여기서는 의미가 없다.
SELECT MIN(DISTINCT salary), MAX(DISTINCT salary)FROM employees;


/*
⑤ VARIANCE(expr), STDDEV(expr)
VARIANCE는 분산을, STDDEV는 표준편차를 구해 반환한다. 
분산이란 주어진 범위의 개별 값과 평균값과의 차이인 편차를 구해 이를 제곱해서 평균한 값을 말하며, 
표준편차는 분산 값의 제곱근이다. 분산은 제곱한 평균이므로, 
실제로 통계에서는 평균을 중심으로 값들이 어느 정도 분포하는지를 나타내는 수치인 표준편차를 지표로 사용한다.
*/
--급여의 분산 및 표준편차
SELECT VARIANCE(salary), STDDEV(salary)FROM employees;


/*
02 | GROUP BY 절과 HAVING 절
지금까지 알아본 집계 함수의 예제는 모두 사원 전체를 기준으로 데이터를 추출했는데, 
전체가 아닌 특정 그룹으로 묶어 데이터를 집계할 수도 있다. 이때 사용되는 구문이 바로 GROUP BY 절이다. 
그룹으로 묶을 컬럼명이나 표현식을 GROUP BY 절에 명시해서 사용하며 GROUP BY 구문은 WHERE와 ORDER BY절 사이에 위치한다.
*/
--각 부서별 총 급여액을 조회하자. 
-- ※GROUP BY를 사용하면 SELECT절에 컬럼명은 제한적으로 사용(GROUP BY에 사용 된 컬럼명, 집계함수 만)해야 한다. 
SELECT department_id, SUM(salary)FROM employees
GROUP BY department_id
ORDER BY department_id;

SELECT department_id,COUNT(*) AS "부서인원", SUM(salary) AS "총급여액", AVG(salary) AS "평균급여" FROM employees
GROUP BY department_id
ORDER BY department_id;

--한국 대출상태 조회
SELECT * FROM kor_loan_status;

/*
kor_loan_status 테이블에는 월별, 지역별 가계대출 잔액(단위는 십억)이 들어 있고, 
대출유형(gubun)은 ‘주택담보대출’과 ‘기타대출’ 두 종류만 존재한다. 

그럼 2013년 지역별 가계대출 총 잔액을 구해 보자.
*/               -- ',' 잘 확인하자
SELECT period, region, SUM(loan_jan_amt) totl_jan FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY period, region;

--HAVING 절은 GROUP BY절 다음에 위치해 GROUP BY한 결과를 대상으로 다시 필터를 거는 역할을 수행한다. 
--즉 HAVING 필터 조건 형태로 사용한다. 예를 들어, 위 쿼리 결과에서 대출잔액이 100조 이상인 건만 추출한다면 
--다음과 같이 쿼리를 작성하면 된다.
SELECT period, region, SUM(loan_jan_amt) totl_jan FROM kor_loan_status
     WHERE period = '201311'
     GROUP BY period, region
     HAVING SUM(loan_jan_amt) > 100000;

--employees(사원)테이블 참고
--1. 각 부서별 최대 급여, 최소급여, 평균 급여를 구하라.
SELECT department_id, MAX(salary), MIN(salary), AVG(salary)
FROM employees 
GROUP BY department_id;  -- 동일한 부서코드를 그룹화
-- 위 예제 가독성 있게 정리
SELECT department_id AS "부서번호", MAX(salary)AS "최대급여", MIN(salary) AS "최소급여", ROUND(AVG(salary),1) AS "평균급여"
FROM employees 
GROUP BY department_id  -- 동일한 부서코드를 그룹화
ORDER BY department_id;

-- 위의쿼리데이터를 평균급여를 오름차순으로 조회하라.
SELECT department_id AS "부서번호", MAX(salary)AS "최대급여", MIN(salary) AS "최소급여", ROUND(AVG(salary),1) AS "평균급여"
FROM employees 
GROUP BY department_id  -- 동일한 부서코드를 그룹화
ORDER BY ROUND(AVG(salary),1);

-- 위의쿼리데이터를 평균급여를 오름차순을 별칭사용 조회하라.
SELECT department_id AS "부서번호", MAX(salary)AS "최대급여", MIN(salary) AS "최소급여", ROUND(AVG(salary),1) AS "평균급여"
FROM employees 
GROUP BY department_id  -- 동일한 부서코드를 그룹화
ORDER BY "평균급여";

--시나리오: employees 테이블에서 직책별(jon_Id)직원수, 최대급여, 최소급여, 평균급여의 소수점 첫째자리 까지 구하라.
SELECT job_id AS "직책", COUNT(*)AS "직원수", MAX(salary)AS "최대급여", MIN(salary) AS "최소급여", ROUND(AVG(salary),1) AS "평균급여"
FROM employees 
GROUP BY job_id  -- 동일한 부서코드를 그룹화
ORDER BY "평균급여";
--위 테이블에서 10명 초과인 직책
SELECT job_id AS "직책", COUNT(*)AS "직원수", MAX(salary)AS "최대급여", MIN(salary) AS "최소급여", ROUND(AVG(salary),1) AS "평균급여"
FROM employees 
GROUP BY job_id  -- 동일한 부서코드를 그룹화
HAVING COUNT (*) > 10
ORDER BY "평균급여";


/* <ROLLUP 순차적 집계, CUBE : 여러조합 집계>
ROLLUP(expr1, expr2, …)
ROLLUP은 expr로 명시한 표현식을 기준으로 집계한 결과, 즉 추가적인 집계 정보를 보여 준다. 
ROLLUP 절에 명시할 수 있는 표현식에는 그룹핑 대상, 
즉 SELECT 리스트에서 집계 함수를 제외한 컬럼 등의 표현식이 올 수 있으며, 
명시한 표현식 수와 순서(오른쪽에서 왼쪽 순으로)에 따라 레벨별로 집계한 결과가 반환된다. 
표현식 개수가 n개이면 n+1 레벨까지, 하위 레벨에서 상위 레벨 순으로 데이터가 집계된다.
*/
-- ※GROUP BY 다음 써주는 게 가장 큰 레벨 범주다.

--위 쿼리는 2013년도 기간(period) 대출 종류별(gubun) 총 잔액을 구한 것이다.
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
     FROM kor_loan_status
     WHERE period LIKE '2013%'
     GROUP BY period, gubun
     ORDER BY period;

-- 2013년 10월 중간합계
-- 2013년 11월 중간합계
-- 전체합계

--GROUP BY ROLLUP(period, gubun); 컬럼수 +1 / 3레벨 형태로 데이터 조회
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
      FROM kor_loan_status
     WHERE period LIKE '2013%'
     GROUP BY ROLLUP(period, gubun); -- 집계정보 2개이므로 3레발 까지 집계하여 보여준다.

/*
    PERIOD   GUBUN                 TOTL_JAN
    -------- -------------------- -----------------------
    201310   기타대출              676078         →③
    201310   주택담보대출          411415.9        →③
    201310                         1087493.9    →②
    201311   기타대출              681121.3       →③
    201311   주택담보대출          414236.9        →③
    201311                         1095358.2    →②
                                   2182852.1    →①
레벨3: 소계     / GROUP BY만 사용
레벨2: 중간계산  / 
레벨1: 전체계산

*/


--GROUP BY period, ROLLUP( gubun ) : ROLLUP 컬럼수 1개 +1 = 2레벨 형태 데이터 출력
--레벨2(period, gubun),레벨1(perido) 이런 형태가 출력된다.
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
      FROM kor_loan_status
     WHERE period LIKE '2013%'
     GROUP BY period, ROLLUP( gubun );
/*
    PERIOD   GUBUN                 TOTL_JAN
    -------- -------------------- -----------------------
    201310   기타대출                 676078         →2
    201310   주택담보대출            411415.9        →2
    201310                        1087493.9    →1
    201311   기타대출                681121.3       →2
    201311   주택담보대출             414236.9        →2
    201311                        1095358.2    →1
    
    (period, gubun), (period)
*/


/*
ROLLUP은 또 다른 유형으로 사용할 수 있는데 예를 들어, GROUP BY expr1, ROLLUP(expr2, expr3)로 명시했다면, 
레벨은 ‘2+1=3’레벨이 되지만 결과는 (expr1, expr2, expr3), (expr1, expr2), (expr1)별로 집계가 되고 
전체 합계는 집계되지 않는다. 이런 유형을 분할(partial) ROLLUP이라고 한다.
*/

/*
 GROUP BY ROLLUP(expr1, expr2, expr3)로 명시했다면,
 컬럼수 3+1 = 4 전체 4레벨로 출력
 (expr1, expr2, expr3), (expr1, expr2), (expr1), 전체 합계 
 낮은범주>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>큰범주
*/

/*
GROUP BY expr1, ROLLUP (expr2)
레벨은 1+1=2 레벨2형태로 출력
(expr1, expr2), (expr1)
*/



/*
CUBE(expr1, expr2, …)
CUBE는 ROLLUP과 비슷하나 개념이 약간 다르다. 
ROLLUP이 레벨별로 순차적 집계를 했다면, CUBE는 명시한 표현식 개수에 따라 가능한 모든 조합별로 집계한 결과를 반환한다. 
CUBE는 2의(expr 수)제곱 만큼 종류별로 집계 된다. 
예를 들어, expr 수가 3이면, 집계 결과의 유형은 총 2^3^ = 8개가 된다.
*/

SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY CUBE(period, gubun) ;
/*GROUP BY 다음을 비워놓으면 전체합계가 출력된다.
--2의 CUBE 컬럼수 승= 4가지 유형 / 
PERIOD GUBUN                            TOTL_JAN
------ ------------------------------ ----------
                                       2182852.1   레벨1(전체합계)
       기타대출                        1357199.3     레벨2
       주택담보대출                     825652.8      레벨2
201310                                 1087493.9   레벨3
201310 기타대출                           676078     레벨4
201310 주택담보대출                     411415.9      레벨4
201311                                 1095358.2    레벨3
201311 기타대출                         681121.3      레벨4
201311 주택담보대출                     414236.9      레벨4
*/

SELECT period, gubun, SUM(loan_jan_amt) totl_jan
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY ROLLUP(period, gubun) ;  -- 컬럼수 2+1= 3레벨 (period, gubun), (period) (전체합계)
--GROUP BY CUBE(period, gubun)  --2의 컬럼수의 승 = 4유형 (period, gubun), (period), (gubun), (전체합계)


/*
GROUP BY expr1, CUBE(expr2, expr3)로 명시했을 때,   
-- 2개 컬럼에 컬럼개수 승(2승) = 4개지 유형이 나온다. 이때 GROUP BY 뒤에 expr1이 있어서 최상위 레벨이 (expr1)이다. 
없으면 전체합계가 최상위 레벨임.--
(expr1, expr2, expr3), (expr1, expr2), (expr1, expr3), (expr1) 
총 4가지(2^2^) 유형으로 집계된다.
*/
SELECT period, gubun, SUM(loan_jan_amt) totl_jan
      FROM kor_loan_status
     WHERE period LIKE '2013%'
     GROUP BY period, CUBE( gubun );
     
/*
PERIOD GUBUN                            TOTL_JAN
------ ------------------------------ ----------
201310                                 1087493.9  (period)
201310 기타대출                           676078    (period, gubun)
201310 주택담보대출                     411415.9     (period, gubun)
201311                                 1095358.2   (period)
201311 기타대출                         681121.3     (period, gubun)
201311 주택담보대출                     414236.9     (period, gubun)
*/
     
     
/*
집합(Set)이라고 부르기도 한다. 집합(Set) 연산자는 이러한 데이터 집합을 대상으로 연산을 수행하는 연산자를 말하며, 
그 종류로는 UNION, UNION ALL, INTERSECT, MINUS가 있다.
*/

CREATE TABLE exp_goods_asia (
           country VARCHAR2(10),
           seq     NUMBER,
           goods   VARCHAR2(80));

    INSERT INTO exp_goods_asia VALUES ('한국', 1, '원유제외 석유류');
    INSERT INTO exp_goods_asia VALUES ('한국', 2, '자동차');
    INSERT INTO exp_goods_asia VALUES ('한국', 3, '전자집적회로');
    INSERT INTO exp_goods_asia VALUES ('한국', 4, '선박');
    INSERT INTO exp_goods_asia VALUES ('한국', 5,  'LCD');
    INSERT INTO exp_goods_asia VALUES ('한국', 6,  '자동차부품');
    INSERT INTO exp_goods_asia VALUES ('한국', 7,  '휴대전화');
    INSERT INTO exp_goods_asia VALUES ('한국', 8,  '환식탄화수소');
    INSERT INTO exp_goods_asia VALUES ('한국', 9,  '무선송신기 디스플레이 부속품');
    INSERT INTO exp_goods_asia VALUES ('한국', 10,  '철 또는 비합금강');

    INSERT INTO exp_goods_asia VALUES ('일본', 1, '자동차');
    INSERT INTO exp_goods_asia VALUES ('일본', 2, '자동차부품');
    INSERT INTO exp_goods_asia VALUES ('일본', 3, '전자집적회로');
    INSERT INTO exp_goods_asia VALUES ('일본', 4, '선박');
    INSERT INTO exp_goods_asia VALUES ('일본', 5, '반도체웨이퍼');
    INSERT INTO exp_goods_asia VALUES ('일본', 6, '화물차');
    INSERT INTO exp_goods_asia VALUES ('일본', 7, '원유제외 석유류');
    INSERT INTO exp_goods_asia VALUES ('일본', 8, '건설기계');
    INSERT INTO exp_goods_asia VALUES ('일본', 9, '다이오드, 트랜지스터');
    INSERT INTO exp_goods_asia VALUES ('일본', 10, '기계류');

COMMIT;

SELECT * FROM exp_goods_asia;

/*
UNION
UNON은 합집합을 의미한다. 
예를 들어, 두 개의 데이터 집합이 있으면 각 집합 원소(SELECT 결과)를 모두 포함한 결과가 반환된다. 
※UNON 명령어는 GOODS컬럼의 중복된 수출품목을 하나만 포함시켜 출력해준다.(중복검사) 
*/ 

    --한국 수출품목 조회         --10건
    SELECT goods FROM exp_goods_asia
     WHERE country = '한국'
     ORDER BY seq;
     
    --일본 수출품목 조회          --10건
    SELECT goods FROM exp_goods_asia
     WHERE country = '일본'
     ORDER BY seq;

    --위의 2개 문장을 하나로 합쳐서 사용      --15건 : 중복제외
    SELECT goods FROM exp_goods_asia
    WHERE country = '한국'
        UNION  --중복검사 
    SELECT goods FROM exp_goods_asia
    WHERE country = '일본';

    -- 중복포함 다보고 싶을때            --20건 : 중복포함
    SELECT goods FROM exp_goods_asia
    WHERE country = '한국'
        UNION ALL  -- 다보여줌.
    SELECT goods FROM exp_goods_asia
    WHERE country = '일본';


/*
INTERSECT
INTERSECT는 합집합이 아닌 교집합을 의미한다. 즉 데이터 집합에서 공통된 항목만 추출해 낸다.
*/
    SELECT goods
    FROM exp_goods_asia
    WHERE country = '한국'
        INTERSECT  --교집합
    SELECT goods
    FROM exp_goods_asia
    WHERE country = '일본';


/*
MINUS
MINUS는 차집합을 의미한다. 
즉 한 데이터 집합을 기준으로 다른 데이터 집합과 공통된 항목을 제외한 결과만 추출해 낸다.
*/
    -- 한국만 수출하는 품목 조회
    SELECT goods
    FROM exp_goods_asia
    WHERE country = '한국'
         MINUS  --차집합
    SELECT goods
    FROM exp_goods_asia
    WHERE country = '일본';

    --일본만 수출하는 품목 조회
    SELECT goods
    FROM exp_goods_asia
    WHERE country = '일본'
         MINUS  --차집합
    SELECT goods
    FROM exp_goods_asia
    WHERE country = '한국';


/* 집합 연산자의 제한사항
① 집합 연산자로 연결되는 각 SELECT문의 SELECT 리스트의 개수와 데이터
타입은 일치해야 한다

*/
/*  --- 오류 : 컬럼 수가 일치하지 않음./ 컬럼수가 동일해야 정상 실행 됨.

    SELECT goods   --컬럼 1개
    FROM exp_goods_asia
    WHERE country = '한국'
         UNION
    SELECT seq, goods   --컬럼2개
    FROM exp_goods_asia
    WHERE country = '일본';
*/
    -- 컬럼수 일치 시켰더니 정상 실행.
    SELECT seq,goods   --컬럼 개
    FROM exp_goods_asia
    WHERE country = '한국'
         UNION
    SELECT seq, goods   --컬럼2개
    FROM exp_goods_asia
    WHERE country = '일본';

/*  --오류 : 컬럼의 데이터 타입이 다르다.
    SELECT seq             -- 숫자 컬럼 1개
    FROM exp_goods_asia
    WHERE country = '한국'
         UNION
    SELECT goods           -- 문자 컬럼1개
    FROM exp_goods_asia
    WHERE country = '일본';

*/

/*
② 집합 연산자로 SELECT 문을 연결할 때 ORDER BY절은 맨 마지막 문장에서만 사용할 수 있다
*/
     SELECT goods
     FROM exp_goods_asia
     WHERE country = '한국'
        ORDER BY goods  -- 중간에 ORDER BY를 사용하면 오류 발생.
     UNION
     SELECT goods
     FROM exp_goods_asia
     WHERE country = '일본';

-- 위의 구문을 수정하면 다음과 같다.
     SELECT goods
     FROM exp_goods_asia
     WHERE country = '한국'
     UNION
     SELECT goods
     FROM exp_goods_asia
     WHERE country = '일본'
          ORDER BY goods;  -- ORDER BY 위의 구문에 종속이지 않다. 
                           -- 전체에 대한 결과(합쳐진 결과)를 정렬하는 의미로 사용 된다. 


/*
③ BLOB, CLOB, BFILE 타입의 컬럼에 대해서는 집합 연산자를 사용할 수 없다
④ UNION, INTERSECT, MINUS 연산자는 LONG형 컬럼에는 사용할 수 없다
*/

/*
GROUPING SETS 절
GROUPING SETS은 ROLLUP이나 CUBE처럼 GROUP BY 절에 명시해서 그룹 쿼리에 사용되는 절이다.
이 장 맨 마지막에 소개하는 이유는 GROUPING SETS 절이 그룹 쿼리이긴 하나 UNION ALL 개념이 섞여 있기 때문이다. 
예를 들어, GROUPING SETS (expr1, expr2, expr3)를 GROUP BY 절에 명시했을 때, 
괄호 안에 있는 세 표현식별로 각각 집계가 이루어진다. 

즉 쿼리 결과는 ((GROUP BY expr1) UNION ALL (GROUP BY expr2) UNION ALL (GROUP BY expr3)) 형태가 된다.
*/
    SELECT period, gubun, SUM(loan_jan_amt) totl_jan
    FROM kor_loan_status
    WHERE period LIKE '2013%'
    GROUP BY GROUPING SETS(period, gubun);  -- ((GROUP BY (period) UNION ALL (GROUP BY(gubun)) 와 같은 말.


     SELECT period, gubun, region, SUM(loan_jan_amt) totl_jan
     FROM kor_loan_status
     WHERE period LIKE '2013%'
     AND region IN ('서울', '경기')
     GROUP BY GROUPING SETS(period, (gubun, region));  -- ((GROUP BY (period) UNION ALL (GROUP BY gubun, region) 와 같은 말.












