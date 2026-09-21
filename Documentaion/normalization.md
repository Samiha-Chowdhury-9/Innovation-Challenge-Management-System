**1. Offers**

**UNF**

 offers (ChallengeID, Title, Theme, Startdate, Enddate, Status, Duration, PrizeID, Prizename, Amount, Rank)

**1NF** 

There is no multi valued attribute.Relation already in 1NF.

1. ChallengeID, Title, Theme, Startdate, Enddate, Status, Duration, PrizeID, Prizename, Amount, Rank

**2NF**

1. ChallengeID, Title, Theme, Startdate, Enddate, Status
2. PrizeID, Prizename, Amount, Rank

**3NF**

There is no transitive dependency. Relation already in 3NF.

1. ChallengeID, Title, Theme, Startdate, Enddate, Status
2. PrizeID, Prizename, Amount, Rank

**Table Creation**

1. ChallengeID, Title, Theme, Startdate, Enddate, Status
2. PrizeID, Prizename, Amount, Rank, **ChallengeID**

 

**2. Wins**

**UNF**

 wins (TeamID, Teamname, PrizeID, Prizename, Amount, Rank)

**1NF** 

There is no multi valued attribute. Relation already in 1NF.

1. TeamID, Teamname, PrizeID, Prizename, Amount, Rank

 

**2NF**

1. TeamID, Teamname
2. PrizeID, Prizename, Amount, Rank

**3NF** 

There is no transitive dependency. Relation already in 3NF.

1. TeamID, Teamname
2. PrizeID, Prizename, Amount, Rank

**Table Creation**

1. TeamID, Teamname
2. PrizeID, Prizename, Amount, Rank, **TeamID**

 

**3. Funds**

**UNF**

 funds (SponsorID, Sponsorname, Contributionamount, PrizeID, Prizename, Amount, Rank)

**1NF** 

There is no multi valued attribute. Relation already in 1NF.

1. SponsorID, Sponsorname, Contributionamount, PrizeID, Prizename, Amount, Rank

**2NF**

1. SponsorID, Sponsorname, Contributionamount
2. PrizeID, Prizename, Amount, Rank

**3NF** 

There is no transitive dependency. Relation already in 3NF.

1. SponsorID, Sponsorname, Contributionamount
2. PrizeID, Prizename, Amount, Rank

**Table Creation**

1. SponsorID, Sponsorname, Contributionamount
2. PrizeID, Prizename, Amount, Rank, **SponsorID**

**4. Registers**

**UNF**

registers (TeamID, Teamname, ChallengeID, Title, Theme, Startdate, Enddate, Status, Duration)

**1NF** 

There is no multi valued attribute .Relation already in 1NF.

1. TeamID, Teamname, ChallengeID, Title, Theme, Startdate, Enddate, Status, Duration

**2NF**

1. TeamID, Teamname
2. ChallengeID, Title, Theme, Startdate, Enddate, Status

**3NF** 

There is no transitive dependency. Relation already in 3NF.

1. TeamID, Teamname
2. ChallengeID, Title, Theme, Startdate, Enddate, Status

**Table Creation**

1. TeamID, Teamname, **ChallengeID**
2. ChallengeID, Title, Theme, Startdate, Enddate, Status

 

**5. HasRound**

**UNF** 

hasround (ChallengeID, Title, Theme, Startdate, Enddate, Status, Duration, RoundID, Roundnumber, Roundname)

**1NF** 

There is no multi valued attribute Relation already in 1NF.

1. ChallengeID, Title, Theme, Startdate, Enddate, Status, Duration, RoundID, Roundnumber, Roundname

**2NF**

1. ChallengeID, Title, Theme, Startdate, Enddate, Status
2. RoundID, Roundnumber, Roundname

**3NF**

There is no transitive dependency. Relation already in 3NF.

1. ChallengeID, Title, Theme, Startdate, Enddate, Status
2. RoundID, Roundnumber, Roundname

**Table Creation**

1. ChallengeID, Title, Theme, Startdate, Enddate, Status
2. RoundID, Roundnumber, Roundname, **ChallengeID**

 

**6. IsMemberOf**

**UNF** 

ismemberof (ParticipantID, Name, Email, Affiliation, Phoneno, TeamID, Teamname)

**1NF** 

Phoneno is a multi-valued attribute.

1. ParticipantID, Name, Email, Affiliation, Phoneno, TeamID, Teamname

**2NF**

1. ParticipantID, Name, Email, Affiliation
2. ParticipantID, Phoneno
3. TeamID, Teamname

**3NF**

 There is no transitive dependency. Relation already in 3NF.

1. ParticipantID, Name, Email, Affiliation
2. ParticipantID, Phoneno
3. TeamID, Teamname

**Table Creation**

1. ParticipantID, Name, Email, Affiliation
2. **ParticipantID**, Phoneno
3. TeamID, Teamname
4. **ParticipantID, TeamID**

 

**7. Submits**

