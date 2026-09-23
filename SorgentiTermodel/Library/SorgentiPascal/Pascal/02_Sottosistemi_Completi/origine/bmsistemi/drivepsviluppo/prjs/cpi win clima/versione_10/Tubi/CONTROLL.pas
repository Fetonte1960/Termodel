Procedure ControlloInput(var ok:boolean);


type RecError=record
              Sottorete:string[8];
              terminale:string[8];
              tronco:string[4];
              descr:string[255];
              end;

elerrore=array[1..100] of recerror;




type arch=record
          descr:string[50];
          nome :string[8];
          end;
archivio=array[1..maxsot] of arch;

var it,i,nsot,nsottemp:integer;
    elsot:array[1..maxsot] of string[8];
    f:file of archivio;
    vprog:archivio;
var errore:elerrore;
    nerrore:integer;
    es, NoErrori: boolean;  //Emanuela inserita la variabile noErrori per la gestione degli erori
    fpgt:file of elerrore;
    FileErrori: TextFile;   //Emanuela variabile per il file che conterrà gli errori
    M_R:string;



Procedure InsErrore(nome,ter:string;ntronco:integer;descrer:string);

begin
echo(Descrer);
if UPstring(nome)=UpString(driveprog+numeroprog) then
   //errore[nerrore].Sottorete:= w_m(232)     {Rete pr.}
   // Emanuela 9/03/2004 modifica dei codici dei messaggi affinchè restituiscano
   // il messaggio correlato.
   errore[nerrore].Sottorete:= 'Rete pr.'
else errore[nerrore].Sottorete:=copy(nome, length(driveprog)+1, length(nome));

with errore[nerrore] do
  begin
  str(ntronco:3,tronco);
  tronco:=M_R+tronco;

  descr:=Descrer;
  Terminale:=ter;
  end;
if Nerrore < 100 then Nerrore:=Nerrore+1;
ok:=false;

end;


procedure existsottorete(nome:string;var esiste:boolean);

var i:integer;
begin
  nsot:=0;
  for i:=1 to maxsot do elsot[i]:='';
  if exist(driveprog+nome+'.sot') then
  begin
    esiste:=true;
    assign(f,driveprog+nome+'.sot');
    reset(f);
    read(f,vprog);
    i:=0;
    repeat
      i:=i+1;
      if vprog[i].nome<>''then
      begin
        elsot[i]:=vprog[i].nome;
      end;
    until (vprog[i].nome='')or (i=maxsot);
    if vprog[i].nome='' THEN i:=i-1;
    nsot:=i;
    close(f);
  end;
  if (nsot=0) then esiste:=false;
end;



procedure controlloterminali(nome:string);


procedure verificacod;

var i,j,k:integer;
    trovato:boolean;

begin
  exit;
  for i:=1 to ultgterm do
  if gterm^[i]^.cod<>'' then
  begin
    if nterm>0 then
    begin
    j:=0;
    repeat
     j:=j+1;
    until (upstring(GTerm^[i]^.cod)=upstring(Term_D^[j].cod))
          or (j=nterm);
    if (upstring(GTerm^[i]^.cod)<>upstring(Term_D^[j].cod)) then trovato:=false
    else
      begin
      trovato:=true;
      if Term_D^[j].Port <= 0 then   {--- Portata non Corretta --}
      with errore[nerrore] do
        begin
          sottorete:='';
          terminale:=GTerm^[i]^.cod;
          //descr := copy(w_m(126),1,50);    { Valore di portata scorretto }
          descr := 'Il valore di portata del terminale di codice ' + Terminale + ' del piano' +
                    GTerm^[i]^.Piano + ' è minore di zero';
          if Nerrore < 100 then Nerrore:=Nerrore+1;
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
            terminale:=GTerm^[i]^.cod;
            // Emanuela
            //descr:=copy((copy(w_m(28),1,20)+upstring(Term_D^[j].CodPerd) +copy(w_m(33),1,20)),1,50);
              {'Perdita '+upstring(Term_D^[j].CodPerd) +' inesistente'}
            descr := 'Il valore della perdita ' + Term_D^[j].CodPerd + ' del Terminale di codice ' + Terminale + ' del piano' +
                    GTerm^[i]^.Piano + ' è inesistente';
              {'Perdita '+upstring(Term_D^[j].CodPerd) +' inesistente'}
            if Nerrore < 100 then Nerrore:=Nerrore+1;
            ok:=false;
          end;
        end;
      end
    end
    else trovato:=false;
    if not trovato then
    begin
      if (nome=driveprog+numeroprog) then
      begin
        if nsot>0 then
        begin
        j:=0;
        repeat
        j:=j+1
        until (upstring(Gterm^[i]^.cod)=upstring(elsot[j]))or(gterm^[i]^.cod='')
              or (j=nsot);
        if upstring(Gterm^[i]^.cod)<>upstring(elsot[j]) then ok:=false;
      end
      else ok:=false;
        if (gterm^[i]^.cod<>'') and (not ok) then
        with errore[nerrore] do
        begin
          sottorete:='Rete pr.';
          terminale:=GTerm^[i]^.cod;
          //descr:=copy(w_m(34),1,50);       {'Codice terminale inesistente'}
          descr := 'Codice terminale inesistente';
          if Nerrore<100 then Nerrore:=Nerrore+1;
          ok:=false;
        end;
      end
      else
      if (gterm^[i]^.cod<>'') then
      with errore[nerrore] do
      begin
        sottorete:=copy(nome,length(driveprog)+1,length(nome));
        terminale:=Gterm^[i]^.cod;
        //descr:=copy(w_m(34),1,50);    {'Codice terminale inesistente'}
        descr := 'Codice terminale inesistente';
        if Nerrore<100 then Nerrore:=Nerrore+1;
       ok:=false;
      end;
    end;
 end;
