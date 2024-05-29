------------------------------24.04.09(화)----------------------------------

/*
01 숫자 함수

02 문자 함수

03 날짜 함수

04 변환 함수

05 NULL 관련 함수

06 기타 함수
*/
--숫자 함수란 수식 연산을 하는 함수로 연산 대상 즉, 매개변수나 반환 값이 대부분 숫자 형태다.
--① ABS(n)
--ABS 함수는 매개변수로 숫자를 받아 그 절대값을 반환하는 함수다.
SELECT ABS(10), ABS(-10), ABS(-10.123) FROM DUAL;  --DUAL은 임시테이블

--② CEIL(n):올림함수 과 FLOOR(n) : 내림함수
--CEIL 함수는 매개변수 n과 같거나 가장 큰 정수를 반환한다. 소수점 있으면 무조건 올림
SELECT CEIL(10.123), CEIL(10.541), CEIL(11.001) FROM DUAL;

--FLOOR 함수는 CEIL 함수와 반대로 매개변수 n보다 작거나 가장 큰 정수를 반환한다. 무조건 내림
SELECT FLOOR(10.123), FLOOR(10.541), FLOOR(11.001) FROM DUAL;


/*
③ ROUND(n, i)와 TRUNC(n1, n2)
ROUND 함수는 매개변수 n을 소수점 기준 (i+1)번 째에서 반올림한 결과를 반환한다. 
i는 생략할 수 있고 디폴트 값은 0, 즉 소수점 첫 번째 자리에서 반올림이 일어나 정수 부분의 일의 자리에 결과가 반영된다.
*/

-- 소수 첫째 자리에서 반올림 여부 판단. 
--매개변수 1개를 사용한 예.
SELECT ROUND(10.154), ROUND(10.541), ROUND(11.001) FROM DUAL;

--매개변서 2개를 사용한 예. 2번째 매개변수가 양수, 음수 여부에 따라 기능이 다르다.
/*
2번재 매개변수가 양수이면, 소수부분을 가리킨다. 
 N+1의 위치를 반올림 여부를 계산한다. 
*/
SELECT ROUND(10.154, 1), ROUND(10.154, 2), ROUND(10.154, 3)FROM DUAL;

/*
2번재 매개변수가 음수이면, 정수부분을 가리킨다. 
 N의 위치를 반올림 여부를 계산한다. 
 : -1이면 정수 첫째 자리, -2면 정수 둘재 자리
*/
SELECT ROUND(0, 3), ROUND(115.155, -1), ROUND(115.155, -2)FROM DUAL;

/*
TRUNC 함수는 반올림을 하지 않고 n1을 소수점 기준 n2자리에서 무조건 잘라낸 결과를 반환한다. 
n2 역시 생략할 수 있으며 디폴트 값은 0이고,양수일 때는 소수점 기준으로 오른쪽, 음수일 때는 소수점 기준 왼쪽 자리에서 잘라낸다.
*/
 SELECT TRUNC(115.155), TRUNC(115.155, 1), TRUNC(115.155, 2), TRUNC(115.155, -2)FROM DUAL;


/*
④ POWER(n2, n1)와 SQRT(n)
POWER 함수는 n2를 n1 제곱한 결과를 반환한다. n1은 정수와 실수 모두 올 수 있는데, n2가 음수일 때 n1은 정수만 올 수 있다.
*/
SELECT POWER(3, 2), POWER(3, 3), POWER(3, 3.0001)FROM DUAL;

SELECT SQRT(2), SQRT(5) FROM DUAL; --매개변수에 루트 씌운것

/*
⑤ MOD(n2, n1)와 REMAINDER(n2, n1)
MOD 함수는 n2를 n1으로 나눈 나머지 값을 반환한다.
*/
SELECT MOD(19,4), MOD(19.123, 4.2)FROM DUAL;

/*
REMAINDER 함수 역시 n2를 n1으로 나눈 나머지 값을 반환하는데, 나머지를 구하는 내부적 연산 방법이 MOD 함수와는 약간 다르다.

? MOD → n2 - n1 * FLOOR (n2/n1)

? REMAINDER → n2 - n1 * ROUND (n2/n1)
*/
SELECT REMAINDER(19,4), REMAINDER(19.123, 4.2)FROM DUAL;


