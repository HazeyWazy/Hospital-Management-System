CREATE Table PatientType
(
	PatientTypeID varchar(10) not null,
	TypeName varchar(20) not null,
	Primary Key(PatientTypeID),
	Check(PatientTypeID in ('IP','OP','EP')),
	Check(TypeName in ('Inpatient','Outpatient','Emergency Patient'))
);

SELECT * FROM PatientType;

CREATE Table Patient
(
	PatientID varchar(10) not null,
	FirstName varchar(30),
	LastName varchar(30),
	Gender varchar(10),
	Age integer,
	MaritalStatus varchar(10),
	Address varchar(100),
	Phone varchar(15),
	Email varchar(50),
	Guardian varchar(50),
	PatientTypeID varchar(10),
	Primary Key(PatientID),
	Foreign Key(PatientTypeID) references PatientType(PatientTypeID),
	Check (PatientID like ('P%')),
	Check (Gender in ('Male','Female')),
	Check (MaritalStatus in ('Single','Married','Divorced','Widowed'))
);

SELECT * FROM Patient;

CREATE Table Doctor
(
	DocID varchar(10) not null,
	DocName varchar(80),
	Specialization varchar(30),
	ConsultantFees decimal(10,2),
	AvailableTime varchar(50),
	Primary Key(DocID),
	Check (DocID like ('D%'))
);

SELECT * FROM Doctor;

CREATE Table Appointment
(
	ApptID varchar(10) not null,
	ApptDate date,
	PatientID varchar(10),
	DocID varchar(10),
	Primary Key(ApptID),
	Foreign Key(PatientID) references Patient(PatientID),
	Foreign Key(DocID) references Doctor(DocID)
	On delete no action
	On update cascade,
	Check (ApptID like ('Appt%'))
);

SELECT * FROM Appointment;

CREATE Table Nurse
(
	NurseID varchar(10) not null,
	NurseName varchar(50),
	Primary Key(NurseID),
	Check (NurseID like ('N%'))
);

SELECT * FROM Nurse;

CREATE Table RoomType
(
	RoomType varchar(20) not null,
	Cost decimal(10,2),
	Primary Key(RoomType)
);

SELECT * FROM RoomType;

CREATE Table Room
(
	RoomNo varchar(10) not null,
	RoomType varchar(20),
	NurseID varchar(10),
	Primary Key(RoomNo),
	Foreign Key(RoomType) references RoomType(RoomType),
	Foreign Key(NurseID) references Nurse(NurseID)
	On delete set null
	On update cascade,
	Check (RoomNo like ('R%'))
);

SELECT * FROM Room;

CREATE Table Admission
(
	AdmID varchar(10) not null,
	AdmDate date,
	PatientID varchar(10),
	DocID varchar(10),
	RoomNo varchar(10),
	Primary Key(AdmID),
	Foreign Key(PatientID) references Patient(PatientID),
	Foreign Key(RoomNo) references Room(RoomNo),
	Foreign Key(DocID) references Doctor(DocID)
	On delete no action
	On update cascade,
	Check (AdmID like ('Adm%'))
);

SELECT * FROM Admission;

CREATE Table Specialist
(
	SpecialistID varchar(10) not null,
	SpecialistName varchar(80),
	Primary Key(SpecialistID),
	Check (SpecialistID like ('S%'))
);

SELECT * FROM Specialist;

CREATE Table Test
(
	TestID varchar(10) not null,
	TestName varchar(80),
	Cost decimal(10,2),
	Primary Key(TestID)
);

SELECT * FROM Test;

CREATE Table TestResult
(
	TestResultID varchar(10) not null,
	SpecialistID varchar(10),
	PatientID varchar(10),
	TestID varchar(10),
	Primary Key(TestResultID),
	Foreign Key(PatientID) references Patient(PatientID),
	Foreign Key(TestID) references Test(TestID),
	Foreign Key(SpecialistID) references Specialist(SpecialistID)
	On delete no action
	On update cascade,
	Check (TestResultID like ('T%'))
);

SELECT * FROM TestResult;

CREATE Table Medicine
(
	MedID varchar(10) not null,
	MedName varchar(50),
	Cost decimal(10,2),
	Primary Key(MedID),
	Check (MedID like ('M%'))
);

SELECT * FROM Medicine;

