--����(dummy) ������ �۾��ϱ�

DELETE FROM board;
COMMIT;
DROP SEQUENCE SEQ_BOARD;

CREATE SEQUENCE SEQ_BOARD;
--�۹�ȣ ���� �ٽ� ó������ �����Ϸ��� �ٽ� ����

--INSERT SELECT���� �����ϱ� ���� ������ 1���� ����־�� ��.
INSERT INTO board(bno, title, content, writer) VALUES(SEQ_BOARD.nextval, '�׽�Ʈ', '�׽�Ʈ', '�׽�Ʈ');

SELECT * FROM board;

-- �÷��� 4���� ����� ����: ������ 3���� ����Ʈ ������ �ֱ⿡ ��.
-- INSERT SELECT �� : ���������� �����ϱ�
-- 9�� �����ؼ� ���̵����͸� �־����� -> �����Ͱ� ������� �� ���� ���� ���̴�. ���� �ڿ������� ������. ���̵����� ���� �� Ư�� �׷�.
INSERT INTO board(bno, title, content, writer)
SELECT SEQ_BOARD.nextval,title, content, writer FROM board;

COMMIT;

SELECT * FROM board ORDER BY bno;

--bno�÷����� ���ǽ��� �̿��Ͽ� ��½�, �����Ͱ� �����Ǹ� ������ �߻��Ѵ�.
--�Խù��� �����͸� 5���� ���, �׷��� �߰��� �����͸� �����ϸ� 5���� ��µ��� ����
SELECT * FROM board WHERE bno >= 1 AND bno <= 5;
SELECT * FROM board WHERE bno >= 6 AND bno <= 10;
SELECT * FROM board WHERE bno >= 11 AND bno <= 15;

DELETE FROM board WHERE bno = 3;

--������ �׷����� 5���� ����ϰ� �ʹٸ� 
-- ROWNUM �ǻ��÷��� �̿��Ѵ�.  : ���̺� ���ӵǴ°� �ƴϳ� ��µǴ� �����Ϳ� ���ؼ� ��ȣ�� �ο����ش�.
-- �� MYSQL�� ROWNUM�� ������� �ʴ´�.

--BNO �÷��� �������� ���
SELECT bno, title, content, writer, regdate, updatedate, viewcount FROM board ORDER BY bno;
-- ROWNUM�� �̿��� ���
SELECT ROWNUM, bno, title, content, writer, regdate, updatedate, viewcount FROM board;

--ROWNUM�� �̿��� ���ǽ�
SELECT ROWNUM, bno, title, content, writer, regdate, updatedate, viewcount FROM board WHERE ROWNUM >= 1 AND ROWNUM <= 5;
--ROWNUM�� ���ۿ����� ���� �߰����� �����ʹ� �������� ���Ѵ�.
SELECT ROWNUM, bno, title, content, writer, regdate, updatedate, viewcount FROM board WHERE ROWNUM >= 6 AND ROWNUM <= 10;
SELECT ROWNUM, bno, title, content, writer, regdate, updatedate, viewcount FROM board WHERE ROWNUM >= 11 AND ROWNUM <= 15;

--ROWNUM�� �ζ��κ� �������� ���.
-- �ζ��κ��? FROM���� ��������.
-- FROM()���� �ڵ尡 1���� ����Ǿ� �̸� ���̺�� ���� > ���ǿ� �°� ������� �����ͷ� ���ǿ� �°� ���
-->> �߰����� �����͸� ROWNUM ���� �����ö� 
SELECT *
FROM(
    SELECT ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount FROM board
)
WHERE RN >= 1 AND RN <=5;


SELECT *
FROM(
    SELECT ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount FROM board
)
WHERE RN >= 6 AND RN <=10;

SELECT *
FROM(
    SELECT ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount FROM board
)
WHERE RN >= 11 AND RN <=15;


-- �Խ��� ������ ��½� �ֽű��� �켱������ ����ؾ� �Ѵ�. ��뷮 �����ʹ� ORDER BY�� ������� �ʴ´�.(ORDER BY�� ����ϰ� �� ��� �����Ͱ� ������? > ���������� ��� �񱳸� �ϰ� �Ǹ鼭 ����ȭ, �ǹ������� �Ժη� ���°� �ƴ�./ ���� �����ʹ� ��� ����)
-- ��� �ε��� ��Ʈ ��ɾ ����Ѵ�.
-- ���̺��� �⺻Ű(primary key)���� �� ���������̸��� �������� �����Ѵ�. 
-- PRIMARY KEY ���������� �����ʰ� ���ÿ� UNIQUE INDEX�� �������� �̸����� �ε����� �Բ� �����ȴ�.
-- �̶� �ε��� ��Ʈ�� ����ϸ� ORDER BY�� ���� ȿ���� �� �� �ִ�.

