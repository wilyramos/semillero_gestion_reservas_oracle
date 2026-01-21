-- 1. INSERTAR ROLES
INSERT INTO rol (id_rol, nombre_rol) 
VALUES (seq_rol.NEXTVAL, 'ROLE_ADMIN');

INSERT INTO rol (id_rol, nombre_rol) 
VALUES (seq_rol.NEXTVAL, 'ADMIN');

INSERT INTO rol (id_rol, nombre_rol) 
VALUES (seq_rol.NEXTVAL, 'ROLE_USER');

-- 2. INSERTAR USUARIOS 
-- Nota: El password es 'admin123' y 'user456' encriptados con BCrypt
INSERT INTO usuario (id_usuario, username, password) 
VALUES (seq_usuario.NEXTVAL, 'admin', '$2a$10$8.UnVuG9HHgffUDAlk8qfOuVGkqRzgVymGe07xd00DMxs.7u41W3u');

INSERT INTO usuario (id_usuario, username, password) 
VALUES (seq_usuario.NEXTVAL, 'maria_sanchez', '$2a$10$EblZqNptyYvcLm/S/7S7vOTjg/3Wsy8V401.T.5vFvS0.B3T7p8S.');

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
-- Primero creamos una reserva para cancelarla
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado)
VALUES (seq_reserva.NEXTVAL, 1, 2, SYSDATE + 5, SYSDATE + 5.1, 'CANCELADA');

INSERT INTO log_cancelacion (id_log, id_reserva, motivo, fecha_cancelacion)
VALUES (seq_log_cancelacion.NEXTVAL, 3, 'Conflicto de horario con mantenimiento', SYSDATE);

COMMIT;

-- VER LOS DATOS INSERTADOS
SELECT * FROM rol;
SELECT * FROM usuario;
SELECT * FROM usuario_rol;
SELECT * FROM sala;
SELECT * FROM reserva;

-- JOIN PARA VER LOS USUARIOS CON SUS ROLES
SELECT u.username, r.nombre_rol
FROM usuario u
JOIN usuario_rol ur ON u.id_usuario = ur.id_usuario
JOIN rol r ON ur.id_rol = r.id_rol;

-- ACTUALIZAR CONTRASEÑA DE UN USUARIO (Ejemplo)

UPDATE usuario
SET password = '$2a$10$.5lXX3HzP2GXD.z3pMp7HOXeIAiYPTYWon.dIRnaJv6.OVNzaokI6';

COMMIT;

select * from log_reserva;
select * from log_cancelacion;

-- Cancelar todas las reservas
UPDATE reserva
SET estado = 'CANCELADA'
WHERE estado = 'ACTIVA';


/

-- SEMANA 1: DEL 1 AL 2 DE ENERO (JUEVES Y VIERNES)
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('01-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('01-01-2026 09:30:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2026 11:30:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('01-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('01-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('01-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('01-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2026 18:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('02-01-2026 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('02-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('02-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('02-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('02-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('02-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

-- SEMANA 2: DEL 5 AL 9 DE ENERO
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('05-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('05-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('05-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('05-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('05-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('05-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('05-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('05-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('05-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('05-01-2026 18:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('06-01-2026 09:30:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('06-01-2026 11:30:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('06-01-2026 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('06-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('06-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('06-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('06-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('06-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('06-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('06-01-2026 19:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('07-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('07-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('07-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('07-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('07-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('07-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('07-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('07-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('07-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('07-01-2026 19:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('08-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('08-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('08-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('08-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('08-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('08-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('08-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('08-01-2026 18:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('09-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('09-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('09-01-2026 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('09-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('09-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('09-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('09-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('09-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

-- SEMANA 3: DEL 12 AL 16 DE ENERO
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('12-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('12-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('12-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('12-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('12-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('12-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('12-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('12-01-2026 18:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('13-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('13-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('13-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('13-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('13-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('13-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('13-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('13-01-2026 19:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('14-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('14-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('14-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('14-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('14-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('14-01-2026 18:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('15-01-2026 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('15-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('15-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('15-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('15-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('15-01-2026 19:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('16-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('16-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('16-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('16-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

COMMIT;


/


-- SEMANA 1: SIMULTANEIDAD TOTAL
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('05-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('05-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('05-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('05-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('05-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('05-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('05-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('05-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('05-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('05-01-2026 18:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('05-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('05-01-2026 18:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

-- SEMANA 1: MARTES 06
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('06-01-2026 08:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('06-01-2026 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('06-01-2026 08:30:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('06-01-2026 10:30:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('06-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('06-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('06-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('06-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

-- SEMANA 1: MIÉRCOLES 07
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('07-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('07-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('07-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('07-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('07-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('07-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('07-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('07-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

-- SEMANA 1: JUEVES 08
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('08-01-2026 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('08-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('08-01-2026 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('08-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('08-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('08-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('08-01-2026 15:30:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('08-01-2026 17:30:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

-- SEMANA 1: VIERNES 09
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('09-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('09-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('09-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('09-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

-- SEMANA 2: LUNES 12
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('12-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('12-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('12-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('12-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('12-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('12-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('12-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('12-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('12-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('12-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('12-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('12-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

-- SEMANA 2: MARTES 13
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('13-01-2026 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('13-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('13-01-2026 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('13-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('13-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('13-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('13-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('13-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

-- SEMANA 2: MIÉRCOLES 14
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('14-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('14-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('14-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('14-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('14-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('14-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('14-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('14-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

-- SEMANA 2: JUEVES 15
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('15-01-2026 08:30:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('15-01-2026 10:30:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('15-01-2026 08:30:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('15-01-2026 10:30:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 2, TO_DATE('15-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('15-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 1, TO_DATE('15-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('15-01-2026 13:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

-- SEMANA 2: VIERNES 16
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('16-01-2026 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('16-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('16-01-2026 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('16-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('16-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('16-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('16-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('16-01-2026 16:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

-- EXTRAS PARA LLEGAR A 50
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('19-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('19-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('19-01-2026 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('19-01-2026 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('19-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('19-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('19-01-2026 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('19-01-2026 14:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 1, 1, TO_DATE('19-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('19-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');
INSERT INTO reserva (id_reserva, id_sala, id_usuario, fecha_inicio, fecha_fin, estado) VALUES (seq_reserva.NEXTVAL, 2, 2, TO_DATE('19-01-2026 15:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('19-01-2026 17:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'ACTIVA');

COMMIT;