CREATE Table Treatment
(
	TreatmentID varchar(10) not null,
	PatientID varchar(10),
	DocID varchar(10),
	MedID varchar(10),
	Quantity integer,
	Primary Key(TreatmentID),
	Check (TreatmentID like ('TM%')),
	Foreign Key(PatientID) references Patient(PatientID),
	Foreign Key(MedID) references Medicine(MedID),
	Foreign Key(DocID) references Doctor(DocID)
	On delete no action
	On update cascade
);

SELECT * FROM Treatment;

----------------------------------------------------------------------------------------------------------------------

INSERT into PatientType(PatientTypeID,TypeName)
VALUES('IP','Inpatient');

INSERT into PatientType(PatientTypeID,TypeName)
VALUES('OP','Outpatient');

INSERT into PatientType(PatientTypeID,TypeName)
VALUES('EP','Emergency Patient');

SELECT * FROM PatientType;

INSERT into Patient(PatientID,FirstName,LastName,Gender,Age,MaritalStatus,Address,Phone,Email,Guardian,PatientTypeID)
VALUES('P0001','James','Smith','Male',68,'Married','Insein, Yangon',09254012356,'jamessmith@gmail.com','Ricky Smith','IP');

INSERT into Patient(PatientID,FirstName,LastName,Gender,Age,MaritalStatus,Address,Phone,Email,Guardian,PatientTypeID)
VALUES('P0002','Mark','Peterson','Male',66,'Widowed','Hlaing, Yangon',09254053636,'markpeterson@gmail.com','Elle Peterson','IP');

INSERT into Patient(PatientID,FirstName,LastName,Gender,Age,MaritalStatus,Address,Phone,Email,Guardian,PatientTypeID)
VALUES('P0003','Jimmy','Alexander','Male',33,'Single','Mayangon, Yangon',09254137789,'jimmyalexander@gmail.com','Daniel Alexander','EP');

INSERT into Patient(PatientID,FirstName,LastName,Gender,Age,MaritalStatus,Address,Phone,Email,Guardian,PatientTypeID)
VALUES('P0004','Samuel','Cardoza','Male',25,'Single','Kamayut, Yangon',09780077894,'samuelcardoza@gmail.com','Heredia Cardoza','OP');

INSERT into Patient(PatientID,FirstName,LastName,Gender,Age,MaritalStatus,Address,Phone,Email,Guardian,PatientTypeID)
VALUES('P0005','Edward','Jones','Male',44,'Divorced','Bahan, Yangon',09789451245,'edwardjones@gmail.com','Amanda Jones','IP');

INSERT into Patient(PatientID,FirstName,LastName,Gender,Age,MaritalStatus,Address,Phone,Email,Guardian,PatientTypeID)
VALUES('P0006','David','Menkin','Male',45,'Single','Kyauktada, Yangon',09773315624,'davidmenkin@gmail.com','Gordon Menkin','IP');

INSERT into Patient(PatientID,FirstName,LastName,Gender,Age,MaritalStatus,Address,Phone,Email,Guardian,PatientTypeID)
VALUES('P0007','Ashley','Burch','Female',39,'Widowed','Pabedan, Yangon',0973045515,'ashleyburch@gmail.com','Paul Fetzer','OP');

INSERT into Patient(PatientID,FirstName,LastName,Gender,Age,MaritalStatus,Address,Phone,Email,Guardian,PatientTypeID)
VALUES('P0008','Carolina','Ravassa','Female',36,'Married','Ahlone, Yangon',09779485216,'carolinaravassa@gmail.com','Sombra Ravassa','IP');

INSERT into Patient(PatientID,FirstName,LastName,Gender,Age,MaritalStatus,Address,Phone,Email,Guardian,PatientTypeID)
VALUES('P0009','Shannon','Williams','Female',23,'Single','Dagon, Yangon',09254134469,'shannonwilliams@gmail.com','Jonah Williams','IP');

INSERT into Patient(PatientID,FirstName,LastName,Gender,Age,MaritalStatus,Address,Phone,Email,Guardian,PatientTypeID)
VALUES('P0010','Annie','Frank','Female',58,'Married','Latha, Yangon',09254659878,'anniefrank@gmail.com','George Frank','IP');

SELECT * FROM Patient;

INSERT into Doctor(DocID,DocName,Specialization,ConsultantFees,AvailableTime)
VALUES('D001','Dr. Ben Stokes','Cardiologist',200,'Tue, Thu - 11:00 AM to 1:00 PM');

INSERT into Doctor(DocID,DocName,Specialization,ConsultantFees,AvailableTime)
VALUES('D002','Dr. Joe Root','General Physician',150,'Mon to Fri – 4:00 PM to 7:00 PM');

