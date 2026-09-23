Procedure NumeraTronco(tr1:integer);

var i,x:integer;

begin

  i:=Dati^[tr1]^.Ti;

  Repeat

    pez:=dis^[i]^.Npezzo;

    if Dis^[i]^.Nlinea<>0 then {-- Curva etc.--}
     begin
     while Dati^[tr1]^.pezzi[x] <> 0 do
      begin
        with VPezzi^[Dati^[tr1]^.Pezzi[x]]^ do
        begin
           NSecPezzi:=NSecPezzi+1;
           TabDescr[1].Descr:='Numerazione pezzo ';
           str(NSecPezzi:5,TabDescr[1].valor);
           TabDescr[1].Attrib:='';
        end;
      end;
  i:=Dis^[i]^.Nlinea;

  until i=0;



if Dati^[tr1]^.PROS[1]<>0 then

  begin
  i:=0;

    {---- disegna i figli (ricorsivo)---- }

    repeat
     i:=i+1;
     if dati^[tr1]^.pros[i]<>0 then NumeraTronco(dati^[tr1]^.pros[i]);
    until (i=6)or(dati^[tr1]^.pros[i]=0);

  end;


end;

   NumeraTronco(RisultCalc^.Origine);


