DECLARE
    v_movie_id Movies.MovieID%TYPE; -- Replace with actual MovieID
    v_date_id Dates.dateID%TYPE; -- Replace with actual DateID
    v_theater_cursor SYS_REFCURSOR;

BEGIN
    select MOVIEID into v_movie_id from Movies where MovieID = &<name="Movie_Name" type="string" List="select MovieID, Title from Movies" description="yes" >;
    select DateID into v_date_id from Dates where DateD = &<name="Date" type="date" List="select DateD from Dates"> and HourH = &<name="Hour" type="string" List="select HourH from Dates">;

    -- Call function to get cursor of available theaters
    v_theater_cursor := FindAvailableTheaters( v_date_id);

    -- Call procedure to add schedule
    ADD_SCHEDULE(p_date_id => v_date_id, p_movie_id => v_movie_id, p_theater_cursor => v_theater_cursor);

EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        IF v_theater_cursor IS NOT NULL THEN
            CLOSE v_theater_cursor; -- Close cursor if an error occurs
        END IF;
        ROLLBACK;
END;

