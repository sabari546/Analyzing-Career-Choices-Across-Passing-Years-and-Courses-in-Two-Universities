-- Q1
use alumni;
select * from college_a_hs;
-- Q3
desc college_a_hs;
desc college_a_sj;
desc college_a_se;
desc college_b_se;
desc college_b_sj;
desc college_b_hs;
-- Q4 ans in python
-- Q6
create view college_a_hs_v as select * from college_a_hs where MotherName <> "" and EntranceExam <> "" and Institute <> "" and location <> "";
select * from college_a_hs_v;
-- q7
create view college_a_se_v as select * from college_a_se where MotherName <> "" and Organization <> "" and Location <> "";
select * from college_b_se_v;
-- Q8
create view college_a_sj_v as select * from college_a_sj where Name <> "" and FatherName <> "" and MotherName <> "" and Organization <> "" and Designation <> "" and Location <> "";
select * from college_a_sj_v;
-- Q9
create view college_b_hs_v as select * from college_b_hs  where MotherName <> "" and FatherName <> "" and EntranceExam <> "" and Institute <> "" and location <> "";
select * from college_b_hs_v;
-- Q10
create view college_b_se_v as select * from college_b_se where mothername <> "" and organization <> "" and location <> "";
select * from college_a_se_v;
-- Q11
create view college_b_sj_v as select * from college_b_sj where MotherName <> "" and Organization <> "" and Designation <> "" and Location <>"";
-- Q15
DELIMITER $$
CREATE PROCEDURE get_name_collegeB 
(
         INOUT name1 TEXT(40000)
)
BEGIN 
    DECLARE finished INT DEFAULT 0;
    DECLARE namelist VARCHAR(16000) DEFAULT "";
    
    DECLARE namedetail 
           CURSOR FOR
				SELECT Name FROM college_b_hs UNION SELECT Name FROM college_b_se UNION SELECT Name FROM college_b_sj;
                
	DECLARE CONTINUE HANDLER 
            FOR NOT FOUND SET finished =1;
            
	OPEN namedetail;
    
    getame :
         LOOP
         FETCH FROM namedetail INTO namelist;
         IF finished = 1 THEN
              LEAVE getame;
		END IF;
        SET name1 = CONCAT(namelist,";",name1);
        
        END LOOP getame;
        CLOSE namedetail;
END $$
DELIMITER ;
SET @Name1 = "";
CALL get_name_collegeB(@Name1);
SELECT @Name1 Name;


-- Q14
DELIMITER $$
CREATE PROCEDURE get_name_collegeA
(
         INOUT name2 TEXT(40000)
)
BEGIN 
    DECLARE finished INT DEFAULT 0;
    DECLARE namelist VARCHAR(16000) DEFAULT "";
    
    DECLARE namedetail 
           CURSOR FOR
				SELECT Name FROM college_a_hs UNION SELECT Name FROM college_a_se UNION SELECT Name FROM college_a_sj;
                
	DECLARE CONTINUE HANDLER 
            FOR NOT FOUND SET finished =1;
            
	OPEN namedetail;
    
    getame :
         LOOP
         FETCH FROM namedetail INTO namelist;
         IF finished = 1 THEN
              LEAVE getame;
		END IF;
        SET name2 = CONCAT(namelist,";",name2);
        
        END LOOP getame;
        CLOSE namedetail;
END $$
DELIMITER ;
set @name2= "";
CALL get_name_collegeB(@Name2);
SELECT @Name2 Name;
-- Q16
SELECT "Higher Studies" Present_status,(COUNT(college_a_hs.RollNo)/(college_a_hs.RollNo))*100 College_A_Persentage,(COUNT(college_b_hs.RollNo)/(college_b_hs.RollNo))*100 College_B_Persentage   FROM college_a_hs CROSS JOIN college_b_hs UNION 
SELECT "Self Empolyment" Present_status,(COUNT(college_a_se.RollNo) /(college_a_se.RollNo))*100 College_A_Persentage,(COUNT(college_b_se.RollNo)/(college_b_se.RollNo))*100 College_B_Persentage   FROM college_a_se CROSS JOIN college_b_se UNION
SELECT "Service Job" Present_status,(COUNT(college_a_sj.RollNo) /(college_a_sj.RollNo))*100 College_A_Persentage,(COUNT(college_b_sj.RollNo)/(college_b_sj.RollNo))*100 College_B_Persentage    FROM college_a_sj CROSS JOIN college_b_sj;