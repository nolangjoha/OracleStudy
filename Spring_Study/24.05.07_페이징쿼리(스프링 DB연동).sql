--더미(dummy) 데이터 작업하기

DELETE FROM board;
COMMIT;
DROP SEQUENCE SEQ_BOARD;

CREATE SEQUENCE SEQ_BOARD;
--글번호 값을 다시 처음부터 진행하려고 다시 만듬

--INSERT SELECT문을 실행하기 전에 데이터 1개는 들어있어야 함.
INSERT INTO board(bno, title, content, writer) VALUES(SEQ_BOARD.nextval, '테스트', '테스트', '테스트');

SELECT * FROM board;

-- 컬럼을 4개만 사용한 이유: 나머지 3개는 디폴트 성격이 있기에 뺌.
-- INSERT SELECT 문 : 여러데이터 삽입하기
-- 9번 실행해서 더미데이터를 넣어주자 -> 데이터가 순서대로 들어가 있지 않을 것이다. 원래 자연스러운 현상임. 더미데이터 만들 때 특히 그럼.
INSERT INTO board(bno, title, content, writer)
SELECT SEQ_BOARD.nextval,title, content, writer FROM board;

COMMIT;

SELECT * FROM board ORDER BY bno;

--bno컬럼으로 조건식을 이용하여 출력시, 데이터가 삭제되면 문제가 발생한다.
--게시물의 데이터를 5개씩 출력, 그런데 중간에 데이터를 삭제하면 5개씩 출력되지 않음
SELECT * FROM board WHERE bno >= 1 AND bno <= 5;
SELECT * FROM board WHERE bno >= 6 AND bno <= 10;
SELECT * FROM board WHERE bno >= 11 AND bno <= 15;

DELETE FROM board WHERE bno = 3;

--하지만 그럼에도 5개씩 출력하고 싶다면 
-- ROWNUM 의사컬럼을 이용한다.  : 테이블에 종속되는건 아니나 출력되는 데이터에 대해서 번호를 부여해준다.
-- ※ MYSQL은 ROWNUM을 사용하지 않는다.

--BNO 컬럼을 오름차순 출력
SELECT bno, title, content, writer, regdate, updatedate, viewcount FROM board ORDER BY bno;
-- ROWNUM을 이용한 출력
SELECT ROWNUM, bno, title, content, writer, regdate, updatedate, viewcount FROM board;

--ROWNUM을 이용한 조건식
SELECT ROWNUM, bno, title, content, writer, regdate, updatedate, viewcount FROM board WHERE ROWNUM >= 1 AND ROWNUM <= 5;
--ROWNUM의 동작원리로 인해 중간범위 데이터는 가져오지 못한다.
SELECT ROWNUM, bno, title, content, writer, regdate, updatedate, viewcount FROM board WHERE ROWNUM >= 6 AND ROWNUM <= 10;
SELECT ROWNUM, bno, title, content, writer, regdate, updatedate, viewcount FROM board WHERE ROWNUM >= 11 AND ROWNUM <= 15;

--ROWNUM을 인라인뷰 구문으로 사용.
-- 인라인뷰란? FROM절의 서브쿼리.
-- FROM()내부 코드가 1차로 진행되어 미리 테이블로 만듬 > 조건에 맞게 만들어진 데이터로 조건에 맞게 출력
-->> 중간범위 데이터를 ROWNUM 으로 가져올땐 
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


-- 게시판 데이터 출력시 최신글을 우선적으로 출력해야 한다. 대용량 데이터는 ORDER BY를 사용하지 않는다.(ORDER BY를 사용하게 될 경우 데이터가 많으면? > 내부적으로 계속 비교를 하게 되면서 과부화, 실무에서는 함부로 쓰는게 아님./ 적은 데이터는 사용 가능)
-- 대신 인덱스 힌트 명령어를 사용한다.
-- 테이블의 기본키(primary key)설정 시 제약조건이름은 수동으로 정의한다. 
-- PRIMARY KEY 제약조건이 생성됨과 동시에 UNIQUE INDEX가 제약조건 이름으로 인덱스가 함께 생성된다.
-- 이때 인덱스 힌트를 사용하면 ORDER BY와 같은 효과를 볼 수 있다.

