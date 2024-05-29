-- PL/SQL

--SQL : DCL, DDL, DML, TCL 4가지로 분류
--DML : SELECT, INSERT, UPDATE, DROR, MERGE 명령어 학습
--SELECT : 테이블의 데이터를 조회하는 명령어
/*
SELECT 컬럼명, 컬럼명,......FROM 테이블명;
*/

--SQL 명령어는 대소문자 구분 안함.
SELECT * FROM employees;  -- ' * '은 테이블의 모든 컬럼 명(열이름)을 의미한다.

--스키마 : 테이블과 같은 데이터베이스 개체들을 논리적인 단위로 묶어서 관리하는 의미.
SELECT * FROM HR.employees;  --접속상태가 HR로 되어 있으면, 스키마 이름은 생략 가능.

-- 사원테이블에서 사원번호, 이름, 전자우편, 입사일, 급여를 조회하라.
SELECT employee_id, first_name || last_name, email, hire_date, salary FROM employees; 

-- SELECT * FROM employees; 중간에 가운데에 다른 단어를 넣을거라면 *을 나중에 넣지말고 일단 넣어두자
-- SELECT  FROM employees; 코드를 끝까지 작성한후 
-- SELECT 원하는 테이블 FROM employees; 중간을 작성한다.

-- 테이블의 컬럼을 선택하여 마우스로 드래그 하는 방법
--SELECT employee_id, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, SALARY from employees;
-- FIRST_NAME과 Last_NAME 컬럼을 하나로 연결하기. ||
--데이터베이스에서는 문자열을 작은 따옴표로 사용한다. "는 쓰지 않는다. 
SELECT employee_id, FIRST_NAME ||' '|| LAST_NAME, EMAIL, HIRE_DATE, SALARY from employees;

-- 컬럼 별칭 사용. AS    1) 컬럼명 AS 별칭
SELECT employee_id, FIRST_NAME ||' '|| LAST_NAME AS NAME, EMAIL, HIRE_DATE, SALARY from employees;

-- 컬럼 별칭 사용. AS 생략   2) 컬럼명  별칭
SELECT employee_id E_ID, FIRST_NAME ||' '|| LAST_NAME AS NAME, EMAIL EM, HIRE_DATE HD, SALARY SAL from employees;

--부서테이블에서 부서명을 조회하라.
SELECT department_name FROM departments;

--부서테이블에서 부서코드, 부서명을 조회하라.
SELECT department_id, department_name FROM departments;

--한줄주석
/*
여러줄 주석
*/

--한글 이름으로 별칭 사용이 가능하다.
SELECT employee_id 사원번호, manager_id 관리자아이디 FROM employees;

--별칭을 띄워쓰기 사용할 경우에는 "" 큰따옴표사용
SELECT employee_id "사원 번호", manager_id "관리자 아이디" FROM employees;

-- 그러나 한글을 사용하게 되면 단독으론 문제 없지만 다른 것과 함께 사용할때 문제가 되므로 한글 별칭을 사용하지 않음.


--<24.04.02> 시작
-- 계정생성과 권한 부여작업이 진행되었을 경우 sqldb계정으로 접속
-- 학습용 데이터 준비작업
--1)~6) 까지 순차적으로 블록을 만들어 실행한다.

--1)
CREATE TABLE userTBL -- 회원 테이블
( userID  	CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  userName  	NVARCHAR2(10) NOT NULL, -- 이름
  birthYear 	NUMBER(4) NOT NULL,  -- 출생년도
  addr	  	NCHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  mobile1	CHAR(3), -- 휴대폰의 국번(010, 011, 016, 017, 018, 019 등)
  mobile2	CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈제외)
  height    	NUMBER(3),  -- 키
  mDate    	DATE  -- 회원 가입일
);

--2)
CREATE TABLE buyTBL -- 회원 구매 테이블
(  idNum 	NUMBER(8) NOT NULL PRIMARY KEY, -- 순번(PK)
   userID  	CHAR(8) NOT NULL, -- 아이디(FK)
   prodName 	NCHAR(6) NOT NULL, --  물품명
   groupName 	NCHAR(4)  , -- 분류
   price     	NUMBER(8)  NOT NULL, -- 단가
   amount    	NUMBER(3)  NOT NULL, -- 수량
   FOREIGN KEY (userID) REFERENCES userTBL(userID)
);
--3)
INSERT INTO userTBL VALUES('LSG', '이승기', 1987, '서울', '011', '11111111', 182, '2008-8-8');
INSERT INTO userTBL VALUES('KBS', '김범수', 1979, '경남', '011', '22222222', 173, '2012-4-4');
INSERT INTO userTBL VALUES('KKH', '김경호', 1971, '전남', '019', '33333333', 177, '2007-7-7');
INSERT INTO userTBL VALUES('JYP', '조용필', 1950, '경기', '011', '44444444', 166, '2009-4-4');
INSERT INTO userTBL VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO userTBL VALUES('LJB', '임재범', 1963, '서울', '016', '66666666', 182, '2009-9-9');
INSERT INTO userTBL VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO userTBL VALUES('EJW', '은지원', 1972, '경북', '011', '88888888', 174, '2014-3-3');
INSERT INTO userTBL VALUES('JKW', '조관우', 1965, '경기', '018', '99999999', 172, '2010-10-10');
INSERT INTO userTBL VALUES('BBK', '바비킴', 1973, '서울', '010', '00000000', 176, '2013-5-5');

--4)
CREATE SEQUENCE idSEQ; -- 순차번호 입력을 위해서 시퀀스 생성

--5)
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'EJW', '책'    , '서적', 15,   1);
INSERT INTO buyTBL VALUES(idSEQ.NEXTVAL, 'BBK', '운동화', NULL   , 30,   2);

--6)
COMMIT;


-- SELECT문 : 테이블에 저장되어 있는 데이터 확인(조회명령어)
SELECT * FROM usertbl; -- 10개
SELECT * FROM buytbl; --12개

--P.194
--특정한 조건의 데이터만 조회.(SELECT ~ FROM ~ WHERE)
/*
문법)
SELECT 컬럼명1, 컬럼명2, FROM 테이블명 WHERE 조건식;
*/

-- 질의) 이름이 김경호인 데이터를 조회하라.
SELECT * FROM usertbl WHERE USERNAME = '김경호';
SELECT * FROM usertbl WHERE USERNAME = '은지원';

