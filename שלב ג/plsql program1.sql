DECLARE
    v_movie_id Movies.MovieID%TYPE;
    v_ref_cursor SYS_REFCURSOR;
    v_schedule_id Schedules.ScheduleID%TYPE;
    v_num_tickets NUMBER := &"num_of_tickets";
BEGIN
    select MOVIEID into v_movie_id from Movies where MovieID = &<name="Movie_Name" type="string" List="select MovieID, Title from Movies" description="yes" >;


    v_ref_cursor := GET_AVAILABLE_SCHEDULES(v_movie_id);
    
    LOOP
        FETCH v_ref_cursor INTO v_schedule_id;
        EXIT WHEN v_ref_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Available Schedule ID: ' || v_schedule_id);
        SELL_TICKETS(v_schedule_id, v_num_tickets);
    END LOOP;
    
    CLOSE v_ref_cursor;
END;



