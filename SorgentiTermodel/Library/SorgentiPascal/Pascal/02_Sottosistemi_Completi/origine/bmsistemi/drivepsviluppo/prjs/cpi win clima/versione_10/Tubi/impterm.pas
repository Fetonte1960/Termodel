unit ImpTerm;

INTERFACE
uses sysutils,libreriagenerale,definiz,udbt,udatalink,varcarichi,angoli,gestdim,Uleggiscrividati,ugrafodxf,dxf_in_out,calcolo_tubi
    {$Ifdef Versione_14}
    ,grafica2d
    {$Else}
    ,grafica
    {$endif}
    , DBTables, Math,
     Dialogs, Msg;

Procedure Initcercacod;
Procedure Closecercacod;
Function Caricacodice(x,y:real;Piano:string;Var nambterm:integer):string;
procedure CaricaCodiciTerminali;
// Emanuela 15/11/2004
procedure SuggerisciModello(var Term: RecGTerm);
function VerificaModelloRadiatore(Term: RecGTerm): Boolean;
procedure SuggerisciModelloFancoil(var Term: RecGTerm);
function VerificaModelloVentilConvettori(Term: RecGTerm): Boolean;
function  RestituisciDatiImpianto(CodImpianto: String; Tag: Integer): Double;
function RestituisciImpianto(CodiceAmb: Integer): String;
Procedure CaricaPotenzaEstivaTerm;
Procedure TrovaModello;
function RestituisciDatiZona(CodZona: String; Tag: Integer): Double;
procedure DatiImpiantiZone(CodiceLocale: Integer; var TIH20I, StI, TAmbienteZ: Double);
Function Ind_terminale(serie,modello:string;Var indmodello:integer):integer;
Function CercaPuntoLoc(x,y:real;Piano:string):integer;
Function CercaPuntoLoc_D(x,y:real;Piano:string):integer;
Function Area_circ(nomepiano:string;indcirc:integer):real;
Procedure Carica(Nome:string;NA,NZ:Integer);
Procedure Debug_Carica(Nome:string;NA,NZ:Integer);
function TrovaAmb(Xin,YIn : real):boolean;
Procedure Scegli_terminale(pianosel,seriesel:string;xpoint,ypoint,incr,lmax,potinp:real;retecorrente:string);
function PotenzaEstivaLocale(num_amb:integer):real;
function PotenzaInvernaleLocale(num_amb:integer):real;
Procedure Carica_fileInt(estens:string);
Function SuperficieLocale(num_amb:integer):real;
Procedure trova_modello;



var MaxNumAmb                  : integer;
    Ci_sono_pannelli:boolean;
implementation
{$Ifdef Versione_14}
uses ritornodxf,pannelli{,letturaInMemoria};
{$Else}
uses UMain_CalcTubi;
{$Endif}


var
      Inizio,Fine                : Boolean;
      NZona                      : integer;
      stzona                     : string[2];
      numpiano,nambint           : integer;
      trovato                    : boolean;
      NumMax,NumMin              : integer;
      Minx,Miny                  : Real;





Procedure Debug_Carica(Nome:string;NA,NZ:Integer);
var i:integer;

begin
nentita:=0;

assign(Fftht,Nome);
try
  reset(Fftht);
  while not eof( FFtht) do
    begin
    read(Fftht,Ftht);
    Add_LineaDxf(FtHt.x0,FtHt.y0,0,FtHt.x1,FtHt.y1,0,'0','1','Continuous');
    if str_tofloat(Ftht.NAmb)=NA then
    Add_TestoDxf((FtHt.x0+FtHt.x1)/2,(FtHt.y0+FtHt.y1)/2,0,0,Ftht.NAmb,'0','1');
    end;
  close(Fftht);
except
  close(Fftht);
end;




output_dxf(i_sl(percorsodrive)+'debug_ftht'+{inttostr(Na)+}'.dxf');

end;


Procedure Carica(Nome:string;NA,NZ:Integer);
var i:integer;

begin
assign(Fftht,Nome);
try
  reset(Fftht);
  i:=0;
  MaxNumAmb := 0;
  while not eof( FFtht) do
    begin
    read(Fftht,Ftht);
    if NA= StrToInt(FtHt.NAmb) then
      begin
      inc(i);
      TabFtht^[i]:=FtHt;
      end;
    end;
  MaxNumAmb := i;
  close(Fftht);
except
  close(Fftht);
end;
end;

function TrovaAmb(Xin,YIn : real):boolean;
var
  fr,Count,Risultato        : integer;
  Infx,Infy,xx,yy           : real;
  apr                       : real;


{ ---------------------------- main CercaAmb ------------------------------ }
{$I Inters1_inpterm }
begin

{  Writeln(lst,' X1:',XIn:6:1,'  Y1:',Yin:6:1);}
  apr:=0.0001;
  xx := 0;  yy := 0;
  Risultato := 0;

  minx:=0;
  miny:=0;
  for fr:=1 to  MaxNumAmb do
  if TabFtHt^[fr].NAmb > ''  then
    begin
    if TabFtHt^[fr].x0<minx then minx:=TabFtHt^[fr].x0;
    if TabFtHt^[fr].x1<minx then minx:=TabFtHt^[fr].x1;
    if TabFtHt^[fr].y0<miny then miny:=TabFtHt^[fr].y0;
    if TabFtHt^[fr].y1<minx then miny:=TabFtHt^[fr].y1;
    end;
  Infx := minx-10;
  Infy := miny-10;
  Fr   := 1;
  Count:= 0;

  // while (fr <= MaxNumFr) do
  while (fr <= MaxNumAmb) do
    begin
       if TabFtHt^[fr].NAmb > '' then
        begin

           inters(xx,yy,Risultato,Infx,Xin, TabFtHt^[fr].x0,TabFtHt^[fr].x1,
                  Infy,Yin, TabFtHt^[fr].y0,TabFtHt^[fr].y1);
           if Risultato = 1 then
            begin
               if ( ((abs(xx - TabFtHt^[fr].x0)) <= 0.01 ) and ((abs(yy - TabFtHt^[fr].y0)) <= 0.01 ) ) or
                  ( ((abs(xx - TabFtHt^[fr].x1)) <= 0.01 ) and ((abs(yy - TabFtHt^[fr].y1)) <= 0.01 ) )then
                begin
                   Infx := Infx + 0.1;
                   count:=0;
                   fr:=0;
                end
               else count:=count+1;
            end;
           fr:=fr+1;
        end
       else fr:=MaxNumFr+1;
    end;
{   writeln(lst,'Contatore intersezioni ',count:4);}
   if ( count mod 2 ) = 0 then TrovaAmb:=false
   else TrovaAmb:=true;
end;

Procedure Initcercacod;
begin
if TabFtHt=nil then
new(TabFtHt);
end;

Function CercaAggregato(Na:integer):integer;
Var i:integer;
    ss:string;
begin
str(na,ss);
result:=NA;
if Nambienti=0 then exit;
i:=1;
While (i<Nambienti)and(ambienti_D^[i]^.CodNum<>ss)do inc(i);
if pos('AGGRE',uppercase(Ambienti_d^[i]^.Denom))<>0 then
result:=strtoint(copy(Ambienti_d^[i]^.Denom,7,length(Ambienti_d^[i]^.Denom)-6));
end;

Function CercaPuntoLoc(x,y:real;Piano:string):integer;
Var i,NN,PROG:integer;
    trovato,duplicato:boolean;