--질의) 생년월일이 1970년 이상 출생하고, 키가 182CM이상인 데이터를 조회하라  -- 조건이 AND인지 OR인지 파악해야 한다. 
SELECT * FROM usertbl WHERE birthyear >= 1970 AND height >= 182;

--질의) 생년월일이 1970년 이상 출생을 하거나, 키가 182CM이상인 데이터를 조회하라
SELECT * FROM usertbl WHERE birthyear >= 1970 OR height >= 182;

--질의) 키가 180이상이면서 183이하인 데이터를 조회하라.
SELECT * FROM usertbl WHERE height >= 180 AND height <= 183;
-- 위와 동일한 구문.
SELECT * FROM usertbl WHERE height BETWEEN 180 AND 183;

--질의)주소가 경남이거나 전남 또는 경북 데이터를 조회하라
SELECT * FROM usertbl WHERE addr = '경남' OR addr = '전남' OR addr = '경북';
-- 위와 동일한 구문.
SELECT * FROM usertbl WHERE addr IN ('경남', '전남', '경북');

--숫자 데이터 컬럼인 경우 사칙연산이 가능하다.
SELECT * FROM buytbl;
--질의)주문금액을 출력하시오.   -- *는 모든 컬럼명을 말한다. 근데 현장에서 개발할때 *쓰면 성능이 떨어진다. 모두 필요하면 그냥 컬럼명 전체 가져오자.
-- 인쇄할 열의 이름들, PRICE * AMOUNT(물건의 양) AS TOT_PRICE(곱한것의 열의 이름은 TOT~로 한다) 
SELECT idnum, USERID, PRODNAME, GROUPNAME, PRICE * AMOUNT AS TOT_PRICE FROM buytbl;
--가격 1.1%인상
SELECT idnum, USERID, PRODNAME, GROUPNAME, PRICE * 1.1 FROM buytbl;

-- LIKE 패턴 매칭
--질의) 이름 중 성이 "김" 씨 인 데이터를 조회하라.
--와일드 카드 문자 % : 길이가 0인 이상(문자수가 0개 이상)의 문자열. // '김'이라는 하나의 문자가 있어도 출력된다.
SELECT * FROM usertbl WHERE username LIKE '김%';

--질의)전체 이름이 3글자 이면서, 종신으로 끝나는 데이터를 조회하라.
-- 와일드 카드문자 _(언더바) : 길이가 1개를 의미/ 어떤글자가 와도 상관없다. 단, 한개의 글자만 와야 한다.
SELECT * FROM usertbl WHERE username LIKE '_종신';
--SELECT * FROM usertbl WHERE userid LIKE '_B_'; //데이터 유형문제로 추후에
/*LIKE 패턴 보충설명할 것. 
 1) 문자열의 내용을 검색해준다.
 2) LIKE를 써주지 않으면 와일드카드문자로 해석하지 않고 일반글자 1개의 의미로 해석된다.(오류발생 주의)
*/

--------------------------------------------------------------
--더북 오라클 https://thebook.io/006696/0063/의 예제 사용

--질의) 사원테이블에서 급여가 5000이 넘는 사원번호와 사원명을 조회하라.
   SELECT  employee_id, emp_name
   FROM  employees
   WHERE   salary > 5000;

-- order by :오름차순 정렬/아래 출력되는 화면에서 정렬된 것이고, 실제 테이블이 정렬된 것은 아니다.
-- 이건 가장 하단에 작성해야 한다.
    SELECT  employee_id, emp_name
    FROM  employees
    WHERE  salary > 5000
    ORDER  BY employee_id;  --ORDER BY employee_id asc
-- 내림차순 desc
    SELECT  employee_id, emp_name
    FROM  employees
    WHERE  salary > 5000
    ORDER  BY employee_id desc;  
    
-- 질의)급여가 5000 이상이고 job_id가 ‘IT_PROG’인 사원을 조회한다면, AND 연산자와 job_id를 검색하는 조건
-- 명령어는 대소문자 구분하지 않지만, 데이터 값은 대소문자를 구분한다.
    SELECT  employee_id, emp_name
    FROM  employees
    WHERE  salary >= 5000 AND  job_id = 'IT_PROG'
    ORDER  BY employee_id;
    
-- 데이터는 대소문자를 구분한다. 'IT_PROG' -> 'it_prog'
-- 대소문자는 구분때문에 결과가 없다. 
    SELECT  employee_id, emp_name
    FROM  employees
    WHERE  salary >= 5000 AND  job_id = 'it_prog'
    ORDER  BY employee_id;    
    
--강사님 추가실습
-- 질의)usertbl테이블에서 생년월일을 오름차순으로 정렬하시오.
SELECT * FROM usertbl ORDER BY birthyear ASC;  

-- 질의)usertbl테이블에서 키를 내림차순, 이름을 오름차순으로 정렬하시오.
-- 동일한 데이터 상에서만 2차 정렬이 가능하다.
SELECT * FROM usertbl ORDER BY height DESC, username ASC;  

-- 질의) USERTBL에서 주소를 오름차순으로 정렬하시오.
SELECT * FROM usertbl ORDER BY ADDR ASC;  -- 다른 데이터와 같이
SELECT ADDR FROM usertbl ORDER BY ADDR ASC;  -- ADDR 열 1개만

-- DISTINCT : 중복된 데이터를 1개만 남기고 나머지는 제거하는 기능
SELECT DISTINCT ADDR FROM USERTBL ORDER BY ADDR ASC;
-- DISTINCT가 의미 없는 경우 : 아래 코드에서 USERNAME과 ADDR을 동시에 만족하는 데이터가 없다. 
SELECT DISTINCT USERNAME, ADDR FROM USERTBL ORDER BY ADDR ASC; -- 중복이 없어서 다나온다.
--동시에 만족되는 데이터 존재시 DISTINCT효과가 나온다.

--------------------------------------------------------------------
-- 더북 : 2장 데이터베이스를 구성하는 객체 살펴보기
/*
1. 데이터 베이스객체의 개요
2. 테이블
*/
/*
테이블 생성
테이블은 CREATE 문으로 생성할 수 있는데, 기본 구문은 다음과 같다.

    CREATE TABLE [스키마.]테이블명(
        컬럼1 컬럼1_데이터타입 [NULL, NOT NULL],
        컬럼2 컬럼2_데이터타입 [NULL, NOT NULL],
    ...
    )[TABLESPACE 테이블스페이스명];
*/
-- CREATE TABLE 스키마명.테이블명
-- 스키마 명 : 계정명으로 사용중, 접속자 상태가 동일한 경우엔 생략
 /*
    CREATE TABLE employees (
          EMPLOYEE_ID NUMBER(6,0) NOT NULL,
          EMP_NAME VARCHAR2(80) NOT NULL,
          ...
          SALARY NUMBER(8,2) ,
          HIRE_DATE DATE NOT NULL,
          ...
          ... );
  */