-- 데이터를 최신글로 정렬하는 방법
-- 1) ORDER BY 사용 -- 데이터가 수십 수만단위일 경우 과부화
SELECT * FROM board ORDER BY bno DESC; --최신글
-- 2) 인덱스 힌트 사용
-- /*+ INDEX(테이블명 제약조건이름)  */  -- 오름차순으로 정렬 
-- /*+ INDEX_DESC(테이블명 제약조건이름)  */ -- 내림차순으로 정렬

SELECT /*+ INDEX(board PK_BOARD)  */ 
    bno, title, content, writer, regdate, updatedate, viewcount
FROM board;

SELECT /*+ INDEX_DESC(board PK_BOARD)  */ 
    bno, title, content, writer, regdate, updatedate, viewcount
FROM board;



-- 최종. ROWNUM과 인덱스 힌트구문, 인라인뷰 조합 > 페이징 쿼리 완성
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
)
WHERE RN >=1 AND RN <= 5;
-- 주의사항 : 인덱스힌트 구문이 잘못되어도, 에러는 발생하지 않는다. 즉 인덱스가 사용되지 않고 출력된다.
-- 페이징 쿼리가 완성 -> 스프링 부트에서 사용하는 형태로 변환작업 필요

/*
3페이지를 클릭했을때 1,2 페이지의 게시글은 나오지 않게 표시하기
*/
--page1이 선택됐을 때
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
    WHERE ROWNUM <= (1*5)  -- 페이지번호 * 페이지별 출력건수
)
WHERE RN > (1 - 1) * 5;  -- (페이지번호 -1) * 페이지별 출력건수


--page2가 선택됐을 때
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
    WHERE ROWNUM <= (2*5)  -- 페이지번호 * 페이지별 출력건수
)
WHERE RN > (2 - 1) * 5;  -- (페이지번호 -1) * 페이지별 출력건수

commit;


-------------24.05.08(수)----------------
--검색기능이 추가된 쿼리
--1) page1이 선택되고, 검색종류가 제목이 선택
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
    WHERE ROWNUM <= (1*5) AND title LIKE '%검색어%'  -- 검색기능 소수 추가 : 원본소스에서부터 검색해야하니까 
)
WHERE RN > (1 - 1) * 5;  -- (페이지번호 -1) * 페이지별 출력건수


--2) page1이 선택되고, 검색종류가 작성자 선택
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
    WHERE ROWNUM <= (1*5) AND write LIKE '%검색어%'  -- 검색기능 소수 추가 : 원본소스에서부터 검색해야하니까 
)
WHERE RN > (1 - 1) * 5;  -- (페이지번호 -1) * 페이지별 출력건수


--3) page1이 선택되고, 검색종류가 내용 선택
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
    WHERE ROWNUM <= (1*5) AND CONTENT LIKE '%검색어%'  -- 검색기능 소수 추가 : 원본소스에서부터 검색해야하니까 
)
WHERE RN > (1 - 1) * 5;  -- (페이지번호 -1) * 페이지별 출력건수


--4) page1이 선택되고, 검색종류가 제목 OR 내용 선택
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
    WHERE ROWNUM <= (1*5) AND (title LIKE '%검색어%' OR content LIKE '%검색어%')  -- 검색기능 소수 추가 : 원본소스에서부터 검색해야하니까 
)                                        --AND와 OR이 같이 쓰일때 AND가 우선임.               
WHERE RN > (1 - 1) * 5;  -- (페이지번호 -1) * 페이지별 출력건수


--5) page1이 선택되고, 검색종류가 제목 OR 작성자 선택
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
    WHERE ROWNUM <= (1*5) AND (title LIKE '%검색어%' OR content writer '%검색어%')  -- 검색기능 소수 추가 : 원본소스에서부터 검색해야하니까 
)                                                       
WHERE RN > (1 - 1) * 5;  -- (페이지번호 -1) * 페이지별 출력건수


