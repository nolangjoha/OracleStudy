DROP TABLE MBSP_TBL;

--1.회원가입 테이블
CREATE TABLE MBSP_TBL(
        MBSP_ID             VARCHAR2(15)            NOT NULL,
        MBSP_NAME           VARCHAR2(30)            NOT NULL,
        MBSP_EMAIL          VARCHAR2(50)            NOT NULL,
        MBSP_PASSWORD       CHAR(60)               NOT NULL,        -- 비밀번호 암호화 처리.
        MBSP_ZIPCODE        CHAR(5)                 NOT NULL,
        MBSP_ADDR           VARCHAR2(100)            NOT NULL,
        MBSP_DEADDR         VARCHAR2(100)            NOT NULL,
        MBSP_PHONE          VARCHAR2(15)            NOT NULL,
        MBSP_NICK           VARCHAR2(30)            NOT NULL UNIQUE,  --닉네임 중복안되도록
        MBSP_RECEIVE        CHAR(1)                 NOT NULL,
        MBSP_POINT          NUMBER DEFAULT 0        NOT NULL,   -- 이건 사용자가 입력하는 정보가 아니므로 디폴트값 설정
        MBSP_LASTLOGIN      DATE                    NULL,       --최근 접속일, 처음엔 로그인을 안했으니 null일 수 밖에 없다. 
        MBSP_DATESUB        DATE DEFAULT SYSDATE    NOT NULL,
        MBSP_UPDATEDATE     DATE DEFAULT SYSDATE    NOT NULL
);

--소소관리 차원에서 pk생성구문 따로 작성
--테이블 생성 후 바로 실행.
ALTER TABLE MBSP_TBL
ADD CONSTRAINT PK_MBSP_ID PRIMARY KEY (MBSP_ID);



--2.카테고리 테이블

DROP TABLE CATEGORY_TBL;
CREATE TABLE CATEGORY_TBL(
        CAT_CODE            NUMBER,    -- 카테고리 코드 1,2,3차든 모든 레벨의 카테고리 코드 저장
        CAT_PRTCODE         NUMBER    NULL,           -- 상위카테고리 코드 / 위에 들어간것 중 상위 카테고리
        CAT_NAME            VARCHAR2(50)    NOT NULL
);

--PRIMARY KEY
ALTER TABLE CATEGORY_TBL
ADD CONSTRAINT PK_CAT_CODE PRIMARY KEY (CAT_CODE);

--FOREIGN KEY (프로젝트 마무리 후 실행)
/*
ALTER TABLE 테이블명
ADD CONSTRAINT 제약조건이름
FOREIGN KEY (컬럼명)
REFERENCES 참조할테이블(컬럼명);
*/
ALTER TABLE CATEGORY_TBL
ADD CONSTRAINT FK_CATEGORY_PCODE
FOREIGN KEY (CAT_PRTCODE)
REFERENCES CATEGORY_TBL(CAT_CODE);


-- / -> /

-- 1차 카테고리 : TOP(1) PANTS(2) SHIRTS(3) OUTER(4) SHOES(5) BAG(6) ACC(7)
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

-- 1차카테고리 TOP : 1
-- 2차 카테고리 : 긴팔티 니트 맨투맨/후드티 프린팅티 나시 반팔티/7부티
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (8,1,'긴팔티');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
VALUES (9,1,'니트');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
VALUES (10,1,'맨투맨&#38;후드티');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
VALUES (11,1,'프린팅티');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
VALUES (12,1,'나시');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
VALUES (13,1,'반팔티&#38;7부티');

-- 1차카테고리 PANTS : 2
-- 2차카테고리 : 밴딩팬츠 청바지 슬랙스 면바지 반바지
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (14,2,'밴딩팬츠');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (15,2,'청바지');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (16,2,'슬랙스');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (17,2,'면바지');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (18,2,'반바지');
    
-- 1차카테고리 SHIRTS : 3
-- 2차카테고리 : 헨리넥/차이나 베이직 체크/패턴 청남방 스트라이프 

INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (19,3,'헨리넥&#38;차이나');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (20,3,'베이직');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (21,3,'체크&#38;패턴');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (22,3,'청남방');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (23,3,'스트라이프'); 
    
    
-- 1차카테고리 OUTER : 4
-- 2차카테고리 : 패딩 코트 수트/블레이져 자켓 블루종/MA-1 가디건/조끼 후드/집업

INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (24,4,'패딩');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (25,4,'코트');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (26,4,'수트&#38;블레이져');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (27,4,'자켓');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (28,4,'블루종&#38;MA-1');     
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (29,4,'가디건&#38;조끼');     
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (30,4,'후드&#38;집업');  
    