CREATE TABLE ex2_1 (
    column1 char(10),
    column2 varchar2(10),
    column3 nvarchar2(10),
    column4 number
);

-- 데이터 삽입
-- INSERT INTO EX2_1(COLUMN1, COLUMN2) VALUES(값1, 값2);
INSERT INTO EX2_1(COLUMN1, COLUMN2) VALUES('abc', 'abc');

--LENGTH(COLUMN1):컬럼의 기억장소 길이
--컬럼의 실제기억장소의 크기를 확인. CHAR(10)와 VARCHAR2(10)의 차이점
--char: 길이가 고정형 데이터, 2000byte, 예)주민번호 14자리
--varchar2 : 길이가 유동적인 데이터, 4000byte, 예) 아이디 8자~ 15자
SELECT COLUMN1, LENGTH(COLUMN1), COLUMN2, LENGTH(COLUMN2) FROM EX2_1; 




-----------------------------------24.04.03(수)-----------------------------------
CREATE TABLE ex2_2(
    COLUMN1 VARCHAR2(3), --3BYTE
    COLUMN2 VARCHAR2(3 BYTE),
    COLUMN3 VARCHAR2(3CHAR) -- 문자 3개(크기와 상관없이 영문이든 한글이든 3글자가 들어가겠다.)
); -- 만들고 안보이면 새로고침(*새로고침은 만들기 빡센 크로그램이라고 한다)


--오라클 데이터베이스 시스템
/*
    영문자, 아라비아숫자, 특수문자 : 1BYTE 관리.
    한글 : 3BYTE. 오라클 설치환경설정에 따라 상대적이다. 2BYTE일 수도 있다.
*/

--함수 : LENGTHB() : 매개변수에 제공되는 데이터의 바이트 정볼르 확인(B는 BYTE의 B)/ BYTE구하는 함수
SELECT LENGTHB('A'), LENGTHB(1), LENGTHB('*'), LENGTHB('김') FROM DUAL;
SELECT LENGTHB('손흥민') FROM DUAL; --9BYTE

--데이터 삽입 / 영문 문자열 데이터는 대소문자 구분. 'ABC', 'abc' 문자열 데이터로 인식된다.
--INSERT INTO 테이블명 (열1, 열2, 열3 ...) VALUES (값, 값, 값...);
INSERT INTO ex2_2(COLUMN1, COLUMN2, COLUMN3) VALUES ('abc', 'abc', 'abc');

--데이터 조회
SELECT COLUMN1, LENGTHB(COLUMN1), COLUMN2, LENGTHB(COLUMN2), COLUMN3, LENGTHB(COLUMN3) FROM ex2_2;

--한글데이터 입력시도 에러?
--스키마:그룹화 시켜서 관리
--ORA-12899: value too large for column "SQLDB"."EX2_2"."COLUMN1" (actual: 9, maximum: 3)
INSERT INTO ex2_2(COLUMN1, COLUMN2, COLUMN3)VALUES ('홍길동', '홍길동', '홍길동');

--COLUMN3 컬럼이 CARCHAR2(3CHAR)이므로, 한글 3개 문자 데이터 삽입 성공.
INSERT INTO ex2_2(COLUMN3) VALUES('홍길동'); --CHAR를 명시했다 : CHAR 타입에만 알맞게 대입하였다.

--데이터 조회
SELECT COLUMN1, LENGTHB(COLUMN1), COLUMN2, LENGTHB(COLUMN2), COLUMN3, LENGTHB(COLUMN3) FROM ex2_2;

-- 숫자 데이터 타입: NUMBER[(P,[S])]
--모두 내부적으로 NUMBER 데이터 타입으로 변환되어 진다.
CREATE TABLE EX2_3(
    COL_INT INTEGER,
    COL_DEC DECIMAL,
    COL_NUM NUMBER
);

--user_tab_cols 시스템 뷰 : 테이블의 컬럼 정보를 확인하는 용도
    SELECT column_id, column_name, data_type, data_length
    FROM user_tab_cols
    WHERE table_name = 'EX2_3'  -- 이 자리에 테이블 명을 기입하면 컬럼정보가 출력된다.
    ORDER BY column_id;           --테이블명이 데이터로 사용(''안에 들어가는것이 데이터로 사용되는거다)할 경우는 대문자로 입력 

--날짜형 데이터 타입 : DATE - 초단위 까지 관리, TIMESTAMP - 밀리세컨드단위 까지 관리.
CREATE TABLE EX2_5(
    COL_DATE DATE,
    COL_TIMESTAMP TIMESTAMP   -- 자꾸 나 마지막자리 옆에 ',' 쓰는데, 오류 발생한다. 주의
 );

-- 날짜 함수 : SYSDATE, SYSTIMESTAMP
--데이터 삽입 
INSERT INTO EX2_5(COL_DATE, COL_TIMESTAMP) VALUES(SYSDATE, SYSTIMESTAMP);
--SYSDATE : 시스템 상의 현재 시간(초까지)

--데이터 조회. 출력되는 날짜 형식 변경 : 도구 > 환경설정 > 데이터 베이스> NLS
SELECT * FROM EX2_5;

--시나리오
/*
 테이블명 : USERINFO
  컬럼명 : 이름(U_NAME) VARCHAR2(50),주소(U_ADDR) VARCHAR2(100), 연락처(U_TEL)VARCHAR2(20), 
          나이(U_AGE)NUMBER, 등록일(U_REG) DATE
*/
CREATE TABLE USERINFO(
    U_NAME VARCHAR2(50),
    U_ADDR VARCHAR2(100),
    U_TEL VARCHAR2(20),
    U_AGE NUMBER,
    U_REG DATE
);

INSERT INTO USERINFO(U_NAME, U_ADDR, U_TEL, U_AGE, U_REG) --이거 할때 왼쪽 접속창에서 원하는거 블럭 잡고 끌어오면 빠름
    VALUES ('이젠컴퓨터학원', '서울특별시 노원구', '02-000-0000', 10, SYSDATE);

SELECT * FROM USERINFO;

