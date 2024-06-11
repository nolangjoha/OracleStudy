DROP TABLE MBSP_TBL;

--1.ȸ������ ���̺�
CREATE TABLE MBSP_TBL(
        MBSP_ID             VARCHAR2(15)            NOT NULL,
        MBSP_NAME           VARCHAR2(30)            NOT NULL,
        MBSP_EMAIL          VARCHAR2(50)            NOT NULL,
        MBSP_PASSWORD       CHAR(60)               NOT NULL,        -- ��й�ȣ ��ȣȭ ó��.
        MBSP_ZIPCODE        CHAR(5)                 NOT NULL,
        MBSP_ADDR           VARCHAR2(100)            NOT NULL,
        MBSP_DEADDR         VARCHAR2(100)            NOT NULL,
        MBSP_PHONE          VARCHAR2(15)            NOT NULL,
        MBSP_NICK           VARCHAR2(30)            NOT NULL UNIQUE,  --�г��� �ߺ��ȵǵ���
        MBSP_RECEIVE        CHAR(1)                 NOT NULL,
        MBSP_POINT          NUMBER DEFAULT 0        NOT NULL,   -- �̰� ����ڰ� �Է��ϴ� ������ �ƴϹǷ� ����Ʈ�� ����
        MBSP_LASTLOGIN      DATE                    NULL,       --�ֱ� ������, ó���� �α����� �������� null�� �� �ۿ� ����. 
        MBSP_DATESUB        DATE DEFAULT SYSDATE    NOT NULL,
        MBSP_UPDATEDATE     DATE DEFAULT SYSDATE    NOT NULL
);

--�ҼҰ��� �������� pk�������� ���� �ۼ�
--���̺� ���� �� �ٷ� ����.
ALTER TABLE MBSP_TBL
ADD CONSTRAINT PK_MBSP_ID PRIMARY KEY (MBSP_ID);



--2.ī�װ� ���̺�

DROP TABLE CATEGORY_TBL;
CREATE TABLE CATEGORY_TBL(
        CAT_CODE            NUMBER,    -- ī�װ� �ڵ� 1,2,3���� ��� ������ ī�װ� �ڵ� ����
        CAT_PRTCODE         NUMBER    NULL,           -- ����ī�װ� �ڵ� / ���� ���� �� ���� ī�װ�
        CAT_NAME            VARCHAR2(50)    NOT NULL
);

--PRIMARY KEY
ALTER TABLE CATEGORY_TBL
ADD CONSTRAINT PK_CAT_CODE PRIMARY KEY (CAT_CODE);

--FOREIGN KEY (������Ʈ ������ �� ����)
/*
ALTER TABLE ���̺��
ADD CONSTRAINT ���������̸�
FOREIGN KEY (�÷���)
REFERENCES ���������̺�(�÷���);
*/
ALTER TABLE CATEGORY_TBL
ADD CONSTRAINT FK_CATEGORY_PCODE
FOREIGN KEY (CAT_PRTCODE)
REFERENCES CATEGORY_TBL(CAT_CODE);


-- / -> /

-- 1�� ī�װ� : TOP(1) PANTS(2) SHIRTS(3) OUTER(4) SHOES(5) BAG(6) ACC(7)
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (1,NULL,'TOP');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (2,NULL,'PANTS');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (3,NULL,'SHIRTS');    
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (4,NULL,'OUTER');        
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (5,NULL,'SHOES');    
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (6,NULL,'BAG');    
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (7,NULL,'ACC');    

-- 1��ī�װ� TOP : 1
-- 2�� ī�װ� : ����Ƽ ��Ʈ ������/�ĵ�Ƽ ������Ƽ ���� ����Ƽ/7��Ƽ
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (8,1,'����Ƽ');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
VALUES (9,1,'��Ʈ');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
VALUES (10,1,'������&#38;�ĵ�Ƽ');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
VALUES (11,1,'������Ƽ');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
VALUES (12,1,'����');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
VALUES (13,1,'����Ƽ&#38;7��Ƽ');

