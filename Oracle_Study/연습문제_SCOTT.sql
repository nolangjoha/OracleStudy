---------------------24.04.17(수)------------------------- 
--------------------오라클 DB 연습문제-----------------------
-- 1. 업무(JOB)가 MANAGER 인 사원의 이름, 입사일 출력
SELECT ename, hiredate FROM emp WHERE job = 'MANAGER';
?

-- 2. 사원명이 WARD 인 사원의 급여, 커미션을 출력
SELECT sal, comm FROM emp WHERE ename = 'WARD';
?

-- 3. 30번 부서에 속하는 사원의 이름, 부서번호를 출력
SELECT ename,deptno FROM emp WHERE deptno = 30;
?

-- 4-1. 급여가 1250을 초과, 3000이하인 사원의 이름, 급여를 출력
SELECT ename,sal  FROM emp WHERE sal >1250 AND sal <=3000;
?

-- 4-2. 급여가 1250이상이고, 3000이하인 사원의 이름, 급여를 출력(범위가 포함됨)
SELECT ename,sal  FROM emp WHERE sal >=1250 AND sal <= 3000;
?

-- 5. 커미션이 0 인 사원이 이름, 커미션을 출력
SELECT ename,comm  FROM emp WHERE comm = 0;
?

-- 6-1. 커미션 계약을 하지 않은 사원의 이름츨 출력
SELECT ename  FROM emp WHERE comm IS NULL;
?
-- 6-2. 커미션 계약을 한 사원의 이름을 출력
SELECT ename  FROM emp WHERE comm IS NOT NULL;

-- 7. 입사일이 81/06/09 보다 늦은 사원이 이름, 입사일 출력(입사일을 기준으로 오름차순.)
SELECT ename, hiredate FROM emp WHERE hiredate > '1981-06-09' ORDER BY hiredate ASC; 
SELECT ename, hiredate FROM emp WHERE hiredate > '1981/06/09' ORDER BY hiredate ASC; 

?-- 8. 모든 사원의 급여마다 1000을 더한 급여를 출력*
SELECT sal + 1000 FROM emp ;
?
-- 9. FORD 의 입사일, 부서번호를 출력
SELECT ename, hiredate FROM emp WHERE ename ='FORD' ; 
?
-- 10. 사원명이 ALLEN인 사원의 급여를 출력하세요.
SELECT ename, sal FROM emp WHERE ename ='ALLEN' ; 

-- 11. ALLEN의 급여보다 높은 급여를 받는 사원의 사원명, 급여를 출력
SELECT ename, sal FROM emp WHERE sal >(SELECT sal FROM emp WHERE ename = 'ALLEN'); 


-- 12. 가장 높은/낮은 커미션을 구하세요.(최대값/최소값)
SELECT MAX(COMM) FROM EMP; 
SELECT MIN(COMM) FROM EMP; 
?
-- 13. 가장 높은 커미션을 받는 사원의 이름을 구하세요.
SELECT ENAME FROM emp WHERE COMM =(SELECT MAX(COMM) FROM EMP); 

-- 14. '가장 높은 커미션을 받는' '사원'의 '입사일'보다 '늦은 사원'의 '이름' '입사일'을 출력 
SELECT ename, hiredate FROM emp WHERE hiredate > (SELECT HIREDATE 
                                                  FROM EMP 
                                                  WHERE COMM = (SELECT MAX(COMM) FROM EMP)); 
?
-- 15. JOB이 CLERK 인 사원들의 급여의 합을 구하세요.*
SELECT SUM(sal) FROM emp WHERE JOB = 'CLERK';

-- 16. JOB 이 CLERK 인 사원들의 급여의 합보다 급여가 많은 사원이름을 출력.*
SELECT ename FROM emp WHERE sal > (SELECT SUM(sal) FROM emp WHERE JOB = 'CLERK');
?

-- 17. JOB이 CLERK 인 사원들의 급여와 같은 급여를 받는 사원의 이름, 급여를 출력(급여 내림차순으로)
SELECT ename,sal FROM emp WHERE sal IN (SELECT sal FROM emp WHERE JOB = 'CLERK') ORDER BY sal DESC;
?
-- 18. EMP테이블의 구조출력
DESC EMP;