**UNF**

 submits (TeamID, Teamname, SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status)

**1NF**

 There is no multi valued attribute. Relation already in 1NF.

1. TeamID, Teamname, SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status

**2NF**

1. TeamID, Teamname
2. SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status

**3NF**

 There is no transitive dependency. Relation already in 3NF.

1. TeamID, Teamname
2. SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status

**Table Creation**

1. TeamID, Teamname
2. SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status, **TeamID**

 

**8. Contains**

**UNF**

 contains (RoundID, Roundnumber, Roundname, SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status)

**1NF**

 There is no multi valued attribute. Relation already in 1NF.

1. RoundID, Roundnumber, Roundname, SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status

**2NF**

1. RoundID, Roundnumber, Roundname
2. SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status

**3NF**

 There is no transitive dependency. Relation already in 3NF.

1. RoundID, Roundnumber, Roundname
2. SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status

**Table Creation**

1. RoundID, Roundnumber, Roundname
2. SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status, **RoundID**

 

**9. Defines**

**UNF** 

defines (RoundID, Roundnumber, Roundname, CriteriaID, Criterianame)

**1NF** 

There is no multi valued attribute. Relation already in 1NF.

1. RoundID, Roundnumber, Roundname, CriteriaID, Criterianame

**2NF**

1. RoundID, Roundnumber, Roundname
2. CriteriaID, Criterianame

**3NF**

 There is no transitive dependency. Relation already in 3NF.

1. RoundID, Roundnumber, Roundname
2. CriteriaID, Criterianame

 

**Table Creation**

1. RoundID, Roundnumber, Roundname
2. CriteriaID, Criterianame, **RoundID**

 

**10. TaggedWith**

**UNF**

 taggedwith (SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status, TagID, Tagname)

**1NF** 

There is no multi valued attribute. Relation already in 1NF.

1. SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status, TagID, Tagname

 

**2NF**

1. SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status
2. TagID, Tagname

**3NF**

 There is no transitive dependency. Relation already in 3NF.

1. SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status
2. TagID, Tagname

**Table Creation**

1. SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status
2. TagID, Tagname
3. **SubmissionID**, **TagID**

 

**11. Undergoes**

**UNF** 

undergoes (SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status, EvaluationID, Score, Comments, Evaluatedat, Lockedby, Locktimestamp)

**1NF**

 There is no multi valued attribute. Relation already in 1NF.

1. SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status, EvaluationID, Score, Comments, Evaluatedat, Lockedby, Locktimestamp

**2NF**

1. SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status
2. EvaluationID, Score, Comments, Evaluatedat, Lockedby, Locktimestamp

**3NF**

 There is no transitive dependency. Relation already in 3NF.

1. SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status
2. EvaluationID, Score, Comments, Evaluatedat, Lockedby, Locktimestamp

**Table Creation**

1. SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status
2. EvaluationID, Score, Comments, Evaluatedat, Lockedby, Locktimestamp, **SubmissionID**

 

**12. AppliedIn**

**UNF**

 appliedin (CriteriaID, Criterianame, EvaluationID, Score, Comments, Evaluatedat, Lockedby, Locktimestamp)

**1NF**

There is no multi valued attribute. Relation already in 1NF.

1. CriteriaID, Criterianame, EvaluationID, Score, Comments, Evaluatedat, Lockedby, Locktimestamp

**2NF**

1. CriteriaID, Criterianame
2. EvaluationID, Score, Comments, Evaluatedat, Lockedby, Locktimestamp

**3NF**

 

 There is no transitive dependency. Relation already in 3NF.

1. CriteriaID, Criterianame
2. EvaluationID, Score, Comments, Evaluatedat, Lockedby, Locktimestamp

**Table Creation**

1. CriteriaID, Criterianame
2. EvaluationID, Score, Comments, Evaluatedat, Lockedby, Locktimestamp, **CriteriaID**

 

**13. Performs**

**UNF**

 performs (ParticipantID, Expertise, EvaluationID, Score, Comments, Evaluatedat, Lockedby, Locktimestamp)

**1NF** 

There is no multi valued attribute. Relation already in 1NF.

1. ParticipantID, Expertise, EvaluationID, Score, Comments, Evaluatedat, Lockedby, Locktimestamp

**2NF**

1. ParticipantID, Expertise
2. EvaluationID, Score, Comments, Evaluatedat, Lockedby, Locktimestamp

**3NF**

 There is no transitive dependency. Relation already in 3NF.

1. ParticipantID, Expertise
2. EvaluationID, Score, Comments, Evaluatedat, Lockedby, Locktimestamp

**Table Creation**

1. ParticipantID, Expertise
2. EvaluationID, Score, Comments, Evaluatedat, Lockedby, Locktimestamp, **ParticipantID**

 

 

**14. Receives**

**UNF**

 receives (TeamID, Teamname, SessionDate, Notes)

**1NF**

 There is no multi valued attribute. Relation already in 1NF.

