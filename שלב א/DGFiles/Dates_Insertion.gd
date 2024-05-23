
[General]
Version=1

[Preferences]
Username=
Password=2860
Database=
DateFormat=dd/mm/yyyy
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=RACHELI
Name=DATES
Count=400

[Record]
Name=DATEID
Type=NUMBER
Size=3
Data=Sequence(111)
Master=

[Record]
Name=HOURH
Type=VARCHAR2
Size=15
Data=Random(18, 23) + ' : ' + Random(0, 59)
Master=

[Record]
Name=DAYD
Type=VARCHAR2
Size=15
Data=List('sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat')
Master=

[Record]
Name=DATED
Type=DATE
Size=
Data=Random(1/1/2024, 30/12/2024)
Master=

