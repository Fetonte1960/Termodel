{$C DEMANDLOAD}
unit Debug;

INTERFACE

uses definiz,globfunz,genproc{$ifdef win},winprocs{$endif};

procedure Deb(Orig:integer);
Procedure Contr_Pezzi;
procedure Test(nomef:string);

{---------------------------------------------------------------------------}
implementation

Var fdebug,fgraf:text;
    errore:boolean;

procedure Deb(Orig:integer);
Var j,colonna:integer;


procedure IterDeb(Tr:integer);

var i,Count:integer;
    unovuoto:integer;

begin
write(FGraf,'Tronco:',tr);
for i:=1 to 3 do
if Dati^[tr]^.Pros[i]<>0 then
write(FGraf,' =>',Dati^[tr]^.Pros[i]);
writeln(FGraf);

unovuoto:=0;
for i:=1 to PezziTr do
  begin
  if Dati^[tr]^.Pezzi[i]<>0  then
    begin
    if unovuoto<>0 then
      begin
      Writeln(fdebug,'Pezzo Irregolare:intermedio a zero');
      errore:=true;
      end;

    if Dati^[tr]^.Pezzi[i] <= UltPezzo then
      begin
      if VPezzi^[Dati^[tr]^.Pezzi[i]]^.Codice='' then
        begin
        Writeln(fdebug,'Pezzo Irregolare:codice vuoto');
        errore:=true;
        end;
      end
    else
      begin
      Writeln(fdebug,'Pezzo Irregolare:indice fuori range.');
      errore:=true;
      end;
    end
  else unovuoto:=i;

  end;



Count:=0;
i:=Dati^[tr]^.ti;
if i=0 then
begin
Writeln(fdebug,'Tronco Irregolare:Mancano linee.');
errore:=true;
end
else
repeat
if (i>0) and(i<=Ultriga) then
  begin
  if Dis^[i]^.Entita='' then
    begin
    Writeln(fdebug,'Linea Irregolare:Manca Entita');
    errore:=true;
    i:=0;
    end
  else
    begin
    if Dis^[i]^.tlinea=1 then
      begin
      Writeln(fdebug,'Due tronchi fanno riferimento alla stessa linea');
      errore:=true;
      i:=0;
      end
    else
      begin
      if dis^[i]^.tronco<> tr then
        begin
        Writeln(fdebug,'linea non punta al suo tronco');
        errore:=true;
        i:=0;
        end
      else
        begin
        Dis^[i]^.tlinea:=1;
        Count:=Count+1;
        i:=Dis^[i]^.Nlinea;
        end;
      end;
    end
  end
else
  begin
  Writeln(fdebug,'Linea Irregolare:indice fuori range.');
  errore:=true;

  i:=0;
  end;

until i=0;

for i:=1  to 3 do
if Dati^[tr]^.Pros[i]<>0 then
  begin
  if (Dati^[tr]^.Pros[i]>0)and(Dati^[tr]^.Pros[i]<=UltTronco) then
    begin
    if  Dati^[Dati^[tr]^.Pros[i]]^.Ti<>0 then
      begin
      if  Dati^[Dati^[tr]^.Pros[i]]^.pros[6]=1 then
        begin
        Dati^[Dati^[tr]^.Pros[i]]^.pros[6]:=0;

        IterDeb(Dati^[tr]^.Pros[i]);
        end
      else
        begin
        Writeln(fdebug,'Tronco ',i,' punta ad un tronco gia utilizzato');
        errore:=true;
        end
      end
    else
      begin
      Writeln(fdebug,'Tronco ',i,' punta ad un tronco senza linee');
      errore:=true;
      end;
    end
  else
    begin
    Writeln(fdebug,'Figlio Irregolare:indice fuori range.');
    errore:=true;
    end;
  end;

end;

begin

For j:=1 to ultriga do
  begin
  dis^[j]^.tlinea:=0;
 {dis^[j]^.Color:=15;    tra commento tutto cio che riguarda colore davide}
  end;
For j:=1 to ulttronco do dati^[j]^.pros[6]:=1;

if orig=0 then orig:=RisultCalc^.Origine;
if orig<>0 then
  begin
  IterDeb(orig);
  end
else
  begin
  Writeln(fdebug,'Origine a zero');
  errore:=true;
  end;


end;

{***************************  Contr_Pezzi     *****************************}

Procedure Contr_Pezzi;

var i,j:Integer;

begin

For i:=1 to UltPezzo do VPezzi^[i]^.Varie:=1;

for i:=1 to ultTronco Do
if Dati^[i]^.TI<>0 THen
For J:=0 to PezziTR do
if Dati^[i]^.Pezzi[j]<>0 then
  begin
  if VPezzi^[Dati^[i]^.Pezzi[j]]^.Varie=1
  then VPezzi^[Dati^[i]^.Pezzi[j]]^.Varie:=0
  else
    begin
      Writeln(fdebug,' Conflitto Pezzo Nø',Dati^[i]^.Pezzi[j]);
      errore:=true;
    end;
  end;


end;

procedure Test(nomef:string);
var j:integer;
begin
errore:=false;
assign(fdebug,'test.txt');
rewrite(fdebug);
assign(fgraf,Nomef+'.txt');
rewrite(fgraf);
Writeln(fdebug,'UltRiga:',ultriga);
Writeln(fdebug,'Ulttronco:',ulttronco);
Writeln(fdebug,'origine:',RisultCalc^.origine);

if RisultCalc^.origine<>0 then
  begin
  if ultpezzo>lungpezzi then
    begin
      Writeln(fdebug,'numeropezzi massimo oltreil limite');
      errore:=true;
    end
  else
    begin

    deb(RisultCalc^.origine);
    Contr_pezzi;
    dati^[RisultCalc^.origine]^.pros[6]:=0;
    For j:=1 to ulttronco do
    if dati^[j]^.Ti<>0 then
    if dati^[j]^.Pros[6]=1 then
      begin
      if j=RisultCalc^.origine then Writeln(fdebug,'origine');
{     dis^[dati^[j]^.ti]^.color:=15;}
      Writeln(fdebug,'tronco:',j,' non connesso');
      errore:=true;;
      end
    else dati^[j]^.Pros[6]:=0;

    For j:=1 to ultriga do
    if dis^[j]^.entita<>'' then
    if not( dis^[j]^.tlinea=1) then
      begin
      Writeln(fdebug,'linea:',j,' non connessa');
      errore:=true;;
      end;

    end;
{ dis^[RisultCalc^.origine]^.color:=15;}
  end;
close(fdebug);
close(Fgraf);

if errore then {$ifdef dos}write(chr(7));{$else}messagebeep(10);{$endif}
end;


end.