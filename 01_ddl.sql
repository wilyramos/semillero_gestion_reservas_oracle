--

create table usuario (
   id_usuario     number,
   username       varchar2(50),
   password       varchar2(255),
   rol            varchar2(20),
   estado         char(1) default 'A',
   fecha_creacion date default sysdate,
   constraint pk_usuario primary key ( id_usuario ),
   constraint uq_usuario_username unique ( username ),
   constraint nn_usuario_username check ( username is not null ),
   constraint nn_usuario_password check ( password is not null ),
   constraint nn_usuario_rol check ( rol is not null ),
   constraint ck_usuario_rol check ( rol in ( 'ADMIN',
                                              'USUARIO' ) ),
   constraint ck_usuario_estado check ( estado in ( 'A',
                                                    'I' ) ),
   constraint nn_usuario_fecha check ( fecha_creacion is not null )
);


-- SALA TABLE

create table sala (
   id_sala   number,
   nombre    varchar2(100),
   capacidad number,
   estado    char(1) default 'A',
   constraint pk_sala primary key ( id_sala ),
   constraint uq_sala_nombre unique ( nombre ),
   constraint nn_sala_nombre check ( nombre is not null ),
   constraint nn_sala_capacidad check ( capacidad is not null ),
   constraint ck_sala_capacidad check ( capacidad > 0 ),
   constraint ck_sala_estado check ( estado in ( 'A',
                                                 'I' ) )
);

-- RESERVA TABLE

create table reserva (
   id_reserva   number,
   id_sala      number,
   id_usuario   number,
   fecha_inicio date,
   fecha_fin    date,
   estado       varchar2(20),

   constraint pk_reserva primary key ( id_reserva ),
   constraint nn_reserva_sala check ( id_sala is not null ),
   constraint nn_reserva_usuario check ( id_usuario is not null ),
   constraint nn_reserva_inicio check ( fecha_inicio is not null ),
   constraint nn_reserva_fin check ( fecha_fin is not null ),
   constraint nn_reserva_estado check ( estado is not null ),
   constraint ck_reserva_estado
      check ( estado in ( 'ACTIVA',
                          'CANCELADA',
                          'FINALIZADA' ) ),
   constraint ck_reserva_fechas check ( fecha_fin > fecha_inicio ),
   constraint fk_reserva_sala foreign key ( id_sala )
      references sala ( id_sala ),
   constraint fk_reserva_usuario foreign key ( id_usuario )
      references usuario ( id_usuario )
);


-- LOG_RESERVA TABLE

create table log_reserva (
   id_log       number,
   id_reserva   number,
   fecha_evento date default sysdate,
   descripcion  varchar2(200),

   constraint pk_log_reserva primary key ( id_log ),
   constraint nn_log_reserva_reserva check ( id_reserva is not null ),
   constraint nn_log_reserva_fecha check ( fecha_evento is not null ),
   constraint nn_log_reserva_desc check ( descripcion is not null ),
   constraint fk_log_reserva_reserva foreign key ( id_reserva )
      references reserva ( id_reserva )
);


-- LOG_CANCELACION TABLE

create table log_cancelacion (
   id_log            number,
   id_reserva        number,
   motivo            varchar2(200),
   fecha_cancelacion date default sysdate,

   constraint pk_log_cancelacion primary key ( id_log ),
   constraint nn_log_cancel_reserva check ( id_reserva is not null ),
   constraint nn_log_cancel_motivo check ( motivo is not null ),
   constraint nn_log_cancel_fecha check ( fecha_cancelacion is not null ),
   constraint fk_log_cancelacion_reserva foreign key ( id_reserva )
      references reserva ( id_reserva )
);