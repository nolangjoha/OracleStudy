------------------------------24.04.09(ȭ)----------------------------------

/*
01 ���� �Լ�

02 ���� �Լ�

03 ��¥ �Լ�

04 ��ȯ �Լ�

05 NULL ���� �Լ�

06 ��Ÿ �Լ�
*/
--���� �Լ��� ���� ������ �ϴ� �Լ��� ���� ��� ��, �Ű������� ��ȯ ���� ��κ� ���� ���´�.
--�� ABS(n)
--ABS �Լ��� �Ű������� ���ڸ� �޾� �� ���밪�� ��ȯ�ϴ� �Լ���.
SELECT ABS(10), ABS(-10), ABS(-10.123) FROM DUAL;  --DUAL�� �ӽ����̺�

--�� CEIL(n):�ø��Լ� �� FLOOR(n) : �����Լ�
--CEIL �Լ��� �Ű����� n�� ���ų� ���� ū ������ ��ȯ�Ѵ�. �Ҽ��� ������ ������ �ø�
SELECT CEIL(10.123), CEIL(10.541), CEIL(11.001) FROM DUAL;

--FLOOR �Լ��� CEIL �Լ��� �ݴ�� �Ű����� n���� �۰ų� ���� ū ������ ��ȯ�Ѵ�. ������ ����
SELECT FLOOR(10.123), FLOOR(10.541), FLOOR(11.001) FROM DUAL;


/*
�� ROUND(n, i)�� TRUNC(n1, n2)
ROUND �Լ��� �Ű����� n�� �Ҽ��� ���� (i+1)�� °���� �ݿø��� ����� ��ȯ�Ѵ�. 
i�� ������ �� �ְ� ����Ʈ ���� 0, �� �Ҽ��� ù ��° �ڸ����� �ݿø��� �Ͼ ���� �κ��� ���� �ڸ��� ����� �ݿ��ȴ�.
*/

-- �Ҽ� ù° �ڸ����� �ݿø� ���� �Ǵ�. 
--�Ű����� 1���� ����� ��.
SELECT ROUND(10.154), ROUND(10.541), ROUND(11.001) FROM DUAL;

--�Ű����� 2���� ����� ��. 2��° �Ű������� ���, ���� ���ο� ���� ����� �ٸ���.
/*
2���� �Ű������� ����̸�, �Ҽ��κ��� ����Ų��. 
 N+1�� ��ġ�� �ݿø� ���θ� ����Ѵ�. 
*/
SELECT ROUND(10.154, 1), ROUND(10.154, 2), ROUND(10.154, 3)FROM DUAL;

/*
2���� �Ű������� �����̸�, �����κ��� ����Ų��. 
 N�� ��ġ�� �ݿø� ���θ� ����Ѵ�. 
 : -1�̸� ���� ù° �ڸ�, -2�� ���� ���� �ڸ�
*/
SELECT ROUND(0, 3), ROUND(115.155, -1), ROUND(115.155, -2)FROM DUAL;

/*
TRUNC �Լ��� �ݿø��� ���� �ʰ� n1�� �Ҽ��� ���� n2�ڸ����� ������ �߶� ����� ��ȯ�Ѵ�. 
n2 ���� ������ �� ������ ����Ʈ ���� 0�̰�,����� ���� �Ҽ��� �������� ������, ������ ���� �Ҽ��� ���� ���� �ڸ����� �߶󳽴�.
*/
 SELECT TRUNC(115.155), TRUNC(115.155, 1), TRUNC(115.155, 2), TRUNC(115.155, -2)FROM DUAL;


/*
�� POWER(n2, n1)�� SQRT(n)
POWER �Լ��� n2�� n1 ������ ����� ��ȯ�Ѵ�. n1�� ������ �Ǽ� ��� �� �� �ִµ�, n2�� ������ �� n1�� ������ �� �� �ִ�.
*/
SELECT POWER(3, 2), POWER(3, 3), POWER(3, 3.0001)FROM DUAL;

SELECT SQRT(2), SQRT(5) FROM DUAL; --�Ű������� ��Ʈ �����

/*
�� MOD(n2, n1)�� REMAINDER(n2, n1)
MOD �Լ��� n2�� n1���� ���� ������ ���� ��ȯ�Ѵ�.
*/
SELECT MOD(19,4), MOD(19.123, 4.2)FROM DUAL;