--02 | 문자 함수
--문자 함수는 연산 대상이 문자이며 반환 값은 함수에 따라 문자나 숫자를 반환한다.
/*
① INITCAP(char), LOWER(char), UPPER(char)
INITCAP 함수는 매개변수로 들어오는 char의 첫 문자는 대문자로, 나머지는 소문자로 반환하는 함수다. 
이때 첫 문자를 인식하는 기준은 공백과 알파벳(숫자 포함)을 제외한 문자다. 
즉 공백이나 알파벳이 아닌 문자를 만난 후 다음 첫 알파벳 문자를 대문자로 변환한다.
*/
 SELECT INITCAP('never say goodbye'), INITCAP('never6say*good가bye')
      FROM DUAL;

SELECT emp_name, INITCAP(emp_name) FROM employees;

COMMIT;

-------------------------2024.04.11(목)-----------------------
--소문자, 대문자로 변환
SELECT LOWER('NEVER SAY GOODBYE'), UPPER('never say goodbye') FROM DUAL;

SELECT emp_name, LOWER(emp_name), UPPER(emp_name) FROM employees;

/*
② CONCAT(char1, char2), SUBSTR(char, pos, len), SUBSTRB(char, pos, len)
CONCAT 함수는 ‘||’ 연산자처럼 매개변수로 들어오는 두 문자를 붙여 반환한다.
*/
SELECT CONCAT('I Have', ' A Dream'), 'I Have' || ' A Dream' FROM DUAL;

SELECT CONCAT(emp_name, salary),emp_name || ' ' || salary FROM employees;

/*
SUBSTR는 문자 함수 중 가장 많이 사용되는 함수로, 
잘라올 대사 문자열인 char의 pos번째 문자부터 len길이만큼 잘라낸 결과를 반환하는 함수다. 
pos 값으로 0이 오면 디폴트 값인 1, 즉 첫 번째 문자를 가리키며, 음수가 오면 char 문자열 맨 끝에서 시작한 상대적 위치를 의미한다. 
또한 len 값이 생략되면 pos번째 문자부터 나머지 모든 문자를 반환한다.
*/
                -- 1은 위치, 4는 개수           -- -1은 뒤에서 첫번째 위치, 4는 개수
SELECT SUBSTR('ABCDEFG', 1, 4), SUBSTR('ABCDEFG', -1, 4) FROM DUAL;
--첫번째부터 4개까지 반환해라/         뒤에서 첫번째부터 +4까지 반환해라

--첫번째부터 3개를 반환해라
SELECT emp_name, SUBSTR(emp_name, 1, 3) || '****' FROM employees;

--바이트 단위. 한글은 3바이트로 관리되고 있기 때문에 한글쪽은 6을 넣으면 두글자씩 출력 된다.
SELECT SUBSTR('ABCDEFG', 1, 4), SUBSTR('가나다라마바사', 1, 6) FROM DUAL;

--한글이 몇바이트로 관리되고 있는지 확인
SELECT LENGTHB('가') FROM DUAL;

/*
③ LTRIM(char, set), RTRIM(char, set)
LTRIM 함수는 매개변수로 들어온 char 문자열에서 set으로 지정된 문자열을 왼쪽 끝에서 제거한 후 나머지 문자열을 반환한다. 
두 번째 매개변수인 set은 생략할 수 있으며, 디폴트로 공백 문자 한 글자가 사용된다. 
RTRIM 함수는 LTRIM 함수와 반대로 오른쪽 끝에서 제거한 뒤 나머지 문자열을 반환한다.
*/
-- 좌측공백 제거, 우측공백 제거
SELECT LENGTH('    ABCDEF'), LENGTH(LTRIM('    ABCDEF')),LENGTH(RTRIM('ABCDEF    '))FROM DUAL;

--매개변수 2개를 사용한 경우, 2번째 매개변수 값에 온느 내용을 좌, 우측에서 단, 1번만 제거 한다. 
--좌측제거, 우측제거만 있음. 가운데 제거 없음.
SELECT LTRIM('ABCDEFGABC', 'ABC'),
        LTRIM('가나다라', '가'),
        RTRIM('ABCDEFGABC', 'ABC'),
        RTRIM('가나다라', '라')
   FROM DUAL;

/*
④ LPAD(expr1, n, expr2), RPAD(expr1, n, expr2)
LPAD 함수는 매개변수로 들어온 expr2 문자열(생략할 때 디폴트는 공백 한 문자)을 n자리만큼 왼쪽부터 채워 expr1을 반환하는 함수다. 
매개변수 n은 expr2와 expr1이 합쳐져 반환되는 총 자릿수를 의미한다. 
예를 들어, 서울의 지역 전화번호는 ‘02’인데 전화번호 컬럼에 지역번호가 없으면 LPAD 함수로 번호 02를 자동으로 채워 넣을 수 있다.
*/
CREATE TABLE ex4_1 (phone_num VARCHAR2(30));

