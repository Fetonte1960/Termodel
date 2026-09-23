
UNIT strutture;

interface

Uses
   {$ifdef dos}
  Crt, {Unit found in TURBO.TPL}
  Dos, {Unit found in TURBO.TPL}
  {$endif}
      {$ifdef win}
  WINPROCS,
  wintypes,
  Owindows,
  bwcc,
  strings,
      {$endif}
  Turbo3, {Unit found in TURBO3.TPU}
  indata,
  definiz,
  defuti,
  inituti,
  utilitie,
  win_uti,
  WM;







var strutcor:integer;
procedure struttur(var uscita:integer);
procedure initarch;
function strf10:boolean;
{ ======================================================================== }


IMPLEMENTATION
var chiave,chiave1,CF,riga1:integer;
 CHX   : char;
     vl: integer;
drive1 : st40;

function calcpeso(nstrut:integer):real;
var k:integer;
    peso:real;
begin
  if Strutture_D^[Nstrut]^.S[1].spessore=0 then calcpeso:=0
  else
    begin
    peso:=0;
    for k:=1 to maxstrati do
    peso:=peso                              +
    Strutture_D^[Nstrut]^.S[k].pesospecifico *
    Strutture_D^[Nstrut]^.S[k].spessore;
    calcpeso:=peso
    end;
end;

procedure SettaDrive1;
begin
  drive1 := drivprg+'\'+Nomecommessa+'\igro\';
end;

procedure CarStruttIgro;
type
StruttPrg1=record
               Descr:string[30];
               KNorm:real;
               KAdot:real;
               NFile:st5;
             end;

   Elenco1 = array[1..MaxNStrutt] of StruttPrg;



var i,j,io  : integer;
    f       : file of elencomuri;
    fel1     :file of elenco1;
    indicegr1:^elenco1;
begin
   settadrive1;
   if exist(drive1+ NumeroProg + '.eln') then
   begin
     assign(f,drive1+ NumeroProg+'.eln');
     {$I-}
     reset(f);
     read(f,Indiceigr^);
     io:=ioresult;
     close(f);
     {$I+}
     if io<>0 then
     begin
       {writemessage('carterm.msg',43);
       halt;}
     end;
     i:=1;  j:=1;
     repeat
       if Indiceigr^[i].NFile > '' then
       begin
         if Strutture_D^[j]=nil then
         begin
           new(Strutture_D^[j]);
           fillchar(Strutture_D^[j]^,sizeof(Strutture_D^[j]^),0);
         end;
         with Strutture_D^[j]^ do
         begin
         if Indiceigr^[i].Descr='' then Descr:=Indiceigr^[i].NFile
         else Descr:=Indiceigr^[i].Descr;
         NFile:=Indiceigr^[i].NFile;
         Trasmitt:=Indiceigr^[i].KAdot;
         end;
         j:=j+1;
       end;
       i:=i+1;
     until (j > MaxStrutture) or ( i > MaxNStrutt);
   end;
end;

{----------------------------- Ripresa Struttura -----------------------------}
function RipresaStruttura(Num:st5):boolean;
type
Contorno1=record
               Ti,Te,URi,URe,wind,PercInc,EsTi,EsTe,EsURI,EsURE,EsG,alfa,beta:real;
               TipoStrut:integer;
            end;


   StruttPrg1=record
               Descr:string[30];
               KNorm:real;
               KAdot:real;
               NFile:st5;
             end;

   Elenco1 = array[1..MaxNStrutt] of StruttPrg;


procedure InitCont;

 begin
    with Cond_Cont^ do
    begin
      Ti:=20;EsTI:=20;Te:=-5;EsTE:=20;URi:=50;EsURI:=80;URe:=90;EsURE:=70;
      wind:=4;PercInc:=0;EsG:=60;alfa:=7.7;beta:=25;epson:=0.837;
      TipoStrut:=2;
    end;
 end;



var g:file of tabmat;
    k:file of Contorno;
    k1:file of Contorno1;
    a:char;
    i,io     :integer;
    linf     :file of infostru;
    fel      : file of elencomuri;
    fel1     :file of elenco1;
    n1,n2:st5;
    cond_cont1:^contorno1;
    indicegr1:^elenco1;

