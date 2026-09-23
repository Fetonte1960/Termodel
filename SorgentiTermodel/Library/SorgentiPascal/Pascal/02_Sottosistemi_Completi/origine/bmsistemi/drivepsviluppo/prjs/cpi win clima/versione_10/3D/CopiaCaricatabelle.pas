unit Copiacaricatabelle;

interface
Uses UDB, dbtables, Uvariabililettura, sysutils, grafica2d,
     graphics,varcarichi,udatalink, Variants, Math, Dialogs,setta_config_user,UnitCompilaDatiZona
     {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)},CalcolaZ, Volumi, angoli,geometria{$IFEND};

Procedure CaricaTabelle;
Function CercaAmb1(Namb:string):boolean;
Function CercaAmb(Namb:string):boolean;
Function Numeralocale(ind,ind_piano:integer):string;
Function CercaZona(CodZona:String;Var indzona:integer):boolean;
//procedure Copiadatizona(Nz:integer);
Function CaricaAmb(i:integer):integer;

//Procedure Caricaspes;
function Spes_par(cod:string):real;
// Emanuela inserita il 4/4/2006
function RestituisciAngoloFalda(codFalda: String): Real;
Procedure Set_pianocor(pc:integer);

Var Indice_clone:integer=0;

implementation

uses
Libreriagenerale,
letturaDisegnobidimensionale ,
CopialetturaDisegno3d,
VariabiliGenerali
(*
Ulettura,
VisualizzaErrori
*)
;

{$I FunzioniGrafiche1}
//{I FunzioniGrafiche2}

Var a_cor:integer;
    inds,Ind_pianocor:integer;
Const Da_piano='DA PIANO';
Procedure Set_pianocor(pc:integer);
begin
Ind_pianocor:=pc;
end;
(*
Procedure Caricaspes;
begin
inds:=0;
new(pspes);
with dm1 do
begin
  tt1.Close;
  tt1.Active := False;
  tt1.DatabaseName:=Percorso_progetti;
  tt1.TableName:='strutture';
  tt3.Close;
  tt3.DatabaseName:=Percorso_progetti;
  tt3.TableName:='strati';
  initassociata;
  tt1.Open;
  tt3.Open;
  tt1.first;
  while not(tt1.Eof) do
  begin
    inc(inds);
    pspes^[inds].spes:=0;
    if tt1.Fieldbyname('Codice').value <> Null then
    begin
      pspes^[inds].cod := upstring(tt1.Fieldbyname('Codice').AsString);
      tt3.First;
      while not(tt3.Eof) do
      begin
       if (tt3.Fieldbyname('spessore').AsString <> '') then
          pspes^[inds].spes:=pspes^[inds].spes+tt3.Fieldbyname('spessore').AsFloat/100;
       tt3.Next;
      end;
    end;
    tt1.Next;
  end;
  tt1.close;
  tt3.close;
end;
Npareti:=inds;
end;
*)


Function Numeralocale(ind,ind_piano:integer):string;
Var namb,nacor,i,res,nummin,nummax:integer;
    trov:boolean;
begin
WDebugPJB('Numerazione locale:'+bll^[ind].Attrib1[1]);
result:='';
if ind_piano=0 then exit;
if npiani=0 then exit;
nummin:=Piani_d[ind_piano].Indice*1000;
NumMax:=(Piani_d[ind_piano].Indice+1)*1000;
result:=bll^[ind].Attrib1[1];
val(bll^[ind].Attrib1[1],Namb,Res);
if (res<>0)or(Namb<=nummin)or(Namb>=NumMax) then Namb:=0;

//Cerca locali duplicati
WDebugPJB('Elenco locali caricati');
if Namb<>0 then
for i:=1 to Ultblocco-1 do
with bll^[i] do
if (Nome='AMB')and(Namb<>0) then
  begin
  WDebugPJB(bll^[i].Attrib1[1]);
  val(Attrib1[1],NaCor,Res);
  if (res=0)and(NaCor>nummin)and(NaCor<NumMax)and(Nacor=Namb) then Namb:=0;
  end;
trov:=false;
If Namb=0 then
  begin
  showmessage('Locale '+bll^[ind].Attrib1[1]+ 'numerazione irregolare !');
  WDebugPJB('Locale '+bll^[ind].Attrib1[1]+ 'numerazione irregolare !');
  repeat
  trov:=true;
  inc(Namb);
  for i:=1 to Ultblocco-1 do
  with bll^[i] do
  if (Nome='AMB')and(i<>ind)and(trov) then
    begin
    val(Attrib1[1],NaCor,Res);
    if (res=0)and(NaCor>nummin)and(NaCor<NumMax)and(Nacor=NumMin+Namb) then trov:=false;
    end;
  Nacor:=NumMin+Namb;
  until trov;
  Namb:=NumMin+Namb;
  end;
str(Namb,bll^[ind].Attrib1[1]);
result:=bll^[ind].Attrib1[1];
end;

Function indpianocor:integer;
Var i:integer;
begin
result:=0;
if Npiani<=0 then exit;
i:=1;
while (i<Npiani) and  (Uppercase(Pianocor)<>Uppercase(Piani_d^[i].Cod)) do inc(i);
if (Uppercase(Pianocor)=Uppercase(Piani_d^[i].Cod)) then result:=i;
end;
function Spes_par(cod:string):real;
Var i:Integer;
begin
cod:=uppercase(cod);
{
result:=0;
i:=1;
if inds <> 0 then
begin
  while (i<Inds)and(uppercase(pspes^[i].cod)<>cod) do inc(i);
  if uppercase(pspes^[i].cod)=cod then result:=pspes^[i].spes;
end;
}
result:=0;
i:=1;
if nstrutture <> 0 then
  begin
  while (i<nstrutture)and(uppercase(strutture_d^[i].NFile)<>cod) do inc(i);
  if uppercase(strutture_d^[i].NFile)=cod then result:=strutture_d^[i].SpessoreParete/100;
  end;
end;

Procedure CancTab(var Tab:TTable);
begin
tab.close;
tab.exclusive:=true;
tab.emptytable;
tab.exclusive:=False;
end;