--LOB 데이터 타입 : 대용량 데이터를 저장 할 때 사용하는 데이터 타입
/*
 - 문자형데이터:CLOB, NCLOB / 4000BYTE보다 큰 문자열 데이터 저장
 - 그래픽, 이미지, 동영상 등의 데이터 : BLOB
 - BFILE은 실제 이진 파일이 아닌 데이터베이스 외부에 있는 파일에 대한 로케이터(해당 파일을 가리키는 포인터)를 저장하며, 
   실제 파일을 수정할 수는 없고 읽기만 가능하다.
*/

CREATE TABLE SAMPLE_1(
    COL1  VARCHAR2(50),
    COL2  CLOB
);

INSERT INTO SAMPLE_1(COL1, COL2) VALUES('진달래', '작엽활엽 관목으로, 한반도에 자주 분포');
INSERT INTO SAMPLE_1(COL1, COL2) VALUES('개나리', '물푸레나무과 식물로 봄철에 노란 꽃을 피우는 관목의 한 종류');
INSERT INTO SAMPLE_1(COL1, COL2) VALUES('봉선화', '쌍떡잎 식물 무환자무목 봉선화과의 한해살이풀');

--데이터 조회
SELECT * FROM SAMPLE_1;

--정렬 : ORDER BY COL1
SELECT * FROM SAMPLE_1 ORDER BY COL1 ASC;

--정렬 : ORDER BY COL2 / 
--결과 : 에러발생/ COL2 컬럼이 CLOB 데이터 타입이므로 정렬기능이 지원안됨./DISTINCT(중복값 제거 기능)도 지원안됨. 
--데이터 양이 많아 의미없다고 판단
SELECT * FROM SAMPLE_1 ORDER BY COL2 ASC; 

/*
--NULL
  :NULL은 ‘값이 없음’을 의미하며 테이블을 생성할 때 컬럼 속성에 기술한다. 
   디폴트 값이 NULL이므로 별도로 지정하지 않으면 해당 컬럼은 NULL을 허용하게 된다.
*/
-- NULL 허용 : 컬럼에 데이터를 입력해도 되고, 안해도 된다는 의미. (EX)자동차 보유 여부 등
-- NOT NULL 허용 : 컬럼에 데이터를 반드시 입력해야 한다는 의미. (EX)아이디, 비밀번호 등
CREATE TABLE SAMPLE_2(
 COL1 NUMBER, --COL1 NUMBER NULL 과 동일함. > NULL 허용
 COL2 VARCHAR2(50) NOT NULL --NULL 비허용 > 값을 반드시 입력해야햠.
);
--NULL이 허용된 컬럼에 입력할 값이 없으면 안쓰고 건너 뛰어도 된다.
--INSERT INTO SAMPLE_2(COL1) VALUES(1);는 (COL1)부터 에러 발생한다. NOT NULL이 허용된 컬럼이므로.
--오류:cannot insert NULL into ("SQLDB"."SAMPLE_2"."COL2")
INSERT INTO SAMPLE_2(COL2) VALUES(1);
INSERT INTO SAMPLE_2(COL1) VALUES(2);

INSERT INTO SAMPLE_2(COL1,COL2) VALUES(2, '테스트2');

--데이터 조회
SELECT * FROM SAMPLE_2;

--주의 :  DBMS 종류에 따라 NULL처리가 조금씩 다를 수 있어, 실무에서 데이터 베이스 따른 NULL 사용법을 확인

/**************************************제약조건******************************************/
/*① NOT NULL
    컬럼명 데이터타입 NOT NULL
    앞의 NULL에서 설명했듯이, 컬럼을 정의할 때 NOT NULL 제약조건을 명시하면 해당 컬럼에는 '반드시 데이터를 입력'해야 한다. 
    즉 반드시 값이 들어 있어야 하는 컬럼에는 NOT NULL 제약조건을 만들어 사용한다. 
*/
CREATE TABLE EX2_6(
    COL_NULL        VARCHAR2(10),
    COL_NOT_NULL    VARCHAR2(10) NOT NULL --오라클 서버가 자동으로 SYS_C007042 제약조건 객체이름 NOT NULL로 설정.
);

--데이터 삽입
--INSERT INTO SAMPLE_2(COL1,COL2) VALUES(2, '테스트2'); 
--원래 위처럼 작성하는데 아래처럼 컬럼명을 생략할 경우 모든 컴럼명에 값을 입력한다는 의미.
INSERT INTO EX2_6 VALUES('AA','');  -- 에러 : 오라클에서는 ''(공백)이 NULL의 의미로 사용 된다. --이건 MY SQL가면 에러
INSERT INTO EX2_6 VALUES('AA',NULL); -- 에러 : 위와 같은 의미  / -- ANSI-SQL표준 문법 //  < 가급적 이렇게 작성해라
--에러 : ORA-01400: cannot insert NULL into ("SQLDB"."EX2_6"."COL_NOT_NULL")

--아래 2코드는 동일한 구문이다.
INSERT INTO EX2_6 VALUES('AA','BB');
INSERT INTO EX2_6(COL_NULL,COL_NOT_NULL) VALUES('AA','BB');

--user_constraints 시스템 뷰 : 테이블의 제약조건 정보를 확인하는 용도.
    SELECT constraint_name, constraint_type, table_name, search_condition
    FROM user_constraints
    WHERE table_name = 'EX2_6';
    
    
/*
② UNIQUE
UNIQUE 제약조건은 말 그대로 해당 컬럼에 들어가는 값이 유일해야 한다는 의미다. 즉 중복 값을 허용하지 않는다.

    컬럼명 데이터타입 UNIQUE
    혹은
    CONSTRAINTS 제약조건명 UNIQUE(컬럼명, ...)
 특징 ) 테이블에 UNIQUE제약조건 여러개 생성 가능
*/
    
CREATE TABLE SAMPLE_3(
    U_NAME      VARCHAR2(50)    NOT NULL,
    SSN         CHAR(14)    UNIQUE NOT NULL -- 오라클 서버가 SQLDB.SYS_C007045 제약조건 객체이름으로 SSN컬럼에 UNIQUE제약 조건 설정
);
--데이터 입력
INSERT INTO SAMPLE_3(U_NAME, SSN) VALUES('손흥민', '123456-1234567');

-- 오류 : ORA-00001: unique constraint (SQLDB.SYS_C007045) violated
--'123456-1234567' 주민등록 번호가 존재하여, UNIQUE 제약조건 에러발생
INSERT INTO SAMPLE_3(U_NAME, SSN) VALUES('김민재', '123456-1234567'); 

