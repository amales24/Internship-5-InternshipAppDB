---Creating tables---

CREATE TABLE City(
	CityId SERIAL PRIMARY KEY,
	Name VARCHAR(20) NOT NULL UNIQUE
)
---

CREATE TABLE Member(
	MemberId SERIAL PRIMARY KEY,
	Name VARCHAR(20) NOT NULL,
	Surname VARCHAR(20) NOT NULL,
	Pin VARCHAR(11) UNIQUE,
	DateOfBirth TIMESTAMP,
	Gender VARCHAR(1) CHECK (Gender IN ('M', 'F')),
	CityId INT REFERENCES City(CityId) ON DELETE SET NULL
)

---
ALTER TABLE Member
	ADD CONSTRAINT PinLength CHECK(LENGTH(Pin) = 11)
---

CREATE TABLE Intern(
	InternId SERIAL PRIMARY KEY,
	Name VARCHAR(20) NOT NULL,
	Surname VARCHAR(20) NOT NULL,
	Pin VARCHAR(11) UNIQUE,
	DateOfBirth TIMESTAMP,
	Gender VARCHAR(1) CHECK (Gender IN ('M', 'F')),
	CityId INT REFERENCES City(CityId) ON DELETE SET NULL
)

---
ALTER TABLE Intern
	ADD CONSTRAINT PinLength CHECK(LENGTH(Pin) = 11)
---

CREATE TABLE Field(
	FieldId SERIAL PRIMARY KEY,
	Name VARCHAR(20) NOT NULL UNIQUE
)

---
CREATE TABLE Internship(
	InternshipId SERIAL PRIMARY KEY,
	StartDate TIMESTAMP,
	EndDate TIMESTAMP,
	Phase VARCHAR(6) CHECK (Phase IN ('Future', 'Active', 'Ended')),
	ManagerId INT REFERENCES Member(MemberId) ON DELETE SET NULL
)

---
ALTER TABLE Internship
	ADD CONSTRAINT EndDateAfterStartDate CHECK (EndDate > Startdate)
---

CREATE TABLE InternshipField(
	Id SERIAL PRIMARY KEY,
	InternshipId INT REFERENCES Internship(InternshipId),
	FieldId INT REFERENCES Field(FieldId),
	ManagerId INT REFERENCES Member(MemberId) ON DELETE SET NULL
)

---
ALTER TABLE InternshipField
	ADD CONSTRAINT UniqueFieldPerInternship UNIQUE(InternshipId, FieldId)
---

CREATE TABLE InternInternshipField(
	InternId INT REFERENCES Intern(InternId),
	InternshipFieldId INT REFERENCES InternshipField(Id),
	Status VARCHAR(8) CHECK (Status IN ('Intern', 'Finished', 'Kicked')),
	PRIMARY KEY (InternId, InternshipFieldId)
)
---

ALTER TABLE InternInternshipField
   DROP CONSTRAINT interninternshipfield_internid_fkey,
   ADD  CONSTRAINT interninternshipfield_internid_fkey
   FOREIGN KEY (InternId) REFERENCES Intern (InternId) ON DELETE CASCADE,
   
   DROP CONSTRAINT interninternshipfield_internshipfieldid_fkey,
   ADD  CONSTRAINT interninternshipfield_internshipfieldid_fkey
   FOREIGN KEY (InternshipFieldId) REFERENCES InternshipField (Id) ON DELETE CASCADE;

---
CREATE TABLE MemberInternshipField(
	MemberId INT REFERENCES Member(MemberId),
	InternshipFieldId INT REFERENCES InternshipField(id),
	PRIMARY KEY (MemberId, InternshipFieldId)
)

---
ALTER TABLE MemberInternshipField
   DROP CONSTRAINT memberinternshipfield_memberid_fkey,
   ADD  CONSTRAINT memberinternshipfield_memberid_fkey
   FOREIGN KEY (MemberId) REFERENCES Member (MemberId) ON DELETE CASCADE;
   
ALTER TABLE MemberInternshipField
   DROP CONSTRAINT memberinternshipfield_internshipfieldid_fkey,
   ADD  CONSTRAINT memberinternshipfield_internshipfieldid_fkey
   FOREIGN KEY (InternshipFieldId) REFERENCES InternshipField (Id) ON DELETE CASCADE;

