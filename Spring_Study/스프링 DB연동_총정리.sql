SELECT
    bno,
    title,
    content,
    writer,
    regdate,
    updatedate,
    viewcount
FROM
    board
ORDER BY
    bno
DESC;

SELECT
    bno,
    title,
    content,
    writer,
    regdate,
    updatedate,
    viewcount
FROM
    board
WHERE
    bno = 2;
    

-- ���� ������ ����
DELETE FROM board;
COMMIT;

DROP SEQUENCE seq_board;

CREATE SEQUENCE seq_board;

-- �Ʒ� ����Ʈ ���� ���Ͽ� ������ �ϳ��� ������.
INSERT INTO
    board(bno, title, content, writer)
VALUES
    (seq_board.nextval, '�׽�Ʈ', '�׽�Ʈ', '�׽�Ʈ');

SELECT * FROM board;    


CREATE TABLE board3(
    bno     NUMBER  CONSTRAINT PK_BOARD_2 PRIMARY KEY,
    title   VARCHAR2(100) NOT NULL
);

-- ����(dummy) ������ �۾��ϱ�(�����뵥����)
-- �Ʒ��� �����ϱ� ���� �� �ּ��� �����Ͱ� �ϳ��� �� �־�߸� ��. �׷����� select ����
INSERT INTO board(
    bno,
    title,
    content,
    writer)
SELECT seq_board.NEXTVAL, title, content, writer
FROM board;

COMMIT;

SELECT * FROM board ORDER BY bno;

-- �Խù��� �����͸� 5���� ���(�ٵ� �̰� �߰��� �����Ͱ� �����Ǹ� 5���� ������ �� ����).
SELECT * FROM board WHERE bno >= 1 AND bno <= 5;
SELECT * FROM board WHERE bno >= 6 AND bno <= 10;
SELECT * FROM board WHERE bno >= 11 AND bno <= 15;

-- ROWNUM �ǻ��÷��� �̿��� ���, ������ ���� �ʿ����.(Mysql���� rownum��� ����)
SELECT ROWNUM,
    bno,
    title,
    content,
    writer,
    regdate,
    updatedate,
    viewcount
FROM
    board;

-- rownum�� �̿��� ���ǽ�
SELECT
    bno,
    title,
    content,
    writer,
    regdate,
    updatedate,
    viewcount
FROM
    board
WHERE ROWNUM > = 1 AND ROWNUM <= 5;

-- �Ʒ��� ���� �Ұ�. �߰������� �ȵ�.
SELECT
    bno,
    title,
    content,
    writer,
    regdate,
    updatedate,
    viewcount
FROM
    board
WHERE ROWNUM > = 6 AND ROWNUM <= 10;
    
-- ROWNUM�� �ζ��� ��(FROM���� ����ϴ� ��������) �������� ���(ROWNUM�� ���� ���� ����)
SELECT *
FROM (
    SELECT ROWNUM AS RN,
    bno,
    title,
    content,
    writer,
    regdate,
    updatedate,
    viewcount
FROM
    board
)
WHERE RN >= 6 AND RN <= 10;

-- ���� ���� �����ʹ� ORDER BY ����������, �񱳰� �Ͼ�� ������ ���ɿ� ��û�� ������ ����.
-- �Խ��� �����͸� ��� �� �ֽű� �켱. ��뷮 �����ʹ� ORDER BY ��� ����.
-- �� ��� �ε��� ��Ʈ ��ɾ �����.
-- ���̺��� Ű��Ű(PRIMARY KEY)���� �� �������� �̸��� �������� ������.
-- PRIMARY KEY ���������� �����ʰ� ���ÿ� UNIQUE INDEX�� ���������̸����� �ε����� �Բ� ������.

