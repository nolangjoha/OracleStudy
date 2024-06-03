--회원 테이블 생성
DROP TABLE userinfo;

CREATE TABLE userinfo (
    u_id         varchar2(20),
    u_pwd        char(60)    not null, --비밀번호 암호화로 인해 60바이트로 설정
    u_name       varchar2(20)    not null,
    u_email      varchar2(40)    not null,
    u_zip_code   char(5)         not null, -- 우편번호는 도로명주소로 전환되면서 5자리 길이(char(5))로 고정
    u_addr       varchar2(100)   not null,
    u_addrdetail varchar2(100)   not null,
    u_phone      varchar2(20)    not null,
    u_regdate    date default sysdate
);

--테이블 primary key제약조건// 테이블만들때 같이 만들어도 되지만 이번에 따로 만듬
ALTER TABLE userinfo ADD CONSTRAINT pk_userinfo PRIMARY KEY(u_id);

--u_id, u_pwd, u_name, u_email, u_zip_code, u_addr, u_addrdetail, u_phone, u_regdate
--U_ID, U_PWD, U_NAME, U_EMAIL, U_ZIP_CODE, U_ADDR, U_ADDRDETAIL, U_PHONE, U_REGDATE
--제약조건 이름으로 인덱스가 만들어진다.



---24.05.23.(목)--------------------
-- [아이디 중복체크 ]
/* 
아이디가 존재하지 않으면, null
아이디가 존재하면, 결과가 아이디로 출력
*/
SELECT u_id FROM userinfo WHERE u_id = 'user01'; 

-- 더미데이터 작업
INSERT INTO userinfo(
        u_id, 
        u_pwd, 
        u_name, 
        u_email, 
        u_zip_code, 
        u_addr, 
        u_addrdetail, 
        u_phone)
VALUES(
        'user01', 
        '1234', 
        '홍길동', 
        'user01@abc.com', 
        '12345', 
        '서울시 노원구', 
        '이젠빌딩 100번지', 
        '010-1234-5678');

commit;-- 커밋을 하지 않으면 스프링에서 확인불가.

--데이터 확인
SELECT * FROM userinfo; 


----24.05.27(월)----
--아래와 같이 조건식을 쓰지 말자... 비밀번호가 60바이트로 암호화 되어있어 소용없다.
SELECT * FROM userinfo WHERE u_pwd = 'user01의 비밀번호'; 
SELECT * FROM userinfo WHERE u_pwd = '1234'; 

--아이디가 존재 : 일단 아이디가 존재하는지 알아본다.  // 위와 같이 아이디와 비밀번호를 동시에 비교하지 않는다. 저건 비밀번호 암호화가 되어있지 않아야 가능한것.
SELECT u_id, 
        u_pwd, 
        u_name, 
        u_email, 
        u_zip_code, 
        u_addr, 
        u_addrdetail, 
        u_phon
FROM 
    userinfo
WHERE u_id = 'user01';


----24.05.28(화)---혼자해보는 중---------------
UPDATE
    userinfo
SET
    u_email = #{u_email}, 
    u_zip_code = #{u_zip_code}, 
    u_addr = #{u_addr}, 
    u_addrdetail = #{u_addrdetail}, 
    u_phone = #{u_phone}
WHERE   
    u_id = #{u_id} 
    
    
    
    
    
---24.06.03(금)
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