-- 1��ī�װ� PANTS : 2
-- 2��ī�װ� : ������� û���� ������ ����� �ݹ���
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (14,2,'�������');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (15,2,'û����');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (16,2,'������');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (17,2,'�����');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (18,2,'�ݹ���');
    
-- 1��ī�װ� SHIRTS : 3
-- 2��ī�װ� : ���/���̳� ������ üũ/���� û���� ��Ʈ������ 

INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (19,3,'���&#38;���̳�');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (20,3,'������');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (21,3,'üũ&#38;����');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (22,3,'û����');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (23,3,'��Ʈ������'); 
    
    
-- 1��ī�װ� OUTER : 4
-- 2��ī�װ� : �е� ��Ʈ ��Ʈ/������ ���� �����/MA-1 �����/���� �ĵ�/����

INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (24,4,'�е�');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (25,4,'��Ʈ');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (26,4,'��Ʈ&#38;������');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (27,4,'����');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (28,4,'�����&#38;MA-1');     
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (29,4,'�����&#38;����');     
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (30,4,'�ĵ�&#38;����');  
    
-- 1��ī�װ� SHOES : 5
-- 2��ī�װ� : ����Ŀ�� ����/���� Ű���̽Ź�/��â ������/�ɸ�/����
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (31,5,'����Ŀ��');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (32,5,'����&#38;����');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (33,5,'Ű���̽Ź�&#38;��â');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (34,5,'������&#38;�ɸ�/����');
   
-- 1��ī�װ� BAG : 6
-- 2��ī�װ� : ���� ��Ʈ/����� ũ�ν��� Ŭ��ġ
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (35,6,'����'); 
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (36,6,'��Ʈ/�����');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (37,6,'ũ�ν���');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (38,6,'Ŭ��ġ');    
-- 1��ī�װ� ACC : 7
-- 2��ī�װ� : �縻/��Ÿ�� ���� ���÷�/�尩 ���̿��� ��Ʈ/�ð� ��Ÿ
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (39,7,'�縻/��Ÿ��');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (40,7,'����');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (41,7,'���÷�&#38;�尩');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (42,7,'���̿���');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (43,7,'��Ʈ&#38;�ð�');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (44,7,'��Ÿ');
    
   
--3.��ǰ���� ���̺�
DROP TABLE PRODUCT_TBL;


DROP TABLE PRODUCT_TBL;
CREATE TABLE PRODUCT_TBL(
        PRO_NUM             NUMBER,
        CAT_CODE            NUMBER            NULL,
        PRO_NAME            VARCHAR2(50)            NOT NULL,
        PRO_PRICE           NUMBER                  NOT NULL,
        PRO_DISCOUNT        NUMBER                  NOT NULL,
        PRO_PUBLISHER       VARCHAR2(50)            NOT NULL,
        PRO_CONTENT         VARCHAR2(4000)  /* CLOB */                  NOT NULL,       -- ������ 4000BYTE �ʰ������Ǵ�?
        PRO_UP_FOLDER       VARCHAR(50)             NOT NULL,  -- ��¥ ���� ��� ��>2024\06\11
        PRO_IMG             VARCHAR(50)             NOT NULL,  -- �����̸�����
        PRO_AMOUNT          NUMBER                  NOT NULL,
        PRO_BUY             CHAR(1)                 NOT NULL,   -- 'Y' or 'N'
        PRO_DATE            DATE DEFAULT SYSDATE    NOT NULL,
        PRO_UPDATEDATE      DATE DEFAULT SYSDATE    NOT NULL
);
--��ǰ���� �̹����� �������� ��� �̹��� ���̺� ������ ����

--����������
CREATE SEQUENCE SEQ_PRO_NUM;

--PRIMARY KEY
ALTER TABLE PRODUCT_TBL
ADD CONSTRAINT PK_PRO_NUM PRIMARY KEY (PRO_NUM);