-- �����͸� (�ֽű۷�) �����ϴ� ���
-- 1) ORDER BY
SELECT * FROM board ORDER BY bno DESC;
-- 2) �ε��� ��Ʈ : /*+ INDEX_DESC(���̺�� ��������) */
SELECT /*+ INDEX_DESC(board PK_BOARD) */
    bno,
    title,
    content,
    writer,
    regdate,
    updatedate,
    viewcount
FROM
    board;

-- ���� : ROWNUM�� �ε��� ��Ʈ ����, �ζ��� �並 �����Ͽ� ����¡ ���� �ϼ�
SELECT
    bno,
    title,
    content,
    writer,
    regdate,
    updatedate,
    viewcount
FROM (
    SELECT /*+ INDEX_DESC(board pk_board) */
        ROWNUM AS rn,
        bno,
        title,
        content,
        writer,
        regdate,
        updatedate,
        viewcount
    FROM
        board
)
WHERE
    rn >= 6 AND rn <= 10;
-- �ε��� ��Ʈ���� ��Ż�� ������ ������ �׳� �� �κ��� �����ϰ� ����Ǿ����.

-- ���� ����¡������ �ϼ� - > ��������Ʈ���� ����ϴ� ���·� ��ȯ�۾�

SELECT
    bno,
    title,
    content,
    writer,
    regdate,
    updatedate,
    viewcount
FROM (
    SELECT /*+ INDEX_DESC(board pk_board) */
        ROWNUM AS rn,
        bno,
        title,
        content,
        writer,
        regdate,
        updatedate,
        viewcount
    FROM
        board
    WHERE
        ROWNUM <= (2 * 5) -- ������ ��ȣ * �������� ��°Ǽ�
)
WHERE
    rn > (2 - 1 ) * 5; -- (������ ��ȣ - 1) * �������� ��� �Ǽ�


-- �˻������ �߰��� ����
-- 1) page1�� ���õǰ�, �˻������� ���� ����
SELECT
    bno,
    title,
    content,
    writer,
    regdate,
    updatedate,
    viewcount
FROM (
    SELECT /*+ INDEX_DESC(board pk_board) */
        ROWNUM AS rn,
        bno,
        title,
        content,
        writer,
        regdate,
        updatedate,
        viewcount
    FROM
        board
    WHERE
        ROWNUM <= (2 * 5) AND title LIKE '%�˻���%' -- �˻����
)
WHERE
    rn > (2 - 1 ) * 5; -- (������ ��ȣ - 1) * �������� ��� �Ǽ�

-- 4) page1�� ���õǰ� �˻������� ���� or ������ ����
SELECT
    bno,
    title,
    content,
    writer,
    regdate,
    updatedate,
    viewcount
FROM (
    SELECT /*+ INDEX_DESC(board pk_board) */
        ROWNUM AS rn,
        bno,
        title,
        content,
        writer,
        regdate,
        updatedate,
        viewcount
    FROM
        board
    WHERE
        ROWNUM <= (1 * 5) AND (title LIKE '%�˻���%' OR content LIKE '%�˻���%') -- �˻����
)
WHERE
    rn > (1 - 1 ) * 5; -- (������ ��ȣ - 1) * �������� ��� �Ǽ�

-- 5) ���� OR �ۼ���
SELECT
    bno,
    title,
    content,
    writer,
    regdate,
    updatedate,
    viewcount
FROM (
    SELECT /*+ INDEX_DESC(board pk_board) */
        ROWNUM AS rn,
        bno,
        title,
        content,
        writer,
        regdate,
        updatedate,
        viewcount
    FROM
        board
    WHERE
        ROWNUM <= (1 * 5) AND (title LIKE '%�˻���%' OR writer LIKE '%�˻���%') -- �˻����
)
WHERE
    rn > (1 - 1 ) * 5; -- (������ ��ȣ - 1) * �������� ��� �Ǽ�

-- 6) ���� OR �ۼ��� OR ����
SELECT
    bno,
    title,
    content,
    writer,
    regdate,
    updatedate,
    viewcount
