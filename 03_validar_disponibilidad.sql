-- Procedimiento para crear una reserva validando la disponibilidad de la sala

CREATE OR REPLACE PROCEDURE sp_crear_reserva (
    p_id_sala IN NUMBER,
    p_id_usuario IN NUMBER,
    p_fecha_inicio IN DATE,
    p_fecha_fin IN DATE
) AS
    v_conteo NUMBER;
BEGIN
    -- Lógica de traslape: (InicioA < FinB) AND (FinA > InicioB)
    SELECT COUNT(*)
    INTO v_conteo
    FROM reserva
    WHERE id_sala = p_id_sala
      AND estado = 'ACTIVA'
      AND (p_fecha_inicio < fecha_fin AND p_fecha_fin > fecha_inicio);

    IF v_conteo > 0 THEN
        raise_application_error(-20001, 'La sala no está disponible en el horario seleccionado.');
    ELSE
        INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado)
        VALUES (seq_reserva.NEXTVAL, p_id_sala, p_id_usuario, p_fecha_inicio, p_fecha_fin, 'ACTIVA');
        
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/