---------------------24.04.17(��)------------------------- 
--------------------����Ŭ DB ��������-----------------------
-- 1. ����(JOB)�� MANAGER �� ����� �̸�, �Ի��� ���
SELECT ename, hiredate FROM emp WHERE job = 'MANAGER';
?

-- 2. ������� WARD �� ����� �޿�, Ŀ�̼��� ���
SELECT sal, comm FROM emp WHERE ename = 'WARD';
?

-- 3. 30�� �μ��� ���ϴ� ����� �̸�, �μ���ȣ�� ���
SELECT ename,deptno FROM emp WHERE deptno = 30;
?

-- 4-1. �޿��� 1250�� �ʰ�, 3000������ ����� �̸�, �޿��� ���
SELECT ename,sal  FROM emp WHERE sal >1250 AND sal <=3000;
?

-- 4-2. �޿��� 1250�̻��̰�, 3000������ ����� �̸�, �޿��� ���(������ ���Ե�)
SELECT ename,sal  FROM emp WHERE sal >=1250 AND sal <= 3000;
?

-- 5. Ŀ�̼��� 0 �� ����� �̸�, Ŀ�̼��� ���
SELECT ename,comm  FROM emp WHERE comm = 0;
?

-- 6-1. Ŀ�̼� ����� ���� ���� ����� �̸��� ���
SELECT ename  FROM emp WHERE comm IS NULL;
?
-- 6-2. Ŀ�̼� ����� �� ����� �̸��� ���
SELECT ename  FROM emp WHERE comm IS NOT NULL;

-- 7. �Ի����� 81/06/09 ���� ���� ����� �̸�, �Ի��� ���(�Ի����� �������� ��������.)
SELECT ename, hiredate FROM emp WHERE hiredate > '1981-06-09' ORDER BY hiredate ASC; 
SELECT ename, hiredate FROM emp WHERE hiredate > '1981/06/09' ORDER BY hiredate ASC; 

?-- 8. ��� ����� �޿����� 1000�� ���� �޿��� ���*
SELECT sal + 1000 FROM emp ;
?
-- 9. FORD �� �Ի���, �μ���ȣ�� ���
SELECT ename, hiredate FROM emp WHERE ename ='FORD' ; 
?
-- 10. ������� ALLEN�� ����� �޿��� ����ϼ���.
SELECT ename, sal FROM emp WHERE ename ='ALLEN' ; 

-- 11. ALLEN�� �޿����� ���� �޿��� �޴� ����� �����, �޿��� ���
SELECT ename, sal FROM emp WHERE sal >(SELECT sal FROM emp WHERE ename = 'ALLEN'); 


-- 12. ���� ����/���� Ŀ�̼��� ���ϼ���.(�ִ밪/�ּҰ�)
SELECT MAX(COMM) FROM EMP; 
SELECT MIN(COMM) FROM EMP; 
?
-- 13. ���� ���� Ŀ�̼��� �޴� ����� �̸��� ���ϼ���.
SELECT ENAME FROM emp WHERE COMM =(SELECT MAX(COMM) FROM EMP); 

-- 14. '���� ���� Ŀ�̼��� �޴�' '���'�� '�Ի���'���� '���� ���'�� '�̸�' '�Ի���'�� ��� 
SELECT ename, hiredate FROM emp WHERE hiredate > (SELECT HIREDATE 
                                                  FROM EMP 
                                                  WHERE COMM = (SELECT MAX(COMM) FROM EMP)); 
?
-- 15. JOB�� CLERK �� ������� �޿��� ���� ���ϼ���.*
SELECT SUM(sal) FROM emp WHERE JOB = 'CLERK';

-- 16. JOB �� CLERK �� ������� �޿��� �պ��� �޿��� ���� ����̸��� ���.*
SELECT ename FROM emp WHERE sal > (SELECT SUM(sal) FROM emp WHERE JOB = 'CLERK');
?

-- 17. JOB�� CLERK �� ������� �޿��� ���� �޿��� �޴� ����� �̸�, �޿��� ���(�޿� ������������)
SELECT ename,sal FROM emp WHERE sal IN (SELECT sal FROM emp WHERE JOB = 'CLERK') ORDER BY sal DESC;
?
-- 18. EMP���̺��� �������
DESC EMP;

------------------2������------------------------------------
SELECT * FORM emp WHERE;

