--1. CHALLENGE DATA (5 rows)
INSERT INTO Challenge (challenge_id, title, theme, start_date, end_date, status) VALUES (seq_challenge.NEXTVAL, 'Green Energy Hack', 'Sustainability', TO_DATE('2026-01-10', 'YYYY-MM-DD'), TO_DATE('2026-06-10', 'YYYY-MM-DD'), 'Open');
INSERT INTO Challenge (challenge_id, title, theme, start_date, end_date, status) VALUES (seq_challenge.NEXTVAL, 'AI for Good', 'Artificial Intelligence', TO_DATE('2025-03-01', 'YYYY-MM-DD'), TO_DATE('2025-08-01', 'YYYY-MM-DD'), 'Closed');
INSERT INTO Challenge (challenge_id, title, theme, start_date, end_date, status) VALUES (seq_challenge.NEXTVAL, 'HealthTech Sprint', 'Healthcare', TO_DATE('2026-09-01', 'YYYY-MM-DD'), TO_DATE('2026-12-01', 'YYYY-MM-DD'), 'Open');
INSERT INTO Challenge (challenge_id, title, theme, start_date, end_date, status) VALUES (seq_challenge.NEXTVAL, 'Smart City Challenge', 'Urban Technology', TO_DATE('2026-02-15', 'YYYY-MM-DD'), TO_DATE('2026-07-15', 'YYYY-MM-DD'), 'Ongoing');
INSERT INTO Challenge (challenge_id, title, theme, start_date, end_date, status) VALUES (seq_challenge.NEXTVAL, 'EduTech Innovate', 'Education', TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2025-11-01', 'YYYY-MM-DD'), 'Closed');

SELECT * FROM Challenge ORDER BY challenge_id;
 

--2. PARTICIPANT DATA (5 rows)
-- Ordinary participants: IDs 1-5
INSERT INTO Participant VALUES (seq_participant.NEXTVAL, 'Tanvir Islam Nayem', 'tanvir@aiub.edu', 'AIUB');
INSERT INTO Participant VALUES (seq_participant.NEXTVAL, 'MD ALIF ZIAD SARKAR', 'alif@aiub.edu', 'AIUB');
INSERT INTO Participant VALUES (seq_participant.NEXTVAL, 'SAMIHA CHOWDHURY', 'samiha@aiub.edu', 'AIUB');
INSERT INTO Participant VALUES (seq_participant.NEXTVAL, 'TASFIAH TASNIM MRINMOYEE', 'tasfiah@aiub.edu', 'AIUB');
INSERT INTO Participant VALUES (seq_participant.NEXTVAL, 'Tanzimul Hasan', 'tanzimul@aiub.edu', 'AIUB');

-- Judge participants: IDs 6-10
INSERT INTO Participant VALUES (seq_participant.NEXTVAL, 'Nafis Ahmed', 'nafis.judge@icms.org', 'Innovation Council');
INSERT INTO Participant VALUES (seq_participant.NEXTVAL, 'Ariana Kabir', 'ariana.judge@icms.org', 'Technology Institute');
INSERT INTO Participant VALUES (seq_participant.NEXTVAL, 'Rayan Chowdhury', 'rayan.judge@icms.org', 'Health Research Center');
INSERT INTO Participant VALUES (seq_participant.NEXTVAL, 'Maliha Rahman', 'maliha.judge@icms.org', 'Green Foundation');
INSERT INTO Participant VALUES (seq_participant.NEXTVAL, 'Zahin Karim', 'zahin.judge@icms.org', 'Urban Development Lab');

-- Mentor participants: IDs 11-15
INSERT INTO Participant VALUES (seq_participant.NEXTVAL, 'Adnan Hossain', 'adnan.mentor@icms.org', 'Engineering Lab');
INSERT INTO Participant VALUES (seq_participant.NEXTVAL, 'Elina Sultana', 'elina.mentor@icms.org', 'Product Institute');
INSERT INTO Participant VALUES (seq_participant.NEXTVAL, 'Imran Haque', 'imran.mentor@icms.org', 'Software Center');
INSERT INTO Participant VALUES (seq_participant.NEXTVAL, 'Rima Akter', 'rima.mentor@icms.org', 'Business Hub');
INSERT INTO Participant VALUES (seq_participant.NEXTVAL, 'Zayan Islam', 'zayan.mentor@icms.org', 'Data Lab');
SELECT * FROM Participant ORDER BY participant_id;
 

--3. PARTICIPANTPHONE DATA (5 rows)
INSERT INTO ParticipantPhone VALUES (1, '01711-000111');
INSERT INTO ParticipantPhone VALUES (1, '01822-333222');
INSERT INTO ParticipantPhone VALUES (2, '01722-000222');
INSERT INTO ParticipantPhone VALUES (3, '01733-000333');
INSERT INTO ParticipantPhone VALUES (4, '01744-000444');
SELECT * FROM ParticipantPhone ORDER BY participant_id, phone_no;
 

--4. TEAM DATA (5 rows)
INSERT INTO Team VALUES (seq_team.NEXTVAL, 'Team Alpha', 1);
INSERT INTO Team VALUES (seq_team.NEXTVAL, 'Team Beta', 1);
INSERT INTO Team VALUES (seq_team.NEXTVAL, 'Team Gamma', 2);
INSERT INTO Team VALUES (seq_team.NEXTVAL, 'Team Delta', 3);
INSERT INTO Team VALUES (seq_team.NEXTVAL, 'Team Epsilon', 3);
SELECT * FROM Team ORDER BY team_id;
 

--5. TEAMPARTICIPANT DATA (5 rows)
INSERT INTO TeamParticipant VALUES (1, 1);
INSERT INTO TeamParticipant VALUES (2, 1);
INSERT INTO TeamParticipant VALUES (3, 2);
INSERT INTO TeamParticipant VALUES (4, 3);
INSERT INTO TeamParticipant VALUES (5, 4);
SELECT * FROM TeamParticipant ORDER BY team_id, participant_id;
 

--6. ROUND DATA (5 rows)
INSERT INTO Round VALUES (seq_round.NEXTVAL, 1, 'Idea Submission', 1);
INSERT INTO Round VALUES (seq_round.NEXTVAL, 2, 'Prototype Review', 1);
INSERT INTO Round VALUES (seq_round.NEXTVAL, 1, 'Concept Pitch', 2);
INSERT INTO Round VALUES (seq_round.NEXTVAL, 1, 'Proposal Round', 3);
INSERT INTO Round VALUES (seq_round.NEXTVAL, 2, 'Design Sprint', 3);
SELECT * FROM Round ORDER BY round_id;
 

--7. TAG DATA (5 rows)
INSERT INTO Tag VALUES (seq_tag.NEXTVAL, 'Renewable Energy');
INSERT INTO Tag VALUES (seq_tag.NEXTVAL, 'Machine Learning');
INSERT INTO Tag VALUES (seq_tag.NEXTVAL, 'IoT');
INSERT INTO Tag VALUES (seq_tag.NEXTVAL, 'Healthcare');
INSERT INTO Tag VALUES (seq_tag.NEXTVAL, 'Smart City');
SELECT * FROM Tag ORDER BY tag_id;
 

--8. CRITERIA DATA (5 rows)
INSERT INTO Criteria VALUES (seq_criteria.NEXTVAL, 'Innovation', 1);
INSERT INTO Criteria VALUES (seq_criteria.NEXTVAL, 'Feasibility', 1);
INSERT INTO Criteria VALUES (seq_criteria.NEXTVAL, 'Prototype Quality', 2);
INSERT INTO Criteria VALUES (seq_criteria.NEXTVAL, 'Presentation', 3);
INSERT INTO Criteria VALUES (seq_criteria.NEXTVAL, 'Design Creativity', 4);
SELECT * FROM Criteria ORDER BY criteria_id;
 

--9. JUDGE DATA (5 rows) — Uses ParticipantID from seq_participant
INSERT INTO Judge VALUES (6, 'Digital Systems');
INSERT INTO Judge VALUES (7, 'Artificial Intelligence');
INSERT INTO Judge VALUES (8, 'Healthcare Technology');
INSERT INTO Judge VALUES (9, 'Renewable Energy');
INSERT INTO Judge VALUES (10, 'Urban Planning');
SELECT * FROM Judge ORDER BY participant_id;
 

--10. MENTOR DATA (5 rows) — Uses ParticipantID from seq_participant
(Mentors already exist as Participants)
INSERT INTO Mentor VALUES (11, 'Hardware Engineering');
INSERT INTO Mentor VALUES (12, 'Product Strategy');
INSERT INTO Mentor VALUES (13, 'Software Development');
INSERT INTO Mentor VALUES (14, 'Business Innovation');
INSERT INTO Mentor VALUES (15, 'Data Science');
SELECT * FROM Mentor ORDER BY participant_id;
 

--11. MENTORSHIPSESSION DATA (5 rows)
INSERT INTO MentorshipSession VALUES (TO_DATE('2026-01-15', 'YYYY-MM-DD'), 'Solar optimization strategy', 1, 11);
INSERT INTO MentorshipSession VALUES (TO_DATE('2026-01-20', 'YYYY-MM-DD'), 'Prototype feasibility', 1, 12);
INSERT INTO MentorshipSession VALUES (TO_DATE('2026-01-18', 'YYYY-MM-DD'), 'AI model selection', 2, 13);
INSERT INTO MentorshipSession VALUES (TO_DATE('2026-09-05', 'YYYY-MM-DD'), 'Data privacy review', 4, 14);
INSERT INTO MentorshipSession VALUES (TO_DATE('2026-02-20', 'YYYY-MM-DD'), 'Infrastructure integration', 3, 15);
SELECT * FROM MentorshipSession ORDER BY session_date, team_id, participant_id;
 

--12. SUBMISSION DATA (5 rows)
INSERT INTO Submission VALUES (seq_submission.NEXTVAL, 'Solar Grid Optimizer', 'AI-powered solar grid optimization for campus', 1, TO_DATE('2026-02-01', 'YYYY-MM-DD'), 'Submitted', 1, 1);
INSERT INTO Submission VALUES (seq_submission.NEXTVAL, 'AI Crop Monitor', 'Machine learning for crop disease detection', 1, TO_DATE('2026-03-01', 'YYYY-MM-DD'), 'Under Review', 2, 1);
INSERT INTO Submission VALUES (seq_submission.NEXTVAL, 'MediTrack App', 'Patient tracking application', 1, TO_DATE('2025-05-01', 'YYYY-MM-DD'), 'Draft', 3, 3);
INSERT INTO Submission VALUES (seq_submission.NEXTVAL, 'Smart Health Portal', 'Remote healthcare coordination portal', 1, TO_DATE('2026-09-10', 'YYYY-MM-DD'), 'Scored', 4, 4);
INSERT INTO Submission VALUES (seq_submission.NEXTVAL, 'Healthcare Innovation Portal', 'A digital platform for improving healthcare service coordination', 1, TO_DATE('2026-09-20', 'YYYY-MM-DD'), 'Submitted', 5, 4);
SELECT * FROM Submission ORDER BY submission_id;
 


--13. SUBMISSIONTAG DATA (5 rows)-- using existing IDs
INSERT INTO SubmissionTag VALUES (1, 1);
INSERT INTO SubmissionTag VALUES (1, 3);
INSERT INTO SubmissionTag VALUES (2, 2);
INSERT INTO SubmissionTag VALUES (3, 4);
INSERT INTO SubmissionTag VALUES (4, 4);
SELECT * FROM SubmissionTag ORDER BY submission_id, tag_id;
 

--14. SPONSOR DATA (5 rows)
INSERT INTO Sponsor VALUES (seq_sponsor.NEXTVAL, 'TechCorp BD', 500000);
INSERT INTO Sponsor VALUES (seq_sponsor.NEXTVAL, 'GreenFund', 300000);
INSERT INTO Sponsor VALUES (seq_sponsor.NEXTVAL, 'HealthVentures', 200000);
INSERT INTO Sponsor VALUES (seq_sponsor.NEXTVAL, 'SmartCity Inc', 400000);
INSERT INTO Sponsor VALUES (seq_sponsor.NEXTVAL, 'EduGrant', 150000);
Select * from sponsor;
 

--15. PRIZE DATA (5 rows)
INSERT INTO Prize VALUES (seq_prize.NEXTVAL, 'Grand Prize', 100000, 1, 1, 1, 1);
INSERT INTO Prize VALUES (seq_prize.NEXTVAL, 'Runner Up', 50000, 2, 1, 2, 1);
INSERT INTO Prize VALUES (seq_prize.NEXTVAL, 'Best AI Solution', 75000, 1, 2, 3, 2);
INSERT INTO Prize VALUES (seq_prize.NEXTVAL, 'Health Innovation Award', 60000, 1, 3, 4, 3);
INSERT INTO Prize VALUES (seq_prize.NEXTVAL, 'Best Prototype Award', 40000, 3, 1, 2, 1);
SELECT * FROM Prize ORDER BY prize_id;
 

--16. EVALUATION DATA (5 rows)
INSERT INTO Evaluation VALUES (seq_evaluation.NEXTVAL, 88.5, 'Excellent innovation', TO_DATE('2026-02-05', 'YYYY-MM-DD'), 'Nafis Ahmed', TO_DATE('2026-02-05 11:00', 'YYYY-MM-DD HH24:MI'), 1, 1, 6);
INSERT INTO Evaluation VALUES (seq_evaluation.NEXTVAL, 75, 'Good feasibility', TO_DATE('2026-02-06', 'YYYY-MM-DD'), 'Ariana Kabir', TO_DATE('2026-02-06 12:00', 'YYYY-MM-DD HH24:MI'), 1, 2, 7);
INSERT INTO Evaluation VALUES (seq_evaluation.NEXTVAL, 65, 'Needs refinement', TO_DATE('2026-03-05', 'YYYY-MM-DD'), 'Rayan Chowdhury', TO_DATE('2026-03-05 10:30', 'YYYY-MM-DD HH24:MI'), 2, 1, 8);
INSERT INTO Evaluation VALUES (seq_evaluation.NEXTVAL, 90, 'Outstanding presentation', TO_DATE('2025-05-05', 'YYYY-MM-DD'), 'Maliha Rahman', TO_DATE('2025-05-05 14:00', 'YYYY-MM-DD HH24:MI'), 3, 4, 9);
INSERT INTO Evaluation VALUES (seq_evaluation.NEXTVAL, 80, 'Clear design', TO_DATE('2026-09-15', 'YYYY-MM-DD'), 'Zahin Karim', TO_DATE('2026-09-15 15:00', 'YYYY-MM-DD HH24:MI'), 4, 5, 10);
SELECT * FROM Evaluation ORDER BY evaluation_id;
 