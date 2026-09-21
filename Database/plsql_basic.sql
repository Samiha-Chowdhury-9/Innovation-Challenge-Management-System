
-- Question 1: Declare variables to store a challenge ID and the number of teams registered for that challenge. Use an existing Challenge row and display the result.


DECLARE
    v_challenge_id Challenge.challenge_id%TYPE;
    v_total_teams  NUMBER;
BEGIN
    SELECT MIN(challenge_id)
    INTO v_challenge_id
    FROM Challenge;

    SELECT COUNT(*)
    INTO v_total_teams
    FROM Team
    WHERE challenge_id = v_challenge_id;

    DBMS_OUTPUT.PUT_LINE('Challenge ID: ' || v_challenge_id);
    DBMS_OUTPUT.PUT_LINE('Total Teams: ' || v_total_teams);
END;
 
-- Question 2: Declare variables to store and display the name and email address of the first participant available in the Participant table.


DECLARE
    v_name  Participant.name%TYPE;
    v_email Participant.email%TYPE;
BEGIN
    SELECT name, email
    INTO v_name, v_email
    FROM Participant
    WHERE participant_id = (SELECT MIN(participant_id) FROM Participant);

    DBMS_OUTPUT.PUT_LINE('Name: ' || v_name);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
END;
 


-- Question 3: Use the addition operator (+) to calculate the combined amount of the first two prizes stored in the Prize table.


DECLARE
    v_prize1 Prize.amount%TYPE;
    v_prize2 Prize.amount%TYPE;
    v_total  NUMBER;
BEGIN
    SELECT MAX(CASE WHEN rn = 1 THEN amount END),
           MAX(CASE WHEN rn = 2 THEN amount END)
    INTO v_prize1, v_prize2
    FROM (
        SELECT amount, ROW_NUMBER() OVER (ORDER BY prize_id) rn
        FROM Prize
    );

    v_total := v_prize1 + v_prize2;
    DBMS_OUTPUT.PUT_LINE('First Prize Amount: ' || v_prize1);
    DBMS_OUTPUT.PUT_LINE('Second Prize Amount: ' || v_prize2);
    DBMS_OUTPUT.PUT_LINE('Combined Amount: ' || v_total);
END;
 

--Question 4: Use the division operator (/) to calculate the average evaluation score from the total score and evaluation count stored in the Evaluation table.


DECLARE
    v_total_score NUMBER;
    v_eval_count  NUMBER;
    v_avg_score   NUMBER;
BEGIN
    SELECT SUM(score), COUNT(*)
    INTO v_total_score, v_eval_count
    FROM Evaluation;

    IF v_eval_count > 0 THEN
        v_avg_score := v_total_score / v_eval_count;
        DBMS_OUTPUT.PUT_LINE('Total Score: ' || v_total_score);
        DBMS_OUTPUT.PUT_LINE('Evaluation Count: ' || v_eval_count);
        DBMS_OUTPUT.PUT_LINE('Calculated Average: ' || ROUND(v_avg_score, 2));
    ELSE
        DBMS_OUTPUT.PUT_LINE('No evaluation data available.');
    END IF;
END;


--Question 5: Use the UPPER function to display the first stored submission title in uppercase.


DECLARE
    v_title       Submission.title%TYPE;
    v_upper_title VARCHAR2(200);
BEGIN
    SELECT title
    INTO v_title
    FROM Submission
    WHERE submission_id = (SELECT MIN(submission_id) FROM Submission);

    v_upper_title := UPPER(v_title);
    DBMS_OUTPUT.PUT_LINE('Original Title: ' || v_title);
    DBMS_OUTPUT.PUT_LINE('Uppercase Title: ' || v_upper_title);
END;
 

--Question 6: Use the ROUND function to round the average score calculated from the Evaluation table to two decimal places.


DECLARE
    v_avg_score     NUMBER;
    v_rounded_score NUMBER;
BEGIN
    SELECT AVG(score)
    INTO v_avg_score
    FROM Evaluation;

    v_rounded_score := ROUND(v_avg_score, 2);
    DBMS_OUTPUT.PUT_LINE('Average Score: ' || v_avg_score);
    DBMS_OUTPUT.PUT_LINE('Rounded Average Score: ' || v_rounded_score);
END;


--Question 7: Use the AVG group function to find the average score of all evaluations.


DECLARE
    v_avg_score NUMBER;
BEGIN
    SELECT AVG(score)
    INTO v_avg_score
    FROM Evaluation;

    DBMS_OUTPUT.PUT_LINE('Average Evaluation Score: ' || ROUND(v_avg_score, 2));
END; 

--Question 8: Use the COUNT group function to find the total number of submissions.


DECLARE
    v_total_submissions NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_total_submissions
    FROM Submission;

    DBMS_OUTPUT.PUT_LINE('Total Submissions: ' || v_total_submissions);
END;
 

--Question 9: Write a PL/SQL block using a basic LOOP with EXIT to display all existing challenge IDs and titles.
 
 
DECLARE 
    v_current_id Challenge.challenge_id%TYPE; 
    v_last_id    Challenge.challenge_id%TYPE; 
    v_title      Challenge.title%TYPE; 
    v_exists     NUMBER; 
