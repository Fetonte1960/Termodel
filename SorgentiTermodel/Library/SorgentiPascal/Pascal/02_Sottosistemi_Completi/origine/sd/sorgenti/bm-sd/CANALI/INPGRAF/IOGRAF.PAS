{************************** LOADDIS*****************************************}
Procedure LoadDis(nomedis:string);
var i:integer;

procedure initconf;

begin
  with conf do
  begin
    codTub:='ASTM';
    Rcolore:=15;
    CodTe:='TE90';
    Tlinea:=1;
    CodCurve:='CU90';
    griglia :=20;
    formato:='A1';
    Rsnap:=20;
    Terminale:=1;
    Etichetta:=1;
  end;
end;



begin
Ultriga:=1;
  if exist(nomedis+'.ret') then
  begin
    i:=1;
    assign(fi,nomedis+'.ret');reset(fi);
    while not(eof(fi)) and (i<=lungdis) do
    begin
      read(fi,dis^[i]);
      i:=i+1;
    end;
    UltRiga:=i-1;
    close(fi);
  end
  else
  begin
  Ultriga:=1;
  dis^[Ultriga].entita:='';
  end;

Nrighe:=Ultriga;

UltTronco:=1;
if exist(nomedis+'.dtr') then
  begin
  i:=1;
  assign(fr,nomedis+'.dtr');reset(fr);
  while not(eof(fr)) and (i<=lungDati) do
    begin
      read(fr,dati^[i]);
      i:=i+1;
    end;
    UltTronco:=i-1;
    close(fr);
  end
  else
    begin
    Ulttronco:=1;
    dati^[UltTronco].Ti:=0;
    end;

Ntronchi:=ultTronco;

UltGTerm:=1;
if exist(nomedis+'.ter') then
  begin
  i:=1;
  assign(fGT,nomedis+'.ter');reset(fgt);
  while not(eof(fgt)) and (i<=MaxGTErm) do
    begin
      read(fgt,GTerm^[i]);
      i:=i+1;
    end;
    UltGTerm:=i-1;
    close(fgt);
  end
  else
    begin
    UltGTerm:=1;
    GTerm^[UltGTerm].Cod:='';
    end;

NGTerm:=ultGTerm;

PieniT   :=false;
PieniD   :=false;
PieniTerm:=false;

if exist(nomedis+'.con') then
   begin
   assign(fconf,nomedis+'.con');
   reset(fconf);
   read(fconf,conf);
   close(fconf);
   end
else initconf;


end;
