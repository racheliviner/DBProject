CREATE OR REPLACE FUNCTION Get_Movie_With_Max_Schedules
RETURN Movies%ROWTYPE
IS
    v_movie_record Movies%ROWTYPE;
BEGIN
    SELECT m.*
    INTO v_movie_record
    FROM Movies m
    WHERE m.MovieID = (
        SELECT MovieID
        FROM (
            SELECT s.MovieID
            FROM Schedules s
            GROUP BY s.MovieID
            ORDER BY COUNT(s.ScheduleID) DESC
        )
        WHERE ROWNUM = 1
    );
    
    RETURN v_movie_record;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Handle the case where no data is found
        DBMS_OUTPUT.PUT_LINE('No data found.');
        RETURN NULL;
    WHEN OTHERS THEN
        -- Handle any other exceptions
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END Get_Movie_With_Max_Schedules;
/