--FOREIGN KEY (������Ʈ ������ �� ����)
ALTER TABLE PRODUCT_TBL
ADD CONSTRAINT FK_PRODUCT_CAT_CODE
FOREIGN KEY (CAT_CODE)
REFERENCES CATEGORY_TBL(CAT_CODE);




DROP TABLE CART_TBL;
--4.��ٱ��� ���̺�
CREATE TABLE CART_TBL(
        CART_CODE        NUMBER,
        PRO_NUM         NUMBER          NOT NULL,   -- ��ǰ��ȣ
        MBSP_ID         VARCHAR2(15)    NOT NULL,   -- ȸ�����̵�
        CART_AMOUNT      NUMBER          NOT NULL,   -- ��ٱ��� ����
        CART_DATE       DATE        DEFAULT SYSDATE -- ��ٱ��Ͽ� ���� ��¥, �ʿ������ ���� ������.
);

--��ǰ���� �̹����� �������� ��� �̹��� ���̺� ������ ����.

--����������
CREATE SEQUENCE SEQ_CART_CODE;

--PRIMARY KEY
ALTER TABLE CART_TBL
ADD CONSTRAINT PK_CART_CODE PRIMARY KEY (CART_CODE);

--FOREIGN KEY (������Ʈ ������ �� ����)
ALTER TABLE CART_TBL
ADD CONSTRAINT FK_CART_PRO_NUM
FOREIGN KEY (PRO_NUM)
REFERENCES PRODUCT_TBL(PRO_NUM);

--FOREIGN KEY (������Ʈ ������ �� ����)
ALTER TABLE CART_TBL
ADD CONSTRAINT FK_CART_MBSP_ID
FOREIGN KEY (MBSP_ID)
REFERENCES PRODUCT_TBL(MBSP_ID);




DROP TABLE ORDER_TBL;
--5.�ֹ����� ���̺�(�ֹ��� ����)
CREATE TABLE ORDER_TBL(
        ORD_CODE            NUMBER,
        MBSP_ID             VARCHAR2(15)            NOT NULL,
        ORD_NAME            VARCHAR2(30)            NOT NULL,
        ORD_ADDR_ZIPCODE        CHAR(5)                 NOT NULL,
        ORD_ADDR_BASIC      VARCHAR2(50)            NOT NULL,
        ORD_ADDR_DETAIL     VARCHAR2(50)            NOT NULL,
        ORD_TEL             VARCHAR2(20)            NOT NULL,
        ORD_PRICE           NUMBER                  NOT NULL,  -- ���ֹ��ݾ�. ����
        ORD_REGDATE         DATE DEFAULT SYSDATE    NOT NULL
);

--����������
CREATE SEQUENCE SEQ_ORD_CODE;

--PRIMARY KEY
ALTER TABLE ORDER_TBL
ADD CONSTRAINT PK_ORD_CODE PRIMARY KEY (ORD_CODE);

--FOREIGN KEY (������Ʈ ������ �� ����)
ALTER TABLE ORDER_TBL
ADD CONSTRAINT FK_ORDER_MBSP_ID
FOREIGN KEY (MBSP_ID)
REFERENCES ORDER_TBL(MBSP_ID);


DROP TABLE ORDETAIL_TBL;
--6.�ֹ��� ���̺�(�ֹ���ǰ ����)
CREATE TABLE ORDETAIL_TBL(
        ORD_CODE        NUMBER,
        PRO_NUM         NUMBER,
        DT_AMOUNT       NUMBER      NOT NULL, -- ��������
        DT_PRICE        NUMBER      NOT NULL  -- ������ȭ
);

--PRIMARY KEY
ALTER TABLE ORDETAIL_TBL
ADD CONSTRAINT PK_ORDETAIL_CODE_NUM PRIMARY KEY (ORD_CODE ,PRO_NUM);

