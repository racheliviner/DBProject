create or replace procedure emptying_Theader(TheaderNumber in out Theaters.TheaterID%type, date1 in out Dates.DateD%type) is
cursor SchedulesNeedMove is select ScheduleID from Schedules where TheaterID=TheaderNumber
 and DateID IN (select DateID from Dates where DateD = date1);
ScheduleNumber Schedules.ScheduleID%type;
TheaterNewNumber Theaters. TheaterID%type;
DateNumber Schedules.DateID%type;

v_theater_cursor SYS_REFCURSOR;

begin
 open SchedulesNeedMove;
 fetch SchedulesNeedMove into ScheduleNumber;
 loop
 exit when SchedulesNeedMove%notfound;
 select DateID into DateNumber from Schedules where ScheduleID=ScheduleNumber;
 v_theater_cursor:=Find_Available_Theaters(DateNumber);
 if v_theater_cursor%notfound then
 dbms_output.put_line( 'There is no empty hall at this time' );
 else
 -- Fetch the first TheaterID from the cursor
FETCH v_theater_cursor INTO TheaterNewNumber;  
 update Schedules set TheaterID=TheaterNewNumber where ScheduleID= ScheduleNumber;
 commit;
 dbms_output.put_line( 'new Theater ' || TheaterNewNumber);
 end if;
 fetch SchedulesNeedMove into ScheduleNumber;
 end loop;
 close SchedulesNeedMove;
end emptying_Theader;
/