INSERT into Doctor(DocID,DocName,Specialization,ConsultantFees,AvailableTime)
VALUES('D003','Dr. Josh Butler','Gastroenterologist',170,'Mon, Wed, Fri - 7:00 PM to 8:00 PM');

INSERT into Doctor(DocID,DocName,Specialization,ConsultantFees,AvailableTime)
VALUES('D004','Dr. Chris Parker','Obstetrician',300,'Sat, Sun – 4:30 PM to 6:30 PM');

INSERT into Doctor(DocID,DocName,Specialization,ConsultantFees,AvailableTime)
VALUES('D005','Dr. Peter Evans','E.N.T Surgeons',220,'Mon to Fri – 4:30 PM');

INSERT into Doctor(DocID,DocName,Specialization,ConsultantFees,AvailableTime)
VALUES('D006','Dr. Mary Watson','Dermatologist',150,'Tue, Thur, Sat – 9:30 AM to 11:30 AM');

INSERT into Doctor(DocID,DocName,Specialization,ConsultantFees,AvailableTime)
VALUES('D007','Dr. Jane Stacy','Neurologist',275,'Mon, Wed, Fri – 11:30 AM to 1:00 PM');

INSERT into Doctor(DocID,DocName,Specialization,ConsultantFees,AvailableTime)
VALUES('D008','Dr. Gwen Potter','Nephrologist',250,'Tue, Sun – 5:00 PM to 7:00 PM');

INSERT into Doctor(DocID,DocName,Specialization,ConsultantFees,AvailableTime)
VALUES('D009','Dr. Luna Granger','Plastic Surgeon',500,'Mon, Wed, Fri – 11:00 AM to 12:00 Noon');

INSERT into Doctor(DocID,DocName,Specialization,ConsultantFees,AvailableTime)
VALUES('D0010','Dr. Percy Lynn','Orthopaedic Surgeon',320,'Tue, Thur, Sat – 2:00 PM to 4:00 PM');

UPDATE Doctor
SET DocID = 'D010'
WHERE DocName = 'Dr. Percy Lynn';

SELECT * FROM Doctor;

INSERT into Nurse(NurseID,NurseName)
VALUES('N001','Katy Lively');

INSERT into Nurse(NurseID,NurseName)
VALUES('N002','Lily Jackson');

INSERT into Nurse(NurseID,NurseName)
VALUES('N003','Maya Hawke');

INSERT into Nurse(NurseID,NurseName)
VALUES('N004','Nina Grey');

INSERT into Nurse(NurseID,NurseName)
VALUES('N005','Sasha Dobrev');

INSERT into Nurse(NurseID,NurseName)
VALUES('N006','Sophie Thompson');

INSERT into Nurse(NurseID,NurseName)
VALUES('N007','Tessa Monk');

INSERT into Nurse(NurseID,NurseName)
VALUES('N008','Vanessa Houston');

INSERT into Nurse(NurseID,NurseName)
VALUES('N009','Whitney Hudgens');

INSERT into Nurse(NurseID,NurseName)
VALUES('N010','Blake Mendes');

SELECT * FROM Nurse;

INSERT into Specialist(SpecialistID,SpecialistName)
VALUES('S01','Susan Ward');

INSERT into Specialist(SpecialistID,SpecialistName)
VALUES('S02','Adam Milne');

INSERT into Specialist(SpecialistID,SpecialistName)
VALUES('S03','Marco Jansen');

INSERT into Specialist(SpecialistID,SpecialistName)
VALUES('S04','Tom Curran');

INSERT into Specialist(SpecialistID,SpecialistName)
VALUES('S05','Roy Hazelwood');

INSERT into Specialist(SpecialistID,SpecialistName)
VALUES('S06','Andrew Russell');

INSERT into Specialist(SpecialistID,SpecialistName)
VALUES('S07','Lockie Fergus');

INSERT into Specialist(SpecialistID,SpecialistName)
VALUES('S08','Emma Kendrick');

INSERT into Specialist(SpecialistID,SpecialistName)
VALUES('S09','Amber Spears');

INSERT into Specialist(SpecialistID,SpecialistName)
VALUES('S10','Anna Heard');

SELECT * FROM Specialist;

INSERT into Test(TestID,TestName,Cost)
VALUES('CBC','Complete Blood Count',140);

INSERT into Test(TestID,TestName,Cost)
VALUES('TSH','Thyroid Stimulating Hormone',150);