INSERT INTO ex4_1 VALUES ('111-1111');
INSERT INTO ex4_1 VALUES ('111-2222');
INSERT INTO ex4_1 VALUES ('111-3333');

SELECT * FROM ex4_1;

COMMIT;-- 데이터 작업내용을 실제 데이터베이스 파일에 물리적으로 반영한다.

--왼쪽을 채우기
SELECT phone_num, LPAD(phone_num, 12, '(02)') FROM ex4_1;

-- 오른쪽 채우기
SELECT phone_num, LPAD(phone_num, 12, '(02)'), RPAD(phone_num, 12, '(02)') FROM ex4_1;

/*
⑤ REPLACE(char, search_str, replace_str), TRANSLATE(expr, FROM_str, to_str)
REPLACE 함수는 char 문자열에서 search_str 문자열을 찾아 이를 replace_str 문자열로 대체한 결과를 반환하는 함수다.
*/
--'나'를 찾아서 '너'로 바꾸기
SELECT REPLACE('나는 너를 모르는데 너는 나를 알겠는가?', '나', '너')FROM DUAL;

SELECT REPLACE('나는 너를 모르는데 너는 나를 알겠는가?', '나는', '너는')FROM DUAL;

--문자열에 있는 공백을 모두 제거 할 수 있다.
    SELECT LTRIM(' ABC DEF '),
           RTRIM(' ABC DEF '),
           REPLACE(' ABC DEF ', ' ', '')
      FROM DUAL;

--REPLACE와 TRANSLATE의 차이점// TRANSLATE는 암호화를 위해 사용할수 있겠으나 수준이 낮다. 
SELECT REPLACE('나는 너를 모르는데 너는 나를 알겠는가?', '나는', '너를') AS rep, -- 나는 단어를 찾아서 너를 변경
       TRANSLATE('나는 너를 모르는데 너는 나를 알겠는가?', '나는', '너를') AS trn -- 나>너, 는>를 로 각각 찾아 변경
      FROM DUAL;
      
/*
⑥ INSTR(str, substr, pos, occur), LENGTH(chr), LENGTHB(chr)
INSTR 함수는 str 문자열에서 substr과 일치하는 위치를 반환하는데, pos는 시작 위치로 디폴트 값은 1, 
occur은 몇 번째 일치하는지를 명시하며 디폴트 값은 1이다.
*/
SELECT INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약') AS INSTR1, --첫번째 위치에서 부터 '만약'찾기
           INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약', 5) AS INSTR2, -- 5번재 위치에서 부터 '만약' 찾기
           INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약', 5, 2) AS INSTR3 --5섯번째 위치에서부터 시작해서 두번째로 나오는 '만약' 찾기
      FROM DUAL;

/*
LENGTH 함수는 매개변수로 들어온 문자열의 개수를 반환하며, LENGTHB 함수는 해당 문자열의 바이트 수를 반환한다.
*/
SELECT LENGTH('대한민국'), LENGTHB('대한민국')FROM DUAL;


/*
03 | 날짜 함수
날짜 함수는 DATE 함수나 TIMESTAMP 함수와 같은 날짜형을 대상으로 연산을 수행해 결과를 반환하는 함수다. 
날짜 함수 역시 대부분 반환 결과는 날짜형이나 함수에 따라 숫자를 반환할 때도 있다.
*/


--① SYSDATE - 년, 월, 일, 초, SYSTIMESTAMP- 년, 월, 일, 초, 밀리초
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

/*
② ADD_MONTHS (date, integer)
ADD_MONTHS 함수는 매개변수로 들어온 날짜에 interger 만큼의 월을 더한 날짜를 반환한다.
*/
--날짜에 월을 더함. 음수를 사용하면 뺄 수도 있음.
SELECT ADD_MONTHS(SYSDATE, 1), ADD_MONTHS(SYSDATE, -1)FROM DUAL;

/*
③ MONTHS_BETWEEN(date1, date2)
MONTHS_BETWEEN 함수는 두 날짜 사이의 개월 수를 반환하는데, date2가 date1보다 빠른 날짜가 온다.
*/
SELECT MONTHS_BETWEEN(SYSDATE, ADD_MONTHS(SYSDATE, 1)) mon1,
       MONTHS_BETWEEN(ADD_MONTHS(SYSDATE, 1), SYSDATE) mon2
  FROM DUAL;

SELECT employee_id, emp_name, MONTHS_BETWEEN(SYSDATE, HIRE_DATE) mon1, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))FROM employees;