function RagrupEsp(ang:reaL;var Destesa:string):String;
var Esp:string;
begin
ang:=-ang+270+DirezNord;
  repeat
      if (Ang < -22.5) then Ang:=Ang+360;
      if (Ang > 337.5) then Ang:=Ang-360;
  until (ANG >= -22.5) AND (ANG <= 337.5);

  if ( Ang >=-22.5) AND (Ang <= 22.5)   then  Begin;Esp:='N';Destesa:='NORD';end;
  if ( Ang > 22.5)  AND (Ang <= 67.5 )  then  Begin;Esp:='NO';Destesa:='NORD-OVEST';end;
  if ( Ang > 67.5 ) AND (Ang <= 112.5 ) then  Begin;Esp:='O';Destesa:='OVEST';end;
  if ( Ang > 112.5) AND (Ang <= 157.5 ) then  Begin;Esp:='SO';Destesa:='SUD-OVEST';end;
  if ( Ang > 157.5) AND (Ang <= 202.5 ) then  Begin;Esp:='S';Destesa:='SUD';end;
  if ( Ang > 202.5) AND (Ang <= 247.5 ) then  Begin;Esp:='SE';Destesa:='SUD-EST';end;
  if ( Ang > 247.5) AND (Ang <= 292.5 ) then  Begin;Esp:='E';Destesa:='EST';end;
  if ( Ang > 292.5) AND (Ang <= 337.5 ) then  Begin;Esp:='NE';Destesa:='NORD-EST';end;
  RagrupEsp:=Esp;
end;


Function Lunghezza(valore:real):real;
begin
  result:=round(valore*10/100)/10;
end;
Function Area(valore:real):real;
begin
  result:=round(valore*10/100)/10;
end;

Function CercaAmb1(Namb:string):boolean;
Begin

with dm1.TT1 do
  begin
  first;
  while not(eof) and (V_recAmb.CodNum<>Namb) do Next;
  end;
result:=(V_recAmb.CodNum=Namb) ;
end;

Function CercaAmb(Namb:string):boolean;
Var i:integer;
Begin
if Nambienti=0 then
  begin
  result:=false;
  exit;
  end;
I:=1;
while (i<Nambienti) and (Ambienti_D^[i].CodNum<>Namb) do INC(I);
result:=(Ambienti_D^[i].CodNum=Namb) ;
a_cor:=i;
end;
Function CaricaAmb(i:integer):integer;
var Tpp:string;
    indzona:integer;
    codice_clone,j:integer;
    codice_locale_clone:string;
begin
with bll[i] do
if not CercaAmb(Attrib1[1]) then
  begin
  Inc(Nambienti);
  new(ambienti_d^[Nambienti]);
  A_cor:=Nambienti;

  if indice_clone<>0 then
    begin
    codice_clone:=piani_d^[indice_clone].Indice*1000;
    codice_clone:=codice_clone+strtoint(Attrib1[1])mod 1000;
    codice_locale_clone:=inttostr(codice_clone);
    for j:=1 to Nambienti-1 do
    if ambienti_d^[j].CodNum=codice_locale_clone then break;
    if ambienti_d^[j].CodNum<>codice_locale_clone then
    showmessage('Locale clone non trovato'); 
    ambienti_d^[A_cor]^:=ambienti_d^[j]^;
    ambienti_d^[A_cor]^.CodNum:=Attrib1[1];
    if ambienti_d^[A_cor]^.CodNum='' then
    showmessage('Numerazione locale non esiste');
    ambienti_d^[A_cor].Npar:=0;
    end
  else
    begin
    ambienti_d^[Nambienti].x1:=bll^[i].x+Minimox-0.1;
    ambienti_d^[Nambienti].y1:=bll^[i].y+Minimoy-0.1;

    ambienti_d^[Nambienti].CodNum:=Attrib1[1];
    if ambienti_d^[A_cor]^.CodNum='' then
    showmessage('Numerazione locale non esiste');
    ambienti_d^[A_cor].impianto:=impianto_d^[1].Codice;
    azzeraidentif;
    tpp:=leggiidentif1(Attrib1[4]);
    if tpp<>'' then ambienti_d^[A_cor].CodZona:=tpp;
    tpp:=leggiidentif1(Attrib1[4]);
    if tpp<>'' then ambienti_d^[A_cor].Impianto:=tpp;
    //copiadatizona(1);
    if cercazona(ambienti_d^[A_cor].CodZona,indzona) then
    copiadatizona(indzona,ind_pianocor,A_cor);
    ambienti_d^[A_cor].Npar:=0;
    //forzatura altezza ed infiltrazioni piano inserita temporaneamente da diego
    ambienti_d^[A_cor]^.HSoffitto:=piani_D^[ind_pianocor].AltN;
    //if uppercase(ambienti_d^[A_cor]^.impianto)<>'NESSUNO' then //esclude locale non riscaldato
    //ambienti_d^[A_cor]^.InfInv:=zone_d^[1].InfInv;
    end;
  end;