-- 제약조건 설정 시 문법적으로 
--1)컬럼 수준제약 : 컬럼을 정의 할 때 사용  
--2)테이블 수준제약 : 테이블의 컬럼을 모두 정의하고 난 후 마지막 부분에 적용.

--컬럼 각각에 UNIQUE제약조건이 적용. EX2_7테이블은 UNIQUE제약 조건 3개가 적용되었다. 
CREATE TABLE EX2_7(
    COL_UNOQUE_NULL     VARCHAR2(10)    UNIQUE, -- NULL허용 / 오라클 서버가 UNIQUE 제약조건 이름을 자동생성
                                                -- 컬럼 수준 제약 : ','(구분자) 이전에 제약조건을 설정한다
    COL_UNOQUE_NNULL    VARCHAR2(10)    UNIQUE NOT NULL, --값은 유일해야한다 + 반드시 데이터를 입력해야 한다.
    COL_UNOQUE          VARCHAR2(10),
    CONSTRAINT UNIQUE_NM1 UNIQUE(COL_UNOQUE) ); --CONSTRAINT 제약조건이름 UNIQUE(컬럼명)
                                                 -- 컬럼명에 UNIQUE 제약조건을 걸겠다.
                                                -- 테이블 수준 제약 / 현장에 가면 이걸 많이 사용할거다.
                                                -- 마지막 코드는 제약조건을 수동으로 설정한다. 

--보출설명 : 제약조건 명령어를 사용하면, 제약조건 개체이름은 오라클 서버가 자동으로 생성해준다.
-- 제약조건개체 이름을 수동으로 정의하고 싶다면, 문법을 다음과 같이 한다.
--예) CONSTRAINT UNIQUE_NM1 UNIQUE

--데이터 입력
INSERT INTO EX2_7 VALUES('AA', 'AA', 'AA'); -- 첫번째 실행

INSERT INTO EX2_7 VALUES('AA', 'AA', 'AA'); -- 두번째 실행 시 에러
--첫번째 열에 UNIQUE제약 걸려있음. 중복값입력 불가. 더하여 첫째열에서 오류가 나면 그 뒤는 해볼 필요도 없으므로 진행되지 않고 종료됨
--ORA-00001: unique constraint (SQLDB.SYS_C007047) violated

INSERT INTO EX2_7 VALUES('', 'BB', 'BB'); --세번째 실행
-- INSERT INTO EX2_7 VALUES(NULL, 'BB', 'BB'); 의미가 같다. 

SELECT * FROM EX2_7;

INSERT INTO EX2_7 VALUES('', 'CC', 'CC'); --네번째 실행
--NULL도 중복 검사에 해당 되나?
--세번째 실행에서 NULL이 존재해도, NULL은 또 사용이 가능하다. NULL은 중복대상에서 제외 된다.
--다른 데이터베이스에서 NULL은 단 1번만 허용하는 경우도 있다.(예: MS-SQL 데이터베이스)

SELECT * FROM EX2_7;

INSERT INTO EX2_7 VALUES('', 'CC', 'CC'); --다섯번째 실행
--ORA-00001: unique constraint (SQLDB.SYS_C007048) violated
--두번째 열에서 CC중복값 입력 불가로 인해 오류 발생

COMMIT;    --- 하루 작업 완료하면 COMMIT반드시 할것, 안하면 데이터 다 날아간다.

-----------------------------------24.04.04(목)-----------------------------------

-- 테이블컬럼을 2개 이상 묶어서 UNIQUE제약조건 적용하기. (복합컬럼을 대상으로 UNIQUE제약조건 적용)
--테이블 수준제약 문법을 사용해야 복합컬럼 UNIQUE제약조건을 적용 할 수 있다.

-- 단일컬럼 각각을 UNIQUE 제약조건을 만든 예, 이 테이블에 UNIQUE제약조건은 2개 생성
-- 예1) 잘못 이해하고 만든 예
CREATE TABLE SAMPLE_4(
    COL1    NUMBER UNIQUE,
    COL2    VARCHAR2(10) UNIQUE,
    COL3    VARCHAR2(10),
    COL4    VARCHAR2(10)
);
    
-- 예2) 올바르게 이해하고 만든 예 : 테이블 수준 제약으로 명령해야 한다.
CREATE TABLE SAMPLE_5(
    COL1    NUMBER,
    COL2    VARCHAR2(10),
    COL3    VARCHAR2(10),
    COL4    VARCHAR2(10), 
    UNIQUE(COL1, COL2) -- 컬럼 2개를 묶어서 UNIQUE제약조건 1개 만들었음.
);

--데이터 삽입
INSERT INTO SAMPLE_5(COL1, COL2)VALUES(1, 'A'); -- 첫번째 실행
INSERT INTO SAMPLE_5(COL1, COL2)VALUES(1, 'B'); -- 두번째 실행

SELECT*FROM SAMPLE_5;

INSERT INTO SAMPLE_5(COL1, COL2)VALUES(1, 'A'); -- 세번째 실행
-- ORA-00001: unique constraint (SQLDB.SYS_C007055) violated


/*
③ 기본키
기본키Primary key라고도 하고 영어 그대로 ‘Primary key’라고 한다. 
보통 테이블에 키를 생성했다라고 할 때, 이는 기본키를 의미한다. 
특징) 기본키는 UNIQUE와 NOT NULL 속성을 동시에 가진 제약조건으로, 테이블 당 1개의 기본키만 생성할 수 있다.★★★★★

단일컬럼을 기본키로 설정하면 단일키 - 컬럼수준 제약
복합컬럼을 기본키로 설정하면 복합키 - 테이블 수준 제약


    컬럼명 데이터타입 PRIMARY KEY
    혹은
    CONSTRAINTS 제약조건명 PRIMARY KEY(컬럼명, ...)
*/
CREATE TABLE EX2_8(
    COL1    VARCHAR(10)     PRIMARY KEY, -- UNIQUE와 NOT NULL의 특징모두 가지고 있다.
    COL2    VARCHAR(10)
    -- 단일컬럼의 기본키 설정 : 단일키
);
--포폴하며 게시판 테이블, 고객테이블 등 테이블을 형성하고 페이징 기능을 만들 때
--PRIMARY KEY 제약조건을 자동으로 만들어 사용하면 안된다. 수동으로 만들어야 한다.