FROM (
    SELECT /*+ INDEX_DESC(board pk_board) */
        ROWNUM AS rn,
        bno,
        title,
        content,
        writer,
        regdate,
        updatedate,
        viewcount
    FROM
        board
    WHERE
        (title LIKE '%�˻���%' OR writer LIKE '%�˻���%' OR content LIKE '%�˻���%') AND ROWNUM <= (1 * 5) -- �˻����
)
WHERE
    rn > (1 - 1 ) * 5; -- (������ ��ȣ - 1) * �������� ��� �Ǽ�
    

-- �˻��� ������ �۾�
UPDATE board
    SET title = '���'
WHERE bno IN (811, 812, 813, 814, 815, 816);
COMMIT;

-- ��� ���̺� ����
CREATE TABLE reply(
    rno         NUMBER  CONSTRAINT pk_reply PRIMARY KEY, -- ��� �Ϸù�ȣ
    bno         NUMBER  NULL, -- �Խ���(board)�� bno�÷��� ���� �۹�ȣ(�߿�)
    retext      VARCHAR2(100)   NOT NULL, -- ��۳���
    replyer     VARCHAR2(100)   NOT NULL, -- ����ۼ���
    replydate   DATE DEFAULT SYSDATE, -- ��� �����
    updatedate  DATE DEFAULT SYSDATE -- ��� ������
);

-- rno, bno, retext, replyer, replydate, updatedate


-- ��۱�� ����
SELECT
    rno,
    bno,
    retext,
    replyer,
    replydate,
    updatedate
FROM (
    SELECT /*+ INDEX_DESC(board pk_reply) */
        ROWNUM AS rn,
            rno,
            bno,
            retext,
            replyer,
            replydate,
            updatedate
        FROM
            reply
        WHERE
            bno = �Խù� ��ȣ
)
WHERE
    rn > (1 - 1 ) * 5; -- (������ ��ȣ - 1) * �������� ��� �Ǽ�

-- 515�� ������
CREATE SEQUENCE seq_reply;

INSERT INTO reply(
    rno,
    bno,
    retext,
    replyer)
VALUES (
    seq_reply.NEXTVAL,
    515,
    '����׽�Ʈ',
    'user01');

-- ���̵����� �۾�
INSERT INTO reply(
    rno,
    bno,
    retext,
    replyer)
SELECT seq_reply.NEXTVAL,
    bno,
    retext,
    replyer
FROM
    reply;

COMMIT;

DELETE FROM reply;

-- ȸ������ ����
CREATE TABLE userinfo ( -- users�� ���� �������� ������ �־ userinfo�� �ٲ���.
    u_id          VARCHAR2(20),
    u_pwd         CHAR(60)    NOT NULL, -- ��ȣȭ�Ͽ� ó��(������Ź�), ��������Ʈ ���� ���̺귯�� ��� ����
    u_name        VARCHAR2(20)    NOT NULL,
    u_email       VARCHAR2(40)    NOT NULL,
    u_zip_code    CHAR(5)         NOT NULL, -- �����ȣ�� CHAR(5)�� ������
    u_addr        VARCHAR2(100)   NOT NULL,
    u_addrdetail  VARCHAR2(100)   NOT NULL,
    u_phone       VARCHAR2(20)    NOT NULL,
    regdate       DATE            DEFAULT SYSDATE -- ��������
);
DROP TABLE userinfo;

-- �����̸� Ű�� ���� ���� �� ����.
ALTER TABLE userinfo
ADD CONSTRAINT pk_userinfo
PRIMARY KEY(u_id);

SELECT
    u_id,
    u_pwd,
    u_name,
    u_email,
    u_zip_code,
    u_addr,
    u_addrdetail,
    u_phone,
    regdate
FROM
    userinfo;

ALTER TABLE userinfo RENAME COLUMN regdate TO u_regdate;

