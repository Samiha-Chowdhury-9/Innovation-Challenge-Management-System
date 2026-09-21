
--Question 17: Create a stored function named days_left that accepts a challenge ID and returns the number of days between the current date and the challenge end date.
CREATE OR REPLACE FUNCTION days_left
(
    p_challenge_id IN Challenge.challenge_id%TYPE
)
RETURN NUMBER
AS
    v_end_date Challenge.end_date%TYPE;
BEGIN
    SELECT end_date
    INTO v_end_date
    FROM Challenge
    WHERE challenge_id = p_challenge_id;

    RETURN ROUND(v_end_date - SYSDATE);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Invalid challenge ID: ' || p_challenge_id);
        RETURN NULL;
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('More than one challenge was found.');
        RETURN NULL;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('days_left error: ' || SQLERRM);
        RETURN NULL;
END days_left;

--Test
DECLARE
    v_challenge_id Challenge.challenge_id%TYPE;
    v_days NUMBER;
BEGIN
    SELECT MIN(challenge_id)
    INTO v_challenge_id
    FROM Challenge;

    v_days := days_left(v_challenge_id);
    IF v_days IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Challenge ID: ' || v_challenge_id);
        DBMS_OUTPUT.PUT_LINE('Days Left: ' || v_days);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No challenge data is available.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Test error: ' || SQLERRM);
END;
 
--Question 18: Create a stored function named mentor_session_count that accepts a mentor participant ID and returns the number of mentorship sessions conducted by that mentor.
CREATE OR REPLACE FUNCTION mentor_session_count
(
    p_mentor_id IN Mentor.participant_id%TYPE
)
RETURN NUMBER
AS
    v_mentor_exists NUMBER;
    v_session_count NUMBER;
    e_invalid_mentor EXCEPTION;
BEGIN
    SELECT COUNT(*)
    INTO v_mentor_exists
    FROM Mentor
    WHERE participant_id = p_mentor_id;

    IF v_mentor_exists = 0 THEN
        RAISE e_invalid_mentor;
    END IF;

    SELECT COUNT(*)
    INTO v_session_count
    FROM MentorshipSession
    WHERE participant_id = p_mentor_id;

    RETURN v_session_count;
EXCEPTION
    WHEN e_invalid_mentor THEN
        DBMS_OUTPUT.PUT_LINE('Invalid mentor ID: ' || p_mentor_id);
        RETURN NULL;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('mentor_session_count error: ' || SQLERRM);
        RETURN NULL;
END mentor_session_count;

--Test
DECLARE
    v_mentor_id Mentor.participant_id%TYPE;
    v_count     NUMBER;
BEGIN
    SELECT MIN(participant_id)
    INTO v_mentor_id
    FROM Mentor;

    v_count := mentor_session_count(v_mentor_id);
    DBMS_OUTPUT.PUT_LINE('Mentor ID: ' || v_mentor_id);
    DBMS_OUTPUT.PUT_LINE('Total Sessions: ' || v_count);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No mentor data is available.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Test error: ' || SQLERRM);
END; 


--Question 19: Create a stored procedure named count_teams_in_challenge that accepts a challenge ID and returns the number of registered teams through an OUT parameter.
CREATE OR REPLACE PROCEDURE count_teams_in_challenge
(
    p_challenge_id IN  Challenge.challenge_id%TYPE,
    p_team_count   OUT NUMBER
)
AS
    v_exists NUMBER;
    e_invalid_challenge EXCEPTION;
BEGIN
    SELECT COUNT(*)
    INTO v_exists
    FROM Challenge
    WHERE challenge_id = p_challenge_id;

    IF v_exists = 0 THEN
        RAISE e_invalid_challenge;
    END IF;

    SELECT COUNT(*)
    INTO p_team_count
    FROM Team
    WHERE challenge_id = p_challenge_id;

    DBMS_OUTPUT.PUT_LINE('Challenge ' || p_challenge_id ||
                         ' has ' || p_team_count || ' team(s).');