--근속년수
SELECT employee_id, emp_name, MONTHS_BETWEEN(SYSDATE, HIRE_DATE) mon1, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))/12 AS "근속년수" FROM employees;


/*
④ LAST_DAY(date)
LAST_DAY는 date 날짜를 기준으로 해당 월의 마지막 일자를 반환한다.
*/
SELECT LAST_DAY('2024-02-01'), Last_DAY(SYSDATE)
FROM DUAL;

/*
⑤ ROUND(date, format), TRUNC(date, format)
ROUND와 TRUNC는 숫자 함수이면서 날짜 함수로도 쓰이는데, ROUND는 format에 따라 반올림한 날짜를, TRUNC는 잘라낸 날짜를 반환한다.
*/
SELECT SYSDATE, ROUND(SYSDATE, 'month'), TRUNC(SYSDATE, 'month')FROM DUAL;

--15일까지는 반올림이 안된다.
SELECT '2024-04-15', ROUND(TO_DATE('2024-04-15'), 'month'), TRUNC(TO_DATE('2024-04-15'), 'month')FROM DUAL;
--16일 이상일 경우 반올림 되어 한달이 더해진다. //TRUNC는 무조건 내림.(자른다)
SELECT '2024-04-16', ROUND(TO_DATE('2024-04-16'), 'month'), TRUNC(TO_DATE('2024-04-16'), 'month')FROM DUAL;


/*
⑥ NEXT_DAY (date, char)
NEXT_DAY는 date를 char에 명시한 날짜로 다음 주 주중 일자를 반환한다.
*/
-- 현재 날짜 기준으로 돌아오는 금요일이 언제인가?
SELECT NEXT_DAY(SYSDATE, '금요일') FROM DUAL;
/*
char로 올 수 있는 값은 ‘일요일’에서 ‘토요일’까지인데, 
이 값은 NLS_LANG이란 오라클 환경 변수에 따라 한글이 올 수도, ‘SUNDAY’, ‘MONDAY’ 처럼 영문이 올 수도 있다.
*/



/*
04 | 변환 함수
변환 함수란 서로 다른 유형의 데이터 타입으로 변환해 결과를 반환하는 함수를 말한다. 
3장에서 언급했듯이 오라클이 자동으로 형변환을 해주는 것을 묵시적 형변환이라 하는데 
이 절에서 학습하는 변환 함수를 통해 형변환을 직접 처리하는 것을 명시적 형변환이라고 한다.
*/
/*
① TO_CHAR (숫자 혹은 날짜, format)
숫자나 날짜를 문자로 변환해 주는 함수가 바로 TO_CHAR로, 
매개변수로는 숫자나 날짜가 올 수 있고 반환 결과를 특정 형식에 맞게 출력할 수 있다.
*/
--3자리마다 ','를 넣어 문자데이터로 변환하겠다.
SELECT TO_CHAR(123456789, '999,999,999')
FROM DUAL;

--날짜데이터를 년-월-일 형식으로 출력하겠다.
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD')
FROM DUAL;

/*
② TO_NUMBER(expr, format)
문자나 다른 유형의 숫자를 NUMBER 형으로 변환하는 함수다.
*/
--문자데이터를 숫자형으로 변환.
SELECT TO_NUMBER('123456')FROM DUAL;

/*
③ TO_DATE(char, format), TO_TIMESTAMP(char, format)
문자를 날짜형으로 변환하는 함수다. 형식 매개변수로는 [표 4-1]에 있는 항목이 올 수 있으며, 
TO_DATE는 DATE 형으로 TO_TIMESTAMP는 TIMESTAMP 형으로 변환해 값을 반환한다.
*/
--문자열데이터를 날짜 형으로 변환해주는 함수 //아무거나 넣는다고 다 되는건 아니다. 
SELECT TO_DATE('20140101', 'YYYY-MM-DD')FROM DUAL;
SELECT TO_DATE('20140101 13:44:50', 'YYYY-MM-DD HH24:MI:SS')FROM DUAL;

/*
05 | NULL 관련 함수
3장에서 알아봤듯이 NULL을 비교할 때는 IS NULL이나 IS NOT NULL 구문을 사용하였는데, 
오라클에서는 NULL을 연산 대상으로 처리하는 SQL 함수를 제공하고 있다.
*/
/*
① NVL(expr1, expr2), NVL2((expr1, expr2, expr3)
NVL 함수는 expr1이 NULL일 때 expr2를 반환한다.
*/
--manager_id컬럼의 데이터가 NULL이면, employee_id컬럼의 값이 반환되고, 
--manager_id컬럼의 데이터가 존재하면(NOT NULL) manager_id컬럼의 데이터가 반환된다.
SELECT NVL(manager_id, employee_id)
FROM employees
WHERE manager_id IS NULL;