1. TeamID, Teamname, SessionDate, Notes

**2NF**

1. TeamID, Teamname
2. SessionDate, Notes

**3NF** 

There is no transitive dependency. Relation already in 3NF.

1. TeamID, Teamname
2. SessionDate, Notes

**Table Creation**

1. TeamID, Teamname
2. SessionDate, Notes, **TeamID**

 

**15. Conducts**

**UNF**

 conducts (ParticipantID, Specialization, SessionDate, Notes)

**1NF** 

There is no multi valued attribute. Relation already in 1NF.

1. ParticipantID, Specialization, SessionDate, Notes

**2NF**

1. ParticipantID, Specialization
2. SessionDate, Notes

 

**3NF** 

There is no transitive dependency. Relation already in 3NF.

1. ParticipantID, Specialization
2. SessionDate, Notes

**Table Creation**

1. ParticipantID, Specialization
2. SessionDate, Notes, **ParticipantID**

 

**16. IsA**

**UNF**

 isa (ParticipantID, Name, Email, Affiliation, Phoneno, Expertise, Specialization)

**1NF** 

   Phoneno is a multi-valued attribute.

1. ParticipantID, Name, Email, Affiliation, Phoneno, Expertise, Specialization

**2NF**

1. ParticipantID, Name, Email, Affiliation
2. ParticipantID, Phoneno
3. **ParticipantID**, Expertise
4. **ParticipantID**, Specialization

**3NF**

 There is no transitive dependency. Relation already in 3NF.

1. ParticipantID, Name, Email, Affiliation
2. ParticipantID, Phoneno
3. **ParticipantID**, Expertise
4. **ParticipantID**, Specialization

**Table Creation**

 

1. ParticipantID, Name, Email, Affiliation
2. **ParticipantID**, Phoneno
3. **ParticipantID**, Expertise
4. **ParticipantID**, Specialization

 

**Temporary Tables**

1. ChallengeID, Title, Theme, Startdate, Enddate, Status
2. PrizeID, Prizename, Amount, Rank, **ChallengeID**
3. TeamID, Teamname
4. PrizeID, Prizename, Amount, Rank, **TeamID**
5. SponsorID, Sponsorname, Contributionamount
6. PrizeID, Prizename, Amount, Rank, **SponsorID**
7. TeamID, Teamname, **ChallengeID**
8. ChallengeID, Title, Theme, Startdate, Enddate, Status
9. ChallengeID, Title, Theme, Startdate, Enddate, Status
10. RoundID, Roundnumber, Roundname, **ChallengeID**
11. ParticipantID, Name, Email, Affiliation
12. **ParticipantID**, Phoneno
13. TeamID, Teamname
14. **ParticipantID**, **TeamID**
15. TeamID, Teamname
16. SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status, **TeamID**
17. RoundID, Roundnumber, Roundname
18. SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status, **RoundID**
19. RoundID, Roundnumber, Roundname
20. CriteriaID, Criterianame, **RoundID**
21. SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status
22. TagID, Tagname
23. **SubmissionID**, **TagID**
24. SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status
25. EvaluationID, Score, Comments, Evaluatedat, Lockedby, Locktimestamp, **SubmissionID**
26. CriteriaID, Criterianame
27. EvaluationID, Score, Comments, Evaluatedat, Lockedby, Locktimestamp, **CriteriaID**
28. ParticipantID, Expertise
29. EvaluationID, Score, Comments, Evaluatedat, Lockedby, Locktimestamp, **ParticipantID**
30. TeamID, Teamname
31. SessionDate, Notes, **TeamID**
32. ParticipantID, Specialization
33. SessionDate, Notes, **ParticipantID**
34. ParticipantID, Name, Email, Affiliation
35. **ParticipantID**, Phoneno
36. **ParticipantID**, Expertise
37. **ParticipantID**, Specialization

 

**Final Tables**

1. ChallengeID, Title, Theme, Startdate, Enddate, Status 
2. SponsorID, Sponsorname, Contributionamount
3. TeamID, Teamname, **ChallengeID** 
4. RoundID, Roundnumber, Roundname, **ChallengeID**
5. ParticipantID, Name, Email, Affiliation 
6. **ParticipantID**, Phoneno 
7. **ParticipantID**, **TeamID** 
8. CriteriaID, Criterianame, **RoundID** 
9. TagID, Tagname 
10. **SubmissionID**, **TagID** 
11. **ParticipantID**, Expertise 
12. **ParticipantID**, Specialization 
13. PrizeID, Prizename, Amount, Rank, **ChallengeID**, **TeamID**, **SponsorID** 
14. SubmissionID, Title, Abstract, Versionno, Submittedatdate, Status, **TeamID**, **RoundID** 
15. EvaluationID, Score, Comments, Evaluatedat, Lockedby, Locktimestamp, **SubmissionID**, **CriteriaID**, **ParticipantID**
16. SessionDate, Notes, **TeamID**, **ParticipantID** 