CREATE OR REPLACE PACKAGE RESERVAS.pkg_reservas AS

    FUNCTION fn_sala_disponible (
        p_id_sala       IN NUMBER,
        p_fecha_inicio  IN DATE,
        p_fecha_fin     IN DATE
    ) RETURN BOOLEAN;

    PROCEDURE pr_crear_reserva (
        p_id_sala       IN NUMBER,
        p_id_usuario    IN NUMBER,
        p_fecha_inicio  IN DATE,
        p_fecha_fin     IN DATE,
        p_codigo_salida OUT NUMBER,
        p_mensaje_salida OUT VARCHAR2
    );

    PROCEDURE pr_cancelar_reserva (
        p_id_reserva    IN NUMBER,
        p_motivo        IN VARCHAR2,
        p_codigo_salida OUT NUMBER,
        p_mensaje_salida OUT VARCHAR2
    );

    PROCEDURE pr_cambiar_estado (
        p_id_reserva    IN NUMBER,
        p_estado        IN VARCHAR2
    );

END pkg_reservas;

CREATE OR REPLACE PACKAGE BODY RESERVAS.pkg_reservas AS

    CURSOR c_reservas_activas (
        p_id_sala NUMBER
    ) IS
        SELECT fecha_inicio, fecha_fin
        FROM reserva
        WHERE id_sala = p_id_sala
          AND estado = 'ACTIVA';

    FUNCTION fn_sala_disponible (
        p_id_sala       IN NUMBER,
        p_fecha_inicio  IN DATE,
        p_fecha_fin     IN DATE
    ) RETURN BOOLEAN IS
    BEGIN
        FOR r IN c_reservas_activas(p_id_sala) LOOP
            IF p_fecha_inicio < r.fecha_fin
               AND p_fecha_fin > r.fecha_inicio THEN
                RETURN FALSE;
            END IF;
        END LOOP;
        RETURN TRUE;
    END fn_sala_disponible;

    PROCEDURE pr_crear_reserva (
        p_id_sala       IN NUMBER,
        p_id_usuario    IN NUMBER,
        p_fecha_inicio  IN DATE,
        p_fecha_fin     IN DATE,
        p_codigo_salida OUT NUMBER,     
        p_mensaje_salida OUT VARCHAR2   
    ) IS
        v_count NUMBER;
    BEGIN
        -- Inicializar
        p_codigo_salida := 0;
        p_mensaje_salida := 'Reserva creada correctamente';

        -- Validar que sala existe
        SELECT COUNT(*) INTO v_count FROM sala WHERE id_sala = p_id_sala;
        IF v_count = 0 THEN
            p_codigo_salida := 6;
            p_mensaje_salida := 'La sala especificada no existe';
            RETURN;
        END IF;
        
        -- Validar que usuario existe
        SELECT COUNT(*) INTO v_count FROM usuario WHERE id_usuario = p_id_usuario;
        IF v_count = 0 THEN
            p_codigo_salida := 7;
            p_mensaje_salida := 'El usuario especificado no existe';
            RETURN;
        END IF;
        
        -- Validación de fechas
        IF p_fecha_fin <= p_fecha_inicio THEN
            p_codigo_salida := 1;
            p_mensaje_salida := 'La fecha fin debe ser mayor que la fecha inicio';
            RETURN;
        END IF;

        -- Validar disponibilidad
        IF NOT fn_sala_disponible(p_id_sala, p_fecha_inicio, p_fecha_fin) THEN
            p_codigo_salida := 2;
            p_mensaje_salida := 'La sala no está disponible en el rango seleccionado';
            RETURN;
        END IF;

        -- Insertar reserva
        INSERT INTO reserva (
            id_reserva,
            id_sala,
            id_usuario,
            fecha_inicio,
            fecha_fin,
            estado
        ) VALUES (
            seq_reserva.NEXTVAL,
            p_id_sala,
            p_id_usuario,
            p_fecha_inicio,
            p_fecha_fin,
            'ACTIVA'
        );

        COMMIT;

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            p_codigo_salida := 99;
            p_mensaje_salida := 'Error: ' || SQLERRM;
    END pr_crear_reserva;

    PROCEDURE pr_cancelar_reserva (
        p_id_reserva    IN NUMBER,
        p_motivo        IN VARCHAR2,
        p_codigo_salida OUT NUMBER,     
        p_mensaje_salida OUT VARCHAR2 
    ) IS
        v_estado reserva.estado%TYPE;
    BEGIN
        -- Inicializar
        p_codigo_salida := 0;
        p_mensaje_salida := 'Reserva cancelada correctamente';

        SELECT estado
        INTO v_estado
        FROM reserva
        WHERE id_reserva = p_id_reserva
        FOR UPDATE;

        IF v_estado = 'FINALIZADA' THEN
            p_codigo_salida := 3;
            p_mensaje_salida := 'No se puede cancelar una reserva finalizada';
            RETURN;
        ELSIF v_estado = 'CANCELADA' THEN
            p_codigo_salida := 4;
            p_mensaje_salida := 'La reserva ya se encuentra cancelada';
            RETURN;
        END IF;

        UPDATE reserva
        SET estado = 'CANCELADA'
        WHERE id_reserva = p_id_reserva;

        INSERT INTO log_cancelacion (
            id_log,
            id_reserva,
            motivo,
            fecha_cancelacion
        ) VALUES (
            seq_log_cancelacion.NEXTVAL,
            p_id_reserva,
            p_motivo,
            SYSDATE
        );

        COMMIT;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_codigo_salida := 5;
            p_mensaje_salida := 'Reserva no encontrada';
        WHEN OTHERS THEN
            ROLLBACK;
            p_codigo_salida := 99;
            p_mensaje_salida := 'Error: ' || SQLERRM;
    END pr_cancelar_reserva;

    PROCEDURE pr_cambiar_estado (
        p_id_reserva    IN NUMBER,
        p_estado        IN VARCHAR2
    ) IS
    BEGIN
        UPDATE reserva
        SET estado = p_estado
        WHERE id_reserva = p_id_reserva;

        IF SQL%ROWCOUNT = 0 THEN
            raise_application_error(
                -20006,
                'Reserva no encontrada.'
            );
        END IF;

        COMMIT;

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END pr_cambiar_estado;

END pkg_reservas;