begin
  io:=0;
  settadrive1;
  if Exist(DRIVE1 + Num +'.STR') then
  begin
    assign(g,DRIVE1 + Num +'.STR');
    reset(g);
    read(g,Tabe^);
    close(g);
    assign(fel,drive1+ NumeroProg+'.eln');
    reset(fel);
    io:=ioresult;
    read(fel,Indiceigr^);
    close(fel);

    i:=1;  j:=1;
    repeat
    if Indiceigr^[i].NFile > '' then
    begin
      n1:=formst(Indiceigr^[i].NFile);
      n2:=formst(num);
      if n1=n2 then
      begin
         if Indiceigr^[i].Descr='' then infostr^.descr:=Indiceigr^[i].NFile
         else infostr^.descr:=Indiceigr^[i].descr;
      end;
    end;
    i:=i+1;
    until (j > MaxStrutture) or ( i > MaxNStrutt);
    RipresaStruttura:=true;

    if Exist(DRIVE1 + Num + '.Con') then
    begin
      assign(k,DRIVE1 + Num + '.Con');
      reset(k);
      io:=ioresult;
      read(k,Cond_Cont^);
      close(k);

    end

    else
    begin
      {
      writemessage('carterm.msg',18);
      ripresastruttura:=false;
      }
      initcont;
    end;
  end
  else
  if Exist(DRIVEarci + Num +'.STR') then
  begin
    assign(g,DRIVEarci + Num +'.STR');
    reset(g);
    read(g,Tabe^);
    close(g);
    RipresaStruttura:=true;
    if Exist(DRIVEarci + Num + '.inf') then
    begin
      assign(linf,DRIVEarci + Num + '.inf');
      reset(linf);
      read(linf,infostr^);
      close(linf);
    end;
    if Exist(DRIVEarci + Num + '.con') then
    BEGIN
      assign(k,DRIVEARCI + Num + '.Con');
      reset(k);
      io:=ioresult;
      read(k,Cond_Cont^);
      close(k);
    end
    else
    begin
      {
      writemessage('carterm.msg',18);
      ripresastruttura:=false;
      }
      initcont;
    end;
  end
  else
  BEGIN
    RipresaStruttura:=false;
    writemessage1('carterm.msg',17,'Struttura: '+num);
  end;
END;

function TrovaStr(NFile:string;var Tras:real):boolean;
var
  i:integer;
  trovato:boolean;
  f:file of elencomuri;
begin
   TrovaStr:=false;
   if Nfile='' then exit;
   assign(f,drive1+ NumeroProg + '.eln');
   reset(f);
   read(f,Indiceigr^);
   close(f);
   trovato:=false;
   i:=1;
   repeat
       Trovato:=(NFile=Indiceigr^[i].NFile);
       if not Trovato then i:=i+1;
   until Trovato or (i > MaxNStrutt);
   if Trovato then
    begin
      Tras:=Indiceigr^[i].KAdot;
      TrovaStr:=true;
    end;
end;


procedure ms;far;
begin

end;




{-----------------------------  CALC_F_TRASF  --------------------------------}
PROCEDURE CALC_F_TRASF(NStrutt,key:INTEGER);
{Calcolo coefficente funzione di trasferimento}
CONST
  IntNk:ARRAY[0..6] OF REAL=(3.5,7,11.5,16,20.5,25,25);
VAR
  I,J:integer;
  RJ:ARRAY[-1..MaxStrati] OF REAL;
  Nrj:INTEGER;     { Numero di strati relativi a RJ[n] :
                     per n=0 addutt. esterna ; per n=Nrj addutt. interna      }
  RT:REAL;         { Resistenza termica totale }
  TR:REAL;         { Trasmittanza              }
  RN,R01,R02:REAL;
  Z1,Z2:REAL;
  Cj,Ri,Ta0:REAL;
