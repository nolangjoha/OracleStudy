CREATE USER spring IDENTIFIED BY 1234
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP;
    
GRANT connect, resource, dba to spring;