unit urisultestivo;

interface

uses
  SysUtils, Classes, DB, DBTables,varcarichi;

type
  TDMRisult = class(TDataModule)
    Trisult: TTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMRisult: TDMRisult;

Procedure Initrisult(perc:string);
Procedure Closerisult;
Procedure MassimoVal(ADD:boolean;Molt:real;Variabile:integer;Amb:integer;Var mese:string;Var ora:integer;Var valore:real);
Function ReadVal(Variabile,Amb,mese,ora:integer):real;
Function Read_Val(Variabile,Amb,mese,ora:integer):real;
Procedure Massimo_Val(ADD:boolean;Molt:real;Variabile:integer;Amb:integer;Var mese:string;Var ora:integer;Var valore:real);

type Tnomivar=
record
  Num:integer;
  Nomelungo:String;
  Nomecorto:String;
  ent:string;
  end ;
TMesi_Ora=array[1..12,0..23]of real;

Var BufVar:TMesi_ora;

Const  Nomivar:array[0..37]of Tnomivar=
(
  (Num:0;Nomelungo:'Potenza totale del fabbricato';Nomecorto:'FPT_TOT';ent:''),{'SETOT.MIC'}
  (Num:1;Nomelungo:'Temperatura esterna,variabile';Nomecorto:'TEMPEST';ent:''),{'TE.DAT'}
  (Num:2;Nomelungo:'Radiazione solare diretta,variabile';Nomecorto:'IRRSOL';ent:''),{'IDN.DAT'}
  (Num:3;Nomelungo:'Potenza totale per zona';Nomecorto:'';ent:''),{''}
  (Num:4;Nomelungo:'Potenza sensibile  per zona';Nomecorto:'ZPS_TOT';ent:'Zone'),{'SZTOT.DAT'}
  (Num:5;Nomelungo:'Potenza Latente per zona';Nomecorto:'ZPL_TOT';ent:'Zone'),{'LZTOT.DAT'}
  (Num:6;Nomelungo:'Potenza totale per locale';Nomecorto:'';ent:''),{''}
  (Num:7;Nomelungo:'Potenza sensibile  per locale';Nomecorto:'LPS_TOT';ent:'Locali'),{'EREST.DAT'}
  (Num:8;Nomelungo:'Potenza Latente per locale';Nomecorto:'LPL_TOT';ent:'Locali'),{'LATEFF.DAT'}
  (Num:9;Nomelungo:'Carichi da trasmissione per locale';Nomecorto:'LCS_TRASM';ent:'Locali'),{'QACON.DAT'}
  (Num:10;Nomelungo:'HG da irraggiamento diretto per locale';Nomecorto:'LHS_IRRAGDIR';ent:'Locali'),{'QIRRTOT.DAT'}
  (Num:11;Nomelungo:'HG da irraggiamento indiretto per locale';Nomecorto:'LHS_IRRAGINDIR';ent:'Locali'),{'QIRCTOT.DAT'}
  (Num:12;Nomelungo:'Carichi  da persone per locale';Nomecorto:'LCS_PERS';ent:'Locali'),{'QOCS.DAT'}
  (Num:13;Nomelungo:'Carichi  da apparecchiature per locale';Nomecorto:'LCS_APP';ent:'Locali'),{'QAPS.DAT'}
  (Num:14;Nomelungo:'HG  da illuminazione per locale';Nomecorto:'LHS_ILL';ent:'Locali'),{'ILLTOT.DAT'}
  (Num:15;Nomelungo:'Infiltrazioni sensibile per locale';Nomecorto:'LCS_INF';ent:'Locali'),{'INSTOTES.DAT'}
  (Num:16;Nomelungo:'Infiltrazioni latente per locale';Nomecorto:'LCL_INF';ent:'Locali'),{'INLTOTES.DAT'}
  (Num:17;Nomelungo:'HG Persone sensibile per locale';Nomecorto:'LHS_PERS';ent:'Locali'),{'OCSTOT.DAT'}
  (Num:18;Nomelungo:'Carico persone latente per locale';Nomecorto:'LHL_PERS';ent:'Locali'),{'OCLTOT.DAT'}
  (Num:19;Nomelungo:'HG apparecchi sensibile  per locale';Nomecorto:'LHS_APP';ent:'Locali'),{'APSTOT.DAT'}
  (Num:20;Nomelungo:'Carichi apparecchiature latente per locale';Nomecorto:'LHL_APP';ent:'Locali'),{'APLTOT.DAT'}
  (Num:21;Nomelungo:'Carichi  da illuminazione per locale';Nomecorto:'LCS_ILL';ent:'Locali'),{'QAILL.DAT'}
  (Num:22;Nomelungo:'Carichi  da irraggiamento per locale';Nomecorto:'LCS_IRR';ent:'Locali'),{'QAIRR.DAT'}
  (Num:23;Nomelungo:'HG  da trasmissione per locale';Nomecorto:'LHS_TRASM';ent:'Locali'),{'QCTOT.DAT'}
  (Num:24;Nomelungo:'Potenza totale di edificio';Nomecorto:'FPT_TOT';ent:'Globale'),{'SETOT.MIC'}
  (Num:25;Nomelungo:'Potenza totale ventilazione di edificio';Nomecorto:'FPT_VENT';ent:'Globale'),{'SEVENT.MIC'}
  (Num:26;Nomelungo:'Potenza sensibile di edificio';Nomecorto:'FPS_SENS';ent:'Globale'),{'SESENS.MIC'}
  (Num:27;Nomelungo:'Potenza latente di edificio';Nomecorto:'FPL_LAT';ent:'Globale'),{'SELAT.MIC'}
  (Num:28;Nomelungo:'Temperatura interna effettiva dei locali';Nomecorto:'LTI_TEMP';ent:'Locali'),{'TIE.DAT'}
  (Num:29;Nomelungo:'Umidita rel. interna effettiva dei locali';Nomecorto:'LUI_UMID';ent:'Locali'),{'UIE.DAT'}
  (Num:30;Nomelungo:'Potenza sensibile per ventilazione di zona';Nomecorto:'ZPS_VENT';ent:'Zone'),{'SZVENT.DAT'}
  (Num:31;Nomelungo:'Potenza latente per ventilazione di zona';Nomecorto:'ZPL_VENT';ent:'Zone'),{'LZVENT.DAT'}
  (Num:32;Nomelungo:'Apporto sensibile per ventilazione ai locali';Nomecorto:'LPS_APPVENT';ent:'Locali'),{'SAPR.DAT'}
  (Num:33;Nomelungo:'Apporto latente per ventilazione ai locali';Nomecorto:'LPL_APPVENT';ent:'Locali'),{'LAPR.DAT'}
  (Num:34;Nomelungo:'Potenza invernale dei locali';Nomecorto:'LPT_POTINV';ent:'Locali'),{'ERINV.DAT'}
  (Num:35;Nomelungo:'Temperatura interna effettiva dei  locali';Nomecorto:'LTI_TEMPINTINV';ent:'Locali'),{'TIEINV.DAT'}
  (Num:36;Nomelungo:'Apporto ventilazione sensibile per impianto';Nomecorto:'IPS_APPVENTL';ent:'Impianti'),{'SaprAmb.DAT'}
  (Num:37;Nomelungo:'Apporto ventilazione latente per impianto';Nomecorto:'IPL_APPVENTL';ent:'Impianti'){'LaprAmb.DAT'}
);

  Const
    Nome_Mese: array[1..12] of string = ('Gennaio','Febbraio','Marzo','Aprile','Maggio',
                                        'Giugno','Luglio','Agosto','Settembre','Ottobre',
                                        'Novembre','Dicembre');
