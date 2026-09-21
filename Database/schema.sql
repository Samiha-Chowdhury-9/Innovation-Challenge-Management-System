-- 1. CHALLENGE
CREATE TABLE Challenge ( challenge_id NUMBER(6), title VARCHAR2(200) NOT NULL, theme VARCHAR2(200), start_date DATE NOT NULL, end_date DATE NOT NULL, status VARCHAR2(20) NOT NULL, CONSTRAINT pk_challenge PRIMARY KEY (challenge_id), CONSTRAINT ck_challenge_dates CHECK (end_date > start_date), CONSTRAINT ck_challenge_status CHECK (status IN ('Open', 'Ongoing', 'Judging', 'Closed')) );
DESC Challenge;
 

-- 2. SPONSOR
CREATE TABLE Sponsor ( sponsor_id NUMBER(6), sponsor_name VARCHAR2(200) NOT NULL, contribution_amount NUMBER(12,2) NOT NULL, CONSTRAINT pk_sponsor PRIMARY KEY (sponsor_id), CONSTRAINT uq_sponsor_name UNIQUE (sponsor_name), CONSTRAINT ck_sponsor_amount CHECK (contribution_amount >= 0) );
DESC Sponsor;
 

-- 3. PARTICIPANT
CREATE TABLE Participant ( participant_id NUMBER(6), name VARCHAR2(150) NOT NULL, email VARCHAR2(150) NOT NULL, affiliation VARCHAR2(200), CONSTRAINT pk_participant PRIMARY KEY (participant_id), CONSTRAINT uq_participant_email UNIQUE (email) );
DESC Participant;
 

-- 4. TAG
CREATE TABLE Tag ( tag_id NUMBER(6), tag_name VARCHAR2(100) NOT NULL, CONSTRAINT pk_tag PRIMARY KEY (tag_id), CONSTRAINT uq_tag_name UNIQUE (tag_name) );
DESC Tag;
 


-- 5. TEAM: depends on Challenge
CREATE TABLE Team ( team_id NUMBER(6), team_name VARCHAR2(150) NOT NULL, challenge_id NUMBER(6) NOT NULL, CONSTRAINT pk_team PRIMARY KEY (team_id), CONSTRAINT uq_team_challenge UNIQUE (team_name, challenge_id), CONSTRAINT fk_team_challenge FOREIGN KEY (challenge_id) REFERENCES Challenge(challenge_id) );
DESC Team;
 

-- 6. ROUND: depends on Challenge
CREATE TABLE Round ( round_id NUMBER(6), round_number NUMBER(3) NOT NULL, round_name VARCHAR2(100) NOT NULL, challenge_id NUMBER(6) NOT NULL, CONSTRAINT pk_round PRIMARY KEY (round_id), CONSTRAINT uq_round_challenge UNIQUE (challenge_id, round_number), CONSTRAINT ck_round_number CHECK (round_number > 0), CONSTRAINT fk_round_challenge FOREIGN KEY (challenge_id) REFERENCES Challenge(challenge_id) );
DESC Round;
 

-- 7. PARTICIPANTPHONE: depends on Participant
CREATE TABLE ParticipantPhone ( participant_id NUMBER(6), phone_no VARCHAR2(20), CONSTRAINT pk_participant_phone PRIMARY KEY (participant_id, phone_no), CONSTRAINT fk_phone_participant FOREIGN KEY (participant_id) REFERENCES Participant(participant_id) );
DESC ParticipantPhone;
 

-- 8. JUDGE: subtype of Participant
CREATE TABLE Judge ( participant_id NUMBER(6), expertise VARCHAR2(200) NOT NULL, CONSTRAINT pk_judge PRIMARY KEY (participant_id), CONSTRAINT fk_judge_participant FOREIGN KEY (participant_id) REFERENCES Participant(participant_id) );
DESC Judge;
 

-- 9. MENTOR: subtype of Participant
CREATE TABLE Mentor ( participant_id NUMBER(6), specialization VARCHAR2(200) NOT NULL, CONSTRAINT pk_mentor PRIMARY KEY (participant_id), CONSTRAINT fk_mentor_participant FOREIGN KEY (participant_id) REFERENCES Participant(participant_id) );
DESC Mentor;
 

-- 10. TEAMPARTICIPANT: depends on Team and Participant
-- The two foreign keys together form the composite primary key.
CREATE TABLE TeamParticipant ( participant_id NUMBER(6), team_id NUMBER(6), CONSTRAINT pk_team_participant PRIMARY KEY (participant_id, team_id), CONSTRAINT fk_tp_participant FOREIGN KEY (participant_id) REFERENCES Participant(participant_id), CONSTRAINT fk_tp_team FOREIGN KEY (team_id) REFERENCES Team(team_id) );
DESC TeamParticipant;
 

