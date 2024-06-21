CREATE OR REPLACE FUNCTION Find_Available_Theaters(p_DateID NUMBER)
  RETURN SYS_REFCURSOR
IS

  -- Ref Cursor variable to return result set
  rc SYS_REFCURSOR;

  -- Variables for error handling
  v_error_code NUMBER;
  v_error_msg VARCHAR2(4000);

BEGIN
  -- Initialize ref cursor
  OPEN rc FOR
    SELECT TheaterID
    FROM Theaters
    WHERE TheaterID NOT IN (
      SELECT TheaterID
      FROM Schedules
      WHERE DateID = p_DateID
    );

  -- Return the ref cursor
  RETURN rc;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    -- Handle no data found error
    v_error_code := SQLCODE;
    v_error_msg := 'No available theaters found for DateID ' ||  p_DateID;
    DBMS_OUTPUT.PUT_LINE(v_error_msg);
    CLOSE rc;
    RETURN NULL;
  
  WHEN OTHERS THEN
    -- Handle other exceptions
    v_error_code := SQLCODE;
    v_error_msg := 'Error in FindAvailableTheaters function: '  || SQLERRM;
    DBMS_OUTPUT.PUT_LINE(v_error_msg);
    CLOSE rc;
    RETURN NULL;
END;
/