-- 1. ALLEN �� �μ��� ���� ������� �����, �Ի����� ���(�޿� �������� ����)
SELECT ename, hiredate FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename='ALLEN') ORDER BY sal DESC;

-- 2. ���� ���� �޿��� �޴� ������� �Ի����� ���� ����� �̸�, �Ի����� ���
SELECT ename, hiredate FROM emp WHERE 
                                hiredate > (SELECT HIREDATE FROM EMP WHERE 
                                            SAL  = (SELECT MAX(SAL) FROM EMP)
                                            );
?
-- 3. �̸��� 'T' �ڰ� ���� ������� �޿��� ���� ���ϼ���. (LIKE ���)
SELECT SUM(sal) FROM emp WHERE ename LIKE '%T%';
SELECT ename, sal FROM emp WHERE ename LIKE '%T%';

-- 4. ��� ����� ��ձ޿��� ���ϼ���. �Ҽ� ��°�ڸ� �ݿø�ǥ��
SELECT Round(AVG(sal), 2) FROM emp;

-- 5. �� �μ��� ��� �޿��� ���ϼ���. �Ҽ� ��°�ڸ� �ݿø�ǥ�� (GROUP BY)
SELECT deptno,round(AVG(sal), 2) FROM emp GROUP BY deptno;

-- 6. �� �μ��� ��ձ޿�, ��ü�޿�, �ְ�޿�, �����޿��� ���Ͽ� ��ձ޿��� ���� ������ ���. ����� �Ҽ� ��°�ڸ� �ݿø�ǥ��
SELECT round(AVG(sal), 2), SUM(sal), MAX(sal),MIN(sal) 
FROM emp 
GROUP BY deptno ORDER BY AVG(sal) DESC;

-- 7. 20�� �μ��� �ְ� �޿����� ���� ����� �����ȣ, �����, �޿��� ���
SELECT empno, ename, sal FROM emp WHERE sal > (SELECT MAX(Sal) FROM emp WHERE deptno = 20);

-- 8. SMITH �� ���� �μ��� ���� ������� ��ձ޿����� ū �޿��� �޴� ��� ����� �����, �޿��� ���
SELECT ename, SAL FROM emp WHERE SAL > (SELECT AVG(SAL) FROM emp 
                                        WHERE Deptno = (SELECT DEPTNO FROM emp WHERE ename = 'SMITH'));
?
-- 9. ȸ�系�� �ּұ޿��� �ִ�޿��� ���̸� ���ϼ���. 
SELECT MAX(sal)- MIN(sal) FROM emp;

-- 10. SCOTT �� �޿����� 1000 �� �� �޿����� ���� �޴� ����� �̸�, �޿��� ���.
SELECT ename, sal FROM emp WHERE sal < (SELECT sal-1000 FROM emp WHERE ename = 'SCCOT'); 
?--SCOTT�� ����..������

-- 11. JOB�� MANAGER�� ����� �� �ּұ޿��� �޴� ������� /�޿��� ���� ����̸�, �޿��� ���
SELECT ename, sal FROM emp WHERE sal < (SELECT MIN(sal) FROM emp WHERE job = 'MANAGER');

-- 12. �̸��� S�� �����ϰ� ���������ڰ� H�� ����� �̸��� ���
SELECT ename FROM emp WHERE ename LIKE 'S%H';

-- 13. WARD �� �Ҽӵ� �μ� ������� ��� �޿�����, �޿��� ���� ����� �̸�,�޿��� ���.
SELECT ename, sal FROM emp WHERE sal > (SELECT AVG(sal) FROM emp 
                                        WHERE DEPTNO = (SELECT DEPTNO FROM emp WHERE ename = 'WARD'));

-- 14-1. EMP���̺��� ��� ������� ���
SELECT COUNT(*) FROM emp;

-- 15. ������(JOB) ������� ���
SELECT job,COUNT(*) FROM emp GROUP BY job;

-- 16. �ּұ޿��� �޴� ����� ���� �μ��� ��� ������� ���
SELECT ename FROM emp WHERE DEPTNO = (SELECT DEPTNO FROM emp 
                                      WHERE SAL =(SELECT MIN(sal) FROM emp)
                                      );
                                      
