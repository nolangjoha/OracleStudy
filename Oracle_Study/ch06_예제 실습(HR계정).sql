-------------------------24.04.15(��)--------------
-- ����1) ������� �̸�, �μ���ȣ, �μ����� ����϶�.
-- �μ���ȣ�� ������̺��� �����Ͽ��� �Ѵ�.(����: ����� �������� �۾�). e.department_id
SELECT e.first_name, e.department_id, d.department_name 
FROM employees e, departments d
WHERE e.department_id = d.department_id;

-- ����2) 30�� �μ��� ������� �̸�, �����ڵ�, �μ����� ����϶�. (2���� ���̺� ����)
-- 1. employees���̺� : �̸�, �����ڵ� / 2. departmetn���̺� : �μ���
SELECT e.first_name, e.job_id, d.department_name 
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.department_id = 30;

-- ����3) 30�� �μ��� ������� �̸�, �����̸�, �μ����� ����϶�. (3���� ���̺� ����)
-- 1. employees : �̸� / 2.departments : �μ��� / 3. jobs : �����̸� 
SELECT e.first_name, j.job_title, d.department_name
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
AND e.job_id = j.job_id 
AND e.department_id = 30;

-- ����4) Ŀ�̼��� �޴�(����)/����� �̸�(�÷���), �����ڵ�(�÷���), �μ���ȣ(�÷���), �μ���(�÷���)�� ����϶�.
SELECT e.first_name, e.job_id, e.department_id, d.department_name 
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND COMMISSION_PCT IS NOT NULL;

-- ����5) ������ȣ(location_id) 2500����/ �ٹ��ϴ� ����� �̸�(1), ������(2), �μ���ȣ(3), �μ���(4)�� ����϶�.
SELECT e.first_name,j.job_title, d.department_id, d.department_name
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
AND e.job_id = j.job_id 
AND d.location_id = 2500;

-- ����6) ����̸�(1)�� �μ���(2)�� ����(3)�� ����ϴµ� /������ 3000�̻��� ����� ����϶�.
--employees :  first_name, salary  / departments : department_name
SELECT e.first_name, e.salary, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id 
AND e.salary >= 3000; 

-- ����7) �޿��� 3000���� 5000������/ ����� �̸�(1)�� �μ���(2)�� ����϶�(between 3000 and 5000 �̿�)
SELECT e.first_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id 
AND e.salary between 3000 and 5000;

-- ����8) �޿��� 3000������/ ����� �̸�(1)�� �޿�(2), �ٹ���(3)�� ����϶�.
SELECT e.first_name , e.salary, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id 
AND l.LOCATION_ID = d.LOCATION_ID
AND e.salary <= 3000;