EXCEPTION
    WHEN e_invalid_challenge THEN
        p_team_count := 0;
        DBMS_OUTPUT.PUT_LINE('Invalid challenge ID: ' || p_challenge_id);
    WHEN OTHERS THEN
        p_team_count := 0;
        DBMS_OUTPUT.PUT_LINE('count_teams_in_challenge error: ' || SQLERRM);
END count_teams_in_challenge;

--Test
DECLARE
    v_challenge_id Challenge.challenge_id%TYPE;
    v_count        NUMBER;
BEGIN
    SELECT MIN(challenge_id)
    INTO v_challenge_id
    FROM Challenge;

    count_teams_in_challenge(v_challenge_id, v_count);
    DBMS_OUTPUT.PUT_LINE('Returned Team Count: ' || v_count);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No challenge data is available.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Test error: ' || SQLERRM);
END; 

--Question 20: Create a stored procedure named get_avg_score that accepts a submission ID and returns its average evaluation score through an OUT parameter.
CREATE OR REPLACE PROCEDURE get_avg_score
(
    p_submission_id IN  Submission.submission_id%TYPE,
    p_avg_score     OUT NUMBER
)
AS
    v_exists NUMBER;
    e_invalid_submission EXCEPTION;
BEGIN
    SELECT COUNT(*)
    INTO v_exists
    FROM Submission
    WHERE submission_id = p_submission_id;

    IF v_exists = 0 THEN
        RAISE e_invalid_submission;
    END IF;

    SELECT NVL(AVG(score), 0)
    INTO p_avg_score
    FROM Evaluation
    WHERE submission_id = p_submission_id;

    DBMS_OUTPUT.PUT_LINE('Submission ' || p_submission_id ||
                         ' Average Score: ' || ROUND(p_avg_score, 2));
EXCEPTION
    WHEN e_invalid_submission THEN
        p_avg_score := 0;
        DBMS_OUTPUT.PUT_LINE('Invalid submission ID: ' || p_submission_id);
    WHEN OTHERS THEN
        p_avg_score := 0;
        DBMS_OUTPUT.PUT_LINE('get_avg_score error: ' || SQLERRM);
END get_avg_score;

--Test
DECLARE
    v_submission_id Submission.submission_id%TYPE;
    v_average       NUMBER;
BEGIN
    SELECT MIN(submission_id)
    INTO v_submission_id
    FROM Submission;

    get_avg_score(v_submission_id, v_average);
    DBMS_OUTPUT.PUT_LINE('Returned Average: ' || ROUND(v_average, 2));
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No submission data is available.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Test error: ' || SQLERRM);
END; 


--Question 21: Use a Challenge%ROWTYPE table-based record to display the details of the first available challenge.
DECLARE
    rec_challenge Challenge%ROWTYPE;
BEGIN
    SELECT *
    INTO rec_challenge
    FROM Challenge
    WHERE challenge_id = (SELECT MIN(challenge_id) FROM Challenge);

    DBMS_OUTPUT.PUT_LINE('ID: ' || rec_challenge.challenge_id);
    DBMS_OUTPUT.PUT_LINE('Title: ' || rec_challenge.title);
    DBMS_OUTPUT.PUT_LINE('Theme: ' || rec_challenge.theme);
    DBMS_OUTPUT.PUT_LINE('Status: ' || rec_challenge.status);
    DBMS_OUTPUT.PUT_LINE('Start Date: ' ||
                         TO_CHAR(rec_challenge.start_date, 'DD-MON-YYYY'));
    DBMS_OUTPUT.PUT_LINE('End Date: ' ||
                         TO_CHAR(rec_challenge.end_date, 'DD-MON-YYYY'));
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No challenge record was found.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Multiple challenge records were returned.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Question 21 error: ' || SQLERRM);
END; 

--Question 22: Use a Submission%ROWTYPE table-based record to display the details of the first available submission.
DECLARE
    rec_submission Submission%ROWTYPE;
