CREATE OR REPLACE PROCEDURE validar_disponibilidad (
    p_id_sala IN NUMBER,
    p_inicio  IN DATE,
    p_fin     IN DATE,
    p_ok      OUT NUMBER
) IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM reserva
    WHERE id_sala = p_id_sala
        AND estado = 'ACTIVA'
        AND (p_inicio < fecha_fin AND p_fin > fecha_inicio);

    IF v_count > 0 THEN
        p_ok := 0;
    ELSE
        p_ok := 1;
    END IF;
END;
/