------------------2번예제------------------------------------
SELECT * FORM emp WHERE;

-- 1. ALLEN 과 부서가 같은 사원들의 사원명, 입사일을 출력(급여 내림차순 정렬)
SELECT ename, hiredate FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename='ALLEN') ORDER BY sal DESC;

-- 2. 가장 높은 급여를 받는 사원보다 입사일이 늦은 사원의 이름, 입사일을 출력
SELECT ename, hiredate FROM emp WHERE 
                                hiredate > (SELECT HIREDATE FROM EMP WHERE 
                                            SAL  = (SELECT MAX(SAL) FROM EMP)
                                            );
?
-- 3. 이름에 'T' 자가 들어가는 사원들의 급여의 합을 구하세요. (LIKE 사용)
SELECT SUM(sal) FROM emp WHERE ename LIKE '%T%';
SELECT ename, sal FROM emp WHERE ename LIKE '%T%';

-- 4. 모든 사원의 평균급여를 구하세요. 소수 둘째자리 반올림표현
SELECT Round(AVG(sal), 2) FROM emp;

-- 5. 각 부서별 평균 급여를 구하세요. 소수 둘째자리 반올림표현 (GROUP BY)
SELECT deptno,round(AVG(sal), 2) FROM emp GROUP BY deptno;

-- 6. 각 부서별 평균급여, 전체급여, 최고급여, 최저급여를 구하여 평균급여가 높은 순으로 출력. 평균은 소수 둘째자리 반올림표현
SELECT round(AVG(sal), 2), SUM(sal), MAX(sal),MIN(sal) 
FROM emp 
GROUP BY deptno ORDER BY AVG(sal) DESC;

-- 7. 20번 부서의 최고 급여보다 많은 사원의 사원번호, 사원명, 급여를 출력
SELECT empno, ename, sal FROM emp WHERE sal > (SELECT MAX(Sal) FROM emp WHERE deptno = 20);

-- 8. SMITH 와 같은 부서에 속한 사원들의 평균급여보다 큰 급여를 받는 모든 사원의 사원명, 급여를 출력
SELECT ename, SAL FROM emp WHERE SAL > (SELECT AVG(SAL) FROM emp 
                                        WHERE Deptno = (SELECT DEPTNO FROM emp WHERE ename = 'SMITH'));
?
-- 9. 회사내의 최소급여와 최대급여의 차이를 구하세요. 
SELECT MAX(sal)- MIN(sal) FROM emp;

-- 10. SCOTT 의 급여에서 1000 을 뺀 급여보다 적게 받는 사원의 이름, 급여를 출력.
SELECT ename, sal FROM emp WHERE sal < (SELECT sal-1000 FROM emp WHERE ename = 'SCCOT'); 
?--SCOTT이 없다..ㅇㅅㅇ

-- 11. JOB이 MANAGER인 사원들 중 최소급여를 받는 사원보다 /급여가 적은 사원이름, 급여를 출력
SELECT ename, sal FROM emp WHERE sal < (SELECT MIN(sal) FROM emp WHERE job = 'MANAGER');

-- 12. 이름이 S로 시작하고 마지막글자가 H인 사원의 이름을 출력
SELECT ename FROM emp WHERE ename LIKE 'S%H';

-- 13. WARD 가 소속된 부서 사원들의 평균 급여보다, 급여가 높은 사원의 이름,급여를 출력.
SELECT ename, sal FROM emp WHERE sal > (SELECT AVG(sal) FROM emp 
                                        WHERE DEPTNO = (SELECT DEPTNO FROM emp WHERE ename = 'WARD'));

-- 14-1. EMP테이블의 모든 사원수를 출력
SELECT COUNT(*) FROM emp;

-- 15. 업무별(JOB) 사원수를 출력
SELECT job,COUNT(*) FROM emp GROUP BY job;

-- 16. 최소급여를 받는 사원과 같은 부서의 모든 사원명을 출력
SELECT ename FROM emp WHERE DEPTNO = (SELECT DEPTNO FROM emp 
                                      WHERE SAL =(SELECT MIN(sal) FROM emp)
                                      );
                                      
