SELECT
    employee_id,
    emp_name,
    email,
    phone_number,
    hire_date,
    salary,
    manager_id,
    commission_pct,
    retire_date,
    department_id,
    job_id,
    create_date,
    update_date
FROM
    employees;
    

DESC employees;

SELECT
    employee_id,
    emp_name,
    email,
    phone_number,
    hire_date,
    salary,
    manager_id,
    commission_pct,
    retire_date,
    department_id,
    job_id,
    create_date,
    update_date
FROM
    employees
WHERE ROWNUM <= 10;