------------------3������------------------------------------                                      
-- 1. ����(JOB)�� MANAGER�� ����� �̸�, �μ���, �Ի����� ���
SELECT ename, deptno, hiredate FROM emp WHERE job = 'MANAGER';
?
-- 2. ������� WARD�� ����� �޿�, �μ���ȣ, �μ���ġ, Ŀ�̼��� ���
SELECT emp.sal, emp.deptno, dept.loc, emp.comm
FROM emp INNER JOIN dept
ON emp.deptno = dept.deptno 
AND emp.ename = 'WARD';

-- 3. 30�� �μ��� ���ϴ� ����� �̸�, �μ���ȣ, �μ���ġ�� ���
SELECT e.ename, e.deptno, d.loc
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.deptno = 30;

-- 4-1. �޿��� 1250�� �ʰ�, 3000������ ����� �̸�, �޿�, �μ����� ���
SELECT e.ename, e.deptno, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal >1250
AND e.sal <= 3000;

-- 4-2. �޿��� 1250�̻� 3000 ������ ������̸�, �޿�(BETWEEN ���)
SELECT e.ename, e.deptno, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal BETWEEN 1250 AND 3000;

-- 5. Ŀ�̼��� 0 �� ����� �̸�, �μ���ġ, Ŀ�̼��� ���
SELECT e.ename, d.loc, e.COMM
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.comm = 0;

-- 6.Ŀ�̼� ����� �������� ����� �̸�, �μ����� ���
SELECT e.ename,d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.COMM IS NULL;

-- 7. �Ի����� 81/06/09���� ���� ����� �̸�, �μ���ġ, �Ի��� ���(�Ի��� ��������)
SELECT e.ename,d.loc,e.hiredate
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.hiredate > '1981/06/09';

-- 8. ��� ����� �޿����� 1000�� ���� �޿���, �����, �޿�, �μ����� ���
SELECT e.ename, e.sal+1000, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno;

-- 9. FORD�� �Ի���, �μ����� ���
SELECT e.hiredate, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.ename = 'FORD';

-- 10. ������� ALLEN�� ����� �޿�, �μ���ȣ, �μ���ġ�� ���
SELECT e.sal, e.deptno ,d.loc
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.ename = 'ALLEN';

-- 11. ALLEN�� �޿����� ���� �޿��� �޴� ����� �����, �μ���, �μ���ġ, �޿��� ���
SELECT e.ename, e.deptno ,d.loc, e.sal
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal > (SELECT sal FROM emp WHERE ename = 'ALLEN');

-- 12. ���� ����/���� Ŀ�̼��� ���ϼ���.
SELECT MAX(COMM) FROM EMP; 
SELECT MIN(COMM) FROM EMP; 

-- 13. ���� ���� Ŀ�̼��� �޴� ����� �̸�, �μ����� ���ϼ���.
SELECT e.ename, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.comm = (SELECT MAX(COMM) FROM EMP);

-- 14. JOB�� CLERK �� ������� �޿��� ���� ���ϼ���
SELECT SUM(sal)
FROM emp
WHERE job ='CLERK';

-- 15. JOB �� CLERK �� ������� �޿��� �պ��� �޿��� ���� ����̸�, �μ����� ���
SELECT e.ename, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal > (SELECT SUM(sal)FROM emp WHERE job ='CLERK');

-- 16. JOB�� CLERK�� ������� �޿��� ���� �޿��� �޴� ����� �̸�,�μ���,�޿��� ���(�޿��� ���������� ���)
SELECT e.ename, d.dname, e.sal
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal IN (SELECT sal FROM emp WHERE job ='CLERK')
ORDER BY e.sal ASC;

-------------------24.04.18(��)-----------------------------
------------------4������------------------------------------
-- 1. �ּұ޿��� �޴� ����� ���� �μ����� �ٹ��ϴ� ��� �����, �μ����� ���
SELECT MIN(sal) FROM emp; --�ּұ޿�

SELECT e.ename, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.deptno = (SELECT deptno FROM emp WHERE sal = (SELECT MIN(sal) FROM emp)); 

-- 2. SCOTT���� �Ի����� ���� ����� ���� �μ����� �ٹ��ϴ� �������/ �μ���, �̸�, �޿��� ��� 
-- SCOTT ���� CLARK�� ����
SELECT d.dname, e.ename, e.sal
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.deptno IN (
                SELECT deptno FROM emp WHERE hiredate > 
                (SELECT hiredate FROM emp WHERE ename ='CLARK')
                );

