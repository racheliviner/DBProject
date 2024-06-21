CREATE OR REPLACE PROCEDURE SELL_TICKETS(p_schedule_id IN TicketSales.ScheduleID%TYPE, p_num_tickets IN NUMBER)
IS
    CURSOR c_tickets IS
        SELECT TicketID FROM TicketSales
        WHERE ScheduleID = p_schedule_id
        AND IsSold = 'N'
        FOR UPDATE;
    
    v_ticket_id TicketSales.TicketID%TYPE;
    v_available_seats Schedules.AvailableSeats%TYPE;
    v_sold_tickets NUMBER := 0; -- משתנה למעקב אחרי מספר הכרטיסים שנמכרו
    v_tickets_left NUMBER := p_num_tickets; -- משתנה למעקב אחרי מספר הכרטיסים שנותרו למכירה
BEGIN
    OPEN c_tickets;
    
    LOOP
        FETCH c_tickets INTO v_ticket_id;
        EXIT WHEN c_tickets%NOTFOUND OR v_tickets_left <= 0;
        
        UPDATE TicketSales
        SET IsSold = 'Y'
        WHERE CURRENT OF c_tickets;
        
        v_sold_tickets := v_sold_tickets + 1;
        v_tickets_left := v_tickets_left - 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(  v_sold_tickets || 'Tickets where sold ' );

    CLOSE c_tickets;
    
    SELECT AvailableSeats INTO v_available_seats
    FROM Schedules
    WHERE ScheduleID = p_schedule_id;
    
    UPDATE Schedules
    SET AvailableSeats = v_available_seats - v_sold_tickets
    WHERE ScheduleID = p_schedule_id;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END SELL_TICKETS;
/