begin
Initcercacod;
result:=0;
//if fileexists(percorsoDrive+ '\' + Piano + '.int') then
if fileexists(IncludeTrailingPathDelimiter(percorsoDrive) + Piano + '.int') then
  begin
  nummax:=0;
  numMin:=15000;
  //assign(Fftht,percorsoDrive+ '\' + Piano + '.int');
  assign(Fftht,IncludeTrailingPathDelimiter(percorsoDrive )+ Piano + '.int');
  try
    reset(Fftht);
    while not eof(Fftht) do
    begin
      read(Fftht,Ftht);
      with ftht do
        begin
        if StrToInt(namb)<NumMin then nummin:= StrToInt(namb);
        if StrToInt(namb)>NumMax then nummax:= StrToInt(namb);
        end;
    end;
    close(Fftht);
  except
    close(Fftht);
  end;
  NN:=NumMin;
    repeat
    //carica(percorsoDrive+ '\' + Piano + '.int',NN,1);
    carica(percorsoDrive + Piano + '.int',NN,1);
    //if  NN=2002 then
    //showmessage('stop');
    trovato:=trovaamb(x,y);
    if not trovato then inc(nn);
    until (trovato)or(nn>NumMax);
  if trovato then result:=nn;
  end;
end;
var ult_piano_elab:string='';
    Ind_piano_elab:integer;
Procedure Carica_fileInt(estens:string);
Var i:integer;
begin
nLineInt:=0;
for i:=1 to Npiani do
if fileexists(I_sl(percorsoDrive) + Piani_d[i].Cod +'.'+ estens) then
  begin
  listapiani[i].inizio:=nLineInt+1;
  assign(Fftht,I_sl(percorsoDrive) + Piani_d[i].Cod +'.'+ estens);
  reset(Fftht);
  while not eof(Fftht) do
    begin
    inc(nLineInt);
    if ar_ftht[nLineInt]=nil then new(ar_ftht[nLineInt]);
    read(Fftht,ar_ftht[nLineInt]^.Datiftht);
    ar_ftht[nLineInt]^.Piano:=Piani_d[i].Cod;
    end;
  listapiani[i].fine:=nLineInt;
  close(Fftht);
  end;
end;
{ TODO -cLavorazione dividi : Funzione puntoloc che aggancia i file inp }
Function CercaPuntoLoc_D(x,y:real;Piano:string):integer;
Var i,NN,PROG:integer;
    trovato,duplicato:boolean;

Procedure Cercapunto_old(estens:string);
begin
result:=0;
//if fileexists(percorsoDrive+ '\' + Piano + '.int') then
if fileexists(IncludeTrailingPathDelimiter(percorsoDrive) + Piano +'.'+ estens) then
  begin
  nummax:=0;
  numMin:=15000;
  //assign(Fftht,percorsoDrive+ '\' + Piano + '.int');
  assign(Fftht,IncludeTrailingPathDelimiter(percorsoDrive )+ Piano +'.'+ estens);
  try
    reset(Fftht);
    while not eof(Fftht) do
    begin
      read(Fftht,Ftht);
      with ftht do
        begin
        if StrToInt(namb)<NumMin then nummin:= StrToInt(namb);
        if StrToInt(namb)>NumMax then nummax:= StrToInt(namb);
        end;
    end;
    close(Fftht);
  except
    close(Fftht);
  end;
  NN:=NumMin;
    repeat
    //carica(percorsoDrive+ '\' + Piano + '.int',NN,1);
    carica(percorsoDrive + Piano +'.'+ estens,NN,1);
    trovato:=trovaamb(x,y);
    if not trovato then inc(nn);
    until (trovato)or(nn>NumMax);
  if trovato then result:=nn;
  end;
end;
Procedure Cercapunto(estens:string);

function Indice_piano:integer;
Var j:integer;
begin
if piano=ult_piano_elab then  result:=Ind_piano_elab
else
  begin
  j:=1;
  while (j<npiani)and(uppercase(piani_d^[j].Cod)<>uppercase(piano))do inc(j);
  Ind_piano_elab:=j;
  ult_piano_elab:=piano;
  result:=j;
  end;
end;
begin
result:=0;
MaxNumAmb:=0;
trovato:=false;
i:=listapiani[Indice_piano].inizio-1;
while (not trovato)and(i<listapiani[Indice_piano].fine) do
  begin
  inc(MaxNumAmb);
  inc(i);
  //if MaxNumAmb=0 then
  //showmessage('!');
  TabFtHt^[MaxNumAmb]:=ar_ftht[i]^.Datiftht;
  if (i=listapiani[Indice_piano].fine)or( ar_ftht[i]^.Datiftht.NAmb<>ar_ftht[i+1]^.Datiftht.NAmb)then
    begin
    trovato:=trovaamb(x,y);
    MaxNumAmb:=0;
    end;
  end;
if trovato then result:=StrToInt(ar_ftht[i]^.Datiftht.NAmb);
end;
begin
Initcercacod;
cercapunto('inp');
end;

Function Area_circ(nomepiano:string;indcirc:integer):real;
type
areaLoc=record
        locale:integer;
        area:real;
        end;
var
fo1:file of areaLoc;
ba:arealoc;
trovato:boolean;
begin
trovato:=false;
assign(fo1, IncludeTrailingPathDelimiter(percorsoDrive) + nomepiano + '.ina');
reset(fo1);
while (not trovato)and(not eof(fo1)) do
  begin
  read(fo1,ba);
  trovato:=ba.locale=indcirc;
  end;
close(fo1);
if trovato then result:=ba.area
else result:=0;
end;

Function Caricacodice(x,y:real;Piano:string;Var nambterm:integer):string;
Var i,NN,PROG:integer;
    trovato,duplicato:boolean;
begin
Initcercacod;
result:='???';
//if fileexists(percorsoDrive+ '\' + Piano + '.int') then
if fileexists(IncludeTrailingPathDelimiter(percorsoDrive) + Piano + '.int') then
  begin
  nummax:=0;
  numMin:=15000;
  //assign(Fftht,percorsoDrive+ '\' + Piano + '.int');
  assign(Fftht,IncludeTrailingPathDelimiter(percorsoDrive )+ Piano + '.int');
  try
    reset(Fftht);
    while not eof(Fftht) do
    begin
      read(Fftht,Ftht);
      with ftht do
        begin
        if StrToInt(namb)<NumMin then nummin:= StrToInt(namb);
        if StrToInt(namb)>NumMax then nummax:= StrToInt(namb);
        end;
    end;
    close(Fftht);
  except
    close(Fftht);
  end;
  NN:=NumMin;
    repeat
    //carica(percorsoDrive+ '\' + Piano + '.int',NN,1);
    carica(percorsoDrive + Piano + '.int',NN,1);
    trovato:=trovaamb(x,y);
    if not trovato then inc(nn);
    until (trovato)or(nn>NumMax);
  if trovato then
    begin
    NambTerm:=cercaaggregato(NN);
    prog:=0;
      Repeat
      inc(prog);
      result:='L-'+floattostr(NN)+'/'+floattostr(PROG);
      i:=0;
      duplicato:=false;
      while (not duplicato)and(i<Ngterm-1) do
        begin
        inc(i);
        duplicato:=result=Gterm^[i].cod;
        end;
      until not duplicato
    end;
  end;
  //Dispose(TabFtHt);
end;

Function Incr_dec(incrperc:real):real;
begin
result:=1+incrperc/100;
end;

Procedure Closecercacod;
type TIntPot = record
              NumAmb: Integer;
              NomeLoc, Piano, CodGen: String[30];
              Pot, Port, DispInf, Vol, Sup, TInv: Double;
            end;
Var  BufIntPOt: TintPOt;
     FIntPOt: File of Tintpot;
     i,cc: Integer;
     ss: String;
     trov:boolean;
