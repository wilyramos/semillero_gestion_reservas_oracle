create or replace procedure cancelar_reserva (
   p_id_reserva in number,
   p_motivo     in varchar2
) is
begin
   update reserva
      set
      estado = 'CANCELADA'
    where id_reserva = p_id_reserva
      and estado <> 'FINALIZADA';

   if sql%rowcount = 0 then
      raise_application_error(
         -20001,
         'No se puede cancelar la reserva'
      );
   end if;
   insert into log_cancelacion values ( log_cancel_seq.nextval,
                                        p_id_reserva,
                                        p_motivo,
                                        sysdate );

   commit;
exception
   when others then
      rollback;
      raise;
end;
/