--데이터 입력
-- 오라클 INSERT문
INSERT INTO EX2_8 VALUES('','AA'); --에러 / MY-SQL에서는 작동 안될 수도 있다.
--ORA-01400: cannot insert NULL into ("SQLDB"."EX2_8"."COL1")
-- 첫번째 컬럼에 NULL을 입력할 수 없다. 값을 넣어라.

-- ANSI-SQL INSERT문
INSERT INTO EX2_8 VALUES(NULL,'AA'); --위와 에러/ MY-SQL에서 정상적으로 작동 할 것이다. 

INSERT INTO EX2_8 VALUES('AA','AA'); --ORA-00001: unique constraint (SQLDB.SYS_C007056) violated
-- 복합기 테이블 예


--1) 잘봇 이해하고 만든 예,
-- 에러발생. 왜? : 기본키는 테이블당 단 1개만 생성 가능하다. 아래는 2개를 생성하는 의미므로 오류 발생.
CREATE TABLE SAMPLE_6(
    COL1    NUMBER PRIMARY KEY,
    COL2    VARCHAR2(10) PRIMARY KEY ,
    COL3    VARCHAR2(10),
    COL4    VARCHAR2(10)
); --ORA-02260: table can have only one primary key
    
-- 예2) 올바르게 이해하고 만든 예 : 테이블 수준 제약으로 명령해야 한다.
--PRIMARY KEY 제약조건 개체이름이 오라클 서버가 자동으로 생성 해준다. 
-- 그래서 제약조건객체 이름이 스프링에서 페이징기능 구현 시 사용될 경우는 제약조건객체 이름을 수동으로 생성해주어야 한다.
CREATE TABLE SAMPLE_7(
    COL1    NUMBER,
    COL2    VARCHAR2(10),
    COL3    VARCHAR2(10),
    COL4    VARCHAR2(10), 
    CONSTRAINTS PK_SAMPLE_7_COL1_COL2 PRIMARY KEY(COL1, COL2) -- 컬럼 2개를 묶어서 PRIMARY KEY제약조건 1개 만들었음.
);
--위의 테이블에 PRIMARY KEY(복합키)설정으로 COL1, COL2 컬럼에 동시에 만족하는 데이터는 중복 될 수 없다.
--여러개의 컬럼을 하나의 기본키로 만드는 경우 최대 컬럼개수는 32까지 가능하다. (SAMPLE_7은 2개)


/*
④ 외래키 또는 참조키
외래키Foreign key는 테이블 간의 참조 데이터 무결성을 위한 제약조건이다.

    CONSTRAINT 외래키명 FOREIGN KEY(컬럼명, ...)
    REFERENCES 참조 테이블(참조 테이블 컬럼명, ...)
*/
--부서 테이블
CREATE TABLE DEPT(
    D_CODE   NUMBER PRIMARY KEY,    -- 이 컬럼이 참조 받는 조건은 PRIMARY KEY OR UNIQUE설정이 되어있어야 한다.
    D_NAME  VARCHAR2(20)    NOT NULL
);

--사원테이블 참조키가 설정되는 테이블. 
--EMP에 있는 D_CODE와 DEPT에 있는 D_CODE 똑같지 않아도 상관없다.
--하비만 사원테이블 D_CODE컬럼은 부서테이블의 D_CODE컬럼의 데이터 타입이 동일해야 한다. 
CREATE TABLE EMP(
    E_ID   NUMBER PRIMARY KEY,
    E_NAME  VARCHAR2(20)    NOT NULL,
    D_CODE NUMBER REFERENCES DEPT(D_CODE)--컬럼수준 제약 (여기에는 FOREIGN KEY을 입력하지 않는다.)
);

--사원테이블
CREATE TABLE EMP(
    E_ID   NUMBER PRIMARY KEY,
    E_NAME  VARCHAR2(20)    NOT NULL,
    D_CODE NUMBER,
    FOREIGN KEY(D_CODE) REFERENCES DEPT(D_CODE) --테이블 수준 제약
);

--테이블 삭제 명령어: 참조키가 설정된 테이블 삭제는 순서가 있다. (★★★★★)
DROP TABLE EMP;-- 참조하는 테이블은 먼저 삭제해야 한다.
DROP TABLE DEPT;-- 참조받는 테이블은 나중에 삭제 해야 한다. 

--테이블 참조키 설정된 모습을 툴로 확인하기
--보기 > DATA MODELER > 브라우저 선택 
-- 브라우저 도구모음에서 관계형모델 우클릭 선택 > 새관계형 모델 클릭

--데이터 입력
-- 1) 부서테이블
INSERT INTO DEPT VALUES(1, '총무부');
INSERT INTO DEPT VALUES(2, '개발부');
INSERT INTO DEPT VALUES(3, '영업부');
INSERT INTO DEPT VALUES(4, '홍보부');

SELECT * FROM DEPT;

--2) 사원테이블 
INSERT INTO EMP VALUES(1001, '손흥민', 1);
INSERT INTO EMP VALUES(1002, '김민재', 2);
INSERT INTO EMP VALUES(1003, '황희찬', 3);
INSERT INTO EMP VALUES(1004, '이강인', 4);

INSERT INTO EMP VALUES(1005, '황선홍', 7);-- 에러, DEPT에는 7번 부서가 없다.
--ORA-02291: integrity constraint (SQLDB.SYS_C007064) violated - parent key not found
--개발을 할때는 제약조건을 잠시 중단 시켜놓는다. 작업하는데 거슬리니까

/* <참조키 제약사항>
외래키에 대한 제약사항은 다음과 같다.
1)반드시 참조하는 테이블이 먼저 생성되어야 하며, 
2)참조키가 참조 테이블의 기본키로 만들어져 있어야 한다.
3)외래키에 사용할 수 있는 컬럼 개수는 최대 32개다.
4)여러 컬럼을 외래키로 만들려면, 참조하는 컬럼과 외래키 컬럼의 순서와 개수는 같아야 한다.
*/
/* <현장에서의 외래키 생성 시점>
시스템 개발 현장에서는 보통 초창기에는 외래키를 생성하지 않는다. 
개발 중에는 수시로 데이터를 입력하고 삭제하는 경우가 빈번한데, 외래키를 생성하면 여러 모로 불편한 것이 사실이다. 
그래서 개발 후 테스트 기간을 거쳐 어느 정도 시스템이 안정화된 이후 외래키를 생성할 때가 많다.
*/