begin
//if fileexists(percorsoDrive+'\potinv.int') then
if fileexists(IncludeTrailingPathDelimiter(percorsoDrive) + 'potinv.int') then
begin
  //assign(fintpot,percorsoDrive+'\potinv.int');
  assign(fintpot, IncludeTrailingPathDelimiter(percorsoDrive) + 'potinv.int');
  try
    reset(fintpot);
    while not eof(fintpot) do
    begin
      read(fintpot,bufintpot);
      if Versione_Trial then bufintpot.POT:=1000;
      with bufintpot do
      begin
        // conta i radiatori dell'ambiente
        cc:=0;
        for i:=1 to ngterm do
        if gTerm^[i]^.cod<>'RIMANDO' then
            if gTerm^[i]^.numamb = numamb then Inc(cc);
        if CC <> 0 then str(POt/cc:1:0,ss);

        // carica i valori in tutti i radiatori dell'ambiente
        for i:=1 to ngterm do
        if gTerm^[i]^.cod<>'RIMANDO' then
        if gTerm^[i]^.numamb = numamb then
        { if (CompareStr(UpperCase(Gterm^[i]^.TipoTerm), Uppercase('FANCOIL')) <> 0) and
            ((gTerm^[i]^.Pot = 0) or (gTerm^[i]^.NumElementi = 0)) then }
           begin
           //gTerm^[i]^.cod:=gTerm^[i]^.cod+'( I:'+ss+' )' ;
           if cc<>0 then Gterm^[i]^.Pot:=Pot*incr_dec(Gterm^[i]^.IncrPotenza)/cc;
          end;
      end;
    end;
    close(Fintpot);
  except
    close(Fintpot);
  end;
end;
end;

function PotenzaEstivaLocale(num_amb:integer):real;
type TintPOtE=record
              NumAmb:integer;
              POtE:real;
             end;
Var
  BufIntPOt:TintPOtE;
  FIntPOt:file of TintpotE;
  i,cc:integer;
  ss:string;
  trov:boolean;
begin
result:=0;
if fileexists(IncludeTrailingPathDelimiter(percorsoDrive) + 'potest.int') then
begin
  assign(fintpot, IncludeTrailingPathDelimiter(percorsoDrive) + 'potest.int');
  try
    reset(fintpot);
    trov:=false;
    while (not eof(fintpot))and(not trov) do
    begin
      read(fintpot,bufintpot);
      with bufintpot do
      if num_amb=numamb then
        begin
        if Versione_Trial then POTE:=1000;
        result:=pote;
        trov:=true;
        end;
    end;
    close(Fintpot);
  except
    close(Fintpot);
  end;
end;
end;

Function SuperficieLocale(num_amb:integer):real;
begin
 { TODO -oDiego -cPannelli : Manca la gestione degli aggregati }
Result:=ambienti_D^[num_amb]^.Superficie;
end;

function PotenzaInvernaleLocale(num_amb:integer):real;
type TintPOtE=record
              NumAmb: Integer;
              NomeLoc, Piano, CodGen: String[30];
              Pot, Port, DispInf, Vol, Sup, TInv: Double;
              end;
Var
  BufIntPOt:TintPOtE;
  FIntPOt:file of TintpotE;
  i,cc:integer;
  ss:string;
  trov:boolean;
begin
{ TODO -oDiego -cPannelli : Manca la gestione degli aggregati }
result:=0;
if fileexists(IncludeTrailingPathDelimiter(percorsoDrive) + 'potinv.int') then
begin
  assign(fintpot, IncludeTrailingPathDelimiter(percorsoDrive) + 'potinv.int');
  try
    reset(fintpot);
    trov:=false;
    while (not eof(fintpot))and(not trov) do
    begin
      read(fintpot,bufintpot);
      if Versione_Trial then bufintpot.POT:=1000;
      with bufintpot do
      if num_amb=numamb then
        begin
        result:=pot;
        trov:=true;
        end;
    end;
    close(Fintpot);
  except
    close(Fintpot);
  end;
end;
end;

Procedure CaricaPotenzaEstivaTerm;
type TintPOtE=record
              NumAmb:integer;
              POtE:real;
             end;
Var
  BufIntPOt:TintPOtE;
  FIntPOt:file of TintpotE;
  i,cc:integer;
  ss:string;
begin
//if fileexists(percorsoDrive+'\potest.int') then
if fileexists(IncludeTrailingPathDelimiter(percorsoDrive) + 'potest.int') then
begin
  //assign(fintpot,percorsoDrive+'\potest.int');
  assign(fintpot, IncludeTrailingPathDelimiter(percorsoDrive) + 'potest.int');
  try
    reset(fintpot);
    while not eof(fintpot) do
    begin
      read(fintpot,bufintpot);
      with bufintpot do
      begin
        // conta i radiatori dell'ambiente

        if Versione_Trial then POTE:=1000;

        cc:=0;
        for i:=1 to ngterm do
            if gTerm^[i]^.numamb = numamb then Inc(cc);
        if CC <> 0 then str(POtE/cc:1:0,ss);

        // carica i valori in tutti i radiatori dell'ambiente
        for i:=1 to ngterm do
        if gTerm^[i]^.numamb = numamb then
         if CompareStr(UpperCase(Gterm^[i]^.TipoTerm), Uppercase('Fancoil')) = 0 then
         begin
          if (gTerm^[i]^.PotE = 0) then
          begin
           if cc<>0 then Gterm^[i]^.PotE:=PotE*incr_dec(Gterm^[i]^.IncrPotenza)/cc;
          end;
         end;
      end;
    end;
    close(Fintpot);
  except
    close(Fintpot);
  end;
end;
end;

Function Ind_terminale(serie,modello:string;Var indmodello:integer):integer;
Var i,j:integer;
begin
serie:=uppercase(serie);
//serie:='PEX';
modello:=uppercase(modello);
//modello:='P100_0.1';
result:=0;
if nterminali=0 then exit;
i:=1;
while (i<NTerminali)and(uppercase(Terminali_D^[i].cod)<>serie)do inc(i);
if uppercase(Terminali_D^[i].cod)=serie then
  begin
  if Terminali_D^[i].NDettTerminali=0 then exit;
  j:=1;
  while (j<Terminali_D^[i].NDettTerminali)and(uppercase(Terminali_D^[i].dettaglioterminali[j].Cod)<>modello) do inc(j);
  if uppercase(Terminali_D^[i].dettaglioterminali[j].Cod)=modello then
    begin
    result:=i;
    indmodello:=j;
    end;
  end;
end;

Function Num_elem(pot,pnom:real):integer;
var ne:real;
    tt:integer;
begin
if pnom=0 then
  begin
  result:=0;
  exit;
  end;
ne:=pot/Pnom;
result:=round(ne);
tt:=trunc(ne);
if (ne<>trunc(ne))and (result=trunc(ne))then inc(result);
end;



Procedure Scegli_terminale(pianosel,seriesel:string;xpoint,ypoint,incr,lmax,potinp:real;retecorrente:string);
Var Indamb,IA,indserie,i,j,count,nterm,num_el,countcirc,indicerete:integer;
const nome_fileout='scegliterminale.sel';
      rend_res=100;
      rend_marg=175;
Var   fo:textfile;
      Pinv_L,pest,PinvS,pestS,potel,smarg,totpan,lungtubo,portpannelli,dtpannelli,perdpannelli,supamb:real;
      numcirc:integer;
      stop,trovmod:boolean;
      segno,descriz:string;



Procedure dxffileint(pianoint,numambfint:string);
var i:integer;

begin
nentita:=0;
assign(fftht,i_sl(percorsoDrive) + Pianoint + '.int');
reset(fftht);
while not(eof(fftht)) do
  begin
  read(fftht,ftht);
  if ftht.NAmb=numambfint then
  Add_LineaDxf(ftht.x0,ftht.y0,0,ftht.x1,ftht.y1,0,'0','1','Continuous');
  end;
close(fftht);
output_dxf(i_sl(percorsodrive)+'debugfileint.dxf');
end;