-- ������ ���̵����� ����
INSERT INTO userinfo (
    u_id,
    u_pwd,
    u_name,
    u_email,
    u_zip_code,
    u_addr,
    u_addrdetail,
    u_phone)
VALUES (
    'user01',
    '1234',
    'ȫ�浿',
    'user01@naver.com',
    '12345',
    '����� �����',
    '�������� 100����',
    '010-0000-0000' 
);

COMMIT;

-- ������ Ȯ��
SELECT
    u_id,
    u_pwd,
    u_name,
    u_email,
    u_zip_code,
    u_addr,
    u_addrdetail,
    u_phone,
    u_regdate
FROM
    userinfo;




-- ���̵� �ߺ�üũ
SELECT
    u_id
FROM
    userinfo
WHERE
    u_id = 'user01';

-- �������� ����. COUNT�Լ� ���
SELECT COUNT(*)
FROM userinfo
WHERE u_id = 'user01';
--�̰� ����� ���� ���µ� ������ ������.

DELETE FROM userinfo WHERE u_id = 'user01';

COMMIT;



---------------------------------24.06.03(��)
--[ī�װ� ���̺� ����] 
CREATE TABLE category(
    c_code  number        primary key,
    c_name  varchar2(30)  not null,  
    c_pcode number        null --foreign key�������� ������ ���ص� ������, �� �ǹ̿� �ش��Ѵ�. 
                               -- ����Ű ������ ���� null�� ���ش�.
);

--ī�װ� �����, ����,������ ����
-- [ī�װ� ���ñ��]
--���̵�����
--1�� ī�װ� ���(c_pcode�÷��� ���� NULL�� Ư¡
INSERT INTO category(c_code, c_name, c_pcode) VALUES(1, 'TOP', NULL);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(2, 'SHIRTS', NULL);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(3, 'PANTS', NULL);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(4, 'OUTER', NULL);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(5, 'SHOES' || '&' ||'BAG', NULL);  --Ư������&������ ���� &amp; ���ؾ� ��� �� �� �ִ�.

-- TOP
INSERT INTO category(c_code, c_name, c_pcode) VALUES(6, '������' || '&' ||'�ĵ�Ƽ', 1);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(7, '��Ʈ', 1);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(8, '����Ƽ', 1);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(9, '����Ƽ', 1);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(10, '����', 1);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(11, '������Ƽ', 1);
--SHIRTS
INSERT INTO category(c_code, c_name, c_pcode) VALUES(12, '������', 2);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(13, 'û����', 2);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(14, 'üũ' || '&' ||'����', 2);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(15, '��Ʈ������', 2);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(16, '���' || '&' ||'���̳�', 2);
--PANTS
INSERT INTO category(c_code, c_name, c_pcode) VALUES(17, '������', 3);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(18, '�����', 3);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(19, 'û����', 3);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(20, '�������', 3);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(21, '�ݹ���', 3);
--OUTER
INSERT INTO category(c_code, c_name, c_pcode) VALUES(22, '�е�', 4);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(23, '�ڵ�', 4);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(24, '��Ʈ' || '&' ||'������', 4);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(25, '����', 4);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(26, '�����/MA-1', 4);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(27, '�����' || '&' ||'����', 4);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(28, '�ĵ�' || '&' ||'����', 4);
--SHOES
INSERT INTO category(c_code, c_name, c_pcode) VALUES(29, '�Ź�', 5);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(30, '����', 5);

-- ī�װ� �ڵ�� ���߿� �������� ó���� ����.

COMMIT; --���������� ����� ����� �������� �� Ŀ��
--Ȯ��
select * from category;


-- 1�� ī�װ� ���
SELECT c_code, c_name, c_pcode From category WHERE c_pcode IS NULL;

--2�� ī�װ� ���  // c_code�� c_pcode�� �� �����ϱ�
SELECT c_code, c_name, c_pcode From category WHERE c_pcode = 1;




