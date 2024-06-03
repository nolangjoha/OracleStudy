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
    

-- 기존 데이터 삭제
DELETE FROM board;
COMMIT;

DROP SEQUENCE seq_board;

CREATE SEQUENCE seq_board;

-- 아래 설렉트 문을 위하여 데이터 하나를 삽입함.
INSERT INTO
    board(bno, title, content, writer)
VALUES
    (seq_board.nextval, '테스트', '테스트', '테스트');

SELECT * FROM board;    


CREATE TABLE board3(
    bno     NUMBER  CONSTRAINT PK_BOARD_2 PRIMARY KEY,
    title   VARCHAR2(100) NOT NULL
);

-- 더미(dummy) 데이터 작업하기(연습용데이터)
-- 아래를 실행하기 전에 꼭 최소한 데이터가 하나는 들어가 있어야만 함. 그래야지 select 가능
INSERT INTO board(
    bno,
    title,
    content,
    writer)
SELECT seq_board.NEXTVAL, title, content, writer
FROM board;

COMMIT;

SELECT * FROM board ORDER BY bno;

-- 게시물의 데이터를 5개씩 출력(근데 이건 중간에 데이터가 삭제되면 5개씩 가져올 수 없음).
SELECT * FROM board WHERE bno >= 1 AND bno <= 5;
SELECT * FROM board WHERE bno >= 6 AND bno <= 10;
SELECT * FROM board WHERE bno >= 11 AND bno <= 15;

-- ROWNUM 의사컬럼을 이용한 방식, 정렬은 따로 필요없음.(Mysql에선 rownum사용 안함)
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

-- rownum을 이용한 조건식
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

-- 아래는 동작 불가. 중간범위는 안됨.
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
    
-- ROWNUM을 인라인 뷰(FROM절에 사용하는 서브쿼리) 구문으로 사용(ROWNUM은 직접 쓰지 말자)
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

-- 작은 양의 데이터는 ORDER BY 가능하지만, 비교가 일어나기 때문에 성능에 엄청난 문제가 생김.
-- 게시판 데이터를 출력 시 최신글 우선. 대용량 데이터는 ORDER BY 사용 안함.
-- 그 대신 인덱스 힌트 명령어를 사용함.
-- 테이블의 키본키(PRIMARY KEY)설정 시 제약조건 이름은 수동으로 정의함.
-- PRIMARY KEY 제약조건이 생성됨과 동시에 UNIQUE INDEX가 제약조건이름으로 인덱스가 함께 생성됨.

-- 데이터를 (최신글로) 정렬하는 방법
-- 1) ORDER BY
SELECT * FROM board ORDER BY bno DESC;
-- 2) 인덱스 힌트 : /*+ INDEX_DESC(테이블명 제약조건) */
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

-- 최종 : ROWNUM과 인덱스 힌트 구문, 인라인 뷰를 조합하여 페이징 쿼리 완성
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
-- 인덱스 힌트에서 오탈자 같은게 있으면 그냥 그 부분을 무시하고 실행되어버림.

-- 위의 페이징쿼리가 완성 - > 스프링부트에서 사용하는 형태로 변환작업

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
        ROWNUM <= (2 * 5) -- 페이지 번호 * 페이지별 출력건수
)
WHERE
    rn > (2 - 1 ) * 5; -- (페이지 번호 - 1) * 페이지별 출력 건수


-- 검색기능이 추가된 쿼리
-- 1) page1이 선택되고, 검색종류에 제목 선택
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
        ROWNUM <= (2 * 5) AND title LIKE '%검색어%' -- 검색기능
)
WHERE
    rn > (2 - 1 ) * 5; -- (페이지 번호 - 1) * 페이지별 출력 건수

-- 4) page1이 선택되고 검색종류가 제목 or 내용이 선택
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
        ROWNUM <= (1 * 5) AND (title LIKE '%검색어%' OR content LIKE '%검색어%') -- 검색기능
)
WHERE
    rn > (1 - 1 ) * 5; -- (페이지 번호 - 1) * 페이지별 출력 건수

-- 5) 제목 OR 작성자
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
        ROWNUM <= (1 * 5) AND (title LIKE '%검색어%' OR writer LIKE '%검색어%') -- 검색기능
)
WHERE
    rn > (1 - 1 ) * 5; -- (페이지 번호 - 1) * 페이지별 출력 건수

-- 6) 제목 OR 작성자 OR 내용
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
        (title LIKE '%검색어%' OR writer LIKE '%검색어%' OR content LIKE '%검색어%') AND ROWNUM <= (1 * 5) -- 검색기능
)
WHERE
    rn > (1 - 1 ) * 5; -- (페이지 번호 - 1) * 페이지별 출력 건수
    

-- 검색용 데이터 작업
UPDATE board
    SET title = '사과'
WHERE bno IN (811, 812, 813, 814, 815, 816);
COMMIT;

-- 댓글 테이블 생성
CREATE TABLE reply(
    rno         NUMBER  CONSTRAINT pk_reply PRIMARY KEY, -- 댓글 일련번호
    bno         NUMBER  NULL, -- 게시판(board)의 bno컬럼의 참조 글번호(중요)
    retext      VARCHAR2(100)   NOT NULL, -- 댓글내용
    replyer     VARCHAR2(100)   NOT NULL, -- 댓글작성자
    replydate   DATE DEFAULT SYSDATE, -- 댓글 등록일
    updatedate  DATE DEFAULT SYSDATE -- 댓글 수정일
);