-- 3. �̸��� 'K'�ڰ� ���� ����� �� �޿��� ���� ���� ����� �μ���, �����, �޿��� ��� 
SELECT ename FROM emp WHERE ename LIKE '%K%'; -- �̸��� 'T'�ڰ� ���� ���

SELECT d.dname, e.ename, e.sal
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal = (SELECT MIN(sal) FROM emp WHERE ename LIKE '%K%');

-- 4. Ŀ�̼� ����� ���� ����� �Ի����� ���� ���� ����� �μ���, �����, �Ի����� ���
SELECT ename FROM emp WHERE comm IS NULL; --Ŀ�̼� ��� ���� ���
SELECT MIN(hiredate) FROM emp WHERE comm IS NULL;

SELECT d.dname, e.ename, e.hiredate
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.hiredate =(SELECT MIN(hiredate) FROM emp WHERE comm IS NULL);

-- 5. ��ġ�� ��ī���� �μ��� ���� ������� �̸��� �μ����� ���.
SELECT DEPTNO FROM DEPT WHERE LOC ='CHICAGO';

SELECT e.ename, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.deptno IN (SELECT DEPTNO FROM DEPT WHERE LOC ='CHICAGO');

-- 6. KING�� �޿����� CLARK�� �޿��� �� ������� ���� �޿��� �޴� /����� �μ���, �̸�, �޿��� ��� 
SELECT sal FROM emp WHERE ename = 'KING'
SELECT sal FROM emp WHERE ename = 'CLARK'

SELECT (SELECT sal FROM emp WHERE ename = 'KING')-(SELECT sal FROM emp WHERE ename = 'CLARK') FROM DUAL;

SELECT d.dname, e.ename, e.sal
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal < (SELECT (SELECT sal FROM emp WHERE ename = 'KING')-(SELECT sal FROM emp WHERE ename = 'CLARK') FROM DUAL);

-- 7. DALLAS�� ��ġ�� �μ��� ���� ����� �ѻ����, ��ձ޿�,��ü�޿�,�ְ�޿�,�����޿��� ���ϼ���. 
SELECT deptno FROM dept WHERE loc = 'DALLAS'; 
?
SELECT COUNT(*), ROUND(AVG(sal), 2), MIN(sal), MAX(sal), SUM(sal)
FROM emp
WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'DALLAS');

-- 8. Ŀ�̼� ��������� ������ �̸��� 'N'�ڰ� ���� ����� �� �޿��� ���� ���� ����� �����, �޿�,�μ����� ���
SELECT ename, comm FROM emp WHERE Comm IS NOT NULL AND ename LIKE '%N%';

SELECT e.ename, e.sal, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal = (SELECT MIN(sal) FROM emp WHERE Comm IS NOT NULL AND ename LIKE '%N%');

-- 9. ALLEN ���� �Ի����� ���� ����� �μ���,������� ���
SELECT hiredate FROM emp WHERE ename = 'ALLEN';

SELECT e.ename, d.dname, e.hiredate
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.hiredate < (SELECT hiredate FROM emp WHERE ename = 'ALLEN');

-- 10. EMP ���̺��� �̸��� 5������ ����� �޿��� ���� ���� ����� �̸�, �޿� , �μ����� ���
SELECT MAX(sal) FROM emp WHERE LENGTH(ename) = 5;

SELECT e.ename, d.dname, e.sal
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
AND e.sal = (SELECT MAX(sal) FROM emp WHERE LENGTH(ename) = 5);

-- 11. CLARK �� ���� �μ��� ��� �������� �޿��� ���� ����� �Ի����� ���� ���� ����� �μ���, �����, �޿��� ���
SELECT deptno FROM emp WHERE ename = 'CLARK'; --CLARK�� ���� �μ�

SELECT ROUND(AVG(sal), 2) FROM emp WHERE deptno =(SELECT deptno FROM emp WHERE ename = 'CLARK');
-- CLARKDL ���� �μ��� ��� ����

SELECT ename, sal, hiredate FROM emp WHERE sal > 
(SELECT ROUND(AVG(sal), 2) FROM emp WHERE deptno =(SELECT deptno FROM emp WHERE ename = 'CLARK'));
-- CLARKDL ���� �μ��� ��� �������� �޿��� ���� ����� �̸�, �޿�, �Ի���

