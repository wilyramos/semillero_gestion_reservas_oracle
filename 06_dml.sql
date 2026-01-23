-- 1. INSERTAR ROLES
INSERT INTO rol (id_rol, nombre_rol) 
VALUES (seq_rol.NEXTVAL, 'ROLE_ADMIN');

INSERT INTO rol (id_rol, nombre_rol) 
VALUES (seq_rol.NEXTVAL, 'ROLE_USER');

-- 2. INSERTAR USUARIOS 
INSERT INTO usuario (id_usuario, username, password) 
VALUES (seq_usuario.NEXTVAL, 'admin', '$2a$10$8.UnVuG9HHgffUDAlk8qfOuVGkqRzgVymGe07xd00DMxs.7u41W3u');

INSERT INTO usuario (id_usuario, username, password) 
VALUES (seq_usuario.NEXTVAL, 'wily', '$2a$10$EblZqNptyYvcLm/S/7S7vOTjg/3Wsy8V401.T.5vFvS0.B3T7p8S.');

-- ACTUALIZAR LA CONTRASEÑA DE del admin
UPDATE usuario
SET password = '$2a$10$OigdG2yziYV4Iq0MOl8nbu3zudhpTfqvQTIjgr/0U0NMDkN8INz0W';

-- 3. ASIGNAR ROLES (USUARIO_ROL)
-- Admin (ID 1) tiene ROLE_ADMIN (ID 1)
INSERT INTO usuario_rol (id_usuario_rol, id_usuario, id_rol) 
VALUES (seq_usuario_rol.NEXTVAL, 1, 1);

-- Maria (ID 2) tiene ROLE_USER (ID 2)
INSERT INTO usuario_rol (id_usuario_rol, id_usuario, id_rol) 
VALUES (seq_usuario_rol.NEXTVAL, 2, 2);

-- 4. INSERTAR SALAS
INSERT INTO sala (id_sala, nombre, capacidad) 
VALUES (seq_sala.NEXTVAL, 'Sala de Conferencias A', 20);

INSERT INTO sala (id_sala, nombre, capacidad) 
VALUES (seq_sala.NEXTVAL, 'Sala de Juntas B', 8);

-- 5. INSERTAR RESERVAS
-- Reserva activa para Admin en Sala A
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado)
VALUES (seq_reserva.NEXTVAL, 1, 1, SYSDATE + 1, SYSDATE + 1.1, 'ACTIVA');

-- Reserva para Maria en Sala B
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado)
VALUES (seq_reserva.NEXTVAL, 2, 2, SYSDATE + 2, SYSDATE + 2.1, 'ACTIVA');

-- 6. LOGS DE RESERVA
INSERT INTO log_reserva (id_log, id_reserva, fecha_evento, descripcion)
VALUES (seq_log_reserva.NEXTVAL, 1, SYSDATE, 'Reserva inicial creada por el administrador.');


-- 7. LOGS DE CANCELACIÓN (Ejemplo de reserva cancelada)
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado)
VALUES (seq_reserva.NEXTVAL, 1, 2, SYSDATE + 5, SYSDATE + 5.1, 'CANCELADA');

INSERT INTO log_cancelacion (id_log, id_reserva, motivo, fecha_cancelacion)
VALUES (seq_log_cancelacion.NEXTVAL, 3, 'Conflicto de horario con mantenimiento', SYSDATE);

COMMIT;

/

-- INSERTS EN RESERVAS ADICIONALES
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('05-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('05-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('05-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('05-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('05-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('05-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('05-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('05-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('05-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('05-01-2026 18:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('05-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('05-01-2026 18:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('06-01-2026 08:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('06-01-2026 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('06-01-2026 08:30:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('06-01-2026 10:30:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('06-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('06-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('06-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('06-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('07-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('07-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('07-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('07-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('07-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('07-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('07-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('07-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('08-01-2026 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('08-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('08-01-2026 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('08-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('08-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('08-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('08-01-2026 15:30:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('08-01-2026 17:30:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('09-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('09-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('09-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('09-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('12-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('12-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('12-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('12-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('12-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('12-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('12-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('12-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('12-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('12-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('12-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('12-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('13-01-2026 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('13-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('13-01-2026 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('13-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('13-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('13-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('13-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('13-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('14-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('14-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('14-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('14-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('14-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('14-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('14-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('14-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('15-01-2026 08:30:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('15-01-2026 10:30:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('15-01-2026 08:30:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('15-01-2026 10:30:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('15-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('15-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('15-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('15-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('16-01-2026 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('16-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('16-01-2026 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('16-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('16-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('16-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('16-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('16-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('19-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('19-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('19-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('19-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('19-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('19-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('19-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('19-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('19-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('19-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('19-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('19-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('20-01-2026 08:30:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('20-01-2026 10:30:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('20-01-2026 08:30:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('20-01-2026 10:30:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('20-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('20-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('20-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('20-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('20-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('20-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('20-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('20-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('21-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('21-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('21-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('21-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('21-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('21-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('21-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('21-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('21-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('21-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('21-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('21-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('22-01-2026 08:30:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('22-01-2026 10:30:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('22-01-2026 08:30:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('22-01-2026 10:30:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('22-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('22-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('22-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('22-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('22-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('22-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('22-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('22-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('23-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('23-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('23-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('23-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('23-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('23-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('23-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('23-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

COMMIT;

