/*
PL/SQL의 구조와 구성요소 살펴 보기
PL/SQL은 집합적 언어와 절차적 언어의 특징을 모두 가지고 있다고 앞서 설명했다. 
전자는 SQL을 사용할 수 있기 때문이고, 후자는 일반 프로그래밍 언어처럼 변수에 값을 할당하고 
예외처리도 할 수 있으며 특정 기능을 처리하는 함수나 프로시저를 만들 수 있는 기능을 제공하기 때문이다. 
PL/SQL이 일반 프로그래밍 언어와 다른 점은 모든 코드가 DB 내부에서 만들어져 처리됨으로써 
수행 속도와 성능 측면에서 큰 장점이 있다는 점이다.

PL/SQL : 비지니스 로직을 구현하는 목적.
*/

SET SERVEROUTPUT ON; -- DBSM_OUTPUT.PUT_line(vi_num); 출력결과를 현재화면에서 보기위한 목적

-- 아래 DECLARE를 잘 쓰고 싶으면 위에 SET~ 구문을 꼭 1번 실행해야 한다.

-- 익명블록
-- 기본문법 구조
DECLARE
    vi_num NUMBER;
BEGIN 
    vi_num := 100;      -- ':=' 부호 주의
    dbms_output.put_line(vi_num);
END;
-- 이 기술을 잘 활용하면 스프링 부트를 깔끔하게 쓸 수 있다.


/*
PL/SQL 블록의 구성요소
*/

/*
<변수>
변수는 다른 프로그래밍 언어에서 사용하는 변수와 개념이 같으며 선언부에서 변수 선언을 하고 실행부에서 사용한다. 
변수 선언 방식은 다음과 같다.

  변수명 데이터타입 := 초깃값;
  
  변수 선언과 동시에 초깃값을 할당할 수 있는데, 
  초깃값을 할당하지 않으면 데이터 타입에 상관없이 그 변수의 초깃값은 NULL이 된다. 

  변수로 선언할 수 있는 데이터 타입은 크게 두 가지로 구분할 수 있는데, 
  하나는 SQL 데이터 타입이고 다른 하나는 PL/SQL 데이터 타입이다.
  ★중요★ : PL/SQL 데이터 타입에는 SQL 데이터 타입이 포함되어 있기 때문이다.
*/
/*
<상수>
상수는 변수와는 달리 한 번 값을 할당하면 변하지 않는다. 상수 선언도 변수 선언과 비슷하다.

    상수명 CONSTANT 데이터타입 := 상수값;

상수를 선언할 때는 반드시 CONSTANT란 키워드를 붙여 변수와 구분하며, 
선언할 때 반드시 초기화해야 하고 실행부에서 상수를 다른 값으로 변경할 수 없다. 
왜냐하면 말 그대로 상수는 상수니까!    
*/

DECLARE
    -- 변수 및 상수선언 위치
    a INTEGER := 2**2*3**2;
BEGIN
    DBMS_OUTPUT.PUT_LINE('a = ' || TO_CHAR(a));
END;

/*
<DML문>
PL/SQL 블록 상에서 사용하는 변수, 상수, 연산자는 사실 부차적인 용도로 사용될 뿐이다. 
실제로 PL/SQL 블록을 작성하는 원래의 목적은 테이블 상에 있는 데이터를 이리저리 가공해서 
특정 로직에 따라 무언가를 처리하는 것이며, 따라서 주로 사용되는 것은 SQL문이다. 
SQL문 중 DDL은 PL/SQL 상에서 직접 쓸 수 없고(물론 전혀 방법이 없는 것은 아니다) DML문만 사용한다.
*/

-- 시나리오? 사원 테이블에서 특정 사원의 이름과 부서명을 가져와 출력하는 코드를 작성.
-- 1)sql 구문
SELECT e.emp_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.employee_id = 100; 

-- 2)PL/SQL 구문
DECLARE
    vs_emp_name     VARCHAR2(80); -- 사원명 변수
    vs_dep_name     VARCHAR2(20); -- 부서명 변수
BEGIN
    SELECT e.emp_name, d.department_name
    INTO vs_emp_name, vs_dep_name --컬럼의 값을 변수에 담는 방법
    FROM employees e, departments d    
    WHERE e.department_id = d.department_id
    AND e.employee_id = 100; 
    
    --변수값 출력
    DBMS_OUTPUT.put_line(vs_emp_name || ' - ' || vs_dep_name);
END;


-- 변수명에 데이터 타입을 테이블 컬럼 타입으로 자동참조 %TYPE
-- 변수명 테이블명.컬럼명%TYPE
--<사용이유> 테이블의 컬럼 데이터 타입이 변경되더라도 타입을 자동참조 하므로 코드 수정을 할 필요가 없다.
DECLARE
    vs_emp_name     employees.emp_name%TYPE; -- 사원명 변수
    vs_dep_name     departments.department_name%TYPE; -- 부서명 변수
BEGIN
    SELECT e.emp_name, d.department_name
    INTO vs_emp_name, vs_dep_name --컬럼의 값을 변수에 담는 방법
    FROM employees e, departments d    
    WHERE e.department_id = d.department_id
    AND e.employee_id = 100; 
    
    --변수값 출력
    DBMS_OUTPUT.put_line(vs_emp_name || ' - ' || vs_dep_name);
END;




/* SQL과 PL/SQL 데이터 타입별 길이 
SQL데이터 타입을 PL/SQL 데이터타입에서 지원하지만, 길이가 좀 더 크게 사용한다(중요) 
 
VARCHAR2 타입은 SQL에서는 최대 크기가 4000 byte였다. 
하지만 PL/SQL에서는 VARCHAR2 타입을 32KB(32,767 byte)까지 사용할 수 있다.
>>> PL/SQL과 SQL의 데이터 타입의 크기 차이가 있으며 PL/SQL의 크기가 훨씬 더 크다
*/


CREATE TABLE ch08_varchar2 (
    VAR1 VARCHAR2(5000)); -- 4000BYTE초과시 에러발생.

-- 타입수정
CREATE TABLE ch08_varchar2 (
    VAR1 VARCHAR2(4000)); 

--데이터 타입 // 요게 들어가야 아래 DECLARE 문이 제대로 작동한다.
INSERT INTO ch08_varchar2 VALUES('4000바이트 크기데이터');

DECLARE
    vs_sql_varchar2     VARCHAR2(4000),
    vs_plsql_varchar2   VARCHAR2(32767)
BEGIN
    SELECT VAR1
        INTO vs_sql_varchar2
        FROM ch08_VARCHAR2;
        
        vs_plsql_varchar2 := vs_sql_varchar2 || ' = ' || vs_sql_varchar2 || ' - ' || vs_plsql_varchar2;
        
        --각 변수의 크기를 출력한다.
        DBMS_OUTPUT.PUT_LINE('SQL VARCHAR2 길이 : ' || LENGTHB(vs_sql_varchar2));
        DBMS_OUTPUT.PUT_LINE('PL/SQL VARCHAR2 길이 : ' || LENGTHB(vs_sql_varchar2));
END;





