create or replace trigger trg_log_reserva after
   insert on reserva
   for each row
begin
   insert into log_reserva values ( log_reserva_seq.nextval,
                                    :new.id_reserva,
                                    sysdate,
                                    'Reserva creada' );
end;
/