-----------------------------------24.04.05(금)-----------------------------------

-------------쇼핑몰 데이터베이스 설계 예제-----------
CREATE TABLE USERS (
    id          VARCHAR2(20)    PRIMARY KEY, -- 회원 아이디
    pwd         VARCHAR2(20),    -- 회원 비밀번호
    name        VARCHAR2(20),   --회원 이름
    enail       VARCHAR2(40),   --회원 이메일
    zip_code    CHAR(5),        --회원 우편번호
    address     VARCHAR2(100),  -- 회원 주소
    phone       VARCHAR2(20),   --회원 전화번호
    useyn       NUMBER DEFAULT 1,   -- 회원 탈퇴여부
    regdate     DATE DEFAULT SYSDATE -- 회원 가입일
);


CREATE TABLE PRODUCT (
    prodnum         NUMBER(5)  PRIMARY  KEY,    --상품 번호
    name            VARCHAR2(200),  --상품 이름
    kind            CHAR(1) CHECK (KIND IN ('1','2','3','4')),    --상품 종류 / bag:1, wallet:2, shoes:3, acc:4
    price1          NUMBER(7),  --원가
    price2          NUMBER(7),  -- 판매가
    price3          NUMBER(7),  --이익
    content         VARCHAR2(1000), --상품설명
    image           VARCHAR2(50),   --상품사진
    useyn           CHAR DEFAULT 'Y',   --판매유무 / 판매:'y', 판매중단 'n'
    regdate         DATE        --등록일
);


CREATE TABLE ADMIN (
    id      varchar2(20)  primary key,  --관리자 아이디
    pwd     varchar2(20),   --관리자 비밀번호
    name    varchar2(20),   --관리자 이름
    email   varchar2(40),   --관리자 이메일
    phone   varchar2(20)    --관리자 전화번호
);



CREATE TABLE CART (
    cartnum     NUMBER(8)   primary key, --장바구니 번호
    id          VARCHAR2(20), --장바구니 이용 회원
    prodnum     NUMBER(5), -- 상품번호
    quantity    NUMBER(5)   default 1,  -- 수량
    result      CHAR(1), -- 배송유무 / 배송전:1, 배송후:2
    indate      DATE, -- 카트담은 날짜
    Foreign Key(id) REFERENCES USERS (ID),
    Foreign Key(PRODNUM)REFERENCES PRODUCT (PRODNUM)
);


CREATE TABLE ORDERS(
    ordernum    NUMBER(10)      PRIMARY KEY,  --주문번호
    id          VARCHAR2(20),      --주문회원 아이디
    indate      DATE,  --주문날짜
    FOREIGN KEY(ID) REFERENCES USERS (ID)
);


CREATE TABLE ORDER_DETAIL (
    ODNUM       NUMBER(10)  PRIMARY KEY, --주문처리 번호
    ORDERNUM    NUMBER(10), --주문번호
    PRODNUM     NUMBER(5),  --상품번호
    QUANTITY    NUMBER(5), -- 수량
    RESULT      CHAR(1)     DEFAULT 1, --처리유무 / 배송전 :1, 배송후 :2
    FOREIGN KEY(ORDERNUM) REFERENCES ORDERS (ORDERNUM),
    FOREIGN KEY(PRODNUM) REFERENCES PRODUCT (PRODNUM)
);


CREATE TABLE QNA (
    QSEQ        NUMBER(5)       PRIMARY KEY, --문의 번호
    SUBJECT     VARCHAR2(30),   --문의 제목
    CONTENT     VARCHAR2(1000), --문의 내용
    REPLY       VARCHAR2(1000), --답변내용
    ID          VARCHAR2(20),  --문의한 고객
    REP         CHAR(1)         DEFAULT 1, --답변유무 / 답변전 : 1, 답변후 :2
    INDATE      DATE,  -- 문의날짜
    FOREIGN KEY(ID) REFERENCES USERS (ID)
    );

COMMIT;