--6) page1이 선택되고, 검색종류가 제목 OR 작성자 OR 내용 선택
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
    WHERE (title LIKE '%검색어%' OR writer LIKE '%검색어%' OR content LIKE '%검색어%') AND ROWNUM <= (1*5)  -- 검색기능 소수 추가 : 원본소스에서부터 검색해야하니까 
)                          
WHERE RN > (1 - 1) * 5;  -- (페이지번호 -1) * 페이지별 출력건수



--검색용 데이터 삽입(원래 있던거 변경)

UPDATE board 
    SET title = '사과'
WHERE bno IN(512, 510, 504, 502, 500, 412, 410, 404, 402, 400, 312, 310, 304, 302, 300, 212, 210, 024, 202, 200, 112, 110, 104, 102, 100);

COMMIT;




--스프링부트에서 검색시 완성된 sql구문
SELECT  
			bno, title, content, writer, regdate, updatedate, viewcount
		FROM (
	    	SELECT /*+ INDEX_DESC(board PK_BOARD) */
	        	ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
	    	FROM 
	        	board  
	    	WHERE 

		 (  title like '%' || '사과'

				OR writer like '%' || '사과'

				OR content like '%' || '사과' ) AND 

	    	ROWNUM <= (1 * 10) 

	    	)
		WHERE 
			RN > (1 - 1) * 10





-----24.05.09(목)--댓글기능 만들기--------------------------

--댓글 테이블 생성
CREATE TABLE reply(
    rno         NUMBER  CONSTRAINT pk_reply PRIMARY KEY,  -- 댓글 일련번호
    bno         NUMBER  NULL,                              -- 게시판(board)의 bno컬럼의 참조 글번호
    retext      VARCHAR2(100)   NOT NULL,                  -- 댓글 내용
    replyer     VARCHAR2(100)   NOT NULL,                  -- 댓글 작성자
    replydate   DATE DEFAULT   SYSDATE,                    -- 댓글 등록일 
    updatedate  DATE DEFAULT   SYSDATE                     -- 댓글 수정일
);


--게시판 목록 기본 쿼리
SELECT  bno, title, content, writer, regdate, updatedate, viewcount
FROM(
    SELECT /*+ INDEX_DESC(board PK_BOARD) */
        ROWNUM AS RN, bno, title, content, writer, regdate, updatedate, viewcount
    FROM 
        board  
    WHERE (title LIKE '%검색어%' OR writer LIKE '%검색어%' OR content LIKE '%검색어%') AND ROWNUM <= (1*5)  -- 검색기능 소수 추가 : 원본소스에서부터 검색해야하니까 
)                          
WHERE RN > (1 - 1) * 5;  -- (페이지번호 -1) * 페이지별 출력건수


--댓글목록 기본 쿼리
-- 1)게시판 목록 기본 쿼리에서 검색기능(WHERE)를 없앴다.
-- 2) 각 게시글 아래 들어가야 하므로 게시글 번호 조건을 추가했다.
SELECT  rno, bno, retext, replyer, replydate, updatedate
FROM(
    SELECT /*+ INDEX_DESC(reply pk_reply) */
        ROWNUM AS RN, rno, bno, retext, replyer, replydate, updatedate
    FROM 
        reply 
    WHERE bno = 게시물번호
        -- 페이지번호 * 페이지별 출력건수
)                          
WHERE RN > (1 - 1) * 5;    -- (페이지번호 -1) * 페이지별 출력건수

--시퀀스 생성: 댓글에서도 해줘야 함.
CREATE SEQUENCE SEQ_REPLY;

--511번에 데이터 넣어보기(rno, bno, retext, replyer, replydate, updatedate)
INSERT INTO reply (rno, bno, retext, replyer) VALUES(SEQ_REPLY.NEXTVAL, 511, '댓글테스트', 'user01');

-- 더미 데이터 많이 넣기
INSERT INTO reply (rno, bno, retext, replyer)
SELECT SEQ_REPLY.NEXTVAL,bno, retext, replyer FROM reply;

COMMIT;



---------------------------------------------------------------
--------------------24.05.14(화)-------------------------------
--총정리

