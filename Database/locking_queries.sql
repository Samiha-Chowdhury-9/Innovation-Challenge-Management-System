--Implicit locking
--Question-1: Write an SQL query to update the affiliation of the ICMS participant with participant_id = 3. 

UPDATE Participant
SET affiliation = 'AIUB Research Lab'
WHERE participant_id = 3;
  

--Question-2: Write an SQL query to delete the sample phone record for participant_id = 1 and phone_no = 01822-333222. 

DELETE FROM ParticipantPhone
WHERE participant_id = 1
  AND phone_no = '01822-333222'
  
--Explicit locking
--Question-3: Write an SQL query to explicitly lock the evaluation row with evaluation_id = 1. 

SELECT *
FROM Evaluation
WHERE evaluation_id = 1
FOR UPDATE NOWAIT;
    
 
--Question-4: Write an SQL query to explicitly lock the entire Tag table in EXCLUSIVE mode. 

LOCK TABLE Tag
IN EXCLUSIVE MODE NOWAIT;
  