BEGIN
    SELECT *
    INTO rec_submission
    FROM Submission
    WHERE submission_id = (SELECT MIN(submission_id) FROM Submission);

    DBMS_OUTPUT.PUT_LINE('ID: ' || rec_submission.submission_id);
    DBMS_OUTPUT.PUT_LINE('Title: ' || rec_submission.title);
    DBMS_OUTPUT.PUT_LINE('Abstract: ' || rec_submission.abstract);
    DBMS_OUTPUT.PUT_LINE('Version: ' || rec_submission.version_no);
    DBMS_OUTPUT.PUT_LINE('Status: ' || rec_submission.status);
    DBMS_OUTPUT.PUT_LINE('Team ID: ' || rec_submission.team_id);
    DBMS_OUTPUT.PUT_LINE('Round ID: ' || rec_submission.round_id);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No submission record was found.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Multiple submission records were returned.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Question 22 error: ' || SQLERRM);
END; 


--Question 23: Use an explicit cursor to display team names and their average evaluation scores in descending order.
DECLARE
    CURSOR c_team_scores IS
        SELECT t.team_name, AVG(e.score) AS avg_score
        FROM Team t, Submission s, Evaluation e
        WHERE t.team_id = s.team_id
          AND s.submission_id = e.submission_id
        GROUP BY t.team_name
        ORDER BY AVG(e.score) DESC;

    v_team_name Team.team_name%TYPE;
    v_avg_score NUMBER;
    v_count     NUMBER := 0;
BEGIN
    OPEN c_team_scores;
    LOOP
        FETCH c_team_scores INTO v_team_name, v_avg_score;
        EXIT WHEN c_team_scores%NOTFOUND;
        v_count := v_count + 1;
        DBMS_OUTPUT.PUT_LINE(v_team_name ||
                             ' | Average Score: ' || ROUND(v_avg_score, 2));
    END LOOP;
    CLOSE c_team_scores;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No evaluated team was found.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        IF c_team_scores%ISOPEN THEN
            CLOSE c_team_scores;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Question 23 error: ' || SQLERRM);
END; 

Question 24: Use an explicit cursor to display all stored submissions with their IDs, titles, and statuses.
DECLARE
    CURSOR c_submissions IS
        SELECT submission_id, title, status
        FROM Submission
        ORDER BY submission_id;

    v_id     Submission.submission_id%TYPE;
    v_title  Submission.title%TYPE;
    v_status Submission.status%TYPE;
    v_count  NUMBER := 0;
BEGIN
    OPEN c_submissions;
    LOOP
        FETCH c_submissions INTO v_id, v_title, v_status;
        EXIT WHEN c_submissions%NOTFOUND;
        v_count := v_count + 1;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_id ||
                             ' | Title: ' || v_title ||
                             ' | Status: ' || v_status);
    END LOOP;
    CLOSE c_submissions;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No submission was found.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        IF c_submissions%ISOPEN THEN
            CLOSE c_submissions;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Question 24 error: ' || SQLERRM);
END; 


--Question 25: Use a cursor-based record (%ROWTYPE) to display team rankings based on average evaluation scores.
DECLARE
    CURSOR c_team_scores IS
        SELECT t.team_name, AVG(e.score) AS avg_score
        FROM Team t, Submission s, Evaluation e
        WHERE t.team_id = s.team_id
          AND s.submission_id = e.submission_id
        GROUP BY t.team_name
        ORDER BY AVG(e.score) DESC;

    rec_team c_team_scores%ROWTYPE;
    v_count  NUMBER := 0;
BEGIN
    OPEN c_team_scores;
    LOOP
        FETCH c_team_scores INTO rec_team;
        EXIT WHEN c_team_scores%NOTFOUND;
        v_count := v_count + 1;
        DBMS_OUTPUT.PUT_LINE(v_count || '. ' || rec_team.team_name ||
                             ' | Average Score: ' ||
                             ROUND(rec_team.avg_score, 2));
    END LOOP;
    CLOSE c_team_scores;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No ranking data was found.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        IF c_team_scores%ISOPEN THEN
            CLOSE c_team_scores;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Question 25 error: ' || SQLERRM);
