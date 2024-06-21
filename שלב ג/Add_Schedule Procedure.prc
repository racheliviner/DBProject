CREATE OR REPLACE PROCEDURE ADD_SCHEDULE (
    p_date_id IN Dates.dateID%TYPE,
    p_movie_id IN Movies.MovieID%TYPE,
    p_theater_cursor IN OUT SYS_REFCURSOR
) IS
    v_new_schedule_id Schedules.ScheduleID%TYPE;
    v_theater_id Theaters.TheaterID%TYPE;  -- Variable to hold TheaterID
    v_availableseats Schedules.Availableseats%TYPE;
BEGIN

    
    -- Calculate the new scheduleID
    SELECT NVL(MAX(ScheduleID), 0) + 1
    INTO v_new_schedule_id
    FROM Schedules;
    
    -- Fetch the first TheaterID from the cursor
    FETCH p_theater_cursor INTO v_theater_id;
    
        -- Calculate the Availableseats
    SELECT t.Capacity INTO v_availableseats
    FROM Theaters t
    WHERE t.TheaterID = v_theater_id;
    
    -- Insert new schedule into Schedules table
    INSERT INTO Schedules (ScheduleID, DateID, MovieID, TheaterID,Availableseats)
    VALUES (v_new_schedule_id, p_date_id, p_movie_id, v_theater_id, v_availableseats);
    
    -- Commit the transaction
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('New Schedule ID created: ' || v_new_schedule_id);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found in the cursor.');
    WHEN OTHERS THEN
        -- Handle exceptions
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK; -- Rollback transaction on error
        RAISE;
END ADD_SCHEDULE;
/
