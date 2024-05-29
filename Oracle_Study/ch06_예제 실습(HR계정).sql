-------------------------24.04.15(월)--------------
-- 문제1) 사원들의 이름, 부서번호, 부서명을 출력하라.
-- 부서번호는 사원테이블에서 참조하오독 한다.(권장: 사원을 기준으로 작업). e.department_id
SELECT e.first_name, e.department_id, d.department_name 
FROM employees e, departments d
WHERE e.department_id = d.department_id;

-- 문제2) 30번 부서의 사원들의 이름, 직업코드, 부서명을 출력하라. (2개의 테이블 참조)
-- 1. employees테이블 : 이름, 직업코드 / 2. departmetn테이블 : 부서명
SELECT e.first_name, e.job_id, d.department_name 
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.department_id = 30;

-- 문제3) 30번 부서의 사원들의 이름, 직업이름, 부서명을 출력하라. (3개의 테이블 참조)
-- 1. employees : 이름 / 2.departments : 부서명 / 3. jobs : 직업이름 
SELECT e.first_name, j.job_title, d.department_name
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
AND e.job_id = j.job_id 
AND e.department_id = 30;

-- 문제4) 커미션을 받는(조건)/사원의 이름(컬럼명), 직업코드(컬럼명), 부서번호(컬럼명), 부서명(컬럼명)을 출력하라.
SELECT e.first_name, e.job_id, e.department_id, d.department_name 
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND COMMISSION_PCT IS NOT NULL;

-- 문제5) 지역번호(location_id) 2500에서/ 근무하는 사원의 이름(1), 직업명(2), 부서번호(3), 부서명(4)을 출력하라.
SELECT e.first_name,j.job_title, d.department_id, d.department_name
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
AND e.job_id = j.job_id 
AND d.location_id = 2500;

-- 문제6) 사원이름(1)과 부서명(2)과 월급(3)을 출력하는데 /월급이 3000이상인 사원을 출력하라.
--employees :  first_name, salary  / departments : department_name
SELECT e.first_name, e.salary, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id 
AND e.salary >= 3000; 

-- 문제7) 급여가 3000에서 5000사이인/ 사원의 이름(1)과 부서명(2)을 출력하라(between 3000 and 5000 이용)
SELECT e.first_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id 
AND e.salary between 3000 and 5000;

-- 문제8) 급여가 3000이하인/ 사원의 이름(1)과 급여(2), 근무지(3)를 출력하라.
SELECT e.first_name , e.salary, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id 
AND l.LOCATION_ID = d.LOCATION_ID
AND e.salary <= 3000;