SELECT hiredate FROM emp WHERE sal > 
(SELECT ROUND(AVG(sal), 2) FROM emp WHERE deptno =(SELECT deptno FROM emp WHERE ename = 'CLARK'));
-- CLARKDL ���� �μ��� ��� �������� �޿��� ����  ������� �Ի���

SELECT MIN(hiredate) FROM emp WHERE hiredate IN (SELECT hiredate FROM emp WHERE sal > 
(SELECT ROUND(AVG(sal), 2) FROM emp WHERE deptno =(SELECT deptno FROM emp WHERE ename = 'CLARK')));
-- CLARKDL ���� �μ��� ��� �������� �޿��� ����  ������� �Ի����� ���� ���� �Ի���

SELECT e.ename, d.dname, e.sal
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno 
AND e.hiredate = (SELECT MIN(hiredate) FROM emp WHERE hiredate IN (SELECT hiredate FROM emp WHERE sal > 
(SELECT ROUND(AVG(sal), 2) FROM emp WHERE deptno =(SELECT deptno FROM emp WHERE ename = 'CLARK'))));


-- 12. ALLEN�� �μ����� ���
SELECT deptno FROM emp WHERE ename = 'ALLEN'; --ALLEN�� �μ��ڵ�
SELECT dname FROM dept WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'ALLEN');

-- 13. �̸��� J�� ���� ����� ��, �޿��� ���� ���� ����� �����ȣ, �̸�, �μ���, �޿�, �μ���ġ�� ���
SELECT ename FROM emp WHERE ename LIKE '%J%'; -- �̸��� j�� ���� ���
SELECT MAX(sal) FROM emp WHERE ename IN (SELECT ename FROM emp WHERE ename LIKE '%J%'); 
-- �̸��� j�� ���� ����� �޿��� ���� ���� ����� �޿�

SELECT e.empno, e.ename, e.sal, d.loc
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno 
AND e.sal = (SELECT MAX(sal) FROM emp WHERE ename IN (SELECT ename FROM emp WHERE ename LIKE '%J%'));

-- 14. �ι�°�� ���� �޿��� �޴� ����� �̸��� �μ���,�޿��� ���
SELECT MAX(sal) FROM emp; -- �ִ�޿�
SELECT MAX(sal) FROM emp WHERE sal < (SELECT MAX(sal) FROM emp); --�ι�°�� �޿��� ���� ����� �޿�

SELECT e.ename, d.dname, e.sal
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno 
AND e.sal = (SELECT MAX(sal) FROM emp WHERE sal < (SELECT MAX(sal) FROM emp));

-- 15. �Ի����� 2��°�� ���� ����� �μ���� �̸�, �Ի����� ���
SELECT d.dname, e.ename, e.hiredate
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno 
AND e.sal = (SELECT MAX(sal) FROM emp WHERE sal < (SELECT MAX(sal) FROM emp));

-- 16. DALLAS�� ��ġ�� �μ��� ��� �� �ִ� �޿��� �޴� ����� �޿����� �ּ� �޿��� �޴� ����� �޿��� �� ����� ���
SELECT deptno FROM dept WHERE loc = 'DALLAS'; --�޶󽺿� ��ġ�� �μ��ڵ�

SELECT ename FROM emp WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'DALLAS');
--�޶󽺿� ��ġ�� �μ��� �ִ� ���

SELECT MAX(sal) FROM emp WHERE ename IN (SELECT ename FROM emp WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'DALLAS'));
-- �ִ�޿�
SELECT MIN(sal) FROM emp WHERE ename IN (SELECT ename FROM emp WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'DALLAS'));
-- �ּұ޿�

SELECT ((SELECT MAX(sal) FROM emp WHERE 
                                  ename IN 
                                  (SELECT ename FROM emp 
                                  WHERE deptno = 
                                  (SELECT deptno FROM dept WHERE loc = 'DALLAS'))) 
                                  -
                                  (SELECT MIN(sal) FROM emp 
                                  WHERE ename IN (SELECT ename FROM emp WHERE deptno = 
                                  (SELECT deptno FROM dept WHERE loc = 'DALLAS'))))AS "�ִ�޿�-�ּұ޿�" 
FROM DUAL;

