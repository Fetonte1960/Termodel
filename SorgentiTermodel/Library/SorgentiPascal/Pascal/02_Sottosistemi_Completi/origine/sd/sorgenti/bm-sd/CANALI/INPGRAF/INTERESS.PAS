program interessi;

uses crt,printer;

Var Nrate,Mese,rate_an:integer;
    Montante,Interesse,Rata,Int_anno:real;
begin
Nrate:=0;
Mese:=0;
clrscr;
Int_anno:=0;
montante:=30000000;
interesse:=14.5;
rata:=2424000;
rate_an:=2;


writeln('Rata:',Nrate:2,'³ Capitale:',Montante:8:0,
        '³ Maturati:',Int_anno:8:0,
        '³ Mensile:',0);

repeat

Nrate:=nrate+1;
mese:=mese+1;
Int_anno:=Int_anno+Montante*interesse/100/rate_an;
Montante:=Montante-Rata;
if  Mese=rate_an then
  begin
  mese:=0;
  Montante:=Montante+int_anno;
  Int_anno:=0;
  end;

writeln('Rata:',Nrate:2,'³ Capitale:',Montante:8:0,
        '³ Maturati:',Int_anno:8:0,
        '³ Mensile:',Montante*interesse/100/12:8:0);


until Montante<rata;

repeat until keypressed;


end.