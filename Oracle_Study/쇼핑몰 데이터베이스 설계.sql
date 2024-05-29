-----------------------------------24.04.05(��)-----------------------------------

-------------���θ� �����ͺ��̽� ���� ����-----------
CREATE TABLE USERS (
    id          VARCHAR2(20)    PRIMARY KEY, -- ȸ�� ���̵�
    pwd         VARCHAR2(20),    -- ȸ�� ��й�ȣ
    name        VARCHAR2(20),   --ȸ�� �̸�
    enail       VARCHAR2(40),   --ȸ�� �̸���
    zip_code    CHAR(5),        --ȸ�� �����ȣ
    address     VARCHAR2(100),  -- ȸ�� �ּ�
    phone       VARCHAR2(20),   --ȸ�� ��ȭ��ȣ
    useyn       NUMBER DEFAULT 1,   -- ȸ�� Ż�𿩺�
    regdate     DATE DEFAULT SYSDATE -- ȸ�� ������
);


CREATE TABLE PRODUCT (
    prodnum         NUMBER(5)  PRIMARY  KEY,    --��ǰ ��ȣ
    name            VARCHAR2(200),  --��ǰ �̸�
    kind            CHAR(1) CHECK (KIND IN ('1','2','3','4')),    --��ǰ ���� / bag:1, wallet:2, shoes:3, acc:4
    price1          NUMBER(7),  --����
    price2          NUMBER(7),  -- �ǸŰ�
    price3          NUMBER(7),  --����
    content         VARCHAR2(1000), --��ǰ����
    image           VARCHAR2(50),   --��ǰ����
    useyn           CHAR DEFAULT 'Y',   --�Ǹ����� / �Ǹ�:'y', �Ǹ��ߴ� 'n'
    regdate         DATE        --�����
);


CREATE TABLE ADMIN (
    id      varchar2(20)  primary key,  --������ ���̵�
    pwd     varchar2(20),   --������ ��й�ȣ
    name    varchar2(20),   --������ �̸�
    email   varchar2(40),   --������ �̸���
    phone   varchar2(20)    --������ ��ȭ��ȣ
);



CREATE TABLE CART (
    cartnum     NUMBER(8)   primary key, --��ٱ��� ��ȣ
    id          VARCHAR2(20), --��ٱ��� �̿� ȸ��
    prodnum     NUMBER(5), -- ��ǰ��ȣ
    quantity    NUMBER(5)   default 1,  -- ����
    result      CHAR(1), -- ������� / �����:1, �����:2
    indate      DATE, -- īƮ���� ��¥
    Foreign Key(id) REFERENCES USERS (ID),
    Foreign Key(PRODNUM)REFERENCES PRODUCT (PRODNUM)
);


CREATE TABLE ORDERS(
    ordernum    NUMBER(10)      PRIMARY KEY,  --�ֹ���ȣ
    id          VARCHAR2(20),      --�ֹ�ȸ�� ���̵�
    indate      DATE,  --�ֹ���¥
    FOREIGN KEY(ID) REFERENCES USERS (ID)
);


CREATE TABLE ORDER_DETAIL (
    ODNUM       NUMBER(10)  PRIMARY KEY, --�ֹ�ó�� ��ȣ
    ORDERNUM    NUMBER(10), --�ֹ���ȣ
    PRODNUM     NUMBER(5),  --��ǰ��ȣ
    QUANTITY    NUMBER(5), -- ����
    RESULT      CHAR(1)     DEFAULT 1, --ó������ / ����� :1, ����� :2
    FOREIGN KEY(ORDERNUM) REFERENCES ORDERS (ORDERNUM),
    FOREIGN KEY(PRODNUM) REFERENCES PRODUCT (PRODNUM)
);


CREATE TABLE QNA (
    QSEQ        NUMBER(5)       PRIMARY KEY, --���� ��ȣ
    SUBJECT     VARCHAR2(30),   --���� ����
    CONTENT     VARCHAR2(1000), --���� ����
    REPLY       VARCHAR2(1000), --�亯����
    ID          VARCHAR2(20),  --������ ��
    REP         CHAR(1)         DEFAULT 1, --�亯���� / �亯�� : 1, �亯�� :2
    INDATE      DATE,  -- ���ǳ�¥
    FOREIGN KEY(ID) REFERENCES USERS (ID)
    );

COMMIT;