begin
assign(fo,i_sl(percorsodrive)+nome_fileout);
rewrite(fo);
Leggi_mem_terminali;
indserie:=1;
while (indserie<Nterminali)and(terminali_d^[indserie].Cod<>seriesel)do inc(indserie);
Leggi_mem_locali;
Leggi_mem_reti;
set_indice_rete(retecorrente);
indicerete:=1;
while (indicerete<MaxGen)and(uppercase(GENERALITA_D1^[indicerete].Codice)<>uppercase(retecorrente)) do inc(indicerete);
Leggi_controllo(pianosel);
if not fileexists(i_sl(percorsodrive)+pianosel+'.int') then writeln(fo,'Calcoli non aggiornati.')
else if nterminali=0 then writeln(fo,'Non ci sono terminali in archivio.')
else if seriesel='' then writeln(fo,'Selezionare una serie.')
else if terminali_d^[indserie].Cod<>seriesel then writeln(fo,'Serie ',seriesel,' non trovata in archivio.')
else if terminali_d^[indserie].NDettTerminali=0 then writeln(fo,'Non ci sono modelli per questa serie.')
else
  begin
  //dxffileint(pianosel,'2002');
  with reccontrollo do
  indamb:=CercaPuntoLoc(xpoint-or_x,ypoint-or_Y,pianosel);
  if indamb=0 then
  writeln(fo,'Punto fuori dalla sagome dell''edificio.')
  else
    begin
    pinv_L:=0;
    pest:=0;
    Supamb:=0;
    descriz:='';
    // cerca il locale e vede se è aggregato
    for ia:=1 to nambienti do
    with ambienti_d^[ia]^ do
    if codnum=inttostr(indamb) then
      begin
      if (pos('AGGRE',denom)<>0) then
      indamb:=strtoint(copy(denom,7,length(denom)-6));
      break;
      end;
    //if (pos('AGGRE',denom)<>0) then ia1:=strtoint(copy(denom,7,length(denom)-6);
    //while (ia<Nambienti)and(ambienti_d^[ia]^.codnum<>inttostr(indamb))do inc(ia);
    //cerca il locale principale e gli aggregati
    for ia:=1 to nambienti do
    with ambienti_d^[ia]^ do
    if (codnum=inttostr(indamb))or((pos('AGGRE',denom)<>0)and(pos(inttostr(indamb),denom)<>0)) then
      begin
      if potinp<>0 then
        begin
        pinv_L:=potinp;
        pest:=potinp;
        end
      else
        begin
        pinv_L:=pinv_L+POtenzaInvernaleLocale(strtoint(codnum));
        pest:=pest+POtenzaEstivaLocale(strtoint(codnum));
        end;
      supamb:=supamb+superficie;
      if codnum=inttostr(indamb) then descriz:=denom;
      end;
    //eliminato with  ambienti_d^[ia]^ modifica aggregati
      begin
      writeln(fo,'Locale N:'+inttostr(indamb),' ',descriz+' '+float_to_str(Supamb,1)+' mq');
      if pos('PANNELLI',uppercase(terminali_d^[indserie].tipologia))=0 then
      writeln(fo,'PInv:',float_to_str(pinv_L,0),' PEst:',float_to_str(pest,0),' Incremento:',float_to_str(incr,1),' %')
      else writeln(fo,'PInv:',float_to_str(pinv_L,0),' Incr.:',float_to_str(incr,1),' % ' ,float_to_str(Pinv_L+Pinv_L*(incr/100),0),' W ',float_to_str((Pinv_L+Pinv_L*(incr/100))/supamb,0),' W/mq');

      pinv_L:=Pinv_L+Pinv_L*(incr/100);
      pest:=Pest+Pest*(incr/100);
      if pos('PANNELLI',uppercase(terminali_d^[indserie].tipologia))=0 then
      writeln(fo,'PInv:',float_to_str(pinv_L,0),' PEst:',float_to_str(pest,0),' Larghezza max:',float_to_str(lmax,2),' m');
      stop:=false;
      count:=0;
      nterm:=0;
      while (not stop)and(nterm<200) do
        begin
        inc(nterm);
        pinvs:=pinv_L/nterm;
        pests:=pest/nterm;
        i:=1;
        while (i<=terminali_d^[indserie].NDettTerminali)and(not stop) do
        with terminali_d^[indserie].DettaglioTerminali[i] do
          begin
          trovmod:=false;
          if uppercase(terminali_d^[indserie].tipologia)='RADIATORI' then
            begin
            num_el:=num_elem(pinv_L/nterm,pnom);
            trovmod:=(lmax=0)or(lmax>=num_el*largezzael/1000);
            if trovmod then
            writeln(fo,inttostr(nterm),' X ',cod,' ',inttostr(Num_el),' el. ',float_to_str(num_el*largezzael/1000,2),' m');
            stop:=count=4;
            end
          else
          if uppercase(terminali_d^[indserie].tipologia)='FANCOIL' then
            begin
            trovmod:=((lmax=0)or(lmax>=Larghezza_VC/1000));
            if trovmod then
              begin
              nterm:=Num_elem(pinv_L,pterminv);
              if Num_elem(pest,PFrigEstTot)> nterm then nterm:=Num_elem(pest,PFrigEstTot);
              pinvs:=pinv_L/nterm;
              pests:=pest/nterm;
              if pest>0 then
              writeln(fo,'N° ',inttostr(nterm),'  ',cod,'  Inv:+',float_to_str((pterminv-pinvs)/pinvs*100,0),' %   Est:+',float_to_str((PFrigEstTot-pests)/pests*100,0),' %  L:',float_to_str(Larghezza_VC/1000,2),' m')
              else writeln(fo,'N° ',inttostr(nterm),'  ',cod,'  Inv:+',float_to_str((pterminv-pinvs)/pinvs*100,0),' %  L:',float_to_str(Larghezza_VC/1000,2),' m');
              end;
            stop:=count=4;
            end
          else
          if pos('PANNELLI',uppercase(terminali_d^[indserie].tipologia))<>0 then
            begin
            { TODO -oDiego -cPannelli : Comando scegli }
            if supamb>0 then
              begin
              smarg:=0;
              if pinvs/supamb>rend_res then //rendimento zona residenziale
                begin
                if pinvs/supamb>rend_marg then //rendimento zona marginale
                  begin
                  smarg:=supamb;
                  writeln(fo,'Tutta zona marginale ',float_to_str(supamb,1),' mq ',float_to_str(supamb*rend_marg,0),' W ');
                  writeln(fo,'Superficie insufficiente.');
                  end
                else
                  begin
                  //(superficie-smarg)*rend_res+smarg*rend_marg=Pinvs
                  //superficie*rend_res-smarg*rend_res+smarg*rend_marg=pinvs
                  smarg:=(pinvs-supamb*rend_res)/(rend_marg-rend_res);
                  writeln(fo,'Zona residenziale massima ',float_to_str(supamb-smarg,1),' mq ',float_to_str((supamb-smarg)*rend_res,0),' W ');
                  writeln(fo,'Zona marginale minima ',float_to_str(smarg,1),' mq ',float_to_str(smarg*rend_marg,0),' W ');
                  end;
                end
              else writeln(fo,'Zona residenziale ',float_to_str(supamb,1),' mq ',float_to_str(supamb*rend_res,0),' W ');
              totpan:=(supamb-smarg)*rend_res+smarg*rend_marg;
              writeln(fo,'Totale :',float_to_str(totpan,0),' W Surplus:',float_to_str((totpan-pinvs)/pinvs*100,0),' %');
              for j:=1 to terminali_d^[indserie].NDettTerminali do
                begin
                lungtubo:=terminali_d^[indserie].dettaglioterminali[j].Sviluppo*supamb;
                setindserie(indserie,j);
                if abs((lungtubo/Maxmatassa)-round(lungtubo/Maxmatassa))<lungtubo*0.01  then  //piccola tolleranza sul calcolo 1%
                numcirc:=round(lungtubo/Maxmatassa)-1
                else numcirc:=trunc(lungtubo/Maxmatassa);
                countcirc:=0;
                  repeat
                  inc(countcirc);
                  inc(numcirc);
                  dtpannelli:=Calc_dt(pinv_L/numcirc,supamb/numcirc,tmandata,20);
                  PortPannelli := (pinv_L/numcirc) * 2.427184E-4/dtpannelli;
                  perdpannelli:=Perdita_Tubo(12{16-4},portpannelli)*lungtubo/numcirc;
                  until (perdpannelli<=MaxPerdCirc)or(countcirc>1000);
                writeln(fo,'Ps ',float_to_str(terminali_d^[indserie].dettaglioterminali[j].Passo,0),' mm ',' circ. ',inttostr(numcirc),'  ',float_to_str(supamb/numcirc,1),'  mq  perd.:',float_to_str(perdpannelli/1000,1),' kPa dt ',float_to_str(dtpannelli,1),' °C');
                end;
              stop:=true;
              trovmod:=true;
              end;
            end;
          if trovmod then inc(count);
          inc(i);
          end;
        if uppercase(terminali_d^[indserie].tipologia)='FANCOIL' then stop:=true;
        end;
      if count=0 then writeln(fo,'Nessun modello idoneo');
      end
    end;
  end;