---
CREATE TABLE Homework(
	HomeworkId SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL,
	InternshipFieldId INT REFERENCES InternshipField(id) ON DELETE SET NULL
)

---
CREATE TABLE InternHomework(
	InternId INT REFERENCES Intern(InternId),
	HomeworkId INT REFERENCES Homework(HomeworkId),
	Grade INT CHECK (Grade IN (1, 2, 3, 4, 5)),
	RectifierId INT REFERENCES Member(MemberId) ON DELETE SET NULL,
	PRIMARY KEY (InternId, HomeworkId)
)

ALTER TABLE InternHomework
   DROP CONSTRAINT internhomework_internid_fkey,
   ADD  CONSTRAINT internhomework_internid_fkey
   FOREIGN KEY (InternId) REFERENCES Intern (InternId) ON DELETE CASCADE,
   
   DROP CONSTRAINT internhomework_homeworkid_fkey,
   ADD  CONSTRAINT internhomework_homeworkid_fkey
   FOREIGN KEY (HomeworkId) REFERENCES Homework (HomeworkId) ON DELETE CASCADE;

---Adding data to tables---

INSERT INTO Field(Name) VALUES
('Dev'),
('Multimedija'),
('Marketing'),
('Dizajn')

INSERT INTO City(Name) VALUES
('Split'),
('Zagreb'),
('Moskva'),
('Zadar')

INSERT INTO Member(Name, Surname, Pin, DateOfBirth, Gender, CityId) VALUES
('Ante', 'Antić', '12345678901', '1995-1-1', 'M', 1),
('Maja', 'Majić', '12345678902', '1996-2-1', 'F', 1),
('Iva', 'Ivić', '12345678903', '1998-12-31', 'F', 2),
('Marija', 'Karin', '12345678904', '2000-1-21', 'F', 4),
('Ivan', 'Pavičin', '12345678905', '1999-12-3', 'M', 4),
('Filip', 'Filipović', '12345678906', '2000-4-8', 'M', 1),
('Mario', 'Maretić', '12345678907', '1998-6-17', 'M', 2),
('Sanja', 'Sanjin', '12345678908', '1999-8-14', 'F', 4),
('Lucija', 'Lukić', '12345678909', '2001-3-23', 'F', 4),
('Ivo', 'Višić', '12345678900', '1997-5-23', 'M', 1)

INSERT INTO Intern(Name, Surname, Pin, DateOfBirth, Gender, CityId) VALUES
('Ana', 'Anić', '12345678911', '2000-2-1', 'F', 1),
('Mate', 'Matić', '12345678912', '2001-12-12', 'M', 2),
('Stipe', 'Stipić', '12345678913', '2001-12-30', 'M', 4),
('Luka', 'Lukić', '12345678914', '2000-4-21', 'M', 1),
('Josipa', 'Lujić', '12345678915', '2003-2-3', 'F', 1),
('Ivana', 'Janić', '12345678916', '2002-5-8', 'F', 4),
('Jana', 'Janović', '12345678917', '1999-5-17', 'F', 2),
('Vanja', 'Anjić', '12345678918', '1999-7-17', 'F', 4),
('Ivan', 'Ivić', '12345678919', '2004-8-23', 'M', 1),
('Ante', 'Lukić', '12345678910', '2000-8-21', 'M', 1),
('Luka', 'Antić', '22345678910', '2001-9-27', 'M', 2),
('Andrea', 'Radić', '32345678910', '2000-10-2', 'F', 4)

INSERT INTO Internship(StartDate, EndDate, Phase, ManagerId) VALUES
('2021-10-15', '2022-5-17', 'Ended', 1),
('2020-10-12', '2021-5-10', 'Ended', 2),
('2022-11-5', '2023-5-2', 'Active', 10),
('2023-11-2', '2024-5-4', 'Future', 5)

SELECT * FROM Field
SELECT * FROM City
SELECT * FROM Member
SELECT * FROM Intern
SELECT * FROM Internship

INSERT INTO InternshipField (InternshipId, FieldId, ManagerId) VALUES
(1, 1, 1),
(1, 2, 3),
(1, 3, 9),
(1, 4, 4),
(2, 1, 1),
(2, 2, 3),
(2, 3, 9),
(2, 4, 4),
(3, 1, 2),
(3, 2, 8),
(3, 3, 5),
(3, 4, 4),
(4, 1, 6),
(4, 2, 8),
(4, 3, 5),
(4, 4, 4)

