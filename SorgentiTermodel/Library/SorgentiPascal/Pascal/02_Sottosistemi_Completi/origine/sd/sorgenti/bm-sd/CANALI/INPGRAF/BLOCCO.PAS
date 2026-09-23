{$M 65000,16384,655360} {Turbo 3 default stack and heap}
{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}
{$C DEMANDLOAD}
unit Blocco;

INTERFACE

uses Turbo3,definiz,globfunz,Genproc,WM,esiste,controll,defuti;

Procedure SaveBl(modo:integer);

{---------------------------------------------------------------------------}
implementation

{***************************  SaveBl         *******************************}

Procedure SaveBl(modo:integer);

{ 1=blocco 2=tutto }

Var ris1:datiint;
    Nome:string;
    Risp:string;
    U_D,U_t,U_P,trattosel:integer;
    MesErr:String;
    trovato:boolean;


Procedure Savetratto(var UltDato,Ultrat,UltPez,tr:integer);

var i,j:integer;
    Trat:cadrec;
    Dat:Calcrec;

begin
Dat:=Dati^[tr]^;

with Dati^[tr]^ Do
for i:=1 to 6 do
if Pros[i]<>0 then Savetratto(ulTDato,Ultrat,UltPez,Dat.pros[i]);


for i:=0 to Pezzitr do
if Dati^[tr]^.Pezzi[i]<>0 then
  begin
  write(fp,VPezzi^[Dati^[tr]^.Pezzi[i]]^);
  Dat.Pezzi[i]:=UltPez;
  UltPez:=UltPez+1;
  end;

i:=Dati^[tr]^.Ti;
Dat.Ti:=UlTrat;

while i<>0 do
  begin

  Trat:=Dis^[i]^;
  Trat.Tronco:=UltDato;
  j:=Dis^[i]^.Nlinea;
  if Trat.Nlinea <>0 then Trat.Nlinea:=Ultrat+1;
  write(fi,Trat);
  i:=j;
  Ultrat:=Ultrat+1;
  end;

Write(fr,Dat);
tr:=UltDato;
UltDato:=UltDato+1;

end;


Begin


if modo=1 then Nome:=NomeFile(Driveprog)
else Nome:=driveprog+NomeProg;

if Nome<>'' then

  begin

  Risp:='';
  if modo=1 then Nome:=Driveprog+nome;

  if Exist(Nome+'.Ret')and(modo=1) then
    repeat
{N}    Risp:=ReadCom(W_M(29),CH2,0); {'Blocco esistente ,sostituisco ? [s/n]:','N',0);}
{S,N}    Until (risp<>'')and((upcase(Risp[1])=CH1)or(upcase(Risp[1])=CH2));

{S}  if (upcase(Risp[1])=CH1)or(risp='') then
    begin
    if modo=1 then trovato:=selezlinea(trattosel)<>130
    else
      begin
      trovato:=true;
      trattosel:=dati^[RisultCalc^.Origine]^.Ti;
      end;
    if trovato then
      begin
      assign(fi,Nome+'.ret');rewrite(fi);
      assign(fr,Nome+'.DTR');rewrite(fr);
      assign(fp,Nome+'.pzz');rewrite(fp);
      U_D:=1;
      U_T:=1;
      U_P:=1;

      Ris1:=RisultCalc^;

      with Ris1 Do
        begin
        SL_Xsup:=L_Xsup;
        SL_Xinf:=L_Xinf;
        SL_YSup:=L_YSup;
        SL_YInf:=L_YInf;
        SXsup:=Xsup;
        SXinf:=Xinf;
        SYSup:=YSup;
        SYInf:=YInf;
        SZInf:=ZInf;
        SZSup:=ZSup;
        Ssezione:=sezione;
        end;

      ris1.Origine:=Dis^[trattosel]^.Tronco;
      Savetratto(U_D,U_T,U_P,Ris1.Origine);
      if U_P=1 then write(fp,Vpezzi^[1]^);
      assign(fRisult,Nome+'.ris');
      rewrite(fRisult);
      write(fRisult,Ris1);
      close(fRisult);
      close(fi);
      close(fr);
      close(fp);
      end;
    end;
  end;

richiesta('');

end;

end.