/*
REMAINDER �Լ� ���� n2�� n1���� ���� ������ ���� ��ȯ�ϴµ�, �������� ���ϴ� ������ ���� ����� MOD �Լ��ʹ� �ణ �ٸ���.

? MOD �� n2 - n1 * FLOOR (n2/n1)

? REMAINDER �� n2 - n1 * ROUND (n2/n1)
*/
SELECT REMAINDER(19,4), REMAINDER(19.123, 4.2)FROM DUAL;


--02 | ���� �Լ�
--���� �Լ��� ���� ����� �����̸� ��ȯ ���� �Լ��� ���� ���ڳ� ���ڸ� ��ȯ�Ѵ�.
/*
�� INITCAP(char), LOWER(char), UPPER(char)
INITCAP �Լ��� �Ű������� ������ char�� ù ���ڴ� �빮�ڷ�, �������� �ҹ��ڷ� ��ȯ�ϴ� �Լ���. 
�̶� ù ���ڸ� �ν��ϴ� ������ ����� ���ĺ�(���� ����)�� ������ ���ڴ�. 
�� �����̳� ���ĺ��� �ƴ� ���ڸ� ���� �� ���� ù ���ĺ� ���ڸ� �빮�ڷ� ��ȯ�Ѵ�.
*/
 SELECT INITCAP('never say goodbye'), INITCAP('never6say*good��bye')
      FROM DUAL;

SELECT emp_name, INITCAP(emp_name) FROM employees;

COMMIT;

-------------------------2024.04.11(��)-----------------------
--�ҹ���, �빮�ڷ� ��ȯ
SELECT LOWER('NEVER SAY GOODBYE'), UPPER('never say goodbye') FROM DUAL;

SELECT emp_name, LOWER(emp_name), UPPER(emp_name) FROM employees;

/*
�� CONCAT(char1, char2), SUBSTR(char, pos, len), SUBSTRB(char, pos, len)
CONCAT �Լ��� ��||�� ������ó�� �Ű������� ������ �� ���ڸ� �ٿ� ��ȯ�Ѵ�.
*/
SELECT CONCAT('I Have', ' A Dream'), 'I Have' || ' A Dream' FROM DUAL;

SELECT CONCAT(emp_name, salary),emp_name || ' ' || salary FROM employees;

/*
SUBSTR�� ���� �Լ� �� ���� ���� ���Ǵ� �Լ���, 
�߶�� ��� ���ڿ��� char�� pos��° ���ں��� len���̸�ŭ �߶� ����� ��ȯ�ϴ� �Լ���. 
pos ������ 0�� ���� ����Ʈ ���� 1, �� ù ��° ���ڸ� ����Ű��, ������ ���� char ���ڿ� �� ������ ������ ����� ��ġ�� �ǹ��Ѵ�. 
���� len ���� �����Ǹ� pos��° ���ں��� ������ ��� ���ڸ� ��ȯ�Ѵ�.
*/
                -- 1�� ��ġ, 4�� ����           -- -1�� �ڿ��� ù��° ��ġ, 4�� ����
SELECT SUBSTR('ABCDEFG', 1, 4), SUBSTR('ABCDEFG', -1, 4) FROM DUAL;
--ù��°���� 4������ ��ȯ�ض�/         �ڿ��� ù��°���� +4���� ��ȯ�ض�

--ù��°���� 3���� ��ȯ�ض�
SELECT emp_name, SUBSTR(emp_name, 1, 3) || '****' FROM employees;

--����Ʈ ����. �ѱ��� 3����Ʈ�� �����ǰ� �ֱ� ������ �ѱ����� 6�� ������ �α��ھ� ��� �ȴ�.
SELECT SUBSTR('ABCDEFG', 1, 4), SUBSTR('�����ٶ󸶹ٻ�', 1, 6) FROM DUAL;

--�ѱ��� �����Ʈ�� �����ǰ� �ִ��� Ȯ��
SELECT LENGTHB('��') FROM DUAL;