close(fo);
end;



Procedure TrovaModello;
var
  IndImpiantocor,i,indseriedef,indmodello,seriefissa,modellofisso: Integer;
  p: Double;
  seriedef:string;
  tt,ne,incrdec:real;
  trovato:boolean;
begin
  // carica i valori in tutti i radiatori dell'ambiente
  {
  for i:=1 to ngterm do
  begin
  if Gterm^[i]^.TipoTerm='' then Gterm^[i]^.TipoTerm:='Radiatori';
    // Emanuela 15/11/2004 inseriamo il suggerimento del modello
    if CompareStr(Gterm^[i]^.TipoTerm, 'Radiatori') = 0 then
    begin
     if not VerificaModelloRadiatore(Gterm^[i]^) then
        SuggerisciModello(Gterm^[i]^);
     p := Gterm^[i]^.pot;
    end
    else
    begin
     if not VerificaModelloVentilConvettori(Gterm^[i]^) then
        SuggerisciModelloFancoil(GTerm^[i]^);
      if Gterm^[i]^.potE <> 0 then
         p := Gterm^[i]^.potE
      else p := Gterm^[i]^.Pot;
    end;

    // Emanuela 4/3/2004: inserito controllo affinchè non avvenga una divisione per zero
      if (Gterm^[i]^.Dt <> 0) then
         Gterm^[i]^.Port := p * 2.427184E-4/Gterm^[i]^.Dt;
  end;
  }
(*
IndImpiantocor:=1;    //serie definita in impianti
dmtutti.T_impianti.first;
seriedef:=Uppercase(V_recimp.CodTerm);
indseriedef:=1;
while (indseriedef<NTerminali)and(uppercase(Terminali_D^[indseriedef].Cod)<>seriedef)do inc(indseriedef);
*)
for i:=1 to ngterm do
with Gterm^[i]^ do
  begin
  incrdec:=1+IncrPotenza/100;
  if {fissaserie}true then
    begin
    seriefissa:=1;
    while (seriefissa<NTerminali)and(uppercase(Terminali_D^[seriefissa].Cod)<>uppercase(serie))do inc(seriefissa);
    end
  else  seriefissa:=indseriedef;
  TipoTerm:=uppercase(Terminali_D^[seriefissa].Tipologia);
  ci_sono_pannelli:=ci_sono_pannelli or (uppercase(copy(tipoterm,1,4))='PANN');

  if fissamodello then
    begin
    Modellofisso:=1;
    while (Modellofisso<Terminali_D^[seriefissa].NDettTerminali)and
          (uppercase(Terminali_D^[seriefissa].DettaglioTerminali[Modellofisso].Cod)<>uppercase(modello))do inc(Modellofisso);
    end
  else
    begin
    Modellofisso:=0;
    trovato:=false;
    while (Modellofisso<Terminali_D^[seriefissa].NDettTerminali)and(not trovato) do
      begin
      inc(Modellofisso);
      with terminali_d^[seriefissa].DettaglioTerminali[Modellofisso] do
        begin
        if tipoterm='RADIATORI' then
          begin
          NumElementi:=num_elem(pot,pnom);
          trovato:=((larghezzamax=0)or(larghezzamax>=largezzael*NumElementi/1000));
          end;
        if tipoterm='FANCOIL' then
          begin
          NumElementi:=0;
          trovato:=((larghezzamax=0)or(larghezzamax>=Larghezza_VC/1000))and
                   (POt*incrdec<=pterminv)and(PotE*incrdec<=PFrigEstTot);
          end;
        end;
      end;
    end;

  modello:=Terminali_D^[seriefissa].DettaglioTerminali[Modellofisso].Cod;

  if uppercase(tipoterm)='PANNELLI' then
    begin
    if not fissamodello then //scelta del passo
      begin
      Modellofisso:=Terminali_D^[seriefissa].NDettTerminali;
      end;
    end ;

  //serie:=Terminali_D^[seriefissa].DettaglioTerminali[Modellofisso].Cod;

  if uppercase(tipoterm)='RADIATORI' then
    begin
    Altezza:=Terminali_D^[seriefissa].DettaglioTerminali[Modellofisso].Altezza/1000;
    Profondita:=Terminali_D^[seriefissa].DettaglioTerminali[Modellofisso].Profondita/1000;
    NumElementi:=num_elem(pot,Terminali_D^[seriefissa].DettaglioTerminali[Modellofisso].pnom);
    Larghezza:=Terminali_D^[seriefissa].DettaglioTerminali[seriefissa].Largezzael*NumElementi/1000;
    if not ((larghezzamax=0)or(larghezzamax>=larghezza))then
    //Escluso provvisorio InserisciErrore('Radiatore fuori ingombro massimo .',piano,Xterm,Yterm);
    end;
  if uppercase(tipoterm)='FANCOIL' then
    begin
    NumElementi:=0;
    Altezza:=Terminali_D^[seriefissa].DettaglioTerminali[Modellofisso].Altezza_VC/1000;
    Profondita:=Terminali_D^[seriefissa].DettaglioTerminali[Modellofisso].Profondita_VC/1000;
    Larghezza:=Terminali_D^[seriefissa].DettaglioTerminali[Modellofisso].Larghezza_VC/1000;
    with Terminali_D^[seriefissa].DettaglioTerminali[Modellofisso] do
      begin
      if not(((larghezzamax=0)or(larghezzamax>=Larghezza)))  then
      InserisciErrore('Fancoil fuori ingombro massimo.',piano,Xterm,Yterm);
      if not((POt*incrdec<=pterminv)and(PotE*incrdec<=PFrigEstTot)) then
      InserisciErrore('Fancoil non sufficiente.',piano,Xterm,Yterm);
      end;
    end;
  p:=pot;
  if (Dt <> 0) then
  Gterm^[i]^.Port := p * 2.427184E-4/Gterm^[i]^.Dt;
  end;
end;

Procedure trova_modello;
Var i:integer;
begin
  for i := 1 to NGTerm do
  if GTerm[i]^.cod<>'RIMANDO' then
  if GTerm[i]^.Potinp<>0 then GTerm[i]^.Pot:=GTerm[i]^.Potinp;

  if CalcUnPiano='' then TrovaModello;
end;

procedure CaricaCodiciTerminali;
var
  i: Integer;
  Numamb: Integer;
begin
  for i := 1 to NGTerm do
  if GTerm[i]^.cod<>'RIMANDO' then
  begin
    GTerm[i].pot  :=0;
    GTerm[i].potE :=0;
    GTerm[i].numamb:=0;
    GTerm[i].cod := CaricaCodice(GTerm[i].XTerm, GTerm[i].Yterm, GTerm[i].Piano, GTerm[i].numamb);
  end;
  CloseCercaCod;
  CaricaPotenzaEstivaTerm;

  trova_modello;
end;

function VerificaModelloRadiatore(Term: RecGTerm): Boolean;
var
 Table_Serie, Table_Modello: TTable;
 CodiceModello: String;
 Larg: Double;
