Procedure ControlloInput(var ok:boolean);



type RecError=record
              Sottorete:string[8];
              terminale:string[8];
              tronco:integer;
              descr:string[50];
              end;

elerrore=array[1..100] of recerror;




type arch=record
          descr:string[50];
          nome :string[8];
          end;
archivio=array[1..10] of arch;

var it,i,nsot,nsottemp:integer;
    elsot:array[1..10] of string[8];
    f:file of archivio;
    vprog:archivio;
    var errore:elerrore;
    nerrore:integer;
    es:boolean;
    fpgt:file of elerrore;



Procedure InsErrore(nome,ter:string;ntronco:integer;descrer:string);

begin

if UPstring(nome)=UpString(data_drive+numeroprog) then
errore[nerrore].Sottorete:='Rete pr.'
else errore[nerrore].Sottorete:=copy(nome,length(data_drive)+1,length(nome));

with errore[nerrore] do
  begin
  tronco:=ntronco;
  descr:=Descrer;
  Terminale:=ter;
  end;
Nerrore:=Nerrore+1;
ok:=false;

end;


procedure existsottorete(nome:string;var esiste:boolean);

var i:integer;
begin
  for i:=1 to 10 do elsot[i]:='';
  if exist(data_drive+nome+'.sot') then
  begin
    esiste:=true;
    assign(f,data_drive+nome+'.sot');
    reset(f);
    read(f,vprog);
    i:=1;
    repeat
     if vprog[i].nome<>''then
     begin
     elsot[i]:=vprog[i].nome;
     i:=i+1;
     end
    until (vprog[i].nome='')or (i>10);
     i:=i-1;
    nsot:=i;
  end else nsot:=0;
end;



procedure controlloterminali(nome:string);


procedure verificacod;

var i,j,k:integer;
    trovato:boolean;

begin

  for i:=1 to ultgterm do
  if gterm^[i].cod<>'' then
  begin
    if nterm>0 then
    begin
    j:=0;
    repeat
     j:=j+1;
    until (upstring(GTerm^[i].cod)=upstring(Term_D^[j].cod))
          or (j=nterm);
    if (upstring(GTerm^[i].cod)<>upstring(Term_D^[j].cod)) then trovato:=false
    else
      begin
      trovato:=true;
      if Term_D^[j].Port<=0 then   {--- Portata non Corretta --}
      with errore[nerrore] do
        begin
          sottorete:='';
          terminale:=GTerm^[i].cod;
          descr:='Valore di portata scorretto';
          Nerrore:=Nerrore+1;
          ok:=false;
        end;
      if Term_D^[j].codPerd <>'' then
        begin
        k:=0;
        repeat
        k:=k+1;
        until (upstring(Term_D^[j].codPerd)=upstring(Perd_D^[k].cod))
            or (k=NPerd);
        if (upstring(Term_D^[j].CodPerd)<>upstring(Perd_D^[k].cod)) then
        with errore[nerrore] do
          begin
            sottorete:='';
            terminale:=GTerm^[i].cod;
            descr:='Perdita '+upstring(Term_D^[j].CodPerd) +' inesistente';
            Nerrore:=Nerrore+1;
            ok:=false;
          end;
        end;
      end
    end
    else trovato:=false;
    if not trovato then
    begin
      if (nome=data_drive+numeroprog) then
      begin
        if nsot>0 then
        begin
        j:=0;
        repeat
        j:=j+1
        until (upstring(Gterm^[i].cod)=upstring(elsot[j]))or(gterm^[i].cod='')
              or (j=nsot);
        if upstring(Gterm^[i].cod)<>upstring(elsot[j]) then ok:=false;
      end
      else ok:=false;
        if (gterm^[i].cod<>'') and (not ok) then
        with errore[nerrore] do
        begin
          sottorete:='Rete pr.';
          terminale:=GTerm^[i].cod;
          descr:='Codice terminale inesistente';
          Nerrore:=Nerrore+1;
          ok:=false;
        end;
      end
      else
      if (gterm^[i].cod<>'') then
      with errore[nerrore] do
      begin
        sottorete:=copy(nome,length(data_drive)+1,length(nome));
        terminale:=Gterm^[i].cod;
        descr:='Codice terminale inesistente';
        Nerrore:=Nerrore+1;
       ok:=false;
      end;
    end;
 end;
end;



begin
  loaddis(nome);
  verificacod;
end;



procedure controllotubi(nome:string);


procedure verificatipo;
var i,j:integer;
    trovato:boolean;

