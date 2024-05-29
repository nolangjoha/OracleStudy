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
