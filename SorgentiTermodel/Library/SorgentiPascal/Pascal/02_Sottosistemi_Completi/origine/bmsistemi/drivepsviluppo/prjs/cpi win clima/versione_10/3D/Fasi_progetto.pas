unit Fasi_progetto;

interface
uses dialogs,sysutils,udatalink,udbt;
function inprete:boolean;
Function Fasiprogetto(fase:string):boolean;
implementation
uses u3dsd;
function inprete:boolean;
begin
result:=not form1.checkbox2.checked;
end;
Procedure echo(mess:string);
begin
showmessage(mess);
end;
Function Fasiprogetto(fase:string):boolean;
begin
result:=true;
fase:=Uppercase(fase);
with form1 do
  begin
  if fase='AUTOCAD' then
    begin
    if (V_recconfCad.PIANOCOR='') then
      begin
      dmtutti.T_ConfCad.Edit;
      V_recconfCad.set_PIANOCOR(V_recPia.Cod);
      dmtutti.T_ConfCad.post;
      dmtutti.T_ConfCad.Edit;
      if (V_recconfCad.PIANOCOR='') then
        begin
        //echo('Selezionare un piano da elaborare'); 
        exit;
        end;
      end;
    IF (inprete)and(V_recconfCad.ColoreTipoReteIRR='') Then
      begin
      dmtutti.T_ConfCad.Edit;
      V_recconfCad.set_ColoreTipoReteIRR(V_recgen.Codice);
      dmtutti.T_ConfCad.post;
      dmtutti.T_ConfCad.Edit;
      if (V_recconfCad.ColoreTipoReteIRR='') then
        begin
        echo('Selezionare una rete da elaborare');
        exit;
        end;
      end
    else result:=false;
    end;
 end;
end;
end.