BEGIN
  WITH STRUTTURE_D^[NStrutt]^ DO
  BEGIN
    IF NStrati=0 THEN EXIT;
    { Calcolo di RJ per ogni componente della struttura }
    IF HE<>0 THEN RJ[0]:=1/HE ELSE RJ[0]:=0;

    MFstrutt:=0;
    FOR I:=1 TO NStrati DO
    BEGIN
      MFstrutt:=MFstrutt+S[I].PesoSpecifico*S[I].Spessore;
      IF S[I].Conduttanza<>0 THEN RJ[I]:=1/S[I].Conduttanza
      ELSE
        IF S[I].ConduttivitaLineare<>0 THEN
          RJ[I]:=S[I].Spessore/S[I].ConduttivitaLineare ELSE RJ[I]:=0;
    END;


    IF HI<>0 THEN RJ[NStrati+1]:=1/HI ELSE RJ[NStrati+1]:=0;
    Nrj:=NStrati+1;

    Rt:=0;
    FOR J:=0 TO Nrj DO Rt:=Rt+RJ[J];   { Calcolo resistenza totale }

    IF Rt<>0 THEN Tr:=1/Rt ELSE Tr:=0; { Calcolo trasmittanza      }

    (*if Nfile ='' then*)

    Trasmitt:=Tr;

    if Exist (drive1+ NumeroProg + '.eln') then
     if TrovaStr(NFile,Tr) then Trasmitt:=Tr;

    Z1:=0;     Z2:=0;
    FOR J:=0 TO Nrj DO
    BEGIN
      RN:=0;
      IF J > 0 THEN FOR I:=0 TO J-1 DO RN:=RN+RJ[I];

      R01:=RN/(RN+RJ[J]);
      R02:=RJ[J]/(RN+RJ[J]);

      Cj:=1;
      IF J>0 THEN CJ:=S[J].CaloreSpecifico*S[J].PesoSpecifico*S[J].Spessore;
      Z1:=Cj*R02*(1/6+1/3*R01)+R01*(Z1+R02*Z2);
      Z2:=Cj/3*(1+R01+sqr(R01))+Z2*sqr(R01);
    END;
    IF HI<>0 THEN Ri:=1/HI ELSE Ri:=0;

    Ta0:=(Z2*Ri*(Rt-Ri)/Rt) + Z1*(Rt-Ri);

    {if Ta0 < 28 then Ta0:=Ta0*0.09
    else Ta0:=Ta0*(ta0*0.004872-0.08);}

    I:=0;
    WHILE (IntNk[I]<Ta0) AND (I<6) DO I:=I+1;

    NK:=I;
    B0:=(Tr/Hi)*(1-(1-exp(-1/Ta0))*Ta0);
    B1:=(Tr/Hi)*(-exp(-1/Ta0)+(1-exp(-1/Ta0))*Ta0);
    Sc:=(1-(Tr/Hi))*(1-exp(-1/Ta0));
    D1:=exp(-1/Ta0);

  END;  { WITH STRUTTURE_D^{NStrutt]..... DO..........}
END;    { PROC. CALC_F_TRASF }



function ultstrut:integer;
var c,i:integer;
begin
  i:=1;
  while strutture_D^[i]<>nil do inc(i);
  ultstrut:=i-1;
end;

function UltimoStratoInTabe : integer;
var  us : integer;
begin
   us := maxstrati-1;
   while (SetLeft(Tabe^[us].Cod) ='') and (us > 1) do us := us-1;
   UltimoStratoInTabe := us;
end;
procedure AggiornaStrut;
var i,j:integer;
 begin

    for i:=1 to MaxStrutture do
    with FinB^[i] do
    begin
      if (descrs>'')or(CodIgro>'')  then
      begin
        if Strutture_D^[i]=nil then
        begin
          new(Strutture_D^[i]);
          fillchar(Strutture_D^[i]^,sizeof(Strutture_D^[i]^),0);
        end;
        Strutture_D^[i]^.descr:=DescrS;
        Strutture_D^[i]^.HI:=Addut_int;
        Strutture_D^[i]^.HE:=Addut_est;

        if DescrS >'' then
        begin
          muri_d^[i].denom:=DescrS;
          muri_D^[i].codarch:=i;
        end
        else
        begin
          muri_d^[i].denom:=CodIgro;
          muri_D^[i].codarch:=i;
        end;
        muri_D^[i].colore:=col;
        muri_d^[i].incrsic:=incrsic;
        Strutture_D^[i]^.NFile:=CodIgro;
        Strutture_D^[i]^.trasmitt:=trasm;
      end
      else
      if Strutture_D^[i]<>nil then
      begin
        dispose(Strutture_D^[i]);
        Strutture_D^[i]:=nil;
      end;
    end;
    for i:=1 to MaxStrutture do
    for j:=1 to MaxStrati do
    if Strutture_D^[i]<>nil then
    with FinA^[i]^[j] do
    begin
      Strutture_D^[i]^.S[j].Cod:=Cod;
      Strutture_D^[i]^.S[j].Descr:=Descr;
      Strutture_D^[i]^.S[j].Spessore:=Spessore;
      Strutture_D^[i]^.S[j].ConduttivitaLineare:=ConduttivitaLineare;
      Strutture_D^[i]^.S[j].Conduttanza:=Conduttanza;
      Strutture_D^[i]^.S[j].CaloreSpecifico:=CaloreSpecifico;
      Strutture_D^[i]^.S[j].PesoSpecifico:=PesoSpecifico;
    end;
 end;


