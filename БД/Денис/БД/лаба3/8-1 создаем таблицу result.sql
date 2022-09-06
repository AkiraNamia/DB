CREATE Table RESULTS
(
ID int primary key identity(1,1),
STUDENT_NAME nvarchar(20),
MARK1 int,
MARK2 int,
MARK3 int,
AVER_VALUE as ((MARK1 + MARK2 + MARK3)/3)
)