end;



begin
  {loaddis(nome);}
  verificacod;
end;



procedure controllotubi(nome:string);


procedure verificatipo;
var i,j:integer;
    trovato:boolean;

begin
  trovato:=false;
  for i:=1 to ulttronco do
  if dati^[i]^.ti <> 0 then
  begin
    trovato:=true;
    if (dati^[i]^.Pros[1] = 0) and (dati^[i]^.Term = 0) then
    //inserrore(nome,'',dati^[i]^.num,copy(w_m(35),1,50));    { Manca il terminale }
    inserrore(nome,'',dati^[i]^.num,'Manca il terminale del tubo, il cui codice è: ' + IntToSTR(dati^[i]^.CodiceTubo) + ' del piano ' +  dati^[i]^.Piano);    { Manca il terminale }
    if dati^[i]^.lungh <= 0 then
    //inserrore(nome,'',dati^[i]^.num,copy(w_m(36),1,50));    { Lunghezza non corretta}
    inserrore(nome,'',dati^[i]^.num,'La lunghezza del tubo:' + IntToSTR(dati^[i]^.CodiceTubo)+ ' del piano ' +  dati^[i]^.Piano + 'non è corretta');    { Lunghezza non corretta}
    j:=0;
    repeat
    j:=j+1;
    //until ( upstring(dati^[i]^.tipo) = TipiRete_D^[j].TipoTubi) or (dati^[i]^.tipo = '')
          //or (TipiRete_D^[j].TipoTubi = '') or (j = maxtubaz);
    // Emanuela data la modifica della tabella dobbiamo riferirci a un nuovo campo
    until ( upstring(dati^[i]^.tipo) = upstring(tubaz_d^[j].cod)) or (dati^[i]^.tipo = '')
          or (tubaz_D^[j].cod = '') or (j = maxtubaz);

    if (upstring(dati^[i]^.tipo) <> upstring(tubaz_D^[j].cod)) then
    //if (upstring(dati^[i]^.tipo) <> upstring(TipiRete_D^[j].TipoTubi)) then

    begin
      if (dati^[i]^.tipo <> '') and (nome = driveprog + numeroprog) then
      begin
        with errore[nerrore] do
        begin
          sottorete:='Rete pr.';
          str(dati^[i]^.num:3,tronco);
          tronco:=M_R+tronco;
          //descr:=copy((copy(w_m(37),1,20)+upstring(dati^[i]^.tipo)+copy(w_m(33),1,20)),1,50);   {Tubazione/..../ inesistente}
          // Emanuela
          descr := 'Tipo tubazione ' + upstring(dati^[i]^.tipo) + 'del tubo di codice' + IntToSTR(dati^[i]^.CodiceTubo) + ' del piano ' +  dati^[i]^.Piano + ' inesistente';   {Tubazione/..../ inesistente}
          inserrore('', '' ,0, descr);
          if Nerrore<100 then Nerrore:=Nerrore+1;
          ok:=false;
        end;
      end
      else
      if (dati^[i]^.tipo <> '') then
      with errore[nerrore] do
      begin
        sottorete:=copy(nome,length(driveprog)+1,length(nome));
        str(dati^[i]^.num:3,tronco);
        tronco:=M_R+tronco;
        // Emanuela
         //descr:=copy((copy(w_m(37),1,20)+upstring(dati^[i]^.tipo)+copy(w_m(33),1,20)),1,50);   {Tubazione/..../ inesistente}
        descr := 'Tipo tubazione: ' + upstring(dati^[i]^.tipo) + 'del tubo di codice' + IntToSTR(dati^[i]^.CodiceTubo) + ' del piano ' +  dati^[i]^.Piano + ' inesistente';   {Tubazione/..../ inesistente}
        inserrore('', '' ,0, descr);
        if Nerrore<100 then Nerrore:=Nerrore+1;
       ok:=false;
      end;
    end;
 end;

 if not trovato then   {--- Rete vuota ---}
 begin
   //inserrore(nome,'',0,copy(w_m(39),1,50));     {}
   // Emanuela
   inserrore(nome, '' ,0, 'Rete vuota');
   inserrore('', '' ,0, 'Il calcolo non può essere effettuato');
 end;