/*
�� LTRIM(char, set), RTRIM(char, set)
LTRIM �Լ��� �Ű������� ���� char ���ڿ����� set���� ������ ���ڿ��� ���� ������ ������ �� ������ ���ڿ��� ��ȯ�Ѵ�. 
�� ��° �Ű������� set�� ������ �� ������, ����Ʈ�� ���� ���� �� ���ڰ� ���ȴ�. 
RTRIM �Լ��� LTRIM �Լ��� �ݴ�� ������ ������ ������ �� ������ ���ڿ��� ��ȯ�Ѵ�.
*/
-- �������� ����, �������� ����
SELECT LENGTH('    ABCDEF'), LENGTH(LTRIM('    ABCDEF')),LENGTH(RTRIM('ABCDEF    '))FROM DUAL;

--�Ű����� 2���� ����� ���, 2��° �Ű����� ���� �´� ������ ��, �������� ��, 1���� ���� �Ѵ�. 
--��������, �������Ÿ� ����. ��� ���� ����.
SELECT LTRIM('ABCDEFGABC', 'ABC'),
        LTRIM('�����ٶ�', '��'),
        RTRIM('ABCDEFGABC', 'ABC'),
        RTRIM('�����ٶ�', '��')
   FROM DUAL;

/*
�� LPAD(expr1, n, expr2), RPAD(expr1, n, expr2)
LPAD �Լ��� �Ű������� ���� expr2 ���ڿ�(������ �� ����Ʈ�� ���� �� ����)�� n�ڸ���ŭ ���ʺ��� ä�� expr1�� ��ȯ�ϴ� �Լ���. 
�Ű����� n�� expr2�� expr1�� ������ ��ȯ�Ǵ� �� �ڸ����� �ǹ��Ѵ�. 
���� ���, ������ ���� ��ȭ��ȣ�� ��02���ε� ��ȭ��ȣ �÷��� ������ȣ�� ������ LPAD �Լ��� ��ȣ 02�� �ڵ����� ä�� ���� �� �ִ�.
*/
CREATE TABLE ex4_1 (phone_num VARCHAR2(30));

INSERT INTO ex4_1 VALUES ('111-1111');
INSERT INTO ex4_1 VALUES ('111-2222');
INSERT INTO ex4_1 VALUES ('111-3333');

SELECT * FROM ex4_1;

COMMIT;-- ������ �۾������� ���� �����ͺ��̽� ���Ͽ� ���������� �ݿ��Ѵ�.

--������ ä���
SELECT phone_num, LPAD(phone_num, 12, '(02)') FROM ex4_1;

-- ������ ä���
SELECT phone_num, LPAD(phone_num, 12, '(02)'), RPAD(phone_num, 12, '(02)') FROM ex4_1;

/*
�� REPLACE(char, search_str, replace_str), TRANSLATE(expr, FROM_str, to_str)
REPLACE �Լ��� char ���ڿ����� search_str ���ڿ��� ã�� �̸� replace_str ���ڿ��� ��ü�� ����� ��ȯ�ϴ� �Լ���.
*/
--'��'�� ã�Ƽ� '��'�� �ٲٱ�
SELECT REPLACE('���� �ʸ� �𸣴µ� �ʴ� ���� �˰ڴ°�?', '��', '��')FROM DUAL;

SELECT REPLACE('���� �ʸ� �𸣴µ� �ʴ� ���� �˰ڴ°�?', '����', '�ʴ�')FROM DUAL;

--���ڿ��� �ִ� ������ ��� ���� �� �� �ִ�.
    SELECT LTRIM(' ABC DEF '),
           RTRIM(' ABC DEF '),
           REPLACE(' ABC DEF ', ' ', '')
      FROM DUAL;

--REPLACE�� TRANSLATE�� ������// TRANSLATE�� ��ȣȭ�� ���� ����Ҽ� �ְ����� ������ ����. 
SELECT REPLACE('���� �ʸ� �𸣴µ� �ʴ� ���� �˰ڴ°�?', '����', '�ʸ�') AS rep, -- ���� �ܾ ã�Ƽ� �ʸ� ����
       TRANSLATE('���� �ʸ� �𸣴µ� �ʴ� ���� �˰ڴ°�?', '����', '�ʸ�') AS trn -- ��>��, ��>�� �� ���� ã�� ����
      FROM DUAL;
      