procedure CaricaStrut;
var i,j:integer;
 begin
    for i:=1 to MaxStrutture do
    with FinB^[i] do
    begin
      if Strutture_D^[i]<>nil then
       begin
         DescrS      := Strutture_D^[i]^.descr;
         Addut_int   := Strutture_D^[i]^.HI;
         Addut_est   := Strutture_D^[i]^.HE;
         col         := muri_D^[i].colore;
         incrsic     := muri_d^[i].incrsic;
         CodIgro     := Strutture_D^[i]^.NFile;
         peso        := calcpeso(i);
         trasm       := Strutture_D^[i]^.trasmitt;
       end
       else fillchar(finb^[i],sizeof(finb^[i]),0);
    end;

    for i:=1 to MaxStrutture do
    for j:=1 to MaxStrati do
    begin
      if Strutture_D^[i]<>nil then
      begin
        if (Strutture_D^[i]^.descr>'')or(Strutture_D^[i]^.NFile >'') then
        begin
          if (FinA^[i]=nil) then new(FinA^[i]);
          with FinA^[i]^[j] do
          begin
            Cod            := Strutture_D^[i]^.S[j].Cod;
            descr          := Strutture_D^[i]^.S[j].Descr;
            Spessore       := Strutture_D^[i]^.S[j].Spessore;
            ConduttivitaLineare := Strutture_D^[i]^.S[j].ConduttivitaLineare;
            Conduttanza    := Strutture_D^[i]^.S[j].Conduttanza;
            CaloreSpecifico:= Strutture_D^[i]^.S[j].CaloreSpecifico;
            PesoSpecifico  := Strutture_D^[i]^.S[j].PesoSpecifico;
          end;
        end
        else
        if FinA^[i]<> nil then fillchar(fina^[i]^,sizeof(fina^[i]^),0);
      end;
    end;
 end;

{------------------------- Cancellazione  ------------------------------}
procedure Cancella;far;
var c,i,j,riga:integer;
begin
 c:=ultstrut;
 {$ifdef dos}
 riga:=riga1;
 {$endif}
 {$ifdef win}
 riga:=tabellacorrente^[a_w].dialog^.numerolineatabella;
 setdata:=true;
 {$endif}
 if riga<=c then
 begin
  for i:=Riga to c-1 do
    with Strutture_D^[i]^ do
     begin
        Descr:=Strutture_D^[i+1]^.Descr;
        HI:=Strutture_D^[i+1]^.HI;
        HE:=Strutture_D^[i+1]^.HE;
        NFile:=Strutture_D^[i+1]^.NFile;
        NStrati:=Strutture_D^[i+1]^.NStrati;
        NK:=Strutture_D^[i+1]^.NK;
        B0:=Strutture_D^[i+1]^.B0;
        B1:=Strutture_D^[i+1]^.B1;
        SC:=Strutture_D^[i+1]^.SC;
        D1:=Strutture_D^[i+1]^.D1;
        Trasmitt:=Strutture_D^[i+1]^.Trasmitt;
        MFstrutt:=Strutture_D^[i+1]^.MFstrutt;
        S:=Strutture_D^[i+1]^.S;
     end;
     dispose(Strutture_D^[c]);
     Strutture_D^[c]:=nil;
     (*
   with Strutture_D^[c]^ do
    begin
       descr:='';
       HI:=0;
       HE:=0;
       NFile:='';
        for j:=1 to MaxStrati do
         begin
            S[j].Cod:='';
            S[j].Descr:='';
            S[j].Spessore:=0;
            S[j].ConduttivitaLineare:=0;
            S[j].Conduttanza:=0;
            S[j].CaloreSpecifico:=0;
            S[j].PesoSpecifico:=0;
         end;
    end;*)
  CaricaStrut;

  end;
  canc_data:=false;
end;

{---------------------------- Inserimento  -----------------------------}
procedure Inserisci;far;
var c,i,j,riga:integer;
begin
  c:=ultstrut;
  new(Strutture_D^[c+1]);
 {$ifdef dos}
 riga:=riga1;
 {$endif}
 {$ifdef win}
  riga:=tabellacorrente^[a_w].dialog^.numerolineatabella;
  setdata:=true;
 {$endif}
 if c>=riga then
 begin
 for i:=c+1 downto Riga+1 do
 if Strutture_D^[i]<>nil then
  with Strutture_D^[i]^ do
   begin
      Descr := Strutture_D^[i-1]^.Descr;
      HI    := Strutture_D^[i-1]^.HI;
      HE    := Strutture_D^[i-1]^.HE;
      NFile := Strutture_D^[i-1]^.NFile;
      NStrati := Strutture_D^[i-1]^.NStrati;
      NK      := Strutture_D^[i-1]^.NK;
      B0      := Strutture_D^[i-1]^.B0;
      B1      := Strutture_D^[i-1]^.B1;
      SC      := Strutture_D^[i-1]^.SC;
      D1      := Strutture_D^[i-1]^.D1;
      Trasmitt := Strutture_D^[i-1]^.Trasmitt;
      MFstrutt := Strutture_D^[i-1]^.MFstrutt;
      S        := Strutture_D^[i-1]^.S;
    end;
    fillchar(Strutture_D^[Riga]^,sizeof(Strutture_D^[Riga]^),0);

    CaricaStrut;

  end;
  ins_data:=false;
end;