-- rno, bno, retext, replyer, replydate, updatedate


-- 댓글기능 구현
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
            bno = 게시물 번호
)
WHERE
    rn > (1 - 1 ) * 5; -- (페이지 번호 - 1) * 페이지별 출력 건수

-- 515번 데이터
CREATE SEQUENCE seq_reply;

INSERT INTO reply(
    rno,
    bno,
    retext,
    replyer)
VALUES (
    seq_reply.NEXTVAL,
    515,
    '댓글테스트',
    'user01');

-- 더미데이터 작업
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

-- 회원관리 시작
CREATE TABLE userinfo ( -- users가 보통 예약적인 성격이 있어서 userinfo로 바꿔줌.
    u_id          VARCHAR2(20),
    u_pwd         CHAR(60)    NOT NULL, -- 암호화하여 처리(정보통신법), 스프링부트 제공 라이브러리 사용 예정
    u_name        VARCHAR2(20)    NOT NULL,
    u_email       VARCHAR2(40)    NOT NULL,
    u_zip_code    CHAR(5)         NOT NULL, -- 우편번호는 CHAR(5)가 고정임
    u_addr        VARCHAR2(100)   NOT NULL,
    u_addrdetail  VARCHAR2(100)   NOT NULL,
    u_phone       VARCHAR2(20)    NOT NULL,
    regdate       DATE            DEFAULT SYSDATE -- 가입일자
);
DROP TABLE userinfo;

-- 프라이머 키를 따로 만들 수 있음.
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

-- 연습용 더미데이터 제작
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
    '홍길동',
    'user01@naver.com',
    '12345',
    '서울시 노원구',
    '이젠빌딩 100번지',
    '010-0000-0000' 
);

COMMIT;

-- 데이터 확인
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




-- 아이디 중복체크
SELECT
    u_id
FROM
    userinfo
WHERE
    u_id = 'user01';

-- 권장하지 않음. COUNT함수 사용
SELECT COUNT(*)
FROM userinfo
WHERE u_id = 'user01';
--이건 기능은 문제 없는데 성능이 떨어짐.

DELETE FROM userinfo WHERE u_id = 'user01';

COMMIT;



---------------------------------24.06.03(금)
--[카테고리 테이블 생성] 
CREATE TABLE category(
    c_code  number        primary key,
    c_name  varchar2(30)  not null,  
    c_pcode number        null --foreign key제약조건 설정은 안해도 되지만, 그 의미에 해당한다. 
                               -- 포린키 설정은 보통 null로 해준다.
);

--카테고리 수등록, 수정,삭제는 생략
-- [카테고리 선택기능]
--더미데이터
--1차 카테고리 등록(c_pcode컬럼의 값이 NULL인 특징
INSERT INTO category(c_code, c_name, c_pcode) VALUES(1, 'TOP', NULL);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(2, 'SHIRTS', NULL);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(3, 'PANTS', NULL);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(4, 'OUTER', NULL);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(5, 'SHOES' || '&' ||'BAG', NULL);  --특수문자&데이터 사용시 &amp; 로해야 사용 할 수 있다.

-- TOP
INSERT INTO category(c_code, c_name, c_pcode) VALUES(6, '맨투맨' || '&' ||'후드티', 1);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(7, '니트', 1);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(8, '긴팔티', 1);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(9, '반팔티', 1);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(10, '나시', 1);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(11, '프린팅티', 1);
--SHIRTS
INSERT INTO category(c_code, c_name, c_pcode) VALUES(12, '베이직', 2);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(13, '청남방', 2);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(14, '체크' || '&' ||'패턴', 2);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(15, '스트라이프', 2);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(16, '헨리텍' || '&' ||'차이나', 2);
--PANTS
INSERT INTO category(c_code, c_name, c_pcode) VALUES(17, '슬랙스', 3);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(18, '면바지', 3);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(19, '청바지', 3);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(20, '밴딩팬츠', 3);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(21, '반바지', 3);
--OUTER
INSERT INTO category(c_code, c_name, c_pcode) VALUES(22, '패딩', 4);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(23, '코드', 4);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(24, '수트' || '&' ||'블레이저', 4);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(25, '자켓', 4);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(26, '블루종/MA-1', 4);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(27, '가디건' || '&' ||'조끼', 4);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(28, '후드' || '&' ||'집업', 4);
--SHOES
INSERT INTO category(c_code, c_name, c_pcode) VALUES(29, '신발', 5);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(30, '가방', 5);

-- 카테고리 코드는 나중에 시퀀스로 처리할 예정.

COMMIT; --스프링에서 적용된 결과를 보기위해 꼭 커밋
--확인
select * from category;


-- 1차 카테고리 출력
SELECT c_code, c_name, c_pcode From category WHERE c_pcode IS NULL;

--2차 카테고리 출력  // c_code와 c_pcode를 잘 구분하기
SELECT c_code, c_name, c_pcode From category WHERE c_pcode = 1;