END; 

--Question 26: Use a parameterized cursor and cursor-based record (%ROWTYPE) to display evaluations for the first available submission.
DECLARE
    CURSOR c_eval(p_submission_id Submission.submission_id%TYPE) IS
        SELECT e.participant_id AS judge_id,
               e.score,
               e.comments
        FROM Evaluation e
        WHERE e.submission_id = p_submission_id
        ORDER BY e.evaluation_id;

    rec_eval       c_eval%ROWTYPE;
    v_submission_id Submission.submission_id%TYPE;
    v_count         NUMBER := 0;
BEGIN
    SELECT MIN(submission_id)
    INTO v_submission_id
    FROM Submission;

    OPEN c_eval(v_submission_id);
    LOOP
        FETCH c_eval INTO rec_eval;
        EXIT WHEN c_eval%NOTFOUND;
        v_count := v_count + 1;
        DBMS_OUTPUT.PUT_LINE('Judge ID: ' || rec_eval.judge_id ||
                             ' | Score: ' || rec_eval.score ||
                             ' | Comment: ' || rec_eval.comments);
    END LOOP;
    CLOSE c_eval;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No evaluation exists for submission ' ||
                             v_submission_id || '.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No submission data is available.');
    WHEN OTHERS THEN
        IF c_eval%ISOPEN THEN
            CLOSE c_eval;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Question 26 error: ' || SQLERRM);
END; 


--Question 27: Create a row-level trigger to validate that a mentorship session date is within the associated challenge period.

CREATE OR REPLACE TRIGGER trg_validate_session_date
BEFORE INSERT ON MentorshipSession
FOR EACH ROW
DECLARE
    v_start DATE;
    v_end   DATE;

    e_invalid_date EXCEPTION;
BEGIN
    SELECT c.start_date,
           c.end_date
    INTO v_start,
         v_end
    FROM Challenge c,
         Team t
    WHERE t.team_id = :NEW.team_id
      AND t.challenge_id = c.challenge_id;

    IF :NEW.session_date NOT BETWEEN v_start AND v_end THEN
        RAISE e_invalid_date;
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'Session date is valid for Team '
        || :NEW.team_id
    );

EXCEPTION
    WHEN e_invalid_date THEN
        :NEW.session_date := v_start;

        DBMS_OUTPUT.PUT_LINE(
            'Exception handled: Invalid session date.'
        );

        DBMS_OUTPUT.PUT_LINE(
            'Session date changed to '
            || TO_CHAR(v_start, 'DD-MON-YYYY')
            || '.'
        );

    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'Exception handled: Team or Challenge not found.'
        );

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(
            'Unexpected exception handled: '
            || SQLERRM
        );
END trg_validate_session_date;


--test1
INSERT INTO MentorshipSession
(
    session_date,
    notes,
    team_id,
    participant_id
)
VALUES
(
    TO_DATE('25-APR-2026', 'DD-MON-YYYY'),
    'Date correction',
    1,
    11
);
--test2
INSERT INTO MentorshipSession
(
    session_date,
    notes,
    team_id,
    participant_id
)
VALUES
(
    TO_DATE('16-DEC-2026', 'DD-MON-YYYY'),
    'Date correction',
    2,
    11
);
 

 

--Question 28: Create a row-level trigger to validate and correct a submission’s Team and Round relationship.

CREATE OR REPLACE TRIGGER trg_validate_submission_link
BEFORE INSERT OR UPDATE OF team_id, round_id
ON Submission
FOR EACH ROW
DECLARE
    v_team_challenge  NUMBER;
    v_round_challenge NUMBER;
    v_valid_round     NUMBER;

    e_invalid_link EXCEPTION;
BEGIN
    SELECT challenge_id
    INTO v_team_challenge
    FROM Team
    WHERE team_id = :NEW.team_id;

    SELECT challenge_id
    INTO v_round_challenge
    FROM Round
    WHERE round_id = :NEW.round_id;

    IF v_team_challenge <> v_round_challenge THEN
        RAISE e_invalid_link;
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'Team and Round relationship is valid.'
    );