-- 1차카테고리 SHOES : 5
-- 2차카테고리 : 스니커즈 로퍼/구두 키높이신발/깔창 슬리퍼/쪼리/샌들
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (31,5,'스니커즈');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (32,5,'로퍼&#38;구두');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (33,5,'키높이신발&#38;깔창');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (34,5,'슬리퍼&#38;쪼리/샌들');
   
-- 1차카테고리 BAG : 6
-- 2차카테고리 : 백팩 토트/숄더백 크로스백 클러치
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (35,6,'백팩'); 
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (36,6,'토트/숄더백');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (37,6,'크로스백');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (38,6,'클러치');    
-- 1차카테고리 ACC : 7
-- 2차카테고리 : 양말/넥타이 모자 머플러/장갑 아이웨어 벨트/시계 기타
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (39,7,'양말/넥타이');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (40,7,'모자');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (41,7,'머플러&#38;장갑');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (42,7,'아이웨어');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (43,7,'벨트&#38;시계');
INSERT INTO category_tbl (cat_code,cat_prtcode,cat_name) 
    VALUES (44,7,'기타');
    
   
--3.상품정보 테이블
DROP TABLE PRODUCT_TBL;


DROP TABLE PRODUCT_TBL;
CREATE TABLE PRODUCT_TBL(
        PRO_NUM             NUMBER,
        CAT_CODE            NUMBER            NULL,
        PRO_NAME            VARCHAR2(50)            NOT NULL,
        PRO_PRICE           NUMBER                  NOT NULL,
        PRO_DISCOUNT        NUMBER                  NOT NULL,
        PRO_PUBLISHER       VARCHAR2(50)            NOT NULL,
        PRO_CONTENT         VARCHAR2(4000)  /* CLOB */                  NOT NULL,       -- 내용이 4000BYTE 초과여부판단?
        PRO_UP_FOLDER       VARCHAR(50)             NOT NULL,  -- 날짜 폴더 경로 예>2024\06\11
        PRO_IMG             VARCHAR(50)             NOT NULL,  -- 파일이름저장
        PRO_AMOUNT          NUMBER                  NOT NULL,
        PRO_BUY             CHAR(1)                 NOT NULL,   -- 'Y' or 'N'
        PRO_DATE            DATE DEFAULT SYSDATE    NOT NULL,
        PRO_UPDATEDATE      DATE DEFAULT SYSDATE    NOT NULL
);
--상품마다 이미지가 여러개인 경우 이미지 테이블 별도로 생성

--시퀀스생성
CREATE SEQUENCE SEQ_PRO_NUM;

--PRIMARY KEY
ALTER TABLE PRODUCT_TBL
ADD CONSTRAINT PK_PRO_NUM PRIMARY KEY (PRO_NUM);

--FOREIGN KEY (프로젝트 마무리 후 실행)
ALTER TABLE PRODUCT_TBL
ADD CONSTRAINT FK_PRODUCT_CAT_CODE
FOREIGN KEY (CAT_CODE)
REFERENCES CATEGORY_TBL(CAT_CODE);




DROP TABLE CART_TBL;
--4.장바구니 테이블
CREATE TABLE CART_TBL(
        CART_CODE        NUMBER,
        PRO_NUM         NUMBER          NOT NULL,   -- 상품번호
        MBSP_ID         VARCHAR2(15)    NOT NULL,   -- 회원아이디
        CART_AMOUNT      NUMBER          NOT NULL,   -- 장바구니 수량
        CART_DATE       DATE        DEFAULT SYSDATE -- 장바구니에 담은 날짜, 필요없으면 빼도 괜찮다.
);

--상품마다 이미지가 여러개인 경우 이미지 테이블 별도로 생성.

--시퀀스생성
CREATE SEQUENCE SEQ_CART_CODE;

--PRIMARY KEY
ALTER TABLE CART_TBL
ADD CONSTRAINT PK_CART_CODE PRIMARY KEY (CART_CODE);

--FOREIGN KEY (프로젝트 마무리 후 실행)
ALTER TABLE CART_TBL
ADD CONSTRAINT FK_CART_PRO_NUM
FOREIGN KEY (PRO_NUM)
REFERENCES PRODUCT_TBL(PRO_NUM);

--FOREIGN KEY (프로젝트 마무리 후 실행)
ALTER TABLE CART_TBL
ADD CONSTRAINT FK_CART_MBSP_ID
FOREIGN KEY (MBSP_ID)
REFERENCES PRODUCT_TBL(MBSP_ID);