SELECT * FROM InternshipField

INSERT INTO InternInternshipField(InternId, InternshipFieldId, Status) VALUES
(1, 1, 'Finished'),
(2, 2, 'Finished'),
(3, 3, 'Kicked'),
(4, 11, 'Intern'),
(5, 9, 'Kicked'),
(6, 12, 'Intern'),
(7, 9, 'Intern'),
(8, 8, 'Finished'),
(9, 7, 'Kicked'),
(10, 3, 'Finished'),
(11, 10, 'Intern'),
(12, 5, 'Finished')

INSERT INTO MemberInternshipField(MemberId, InternshipFieldId) VALUES
(1, 1),
(1, 5),
(2, 5),
(2, 9),
(3, 2),
(3, 6),
(4, 4),
(4, 8),
(4, 12),
(4, 16),
(5, 11),
(5, 15),
(6, 9),
(6, 13),
(7, 1),
(7, 5),
(8, 10),
(8, 14),
(9, 3),
(9, 7),
(10, 11)

INSERT INTO Homework (Name, InternshipFieldId) VALUES
('OOP-CryptoWallet', 9),
('OOP-MailCalendar', 9),
('C-Sharp-WorldChampionship', 9),
('Multimedija-domaci-1', 10),
('Multimedija-domaci-2', 10),
('Multimedija-domaci-3', 10),
('Marketing-domaci-1', 11),
('Marketing-domaci-2', 11),
('Marketing-domaci-3', 11),
('Dizajn-domaci-1', 12),
('Dizajn-domaci-2', 12),
('Dizajn-domaci-3', 12)

SELECT * FROM Homework

INSERT INTO InternHomework(InternId, HomeworkId, Grade, RectifierId) VALUES
(5, 1, 5, 2),
(5, 2, 4, 2),
(5, 3, 5, 6),
(7, 1, 1, 2),
(7, 2, 2, 6),
(7, 3, 1, 6),
(4, 7, 2, 10),
(4, 8, 2, 5),
(4, 9, 2, 5),
(11, 4, 3, 8),
(11, 5, 4, 8),
(11, 6, 3, 8),
(6, 10, 5, 4),
(6, 11, 3, 4),
(6, 12, 4, 4)

---QUERIES---

---1---
SELECT m.Name, m.Surname as City FROM Member m WHERE
(SELECT c.Name FROM City c WHERE c.CityId = m.CityId) NOT LIKE 'Split'

---2---
SELECT i.StartDate, i.EndDate FROM Internship i 
ORDER BY i.StartDate DESC

---3---
SELECT i.Name, i.Surname FROM Intern i
JOIN InternInternshipField iif ON iif.InternId = i.InternId
JOIN InternshipField ifi ON ifi.Id = iif.InternshipFieldId
JOIN Internship ish ON ish.InternshipId = ifi.InternshipId
WHERE DATE_PART('year',ish.StartDate) = 2021

---4---
SELECT COUNT(*) AS No_Dev_Female_Interns_2022 FROM Intern i
JOIN InternInternshipField iif ON iif.InternId = i.InternId
JOIN InternshipField ifi ON ifi.Id = iif.InternshipFieldId
JOIN Internship ish ON ish.InternshipId = ifi.InternshipId
JOIN Field f ON f.FieldId = ifi.FieldId
WHERE DATE_PART('year',ish.StartDate) = 2022 AND i.Gender = 'F' AND f.Name = 'Dev'

---5---
SELECT COUNT(*) AS No_Kicked_Marketing_Interns FROM Intern i
JOIN InternInternshipField iif ON iif.InternId = i.InternId
JOIN InternshipField ifi ON ifi.Id = iif.InternshipFieldId
JOIN Field f ON f.FieldId = ifi.FieldId
WHERE f.Name = 'Marketing' AND iif.Status = 'Kicked'

---6---
UPDATE Member 
	SET CityId = (SELECT c.CityId FROM City c WHERE c.Name = 'Moskva')
	WHERE Surname LIKE '%in'
	
SELECT * FROM Member

---7---
DELETE FROM Member 
	WHERE (DATE_PART('year', AGE(NOW(), DateOfBirth))) >= 25

SELECT * FROM Member --check if selected members are deleted
SELECT * FROM Internship --check if references to them are set to null
SELECT * FROM MemberInternshipField --check if data about their internship and fields are deleted

---8---

	