procedure InitStruttCalc(NStrutt:integer);
var j:integer;
 begin
    with FinB^[NStrutt] do
     begin
        Strutture_D^[NStrutt]^.descr:=DescrS;
        Strutture_D^[NStrutt]^.HI:=Addut_int;
        Strutture_D^[NStrutt]^.HE:=Addut_est;

        if (DescrS >'') or (CodIgro>'') then
          begin
          muri_d^[nstrutt].denom:='ST';
          muri_D^[nstrutt].codarch:=nstrutt;
          end
        else
          begin
          muri_d^[nstrutt].denom:='';
          muri_D^[nstrutt].codarch:=0;
          end;
        muri_D^[nstrutt].codarch:=nstrutt;
        muri_D^[nstrutt].colore:=col;
        muri_d^[nstrutt].incrsic:=incrsic;
        Strutture_D^[NStrutt]^.NFile:=CodIgro;
     end;

    for j:=1 to MaxStrati do
    with FinA^[NStrutt]^[j] do
      begin
         Strutture_D^[NStrutt]^.S[j].Cod:=Cod;
         Strutture_D^[NStrutt]^.S[j].Descr:=Descr;
         Strutture_D^[NStrutt]^.S[j].Spessore:=Spessore;
         Strutture_D^[NStrutt]^.S[j].ConduttivitaLineare:=ConduttivitaLineare;
         Strutture_D^[NStrutt]^.S[j].Conduttanza:=Conduttanza;
         Strutture_D^[NStrutt]^.S[j].CaloreSpecifico:=CaloreSpecifico;
         Strutture_D^[NStrutt]^.S[j].PesoSpecifico:=PesoSpecifico;
      end;
  end;



{------------------------- Richiamo o Inizializzazione Archivio --------------}
procedure InitArch;
var i:integer;
    figr:file of Arch;

begin
   if Exist(DRIVEARCI + 'Archivio.gen') then
    begin
       assign(figr,DRIVEARCI + 'Archivio.gen');
       reset(figr);
       read(figr,Arcigro^);
       close(figr);
    end
   else
    begin
       for i:=1 to NMater do
       with arcigro^[i] do
       begin
          cod:='';nome:='';
          lamda:=0;Cond:=0;
          Mu:=0; Densita:=0; Ct:=0;
       end;
    end;
end;


{--------------------------- Ricerca Codice in Archivio ----------------------}
procedure RicercaArc(RigaStrato,nstrutt:integer;var trovato:boolean);

var i,l,l1,l2:integer;
    f:file of Arch;

begin
   Trovato:=false;

   FinA^[NStrutt]^[RigaStrato].cod:=UpString(FinA^[NStrutt]^[RigaStrato].cod);
   i:=1;
   repeat

      arcigro^[i].cod:=UpString(arcigro^[i].cod);

      if FinA^[NStrutt]^[RigaStrato].cod=arcigro^[i].cod then
       begin
          FinA^[NStrutt]^[RigaStrato].descr:=arcigro^[i].nome;
          FinA^[NStrutt]^[RigaStrato].ConduttivitaLineare:=arcigro^[i].lamda;
          FinA^[NStrutt]^[RigaStrato].conduttanza:=arcigro^[i].Cond;
          FinA^[NStrutt]^[RigaStrato].CaloreSpecifico:=arcigro^[i].ct;
          FinA^[NStrutt]^[RigaStrato].PesoSpecifico:=arcigro^[i].densita;
          Trovato:=true;
       end
      else i:=i+1;
   until Trovato or (i > NMater);
 end;

procedure insf2;far;
var nstrutt,i:integer;
    nks,
    b0s,
    b1s,
    scs,
    d1s,
    nsts,
    trs:string[10];
    rigaL:string[100];
    pcl:array[0..100] of char;
