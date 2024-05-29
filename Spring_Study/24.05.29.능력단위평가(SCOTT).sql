--1.

CREATE TABLE orcleTest (
    UserID      varchar2(10) NOT NULL PRIMARY KEY, 
    Passwd      varchar2(10) NOT NULL,   
    Name        varchar2(10) NOT NULL,    
    Regist_NO   varchar2(14) NOT NULL UNIQUE,   
    Email       varchar2(20),   
    Telephone   varchar2(13) NOT NULL,
    Address     varchar2(40),
    Buycash     NUMBER(8) default 0,   
    TimeStamp   date default sysdate
);



--2. 
CREATE TABLE orcleTestProduct (
    Product_Code  varchar2(10) NOT NULL PRIMARY KEY, 
    Product_Name  varchar2(20) NOT NULL,   
    Standard      varchar2(20),    
    Unit          varchar2(10),   
    Unit_Price    NUMBER(7) NOT NULL,   
    Left_Qty      NUMBER(5) NOT NULL,
    Company       varchar2(20),
    ImageName     varchar2(20),   
    Info          varchar2(50),   
    Datail_info   varchar2(255)
);



--3.
CREATE TABLE orcleTestOrder (
    Order_NO      varchar2(10) NOT NULL PRIMARY KEY, 
    Order_ID      varchar2(20) NOT NULL,
    Product_Code  varchar2(20) NOT NULL,    
    Order_Qty     NUMBER(10)   NOT NULL,   
    Order_Date    date         default sysdate,
    FOREIGN KEY(Order_ID) REFERENCES orcleTest(UserID),
    FOREIGN KEY(Product_Code) REFERENCES orcleTestProduct(Product_Code)
);


--4. 급여가 3000이상, 5000이하인 사원의 이름, 급여 출력
SELECT ename, sal FROM emp WHERE sal >=3000 AND sal <= 5000;

--5. 각 부서별 평균 급여를 구하세요. 소수 둘째자리 반올림 표현
SELECT ROUND(AVG(sal),2) FROM emp GROUP BY job;

--6. 모든 사원의 급여를 10%인상한 사원의 이름, 급여를 출력
SELECT ename, sal*1.1 FROM emp;

--7. JOB이 SALESMAN인 사원들의 급여(급여+ 커미션 포함)의 합계를 구하세요.
SELECT SUM(SAL+COMM) FROM EMP WHERE job='SALESMAN';
