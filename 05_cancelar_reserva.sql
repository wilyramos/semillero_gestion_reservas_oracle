-- Procedimiento para cancelar una reserva y registrar en logs

CREATE OR REPLACE PROCEDURE sp_cancelar_reserva (
    p_id_reserva IN NUMBER,
    p_motivo IN VARCHAR2
) AS
    v_estado VARCHAR2(20);
BEGIN
    -- Verificar estado actual
    SELECT estado INTO v_estado FROM reserva WHERE id_reserva = p_id_reserva;

    IF v_estado = 'FINALIZADA' THEN
        raise_application_error(-20002, 'No se puede cancelar una reserva que ya ha finalizado.');
    ELSIF v_estado = 'CANCELADA' THEN
        raise_application_error(-20003, 'La reserva ya se encuentra cancelada.');
    ELSE
        -- Actualizar estado
        UPDATE reserva SET estado = 'CANCELADA' WHERE id_reserva = p_id_reserva;

        -- Registrar en log específico de cancelación
        INSERT INTO log_cancelacion (id_log, id_reserva, motivo, fecha_cancelacion)
        VALUES (seq_log_cancelacion.NEXTVAL, p_id_reserva, p_motivo, SYSDATE);

        -- Registrar en log general
        INSERT INTO log_reserva (id_log, id_reserva, fecha_evento, descripcion)
        VALUES (seq_log_reserva.NEXTVAL, p_id_reserva, SYSDATE, 'Cancelación: ' || p_motivo);

        COMMIT;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        raise_application_error(-20004, 'ID de reserva no encontrado.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/