/*
⑤ CHECK
마지막으로 알아볼 제약조건으로 CHECK가 있다. 
컬럼에 입력되는 데이터를 체크해 특정 조건에 맞는 데이터만 입력 받고 그렇지 않으면 오류를 뱉어 낸다.

    CONSTRAINT 체크명 CHECK(체크조건)
*/
CREATE TABLE EX2_9 (
    NUM1    NUMBER CONSTRAINTS CHECK1 CHECK(NUM1 BETWEEN 1 AND 9), --NUM1컬럼에 숫자데이터 1~9 범위로 입력가능
    GENDER  VARCHAR2(10)CONSTRAINTS CHECK2 CHECK(GENDER IN ('MALE', 'FEMALE')) 
    -- GENDER컬럼에 문자데이터 'MALE', 'FEMALE' 문자데이터만 입력 가능
);

INSERT INTO EX2_9 VALUES (10,'MALE'); -- 1번 컬럼 범위 초과로 인한 에러
--ORA-02290: check constraint (SQLDB.CHECK1) violated  //CHECK1의 제약을 확인해랴

INSERT INTO EX2_9 VALUES (5,'FEMALE');

SELECT * FROM EX2_9;

COMMIT;--커밋을 하지안으면, 데이터 입력한 것들은 임시상태에 있다. 때문에 물리적으로 입력한 데이터 반영을 위해 커밋을 해야한다.

--DEFAULT(기본값): 제약조건은 아니지만 컬럼속성 명령어
CREATE TABLE EX2_10(
    COL1    VARCHAR2(10)    NOT NULL,
    COL2    VARCHAR2(10)    NULL,
    CREATE_DATE DATE DEFAULT SYSDATE  -- 현재 컴퓨터의 날짜, 시간을 가져온다.
);

--데이터 입력
-- CREATE_DATE입력시 생략하게 되면 데이터 삽입 시 SYSDATE가 작동된다. 컴퓨터의 날짜와 시간을 읽어와 삽입된다.
INSERT INTO EX2_10(COL1, COL2)VALUES('AA',  'BB');

--CREATE_DATE컬럼의 데이터 수동 입력 
INSERT INTO EX2_10 VALUES('AA', 'BB', '2024-04-04'); --'2024-04-04'문자열 데이터가 날짜 데이터로 형변환 되어 저장된다.

SELECT * FROM EX2_10;

----------------------제약조건 예제----------------------
CREATE TABLE DEPT_CONST(
    DEPTNO  NUMBER(2) CONSTRAINT DEPTCONST_DEPTNO_PK PRIMARY KEY,
    DNAME   VARCHAR2(14)CONSTRAINT DEPTCONST_DNAME_UNQ UNIQUE,
    LOC     VARCHAR2(13) CONSTRAINT DEPTCONST_LOC_NN NOT NULL
);


CREATE TABLE EMP_CONST(
    EMPNO  NUMBER(4) CONSTRAINT EMPCONST_EMPNO_PK PRIMARY KEY,
    ENAME   VARCHAR2(10) CONSTRAINT EMPCONST_ENAME_NN NOT NULL,
    JOB     VARCHAR2(9),
    TEL   VARCHAR2(20) CONSTRAINT EMPCONST_TEL_UNQ UNIQUE,
    HIREDATE DATE,
    SAL     NUMBER(7,2) CONSTRAINT EMPCONST_SAL_CHK CHECK(SAL BETWEEN 1000 AND 9999),
    COMM    NUMBER(7,2),
    DEPTNO  NUMBER(2)  CONSTRAINT EMPCONST_DEPTNO_FK REFERENCES DEPT_CONST(DEPTNO)
);

commit;


-----------------------------------24.04.05(금)-----------------------------------

-------------쇼핑몰 데이터베이스 설계 예제-----------
CREATE TABLE USERS (
    id          VARCHAR2(20)    PRIMARY KEY, -- 회원 아이디
    pwd         VARCHAR2(20),    -- 회원 비밀번호
    name        VARCHAR2(20),   --회원 이름
    enail       VARCHAR2(40),   --회원 이메일
    zip_code    CHAR(5),        --회원 우편번호
    address     VARCHAR2(100),  -- 회원 주소
    phone       VARCHAR2(20),   --회원 전화번호
    useyn       NUMBER DEFAULT 1,   -- 회원 탈퇴여부
    regdate     DATE DEFAULT SYSDATE -- 회원 가입일
);

CREATE TABLE PRODUCT (
    prodnum         NUMBER(5)  PRIMARY  KEY,    --상품 번호
    name            VARCHAR2(200),  --상품 이름
    kind            CHAR(1),    --상품 종류 / bag:1, wallet:2, shoes:3, acc:4
    price1          NUMBER(7),  --원가
    price2          NUMBER(7),  -- 판매가
    price3          NUMBER(7),  --이익
    content         VARCHAR2(1000), --상품설명
    image           VARCHAR2(50),   --상품사진
    useyn           CHAR DEFAULT 'Y',   --판매유무 / 판매:'y', 판매중단 'n'
    regdate         DATE        --등록일
);

CREATE TABLE ADMIN (
    id      varchar2(20)  primary key,  --관리자 아이디
    pwd     varchar2(20),   --관리자 비밀번호
    name    varchar2(20),   --관리자 이름
    email   varchar2(40),   --관리자 이메일
    phone   varchar2(20)    --관리자 전화번호
);

CREATE TABLE CART (
    cartnum     NUMBER(8)   primary key, --장바구니 번호
    id          VARCHAR2(20), --장바구니 이용 회원
    prodnum     NUMBER(5), -- 상품번호
    quantity    NUMBER(5)   default 1,  -- 수량
    result      CHAR(1), -- 배송유무 / 배송전:1, 배송후:2
    indate      DATE, -- 카트담은 날짜
    Foreign Key(id) REFERENCES USERS (ID),
    Foreign Key(PRODNUM)REFERENCES PRODUCT (PRODNUM)
);

CREATE TABLE ORDERS(
    ordernum    NUMBER(10)      PRIMARY KEY,  --주문번호
    id          VARCHAR2(20),      --주문회원 아이디
    indate      DATE,  --주문날짜
    FOREIGN KEY(ID) REFERENCES USERS (ID)
);

CREATE TABLE ORDER_DETAIL (
    ODNUM       NUMBER(10)  PRIMARY KEY, --주문처리 번호
    ORDERNUM    NUMBER(10), --주문번호
    PRODNUM     NUMBER(5),  --상품번호
    QUANTITY    NUMBER(5), -- 수량
    RESULT      CHAR(1)     DEFAULT 1, --처리유무 / 배송전 :1, 배송후 :2
    FOREIGN KEY(ORDERNUM) REFERENCES ORDERS (ORDERNUM),
    FOREIGN KEY(PRODNUM) REFERENCES PRODUCT (PRODNUM)
);