/*
�� INSTR(str, substr, pos, occur), LENGTH(chr), LENGTHB(chr)
INSTR �Լ��� str ���ڿ����� substr�� ��ġ�ϴ� ��ġ�� ��ȯ�ϴµ�, pos�� ���� ��ġ�� ����Ʈ ���� 1, 
occur�� �� ��° ��ġ�ϴ����� ����ϸ� ����Ʈ ���� 1�̴�.
*/
SELECT INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����, ���� ���� ��ſ� ����', '����') AS INSTR1, --ù��° ��ġ���� ���� '����'ã��
           INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����, ���� ���� ��ſ� ����', '����', 5) AS INSTR2, -- 5���� ��ġ���� ���� '����' ã��
           INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����, ���� ���� ��ſ� ����', '����', 5, 2) AS INSTR3 --5����° ��ġ�������� �����ؼ� �ι�°�� ������ '����' ã��
      FROM DUAL;

/*
LENGTH �Լ��� �Ű������� ���� ���ڿ��� ������ ��ȯ�ϸ�, LENGTHB �Լ��� �ش� ���ڿ��� ����Ʈ ���� ��ȯ�Ѵ�.
*/
SELECT LENGTH('���ѹα�'), LENGTHB('���ѹα�')FROM DUAL;


/*
03 | ��¥ �Լ�
��¥ �Լ��� DATE �Լ��� TIMESTAMP �Լ��� ���� ��¥���� ������� ������ ������ ����� ��ȯ�ϴ� �Լ���. 
��¥ �Լ� ���� ��κ� ��ȯ ����� ��¥���̳� �Լ��� ���� ���ڸ� ��ȯ�� ���� �ִ�.
*/


--�� SYSDATE - ��, ��, ��, ��, SYSTIMESTAMP- ��, ��, ��, ��, �и���
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

/*
�� ADD_MONTHS (date, integer)
ADD_MONTHS �Լ��� �Ű������� ���� ��¥�� interger ��ŭ�� ���� ���� ��¥�� ��ȯ�Ѵ�.
*/
--��¥�� ���� ����. ������ ����ϸ� �� ���� ����.
SELECT ADD_MONTHS(SYSDATE, 1), ADD_MONTHS(SYSDATE, -1)FROM DUAL;

/*
�� MONTHS_BETWEEN(date1, date2)
MONTHS_BETWEEN �Լ��� �� ��¥ ������ ���� ���� ��ȯ�ϴµ�, date2�� date1���� ���� ��¥�� �´�.
*/
SELECT MONTHS_BETWEEN(SYSDATE, ADD_MONTHS(SYSDATE, 1)) mon1,
       MONTHS_BETWEEN(ADD_MONTHS(SYSDATE, 1), SYSDATE) mon2
  FROM DUAL;

SELECT employee_id, emp_name, MONTHS_BETWEEN(SYSDATE, HIRE_DATE) mon1, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))FROM employees;

--�ټӳ��
SELECT employee_id, emp_name, MONTHS_BETWEEN(SYSDATE, HIRE_DATE) mon1, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))/12 AS "�ټӳ��" FROM employees;


/*
�� LAST_DAY(date)
LAST_DAY�� date ��¥�� �������� �ش� ���� ������ ���ڸ� ��ȯ�Ѵ�.
*/
SELECT LAST_DAY('2024-02-01'), Last_DAY(SYSDATE)
FROM DUAL;

/*
�� ROUND(date, format), TRUNC(date, format)
ROUND�� TRUNC�� ���� �Լ��̸鼭 ��¥ �Լ��ε� ���̴µ�, ROUND�� format�� ���� �ݿø��� ��¥��, TRUNC�� �߶� ��¥�� ��ȯ�Ѵ�.
*/
SELECT SYSDATE, ROUND(SYSDATE, 'month'), TRUNC(SYSDATE, 'month')FROM DUAL;

--15�ϱ����� �ݿø��� �ȵȴ�.
SELECT '2024-04-15', ROUND(TO_DATE('2024-04-15'), 'month'), TRUNC(TO_DATE('2024-04-15'), 'month')FROM DUAL;
--16�� �̻��� ��� �ݿø� �Ǿ� �Ѵ��� ��������. //TRUNC�� ������ ����.(�ڸ���)
SELECT '2024-04-16', ROUND(TO_DATE('2024-04-16'), 'month'), TRUNC(TO_DATE('2024-04-16'), 'month')FROM DUAL;