begin
  {$ifdef dos}
   nstrutt:=riga1;
  {$endif}
  {$ifdef win}
   nstrutt:=strutcor;
  {$endif}
  I:=1;
  while (SetLeft(FinA^[NStrutt]^[I].Descr) > '') and (I <= MaxStrati-1) do i:=i+1;
  if not (SetLeft(FinA^[NStrutt]^[MaxStrati].Descr) > '') then i:=i-1;
  if i>0 then
  begin
     if Strutture_D^[NStrutt]=nil then
      begin
         new(Strutture_D^[NStrutt]);
         fillchar(Strutture_D^[NStrutt]^,sizeof(Strutture_D^[NStrutt]^),0);
      end;
    STRUTTURE_D^[NStrutt]^.NStrati:=I;
    InitStruttCalc(NStrutt);
    with Strutture_D^[NStrutt]^ do
    if (HI <> 0) and (HE <> 0) then CALC_F_TRASF(NStrutt,chiave);
     {$ifdef dos}
      GOTOXY(1,21);    ClrEol;
      GOTOXY(1,21);
      WITH STRUTTURE_D^[nstrutt]^ DO
      WRITE(W_M(18),NStrati,'  NK=',NK,'  B0=',B0:6:3,'  B1=',B1:6:3,
      '  SC',SC:6:3,'  D1=',D1:6:3,'  ',W_M(19),Trasmitt:4:3);
      readkbd(ch);
      if keypressed then readkbd(ch);
      GOTOXY(1,1); clreol;
      GOTOXY(1,21);ClrEol;
     {$endif}
     {$ifdef win}
     with Strutture_D^[NStrutt]^ do
     begin
      str(nstrati,nsts);
      str(nk,nks);
      str(b0:6:3,b0s);
      str(b1:6:3,b1s);
      str(sc:6:3,scs);
      str(d1:6:3,d1s);
      str(trasmitt:4:3,trs);
      rigal:=W_M(18)+NSts+'  NK='+NKs+'  B0='+B0s+'  B1='+B1s+'  SC'+SCs+'  D1='+D1s+
      +'  '+W_M(19)+Trs;
     end;
      messagebox(0,strpcopy(pcl,rigal),'Mc4 Software',mb_ok or MB_ICONEXCLAMATION);
     {$endif}
  end;
end;
 {$ifdef win}
procedure stratocancl;far;
begin
end;


procedure insf3;far;
var hd:hwnd;
    msg:tmessage;
    i,nstrutt:integer;
begin
    tabellacorrente^[a_w].dialog^.enddlg(id_ok);

end;
{$endif}



{---------------------------- Inserimento Strati -----------------------------}
procedure InsStrati(NStrutt:integer;var Chiave:integer);
var
  rigas,campos     : integer;
  InitMask1,initmenu1 : boolean;
  {$ifdef win}
   hd:hwnd;
   {$endif}

function Errore:boolean;
var i:integer;
    Err:boolean;

begin

     Err:=false;
     i:=1;

     repeat

        with FinA^[NStrutt]^[i] do
          Err:=((Cod > '') and (Spessore = 0));
        if not Err then i:=i+1;

     until Err or (I > MaxStrati - 1);

     if Err then  {$ifdef dos} write(chr(7)){$endif}
      {$ifdef win}
       messagebeep(10);
      {$endif};
     Errore:=Err;
end;

 begin

    if finA^[nstrutt]=nil then
    begin
      new(finA^[nstrutt]);
      fillchar(finA^[nstrutt]^,sizeof(finA^[nstrutt]^),0);
    end;
    ar_ins^[1].ncampo:=1;
    ar_ins^[1].nfile:=drivearcI+'strutmas.l1';

     initproc;
     procarr[2]:=insf2;
     procarr[3]:=insf3;
     procarr[11]:=stratocancl;
     procarr[12]:=generica;
     st_8:='struttur';
     a_w:=numerotabella(st_8,hd,2);
     w_IOTabella(FinA^[NStrutt]^,MaxStrati-1,MaxStrati-1,7,
                  'STRATO.MSK',false,PROCARR,true,code,fill_listagen,tabellacorrente^[a_w].self);
     if code=id_ok then
     begin
       nstrutt:=strutcor;
       AggiornaStrut;
       I:=1;
       while (SetLeft(FinA^[NStrutt]^[I].Descr) > '') and (I <= MaxStrati-1) do i:=i+1;
       if not (SetLeft(FinA^[NStrutt]^[MaxStrati].Descr) > '') then i:=i-1;
       if i>0 then
       begin
         STRUTTURE_D^[NStrutt]^.NStrati:=I;
         InitStruttCalc(NStrutt);
         with Strutture_D^[NStrutt]^ do
         if (HI <> 0) and (HE <> 0) then CALC_F_TRASF(NStrutt,chiave);
         FinB^[NStrutt].peso:=calcpeso(NStrutt);
         FinB^[NStrutt].trasm:=Strutture_D^[NStrutt]^.trasmitt;
       end;
       caricastrut;
       st_8:='struttur';
       a_w:=numerotabella(st_8,hd,2);
       with tabellacorrente^[a_w] do
       begin
         setactivewindow(maniglia);
         dialog^.transferdata(tf_setdata);
         setdata:=false;
       end;
     end;

end;
procedure salvamuri;far;
begin
  AggiornaStrut;
  TRANSFER_STRUTTURE(DriveProg+NumeroProg+'.STR','S');
  TRANSFER_MURI(DriveProg+NumeroProg+'.MUR','S');
  generains(2,'muri.msk',DriveProg+NumeroProg+'.mur', MaxStrutture,10,4,0,1,4,30);
end;


function strf10:boolean;
var i,j,NStrutt,Campo,Riga, totstr:integer;
    PrCampo,UltCampo                               :integer;
    FEND,InitMask,IwVal,InitMenu,existmat          :boolean;
    f                                              :file of Arch;