end;

procedure verificadiam;
var i,j,k:integer;

begin
  for i:=1 to ulttronco do
  begin
   if Pos('!!!', dati^[i]^.coddiam) = 0 then
   begin
    if (dati^[i]^.swdiam = '*')and (dati^[i]^.ti <> 0) then
    begin
      j:=0;
      repeat
      j:=j+1;
      //until (upstring(dati^[i]^.tipo)=TipiRete_D^[j].TipoTubi) or (j=maxtubaz);
      until (upstring(dati^[i]^.tipo)=tubaz_d^[j].cod) or (j=maxtubaz);
      // Emanuela modificato per la modifica della tabella

      if (dati^[i]^.tipo = tubaz_d^[j].Cod)then
      begin
        k:=0;
        repeat
        k:=k+1;
        until (upstring(tubaz_d^[j].sez[k].dnom)=upstring(dati^[i]^.coddiam))
              or (k=maxsez);
        if(upstring(tubaz_d^[j].sez[k].dnom) <> upstring(dati^[i]^.coddiam)) then
        begin
          if nome = driveprog + numeroprog then
          begin
            with errore[nerrore] do
            begin
              sottorete:='Rete pr.';
              str(dati^[i]^.num:3,tronco);
              tronco:=M_R + tronco;
              // Emanuela
              // descr:=copy((copy(w_m(40),1,20)+'  '+upstring(dati^[i]^.coddiam)+copy(w_m(33),1,20)),1,50);
              descr := 'Diametro tubazione ' + upstring(dati^[i]^.coddiam) + ' del tubo di codice' + IntToSTR(dati^[i]^.CodiceTubo) + ' del piano ' +  dati^[i]^.Piano + ' è inesistente';
                {Diametro tubazione /..../ inesistente}
              inserrore('', '' ,0, descr);
              if Nerrore<100 then Nerrore:=Nerrore+1;
              ok:=false;
            end;
          end
          else
          if (dati^[i]^.tipo <> '') then
          with errore[nerrore] do
          begin
            sottorete:=copy(nome,length(driveprog)+1,length(nome));
            str(dati^[i]^.num:3,tronco);
            tronco:=M_R+tronco;
            // Emanuela
            //descr:=copy((copy(w_m(40),1,20)+'  '+upstring(dati^[i]^.coddiam)+copy(w_m(33),1,20)),1,50);
               {Diametro tubazione /..../ inesistente}
            descr := 'Diametro tubazione ' + upstring(dati^[i]^.coddiam) + 'del tubo di codice' + IntToSTR(dati^[i]^.CodiceTubo) + ' del piano ' +  dati^[i]^.Piano + ' è inesistente';
            inserrore('', '' ,0, descr);
            if Nerrore < 100 then Nerrore := Nerrore + 1;
            ok:=false;
          end;
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
  if (dati^[i]^.ti<>0) then
  begin
    for k:=1 to dati^[i]^.NPconc do
    if dati^[i]^.pconc[k].cod<>'' then
    begin
      j:=0;
      repeat
      j:=j+1;
      until ( upstring(dati^[i]^.pconc[k].cod)=upstring(Perd_d^[j].cod))
            or (perd_D^[j].cod='')or (j=maxperd);

      if (upstring(dati^[i]^.pconc[k].cod)<>upstring(perd_D^[j].cod)) then
      begin
        if (dati^[i]^.pconc[k].cod<>'')and (nome=driveprog+numeroprog) then
        begin
          with errore[nerrore] do
          begin
            sottorete:='Rete pr.';
            str(dati^[i]^.num:3,tronco);
            tronco:=M_R+tronco;
            // Emanuela
            //descr:=copy((copy(w_m(42),1,20)+' '+ upstring(dati^[i]^.pconc[k].cod)+copy(w_m(33),1,20)),1,50);
              {Codice perdita localizzata /.../ inesistente}
            descr := 'Codice perdita localizzata ' + upstring(dati^[i]^.pconc[k].cod) + ' è inesistente';
            inserrore('', '' ,0, descr);
            if Nerrore < 100 then Nerrore := Nerrore + 1;
            ok:=false;
          end;
        end
        else
        if (dati^[i]^.pconc[k].cod<>'') then
        with errore[nerrore] do
        begin
          sottorete:=copy(nome,length(driveprog)+1,length(nome));
          str(dati^[i]^.num:3,tronco);
          tronco:=M_R+tronco;
          // Emanuela
          //descr:=copy((copy(w_m(42),1,20)+' '+ upstring(dati^[i]^.pconc[k].cod)+copy(w_m(33),1,20)),1,50);
           {Codice perdita localizzata /.../ inesistente}
          descr := 'Codice perdita localizzata ' + upstring(dati^[i]^.pconc[k].cod) + ' è inesistente';
          inserrore('', '' ,0, descr);
          if Nerrore < 100 then Nerrore := Nerrore + 1;
          ok:=false;
        end;
     end;
   end;
 end;
