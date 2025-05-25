use join_task

-- Company table
CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY,
    Name VARCHAR(100),
    Industry VARCHAR(50),
    City VARCHAR(50)
);

-- Job Seekers
CREATE TABLE JobSeekers (
    SeekerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    ExperienceYears INT,
    City VARCHAR(50)
);

-- Job Postings
CREATE TABLE Jobs (
    JobID INT PRIMARY KEY,
    Title VARCHAR(100),
    CompanyID INT,
    Salary DECIMAL(10, 2),
    Location VARCHAR(50),
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);

-- Applications
CREATE TABLE Applications (
    AppID INT PRIMARY KEY,
    JobID INT,
    SeekerID INT,
    ApplicationDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
    FOREIGN KEY (SeekerID) REFERENCES JobSeekers(SeekerID)
);


-- Companies
INSERT INTO Companies VALUES
(1, 'TechWave', 'IT', 'Muscat'),
(2, 'GreenEnergy', 'Energy', 'Sohar'),
(3, 'EduBridge', 'Education', 'Salalah');

-- Job Seekers
INSERT INTO JobSeekers VALUES
(101, 'Sara Al Busaidi', 'sara.b@example.com', 2, 'Muscat'),
(102, 'Ahmed Al Hinai', 'ahmed.h@example.com', 5, 'Nizwa'),
(103, 'Mona Al Zadjali', 'mona.z@example.com', 1, 'Salalah'),
(104, 'Hassan Al Lawati', 'hassan.l@example.com', 3, 'Muscat');

-- Jobs
INSERT INTO Jobs VALUES
(201, 'Software Developer', 1, 900, 'Muscat'),
(202, 'Data Analyst', 1, 800, 'Muscat'),
(203, 'Science Teacher', 3, 700, 'Salalah'),
(204, 'Field Engineer', 2, 950, 'Sohar');

-- Applications
INSERT INTO Applications VALUES
(301, 201, 101, '2025-05-01', 'Pending'),
(302, 202, 104, '2025-05-02', 'Shortlisted'),
(303, 203, 103, '2025-05-03', 'Rejected'),
(304, 204, 102, '2025-05-04', 'Pending');

-- joun tasks

-- Task 1 – “Who Got What?”
select FullName , Title , Name
from JobSeekers JSs , Jobs J, Companies C, Applications A
where JSs.SeekerID = A.SeekerID AND J.JobID = A.JobID AND C.CompanyID = J.CompanyID

-- Task 2 – “Empty Chairs”
select Title AS JopTitle , Name as CompanyName
from Jobs J left join Applications A
on J.JobID = A.JobID 
left join Companies C on C.CompanyID = J.CompanyID

-- Task 3 – “Who Lives Where They Work?”
select FullName , Title , City
from JobSeekers JSs , Jobs J, Applications A
where JSs.SeekerID = A.SeekerID AND J.JobID = A.JobID AND JSs.City = J.Location

-- Task 4 – “All Seekers with or without Applications” 
select FullName as seeker , Title as job , Status as applyStatus
from JobSeekers JSs left join Applications A on JSs.SeekerID = A.SeekerID
left join Jobs J on A.JobID = J.JobID

-- Task 5 – “Job Posting Visibility”
select Title as jobTitle , FullName as jobSeeker
from Jobs J left join Applications A on J.JobID = A.JobID
left join JobSeekers JSs on A.SeekerID = JSs.SeekerID

-- Task 6 – “Ghost Seekers” 
select FullName as seeker , Email
from JobSeekers JSs left join Applications A on JSs.SeekerID = A.SeekerID
where A.AppID IS NULL

-- Task 7 – “Vacant Companies”
select Name AS COMPANYNAME
from Companies C left join Jobs J on C.CompanyID = J.CompanyID
where J.JobID IS NULL

-- Task 8 – “Same City, Different People” 
select JS1.FullName as seeker1 , JS2.FullName as seeker2 , JS1.City as Shared_City
from JobSeekers JS1 join JobSeekers JS2 
on JS1.City = JS2.City AND JS1.SeekerID <> JS2.SeekerID

--Task 9 – “High Salary, Wrong City”
select FullName
from JobSeekers JSs join Applications A on JSs.SeekerID = A.SeekerID 
join Jobs J on A.JobID = J.JobID  
where salary > 850 AND JSs.City <> J.Location

-- Task 10 – “Unmatched Applications” 
select FullName , City , Location
from JobSeekers JSs join Applications A on JSs.SeekerID = A.SeekerID 
join Jobs J on A.JobID = J.JobID

-- Task 11 – “Jobs With No Applicants” 
SELECT J.Title AS Job_Title
FROM Jobs J LEFT JOIN Applications A ON J.JobID = A.JobID
WHERE A.AppID IS NULL;