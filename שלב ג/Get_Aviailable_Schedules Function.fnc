CREATE OR REPLACE FUNCTION GET_AVAILABLE_SCHEDULES(p_movie_id IN Schedules.MovieID%TYPE)
RETURN SYS_REFCURSOR
IS
    v_ref_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_ref_cursor FOR
    SELECT ScheduleID FROM Schedules
    WHERE MovieID = p_movie_id
    AND AvailableSeats > 0;
    
    RETURN v_ref_cursor;
END GET_AVAILABLE_SCHEDULES;
/