implementation

{$R *.dfm}
Procedure Initrisult(perc:string);
begin
DMRisult:=TDMRisult.Create(Nil);
DMRisult.Trisult.TableName := perc + 'risultati.db';
DMRisult.Trisult.open;
end;

Procedure AzzeraBuf;
Var i,j:integer;
begin
For i:=1 to 12 do
for j:=0 to 23 do
Bufvar[i,j]:=0;
end;

Function Read_Val(Variabile,Amb,mese,ora:integer):real;
Var i:Integer;
begin
if ora=99 then
  begin
  result:=0;
  exit;
  end;
{$Ifdef Calcolimemoria}
i:=1;
while (i<N_ris_mem)and((Nomivar[variabile].nomecorto<>uppercase(ris_mem[i]^.Nome))or(amb<>ris_mem[i]^.Indice)or(mese<>ris_mem[i]^.mese)) do inc(i);
result:=0;
if (Nomivar[variabile].nomecorto=uppercase(ris_mem[i]^.Nome))and(amb=ris_mem[i]^.Indice)and(mese=ris_mem[i]^.mese) then
result:=ris_mem[i]^.h[ora];
{$Else}

with DMRisult.Trisult do
  begin
  first;
  while not(eof)and((Nomivar[variabile].nomecorto<>uppercase(fields.fieldbyname('Nome').value))or(Amb<>fields.fieldbyname('Indice').value)) do
  next;
  result:=fields[ora+3].value;
  end;