INSERT into Test(TestID,TestName,Cost)
VALUES('LP','Lipid Panel',300);

INSERT into Test(TestID,TestName,Cost)
VALUES('BMP','Basic Metabolic Panel',330);

INSERT into Test(TestID,TestName,Cost)
VALUES('UT','Urinalysis',130);

INSERT into Test(TestID,TestName,Cost)
VALUES('STDT','Sexually Transmitted Disease Test',110);

INSERT into Test(TestID,TestName,Cost)
VALUES('VP','Vitamin Panel',100);

INSERT into Test(TestID,TestName,Cost)
VALUES('CT','Computed Tomography',700);

INSERT into Test(TestID,TestName,Cost)
VALUES('DEXA','Bone Density Scan',125);

INSERT into Test(TestID,TestName,Cost)
VALUES('MRI','Magnetic Resonance Imaging',1000);

INSERT into Test(TestID,TestName,Cost)
VALUES('PET','Positron Emission Tomography',500);

INSERT into Test(TestID,TestName,Cost)
VALUES('USG','Ultrasonography',400);

INSERT into Test(TestID,TestName,Cost)
VALUES('X-ray','X-radiation',350);

INSERT into Test(TestID,TestName,Cost)
VALUES('ECG','Electrocardiogram',160);

SELECT * FROM Test;

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0001','Warfarin',16.41);

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0002','Diovan',38.70);

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0003','Aspirin',3.57);

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0004','Paracetemol',3.69);

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0005','Pantoprazole',18);

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0006','Domperidone',59);

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0007','Vitamin D3',11.99);

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0008','Neomycin',86.47);

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0009','Metformin',50);

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0010','Lorazepam',20.99);

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0011','Ralista',29.97);

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0012','Tropex',8.55);

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0013','Tiger Balm',13.95);

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0014','Candid Powder',5.00);

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0015','Clotrimazole Cream',11.00);

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0016','Neurobion',10);

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0017','Botox',15);

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0018','Cefuroxime',31.97);

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0019','Folic Acid',11.06);

INSERT into Medicine(MedID,MedName,Cost)
VALUES('M0020','Vitamin B Complex',13.90);

SELECT * FROM Medicine;

INSERT into RoomType(RoomType,Cost)
VALUES('Single Bedroom',508.91);

INSERT into RoomType(RoomType,Cost)
VALUES('Double Bedroom',251.50);

SELECT * FROM RoomType;

INSERT into Room(RoomNo,RoomType,NurseID)
VALUES('R001','Single Bedroom','N001');

INSERT into Room(RoomNo,RoomType,NurseID)
VALUES('R002','Single Bedroom','N001');

INSERT into Room(RoomNo,RoomType,NurseID)
VALUES('R003','Single Bedroom','N002');

INSERT into Room(RoomNo,RoomType,NurseID)
VALUES('R004','Single Bedroom','N002');

INSERT into Room(RoomNo,RoomType,NurseID)
VALUES('R005','Single Bedroom','N003');

INSERT into Room(RoomNo,RoomType,NurseID)
VALUES('R006','Single Bedroom','N003');

INSERT into Room(RoomNo,RoomType,NurseID)
VALUES('R007','Single Bedroom','N004');

INSERT into Room(RoomNo,RoomType,NurseID)
VALUES('R008','Single Bedroom','N004');

INSERT into Room(RoomNo,RoomType,NurseID)
VALUES('R009','Double Bedroom','N005');

INSERT into Room(RoomNo,RoomType,NurseID)
VALUES('R010','Double Bedroom','N006');

INSERT into Room(RoomNo,RoomType,NurseID)
VALUES('R011','Double Bedroom','N007');

INSERT into Room(RoomNo,RoomType,NurseID)
VALUES('R012','Double Bedroom','N008');

INSERT into Room(RoomNo,RoomType,NurseID)
VALUES('R013','Double Bedroom','N009');

INSERT into Room(RoomNo,RoomType,NurseID)
VALUES('R014','Double Bedroom','N010');

SELECT * FROM Room;

INSERT into Appointment(ApptID,ApptDate,PatientID,DocID)
VALUES('Appt1','2021-10-11','P0004','D002');

INSERT into Appointment(ApptID,ApptDate,PatientID,DocID)
VALUES('Appt2','2021-10-12','P0009','D005');

INSERT into Appointment(ApptID,ApptDate,PatientID,DocID)
VALUES('Appt3','2021-10-12','P0005','D008');