begin
 Result := False;
 if Term.Modello <> '' then
 begin
   Table_Modello := TTable.Create(nil);
   Table_Modello.databasename := Percorso_Archivi;
   Table_Modello.tablename    := 'TipoTerminali';
   Table_Modello.Open;
   Table_Modello.first;
   Table_Serie := TTable.Create(nil);
   Table_Serie.databasename := Percorso_Archivi;
   Table_Serie.tablename    := 'DettTerminali';
   Table_Serie.Open;
   Table_Serie.first;
   Trovato := False;
   while (not Table_Modello.Eof) and (not Trovato) do
   begin
     if CompareStr(Table_Modello.FieldByName('Codice').AsString, Term.Modello) = 0 then
     begin
       CodiceModello := Table_Modello.FieldByName('Codice').AsString;
       Trovato := True;
       Table_Serie.First;
       while (not Table_Serie.Eof) and (CompareStr(CodiceModello, Table_Serie.FieldByName('Codice').AsString) <> 0)  do
         Table_Serie.Next;
       Larg := (Table_Serie.FieldByName('Larghezza').AsFloat / 1000) * Term.NumElementi;
       if ((CompareValue(Larg, Term.LarghezzaMax, 0) = -1) or (SameValue(Larg, Term.LarghezzaMax, 0)))
       then Result := True;
     end;
     Table_Modello.Next;
   end;
  Table_Serie.Close;
  Table_Serie.Free;
  Table_Modello.Close;
  Table_Modello.Free;
 end;
end;

procedure SuggerisciModello(var Term: RecGTerm);
var
  Potenza, Prof, Alt, Larg, TIH2O, St, TAmbiente, Qe, Dt: Double;
  Trovato: Boolean;
  Table_Serie, Table_Modello: TTable;
  i: Integer;
  Serie, CodiceModello: String;
begin
  Table_Modello := TTable.Create(nil);
  Table_Modello.databasename := Percorso_Archivi;
  Table_Modello.tablename    := 'TipoTerminali';
  Table_Modello.Open;
  Table_Modello.first;
  Table_Serie := TTable.Create(nil);
  Table_Serie.databasename := Percorso_Archivi;
  Table_Serie.tablename    := 'DettTerminali';
  Table_Serie.Open;
  Table_Serie.first;
  Trovato := False;
  CodiceModello := Term.Modello;
  Table_Serie.First;
  while (not Table_Serie.Eof) and (not Trovato) do
  begin
    if (CompareStr(CodiceModello, Table_Serie.FieldByName('Codice').AsString) = 0) then
    begin
      if Term.numamb <> 0 then
         DatiImpiantiZone(Term.numamb, TIH2O, St, TAmbiente)
      else DatiImpiantiZone(0, TIH2O, St, TAmbiente);
      Dt := (TIH2O - (St /2)) - TAmbiente;
      Qe := Table_Serie.FieldByName('Potenza').AsFloat*(power((Dt/60), Table_Serie.FieldByName('Esponente').AsFloat));
      Term.NumElementi := Round(Term.Pot / Qe);
      Larg := (Table_Serie.FieldByName('Larghezza').AsFloat / 1000) * Term.NumElementi;
      if ((CompareValue(Larg, Term.LarghezzaMax, 0) = -1) or (SameValue(Larg, Term.LarghezzaMax, 0)))
      then
      begin
        Term.Profondita := Table_Serie.FieldByName('Profondita').AsFloat / 1000;
        Term.Altezza    := Table_Serie.FieldByName('Altezza').AsFloat / 1000;
        Term.Larghezza  := Larg;
        Term.Serie      := Table_Serie.FieldByName('Descrizione').AsString;
        Trovato := True;
      end;
    end;
    Table_Serie.Next;
  end;
  Table_Serie.Close;
  Table_Serie.Free;
  Table_Modello.Close;
  Table_Modello.Free;
end;

function VerificaModelloVentilConvettori(Term: RecGTerm): Boolean;
var
 Table_Serie, Table_Modello: TTable;
 CodiceModello: String;
 TImmHI, TImmHE, TImmAI, TImmAE, StHI, StHE: Double;
 Impianto: String;
begin
 Result := False;
 if Term.Modello <> '' then
 begin
   Impianto := RestituisciImpianto(Term.numamb);
   TImmHI   := RestituisciDatiImpianto(Impianto, 9);
   TImmHE   := RestituisciDatiImpianto(Impianto, 7);
   TImmAI   := RestituisciDatiImpianto(Impianto, 32);
   TImmAE   := RestituisciDatiImpianto(Impianto, 33);
   StHE     := RestituisciDatiImpianto(Impianto, 8);
   StHI     := RestituisciDatiImpianto(Impianto, 10);
   Table_Modello := TTable.Create(nil);
   Table_Modello.databasename := Percorso_Archivi;
   Table_Modello.tablename    := 'TipoTerminali';
   Table_Modello.Open;
   Table_Modello.first;
   Table_Serie := TTable.Create(nil);
   Table_Serie.databasename := Percorso_Archivi;
   Table_Serie.tablename    := 'DettVentilConvettori';
   Table_Serie.Open;
   Table_Serie.first;
   Trovato := False;
   CodiceModello := Term.Modello;
   Trovato := True;
   Table_Serie.First;
   while (not Table_Serie.Eof) and (CompareStr(CodiceModello, Table_Serie.FieldByName('Codice').AsString) <> 0)  do
     Table_Serie.Next;
     if  (CompareValue(Table_Serie.FieldByName('PTermInv').AsFloat,    Term.Pot, 0.005) >= 0) and
         (CompareValue(Table_Serie.FieldByName('PFrigEstTot').AsFloat, Term.PotE, 0.005) >= 0) and
         (CompareValue(Table_Serie.FieldByName('TImmH2OI').AsFloat,    TImmHI, 0.005) >= 0) and
         (CompareValue(Table_Serie.FieldByName('SaltoTI').AsFloat,     StHI,   0.005) >= 0) and
         (CompareValue(Table_Serie.FieldByName('TempAriaI').AsFloat,   TImmAI, 0.005) >= 0) and
         (CompareValue(Table_Serie.FieldByName('TImmH2OE').AsFloat,    TImmHE, 0.005) >= 0) and
         (CompareValue(Table_Serie.FieldByName('SaltoTE').AsFloat,     StHE,   0.005) >= 0) and
         (CompareValue(Table_Serie.FieldByName('TempAriaE').AsFloat,   TImmAE, 0.005) >= 0)
      then Result := True;
  Table_Serie.Close;
  Table_Serie.Free;
  Table_Modello.Close;
  Table_Modello.Free;
 end;
end;

procedure SuggerisciModelloFancoil(var Term: RecGTerm);
var
  TImmHI, TImmHE, TImmAI, TImmAE, StHI, StHE: Double;
  Impianto: String;
  Verificato, trovato: Boolean;
  Table_Serie, Table_Modello: TTable;
  i: Integer;
begin
  Impianto := RestituisciImpianto(Term.numamb);
  TImmHI := RestituisciDatiImpianto(Impianto, 9);
  TImmHE := RestituisciDatiImpianto(Impianto, 7);
  TImmAI := RestituisciDatiImpianto(Impianto, 32);
  TImmAE := RestituisciDatiImpianto(Impianto, 33);
  StHE   := RestituisciDatiImpianto(Impianto, 8);
  StHI   := RestituisciDatiImpianto(Impianto, 10);
  Table_Modello := TTable.Create(nil);
  Table_Modello.databasename := Percorso_Archivi;
  Table_Modello.tablename    := 'TipoTerminali';
  Table_Modello.Filtered := true;
  Table_Modello.Open;
  Table_Modello.first;
  Table_Serie := TTable.Create(nil);
  Table_Serie.Databasename := Percorso_Archivi;
  Table_Serie.Tablename    := 'DettVentilConvettori';
  Table_Serie.Open;
  Table_Serie.first;
  Trovato := False;
  while (not Table_Serie.Eof) and (not Trovato) do
  begin
    if CompareStr(Table_Serie.FieldByName('Codice').AsString, Term.Modello) = 0 then
    begin
      if (CompareValue(Table_Serie.FieldByName('PTermInv').AsFloat,    Term.Pot, 0.005) >= 0) and
         (CompareValue(Table_Serie.FieldByName('PFrigEstTot').AsFloat, Term.PotE, 0.005) >= 0) and
         (CompareValue(Table_Serie.FieldByName('TImmH2OI').AsFloat,    TImmHI, 0.005) >= 0) and
         (CompareValue(Table_Serie.FieldByName('SaltoTI').AsFloat,     StHI,   0.005) >= 0) and
         (CompareValue(Table_Serie.FieldByName('TempAriaI').AsFloat,   TImmAI, 0.005) >= 0) and
         (CompareValue(Table_Serie.FieldByName('TImmH2OE').AsFloat,    TImmHE, 0.005) >= 0) and
         (CompareValue(Table_Serie.FieldByName('SaltoTE').AsFloat,     StHE,   0.005) >= 0) and
         (CompareValue(Table_Serie.FieldByName('TempAriaE').AsFloat,   TImmAE, 0.005) >= 0)
      then Trovato := True
      else Trovato := False;
    end;
    Table_Serie.Next;
  end;
  if Trovato then
  begin
    Term.Serie   := Table_Serie.FieldByName('Descrizione').AsString;
  end;
  Table_Serie.Close;
  Table_Serie.Free;
  Table_Modello.Close;
  Table_Modello.Free;
