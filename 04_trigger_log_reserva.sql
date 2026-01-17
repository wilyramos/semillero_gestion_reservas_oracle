CREATE OR REPLACE TRIGGER trg_log_reserva_ai
AFTER INSERT ON reserva
FOR EACH ROW
BEGIN
    INSERT INTO log_reserva (id_log, id_reserva, fecha_evento, descripcion)
    VALUES (seq_log_reserva.NEXTVAL, :NEW.id_reserva, SYSDATE, 'Reserva creada exitosamente');
END;
/