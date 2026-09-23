 {$M 65000,16384,655360} {Turbo 3 default stack and heap}
{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{F+}

unit genproc;

Interface

uses crt,dos,definiz,globfunz;

Function NewRiga:integer;
Function Vuoto:boolean;
Function NewTR:integer;
Function NewTer:integer;
procedure initRec(indice:integer);
procedure vaga;

Implementation

{--------------------------------------------------------------------------}

{$I halotp4.p}

{****************************** NewRiga ***********************************}

Function NewRiga:integer;

var i:integer;

Begin

i:=1;
while (i<Ultriga)and(dis^[i].entita<>'') do i:=i+1;

if (i=Ultriga)and(dis^[i].entita<>'') then

  begin

  if i<lungdis then

    begin
    i:=i+1;
    Ultriga:=Ultriga+1;
    dis^[i].entita:='';
    NewRiga:=i;
    end

  else

    begin
    NewRiga:=0;
    PieniT:=true;
    end;

  end

else NewRiga:=i;

if (i=Ultriga)and(Lungdis-ultriga<=20) then
  begin
  write(chr(7));
  richiesta('');
  st1:='';
  str((lungdis-ultriga),st1);
  richiesta('Attenzione ! Potete disegnare ancora '+st1+' elementi');
  end

end;

{****************************** Vuoto *************************************}
Function Vuoto:boolean;
var i:integer;
    vuoto1:boolean;

begin
Vuoto1:=true;

i:=0;
repeat
i:=i+1;
if dis^[i].entita<>''then Vuoto1:=false;
until (Not Vuoto1)or(i=ultriga);
vuoto:=vuoto1;
end;

{****************************** NewTr *************************************}

Function NewTR:integer;
var i:integer;
Begin
i:=1;
while (i<Ulttronco)and(dati^[i].TI<>0) do i:=i+1;
if (i=Ulttronco)and(dati^[i].Ti<>0) then

  begin

  if i<lungdati then

    begin
    i:=i+1;
    UltTronco:=UltTronco+1;
    dati^[i].ti:=0;
    NewTr:=i;
    end

  else

    begin
    NewTr:=0;
    PieniD:=true;
    end;

  end

else newtr:=i;

if (i=Ulttronco)and(Lungdati-ulttronco<=20) then
  begin
  write(chr(7));
  richiesta('');
  st1:='';
  str((lungdati-ulttronco),st1);
  richiesta('Attenzione ! Potete disegnare ancora '+st1+' tronchi');
  end

end;

{****************************** NewTer *************************************}

Function NewTer:integer;
var i:integer;
Begin
i:=1;
while (i<UltGterm)and(GTerm^[i].Cod<>'') do i:=i+1;
if (i=UltGTerm)and(GTerm^[i].Cod<>'') then

  begin

  if i<MaxGTerm then

    begin
    i:=i+1;
    UltGTerm:=UltGTerm+1;
    GTerm^[i].Cod:='';
    NewTer:=i
    end

  else

    begin
    NewTer:=0;
    PieniTerm:=true;
    end;

  end

else newTer:=i;

if (i=UltGTerm)and(MaxGTerm-ultGTerm<=20) then
  begin
  write(chr(7));
  richiesta('');
  st1:='';
  str((MaxGTerm-ultGTerm),st1);
  richiesta('Attenzione ! Potete disegnare ancora '+st1+' Terminali');
  end

end;

{****************************** InitRec *************************************}

procedure initRec(indice:integer);

var i:integer;


begin

  with dati^[indice] do
  begin
    Num    :=0;
    x      :=0;
    y      :=0;
    Tipo   :=Conf.CodTub;
    lungh  :=0;
    Dh     :=0;
    diam   :=0;
    coddiam:='';
    SwDiam :='';
    port   :=0;
    porteff:=0;
    Ti     :=0;
    Term   :=0;
    for i:=1 to 6 do pros[i]:=0;
    pd     :=0;
    pl     :=0;
    pp     :=0;
    for i:=1 to 5 do
      begin
      PConc[i].N  :=0;
      PConc[i].Cod:='';
      end;
  end;
end;

{****************************** VAGA *****************************************}

procedure vaga;

begin
  st1:='';
  setclip(@minxw,@minyw,@maxxW,@maxYw);
  repeat
    readcord(x,y,cod,scelta,ST1,1);
  until scelta<>0;
end;

end.