end;

function RestituisciDatiImpianto(CodImpianto: String; Tag: Integer): Double;
var
  TableImp: TTable;
begin
 if FileExists(Percorso_Progetti + 'Impianti.db') then
 begin
  TableImp := TTable.Create(nil);
  TableImp.DatabaseName := Percorso_Progetti;
  TableImp.Tablename := 'Impianti.db';
  Result := 0.0;
  if TableImp.Exists then
  begin
   TableImp.Open;
   TableImp.First;
   if CodImpianto <> '' then
   begin
     while (not TableImp.Eof) and (CompareStr(UpperCase(TableImp.Fields[0].Text), UpperCase(CodImpianto)) <> 0) do TableImp.Next;
   end;
   Result :=  TableImp.Fields[tag].AsFloat;
  end; {if exists}
  TableImp.Close;
  TableImp.Free;
 end
 else MessageDlg(goMSG('MSG_004032007',MSG_004032007), mtInformation, [mbOk], 0);
end;

function RestituisciImpianto(CodiceAmb: Integer): String;
var
  TableLoc: TTable;
begin
 if FileExists(Percorso_Progetti + 'Locali.db') then
 begin
  TableLoc := TTable.Create(nil);
  TableLoc.DatabaseName := Percorso_Progetti;
  TableLoc.Tablename := 'Locali.db';
  Result := '';
  if TableLoc.Exists then
  begin
   TableLoc.Open;
   TableLoc.First;
   while (not TableLoc.Eof) and (TableLoc.Fields[1].asInteger <> CodiceAmb) do TableLoc.Next;
   Result :=  TableLoc.Fields[7].AsString;
  end; {if exists}
  TableLoc.Close;
  TableLoc.Free;
 end
 else MessageDlg(goMSG('MSG_004032002',MSG_004032002), mtInformation, [mbOk], 0);
end;

function RestituisciZona(CodiceAmb: Integer): String;
var
  TableLoc: TTable;
begin
 if FileExists(Percorso_Progetti + 'Locali.db') then
 begin
  TableLoc := TTable.Create(nil);
  TableLoc.DatabaseName := Percorso_Progetti;
  TableLoc.Tablename := 'Locali.db';
  Result := '';
  if TableLoc.Exists then
  begin
   TableLoc.Open;
   TableLoc.First;
   while (not TableLoc.Eof) and (TableLoc.Fields[1].asInteger <> CodiceAmb) do TableLoc.Next;
   Result :=  TableLoc.Fields[2].AsString;
  end; {if exists}
  TableLoc.Close;
  TableLoc.Free;
 end
 else MessageDlg(goMSG('MSG_004032002',MSG_004032002), mtInformation, [mbOk], 0);
end;

procedure DatiImpiantiZone(CodiceLocale: Integer; var TIH20I, StI, TAmbienteZ: Double);
var
  Impianto, Zona: String;
begin
 if CodiceLocale <> 0 then
 begin
   Impianto := RestituisciImpianto(CodiceLocale);
   Zona     := RestituisciZona(CodiceLocale);
 end
 else
  begin
    Impianto := '';
    Zona := '';
  end;
  TIH20I     := RestituisciDatiImpianto(Impianto, 9);
  STI        := RestituisciDatiImpianto(Impianto, 10);
  TAmbienteZ := RestituisciDatiZona(Zona, 3);
end;

function RestituisciDatiZona(CodZona: String; Tag: Integer): Double;
var
  TableZona: TTable;
begin
 if FileExists(Percorso_Progetti + 'Zone.db') then
 begin
  TableZona := TTable.Create(nil);
  TableZona.DatabaseName := Percorso_Progetti;
  TableZona.Tablename := 'Zone.db';
  Result := 0.0;
  if TableZona.Exists then
  begin
   TableZona.Open;
   TableZona.First;
   if CodZona <> '' then
   begin
     while (not TableZona.Eof) and (CompareStr(UpperCase(TableZona.Fields[0].Text), UpperCase(CodZona)) <> 0) do TableZona.Next;
   end;
   Result :=  TableZona.Fields[tag].AsFloat;
  end; {if exists}
  TableZona.Close;
  TableZona.Free;
 end
 else MessageDlg(goMSG('MSG_004032011',MSG_004032011), mtInformation, [mbOk], 0);
end;