INSERT into Appointment(ApptID,ApptDate,PatientID,DocID)
VALUES('Appt4','2021-10-13','P0008','D009');

INSERT into Appointment(ApptID,ApptDate,PatientID,DocID)
VALUES('Appt5','2021-10-14','P0001','D001');

INSERT into Appointment(ApptID,ApptDate,PatientID,DocID)
VALUES('Appt6','2021-10-15','P0006','D007');

INSERT into Appointment(ApptID,ApptDate,PatientID,DocID)
VALUES('Appt7','2021-10-16','P0007','D006');

INSERT into Appointment(ApptID,ApptDate,PatientID,DocID)
VALUES('Appt8','2021-10-16','P0002','D010');

INSERT into Appointment(ApptID,ApptDate,PatientID,DocID)
VALUES('Appt9','2021-10-17','P0010','D004');

INSERT into Appointment(ApptID,ApptDate,PatientID,DocID)
VALUES('Appt10','2021-10-17','P0005','D008');

INSERT into Appointment(ApptID,ApptDate,PatientID,DocID)
VALUES('Appt11','2021-10-18','P0009','D005');

INSERT into Appointment(ApptID,ApptDate,PatientID,DocID)
VALUES('Appt12','2021-10-19','P0001','D001');

SELECT * FROM Appointment
ORDER BY ApptDate;

INSERT into TestResult(TestResultID,PatientID,TestID,SpecialistID)
VALUES('T1','P0004','CBC','S01');

INSERT into TestResult(TestResultID,PatientID,TestID,SpecialistID)
VALUES('T2','P0005','BMP','S02');

INSERT into TestResult(TestResultID,PatientID,TestID,SpecialistID)
VALUES('T3','P0005','UT','S03');

INSERT into TestResult(TestResultID,PatientID,TestID,SpecialistID)
VALUES('T4','P0001','ECG','S04');

INSERT into TestResult(TestResultID,PatientID,TestID,SpecialistID)
VALUES('T5','P0001','LP','S05');

INSERT into TestResult(TestResultID,PatientID,TestID,SpecialistID)
VALUES('T6','P0006','MRI','S06');

INSERT into TestResult(TestResultID,PatientID,TestID,SpecialistID)
VALUES('T7','P0002','X-ray','S07');

INSERT into TestResult(TestResultID,PatientID,TestID,SpecialistID)
VALUES('T8','P0010','DEXA','S08');

INSERT into TestResult(TestResultID,PatientID,TestID,SpecialistID)
VALUES('T9','P0010','UT','S09');

INSERT into TestResult(TestResultID,PatientID,TestID,SpecialistID)
VALUES('T10','P0003','MRI','S10');

SELECT * FROM TestResult
ORDER BY PatientID;

INSERT into Admission(AdmID,AdmDate,PatientID,DocID,RoomNo)
VALUES('Adm1','2021-10-13','P0008','D009','R007');

INSERT into Admission(AdmID,AdmDate,PatientID,DocID,RoomNo)
VALUES('Adm2','2021-10-15','P0003','D003','R001');

INSERT into Admission(AdmID,AdmDate,PatientID,DocID,RoomNo)
VALUES('Adm3','2021-10-16','P0002','D010','R012');

INSERT into Admission(AdmID,AdmDate,PatientID,DocID,RoomNo)
VALUES('Adm4','2021-10-17','P0010','D004','R005');

INSERT into Admission(AdmID,AdmDate,PatientID,DocID,RoomNo)
VALUES('Adm5','2021-10-17','P0005','D008','R004');

INSERT into Admission(AdmID,AdmDate,PatientID,DocID,RoomNo)
VALUES('Adm6','2021-10-18','P0009','D005','R010');

INSERT into Admission(AdmID,AdmDate,PatientID,DocID,RoomNo)
VALUES('Adm7','2021-10-19','P0001','D001','R003');

INSERT into Admission(AdmID,AdmDate,PatientID,DocID,RoomNo)
VALUES('Adm8','2021-10-20','P0006','D007','R010');

SELECT * FROM Admission
ORDER BY AdmDate;

INSERT into Treatment(TreatmentID,PatientID,DocID,MedID,Quantity)
VALUES('TM1','P0004','D002','M0003',5);

INSERT into Treatment(TreatmentID,PatientID,DocID,MedID,Quantity)
VALUES('TM2','P0004','D002','M0004',5);