SELECT NVL(NULL, 10), NVL(10, 20) FROM DUAL;

/*
NVL2는 NVL을 확장한 함수로 expr1이 NULL이 아니면 expr2를, NULL이면 expr3를 반환하는 함수다.
*/
SELECT employee_id, salary, commission_pct,
NVL2(commission_pct, salary + (salary * commission_pct), salary) AS salary2
--commission_pct이 null이면 salary를 출력하고 not null이면 salary + (salary * commission_pct)코드가 출력된다.
FROM employees;

SELECT NVL2(NULL, 10, 20), NVL2(10, 20, 30) FROM DUAL;

-- NULL과 연산시 결과는 NULL이 된다.(중요)
SELECT NULL + 100 FROM DUAL;

/*
② COALESCE (expr1, expr2, …)
COALESCE 함수는 매개변수로 들어오는 표현식에서 NULL이 아닌 첫 번째 표현식을 반환하는 함수다.
*/
--널이 아닌 것을 반환
SELECT COALESCE(NULL, NULL, 1), COALESCE(NULL, 1, 2),COALESCE(1,2,3), COALESCE(NULL, NULL, NULL) FROM DUAL;

--COALESCE (salary * commission_pct, salary) : salary * commission_pct 값이 null이면 salary컬럼의 값이 반환되고
--salary * commission_pctdl 'not null'이면 자신의 결과값이 반환된다.
SELECT employee_id, salary, commission_pct,
COALESCE (salary * commission_pct, salary) AS salary2
FROM employees;


/*
③ LNNVL(조건식)
LNNVL은 매개변수로 들어오는 조건식의 결과가 FALSE이면 true, 조건식의 결과가 true이면 false로 반환
*/

SELECT emp_name, commission_pct FROM employees
WHERE LNNVL (commission_pct = 0);

--위의 구문을 다음처럼 변경 할 수가 있다.
SELECT emp_name, commission_pct FROM employees
WHERE commission_pct IS NULL OR commission_pct != 0;

SELECT salary FROM employees
WHERE LNNVL (salary > 5000);  --49건

SELECT salary FROM employees
WHERE salary <= 5000;  --49건


/*
④ NULLIF (expr1, expr2)
NULLIF 함수는 expr1과 expr2을 비교해 같으면 NULL을, 같지 않으면 expr1을 반환한다.
*/
    SELECT NULLIF(100, 100), NULLIF(100, 200) FROM DUAL;

-- job_history 테이블에서 start_date와 end_date의 연도만 추출해 두 연도가 같으면 NULL을, 같지 않으면 종료년도를 출력하는 쿼리다.
    SELECT employee_id,
           TO_CHAR(start_date, 'YYYY') start_year,
           TO_CHAR(end_date, 'YYYY') end_year,
           NULLIF(TO_CHAR(end_date, 'YYYY'), TO_CHAR(start_date, 'YYYY') ) nullif_year
    FROM job_history;

/*
06 | 기타 함수
① GREATEST(expr1, expr2, …), LEAST(expr1, expr2, …)
GREATEST는 매개변수로 들어오는 표현식에서 가장 큰 값을, LEAST는 가장 작은 값을 반환하는 함수다.
※ '…' : 매개변수의 갯수가 제한 없다는 뜻.
*/
SELECT GREATEST(1, 2, 3, 2) AS "가장큰값",LEAST(1, 2, 3, 2)AS "가장작은 값" FROM DUAL;
SELECT GREATEST('이순신', '강감찬', '세종대왕'),LEAST('이순신', '강감찬', '세종대왕')FROM DUAL;


/*
② DECODE (expr, search1, result1, search2, result2, …, default)
DECODE는 expr과 search1을 비교해 두 값이 같으면 result1을, 
같지 않으면 다시 search2와 비교해 값이 같으면 result2를 반환하고, 
이런 식으로 계속 비교한 뒤 최종적으로 같은 값이 없으면 default 값을 반환한다.
*/
-- IF문 SWHICH문과 비슷하다.
    SELECT prod_id,
             DECODE(channel_id, 3, 'Direct',
                                9, 'Direct',
                                5, 'Indirect',
                                4, 'Indirect',
                                   'Others')  decodes
       FROM sales
      WHERE rownum < 10;
-- 오늘날 이런 작업은 CASE문으로 대체 된다. sales테이블 파일은 홈페이지 가면 다운 받을 수 있지만 여기서 그리 중요치 않음.

commit;