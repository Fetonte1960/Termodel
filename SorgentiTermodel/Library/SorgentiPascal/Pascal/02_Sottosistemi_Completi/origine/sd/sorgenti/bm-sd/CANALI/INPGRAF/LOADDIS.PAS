{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit Load_D;

INTERFACE

uses definiz,globfunz,genproc;

Procedure LoadDis(nomedis:string);

{---------------------------------------------------------------------------}
implementation

{$I halotp4.p}

{************************** LOADDIS*****************************************}
Procedure LoadDis(nomedis:string);
var i:integer;

procedure initconf;

begin
  with conf do
  begin
    codTub:='310R';
    Rcolore:=15;
    CodTe:='3722';
    Tlinea:=1;
    codmont:='';
    CodCurve:='07';
    griglia :=20;
    Rsnap:=20;
    Terminale:=1;
    altnum:=13;
    numdia:='N';

  end;
end;

procedure InitRis;

begin
  with RisulTCalc do
  begin
    Origine:=0;
    Portata:=0;
    Perdita:=0;
    Sbil   :=0;
    Sfavor :=0;
  end;
end;



begin
write(Nomedis);
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

UltPezzo:=1;
if exist(nomedis+'.pzz') then
  begin
  i:=1;
  assign(fp,nomedis+'.pzz');reset(fp);
  while not(eof(fp)) and (i<=lungpezzi) do
    begin
      read(fp,Vpezzi^[i]);
      i:=i+1;
    end;
    Ultpezzo:=i-1;
    close(fp);
  end
  else
    begin
    Ultpezzo:=1;
    Vpezzi^[UltPezzo].Codice:='';
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

if exist(nomedis+'.ris') then
   begin
   assign(frisult,nomedis+'.ris');
   reset(frisult);
   read(frisult,RisultCalc);
   close(FRisult);
   end
else initRis;

end;



end.