------------------3번예제------------------------------------                                      
-- 1. 업무(JOB)가 MANAGER인 사원의 이름, 부서명, 입사일을 출력
SELECT ename, deptno, hiredate FROM emp WHERE job = 'MANAGER';
?
-- 2. 사원명이 WARD인 사원의 급여, 부서번호, 부서위치, 커미션을 출력
SELECT emp.sal, emp.deptno, dept.loc, emp.comm
FROM emp INNER JOIN dept
ON emp.deptno = dept.deptno 
AND emp.ename = 'WARD';

-- 3. 30번 부서에 속하는 사원의 이름, 부서번호, 부서위치를 출력
SELECT e.ename, e.deptno, d.loc
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.deptno = 30;

-- 4-1. 급여가 1250을 초과, 3000이하인 사원의 이름, 급여, 부서명을 출력
SELECT e.ename, e.deptno, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal >1250
AND e.sal <= 3000;

-- 4-2. 급여가 1250이상 3000 이하인 사원의이름, 급여(BETWEEN 사용)
SELECT e.ename, e.deptno, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal BETWEEN 1250 AND 3000;

-- 5. 커미션이 0 인 사원의 이름, 부서위치, 커미션을 출력
SELECT e.ename, d.loc, e.COMM
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.comm = 0;

-- 6.커미션 계약을 하지않은 사원의 이름, 부서명을 출력
SELECT e.ename,d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.COMM IS NULL;

-- 7. 입사일이 81/06/09보다 늦은 사원이 이름, 부서위치, 입사일 출력(입사일 오름차순)
SELECT e.ename,d.loc,e.hiredate
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.hiredate > '1981/06/09';

-- 8. 모든 사원의 급여마다 1000을 더한 급여액, 사원명, 급여, 부서명을 출력
SELECT e.ename, e.sal+1000, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno;

-- 9. FORD의 입사일, 부서명을 출력
SELECT e.hiredate, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.ename = 'FORD';

-- 10. 사원명이 ALLEN인 사원의 급여, 부서번호, 부서위치를 출력
SELECT e.sal, e.deptno ,d.loc
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.ename = 'ALLEN';

-- 11. ALLEN의 급여보다 높은 급여를 받는 사원의 사원명, 부서명, 부서위치, 급여를 출력
SELECT e.ename, e.deptno ,d.loc, e.sal
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal > (SELECT sal FROM emp WHERE ename = 'ALLEN');

-- 12. 가장 높은/낮은 커미션을 구하세요.
SELECT MAX(COMM) FROM EMP; 
SELECT MIN(COMM) FROM EMP; 

-- 13. 가장 높은 커미션을 받는 사원의 이름, 부서명을 구하세요.
SELECT e.ename, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.comm = (SELECT MAX(COMM) FROM EMP);

-- 14. JOB이 CLERK 인 사원들의 급여의 합을 구하세요
SELECT SUM(sal)
FROM emp
WHERE job ='CLERK';

-- 15. JOB 이 CLERK 인 사원들의 급여의 합보다 급여가 많은 사원이름, 부서명을 출력
SELECT e.ename, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal > (SELECT SUM(sal)FROM emp WHERE job ='CLERK');

-- 16. JOB이 CLERK인 사원들의 급여와 같은 급여를 받는 사원의 이름,부서명,급여를 출력(급여가 높은순으로 출력)
SELECT e.ename, d.dname, e.sal
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal IN (SELECT sal FROM emp WHERE job ='CLERK')
ORDER BY e.sal ASC;

-------------------24.04.18(목)-----------------------------
------------------4번예제------------------------------------
-- 1. 최소급여를 받는 사원과 같은 부서에서 근무하는 모든 사원명, 부서명을 출력
SELECT MIN(sal) FROM emp; --최소급여

SELECT e.ename, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.deptno = (SELECT deptno FROM emp WHERE sal = (SELECT MIN(sal) FROM emp)); 

-- 2. SCOTT보다 입사일이 늦은 사원과 같은 부서에서 근무하는 사원들의/ 부서명, 이름, 급여를 출력 
-- SCOTT 없음 CLARK로 하자
SELECT d.dname, e.ename, e.sal
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.deptno IN (
                SELECT deptno FROM emp WHERE hiredate > 
                (SELECT hiredate FROM emp WHERE ename ='CLARK')
                );