{$Endif}
end;



Procedure Massimo_Val(ADD:boolean;Molt:real;Variabile:integer;Amb:integer;Var mese:string;Var ora:integer;Var valore:real);
Var i,j,k,indmese,meseE:integer;
begin
ora:=-1;
if not add then AzzeraBuf;
with DMRisult.Trisult do
  begin
  {$Ifdef Calcolimemoria}
  j:=1;
  while (j<N_ris_mem)and((Nomivar[variabile].nomecorto<>uppercase(ris_mem[j]^.Nome))or(amb<>ris_mem[j]^.Indice)) do inc(j);
  if (Nomivar[variabile].nomecorto<>uppercase(ris_mem[j]^.Nome))or(amb<>ris_mem[j]^.Indice) then
 {$Else}
  first;
  while not(eof)and((Nomivar[variabile].nomecorto<>uppercase(fields.fieldbyname('Nome').asstring))or(fields.fieldbyname('Indice').asstring='')or(Amb<>fields.fieldbyname('Indice').asinteger)) do
  next;
  if (eof)or((Nomivar[variabile].nomecorto<>uppercase(fields.fieldbyname('Nome').asstring))or(fields.fieldbyname('Indice').asstring='')or(Amb<>fields.fieldbyname('Indice').value)) then
  {$Endif}
  ora:=99
  else
    begin
    if ora<0 then
      begin
      Mese:='Luglio';
      indmese:=1;
      Valore:=-10E9;
      ora:=0;
      for k:= 1 to 12  do
      if (j+k-1<=N_ris_mem)and(Nomivar[variabile].nomecorto=uppercase(ris_mem[j+k-1]^.Nome))and(amb=ris_mem[j+k-1]^.Indice)  then
      for i:=0 to 23 do
        begin
        {$Ifdef Calcolimemoria}
        meseE:=ris_mem[j+k-1]^.mese;
        BufVar[meseE,i]:=BufVar[meseE,i]+ris_mem[j+k-1]^.h[i]*Molt;
        {$Else}
        BufVar[7,i]:=BufVar[7,i]+fields[i+3].value*Molt;
        {$Endif}
        if BufVar[meseE,i]>Valore then
          begin
          Valore:=BufVar[meseE,i];
          indmese:=meseE;
          mese:=nome_mese[indmese];
          ora:=i;
          end;
        end;
      end
      else
        {$Ifdef Calcolimemoria}
        Valore:=ris_mem[j+indmese-1]^.h[ora];
        {$Else}
        Valore:=fields[ora+3].value;
        {$Endif}
    end;
  end;
end;

Function Aggregato(codbase,codaggre:string):boolean;
var
  cod: Integer;
begin
   result:=false;
   if (Pos('AGGRE-', CodBase) <> 0) then
   begin
     Cod := StrToInt(Copy(CodBase, 7, Length(CodBase) - 6));
     if Cod = StrToInt(CodAggre) then
        result := True;
   end;
end;


Function ReadVal(Variabile,Amb,mese,ora:integer):real;
var i:integer;
begin
result:=Read_Val(Variabile,Amb,mese,ora);
if uppercase(Nomivar[variabile].ent)='LOCALI' then
for i:=1 to Nambienti do
if aggregato(ambienti_d^[i].Denom,ambienti_d^[amb].codnum)
then result:=result+Read_Val(Variabile,i,mese,ora);
end;

Procedure MassimoVal(ADD:boolean;Molt:real;Variabile:integer;Amb:integer;Var mese:string;Var ora:integer;Var valore:real);
Var i:integer;
begin
Massimo_Val(ADD,Molt,Variabile,Amb,mese,ora,valore);
if uppercase(Nomivar[variabile].ent)='LOCALI' then
for i:=1 to Nambienti do
if aggregato(ambienti_d^[i].Denom,ambienti_d^[amb].codnum)
then Massimo_Val(true,Molt,Variabile,i,mese,ora,valore);
end;

Procedure Closerisult;
begin
 DMRisult.Trisult.Close;
 DMRisult.Destroy;
end;
end.
