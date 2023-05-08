# Internship-5-InternshipAppDB

TASK: <br />
Create a database for tracking Internship data following instructions below.  
We are tracking internships for several generations so we need to record the start date, end date, current phase (upcoming, in process, finished) and the member who is the internship manager. Also, each field of internship has its own manager.  
Currently available fields are programming, design, multimedia and marketing, but there could be more in the future.  
Only one internship can be in process.  
Relevant information about members: name, surname, OIB, date of birth, gender, place of residence and fields of which they are a member.  
Similarly, information we need to know about interns are name, surname, OIB, date of birth, gender, place of residence, fields of which they are an intern and status for each field (intern, finished, kicked out).  
Intern upon entry cannot be older than 24 or younger than 16.  
Each field accepts a maximum of 20 members.  
Interns are graded (1-5) for each homework, by a single rectifier.  
  
After creating the database and entering test data, write the following queries:
1. Name and surname of members living outside of Split
2. Start and end date for each Internship, sorted by the start date from newer to older
3. Name and surname of each intern from 2021/2022
4. Number of female interns on this year's dev internship
5. Number of kicked out marketing interns
6. Change the place of residence for each member whose surname ends in 'in' to Moscow
7. Delete all members older than 25
8. Kick out all interns with average grade below 2.4 in the belonging field