begin
  {if conferma('carterm.msg','',22) then}
  begin
    fillchar(muri_d^,sizeof(muri_d^),0);
    init_muri;
    fillchar(fina^,sizeof(fina^),0);
    fillchar(finb^,sizeof(finb^),0);
    for i:=1 to MaxStrutture do
    if Strutture_d^[i]<>nil then
    begin
      dispose(Strutture_d^[i]);
      Strutture_d^[i]:=nil;
    end;
    initarch;
    new(infostr);
    fillchar(infostr^,sizeof(infostr^),0);
    CarStruttIgro;
    totstr:=0;
    FOR nstrutt :=1 to MaxStrutture do
    if Strutture_d^[nstrutt]<>nil then
    if formst(Strutture_d^[nstrutt]^.nfile)>'' then
    if RipresaStruttura(formst(Strutture_d^[nstrutt]^.nfile)) then
    begin
      inc(totstr);
      FinB^[nstrutt].codigro:=setleft(setright(Strutture_d^[nstrutt]^.nfile));
      FinB^[nstrutt].DescrS:=infostr^.DESCR;
      FinB^[nstrutt].Addut_Int:=Cond_Cont^.Alfa;
      FinB^[nstrutt].Addut_Est:=Cond_Cont^.Beta;
      FinB^[nstrutt].col:=indiceigr^[nstrutt].colore;
      FinB^[nstrutt].incrsic:=1{+cond_cont^.percinc/100};
      Strutture_D^[nstrutt]^.HI:=Cond_Cont^.Alfa;
      Strutture_D^[nstrutt]^.HE:=Cond_Cont^.Beta;

      k10^[nstrutt].ka:=indiceigr^[nstrutt].kadot_10;
      k10^[nstrutt].kn:=indiceigr^[nstrutt].knorm_10;
      k10^[nstrutt].hi:=Cond_Cont^.Alfa_10;
      k10^[nstrutt].he:=Cond_Cont^.bETA_10;

      FinB^[nstrutt].trasm:=Strutture_D^[nstrutt]^.trasmitt;
      I := UltimostratoinTabe;
      vl :=i;
      j:=0;
      if  FinA^[NStrutt]=nil then
      begin
        new(FinA^[NStrutt]);
        fillchar(FinA^[NStrutt]^,sizeof(FinA^[NStrutt]^),0);
      end;
      REPEAT
        j :=j+1;
        FinA^[NStrutt]^[j].Cod:=Tabe^[I].Cod;
        FinA^[NStrutt]^[j].Spessore:=Tabe^[I].s;
        existmat:=false;
        RicercaArc(j,nstrutt,existmat);
        if not existmat then
        begin
          strf10:=false;
          writemessage2('carterm.msg',' '+Strutture_d^[nstrutt]^.nfile+' " '+FinA^[NStrutt]^[j].Cod+' " ',50,51);
          exit;
        end;
        I:=I-1;
      UNTIL (I=0)or (j = vl);
    end
    else
    begin
      strf10:=false;
      writemessage('carterm.msg',18);
      exit;
    end;
    {Halt;}
    AggiornaStrut;
    for nstrutt:=1 to totstr do
    begin
      I:=1;
      while (SetLeft(FinA^[NStrutt]^[I].Descr) > '') and (I <= MaxStrati-1) do i:=i+1;
      if not (SetLeft(FinA^[NStrutt]^[MaxStrati].Descr) > '') then i:=i-1;
      if i>0 then
      begin
         STRUTTURE_D^[NStrutt]^.NStrati:=I;
         InitStruttCalc(NStrutt);
         with Strutture_D^[NStrutt]^ do
         if (HI <> 0) and (HE <> 0) then CALC_F_TRASF(NStrutt,chiave);
         FinB^[NStrutt].peso:=calcpeso(NStrutt);
         FinB^[NStrutt].trasm:=Strutture_D^[NStrutt]^.trasmitt;
      end;
    end;
    caricastrut;
    dispose(infostr);

  end;
  setdata:=true;
  salvamuri;
end;

procedure strf3;far;
var i,j,NStrutt,Campo:integer;
    FEND,InitMask,IwVal,InitMenu,existmat          :boolean;
    f                                              :file of Arch;
    Tab1                                           :^TabellaRec;
    Map1                                           :^TabellaMap;
    PrCampo,UltCampo                               :integer;

