--게시판 테이블
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

--시퀀스 생성
CREATE SEQUENCE SEQ_practice; --BNO컬럼의 게시물 번호 데이터

--연습용 데이터 넣기
INSERT INTO practice(bno, title, content, writer) VALUES(SEQ_PRACTICE.nextval, '연습용', '연습용', '연습용');

SELECT * FROM PRACTICE;

INSERT INTO practice(bno, title, content, writer)SELECT SEQ_PRACTICE.nextval,title, content, writer FROM practice;

commit;


--write에 넣을 코드(문자면 '' 쓰기)
INSERT INTO PRACTICE(bno, title, CONTENT, writer) VALUES(SEQ_PRACTICE.NEXTVAL, '사과', '사과', '사과');
    

--list에 넣을 코드
SELECT
    bno, title, content, writer, regdate, updatedate, viewcount
FROM
    practice
ORDER BY
 bno DESC;
 
 
--24.05.09(목) ex04-1연습--------

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
            
            
            
            