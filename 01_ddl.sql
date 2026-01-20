-- Borrado previo para limpieza tambien de indices y secuencias
-- eLIMINTAR TODA LA DB
DROP TRIGGER trg_log_reserva_ai;
DROP SEQUENCE seq_rol;
DROP SEQUENCE seq_usuario;
DROP SEQUENCE seq_usuario_rol;
DROP SEQUENCE seq_sala;
DROP SEQUENCE seq_reserva;
DROP SEQUENCE seq_log_reserva;
DROP SEQUENCE seq_log_cancelacion;
TRUNCATE TABLE log_cancelacion;
TRUNCATE TABLE log_reserva;
TRUNCATE TABLE reserva;
TRUNCATE TABLE sala;
TRUNCATE TABLE usuario_rol;
TRUNCATE TABLE usuario;
TRUNCATE TABLE rol;
-- 1. ROL
CREATE TABLE rol (
    id_rol      NUMBER NOT NULL,
    nombre_rol  VARCHAR2(20) NOT NULL UNIQUE,
    CONSTRAINT pk_rol PRIMARY KEY (id_rol)
);

-- 2. USUARIO
CREATE TABLE usuario (
    id_usuario  NUMBER NOT NULL,
    username    VARCHAR2(50) NOT NULL UNIQUE,
    password    VARCHAR2(255) NOT NULL,
    CONSTRAINT pk_usuario PRIMARY KEY (id_usuario)
);

-- 3. USUARIO_ROL
CREATE TABLE usuario_rol (
    id_usuario_rol NUMBER NOT NULL,
    id_usuario     NUMBER NOT NULL,
    id_rol         NUMBER NOT NULL,
    CONSTRAINT pk_usuario_rol PRIMARY KEY (id_usuario_rol),
    CONSTRAINT fk_user_rol_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),
    CONSTRAINT fk_user_rol_rol FOREIGN KEY (id_rol) REFERENCES rol (id_rol)
);


-- 4. SALA
CREATE TABLE sala (
    id_sala    NUMBER NOT NULL,
    nombre     VARCHAR2(100) NOT NULL UNIQUE,
    capacidad  NUMBER NOT NULL,
    
    CONSTRAINT pk_sala PRIMARY KEY (id_sala),
    CONSTRAINT ck_sala_capacidad CHECK (capacidad > 0)
);

-- 5. RESERVA
CREATE TABLE reserva (
    id_reserva    NUMBER NOT NULL,
    id_sala       NUMBER NOT NULL,
    id_usuario    NUMBER NOT NULL,
    fecha_inicio  DATE NOT NULL,
    fecha_fin     DATE NOT NULL,
    estado        VARCHAR2(20) NOT NULL,
    
    CONSTRAINT pk_reserva PRIMARY KEY (id_reserva),
    CONSTRAINT ck_reserva_estado CHECK (estado IN ('ACTIVA', 'CANCELADA', 'FINALIZADA')),
    CONSTRAINT ck_reserva_fechas CHECK (fecha_fin > fecha_inicio),
    CONSTRAINT fk_reserva_sala FOREIGN KEY (id_sala) REFERENCES sala (id_sala),
    CONSTRAINT fk_reserva_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
);

CREATE INDEX idx_reserva_fecha ON reserva(fecha_inicio);
CREATE INDEX idx_reserva_usuario ON reserva(id_usuario);

-- 6. LOG_RESERVA
CREATE TABLE log_reserva (
    id_log        NUMBER NOT NULL,
    id_reserva    NUMBER NOT NULL,
    fecha_evento  DATE DEFAULT sysdate NOT NULL,
    descripcion   VARCHAR2(200) NOT NULL,
    
    CONSTRAINT pk_log_reserva PRIMARY KEY (id_log),
    CONSTRAINT fk_log_reserva_reserva FOREIGN KEY (id_reserva) REFERENCES reserva (id_reserva)
);

-- 7. LOG_CANCELACION
CREATE TABLE log_cancelacion (
    id_log             NUMBER NOT NULL,
    id_reserva         NUMBER NOT NULL,
    motivo             VARCHAR2(200) NOT NULL,
    fecha_cancelacion  DATE DEFAULT sysdate NOT NULL,
    
    CONSTRAINT pk_log_cancelacion PRIMARY KEY (id_log),
    CONSTRAINT fk_log_cancelacion_reserva FOREIGN KEY (id_reserva) REFERENCES reserva (id_reserva)
);