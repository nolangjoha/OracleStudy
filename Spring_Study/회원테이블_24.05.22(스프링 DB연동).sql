--ȸ�� ���̺� ����
DROP TABLE userinfo;

CREATE TABLE userinfo (
    u_id         varchar2(20),
    u_pwd        char(60)    not null, --��й�ȣ ��ȣȭ�� ���� 60����Ʈ�� ����
    u_name       varchar2(20)    not null,
    u_email      varchar2(40)    not null,
    u_zip_code   char(5)         not null, -- �����ȣ�� ���θ��ּҷ� ��ȯ�Ǹ鼭 5�ڸ� ����(char(5))�� ����
    u_addr       varchar2(100)   not null,
    u_addrdetail varchar2(100)   not null,
    u_phone      varchar2(20)    not null,
    u_regdate    date default sysdate
);

--���̺� primary key��������// ���̺��鶧 ���� ���� ������ �̹��� ���� ����
ALTER TABLE userinfo ADD CONSTRAINT pk_userinfo PRIMARY KEY(u_id);

--u_id, u_pwd, u_name, u_email, u_zip_code, u_addr, u_addrdetail, u_phone, u_regdate
--U_ID, U_PWD, U_NAME, U_EMAIL, U_ZIP_CODE, U_ADDR, U_ADDRDETAIL, U_PHONE, U_REGDATE
--�������� �̸����� �ε����� ���������.



---24.05.23.(��)--------------------
-- [���̵� �ߺ�üũ ]
/* 
���̵� �������� ������, null
���̵� �����ϸ�, ����� ���̵�� ���
*/
SELECT u_id FROM userinfo WHERE u_id = 'user01'; 

-- ���̵����� �۾�
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
        'ȫ�浿', 
        'user01@abc.com', 
        '12345', 
        '����� �����', 
        '�������� 100����', 
        '010-1234-5678');

commit;-- Ŀ���� ���� ������ ���������� Ȯ�κҰ�.

--������ Ȯ��
SELECT * FROM userinfo; 


----24.05.27(��)----
--�Ʒ��� ���� ���ǽ��� ���� ����... ��й�ȣ�� 60����Ʈ�� ��ȣȭ �Ǿ��־� �ҿ����.
SELECT * FROM userinfo WHERE u_pwd = 'user01�� ��й�ȣ'; 
SELECT * FROM userinfo WHERE u_pwd = '1234'; 

--���̵� ���� : �ϴ� ���̵� �����ϴ��� �˾ƺ���.  // ���� ���� ���̵�� ��й�ȣ�� ���ÿ� ������ �ʴ´�. ���� ��й�ȣ ��ȣȭ�� �Ǿ����� �ʾƾ� �����Ѱ�.
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


----24.05.28(ȭ)---ȥ���غ��� ��---------------
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
