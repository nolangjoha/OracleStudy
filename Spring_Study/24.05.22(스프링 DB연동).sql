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
    
    
    
    
    
---24.06.03(��)
--[ī�װ� ���̺� ����] 
CREATE TABLE category(
    c_code  number        primary key,
    c_name  varchar2(30)  not null,  
    c_pcode number        null --foreign key�������� ������ ���ص� ������, �� �ǹ̿� �ش��Ѵ�. 
                               -- ����Ű ������ ���� null�� ���ش�.
);

--ī�װ� �����, ����,������ ����

-- [ī�װ� ���ñ��]

--���̵�����
--1�� ī�װ� ���(c_pcode�÷��� ���� NULL�� Ư¡
INSERT INTO category(c_code, c_name, c_pcode) VALUES(1, 'TOP', NULL);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(2, 'SHIRTS', NULL);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(3, 'PANTS', NULL);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(4, 'OUTER', NULL);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(5, 'SHOES' || '&' ||'BAG', NULL);  --Ư������&������ ���� &amp; ���ؾ� ��� �� �� �ִ�.

-- TOP
INSERT INTO category(c_code, c_name, c_pcode) VALUES(6, '������' || '&' ||'�ĵ�Ƽ', 1);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(7, '��Ʈ', 1);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(8, '����Ƽ', 1);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(9, '����Ƽ', 1);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(10, '����', 1);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(11, '������Ƽ', 1);
--SHIRTS
INSERT INTO category(c_code, c_name, c_pcode) VALUES(12, '������', 2);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(13, 'û����', 2);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(14, 'üũ' || '&' ||'����', 2);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(15, '��Ʈ������', 2);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(16, '���' || '&' ||'���̳�', 2);
--PANTS
INSERT INTO category(c_code, c_name, c_pcode) VALUES(17, '������', 3);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(18, '�����', 3);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(19, 'û����', 3);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(20, '�������', 3);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(21, '�ݹ���', 3);
--OUTER
INSERT INTO category(c_code, c_name, c_pcode) VALUES(22, '�е�', 4);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(23, '�ڵ�', 4);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(24, '��Ʈ' || '&' ||'������', 4);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(25, '����', 4);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(26, '�����/MA-1', 4);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(27, '�����' || '&' ||'����', 4);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(28, '�ĵ�' || '&' ||'����', 4);
--SHOES
INSERT INTO category(c_code, c_name, c_pcode) VALUES(29, '�Ź�', 5);
INSERT INTO category(c_code, c_name, c_pcode) VALUES(30, '����', 5);

-- ī�װ� �ڵ�� ���߿� �������� ó���� ����.

COMMIT; --���������� ����� ����� �������� �� Ŀ��
--Ȯ��
select * from category;


-- 1�� ī�װ� ���
SELECT c_code, c_name, c_pcode From category WHERE c_pcode IS NULL;

--2�� ī�װ� ���  // c_code�� c_pcode�� �� �����ϱ�
SELECT c_code, c_name, c_pcode From category WHERE c_pcode = 1;