-- 3. 이름에 'K'자가 들어가는 사원들 중 급여가 가장 적은 사원의 부서명, 사원명, 급여를 출력 
SELECT ename FROM emp WHERE ename LIKE '%K%'; -- 이름에 'T'자가 들어가는 사원

SELECT d.dname, e.ename, e.sal
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal = (SELECT MIN(sal) FROM emp WHERE ename LIKE '%K%');

-- 4. 커미션 계약이 없는 사원중 입사일이 가장 빠른 사원의 부서명, 사원명, 입사일을 출력
SELECT ename FROM emp WHERE comm IS NULL; --커미션 계약 없는 사원
SELECT MIN(hiredate) FROM emp WHERE comm IS NULL;

SELECT d.dname, e.ename, e.hiredate
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.hiredate =(SELECT MIN(hiredate) FROM emp WHERE comm IS NULL);

-- 5. 위치가 시카고인 부서에 속한 사원들의 이름과 부서명을 출력.
SELECT DEPTNO FROM DEPT WHERE LOC ='CHICAGO';

SELECT e.ename, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.deptno IN (SELECT DEPTNO FROM DEPT WHERE LOC ='CHICAGO');

-- 6. KING의 급여에서 CLARK의 급여를 뺀 결과보다 적은 급여를 받는 /사원의 부서명, 이름, 급여를 출력 
SELECT sal FROM emp WHERE ename = 'KING'
SELECT sal FROM emp WHERE ename = 'CLARK'

SELECT (SELECT sal FROM emp WHERE ename = 'KING')-(SELECT sal FROM emp WHERE ename = 'CLARK') FROM DUAL;

SELECT d.dname, e.ename, e.sal
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal < (SELECT (SELECT sal FROM emp WHERE ename = 'KING')-(SELECT sal FROM emp WHERE ename = 'CLARK') FROM DUAL);

-- 7. DALLAS에 위치한 부서에 속한 사원의 총사원수, 평균급여,전체급여,최고급여,초저급여를 구하세요. 
SELECT deptno FROM dept WHERE loc = 'DALLAS'; 
?
SELECT COUNT(*), ROUND(AVG(sal), 2), MIN(sal), MAX(sal), SUM(sal)
FROM emp
WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'DALLAS');

-- 8. 커미션 계약조건이 있으며 이름에 'N'자가 들어가는 사원들 중 급여가 가장 적은 사원의 사원명, 급여,부서명을 출력
SELECT ename, comm FROM emp WHERE Comm IS NOT NULL AND ename LIKE '%N%';

SELECT e.ename, e.sal, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal = (SELECT MIN(sal) FROM emp WHERE Comm IS NOT NULL AND ename LIKE '%N%');

-- 9. ALLEN 보다 입사일이 빠른 사원의 부서명,사원명을 출력
SELECT hiredate FROM emp WHERE ename = 'ALLEN';

SELECT e.ename, d.dname, e.hiredate
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.hiredate < (SELECT hiredate FROM emp WHERE ename = 'ALLEN');

-- 10. EMP 테이블에서 이름이 5글자인 사원중 급여가 가장 높은 사원의 이름, 급여 , 부서명을 출력
SELECT MAX(sal) FROM emp WHERE LENGTH(ename) = 5;

SELECT e.ename, d.dname, e.sal
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal = (SELECT MAX(sal) FROM emp WHERE LENGTH(ename) = 5);

-- 11. CLARK 이 속한 부서의 평균 연봉보다 급여가 높은 사원중 입사일이 가장 빠른 사원의 부서명, 사원명, 급여를 출력
SELECT deptno FROM emp WHERE ename = 'CLARK'; --CLARK이 속한 부서

SELECT ROUND(AVG(sal), 2) FROM emp WHERE deptno =(SELECT deptno FROM emp WHERE ename = 'CLARK');
-- CLARKDL 속한 부서의 평균 연봉

SELECT ename, sal, hiredate FROM emp WHERE sal > 
(SELECT ROUND(AVG(sal), 2) FROM emp WHERE deptno =(SELECT deptno FROM emp WHERE ename = 'CLARK'));
-- CLARKDL 속한 부서의 평균 연봉보다 급여가 높은 사원의 이름, 급여, 입사일

