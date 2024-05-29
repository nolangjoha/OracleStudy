--�Խ��� ���̺�
CREATE TABLE practice(
    BNO     NUMBER,
    TITLE   VARCHAR2(100)   NOT NULL,
    CONTENT VARCHAR2(1000)  NOT NULL,
    WRITER  VARCHAR2(100)   NOT NULL,
    REGDATE DATE    DEFAULT SYSDATE,
    UPDATEDATE DATE DEFAULT SYSDATE,
    VIEWCOUNT NUMBER DEFAULT 0,
    CONSTRAINT PK_PRACTICE PRIMARY KEY (BNO)
);

--bno, title, content, writer, regdate, updatedate, viewcount

--������ ����
CREATE SEQUENCE SEQ_practice; --BNO�÷��� �Խù� ��ȣ ������

--������ ������ �ֱ�
INSERT INTO practice(bno, title, content, writer) VALUES(SEQ_PRACTICE.nextval, '������', '������', '������');

SELECT * FROM PRACTICE;

INSERT INTO practice(bno, title, content, writer)SELECT SEQ_PRACTICE.nextval,title, content, writer FROM practice;

commit;


--write�� ���� �ڵ�(���ڸ� '' ����)
INSERT INTO PRACTICE(bno, title, CONTENT, writer) VALUES(SEQ_PRACTICE.NEXTVAL, '���', '���', '���');
    

--list�� ���� �ڵ�
SELECT
    bno, title, content, writer, regdate, updatedate, viewcount
FROM
    practice
ORDER BY
 bno DESC;
 
 
--24.05.09(��) ex04-1����--------

		SELECT
		    bno, 
		    title, 
		    content, 
		    writer, 
		    regdate, 
		    updatedate, 
		    viewcount
		FROM
		    practice
        WHERE 
            ROWNUM <=10;
            
            
            
            