DROP TABLE ORDER_TBL;
--5.주문내용 테이블(주문자 정보)
CREATE TABLE ORDER_TBL(
        ORD_CODE            NUMBER,
        MBSP_ID             VARCHAR2(15)            NOT NULL,
        ORD_NAME            VARCHAR2(30)            NOT NULL,
        ORD_ADDR_ZIPCODE        CHAR(5)                 NOT NULL,
        ORD_ADDR_BASIC      VARCHAR2(50)            NOT NULL,
        ORD_ADDR_DETAIL     VARCHAR2(50)            NOT NULL,
        ORD_TEL             VARCHAR2(20)            NOT NULL,
        ORD_PRICE           NUMBER                  NOT NULL,  -- 총주문금액. 선택
        ORD_REGDATE         DATE DEFAULT SYSDATE    NOT NULL
);

--시퀀스생성
CREATE SEQUENCE SEQ_ORD_CODE;

--PRIMARY KEY
ALTER TABLE ORDER_TBL
ADD CONSTRAINT PK_ORD_CODE PRIMARY KEY (ORD_CODE);

--FOREIGN KEY (프로젝트 마무리 후 실행)
ALTER TABLE ORDER_TBL
ADD CONSTRAINT FK_ORDER_MBSP_ID
FOREIGN KEY (MBSP_ID)
REFERENCES ORDER_TBL(MBSP_ID);


DROP TABLE ORDETAIL_TBL;
--6.주문상세 테이블(주문상품 정보)
CREATE TABLE ORDETAIL_TBL(
        ORD_CODE        NUMBER,
        PRO_NUM         NUMBER,
        DT_AMOUNT       NUMBER      NOT NULL, -- 개별가격
        DT_PRICE        NUMBER      NOT NULL  -- 역정규화
);

--PRIMARY KEY
ALTER TABLE ORDETAIL_TBL
ADD CONSTRAINT PK_ORDETAIL_CODE_NUM PRIMARY KEY (ORD_CODE ,PRO_NUM);

--FOREIGN KEY (프로젝트 마무리 후 실행)
ALTER TABLE ORDETAIL_TBL
ADD CONSTRAINT FK_ORDETAIL_CODE
FOREIGN KEY (ORD_CODE)
REFERENCES ORDER_TBL(ORD_CODE);

--FOREIGN KEY (프로젝트 마무리 후 실행)
ALTER TABLE ORDETAIL_TBL
ADD CONSTRAINT FK_ORDETAIL_CODE
FOREIGN KEY (PRO_NUM)
REFERENCES ORDER_TBL(PRO_NUM);


--7. 상품후기 테이블
CREATE TABLE REVIEW(
    RE_CODE     NUMBER       NOT NULL,
    MBSP_ID     VARCHAR2(15) NOT NULL,
    PRO_NUM     NUMBER       NOT NULL,
    RE_TITLE    VARCHAR2(50)    NOT NULL,
    RE_CONTENT  VARCHAR2(200)    NOT NULL,
    RE_RATE     NUMBER          NOT NULL,
    RE_DATE     DATE DEFAULT SYSDATE    
);

--시퀀스생성
CREATE SEQUENCE SEQ_REVIEW_CODE;

--PRIMARY KEY
ALTER TABLE REVIEW_TBL
ADD CONSTRAINT PK_RE_CODE PRIMARY KEY (RE_CODE);

--FOREIGN KEY (프로젝트 마무리 후 실행)
ALTER TABLE REVIEW_TBL
ADD CONSTRAINT FK_REVIEW_CODE
FOREIGN KEY (MBSP_ID)
REFERENCES MBSP_TBL(MBSP_ID);

--FOREIGN KEY (프로젝트 마무리 후 실행)
ALTER TABLE REVIEW_TBL
ADD CONSTRAINT FK_REVIEW_NUM
FOREIGN KEY (PRO_NUM)
REFERENCES PRODUCT_TBL(PRO_NUM);


DROP TABLE BOARD_TBL;
--8.게시판 테이블

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

-- 참조키 추가
ALTER TABLE BOARD_TBL ADD CONSTRAINT FK_BOARD_MBSP_ID
FOREIGN KEY (MBSP_ID) REFERENCES MBSP_TBL(MBSP_ID);

--9.관리자(ADMIN)테이블
CREATE TABLE ADMIN_TBL (
    ADMIN_ID    VARCHAR2(15)    PRIMARY KEY,
    ADMIN_PW    CHAR(60)    NOT NULL,
    ADMIN_VISIT_DATE    DATE
);

--10. 공지사항테이블
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

-- 참조키 추가
ALTER TABLE NOTICE_TBL ADD CONSTRAINT FK_NOTICE_WRITER
FOREIGN KEY (MBSP_ID) REFERENCES ADMIN_TBL(ADMIN_ID);