begin
trovato:=false;
  for i:=1 to ulttronco do
  if dati^[i].ti <>0 then
  begin
    trovato:=true;

    if (dati^[i].Pros[1]=0)and(dati^[i].Term=0) then
    inserrore(nome,'',dati^[i].num,'Manca il terminale');
    if dati^[i].lungh<=0 then
    inserrore(nome,'',dati^[i].num,'Lunghezza non corretta');
    j:=0;
    repeat
    j:=j+1;
    until ( upstring(dati^[i].tipo)=tubaz_d^[j].cod) or (dati^[i].tipo='')
          or (tubaz_D^[j].cod='')or (j=maxtubaz);

    if (upstring(dati^[i].tipo)<>upstring(tubaz_D^[j].cod)) then
    begin
      if (dati^[i].tipo<>'')and (nome=data_drive+numeroprog) then
      begin
        with errore[nerrore] do
        begin
          sottorete:='Rete pr.';
          tronco:=dati^[i].num;
          descr:='Tubazione '+upstring(dati^[i].tipo)+' inesistente';
          Nerrore:=Nerrore+1;
          ok:=false;
        end;
      end
      else
      if (dati^[i].tipo<>'') then
      with errore[nerrore] do
      begin
        sottorete:=copy(nome,length(data_drive)+1,length(nome));
        tronco:=dati^[i].num;
        descr:='Tubazione '+upstring(dati^[i].tipo)+' inesistente';
        Nerrore:=Nerrore+1;
       ok:=false;
      end;
    end;
 end;

if not trovato then       {--- Rete vuota ---}
inserrore(nome,'',0,'Rete inesistente');

end;

procedure verificadiam;
var i,j,k:integer;

begin
  for i:=1 to ulttronco do
  begin
    if (dati^[i].swdiam='*')and (dati^[i].ti <>0) then
    begin
      j:=0;
      repeat
      j:=j+1;
      until ( upstring(dati^[i].tipo)=tubaz_d^[j].cod) or (j=maxtubaz);

      if (dati^[i].tipo=tubaz_D^[j].cod)then
      begin
        k:=0;
        repeat
        k:=k+1;
        until (upstring(tubaz_d^[j].sez[k].dnom)=upstring(dati^[i].coddiam))
              or (k=maxsez);
        if(upstring(tubaz_d^[j].sez[k].dnom)<>upstring(dati^[i].coddiam)) then
        begin
          if nome=data_drive+numeroprog then
          begin
            with errore[nerrore] do
            begin
              sottorete:='Rete pr.';
              tronco:=dati^[i].num;
              descr:='Diametro tubazione '+upstring(dati^[i].coddiam)+' inesistente';
              Nerrore:=Nerrore+1;
              ok:=false;
            end;
          end
          else
          if (dati^[i].tipo<>'') then
          with errore[nerrore] do
          begin
            sottorete:=copy(nome,length(data_drive)+1,length(nome));
            tronco:=dati^[i].num;
            descr:='Diametro tubazione '+upstring(dati^[i].coddiam)+' inesistente';
            Nerrore:=Nerrore+1;
            ok:=false;
          end;
       end;
      end;
    end;
 end;
end;

procedure verificaperd;

var i,j,k:integer;

begin
  for i:=1 to ulttronco do
  if (dati^[i].ti<>0) then
  begin
    for k:=1 to 5 do
    if dati^[i].pconc[k].cod<>'' then
    begin
      j:=0;
      repeat
      j:=j+1;
      until ( upstring(dati^[i].pconc[k].cod)=upstring(Perd_d^[j].cod))
            or (perd_D^[j].cod='')or (j=maxperd);

      if (upstring(dati^[i].pconc[k].cod)<>upstring(perd_D^[j].cod)) then
      begin
        if (dati^[i].pconc[k].cod<>'')and (nome=data_drive+numeroprog) then
        begin
          with errore[nerrore] do
          begin
            sottorete:='Rete pr.';
            tronco:=dati^[i].num;
            descr:='Codice perdita localizzata '+ upstring(dati^[i].pconc[k].cod)+' inesistente';
            Nerrore:=Nerrore+1;
            ok:=false;
          end;
        end
        else
        if (dati^[i].pconc[k].cod<>'') then
        with errore[nerrore] do
        begin
          sottorete:=copy(nome,length(data_drive)+1,length(nome));
          tronco:=dati^[i].num;
          descr:='Codice perdita localizzata '+ upstring(dati^[i].pconc[k].cod)+' inesistente';
          Nerrore:=Nerrore+1;
          ok:=false;
        end;
     end;
   end;
 end;
end;



begin

  loaddis(nome);
  verificatipo;
  verificadiam;
  verificaperd;


end;



procedure ControlloSottoreti;


var i:integer;

begin
  for i:=1 to nsottemp do ControlloTubi(data_drive+elsot[i]);
  for i:=1 to nsottemp do ControlloTerminali(data_drive+elsot[i]);
end;



begin
  for i:=1 to 100 do
  with errore[i] do
  begin
    sottorete:='';
    terminale:='';
    tronco:=0;
    descr:='';
  end;
  es:=false;
  Nerrore:=1;
  ok:=true;
  existsottorete(NumeroProg,es);
  if es then
  begin
     nsottemp:=nsot;
     nsot:=0;
     ControlloSottoreti;
     nsot:=nsottemp;
  end;

  ControlloTubi(Data_drive+Numeroprog);
  ControlloTerminali(Data_drive+Numeroprog);




  assign(fpgt,'errori.dat');
  rewrite(fpgt);
  write(fpgt,errore);
  close(fpgt);
end;