--FOREIGN KEY (������Ʈ ������ �� ����)
ALTER TABLE ORDETAIL_TBL
ADD CONSTRAINT FK_ORDETAIL_CODE
FOREIGN KEY (ORD_CODE)
REFERENCES ORDER_TBL(ORD_CODE);

--FOREIGN KEY (������Ʈ ������ �� ����)
ALTER TABLE ORDETAIL_TBL
ADD CONSTRAINT FK_ORDETAIL_CODE
FOREIGN KEY (PRO_NUM)
REFERENCES ORDER_TBL(PRO_NUM);


--7. ��ǰ�ı� ���̺�
CREATE TABLE REVIEW(
    RE_CODE     NUMBER       NOT NULL,
    MBSP_ID     VARCHAR2(15) NOT NULL,
    PRO_NUM     NUMBER       NOT NULL,
    RE_TITLE    VARCHAR2(50)    NOT NULL,
    RE_CONTENT  VARCHAR2(200)    NOT NULL,
    RE_RATE     NUMBER          NOT NULL,
    RE_DATE     DATE DEFAULT SYSDATE    
);

--����������
CREATE SEQUENCE SEQ_REVIEW_CODE;

--PRIMARY KEY
ALTER TABLE REVIEW_TBL
ADD CONSTRAINT PK_RE_CODE PRIMARY KEY (RE_CODE);

--FOREIGN KEY (������Ʈ ������ �� ����)
ALTER TABLE REVIEW_TBL
ADD CONSTRAINT FK_REVIEW_CODE
FOREIGN KEY (MBSP_ID)
REFERENCES MBSP_TBL(MBSP_ID);

--FOREIGN KEY (������Ʈ ������ �� ����)
ALTER TABLE REVIEW_TBL
ADD CONSTRAINT FK_REVIEW_NUM
FOREIGN KEY (PRO_NUM)
REFERENCES PRODUCT_TBL(PRO_NUM);


DROP TABLE BOARD_TBL;
--8.�Խ��� ���̺�

CREATE SEQUENCE BOARD_NUM_SEQ;
CREATE TABLE BOARD_TBL(
        BRD_NUM         NUMBER,
        MBSP_ID         VARCHAR2(15)            NOT NULL,
        BRD_TITLE       VARCHAR2(100)           NOT NULL,
        BRD_CONTENT     VARCHAR2(4000)          NOT NULL,
        BRD_REGDATE     DATE DEFAULT SYSDATE    NOT NULL
);

--PRIMARY KEY
ALTER TABLE BOARD_TBL
ADD CONSTRAINT PK_BOARD_BRD_NUM PRIMARY KEY (BRD_NUM);

-- ����Ű �߰�
ALTER TABLE BOARD_TBL ADD CONSTRAINT FK_BOARD_MBSP_ID
FOREIGN KEY (MBSP_ID) REFERENCES MBSP_TBL(MBSP_ID);

--9.������(ADMIN)���̺�
CREATE TABLE ADMIN_TBL (
    ADMIN_ID    VARCHAR2(15)    PRIMARY KEY,
    ADMIN_PW    CHAR(60)    NOT NULL,
    ADMIN_VISIT_DATE    DATE
);

--10. �����������̺�
CREATE TABLE NOTICE_TBL(
    IDX         NUMBER      NOT NULL,
    TITLE       VARCHAR2(50)    NOT NULL,
    CONTENT     VARCHAR2(1000)  NOT NULL,
    WRITER      VARCHAR2(15)    NOT NULL,
    READCOUNT   NUMBER DEFAULT 0 NOT NULL,
    REGDATE DATE DEFAULT SYSDATE
);

--PRIMARY KEY
ALTER TABLE NOTICE_TBL
ADD CONSTRAINT PK_NOTICE_IDX PRIMARY KEY (IDX);

-- ����Ű �߰�
ALTER TABLE NOTICE_TBL ADD CONSTRAINT FK_NOTICE_WRITER
FOREIGN KEY (MBSP_ID) REFERENCES ADMIN_TBL(ADMIN_ID);