SELECT hiredate FROM emp WHERE sal > 
(SELECT ROUND(AVG(sal), 2) FROM emp WHERE deptno =(SELECT deptno FROM emp WHERE ename = 'CLARK'));
-- CLARKDL 속한 부서의 평균 연봉보다 급여가 높은  사원들의 입사일

SELECT MIN(hiredate) FROM emp WHERE hiredate IN (SELECT hiredate FROM emp WHERE sal > 
(SELECT ROUND(AVG(sal), 2) FROM emp WHERE deptno =(SELECT deptno FROM emp WHERE ename = 'CLARK')));
-- CLARKDL 속한 부서의 평균 연봉보다 급여가 높은  사원들의 입사일중 가장 빠른 입사일

SELECT e.ename, d.dname, e.sal
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno 
AND e.hiredate = (SELECT MIN(hiredate) FROM emp WHERE hiredate IN (SELECT hiredate FROM emp WHERE sal > 
(SELECT ROUND(AVG(sal), 2) FROM emp WHERE deptno =(SELECT deptno FROM emp WHERE ename = 'CLARK'))));


-- 12. ALLEN의 부서명을 출력
SELECT deptno FROM emp WHERE ename = 'ALLEN'; --ALLEN의 부서코드
SELECT dname FROM dept WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'ALLEN');

-- 13. 이름에 J가 들어가는 사원들 중, 급여가 가장 높은 사원의 사원번호, 이름, 부서명, 급여, 부서위치를 출력
SELECT ename FROM emp WHERE ename LIKE '%J%'; -- 이름에 j가 들어가는 사원
SELECT MAX(sal) FROM emp WHERE ename IN (SELECT ename FROM emp WHERE ename LIKE '%J%'); 
-- 이름에 j가 들어가는 사원중 급여가 가장 높은 사람의 급여

SELECT e.empno, e.ename, e.sal, d.loc
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno 
AND e.sal = (SELECT MAX(sal) FROM emp WHERE ename IN (SELECT ename FROM emp WHERE ename LIKE '%J%'));

-- 14. 두번째로 많은 급여를 받는 사원의 이름과 부서명,급여를 출력
SELECT MAX(sal) FROM emp; -- 최대급여
SELECT MAX(sal) FROM emp WHERE sal < (SELECT MAX(sal) FROM emp); --두번째로 급여가 많은 사람의 급여

SELECT e.ename, d.dname, e.sal
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno 
AND e.sal = (SELECT MAX(sal) FROM emp WHERE sal < (SELECT MAX(sal) FROM emp));

-- 15. 입사일이 2번째로 빠른 사원의 부서명과 이름, 입사일을 출력
SELECT d.dname, e.ename, e.hiredate
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno 
AND e.sal = (SELECT MAX(sal) FROM emp WHERE sal < (SELECT MAX(sal) FROM emp));

-- 16. DALLAS에 위치한 부서의 사원 중 최대 급여를 받는 사원의 급여에서 최소 급여를 받는 사원의 급여를 뺀 결과를 출력
SELECT deptno FROM dept WHERE loc = 'DALLAS'; --달라스에 위치한 부서코드

SELECT ename FROM emp WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'DALLAS');
--달라스에 위치한 부서에 있는 사원

SELECT MAX(sal) FROM emp WHERE ename IN (SELECT ename FROM emp WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'DALLAS'));
-- 최대급여
SELECT MIN(sal) FROM emp WHERE ename IN (SELECT ename FROM emp WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'DALLAS'));
-- 최소급여

SELECT ((SELECT MAX(sal) FROM emp WHERE 
                                  ename IN 
                                  (SELECT ename FROM emp 
                                  WHERE deptno = 
                                  (SELECT deptno FROM dept WHERE loc = 'DALLAS'))) 
                                  -
                                  (SELECT MIN(sal) FROM emp 
                                  WHERE ename IN (SELECT ename FROM emp WHERE deptno = 
                                  (SELECT deptno FROM dept WHERE loc = 'DALLAS'))))AS "최대급여-최소급여" 
FROM DUAL;