/*
�� NEXT_DAY (date, char)
NEXT_DAY�� date�� char�� ����� ��¥�� ���� �� ���� ���ڸ� ��ȯ�Ѵ�.
*/
-- ���� ��¥ �������� ���ƿ��� �ݿ����� �����ΰ�?
SELECT NEXT_DAY(SYSDATE, '�ݿ���') FROM DUAL;
/*
char�� �� �� �ִ� ���� ���Ͽ��ϡ����� ������ϡ������ε�, 
�� ���� NLS_LANG�̶� ����Ŭ ȯ�� ������ ���� �ѱ��� �� ����, ��SUNDAY��, ��MONDAY�� ó�� ������ �� ���� �ִ�.
*/



/*
04 | ��ȯ �Լ�
��ȯ �Լ��� ���� �ٸ� ������ ������ Ÿ������ ��ȯ�� ����� ��ȯ�ϴ� �Լ��� ���Ѵ�. 
3�忡�� ����ߵ��� ����Ŭ�� �ڵ����� ����ȯ�� ���ִ� ���� ������ ����ȯ�̶� �ϴµ� 
�� ������ �н��ϴ� ��ȯ �Լ��� ���� ����ȯ�� ���� ó���ϴ� ���� ����� ����ȯ�̶�� �Ѵ�.
*/
/*
�� TO_CHAR (���� Ȥ�� ��¥, format)
���ڳ� ��¥�� ���ڷ� ��ȯ�� �ִ� �Լ��� �ٷ� TO_CHAR��, 
�Ű������δ� ���ڳ� ��¥�� �� �� �ְ� ��ȯ ����� Ư�� ���Ŀ� �°� ����� �� �ִ�.
*/
--3�ڸ����� ','�� �־� ���ڵ����ͷ� ��ȯ�ϰڴ�.
SELECT TO_CHAR(123456789, '999,999,999')
FROM DUAL;

--��¥�����͸� ��-��-�� �������� ����ϰڴ�.
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD')
FROM DUAL;

/*
�� TO_NUMBER(expr, format)
���ڳ� �ٸ� ������ ���ڸ� NUMBER ������ ��ȯ�ϴ� �Լ���.
*/
--���ڵ����͸� ���������� ��ȯ.
SELECT TO_NUMBER('123456')FROM DUAL;

/*
�� TO_DATE(char, format), TO_TIMESTAMP(char, format)
���ڸ� ��¥������ ��ȯ�ϴ� �Լ���. ���� �Ű������δ� [ǥ 4-1]�� �ִ� �׸��� �� �� ������, 
TO_DATE�� DATE ������ TO_TIMESTAMP�� TIMESTAMP ������ ��ȯ�� ���� ��ȯ�Ѵ�.
*/
--���ڿ������͸� ��¥ ������ ��ȯ���ִ� �Լ� //�ƹ��ų� �ִ´ٰ� �� �Ǵ°� �ƴϴ�. 
SELECT TO_DATE('20140101', 'YYYY-MM-DD')FROM DUAL;
SELECT TO_DATE('20140101 13:44:50', 'YYYY-MM-DD HH24:MI:SS')FROM DUAL;

/*
05 | NULL ���� �Լ�
3�忡�� �˾ƺõ��� NULL�� ���� ���� IS NULL�̳� IS NOT NULL ������ ����Ͽ��µ�, 
����Ŭ������ NULL�� ���� ������� ó���ϴ� SQL �Լ��� �����ϰ� �ִ�.
*/
/*
�� NVL(expr1, expr2), NVL2((expr1, expr2, expr3)
NVL �Լ��� expr1�� NULL�� �� expr2�� ��ȯ�Ѵ�.
*/
--manager_id�÷��� �����Ͱ� NULL�̸�, employee_id�÷��� ���� ��ȯ�ǰ�, 
--manager_id�÷��� �����Ͱ� �����ϸ�(NOT NULL) manager_id�÷��� �����Ͱ� ��ȯ�ȴ�.
SELECT NVL(manager_id, employee_id)
FROM employees
WHERE manager_id IS NULL;

SELECT NVL(NULL, 10), NVL(10, 20) FROM DUAL;

/*
NVL2�� NVL�� Ȯ���� �Լ��� expr1�� NULL�� �ƴϸ� expr2��, NULL�̸� expr3�� ��ȯ�ϴ� �Լ���.
*/
SELECT employee_id, salary, commission_pct,
NVL2(commission_pct, salary + (salary * commission_pct), salary) AS salary2
--commission_pct�� null�̸� salary�� ����ϰ� not null�̸� salary + (salary * commission_pct)�ڵ尡 ��µȴ�.
FROM employees;

