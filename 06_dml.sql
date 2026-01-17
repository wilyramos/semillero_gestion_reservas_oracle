-- 1. INSERTAR ROLES
INSERT INTO rol (id_rol, nombre_rol) 
VALUES (seq_rol.NEXTVAL, 'ROLE_ADMIN');

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