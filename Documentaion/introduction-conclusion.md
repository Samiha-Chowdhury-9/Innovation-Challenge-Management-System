**Introduction-**

The Innovation Challenge Management System (ICMS) is designed to manage innovation competitions and hackathons. It brings all major activities into one system. Organizers can create challenges and divide them into several rounds.

Participants can register and form teams. Each team can submit its ideas or projects for different rounds. Judges can evaluate the submissions using specific scoring criteria. Mentors can guide teams through mentorship sessions.

The system also manages sponsors and prizes. It tracks team progress, submission status, scores, and winners. It can also support automatic prize allocation after judging is completed.

Overall, ICMS makes the competition process more organized, transparent, and efficient. It reduces manual work and helps organizers manage every stage from registration to prize distribution.

**Conclusion-**

This project designed the Innovation Challenge Management System (ICMS) as a relational database. The database covers the full challenge process, including challenges, rounds, teams, participants, submissions, evaluations, mentorship sessions, sponsors, and prizes.

The design also includes several important database concepts. These include a multivalued attribute, many-to-many relationships, a ternary relationship, a weak entity, and an ISA hierarchy where Judges and Mentors are modeled as subtypes of Participant.

Each relation was normalized from UNF to 1NF, 2NF, and finally 3NF. This removed repeating groups, partial dependencies, transitive dependencies, and unnecessary data duplication. As a result, the final tables are more organized, consistent, and easier to maintain.

The main business rules were implemented using PL/SQL. Row-level and statement-level triggers, stored functions, and a stored procedure with an explicit cursor were used to manage tasks such as status updates, prize allocation, and submission deadlines.

Overall, the database provides a single and reliable source of information for the complete challenge lifecycle. It connects team participation, submissions, judging, mentorship, sponsorship, and prize distribution through a consistent and well-structured database design.

**Future Work**

The system can be improved further in several ways. Materialized views could be added to make frequently used reports faster, especially reports involving challenge duration and overall performance.

The prize allocation process could also include clear tie-breaking rules when multiple teams receive the same total score. The evaluation system could be extended by introducing judge reliability weights, although this would require a fair and clearly defined method for measuring reliability.

A separate audit table and audit trigger could be added to record every change made to an evaluation. This would provide a complete history of score updates, comments, locking actions, and responsible users instead of storing only the latest lock information.

Finally, the system could be tested with many users submitting and evaluating projects at the same time. This would help confirm that the triggers, procedures, constraints, and transaction rules continue to work correctly during real competition-day activity.

 