EXCEPTION
    WHEN e_invalid_link THEN
        SELECT MIN(round_id)
        INTO v_valid_round
        FROM Round
        WHERE challenge_id = v_team_challenge;

        :NEW.round_id := v_valid_round;

        DBMS_OUTPUT.PUT_LINE(
            'Exception handled: Team and Round belonged '
            || 'to different Challenges.'
        );

        DBMS_OUTPUT.PUT_LINE(
            'Round ID changed to '
            || v_valid_round
            || '.'
        );

    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'Exception handled: Team or Round was not found.'
        );

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(
            'Unexpected exception handled: '
            || SQLERRM
        );
END trg_validate_submission_link;


--test1
UPDATE Submission
SET team_id = 1,
    round_id = 1
WHERE submission_id = 1;

--test2
UPDATE Submission
SET team_id = 1,
    round_id = 3
WHERE submission_id = 1;
 

 


--Question 29: Write a statement-level trigger named trg_challenge_update_summary that fires after an update operation on the Challenge table and displays the total number of challenges currently stored.

CREATE OR REPLACE TRIGGER trg_challenge_update_summary
AFTER UPDATE ON Challenge
DECLARE
    v_total_challenges NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_total_challenges
    FROM Challenge;

    DBMS_OUTPUT.PUT_LINE(
        'Challenge update statement completed successfully.'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Total challenges currently stored: '
        || v_total_challenges
    );

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'Exception handled: No challenge data was found.'
        );

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(
            'Unexpected exception handled: '
            || SQLERRM
        );
END trg_challenge_update_summary;

--Test1
UPDATE Challenge
SET status = status
WHERE challenge_id = 1;

--Test2
-- Invalid test: Challenge 999 does not exist
UPDATE Challenge
SET status = 'Closed'
WHERE challenge_id = 999;

 

 

--Question 30: Write a statement-level trigger named trg_submission_update_summary that fires after an update operation on the Submission table and displays the total number of submissions currently stored.

CREATE OR REPLACE TRIGGER trg_submission_update_summary
AFTER UPDATE ON Submission
DECLARE
    v_total_submissions NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_total_submissions
    FROM Submission;

    DBMS_OUTPUT.PUT_LINE(
        'Submission update statement was executed.'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Total submissions currently stored: '
        || v_total_submissions
    );

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'Exception handled: No submission data was found.'
        );

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(
            'Unexpected exception handled: '
            || SQLERRM
        );
END trg_submission_update_summary;

--Test 1
UPDATE Submission
SET status = status
WHERE submission_id = 1;

--Test 2
UPDATE Submission
SET status = 'Scored'
WHERE submission_id = 999;
 

 

--Question 31: Write a package named icms_pkg containing two procedures and two functions:
--•	Procedures: display_prize_count and close_challenge
--•	Functions: days_left and mentor_session_count

CREATE OR REPLACE PACKAGE icms_pkg
AS
    PROCEDURE display_prize_count
    (
        p_challenge_id IN NUMBER
    );

    PROCEDURE close_challenge
    (
        p_challenge_id IN NUMBER
    );

    FUNCTION days_left
    (
        p_challenge_id IN NUMBER
    )
    RETURN NUMBER;

    FUNCTION mentor_session_count
    (
        p_mentor_id IN NUMBER
    )
    RETURN NUMBER;
END icms_pkg;


--Package Body
CREATE OR REPLACE PACKAGE BODY icms_pkg
AS
    PROCEDURE display_prize_count
    (
        p_challenge_id IN NUMBER
    )
    AS
        v_challenge_count NUMBER;
        v_prize_count     NUMBER;

        e_invalid_challenge EXCEPTION;
    BEGIN
        SELECT COUNT(*)
        INTO v_challenge_count
        FROM Challenge
        WHERE challenge_id = p_challenge_id;

        IF v_challenge_count = 0 THEN
            RAISE e_invalid_challenge;
        END IF;

        SELECT COUNT(*)
        INTO v_prize_count
        FROM Prize
        WHERE challenge_id = p_challenge_id;

        DBMS_OUTPUT.PUT_LINE
        (
            'Challenge '
            || p_challenge_id
            || ' has '
            || v_prize_count
            || ' prize(s).'
        );

    EXCEPTION
        WHEN e_invalid_challenge THEN
            DBMS_OUTPUT.PUT_LINE
            (
                'Exception handled: Challenge '
                || p_challenge_id
                || ' does not exist.'
            );

        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE
            (
                'Unexpected exception handled in '
                || 'display_prize_count: '
                || SQLERRM
            );
    END display_prize_count;


    PROCEDURE close_challenge
    (
        p_challenge_id IN NUMBER
    )
    AS
        e_invalid_challenge EXCEPTION;
    BEGIN
        UPDATE Challenge
        SET status = 'Closed'
        WHERE challenge_id = p_challenge_id;

        IF SQL%NOTFOUND THEN
            RAISE e_invalid_challenge;
        END IF;

        DBMS_OUTPUT.PUT_LINE
        (
            'Challenge '
            || p_challenge_id
            || ' closed successfully.'
        );

    EXCEPTION
        WHEN e_invalid_challenge THEN
            DBMS_OUTPUT.PUT_LINE
            (
                'Exception handled: Challenge '
                || p_challenge_id
                || ' does not exist. No update performed.'
            );

        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE
            (
                'Unexpected exception handled in '
                || 'close_challenge: '
                || SQLERRM
            );
    END close_challenge;


    FUNCTION days_left
    (
        p_challenge_id IN NUMBER
    )
    RETURN NUMBER
    AS
        v_end_date  Challenge.end_date%TYPE;
        v_days_left NUMBER;
    BEGIN
        SELECT end_date
        INTO v_end_date
        FROM Challenge
        WHERE challenge_id = p_challenge_id;

        v_days_left := ROUND(v_end_date - SYSDATE);

        RETURN v_days_left;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE
            (
                'Exception handled: Challenge '
                || p_challenge_id
                || ' does not exist.'
            );

            RETURN NULL;

        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE
            (
                'Exception handled: Multiple Challenge records found.'
            );

            RETURN NULL;

        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE
            (
                'Unexpected exception handled in days_left: '
                || SQLERRM
            );

            RETURN NULL;
    END days_left;


    FUNCTION mentor_session_count
    (
        p_mentor_id IN NUMBER
    )
    RETURN NUMBER
    AS
        v_mentor_count  NUMBER;
        v_session_count NUMBER;

        e_invalid_mentor EXCEPTION;
    BEGIN
        SELECT COUNT(*)
        INTO v_mentor_count
        FROM Mentor
        WHERE participant_id = p_mentor_id;

        IF v_mentor_count = 0 THEN
            RAISE e_invalid_mentor;
        END IF;

        SELECT COUNT(*)
        INTO v_session_count
        FROM MentorshipSession
        WHERE participant_id = p_mentor_id;

        RETURN v_session_count;

    EXCEPTION
        WHEN e_invalid_mentor THEN
            DBMS_OUTPUT.PUT_LINE
            (
                'Exception handled: Mentor '
                || p_mentor_id
                || ' does not exist.'
            );

            RETURN NULL;

        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE
            (
                'Unexpected exception handled in '
                || 'mentor_session_count: '
                || SQLERRM
            );

            RETURN NULL;
    END mentor_session_count;

END icms_pkg;

--Test
DECLARE
    v_days     NUMBER;
    v_sessions NUMBER;
BEGIN
    v_days := icms_pkg.days_left(1);

    IF v_days IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE
        (
            'Days left for Challenge 1: '
            || v_days
        );
    END IF;

    v_sessions := icms_pkg.mentor_session_count(11);

    IF v_sessions IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE
        (
            'Total sessions conducted by Mentor 11: '
            || v_sessions
        );
    END IF;

    icms_pkg.display_prize_count(1);
END; 

-- Question 32: Write a package named challenge_stats_pkg containing two procedures and two functions:
-- •	Procedures: open_challenge and close_challenge
-- •	Functions: get_challenge_status and get_team_countWrite a package named challenge_stats_pkg that contains:

CREATE OR REPLACE PACKAGE challenge_stats_pkg AS

    PROCEDURE open_challenge
    (
        p_challenge_id IN NUMBER
    );

    PROCEDURE close_challenge
    (
        p_challenge_id IN NUMBER
    );

    FUNCTION get_challenge_status
    (
        p_challenge_id IN NUMBER
    )
    RETURN VARCHAR2;

    FUNCTION get_team_count
    (
        p_challenge_id IN NUMBER
    )
    RETURN NUMBER;

END challenge_stats_pkg;

CREATE OR REPLACE PACKAGE BODY challenge_stats_pkg AS

PROCEDURE open_challenge(p_challenge_id NUMBER) AS
BEGIN
 UPDATE Challenge SET status='Open'
 WHERE challenge_id=p_challenge_id;

 IF SQL%NOTFOUND THEN
  DBMS_OUTPUT.PUT_LINE('Exception handled: Challenge does not exist.');
 ELSE
  DBMS_OUTPUT.PUT_LINE('Challenge opened successfully.');
 END IF;
EXCEPTION
 WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('Exception handled: '||SQLERRM);
END;

PROCEDURE close_challenge(p_challenge_id NUMBER) AS
BEGIN
 UPDATE Challenge SET status='Closed'
 WHERE challenge_id=p_challenge_id;

 IF SQL%NOTFOUND THEN
  DBMS_OUTPUT.PUT_LINE('Exception handled: Challenge does not exist.');
 ELSE
  DBMS_OUTPUT.PUT_LINE('Challenge closed successfully.');
 END IF;
EXCEPTION
 WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('Exception handled: '||SQLERRM);
END;

FUNCTION get_challenge_status(p_challenge_id NUMBER)
RETURN VARCHAR2 AS
 v_status Challenge.status%TYPE;
BEGIN
 SELECT status INTO v_status
 FROM Challenge
 WHERE challenge_id=p_challenge_id;

 RETURN v_status;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE('Exception handled: Challenge does not exist.');
  RETURN NULL;
 WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('Exception handled: '||SQLERRM);
  RETURN NULL;
END;

FUNCTION get_team_count(p_challenge_id NUMBER)
RETURN NUMBER AS
 v_exists NUMBER;
 v_count NUMBER;
BEGIN
 SELECT COUNT(*) INTO v_exists
 FROM Challenge
 WHERE challenge_id=p_challenge_id;

 IF v_exists=0 THEN
  DBMS_OUTPUT.PUT_LINE('Exception handled: Challenge does not exist.');
  RETURN NULL;
 END IF;

 SELECT COUNT(*) INTO v_count
 FROM Team
 WHERE challenge_id=p_challenge_id;

 RETURN v_count;
EXCEPTION
 WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('Exception handled: '||SQLERRM);
  RETURN NULL;
END;

END challenge_stats_pkg;

--test1
DECLARE
    v_status VARCHAR2(20);
    v_teams  NUMBER;
BEGIN
    v_status := challenge_stats_pkg.get_challenge_status(1);
    v_teams := challenge_stats_pkg.get_team_count(1);

    DBMS_OUTPUT.PUT_LINE(
        'Challenge 1 Status: ' || v_status
    );

    DBMS_OUTPUT.PUT_LINE(
        'Challenge 1 Team Count: ' || v_teams
    );
END;

--test2
DECLARE
    v_status VARCHAR2(20);
    v_teams  NUMBER;
BEGIN
    v_status := challenge_stats_pkg.get_challenge_status(999);
    v_teams := challenge_stats_pkg.get_team_count(999);

    DBMS_OUTPUT.PUT_LINE(
        'Challenge 1 Status: ' || v_status
    );

    DBMS_OUTPUT.PUT_LINE(
        'Challenge 1 Team Count: ' || v_teams
    );
END;

 

 
