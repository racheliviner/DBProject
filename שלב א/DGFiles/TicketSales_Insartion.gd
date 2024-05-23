
[General]
Version=1

[Preferences]
Username=
Password=2315
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=RACHELI
Name=TICKETSALES
Count=400

[Record]
Name=TICKETID
Type=NUMBER
Size=3
Data=Sequence(111)
Master=

[Record]
Name=PRICE
Type=NUMBER
Size=5,2
Data=Random(20, 150)
Master=

[Record]
Name=ISSOLD
Type=CHAR
Size=1
Data=List(N)
Master=

[Record]
Name=SCHEDULEID
Type=NUMBER
Size=3
Data=List(select scheduleid from schedules)
Master=

[Record]
Name=SUBSCRIBERID
Type=NUMBER
Size=3
Data=List(select subscriberid from subscribers)
Master=