-- �����͸� �ֽű۷� �����ϴ� ���
-- 1) ORDER BY ��� -- �����Ͱ� ���� ���������� ��� ����ȭ
SELECT * FROM board ORDER BY bno DESC; --�ֽű�
-- 2) �ε��� ��Ʈ ���
-- /*+ INDEX(���̺�� ���������̸�)  */  -- ������������ ���� 
-- /*+ INDEX_DESC(���̺�� ���������̸�)  */ -- ������������ ����

SELECT /*+ INDEX(board PK_BOARD)  */ 
    bno, title, content, writer, regdate, updatedate, viewcount
FROM board;

SELECT /*+ INDEX_DESC(board PK_BOARD)  */ 
    bno, title, content, writer, regdate, updatedate, viewcount
FROM board;



-- ����. ROWNUM�� �ε��� ��Ʈ����, �ζ��κ� ���� > ����¡ ���� �ϼ�
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
)
WHERE RN >=1 AND RN <= 5;
-- ���ǻ��� : �ε�����Ʈ ������ �߸��Ǿ, ������ �߻����� �ʴ´�. �� �ε����� ������ �ʰ� ��µȴ�.
-- ����¡ ������ �ϼ� -> ������ ��Ʈ���� ����ϴ� ���·� ��ȯ�۾� �ʿ�

/*
3�������� Ŭ�������� 1,2 �������� �Խñ��� ������ �ʰ� ǥ���ϱ�
*/
--page1�� ���õ��� ��
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
    WHERE ROWNUM <= (1*5)  -- ��������ȣ * �������� ��°Ǽ�
)
WHERE RN > (1 - 1) * 5;  -- (��������ȣ -1) * �������� ��°Ǽ�


--page2�� ���õ��� ��
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
    WHERE ROWNUM <= (2*5)  -- ��������ȣ * �������� ��°Ǽ�
)
WHERE RN > (2 - 1) * 5;  -- (��������ȣ -1) * �������� ��°Ǽ�

commit;


-------------24.05.08(��)----------------
--�˻������ �߰��� ����
--1) page1�� ���õǰ�, �˻������� ������ ����
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
    WHERE ROWNUM <= (1*5) AND title LIKE '%�˻���%'  -- �˻���� �Ҽ� �߰� : �����ҽ��������� �˻��ؾ��ϴϱ� 
)
WHERE RN > (1 - 1) * 5;  -- (��������ȣ -1) * �������� ��°Ǽ�


--2) page1�� ���õǰ�, �˻������� �ۼ��� ����
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
    WHERE ROWNUM <= (1*5) AND write LIKE '%�˻���%'  -- �˻���� �Ҽ� �߰� : �����ҽ��������� �˻��ؾ��ϴϱ� 
)
WHERE RN > (1 - 1) * 5;  -- (��������ȣ -1) * �������� ��°Ǽ�


--3) page1�� ���õǰ�, �˻������� ���� ����
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
    WHERE ROWNUM <= (1*5) AND CONTENT LIKE '%�˻���%'  -- �˻���� �Ҽ� �߰� : �����ҽ��������� �˻��ؾ��ϴϱ� 
)
WHERE RN > (1 - 1) * 5;  -- (��������ȣ -1) * �������� ��°Ǽ�


--4) page1�� ���õǰ�, �˻������� ���� OR ���� ����
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
    WHERE ROWNUM <= (1*5) AND (title LIKE '%�˻���%' OR content LIKE '%�˻���%')  -- �˻���� �Ҽ� �߰� : �����ҽ��������� �˻��ؾ��ϴϱ� 
)                                        --AND�� OR�� ���� ���϶� AND�� �켱��.               
WHERE RN > (1 - 1) * 5;  -- (��������ȣ -1) * �������� ��°Ǽ�


--5) page1�� ���õǰ�, �˻������� ���� OR �ۼ��� ����
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
    WHERE ROWNUM <= (1*5) AND (title LIKE '%�˻���%' OR content writer '%�˻���%')  -- �˻���� �Ҽ� �߰� : �����ҽ��������� �˻��ؾ��ϴϱ� 
)                                                       
WHERE RN > (1 - 1) * 5;  -- (��������ȣ -1) * �������� ��°Ǽ�


--6) page1�� ���õǰ�, �˻������� ���� OR �ۼ��� OR ���� ����
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
    WHERE (title LIKE '%�˻���%' OR writer LIKE '%�˻���%' OR content LIKE '%�˻���%') AND ROWNUM <= (1*5)  -- �˻���� �Ҽ� �߰� : �����ҽ��������� �˻��ؾ��ϴϱ� 
)                          
WHERE RN > (1 - 1) * 5;  -- (��������ȣ -1) * �������� ��°Ǽ�



--�˻��� ������ ����(���� �ִ��� ����)

UPDATE board 
    SET title = '���'
WHERE bno IN(512, 510, 504, 502, 500, 412, 410, 404, 402, 400, 312, 310, 304, 302, 300, 212, 210, 024, 202, 200, 112, 110, 104, 102, 100);

COMMIT;




--��������Ʈ���� �˻��� �ϼ��� sql����
SELECT  
			bno, title, content, writer, regdate, updatedate, viewcount
		FROM (
	    	SELECT /*+ INDEX_DESC(board PK_BOARD) */
	        	ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
	    	FROM 
	        	board  
	    	WHERE 

		 (  title like '%' || '���'

				OR writer like '%' || '���'

				OR content like '%' || '���' ) AND 

	    	ROWNUM <= (1 * 10) 

	    	)
		WHERE 
			RN > (1 - 1) * 10





-----24.05.09(��)--��۱�� �����--------------------------

--��� ���̺� ����
CREATE TABLE reply(
    rno         NUMBER  CONSTRAINT pk_reply PRIMARY KEY,  -- ��� �Ϸù�ȣ
    bno         NUMBER  NULL,                              -- �Խ���(board)�� bno�÷��� ���� �۹�ȣ
    retext      VARCHAR2(100)   NOT NULL,                  -- ��� ����
    replyer     VARCHAR2(100)   NOT NULL,                  -- ��� �ۼ���
    replydate   DATE DEFAULT   SYSDATE,                    -- ��� ����� 
    updatedate  DATE DEFAULT   SYSDATE                     -- ��� ������
);


--�Խ��� ��� �⺻ ����
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
    WHERE (title LIKE '%�˻���%' OR writer LIKE '%�˻���%' OR content LIKE '%�˻���%') AND ROWNUM <= (1*5)  -- �˻���� �Ҽ� �߰� : �����ҽ��������� �˻��ؾ��ϴϱ� 
)                          
WHERE RN > (1 - 1) * 5;  -- (��������ȣ -1) * �������� ��°Ǽ�


--��۸�� �⺻ ����
-- 1)�Խ��� ��� �⺻ �������� �˻����(WHERE)�� ���ݴ�.
-- 2) �� �Խñ� �Ʒ� ���� �ϹǷ� �Խñ� ��ȣ ������ �߰��ߴ�.
SELECT  rno, bno, retext, replyer, replydate, updatedate
FROM(
    SELECT /*+ INDEX_DESC(reply pk_reply) */
        ROWNUM AS RN, rno, bno, retext, replyer, replydate, updatedate
    FROM 
        reply 
    WHERE bno = �Խù���ȣ
        -- ��������ȣ * �������� ��°Ǽ�
)                          
WHERE RN > (1 - 1) * 5;    -- (��������ȣ -1) * �������� ��°Ǽ�

--������ ����: ��ۿ����� ����� ��.
CREATE SEQUENCE SEQ_REPLY;

--511���� ������ �־��(rno, bno, retext, replyer, replydate, updatedate)
INSERT INTO reply (rno, bno, retext, replyer) VALUES(SEQ_REPLY.NEXTVAL, 511, '����׽�Ʈ', 'user01');

-- ���� ������ ���� �ֱ�
INSERT INTO reply (rno, bno, retext, replyer)
SELECT SEQ_REPLY.NEXTVAL,bno, retext, replyer FROM reply;

COMMIT;



---------------------------------------------------------------
--------------------24.05.14(ȭ)-------------------------------
--������

