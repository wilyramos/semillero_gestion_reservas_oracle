insert into usuario values ( usuario_seq.nextval,
                             'admin',
                             'admin123',
                             'ADMIN',
                             'A',
                             sysdate );

insert into usuario values ( usuario_seq.nextval,
                             'usuario1',
                             'user123',
                             'USUARIO',
                             'A',
                             sysdate );

insert into sala values ( sala_seq.nextval,
                          'Sala Principal',
                          20,
                          'A' );

commit;


/

SELECT * FROM usuario;