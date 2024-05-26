
[General]
Version=1

[Preferences]
Username=
Password=2073
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=RACHELI
Name=SCHEDULES
Count=400

[Record]
Name=SCHEDULEID
Type=NUMBER
Size=3
Data=Sequence(100)
Master=

[Record]
Name=AVAILABLESEATS
Type=NUMBER
Size=
Data=List(0)
Master=

[Record]
Name=MOVIEID
Type=NUMBER
Size=3
Data=List(select MOVIEID from MOVIES)
Master=

[Record]
Name=THEATERID
Type=NUMBER
Size=3
Data=List(select THEATERID from THEATERS)
Master=

[Record]
Name=DATEID
Type=NUMBER
Size=3
Data=List(select DATEID from DATES)
Master=