end.



 {
type

  FRONTHT = Record
                NZon    :integer;
                NAmb    :String[10];
                x0      : real;
                y0      : real;
                x1      : real;
                y1      : real;
             end;

 }

 (*
uses definiz,genproc,utilitie,printer,wm;
{ty1}
Const
  MaxNumFr=250;



type

  FRONTHT = Record
                NZon    :integer;
                NAmb    :integer;
                x0      : real;
                y0      : real;
                x1      : real;
                y1      : real;
             end;



    EFr = array[1..MaxNumFr] of FrontHt;


  var
      FtHt                       : FrontHt;
      fFtHt                      : file of Frontht;
      TabFtht                    : ^EFr;
      Inizio,Fine                : Boolean;
      NZona                      : integer;
      stzona                     : string[2];
      numpiano,nambint           : integer;
      trovato                    : boolean;
{ty1}
Procedure Carica(Nome:string;Var NA,NZ:Integer);
function TrovaAmb(Xin,YIn : real):boolean;
function NomeTerm(i,Num_A,NumTer:integer):string;
{ty2}
{ty2}
Function AssegnaCod:String;
Function NumAmbient(Var NZ:integer):real;

{---------------------------------------------------------------------------}
implementation

uses datitubi
{$IFDEF free}
{$else}
,fc_tubi
{$ENdIf} ;
Const
{  MaxNumFr=250; ty1}
  MaxEpiante=50;
  RigheTab=10;



{type
 ty1 in interface
  FRONTHT = Record
                NZon    :integer;
                NAmb    :integer;
                x0      : real;
                y0      : real;
                x1      : real;
                y1      : real;
             end;

}
    {EFr = array[1..MaxNumFr] of FrontHt; ty1 in interface}



{      FtHt                       : FrontHt;
      fFtHt                      : file of Frontht;
      TabFtht                    : ^EFr;
      Inizio,Fine                : Boolean;
      NZona                      : integer;   ty1 in interfase}

{      stzona                     :string[2];
      numpiano,nambint            :integer;
      trovato                    :boolean;  interface}

Procedure Carica(Nome:string;Var NA,NZ:Integer);
var i:integer;


procedure InitFtHt;
var j : integer;
begin
  for j :=1 to MaxNumFr do
   with TabFtHt^[j] do
    begin
       NZon:=0;
       NAmb:=0;
       x0 := 0;
       y0 := 0;
       x1 := 0;
       y1 := 0;
    end;
end;

begin
   If Inizio then
     begin
     Inizio:=false;
     assign(Fftht,Nome);
     reset(Fftht);
     if not eof(Fftht) Then read(Fftht,Ftht);
     end;

   i:=1;

   NZ:=FtHt.NZon;
   nzona:=nz;
   InitFtht;
   Repeat
     NA:=FtHt.NAmb;

     TabFtht^[i]:=FtHt;
{     writeln(lst,' frontiera ',i,' zona ',TabFtht^[i].Nzon,' amb ',TabFtht^[i].Namb,
     ' x0 ',TabFtht^[i].x0:6:1,' y0 ',TabFtht^[i].y0:6:1,
     ' x1 ',TabFtht^[i].x1:6:1,' y1 ',TabFtht^[i].y1:6:1);}
     i:=i+1;
     if i > MaxNumFr then NA:=0;
     If not(eof(Fftht)) then read(Fftht,Ftht);

     if (eof(Fftht)) and (FtHt.NAmb = NA) then TabFtht^[i]:=FtHt;

   Until (eof(Fftht)) or (FtHt.NAmb <> NA);

   if eof(Fftht) Then
     begin
     close(Fftht);
     fine:=true;
     end;

end;

function TrovaAmb(Xin,YIn : real):boolean;
var
  fr,Count,Risultato        : integer;
  Infx,Infy,xx,yy           : real;
  apr                       : real;


{ ---------------------------- main CercaAmb ------------------------------ }
{$I Inters1_inptermm }
begin

{  Writeln(lst,' X1:',XIn:6:1,'  Y1:',Yin:6:1);}
  apr:=0.0001;
  xx := 0;  yy := 0;
  Risultato := 0;

  Infx := 0;
  Infy := 0;
  Fr   := 1;
  Count:= 0;

   while (fr <= MaxNumFr) do
    begin
       if TabFtHt^[fr].NAmb > 0 then
        begin
           inters(xx,yy,Risultato,Infx,Xin, TabFtHt^[fr].x0,TabFtHt^[fr].x1,
                  Infy,Yin, TabFtHt^[fr].y0,TabFtHt^[fr].y1);
           if Risultato = 1 then
            begin
               if ( ((abs(xx - TabFtHt^[fr].x0)) <= 0.01 ) and ((abs(yy - TabFtHt^[fr].y0)) <= 0.01 ) ) or
                  ( ((abs(xx - TabFtHt^[fr].x1)) <= 0.01 ) and ((abs(yy - TabFtHt^[fr].y1)) <= 0.01 ) )then
                begin
                   Infx := Infx + 0.1;
                   count:=0;
                   fr:=0;
                end
               else count:=count+1;
            end;
           fr:=fr+1;
        end
       else fr:=MaxNumFr+1;
    end;
{   writeln(lst,'Contatore intersezioni ',count:4);}
   if ( count mod 2 ) = 0 then TrovaAmb:=false
   else TrovaAmb:=true;
end;

function NomeTerm(i,Num_A,NumTer:integer):string;

var
  st:string;
  NumTerm:string;
begin
   NumTerm:='--------';
   if i<10 Then str(i:1,St)
   else st:=chr(55+i);
   st:=setleft(setright(st));
   insert(st,NumTerm,1);

   str(NZona,St);
   st:=setleft(setright(st));
   insert(st,NumTerm,4-length(st));

   str(Num_A,St);
   st:=setleft(setright(st));
   insert(st,NumTerm,7-length(st));

   str(NumTer,St);
   st:=setleft(setright(st));
   insert(st,NumTerm,9-length(st));
   NomeTerm:=NumTerm;
end;


Function AssegnaCod:String;

var i,j,NumTer,Num_A,Num_Z:integer;
    NOMEPROG10:string;
    st_8:string[10];
Begin
  AssegnaCod:='';

  if upstring(conf^.codterm)='N' then
  begin

 { PulisciTerm(DRIVEPROG+NumeroProg);}

  AssegnaCod:='';

  for j:=1 To UltRiga Do
  if Dis^[j]^.Entita='T' Then   { T }
  if Dis^[j]^.Rid<>'SOTTO' Then
  if (GTerm^[Dis^[j]^.Tronco]^.Cod<>'')and(GTerm^[Dis^[j]^.Tronco]^.Cod[1]<>'#') then
  GTerm^[Dis^[j]^.Tronco]^.Cod:='XXXXXXXX';


{if nomeretemain<>'' then nomeprog10:=nomeretemain else nomeprog10:=nomeprog;
cippo con i nuovi direttori nomepro10=nomecommessa nomecommessa non era presente
quindi in caso dierrore fare replace nomecommessa e nomeprog10   }

  nomeprog10:=nomecommessa;
  if exist(Driveplt+'work.pnt') then
  begin
    New(TabFtHt);
    assign(fept,Driveplt+'work.pnt');
    reset(fept);
    read(fept,Ept^);
    close(Fept);
    i:=1;
    Num_A:=0;
    repeat
      with EpT^[i] do
      begin
        Nomepianta:=NomeP;
        ZMax_P:=Zmax*40000/conf^.AltNum;
        ZMin_P:=Zmin*40000/conf^.AltNum;
      end;

      if Exist(DriveProgCart+NomePianta+'.FHT') then
      begin
        inizio:=True;
        fine:=false;
        repeat
          NumTer:=1;
          Carica(DriveProgCart+NomePianta+'.FHT',Num_A,Num_Z);
          if Num_A<>0 then
          begin
            for j:=1 To UltRiga Do
            if Dis^[j]^.Entita<>'' Then
            if Dis^[j]^.Entita='T' Then   { T }
            if Dis^[j]^.Rid<>'SOTTO' Then
            if Dis^[j]^.Tronco<>0 then
            if GTerm^[Dis^[j]^.Tronco]^.Cod='XXXXXXXX' then
            if (Dis^[j]^.Z1>=ZMin_P)and(Dis^[j]^.Z1<=ZMax_P) Then
            if TrovaAmb(Dis^[j]^.X1/40*conf^.AltNum/100,Dis^[j]^.Y1/40*conf^.AltNum/100)
            Then
            begin
              GTerm^[Dis^[j]^.Tronco]^.Cod:=NomeTerm(i,Num_A,NumTer);
              NumTer:=NumTer+1;
            end;
          end
          else AssegnaCod:='Troppe frontiere su uno stesso ambiente';
        until Fine
      end;
      i:=I+1;
    until (i> MaxEPiante);
    dispose(TabFtHt);
  end;

  end;
end;



Function NumAmbient(Var NZ:integer):real;

  var i,j,Num_A,salvaNum_a,saveN_Z:integer;
      coeff:real;
      piano:integer;
      coordx,coordy:real;
  Begin
  piano:=0;
  num_a:=0;
  salvanum_a:=0;
  saveN_Z:=-1;
  if exist(Driveplt+'work.pnt') then
    begin
    assign(fept,DrivePlt+'work.pnt');
    reset(fept);
    read(fept,Ept^);
    close(Fept);
    i:=1;
    nomepianta:='';
      repeat
      with EpT^[i] do
      if nomeP<>'' then
        begin
        if (RisultCalc^.Quota*CONF^.AltNum/40000>=Zmin)and(RisultCalc^.Quota*CONF^.AltNum/40000<=Zmax) then
          begin
          Nomepianta:=NomeP;
          ZMax_P:=Zmax*40000/CONF^.AltNum;
          ZMin_P:=Zmin*40000/CONF^.AltNum;
          end;
          piano:=i;
        end;
      i:=I+1;
      until (i>MaxEPiante)or(Nomepianta<>'');
    end;

    num_a:=0;
    if piano<>0 then
     begin
      saveN_Z:=0;
      coeff:=40/(CONF^.ALTNUM/100);
      coordx:=xe(x);
      coordY:=ye(Y,Y);
      NumAmbient:=0;
      num_a:=0;
      new(tabftht);
      if Exist(DriveProgCart+NomePianta+'.FHT') then
      begin
       inizio:=True;
       fine:=false;
       repeat
        Carica(DriveProgCart+NomePianta+'.FHT',Num_A,NZ);
        if Num_A<>0 then
         if TrovaAmb(coordx/coeff,coordy/coeff) Then
          begin
           SalvaNum_a:=piano*1000+num_a;
           saveN_Z:=Nz;
          end;
       Until fine;
       dispose(tabftht);
      end
      else SalvaNum_a:=-1;
     end;
   NumAmbient:=SalvaNum_a;
   NZ:=saveN_Z;
   end;
*)
