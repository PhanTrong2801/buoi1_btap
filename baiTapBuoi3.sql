
#cau1
#select * from employee
#cau2
#select e.employeeName,e.email from employee e join department d on e.departmentId= d.departmentId where d.departmentName='Phòng Kỹ Thuật'
#cau3
#select * from project where year(startDate) = '2024'
#cau5
#select * from department 
#cau6
#select e.employeeName,e.salary  from employee e
#cau7
#select d.departmentName, count(e.employeeId) as slNV 
#from department d left join employee e  on d.departmentId=e.departmentId group by d.departmentId, d.departmentName;
#cau8
#select * from project where endDate > '2025-01-01'
#cau9
#select * from employee where salary >'2500'
#cau10
#select * from employee where managerId IS NULL;
#cau11
SELECT 
    d.departmentId,
    d.departmentName,
    SUM(e.salary) AS totalSalary
FROM 
    Department d
LEFT JOIN 
    Employee e ON d.departmentId = e.departmentId
GROUP BY 
    d.departmentId, d.departmentName;
    
#cau12
SELECT 
    p.projectId,
    p.projectName,
    p.startDate,
    p.endDate,
    ep.assignedDate
FROM 
    EmployeeProject ep
JOIN 
    Project p ON ep.projectId = p.projectId
WHERE 
    ep.employeeId = 2;
    
    
#cau13
SELECT 
    e.employeeName,
    d.departmentName
FROM 
    Employee e
JOIN 
    Department d ON e.departmentId = d.departmentId;
    
    
#cau14
SELECT 
    e.employeeId,
    e.employeeName,
    e.salary,
    d.departmentName
FROM 
    Employee e
JOIN 
    Department d ON e.departmentId = d.departmentId
WHERE 
    e.salary = (
        SELECT MAX(e2.salary)
        FROM Employee e2
        WHERE e2.departmentId = e.departmentId
    );


#cau15
SELECT 
    e.employeeId,
    e.employeeName,
    COUNT(ep.projectId) AS projectCount
FROM 
    Employee e
JOIN 
    EmployeeProject ep ON e.employeeId = ep.employeeId
GROUP BY 
    e.employeeId, e.employeeName
HAVING 
    COUNT(ep.projectId) > 1;

#cau16
SELECT 
    p.projectId,
    p.projectName,
    COUNT(ep.employeeId) AS numberOfEmployees
FROM 
    Project p
LEFT JOIN 
    EmployeeProject ep ON p.projectId = ep.projectId
GROUP BY 
    p.projectId, p.projectName;

#cau17
SELECT 
    e.employeeName, 
    e.salary, 
    d.departmentName
FROM 
    Employee e
JOIN 
    Department d ON e.departmentId = d.departmentId
WHERE 
    d.departmentName = 'Phòng Nhân Sự'
    AND e.salary > 2000;

#cau18
SELECT 
    p.projectId, 
    p.projectName
FROM 
    Project p
LEFT JOIN 
    EmployeeProject ep ON p.projectId = ep.projectId
WHERE 
    ep.employeeId IS NULL;

#cau 19
SELECT 
    e.employeeName AS EmployeeName, 
    m.employeeName AS ManagerName
FROM 
    Employee e
LEFT JOIN 
    Employee m ON e.managerId = m.employeeId;
    
#cau20
SELECT 
    e.employeeName,
    d.departmentName
FROM 
    Employee e
JOIN 
    Department d ON e.departmentId = d.departmentId
LEFT JOIN 
    EmployeeProject ep ON e.employeeId = ep.employeeId
WHERE 
    d.departmentName = 'Phòng Marketing'
    AND ep.projectId IS NULL;

#cau21
SELECT 
    e.employeeName AS 'Tên Nhân Viên',
    p.projectName AS 'Tên Dự Án',
    ep.assignedDate AS 'Ngày Phân Công'
FROM 
    Employee e
JOIN 
    EmployeeProject ep ON e.employeeId = ep.employeeId
JOIN 
    Project p ON ep.projectId = p.projectId;

#cau22
SELECT 
    p.projectName AS 'Tên Dự Án',
    COUNT(ep.employeeId) AS 'Số Lượng Nhân Viên'
FROM 
    Project p
JOIN 
    EmployeeProject ep ON p.projectId = ep.projectId
GROUP BY 
    p.projectId
HAVING 
    COUNT(ep.employeeId) >= 3;

#cau23
SELECT 
    e.employeeName AS 'Tên Nhân Viên'
FROM 
    Employee e
JOIN 
    EmployeeProject ep ON e.employeeId = ep.employeeId
JOIN 
    Project p ON ep.projectId = p.projectId
WHERE 
    p.projectName IN ('Dự án A''Dự án E')
GROUP BY 
    e.employeeId
HAVING 
    COUNT(DISTINCT p.projectId) = 2;

#cau24
SELECT 
    e.employeeName AS 'Tên Nhân Viên'
FROM 
    Employee e
JOIN 
    Employee b ON e.managerId = b.employeeId
WHERE 
    b.employeeName = 'Bob';


#cau25
SELECT 
    d.departmentName AS 'Tên Phòng Ban',
    AVG(e.salary) AS 'Mức Lương Trung Bình'
FROM 
    Department d
JOIN 
    Employee e ON d.departmentId = e.departmentId
GROUP BY 
    d.departmentId
HAVING 
    COUNT(e.employeeId) > 1;

#cau26
SELECT 
    e.employeeName AS 'Tên Nhân Viên', 
    e.salary AS 'Mức Lương'
FROM 
    Employee e
WHERE 
    e.salary = (SELECT MAX(salary) FROM Employee)
    AND e.employeeId NOT IN (SELECT DISTINCT managerId FROM Employee WHERE managerId IS NOT NULL);


#cau27
SELECT DISTINCT 
    p.projectName AS 'Dự Án D'
FROM 
    Project p
JOIN 
    EmployeeProject ep ON p.projectId = ep.projectId
JOIN 
    Employee e ON ep.employeeId = e.employeeId
JOIN 
    Department d ON e.departmentId = d.departmentId
WHERE 
    d.departmentName = 'Phòng Kỹ Thuật';

#cau 29
SELECT 
    e.employeeName AS 'Tên Nhân Viên', 
    p.projectName AS 'Tên Dự Án', 
    ep.assignedDate AS 'Ngày Phân Công'
FROM 
    Employee e
JOIN 
    EmployeeProject ep ON e.employeeId = ep.employeeId
JOIN 
    Project p ON ep.projectId = p.projectId
WHERE 
    ep.assignedDate < e.hireDate;

#cau30
SELECT 
    p.projectName AS 'Tên Dự Án'
FROM 
    Project p
JOIN 
    EmployeeProject ep ON p.projectId = ep.projectId
JOIN 
    Employee e ON ep.employeeId = e.employeeId
WHERE 
    p.endDate > CURDATE() 
GROUP BY 
    p.projectId
HAVING 
    COUNT(ep.employeeId) < 3;  