begin
  new(infostr);
   {$ifdef dos}
  new(tab1);
  new(map1);
  ClrScr;
  NStrutt:=Riga1;
  Tab1^:=Tabella^;
  Map1^:=Mappa^;
  PrCampo:=PrimoCampo;  UltCampo:=UltimoCampo;
  {$endif}
  {$ifdef win}
  nstrutt:=tabellacorrente^[a_w].dialog^.numerolineatabella;
  strutcor:=nstrutt;
  setdata:=false;
  {$endif}

  if FinB^[nstrutt].CodIgro > '' then
  begin
    FinB^[nstrutt].CodIgro:=SETLEFT(SETRIGHT((FinB^[nstrutt].CodIgro)));
    if RipresaStruttura(FinB^[nstrutt].CodIgro) then
    begin
      if FinB^[nstrutt].DescrS='' then FinB^[nstrutt].DescrS:=infostr^.DESCR;

      FinB^[nstrutt].Addut_Int:=Cond_Cont^.Alfa;
      FinB^[nstrutt].Addut_Est:=Cond_Cont^.Beta;
      IF Strutture_D^[nstrutt]=NIL THEN
      begin
        new(Strutture_D^[nstrutt]);
        fillchar(Strutture_D^[nstrutt]^,sizeof(Strutture_D^[nstrutt]^),0);
      end;
      Strutture_D^[nstrutt]^.HI:=Cond_Cont^.Alfa;
      Strutture_D^[nstrutt]^.HE:=Cond_Cont^.Beta;
      FinB^[nstrutt].peso:=calcpeso(nstrutt);
      FinB^[nstrutt].trasm:=Strutture_D^[nstrutt]^.trasmitt;
      I := UltimostratoinTabe;
      vl :=i;
      j:=0;
      if (chiave<>63) and (chiave<>64) then
      begin
        if  FinA^[NStrutt]=nil then
        begin
          new(FinA^[NStrutt]);
          fillchar(FinA^[NStrutt]^,sizeof(FinA^[NStrutt]^),0);
        end;
        REPEAT
          j :=j+1;
          FinA^[NStrutt]^[j].Cod:=Tabe^[I].Cod;
          FinA^[NStrutt]^[j].Spessore:=Tabe^[I].s;
          RicercaArc(j,nstrutt,existmat);
          I:=I-1;
        UNTIL (I=0)or (j = vl);
      end;
    end;
  end;
  dispose(infostr);
  InsStrati(NStrutt,Chiave);
  {$ifdef dos}
  AggiornaStrut;
  if Chiave in [27,61] then {59}
  begin
    I:=1;
    while (SetLeft(FinA^[NStrutt]^[i].Descr) > '') and (I <= MaxStrati-1) do i:=i+1;
    if not (SetLeft(FinA^[NStrutt]^[MaxStrati].Descr) > '') then i:=i-1;
    if i>0 then
    begin
      STRUTTURE_D^[NStrutt]^.NStrati:=I;
      InitStruttCalc(NStrutt);
      with Strutture_D^[NStrutt]^ do
      if (HI <> 0) and (HE <> 0) then CALC_F_TRASF(NStrutt,chiave);
    end;
  end;
  FinB^[NStrutt].peso:=calcpeso(NStrutt);
  FinB^[NStrutt].trasm:=Strutture_D^[NStrutt]^.trasmitt;
  if (chiave=61){ or (chiave1=12)} then
  begin
    clrscr;
    Tabella^:=Tab1^;
    Mappa^:=Map1^;
    PrimoCampo:=PrCampo;  UltimoCampo:=Ultcampo;
    StampaMappa(col[2]);
  end;
  UltimoAccesso := 78;
  dispose(tab1);
  DISPOSE(MAP1)
 {$endif}

end;


Procedure canclst;far;
begin
  {$ifdef win}

  {$endif}
end;
procedure initpun;
begin


end;

{------------------------------ STRUTTURE -----------------------------------}

PROCEDURE STRUTTUR(var uscita:integer);

var i,j,NStrutt,Campo,Riga:integer;

    FEND,InitMask,IwVal,InitMenu                   :boolean;
    f                                              :file of Arch;
    {Tab1                                           :^TabellaRec;
    Map1                                           :^TabellaMap;}
    PrCampo,UltCampo                               :integer;
    {$ifdef win}
    hd:hwnd;
    {$endif}

BEGIN
  ar_ins^[6].ncampo:=6;
  ar_ins^[6].nfile:=drivearcI+'arcstru.ins';
  initpun;
  SettaDrive1;
  InitArch;
  caricastrut;
  initproc;
  {procarr[10]:=strf10;}
  procarr[3]:=strf3;
  procarr[5]:=cancella;
  procarr[6]:=inserisci;
  procarr[11]:=canclst;
  procarr[12]:=salvamuri;
  W_IOTabella(FinB^,MaxStrutture,10,8,
                 'STRUTTUR.MSK',true,PROCARR,true,code,fill_listagen,nil);
  initins;
END;   { PROC. strutture }

END.