result:=a_cor;
end;
(* sostituita con quella di emanuela
procedure Copiadatizona(Nz:integer);
begin
with ambienti_d^[a_cor]^ do
begin
if uppercase(impianto)<>'NESSUNO' then //esclude locale non riscaldato
 if Zone_D <> nil then
 begin
  if NZ <> 0 then
  begin
    // Emanuela 7/10/2004 inserita la condizione di non modificare l'altezza del locale se essa
    // esiste già, impostata dall'utente
    if Hsoffitto = 0 then
       Hsoffitto:=Zone_d^[nz].HSoffittoRicorr;
    if codzona = '' then codzona := Zone_d^[nz].Cod;
    if NPersone = 0 then
    begin
      if Zone_d^[nz].AffollPersona <> 0 then
         NPersone := Round(Superficie/Zone_d^[nz].AffollPersona)
      else NPersone := 0;
    end;
    { TODO -oFabio -cCorrezioni Estivo : Errore sul calcolo estivo dell'illuminazione 11-11-2004}
  //  IlluminazFissa:=Zone_d^[nz].IlluminazFissa*Superficie;
    if IlluminazFissa = 0 then IlluminazFissa    := Zone_d^[nz].IlluminazFissa; //*Superficie;
    if SensApparecch  = 0 then SensApparecch     := Zone_d^[nz].SensApparecch*Superficie;
    if LatenteApparecch  = 0 then LatenteApparecch  := Zone_d^[nz].LatenteApparecch*Superficie;
    if InfInv = 0 then InfInv:=Zone_d^[nz].InfInv + Zone_d^[nz].PortMec;
    if RicambioPersona  = 0 then RicambioPersona  := Zone_d^[nz].RicAriaTrat;
    if CodPROccupaz     = '' then CodPROccupaz    := Zone_d^[nz].ProfiloOccupaz;
    if SensibilePersona = 0 then SensibilePersona := Zone_d^[nz].SensibilePersona;
    if LatentePersona   = 0 then LatentePersona   := Zone_d^[nz].LatentePersona;
    if CodPRApparecch   = '' then CodPRApparecch  := Zone_d^[nz].ProfiloApparecch;
    if CodPRIlluminaz   = '' then CodPRIlluminaz  := Zone_d^[nz].ProfiloIlluminaz;
    if InfEst = 0 then InfEst := Zone_d^[nz].InfInv + Zone_d^[nz].PortMec;
    if Ventilazione = 0 then Ventilazione := Zone_d^[nz].VentMecTratt;
    //ProfiloIlluminaz:=Zone_d^[nz].ProfiloIlluminaz;
    //ProfiloApparecch:=Zone_d^[nz].ProfiloApparecch;
    //ProfiloOccupaz:=Zone_d^[nz].ProfiloOccupaz;
    IlluminazVar  := Zone_d^[nz].IlluminazVar;
    TipoIlluminaz := Zone_d^[nz].TipoIlluminaz;
    RappRS:=0.45;
    CircolazAria:=1;
    if Piani_D^[IndPianocor].Piani_Uguali<>0 then
    {AmbientiUguali:=Piani_D^[IndPianocor].Piani_Uguali
    else} AmbientiUguali:=1;
  end;
 end;
end;
end;
*)
Function CercaZona(CodZona:String;Var indzona:integer):boolean;
Var Personemq,Lucimq,Macchinemq,MacchineLatmq:real;
    i,j,k:integer;
Begin
result:=false;
indzona:=0;
if codzona<>'' then
  begin
  result:=true;
  k:=1;
  while (k<Nzone) and (Upstring(Zone_d^[k].Cod)<>Upstring(Codzona)) do inc(k);
  if (Upstring(Zone_d^[k].Cod)=Upstring(Codzona)) then
    begin
    //copiadatizona(k);
     indzona:=k;
    end
  end

end;



Procedure Nuova_esp(codesp,estesa:string);
Var i:integer;
begin
i:=1;
while (i<Nconfini)and(Formst(codesp)<>Formst(Confine_d^[i].Codice)) do
inc(i);
if Formst(codesp)=Formst(Confine_d^[i].Codice) then
  begin
  Inc(Nconfini);
  Confine_d^[Nconfini].Denom:=estesa;
  Confine_d^[Nconfini].Codice:=codesp;
  end;
end;


Function Angolo(dx,dy : real) : real;
begin
  if dy >= 10E-6 then Angolo := ArcTan(dx/abs(dy))
  else
    begin
       if dy < -10E-6 then Angolo := pi - ArcTan(dx/abs(dy))
       else
         begin
            if dx > 0  then Angolo := pi/2
            else Angolo := 3*pi/2;
        end;
    end;
end;



Procedure CaricaTabelle;

Type TCol_Cad=record  codice:string;colore:integer end;
Const maxcolcad=50;

Var i,j:integer;
    am1,am2:string;
    Col_cad:array[1..maxcolcad] of TCol_Cad;
    NcolCad:integer;



Var fo:file of FRONTHT;
buf:FRONTHT;


Function colore_CAD(ind:integer):string;
begin
case ind of
1:Result:='Rosso';
2:Result:='Giallo';
3:Result:='Verde';
4:Result:='Ciano';
5:Result:='Blu';
6:Result:='Magenta';
7:Result:='Bianco';
else result:='Colore '+inttostr(ind);
end;
end;

Function indcolore(nomecolore:string):integer;
begin
nomecolore:=Lowercase(nomecolore);
if copy(nomecolore,1,6)='colore' then
result:=strtoint(copy(nomecolore,8,length(nomecolore)-7))
else
if nomecolore='rosso' then result:=1  else
if nomecolore='giallo' then result:=2  else
if nomecolore='verde' then result:=3  else
if nomecolore='ciano' then result:=4  else
if nomecolore='blu' then result:=5  else
if nomecolore='magenta' then result:=6  else
if nomecolore='bianco' then result:=7
else result:=0;
end;


Procedure InitcolCad;
Var clpar:string;
    I:integer;
begin
NcolCad:=0;
for i:=1 to Nstrutture do
    begin
    inc(NcolCad);
    col_cad[NcolCad].codice:=Strutture_D^[i].NFile;
    clpar:=formst(Strutture_D^[i].colcad);
    col_cad[NcolCad].colore:=indcolore(clpar);
    (*col_cad[NcolCad].colore:=0;
    if clpar='ROSSO'then col_cad[NcolCad].colore:=1
    else if clpar='GIALLO'then col_cad[NcolCad].colore:=2
    else if clpar='VERDE'then col_cad[NcolCad].colore:=3
    else if clpar='CIANO'then col_cad[NcolCad].colore:=4
    else if clpar='BLU'then col_cad[NcolCad].colore:=5
    if clpar='MAGENTA'then col_cad[NcolCad].colore:=6;
    if clpar='MAGENTA'then col_cad[NcolCad].colore:=6;*)
    end;
end;

Function CCad(cc:string):String;
Var err,i:integer;
    cpar:integer;
begin
result:=cc;
if cc<>'' then
if cc[1]='£' then
  begin
  cc:=copy(cc,2,length(cc)-1);
  Val(cc,cpar,err);
  if err=0 then
    begin
    i:=1;
    while (i<=NColCad)and(col_cad[i].colore<>Cpar) do inc(i);
    if col_cad[i].colore=Cpar then result:=col_cad[i].codice;
    end;
  end;
end;

Function Conf_Cad(cc:string):String;
Var err,i:integer;
    cpar:integer;
    cc1:string;
begin
result:=cc;
if cc<>'' then
if cc[1]='£' then
  begin
  cc:=copy(cc,2,length(cc)-1);
  cc1:='';
  if cc='ACAD_ISO02W100' then cC1:='1';
  if cc='ACAD_ISO03W100' then cc1:='2';
  if cc='ACAD_ISO04W100' then cc1:='3';
  if cc='ACAD_ISO05W100' then cc1:='4';
  if cc='ACAD_ISO06W100' then cc1:='5';
  cc:=cc1;
  if CC<>'' then
    begin
    i:=1;
    while (i<=NConfini)and(Confine_d^[i].TLinea<>CC) do inc(i);
    if Confine_d^[i].TLinea=CC then result:=Confine_d^[i].codice;
    end;
  end;
end;
//lucernai
Var IndParbase:integer;
Procedure caricaPar(Lato1,lato2:string;l1:boolean;VItem:integer);
Var dir,Dirz,disp:real;
    estesa:string;
    AAA,ripetiz,j,k,l,ftscalap,finestrata,ambl2:integer;
    Confinebase,confine2,tlineaorig:string;
    AltezzaTotale,Altezza1, Altezza2,lungtemp,Hz1,Hz2,hz3,tmp,qpav1,qpav2:real;
    Tipo_P, Tipo2 : String;
    Misto:boolean;
    CodTemp,codpspec,tempconfine,coloretemp:string;
    dispf,xmedpar,ymedpar: Real;

Function finoalmeno(ss:string):string;
Var i:integer;
begin
result:='';
if ss='' then exit;
i:=1;
while (i<length(ss))and(ss[i]<>'-') do inc(i);
if ss[i]='-' then result:=copy(ss,1,i-1)
else result:=copy(ss,1,i);
end;

begin
cercaamb(lato2);
ambl2:=a_cor;
if not cercaamb(lato1) then exit;
qpav1:=ambienti_d^[a_cor].Quotapav;
if ambl2<>0 then qpav2:=ambienti_d^[ambl2].Quotapav;

for k:=1 to NParSpeciali do
with ParSpeciali_D^[k]^ do
if Categoria='Pareti miste' then
  begin
  if pos('AUTORILE',Uppercase(ConfineStruttura1))<>0 then ConfineStruttura1:='Esterno';
  if pos('AUTORILE',Uppercase(ConfineStruttura2))<>0 then ConfineStruttura2:='Esterno';
  if pos('AUTORILE',Uppercase(ConfineStruttura3))<>0 then ConfineStruttura2:='Esterno';
  end;
ftscalap:=100;
dispf := 0;

with Ft^[i] do
  begin
  coloretemp:=colore;//lo devo ripristinare per i piani clone
  tlineaorig:=tlinea;
  azzeraidentif;
  misto:=false;
  AltezzaTotale:=str_tofloat(leggiidentif1(Tlinea));
  if altezzaTotale=0 then altezzaTotale:=ambienti_d^[a_cor].HSoffitto;
  Hz2:=str_tofloat(leggiidentif1(Tlinea));
  Tipo_p:=Colore;

 {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
  if (not l1)and(lato2<>'') then
    begin
    tmp:=altezzatotale;
    altezzatotale:=hz2;
    hz2:=tmp;
    end;
 {$IFEND}
  finestrata:=0;
  if colore[1]='§' then  //Pareti speciali
    begin
    codpspec:=copy(colore,2,length(colore)-1);
    for k:=1 to NParSpeciali do
    if inttostr(ParSpeciali_D^[k].Codice)=codpspec then break;
    if ParSpeciali_D^[k].Categoria='Pareti miste' then
      begin
      Tlinea:='';
      Tlinea:=Tlinea+ParSpeciali_D^[k].ConfineStruttura2+':';
      Tlinea:=Tlinea+ParSpeciali_D^[k].TipoStruttura2+':';
      //Tlinea:=Tlinea+ParSpeciali_D^[i].ALTEZZA1+':'; manca il campo
      Tlinea:=Tlinea+float_to_str(ParSpeciali_D^[k].AltParte1,2)+':';
      Tlinea:=Tlinea+ParSpeciali_D^[k].ConfineStruttura1+':';
      Tlinea:=Tlinea+ParSpeciali_D^[k].TipoStruttura1+':';
      confinebase:='MISTO';
      AzzeraIdentif;
      end;
    if ParSpeciali_D^[k].Categoria='Pareti vetrate' then
      begin
      for l:=1 to Nfinestre do
      if uppercase(Finestre_d^[l].Codice)=uppercase(ParSpeciali_D^[k].TipoFinestra) then break;
      finestrata:=l;
      colore:=ParSpeciali_D^[k].TipoStruttura1;
      Tipo_p:=Colore;
      confinebase:=conf_cad(leggiidentif1(Tlinea));
      end;
    if ParSpeciali_D^[k].Categoria='Locali sfalsati' then
      begin
      confinebase:=conf_cad(leggiidentif1(Tlinea));
      if upstring(confinebase)='MISTO_FALDA' then
        begin
        confine2:=leggiidentif1(Tlinea);
        Tipo2:=leggiidentif1(Tlinea);
        altezza1:=str_tofloat(leggiidentif1(Tlinea));
        //Altezzatotale:=Altezzatotale-Altezza1;
        //Hz2:=Hz2-Altezza1;
        confinebase:=leggiidentif1(Tlinea);
        Tipo_p:=leggiidentif1(Tlinea);
        Hz3:=str_tofloat(leggiidentif1(Tlinea));
        azzeraidentif;
        if vicino(qpav1,0,0,qpav2,0,0) then //caso 1
          begin
          confine2:=ParSpeciali_D^[k].ConfineStruttura2;
          tipo_P:=ParSpeciali_D^[k].TipoStruttura1;
          tipo2:=ParSpeciali_D^[k].TipoStruttura2;
          end
        else  //caso2 ,caso3
          begin
          if qpav2>qpav1 then
            begin     //confinante più alto
            confinebase:='Autorilevato';
            tipo_P:=ParSpeciali_D^[k].TipoStruttura1;
            tipo2:=ParSpeciali_D^[k].TipoStruttura3;
            confine2:=ParSpeciali_D^[k].ConfineStruttura1;
            end
          else
            begin
            confinebase:='Autorilevato';
            tipo_P:=ParSpeciali_D^[k].TipoStruttura3;
            tipo2:=ParSpeciali_D^[k].TipoStruttura2;
            confine2:=ParSpeciali_D^[k].ConfineStruttura2;
            end;
          end;
        tlinea:=confine2+':'+Tipo2+':'+float_to_str(altezza1,3)+':'+confinebase+':'+tipo_p+':'+float_to_str(hz3,3)+':';
        confinebase:='MISTO_FALDA';
        end
      end;
    end
  else
  confinebase:=conf_cad(leggiidentif1(Tlinea));

 // confinebase:=leggiidentif1(Tlinea);

  ripetiz:=1;
   {
   if uppercase(espbase)='MISTO' then result:=float_to_Str(h1,3)
                                          +':'+float_to_Str(H2,3)
                                          +':'+EspBase + '_FALDA'
                                          +':'+Conf2
                                          +':'+t2
                                          +':'+float_to_Str(Alt1,3)
                                          +':'+Confbase
                                          +':'+tipoP
                                          +':'+float_to_Str(Alt2,3)+':'
    }
  if upstring(confinebase)='MISTO_FALDA' then
    begin
    Misto:=true;
    confine2:=leggiidentif1(Tlinea);
    Tipo2:=leggiidentif1(Tlinea);
    altezza1:=str_tofloat(leggiidentif1(Tlinea));
    //Altezzatotale:=Altezzatotale-Altezza1;
    //Hz2:=Hz2-Altezza1;
    confinebase:=leggiidentif1(Tlinea);
    Tipo_p:=leggiidentif1(Tlinea);
    Hz3:=str_tofloat(leggiidentif1(Tlinea));
    if not vicino(qpav1,0,0,qpav2,0,0) then
      begin
      if qpav2>qpav1 then
        begin
        tempconfine:=confinebase;//la striscia di sotto prende in confine principale
        confinebase:=confine2;
        confine2:=tempconfine;
        if l1 then
          begin
          altezza1:=(qpav2-qpav1);
          hz3:=(qpav2-qpav1);
          end
        else
          begin
          altezzatotale:=(qpav2-qpav1);
          hz2:=(qpav2-qpav1);
          end
        end
      else
        begin
        if l1 then
          begin
          altezza1:=altezza1-(qpav1-qpav2);
          hz3:=hz3-(qpav1-qpav2);
          end
        else
          begin
          altezzatotale:=altezzatotale-(qpav1-qpav2);
          hz2:=hz2-(qpav1-qpav2);
          end
        end;
      end;
    ripetiz:=2;
    //altezza2:=str_tofloat(leggiidentif1(Tlinea));
    end;
  if upstring(confinebase)='MISTO' then
    begin
    Misto:=true;
    confine2:=leggiidentif1(Tlinea);
    Tipo2:=leggiidentif1(Tlinea);
    altezza1:=str_tofloat(leggiidentif1(Tlinea));
    Altezzatotale:=Altezzatotale-Altezza1;
    Hz2:=Hz2-Altezza1;
    confinebase:=leggiidentif1(Tlinea);
    Tipo_p:=leggiidentif1(Tlinea);
    Hz3:=str_tofloat(leggiidentif1(Tlinea));
    ripetiz:=2;
    //altezza2:=str_tofloat(leggiidentif1(Tlinea));
    end;

  {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
  if (lato2<>'')and(misto) then
    begin
    if hz3=0 then hz3:=altezza1;//modifica
    //Altezzatotale:=Altezzatotale+Altezza1;
    //Hz2:=Hz2+Altezza1;  //Modifica
    if l1 then
      begin
      if (Altezzatotale+Hz2)/2<(altezza1+hz3)/2 then
        begin
        misto:=false;
        ripetiz:=1;
        end
      else
        begin
        altezzatotale:=altezzatotale-altezza1;
        hz2:=hz2-hz3;
        tmp:=altezzatotale;
        altezzatotale:=altezza1;
        altezza1:=tmp;
        tmp:=hz2;
        hz2:=hz3;
        hz3:=tmp;
        end;
      end
    else
      begin
      tmp:=altezza1; //Mod 25-11-2005
      altezza1:=hz3; //Mod 25-11-2005
      hz3:=tmp; //Mod 25-11-2005
      if (Altezzatotale+Hz2)/2>(altezza1+hz3)/2 then
        begin
        misto:=false;
        ripetiz:=1;
        Altezzatotale:=Altezza1;
        Hz2:=Hz3;
        end
      else
        begin
        altezza1:=altezza1-altezzatotale;
        hz3:=hz3-hz2;
        end;
         {
      else
        begin
        tmp:=altezzatotale;
        altezzatotale:=altezza1;
        altezza1:=tmp;
        tmp:=hz2;
        hz2:=hz3;
        hz3:=tmp;
        end;
          }
      end;
    end
  else hz3:=0;
    {$IFEND}
  Tlinea:=Tlineaorig;
  for  j:=1 to ripetiz do   // gestisce il misto
    begin
    if j=2 then
      begin
      altezzatotale:=Altezza1;
      if tipo2<>'' then tipo_p:=Tipo2;
      confinebase:=confine2;
      {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
      hz2:=hz3;
      {$IFEND}
      end;
    inc(ambienti_d^[a_cor].Npar);

    //Lucernai
    indparbase:=ambienti_d^[a_cor].Npar;

    with   ambienti_d^[a_cor].par[ambienti_d^[a_cor].Npar] do
      begin
      Item := 0;
      Item:=VItem;
      // Emanuela 5/7/2003 inizializziamo i campi prima di utilizzarli
      Num := 0;
      lungtemp := 0;
      Alt := 0;
      Alt2 := 0;
      Lato := '';
      Confine := '';
      Tipo := '';
      Sup := 0;
      Cod := '';
      x1       := 0;
      y1       := 0;
      x2       := 0;
      y2       := 0;
      //Emanuela inserite per poter variare le cifre decimali
      //lungtemp := RoundTo((sqrt(sqr(Ft^[i].x1-Ft^[i].x0)+sqr(Ft^[i].y1-Ft^[i].y0))/100), -1);
      lungtemp:=Lunghezza(sqrt(sqr(Ft^[i].x1-Ft^[i].x0)+sqr(Ft^[i].y1-Ft^[i].y0)));
      Num:=Lungtemp;
      If (minimox<0) or (minimoy<0) then
      disp:=0.1 else disp:=0;
      x1:=(Ft^[i].x0+Minimox-disp)/ftscalap;
      y1:=(Ft^[i].y0+Minimoy-disp)/ftscalap;
      x2:=(Ft^[i].x1+Minimox-disp)/ftscalap;
      y2:=(Ft^[i].y1+Minimoy-disp)/ftscalap;
      xmedpar:=(x1+x2)/2;//serve per le pareti finestrate
      ymedpar:=(y1+y2)/2;
      Alt:=AltezzaTotale;
      if hz2=0 then hz2:=altezzatotale;
      Alt2:=Hz2;
      //Sup:=roundr(2,lungtemp*(altezzatotale+hz2)/2); //All
      Sup := RoundTo(lungtemp*(altezzatotale+hz2)/2, -3);//all
      Cod:=CCad(tipo_P);
      // Emanuela correzione del 29/3/2007 per evitare che quando esiste un solo piano
      // la parete venga considerata come divisorio
      if (lato2<>'') and (not(misto)or(uppercase(confinebase)='INTERNO')or(uppercase(confinebase)='AUTORILEVATO'))
      //all and (uppercase(confinebase)<>'ESTERNO')
      then
        begin
        // Emanuela per considerare i divisori con confini diversi da non scambiante
        // e per essi calcolare il lato corretto
        //all(*   Eliminato da Diego
        (*if UpperCase(ConfineBase) <> 'NON SC' then
          begin
          Confine := ConfineBase;
          {if not l1 then
          dir:=angolo(x1-x0,y1-y0)//Calc_D(x0,y0,0,x1,y1,0,Dir,Dirz)
          else
          dir:=angolo(x0-x1,y0-y1);//Calc_D(x1,y1,0,x0,y0,0,Dir,Dirz);
          Lato:=RagrupEsp(Dir*180/pi,estesa);  }
          end
        else*)
          begin
          Confine:='Divisorio';
          end;//all *)
        //all Confine:='Interno';
        Lato:='L'+ lato2;
        end
      else
        begin
        if  not l1 then
        dir:=angolo(Ft^[i].x1-Ft^[i].x0,Ft^[i].y1-Ft^[i].y0)//Calc_D(x0,y0,0,x1,y1,0,Dir,Dirz)
        else
        dir:=angolo(Ft^[i].x0-Ft^[i].x1,Ft^[i].y0-Ft^[i].y1);//Calc_D(x1,y1,0,x0,y0,0,Dir,Dirz);
        Lato:=RagrupEsp(Dir*180/pi,estesa);
        //if v_recPar.Lato[1]<>'L' then Nuova_esp(v_recPar.Lato,estesa);
        if (Formst(confinebase)='ESTERNO')or(confinebase='0')or(Formst(confinebase)='') then Confine:='Esterno'
        else Confine:=finoalmeno(confinebase);
        end;
      Tipo:='Parete';
      //dm1.tt3.fieldbyname('Num/Lung').Value:=Lunghezza(sqrt(sqr(x1-x0)+sqr(y1-y0)));
      //dm1.tt3.fieldbyname('Sup.').Value:=dm1.tt3.fieldbyname('Num/Lung').Value*dm1.tt1.fieldbyname('Altezza netta').Value;
      end; // with

    if finestrata<>0 then  //pareti finestrate
      begin
      inc(ambienti_d^[a_cor].Npar);
      with   ambienti_d^[a_cor].par[ambienti_d^[a_cor].Npar] do
        begin
        //dm1.TT3.fields[1].value:=Lato1;
        Item:=0;//modificato per pareti finestrate
        //conteggia il numero di finestre in base alla larghezza
        //tollerato un'eccesso dell' 1%
        Num:=round(ambienti_d^[a_cor].par[ambienti_d^[a_cor].Npar-1].Num/finestre_D^[finestrata].Larghezza);
        if num*finestre_D^[finestrata].Larghezza-(ambienti_d^[a_cor].par[ambienti_d^[a_cor].Npar-1].Num/finestre_D^[finestrata].Larghezza)>
        ambienti_d^[a_cor].par[ambienti_d^[a_cor].Npar-1].Num*0.01 then
        Num:=trunc(ambienti_d^[a_cor].par[ambienti_d^[a_cor].Npar-1].Num/finestre_D^[finestrata].Larghezza);

        // Emanuela 1/8/2005 inserita l'inizializzazione perchè dava errore di invalid point operation
        Alt := 0;
        Alt2 := 0;
        Lato := '';
        Confine := '';
        sup := 0;
       { x1  := bll^[j].x/100;
        y1  := bll^[j].y/100;       }
        {Emanuela 11/1/2010 modificate in modo da prendere la giusta conversion}
        x1:=xmedpar;  //modificato per pareti finestrate
        y1:=Ymedpar;
        {
        If (minimox<0) or (minimoy<0) then
            dispf:=0.1 else dispf:=0;
        x1:=(bll^[j].x+Minimox-dispf)/ftscalap;
        y1:=(bll^[j].y+Minimox-dispf)/ftscalap;
        }
        x2  := 0;
        y2  := 0;
        (*
        If (str_tofloat(attrib1[2])<>0){and(attrib1[2]<>'')and(attrib1[2]<>' ')} then Sup:=str_tofloat(attrib1[2])
        else Sup:=Cercafin(attrib1[1]);
        Cod:=attrib1[1];
        *)
        sup:=finestre_D^[finestrata].SuperfUnit;
        cod:=finestre_D^[finestrata].Codice;
        Lato:='-';
        Tipo:='Finestra';

        end;
      finestrata:=0;
      end
    end;  //for  j:=1 to ripetiz do
  colore:=coloretemp;//lo devo ripristinare per i piani clone
  end; // with Ft^[i] do

end;

//Lucernai
Var Hsottofincor:real;
    Indfincor,IndAmbLuc:integer;
Function Cercafin(codfin:string):real;
Var i:integer;
begin
result:=0;
I:=1;
while (i<Nfinestre)and(upstring(codfin)<>upstring(finestre_D^[i].codice)) do inc(i);
if upstring(codfin)=upstring(finestre_D^[i].codice) then
  begin
  result:=finestre_D^[i].SuperfUnit;
  //Lucernai
  Hsottofincor:=finestre_D^[i].AltSottoFin;
  indfincor:=i;
  end;
end;

Procedure caricafinPOnti(Lato1:string;NumPar:integer);
Var j,k,ia, ftscalaf:integer;
    tt:real;
    dispf: Real;

begin
if not cercaamb(lato1) then exit;
ftscalaf:=100;
dispf := 0;
for j:=1 to Ultblocco do
with bll^[j] do
  begin
  if (Nome='FIN') then
    begin

    If ((attrib1[5]='')and(numpar<>0)and(ambienti=NumPar))or  //Finestre normali
        //lucernai
        ((attrib1[5]<>'')and(numpar=0)and
          ((Ft^[ambienti].A1=indambluc)or(Ft^[ambienti].A2=indambluc))
        )
     then
      begin
      inc(ambienti_d^[a_cor].Npar);
      with   ambienti_d^[a_cor].par[ambienti_d^[a_cor].Npar] do
        begin
        //dm1.TT3.fields[1].value:=Lato1;
        Item:=-j;
        Num:=0;
        // Emanuela 1/8/2005 inserita l'inizializzazione perchè dava errore di invalid point operation
        Alt := 0;
        Alt2 := 0;
        Lato := '';
        Confine := '';
        sup := 0;
       { x1  := bll^[j].x/100;
        y1  := bll^[j].y/100;       }
        {Emanuela 11/1/2010 modificate in modo da prendere la giusta conversion}
        If (minimox<0) or (minimoy<0) then
            dispf:=0.1 else dispf:=0;
        x1:=(bll^[j].x+Minimox-dispf)/ftscalaf;
        y1:=(bll^[j].y+Minimox-dispf)/ftscalaf;
        x2  := 0;
        y2  := 0;
        If (str_tofloat(attrib1[2])<>0){and(attrib1[2]<>'')and(attrib1[2]<>' ')} then Sup:=str_tofloat(attrib1[2])
        else Sup:=Cercafin(attrib1[1]);
        Cod:=attrib1[1];
        Lato:='-';
        Tipo:='Finestra';
        end;
      end
    end
  else
   begin
    if (Nome='PON') then
    If (numpar<>0)and(ambienti=NumPar) then
    begin
    inc(ambienti_d^[a_cor].Npar);
      with   ambienti_d^[a_cor].par[ambienti_d^[a_cor].Npar] do
        begin
        //dm1.TT3.fields[1].value:=Lato1;
        Item:=-j;
        //v_recPar.Set_num(strtoint(attrib1[2]));
        // Emanuela 5/02/2003
        num:=Str_ToFloat(attrib1[2]);
        // Emanuela 1/8/2005 inserita l'inizializzazione perchè dava errore di invalid point operation
        Alt := 0;
        Alt2 := 0;
        Sup:=0;
        Confine := '';
        {Emanuela 11/1/2010 modificate in modo da prendere la giusta conversion}
        If (minimox<0) or (minimoy<0) then
            dispf:=0.1 else dispf:=0;
       { x1  := bll^[j].x/100;
        y1  := bll^[j].y/100;      }
        {Emanuela 11/1/2010}
        x1:=(bll^[j].x+Minimox-dispf)/ftscalaf;
        y1:=(bll^[j].y+Minimox-dispf)/ftscalaf;
        x2  := 0;
        y2  := 0;
        //If (attrib1[2]<>'0')and(attrib1[2]<>'')and(attrib1[2]<>' ') then v_recPar.Set_Sup(strtoint(attrib1[2]))
        //else v_recPar.Set_Sup(Cercafin(attrib1[1]));
        Cod:=attrib1[1];
        Lato:='-';
        Tipo:='Ponte_T';
        end;
    end
   end;
 end
end;
 Var TempSupAmb,ftscala,dsp, LungPar, AngoloFalda:real;
     tpp,tpp1:string;
     ff:textfile;
     indzona:integer;
 {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
    type TIntFin=record
                   item,itempar:integer;
                   xf,yf, larg, alt,angolo:real;
                  end;
    var Buffin:TInTfin;
        fIntfin:file of tintfin;
 {$IFEND}
begin
ind_pianocor:=indpianocor;
InitcolCad;
assign(fo, IncludeTrailingPathDelimiter(percorsoDrive) + pianocor + '.int');
try
  rewrite(fo);
  for i:=1 to Ultblocco do
  with bll^[i] do
  if (Nome='AMB')and(attrib1[1]<>'0') then //Cortile
    begin
    indambluc:=i;
    //attrib1[1]:=NumeraLocale(i);
    if not CercaAmb(Attrib1[1]) then
    caricaAmb(i)
    { Il locale viene caricato in fase di lettura DXF Diego V15
      begin
      Inc(Nambienti);
      new(ambienti_d^[Nambienti]);
      ambienti_d^[Nambienti].x1:=bll^[i].x+Minimox-0.1;
      ambienti_d^[Nambienti].y1:=bll^[i].y+Minimoy-0.1;

      ambienti_d^[Nambienti].CodNum:=Attrib1[1];
      A_cor:=Nambienti;
      ambienti_d^[A_cor].impianto:=impianto_d^[1].Codice;
      azzeraidentif;
      tpp:=leggiidentif1(Attrib1[4]);
      if tpp<>'' then ambienti_d^[A_cor].CodZona:=tpp;
      tpp:=leggiidentif1(Attrib1[4]);
      if tpp<>'' then ambienti_d^[A_cor].Impianto:=tpp;
      //copiadatizona(1);
      if cercazona(ambienti_d^[A_cor].CodZona,indzona) then
         copiadatizona(indzona);
      ambienti_d^[A_cor].Npar:=0;
      //forzatura altezza ed infiltrazioni piano inserita temporaneamente da diego
      ambienti_d^[A_cor]^.HSoffitto:=piani_D^[ind_pianocor].AltN;
      ambienti_d^[A_cor]^.InfInv:=zone_d^[1].InfInv;
      end  }
    else
      begin
      ambienti_d^[A_cor]^.Piano:=pianocor;
      //ambienti_d^[Nambienti].CodNum:=Attrib1[1];
      end;
    // Si attiva solo nella versione autocad;
    azzeraidentif;
    tpp:=leggiidentif1(Attrib1[4]);// Zona
    //if tpp<>'' then Cercazona(tpp);
    if tpp<>'' then Cercazona(tpp,indzona);
    tpp:=leggiidentif1(Attrib1[4]); //impianto
    if tpp<>'' then ambienti_d^[A_cor].Impianto:=tpp;
    azzeraidentif;
    tpp:=leggiidentif1(Attrib1[5]);// Tipo Pavimento
    if Uppercase(tpp)=Da_Piano then Tpp:=Piani_D^[Ind_Pianocor].T_Pav;
    {if tpp<>'' then} ambienti_d^[A_cor].T_Pav:=tpp;
    tpp:=leggiidentif1(Attrib1[5]); //Confine pavimento
    if Uppercase(tpp)=Da_Piano then Tpp:=Piani_D^[Ind_Pianocor].C_Pav;
    azzeraidentif;
    {if tpp<>'' then} ambienti_d^[A_cor].C_Pav:=tpp;
    tpp:=leggiidentif1(Attrib1[6]);// Tipo soffitto
    if Uppercase(tpp)=Da_Piano then Tpp:=Piani_D^[Ind_Pianocor].T_Soff;
    {if tpp<>'' then} ambienti_d^[A_cor].T_Soff:=tpp;
    tpp:=leggiidentif1(Attrib1[6]); //Confine soffitto
    if Uppercase(tpp)=Da_Piano then Tpp:=Piani_D^[Ind_Pianocor].C_Soff;
    {if tpp<>'' then }ambienti_d^[A_cor].C_soff:=tpp;
    // fine zona autocad;

    ambienti_d^[A_cor].Npar:=0;

   //All ambienti_d^[A_cor]^.Superficie:=lunghezza(area(ar^[strtoint(Attrib1[1])]));
    ambienti_d^[A_cor]^.Superficie := RoundTo(ar^[strtoint(Attrib1[1])]/10000, -5);//all
    ambienti_d^[A_cor]^.Denom := Attrib1[2];
    ambienti_d^[A_cor]^.V:='*';
    ambienti_d^[A_cor]^.Piano:=pianocor;

    //Spostato perche in questo punto non considera i divisori
    //if not CercaZona(ambienti_d^[A_cor].CodZona,indzona) then copiadatizona(1,ind_pianocor,A_cor)
    //else copiadatizona(indzona,ind_pianocor,A_cor);


    //if not CercaZona(ambienti_d^[A_cor].CodZona) then copiadatizona(1);
    //V_recAmb.Set_Piano('Pippo');
    if (ambienti_d^[a_cor].T_Pav<>'')and(ambienti_d^[a_cor].C_Pav<>'') then
      begin
      inc(ambienti_d^[a_cor].Npar);
      with   ambienti_d^[a_cor].par[ambienti_d^[a_cor].Npar] do
        begin
        Item:=0;
        // Emanuela 1/8/2005 inserita l'inizializzazione perchè dava errore di invalid point operation
        Num := 0;
        Alt := 0;
        Alt2 := 0;
        Sup := 0;
        Cod := '';
        Confine := '';
        x1 := 0;
        y1 := 0;
        x2 := 0;
        y2 := 0;
        tempsupAmb:=ambienti_d^[a_cor].Superficie;
        if tempsupamb <> 0 then
           Sup := tempsupamb
        else Sup := 0;
        Cod:=ambienti_d^[a_cor].T_Pav;
        Lato:='OR';
        Confine:=ambienti_d^[a_cor].C_Pav;
        Tipo:='Pavimento';
        end;
      end;
    if (ambienti_d^[a_cor].T_Soff<>'')and(ambienti_d^[a_cor].C_Soff<>'') then
      begin
      inc(ambienti_d^[a_cor].Npar);
      with   ambienti_d^[a_cor].par[ambienti_d^[a_cor].Npar] do
        begin
        Item:=0;
        // Emanuela 1/8/2005 inserita l'inizializzazione perchè dava errore di invalid point operation
        Num := 0;
        Alt := 0;
        Alt2 := 0;
        Sup := 0;
        Cod := '';
        Confine := '';
        x1 := 0;
        y1 := 0;
        x2 := 0;
        y2 := 0;
        AngoloFalda := RestituisciAngoloFalda(ambienti_d^[a_cor].C_Soff);
        if ambienti_d^[a_cor].Superficie <> 0 then
        begin
         if Cos(DegToRad(AngoloFalda)) <> 0 then
           Sup:=ambienti_d^[a_cor].Superficie / Cos(DegToRad(AngoloFalda))
         else Sup:=ambienti_d^[a_cor].Superficie;
        end
        else Sup := 0;
        Cod := '';
        Confine := '';
        Cod:=ambienti_d^[a_cor].T_Soff;
        Lato:='OR';
        Confine:=ambienti_d^[a_cor].C_Soff;
        Tipo:='Soffitto';
        end;
      //Lucernai
      caricafinPOnti(ambienti_d^[a_cor].codnum,0);
      end;
    end;


  {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
     Nblocchitemp:=Ultblocco;
     Eleva_Pareti;
  {$IFEND}

  for i:=1 to ultft do
  with Ft^[i] do
  if true {confini a temperature diverse} then
    begin
    am1:='';
    am2:='';
    if (a1<>0)and(bll^[a1].Attrib1[1]<>'0') then   //Cortile
       am1:=bll^[a1].Attrib1[1];
    if (a2<>0)and(bll^[a2].Attrib1[1]<>'0') then   //Cortile
       am2:=bll^[a2].Attrib1[1];
    if (am1<>'')and(cercaAmb(am1)) then
      begin
      CaricaPar(am1,am2,true,i);
      caricafinPOnti(am1,i);
      end;
    if (am2<>'')and(cercaAmb(am2)) then
      begin
      CaricaPar(am2,am1,false,i);
      caricafinPOnti(am2,i);
      end;

    ftscala:=100;
    buf.NZon:=0;
    buf.item:=i;
    if (a1<>0)and(a2<>0) then
    begin
      buf.colore:=clgreen
    end
    else buf.colore:=clred;
    If (minimox<0)or(minimoy<0) then dsp:=0.1 else dsp:=0;
    // calcolo dello spessore
    if (am1<>'')and(am2<>'') then
    begin
     LungPar := sqrt(sqr(x1-x0)+sqr(y1-y0)) / 100;
     if cercaamb(am1) then
        ambienti_D^[A_cor].Superficie:=ambienti_D^[A_cor].Superficie -((spes_par(colore)*LungPar)/2);
     if cercaamb(am2) then
        ambienti_D^[A_cor].Superficie:=ambienti_D^[A_cor].Superficie-((spes_par(colore)*LungPar)/2);
    end;

   {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
      if am1<>'' then
      begin
      buf.x0:=(x0+Minimox-dsp)/ftscala;
      buf.y0:=(y0+Minimoy-dsp)/ftscala;
      buf.x1:=(x1+Minimox-dsp)/ftscala;
      buf.y1:=(y1+Minimoy-dsp)/ftscala;
      buf.NAmb  := am1;
      buf.NAmb2 := am2;
      write(fo,buf);
      end;
    if am2<>'' then  //p1 e p2 invertiti
      begin
      buf.x1:=(x0+Minimox-dsp)/ftscala;
      buf.y1:=(y0+Minimoy-dsp)/ftscala;
      buf.x0:=(x1+Minimox-dsp)/ftscala;
      buf.y0:=(y1+Minimoy-dsp)/ftscala;
      buf.NAmb    :=am2;
      buf.NAmb2   :=am1;
   {$ELSE}
    buf.x0:=(x0+Minimox-dsp)/ftscala;
    buf.y0:=(y0+Minimoy-dsp)/ftscala;
    buf.x1:=(x1+Minimox-dsp)/ftscala;
    buf.y1:=(y1+Minimoy-dsp)/ftscala;
    if am1<>'' then
      begin
      buf.NAmb    :=am1;
      write(fo,buf);
      end;
    if am2<>'' then
      begin
      buf.NAmb    :=am2;
   {$IFEND}
      write(fo,buf);
      end;
    end;

  for i:=1 to Nambienti do
  if uppercase(pianocor)=uppercase(ambienti_d^[i].piano) then
    begin
    //Spostato perche in questo punto non considera i divisori
    if not CercaZona(ambienti_d^[i].CodZona,indzona) then copiadatizona(1,ind_pianocor,A_cor)
    else copiadatizona(indzona,ind_pianocor,i);
    end;
  //varcarichi.Disposepuntatori;
   {
  dm1.TT1.First;
  initassociata;
  while not(dm1.TT1.Eof) do
    begin
    tempsupamb:= V_recamb.Superficie;
    dm1.TT3.First;
    while not(dm1.TT3.Eof) do
      begin
      if FormST(V_RecPar.lato)='OR' then
        begin
        dm1.TT3.Edit;
        V_RecPar.Set_Sup(tempsupamb);
        dm1.TT3.Post;
        end;
      dm1.TT3.next;
      end;
    dm1.TT1.next;
    end;
  }

 {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
  assign(fIntFin, IncludeTrailingPathDelimiter(percorsoDrive) + pianocor + '.fin');
  try
    rewrite(fIntfin);
    for i:=1 to Ultblocco do
    with bll^[i] do
    if Nome='FIN' then
      begin
      buffin.xf:=(x+Minimox-dsp)/ftscala;
      buffin.Yf:=(Y+Minimoy-dsp)/ftscala;
      buffin.Larg := str_tofloat(Attrib1[3]);
      buffin.alt  := str_tofloat(Attrib1[4]);
      buffin.Item:=i;
      buffin.ItemPar:=ambienti;
      //Lucernai
      buffin.angolo:=angolo;
      if attrib1[5]='2' then buffin.angolo:=buffin.angolo+180;
      write(fIntfin,Buffin);
      end;
    close(fIntfin);
  except
    close(fIntfin);
  end;
  {$IFEND}
 close(fo);
except
 close(fo);
end;
end;

{-----------------------------------------------------------------------------
  Procedure: RestituisciAngoloFalda
  Author:    e.diquattro
  Date:      04-apr-2006
  Arguments: codFalda: String
  Result:    Real
  
  Cosa fa:
-----------------------------------------------------------------------------}
function RestituisciAngoloFalda(codFalda: String): Real;
var
  Table: TTable;
  Trovato: Boolean;
begin
  Result := 0;
  Table := TTable.Create(Nil);
  Table.DatabaseName := Percorso_progetti;
  Table.TableName := 'Confine.db';
  Table.Close;
  Table.Open;
  Trovato := False;
  while (not Table.Eof) and (not Trovato) do
  begin
   if CompareStr(Table.fieldByName('Codice').asString, CodFalda) = 0 then
   begin
      Result := Table.fieldByName('Inclinazione').AsFloat;
      Trovato := True;
   end;
   Table.Next;
  end;
  Table.Close;
  FreeAndNil(Table);
end;

end.