SELECT NVL2(NULL, 10, 20), NVL2(10, 20, 30) FROM DUAL;

-- NULL�� ����� ����� NULL�� �ȴ�.(�߿�)
SELECT NULL + 100 FROM DUAL;

/*
�� COALESCE (expr1, expr2, ��)
COALESCE �Լ��� �Ű������� ������ ǥ���Ŀ��� NULL�� �ƴ� ù ��° ǥ������ ��ȯ�ϴ� �Լ���.
*/
--���� �ƴ� ���� ��ȯ
SELECT COALESCE(NULL, NULL, 1), COALESCE(NULL, 1, 2),COALESCE(1,2,3), COALESCE(NULL, NULL, NULL) FROM DUAL;

--COALESCE (salary * commission_pct, salary) : salary * commission_pct ���� null�̸� salary�÷��� ���� ��ȯ�ǰ�
--salary * commission_pctdl 'not null'�̸� �ڽ��� ������� ��ȯ�ȴ�.
SELECT employee_id, salary, commission_pct,
COALESCE (salary * commission_pct, salary) AS salary2
FROM employees;


/*
�� LNNVL(���ǽ�)
LNNVL�� �Ű������� ������ ���ǽ��� ����� FALSE�̸� true, ���ǽ��� ����� true�̸� false�� ��ȯ
*/

SELECT emp_name, commission_pct FROM employees
WHERE LNNVL (commission_pct = 0);

--���� ������ ����ó�� ���� �� ���� �ִ�.
SELECT emp_name, commission_pct FROM employees
WHERE commission_pct IS NULL OR commission_pct != 0;

SELECT salary FROM employees
WHERE LNNVL (salary > 5000);  --49��

SELECT salary FROM employees
WHERE salary <= 5000;  --49��


/*
�� NULLIF (expr1, expr2)
NULLIF �Լ��� expr1�� expr2�� ���� ������ NULL��, ���� ������ expr1�� ��ȯ�Ѵ�.
*/
    SELECT NULLIF(100, 100), NULLIF(100, 200) FROM DUAL;

-- job_history ���̺��� start_date�� end_date�� ������ ������ �� ������ ������ NULL��, ���� ������ ����⵵�� ����ϴ� ������.
    SELECT employee_id,
           TO_CHAR(start_date, 'YYYY') start_year,
           TO_CHAR(end_date, 'YYYY') end_year,
           NULLIF(TO_CHAR(end_date, 'YYYY'), TO_CHAR(start_date, 'YYYY') ) nullif_year
    FROM job_history;

/*
06 | ��Ÿ �Լ�
�� GREATEST(expr1, expr2, ��), LEAST(expr1, expr2, ��)
GREATEST�� �Ű������� ������ ǥ���Ŀ��� ���� ū ����, LEAST�� ���� ���� ���� ��ȯ�ϴ� �Լ���.
�� '��' : �Ű������� ������ ���� ���ٴ� ��.
*/
SELECT GREATEST(1, 2, 3, 2) AS "����ū��",LEAST(1, 2, 3, 2)AS "�������� ��" FROM DUAL;
SELECT GREATEST('�̼���', '������', '�������'),LEAST('�̼���', '������', '�������')FROM DUAL;


/*
�� DECODE (expr, search1, result1, search2, result2, ��, default)
DECODE�� expr�� search1�� ���� �� ���� ������ result1��, 
���� ������ �ٽ� search2�� ���� ���� ������ result2�� ��ȯ�ϰ�, 
�̷� ������ ��� ���� �� ���������� ���� ���� ������ default ���� ��ȯ�Ѵ�.
*/
-- IF�� SWHICH���� ����ϴ�.
    SELECT prod_id,
             DECODE(channel_id, 3, 'Direct',
                                9, 'Direct',
                                5, 'Indirect',
                                4, 'Indirect',
                                   'Others')  decodes
       FROM sales
      WHERE rownum < 10;
-- ���ó� �̷� �۾��� CASE������ ��ü �ȴ�. sales���̺� ������ Ȩ������ ���� �ٿ� ���� �� ������ ���⼭ �׸� �߿�ġ ����.

commit;