-- 11. CRITERIA: depends on Round
CREATE TABLE Criteria ( criteria_id NUMBER(6), criteria_name VARCHAR2(150) NOT NULL, round_id NUMBER(6) NOT NULL, CONSTRAINT pk_criteria PRIMARY KEY (criteria_id), CONSTRAINT uq_criteria_round UNIQUE (round_id, criteria_name), CONSTRAINT fk_criteria_round FOREIGN KEY (round_id) REFERENCES Round(round_id) );
DESC Criteria;
 

-- 12. PRIZE: depends on Challenge, Team and Sponsor
CREATE TABLE Prize ( prize_id NUMBER(6), prize_name VARCHAR2(150) NOT NULL, amount NUMBER(12,2) NOT NULL, rank NUMBER(3) NOT NULL, challenge_id NUMBER(6) NOT NULL, team_id NUMBER(6) NOT NULL, sponsor_id NUMBER(6) NOT NULL, CONSTRAINT pk_prize PRIMARY KEY (prize_id), CONSTRAINT uq_prize_rank UNIQUE (challenge_id, rank), CONSTRAINT ck_prize_amount CHECK (amount >= 0), CONSTRAINT ck_prize_rank CHECK (rank > 0), CONSTRAINT fk_prize_challenge FOREIGN KEY (challenge_id) REFERENCES Challenge(challenge_id), CONSTRAINT fk_prize_team FOREIGN KEY (team_id) REFERENCES Team(team_id), CONSTRAINT fk_prize_sponsor FOREIGN KEY (sponsor_id) REFERENCES Sponsor(sponsor_id) );
DESC Prize;
 

-- 13. SUBMISSION: depends on Team and Round
CREATE TABLE Submission ( submission_id NUMBER(6), title VARCHAR2(200) NOT NULL, abstract VARCHAR2(500), version_no NUMBER(5,2) NOT NULL, submitted_at_date DATE NOT NULL, status VARCHAR2(20) NOT NULL, team_id NUMBER(6) NOT NULL, round_id NUMBER(6) NOT NULL, CONSTRAINT pk_submission PRIMARY KEY (submission_id), CONSTRAINT uq_submission_team_round UNIQUE (team_id, round_id), CONSTRAINT ck_submission_version CHECK (version_no > 0), CONSTRAINT ck_submission_status CHECK (status IN ('Draft', 'Submitted', 'Under Review', 'Scored', 'Finalist')), CONSTRAINT fk_submission_team FOREIGN KEY (team_id) REFERENCES Team(team_id), CONSTRAINT fk_submission_round FOREIGN KEY (round_id) REFERENCES Round(round_id) );
DESC Submission;
 

-- 14. MENTORSHIPSESSION: depends on Team and Mentor
CREATE TABLE MentorshipSession ( session_date DATE, notes VARCHAR2(500), team_id NUMBER(6), participant_id NUMBER(6), CONSTRAINT pk_mentorship_session PRIMARY KEY (session_date, team_id, participant_id), CONSTRAINT fk_ms_team FOREIGN KEY (team_id) REFERENCES Team(team_id), CONSTRAINT fk_ms_mentor FOREIGN KEY (participant_id) REFERENCES Mentor(participant_id) );
DESC MentorshipSession;
 

-- 15. SUBMISSIONTAG: depends on Submission and Tag
CREATE TABLE SubmissionTag ( submission_id NUMBER(6), tag_id NUMBER(6), CONSTRAINT pk_submission_tag PRIMARY KEY (submission_id, tag_id), CONSTRAINT fk_st_submission FOREIGN KEY (submission_id) REFERENCES Submission(submission_id), CONSTRAINT fk_st_tag FOREIGN KEY (tag_id) REFERENCES Tag(tag_id) );
DESC SubmissionTag;
 


-- 16. EVALUATION: depends on Submission, Criteria and Judge
CREATE TABLE Evaluation ( evaluation_id NUMBER(6), score NUMBER(5,2) NOT NULL, comments VARCHAR2(500), evaluated_at DATE NOT NULL, locked_by VARCHAR2(100), lock_timestamp DATE, submission_id NUMBER(6) NOT NULL, criteria_id NUMBER(6) NOT NULL, participant_id NUMBER(6) NOT NULL, CONSTRAINT pk_evaluation PRIMARY KEY (evaluation_id), CONSTRAINT uq_evaluation UNIQUE (submission_id, criteria_id, participant_id), CONSTRAINT ck_evaluation_score CHECK (score BETWEEN 0 AND 100), CONSTRAINT ck_evaluation_lock CHECK ( (locked_by IS NULL AND lock_timestamp IS NULL) OR (locked_by IS NOT NULL AND lock_timestamp IS NOT NULL) ), CONSTRAINT fk_evaluation_submission FOREIGN KEY (submission_id) REFERENCES Submission(submission_id), CONSTRAINT fk_evaluation_criteria FOREIGN KEY (criteria_id) REFERENCES Criteria(criteria_id), CONSTRAINT fk_evaluation_judge FOREIGN KEY (participant_id) REFERENCES Judge(participant_id) );
DESC Evaluation;
 

