
create database `survey_system` 
DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
use `survey_system`;

CREATE TABLE Users
(userId INT PRIMARY KEY AUTO_INCREMENT, 
userName NVARCHAR(40), 
userPassword NVARCHAR(40), 
userMail NVARCHAR(40), 
userReg DATETIME, 
userRole INT);

INSERT INTO Users VALUES
(NULL, 'admin', 'admin', 'admin@zju.edu.cn', '2020-05-03 17:56:12', '0');

CREATE TABLE Papers
(paperId INT PRIMARY KEY AUTO_INCREMENT, 
 userId INT, 
 paperTitle NVARCHAR(100), 
 paperSummary NVARCHAR(300),
 paperStartDate DATETIME, 
 paperEndDate DATETIME, 
 paperType INT, 
 paperFilltimes INT, 
 paperPeriod INT, 
 paperCount INT);
 
 INSERT INTO Papers VALUES
 (NULL, '1', 'Admin Paper', 'Paper Summary', '2020-05-03 18:00:00', '2020-06-03 18:00:00', '1', '10', '30', '0');
 
 CREATE TABLE Questions
 (qstId INT PRIMARY KEY AUTO_INCREMENT,
  paperId INT, 
  qstType INT, 
  qstTitle NVARCHAR(100),
  qstOption NVARCHAR(1000), 
  qstAnswer NVARCHAR(1000),
  cascade_single varchar(20),
  QsTSetTime DateTime
  );
 
 INSERT INTO Questions VALUES
 (NULL, '1', '1', 'Admin Question', 'A:1#B:2#C:3#D:4', '0&0&0&0');
 
CREATE TABLE NonRegUsers
 (userIP NVARCHAR(50) PRIMARY KEY);
 
 CREATE TABLE PaperUserRelationship
 (relationId INT PRIMARY KEY AUTO_INCREMENT,
  paperId INT, 
  userIP NVARCHAR(50), 
  filltimes INT,
  paperLastFillDate DATETIME);
 
 