end;



begin

{ loaddis(nome);}
  verificatipo;
  verificadiam;
  verificaperd;


end;



procedure ControlloSottoreti;


var i:integer;

begin
  for i:=1 to nsottemp do
  begin
    loaddis(driveprog+elsot[i]);
    ControlloTubi(driveprog+elsot[i]);
    ControlloTerminali(driveprog+elsot[i]);
    savedis(driveprog+elsot[i]);
    ScaricaTerm(driveprog+elsot[i]);  { Nuccio }
    if rit=2 then
    begin
      manrip:=false;
      loaddis(driveprog+elsot[i]);
      CaricaTerm(driveprog+elsot[i]);
      ControlloTubi(driveprog+elsot[i]);
      ControlloTerminali(driveprog+elsot[i]);

      savedis(driveprog+elsot[i]);
      manrip:=true;
    end;
  savelink(driveprog+elsot[i]);
  end;
end;

     {***************************   MAIN   *********************************}


begin
{$Ifdef Versione_14}
{$else}
FMainTubi.memo1.lines.clear;
{$endif}
  if wr then
  writeln(lst,'Controllo ',Manrip);
  Contr:=true;

  es:=false;
  M_R:=ch17;    { 'R' }


  if ManRip then
  begin
    Nerrore:=1;
    M_R:=ch18;    { 'M' }
    for i:=1 to 100 do
    with errore[i] do
    begin
      sottorete:='';
      terminale:='';
      tronco:='';
      descr:='';
    end;
  end;




  ok:=true;
  existsottorete(NumeroProg,es);
  if es and manrip then
  begin
    nsottemp:=nsot;
    nsot:=0;
    ControlloSottoreti;
    nsot:=nsottemp;
  end;


  loaddis(driveprog+Numeroprog);
  if ManRip then
  begin
     ControlloTubi(driveprog+Numeroprog);
     ControlloTerminali(driveprog+Numeroprog);
     ScaricaTerm(driveprog+Numeroprog);
     if es then savelink(driveprog+Numeroprog);
  end
  else
  begin
    CaricaTerm(driveprog+Numeroprog);
    ControlloTubi(driveprog+Numeroprog);
    ControlloTerminali(driveprog+Numeroprog);
    savelink(driveprog+Numeroprog);
  end;
  if es or (rit=2) then savedis(driveprog+Numeroprog);

  if (rit =1) or ((rit = 2) and (not(ManRip))) then
  begin
    assign(fpgt,PercorsoDrive + 'errori.dat');
    rewrite(fpgt);
    write(fpgt,errore);
    close(fpgt);
  end;

  Contr:=False;

  // Emanuela inserimento degli errori nel file erroriimpianti.txt
  AssignFile(FileErrori, PercorsoDrive + NomeFile_Errori_Impianti);
  Append(FileErrori);
  NoErrori := False;

  Assign(fpgt,PercorsoDrive + 'errori.dat');
  Reset(fpgt);
  Nerrore := 1;

  while not Eof(fpgt) do
  begin
    Read(fpgt, errore);
    if errore[Nerrore].descr <> '' then
    begin
      writeln(FileErrori, errore[Nerrore].descr);
      noErrori := True;
      un_errore:=true;
    end;
    inc(Nerrore);
  end;
  writeln(FileErrori, 'Il calcolo non può essere effettuato');
  Close(fpgt);
  DeleteFile(PercorsoDrive + 'errori.dat');

  if (not noErrori) then
     writeln(FileErrori, Str_Tutto_OK)
  else writeln(FileErrori, Str_Calc_No_OK);
  CloseFile(FileErrori);

end;