INSERT into Treatment(TreatmentID,PatientID,DocID,MedID,Quantity)
VALUES('TM3','P0008','D009','M0008',3);

INSERT into Treatment(TreatmentID,PatientID,DocID,MedID,Quantity)
VALUES('TM4','P0008','D009','M0017',2);

INSERT into Treatment(TreatmentID,PatientID,DocID,MedID,Quantity)
VALUES('TM5','P0003','D003','M0005',7);

INSERT into Treatment(TreatmentID,PatientID,DocID,MedID,Quantity)
VALUES('TM6','P0003','D003','M0006',2);

INSERT into Treatment(TreatmentID,PatientID,DocID,MedID,Quantity)
VALUES('TM7','P0007','D006','M0014',1);

INSERT into Treatment(TreatmentID,PatientID,DocID,MedID,Quantity)
VALUES('TM8','P0007','D006','M0015',1);

INSERT into Treatment(TreatmentID,PatientID,DocID,MedID,Quantity)
VALUES('TM9','P0002','D010','M0018',4);

INSERT into Treatment(TreatmentID,PatientID,DocID,MedID,Quantity)
VALUES('TM10','P0010','D004','M0011',10);

INSERT into Treatment(TreatmentID,PatientID,DocID,MedID,Quantity)
VALUES('TM11','P0010','D004','M0019',10);

INSERT into Treatment(TreatmentID,PatientID,DocID,MedID,Quantity)
VALUES('TM12','P0005','D008','M0010',8);

INSERT into Treatment(TreatmentID,PatientID,DocID,MedID,Quantity)
VALUES('TM13','P0009','D005','M0012',1);

INSERT into Treatment(TreatmentID,PatientID,DocID,MedID,Quantity)
VALUES('TM14','P0001','D001','M0001',10);

INSERT into Treatment(TreatmentID,PatientID,DocID,MedID,Quantity)
VALUES('TM15','P0001','D001','M0002',10);

INSERT into Treatment(TreatmentID,PatientID,DocID,MedID,Quantity)
VALUES('TM16','P0006','D007','M0016',10);

SELECT * FROM Treatment
ORDER BY PatientID;

UPDATE Medicine
SET MedName = 'Clotri-denk', 
	   Cost = 12
WHERE MedID = 'M0015';

SELECT * FROM Medicine
WHERE MedID = 'M0015';

DELETE FROM Test
WHERE TestID = 'STDT';

SELECT * FROM Test
WHERE TestID = 'STDT';

SELECT p.PatientID, p.FirstName, p.LastName, r.RoomNo, r.RoomType
FROM Patient p, Admission a, Room r
WHERE p.PatientID = a.PatientID
AND a.RoomNo = r.RoomNo
AND p.PatientTypeID = 'IP'
ORDER BY r.RoomNo;

SELECT COUNT(PatientID) AS NumOfPatient,AVG(Age) AS AverageAge
FROM Patient;

ALTER table Treatment
ADD TotalCost decimal(10,2);

SELECT * FROM Treatment;

UPDATE Treatment
SET TotalCost = (tm.Quantity*m.Cost)
FROM Treatment tm, Medicine m
WHERE tm.MedID = m.MedID;

SELECT * FROM Treatment;

SELECT p.PatientID, p.FirstName,p.LastName, t.*, s.SpecialistName
FROM Test t, TestResult r, Patient p, Specialist s
WHERE t.TestID = r.TestID
AND r.PatientID = p.PatientID
AND s.SpecialistID = r.SpecialistID
AND t.Cost = (SELECT MAX(Cost) FROM Test);

SELECT p.PatientID, p.FirstName, p.LastName, appt.DocID, appt.ApptDate, tr.TestID
FROM ((Patient p
INNER JOIN Appointment appt ON p.PatientID = appt.PatientID)
INNER JOIN TestResult tr ON p.PatientID = tr.PatientID)
ORDER BY appt.ApptDate;

SELECT COUNT(r.PatientID) AS NumOfPatients,t.TestName
FROM TestResult r, Test t
WHERE r.TestID = t.TestID
GROUP BY t.TestName
ORDER BY COUNT(r.PatientID) DESC;

SELECT p.FirstName, p.LastName, SUM(tm.TotalCost) AS Payment
FROM Patient p, Treatment tm
WHERE p.PatientID = tm.PatientID
AND p.PatientID = 'P0008'
GROUP BY p.FirstName, p.LastName;

SELECT * FROM Appointment
WHERE PatientID = 'P0009';