CREATE TABLE QNA (
    QSEQ        NUMBER(5)       PRIMARY KEY, --문의 번호
    SUBJECT     VARCHAR2(30),   --문의 제목
    CONTENT     VARCHAR2(1000), --문의 내용
    REPLY       VARCHAR2(1000), --답변내용
    ID          VARCHAR2(20),  --문의한 고객
    REP         CHAR(1)         DEFAULT 1, --답변유무 / 답변전 : 1, 답변후 :2
    INDATE      DATE,  -- 문의날짜
    FOREIGN KEY(ID) REFERENCES USERS (ID)
    );



-- 테이블 삭제
/*
 DROP TABLE [스키마.]테이블명 [CASCADE CONSTRAINTS]
  CASCADE CONSTRAINTS를 붙이면 삭제할 테이블의 기본키와 UNIQUE 키를 참조하는 
  참조 무결성 제약조건도 자동으로 삭제된다.
*/
DROP TABLE DEPT_CONST; --EMP_CONST테이블로부터 참조를 받고 있는 테이블이기 때문에 삭제가 안된다.

--삭제순서 중요.
DROP TABLE EMP_CONST;
DROP TABLE DEPT_CONST;

--[CASCADE CONSTRAINTS] 사용
DROP TABLE DEPT_CONST CASCADE CONSTRAINTS; --EMP_CONST테이블의 참조키 제약조건을 자동삭제


--테이블 변경
--기존에 생성했던 컬럼의 데이터 타입을 수정하거나 삭제, 새로운 컬럼을 추가하는 경우가 발생
DROP TABLE EX2_10;

CREATE TABLE EX2_10 (
    COL1        VARCHAR2(10)    NOT NULL,
    COL2        VARCHAR2(10)    NULL,
    CREATE_DATE DATE DEFAULT SYSDATE
);

/*
① 컬럼명 변경: col1 컬럼 이름을 col11으로 변경
    ALTER TABLE [스키마.]테이블명 RENAME COLUMN 변경전컬럼명 TO 변경후컬럼명;
*/
ALTER TABLE EX2_10 RENAME COLUMN COL1 TO COL11;

--컬럼 변경 확인
DESC EX2_10; --테이블의 컬럼구성 확인


/*
② 컬럼 타입 변경: col2 컬럼을 VARCHAR2(10)에서 VARCHAR2(30)으로 변경
    ALTER TABLE [스키마.]테이블명 MODIFY 컬럼명 데이터타입;
*/
ALTER TABLE EX2_10
MODIFY COL2 VARCHAR2(30);

--컬럼확인
DESC EX2_10;

/*
③ 컬럼 추가: col3 NUMBER 타입으로 신규 생성
    ALTER TABLE [스키마.]테이블명 ADD 컬럼명 데이터타입;
*/
ALTER TABLE EX2_10
ADD COL3 NUMBER;

--컬럼 확인
DESC EX2_10;

/*
④ 컬럼 삭제: col3 컬럼을 삭제
    ALTER TABLE [스키마.]테이블명 DROP COLUMN 컬럼명;
*/
ALTER TABLE EX2_10
DROP COLUMN COL3;

--컬럼 확인
DESC EX2_10;

/*
⑤ 제약조건 추가: col11에 기본키 추가
    ALTER TABLE [스키마.]테이블명 ADD CONSTRAINTS 제약조건명 PRIMARY KEY (컬럼명, ..);
*/
ALTER TABLE EX2_10
ADD CONSTRAINTS PK_EX2_10 PRIMARY KEY(COL11);

/*
⑥ 제약조건 삭제: col11에서 기본키 삭제
    ALTER TABLE [스키마.]테이블명 DROP CONSTRAINTS 제약조건명;
*/
ALTER TABLE EX2_10
DROP CONSTRAINTS PK_EX2_10;

--컬럼 확인
DESC EX2_10;


/*
테이블 복사
프로젝트를 하다 보면 기존에 있는 테이블을 복사해서 사용할 경우가 발생한다. 
예를 들어, 사용하고 있는 기존 테이블의 테이블의 구조를 자주 변경한다면 미리 복사해 만들어 테스트해보거나, 
테이블 데이터 자체를 백업용으로 만들어 놓을 수도 있다.
    CREATE TABLE [스키마.]테이블명 AS
    SELECT 컬럼1, 컬럼2, ...
    FROM 복사할 테이블명;
    
※ 기본키는 복사가 안된다. 그러나 다른 제약조건은 복사된다.※
*/

SELECT * FROM EX2_9;

--설명 : SELECT * FROM EX2_9 실행 결과의 데이터를 EX2_9_1테이블을 생성하여 관리하겠다.
CREATE TABLE EX2_9_1 
AS 
SELECT*FROM EX2_9;   --EX2_9테이블로부터 EX2_9_1테이블을 새로 만들겠다.

--확인
SELECT * FROM EX2_9_1;

--시나리오 : 사원테이블 중 부서코드가 50번인 데이터를 보관하는 테이블 생성하라. EMP_DEPATRMENT_ID_50
CREATE TABLE EMP_DEPARTMENT_ID_50
AS
SELECT EMPLOYEE_ID, EMP_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, SALARY, MANAGER_ID, DEPARTMENT_ID
FROM employees 
WHERE DEPARTMENT_ID = 50;

--시나리오2: 사원테이블에서 급여가 5000이상인 데이터를 EMP_SALARY_5000테이블 명으로 생성하라.
-- 컬럼명은 사원번호, 사원이름, 급여, 커미션, 부서코드 사용
CREATE TABLE EMP_SALARY_5000
AS
SELECT employee_id, EMP_NAME, SALARY, COMMISSION_PCT, DEPARTMENT_ID  --복사전 여기행부터 먼저 실행해보면 데이터부터 출력해 확인 할 수 있다.
FROM employees 
WHERE SALARY >= 5000;

--확인
SELECT * FROM EMP_SALARY_5000;

--데이터 입력
--201 사원번호가 존재 한 상태/ 기본키가 복사가 안되어서 사원번호 201은 중복저장이 가능하게 된다.
INSERT INTO EMP_SALARY_5000 VALUES(201, 'DOCCOMSA', 20000, NULL, 20);

COMMIT;