BEGIN 
    SELECT MIN(challenge_id), MAX(challenge_id) 
    INTO v_current_id, v_last_id 
    FROM Challenge; 
 
    LOOP 
        SELECT COUNT(*), MAX(title) 
        INTO v_exists, v_title 
        FROM Challenge 
        WHERE challenge_id = v_current_id; 
 
        IF v_exists > 0 THEN 
            DBMS_OUTPUT.PUT_LINE( 
                'Challenge ' || v_current_id || ': ' || v_title 
            ); 
        END IF; 
 
        v_current_id := v_current_id + 1; 
        EXIT WHEN v_current_id > v_last_id; 
    END LOOP; 
END;  

--Question 10: Use a FOR LOOP to display each stored challenge title and its number of registered teams.


BEGIN
    FOR rec IN (
        SELECT c.challenge_id, c.title, COUNT(t.team_id) AS total_teams
        FROM Challenge c
        LEFT JOIN Team t ON t.challenge_id = c.challenge_id
        GROUP BY c.challenge_id, c.title
        ORDER BY c.challenge_id
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.title || ' has ' || rec.total_teams || ' team(s).');
    END LOOP;
END;
 


--Question 11: Use IF-THEN-ELSIF-ELSE to classify the first stored evaluation score as 'Excellent Performance', 'Good Performance', or 'Needs Improvement'.


DECLARE
    v_score Evaluation.score%TYPE;
BEGIN
    SELECT score
    INTO v_score
    FROM Evaluation
    WHERE evaluation_id = (SELECT MIN(evaluation_id) FROM Evaluation);

    IF v_score >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('Score: ' || v_score || ' - Excellent Performance');
    ELSIF v_score >= 60 THEN
        DBMS_OUTPUT.PUT_LINE('Score: ' || v_score || ' - Good Performance');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Score: ' || v_score || ' - Needs Improvement');
    END IF;
END; 

--Question 12: Use a CASE statement to display the meaning of the status of the first stored submission.


DECLARE
    v_status Submission.status%TYPE;
BEGIN
    SELECT status
    INTO v_status
    FROM Submission
    WHERE submission_id = (SELECT MIN(submission_id) FROM Submission);

    CASE v_status
        WHEN 'Draft' THEN
            DBMS_OUTPUT.PUT_LINE('Draft - Work in progress');
        WHEN 'Submitted' THEN
            DBMS_OUTPUT.PUT_LINE('Submitted - Awaiting review');
        WHEN 'Under Review' THEN
            DBMS_OUTPUT.PUT_LINE('Under Review - Being evaluated');
        WHEN 'Scored' THEN
            DBMS_OUTPUT.PUT_LINE('Scored - Evaluation complete');
        WHEN 'Finalist' THEN
            DBMS_OUTPUT.PUT_LINE('Finalist - Selected for finals');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Unknown submission status');
    END CASE;
END; 


--Question 13: Use a single-row subquery to display the title and status of one submission having the highest evaluation score.


DECLARE
    v_title  Submission.title%TYPE;
    v_status Submission.status%TYPE;
BEGIN
    SELECT title, status
    INTO v_title, v_status
    FROM Submission
    WHERE submission_id = (
        SELECT MIN(submission_id)
        FROM Evaluation
        WHERE score = (SELECT MAX(score) FROM Evaluation)
    );
    DBMS_OUTPUT.PUT_LINE('Highest-Scoring Submission: ' || v_title);
    DBMS_OUTPUT.PUT_LINE('Status: ' || v_status);
END;

 


--Question 14: Use a multiple-row subquery with IN to display submissions whose evaluation scores are above the overall average score.


DECLARE
    v_count NUMBER := 0;
BEGIN
    FOR rec IN (
        SELECT submission_id, title, status
        FROM Submission
        WHERE submission_id IN (
            SELECT submission_id
            FROM Evaluation
            WHERE score > (SELECT AVG(score) FROM Evaluation)
        )
        ORDER BY submission_id
    ) LOOP
        v_count := v_count + 1;
        DBMS_OUTPUT.PUT_LINE(v_count || '. ' || rec.title || ' (' || rec.status || ')');
    END LOOP;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No submission has a score above the overall average.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total Found: ' || v_count);
    END IF;
END;
 


--Question 15: Use an equijoin to display submission titles with their team names and round names.


DECLARE
    v_count NUMBER := 0;
BEGIN
    FOR rec IN (
        SELECT s.title, t.team_name, r.round_name
        FROM Submission s, Team t, Round r
        WHERE s.team_id = t.team_id
          AND s.round_id = r.round_id
        ORDER BY s.submission_id
    ) LOOP
        v_count := v_count + 1;
        DBMS_OUTPUT.PUT_LINE(v_count || '. ' || rec.title ||
            ' | Team: ' || rec.team_name ||
            ' | Round: ' || rec.round_name);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Total Submissions Displayed: ' || v_count);
END; 

--Question 16: Use a left outer join to display all teams with their mentorship session dates and notes.


DECLARE
    v_count NUMBER := 0;
BEGIN
    FOR rec IN (
        SELECT t.team_name, m.session_date, m.notes
        FROM Team t
        LEFT OUTER JOIN MentorshipSession m
          ON t.team_id = m.team_id
        ORDER BY t.team_id, m.session_date
    ) LOOP
        v_count := v_count + 1;
        IF rec.session_date IS NULL THEN
            DBMS_OUTPUT.PUT_LINE(v_count || '. ' || rec.team_name ||
                ' | No mentorship session');
        ELSE
            DBMS_OUTPUT.PUT_LINE(v_count || '. ' || rec.team_name ||
                ' | Date: ' || TO_CHAR(rec.session_date, 'DD-MON-YYYY') ||
                ' | Notes: ' || rec.notes);
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Total Rows Displayed: ' || v_count);
END; 

