{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$M 65000,16384,655360} {Turbo 3 default stack and heap}
{F+}
{$O+}

Unit Init_Cart;

Interface

Uses
  Crt, {Unit found in TURBO.TPL}
  Dos, {Unit found in TURBO.TPL}
  Turbo3, {Unit found in TURBO3.TPU}
  key,
  WM,
  defuti,
  utilitie,
  definiz,
  {$ifdef dos}
  DEMO,
  {$endif}
  indata,datigen,texter;


Procedure  InitCart;
function ExistCalc:boolean;

Procedure Scrivi_Ferrori(numeroControllo:integer);
Procedure Visualizza_Ferrori;

Implementation
{----------------------------------------------------------------------------}
Procedure Scrivi_Ferrori(numeroControllo:integer);
var i:integer;
     fp:file of epiantear;
begin
 errore:=false;

 assign(fp,DRIVEplt+ NumeroProg+'.PNT');
 Reset(Fp);
 Read(Fp,EPt^);
 close(fp);

 { TestAT = 195 ==> Legge 10 }
 if TestAT = 195 then
  begin
   new(tubaz_d);
   new(elenTub);
   new(arcttubi);

   TRANSFER_TUBAZ(DRIVEarc+'Archivio.TBZ','L');
   Transfer_ElencoTub;
   LoadTT;
  end;

 i:=1;
 assign(ferrori,'Errori.hlp');
 rewrite(ferrori);
 writeln(ferrori,'þ                     VISUALIZZAZIONE ERRORI DI INPUT                          þ');{*TR*}

 errordati(0);
 repeat

   EPt^[i].NomeP := FORMST(EPt^[i].NomeP);

   if (EPt^[i].NomeP > '') then
    begin
       NDisegno:=EPt^[i].NomeP;
       disk_P('L');
       writeln(ferrori,'5Errori di input riscontrati al piano: 2 ',upstring(ndisegno),'');{*TR*}
       errordati(numeroControllo);
    end else i:=maxepiante;
    i:=i+1;
 until (i > MaxEPiante);

 close(ferrori);
end;

Procedure Visualizza_Ferrori;
begin
 {$ifdef dos}
 gotoxy(2,21);
 write(chr(7));
 TEXTCOLOR(14);
 TEXTBACKGROUND(4);

 write('Si sono verificati errori di input! per visalizzarli <CTRL+F3> ');{*TR*}
 repeat until keypressed;

 scelta:=11;
 textbackground(col[1]);

 {$endif}
 {$ifdef win}

 writemessage('carterm.msg',20);
 {$endif}
end;

 {$I f:\sorgenti\hvac\costant}

{*************************** EXISTCALC ************************************}
function ExistCalc:boolean;
var ft:text;
    buf:st80;
begin
if exist('calcok.tst') then
  begin
  Assign(ft,'calcok.tst');
  reset(ft);
  readln(ft,buf);

  if buf<>NumeroProg then
    begin
    ExistCalc:=false;
    WriteMessage('Carterm.msg',9)
    end
  else ExistCalc:=true;
  close(ft);
  end
else
begin
  ExistCalc:=false;
  WriteMessage('Carterm.msg',9)
end

end;


Procedure  InitCart;

{*************************** LOAD_ITA *************************************}
PROCEDURE LOAD_ITA;
var ja: integer;
BEGIN


   for ja := 1 to 12 do MESE^[ja] := MESE_ITA[ja];
END;



begin

  new(faccia);
  new(fin10);
  new(vet);
  new(prog);
  new(RisultZon);
  new(DescGen);
  new(SupPt);
  new(arcttubi);
  new(elentub);
  new(relazione_d);
  new(relGen);
  new(ArkGenerat);
  new(cd);


  { spostare queste new in una chiamata solo per l10 }


  FILETRADUZ:='CARTERM';
  ctrlkey:=1;
  {ControlloChiave(ctrlkey,5,versione);}

  erroraddr:=nil;

  ASSIGN(filet,'drive1.int');
  RESET(filet);
  readln(filet,drive);
  close(filet);

  chdir(drive+'\carterm');

  ASSIGN(filet,drive+'\DriveArc.int');
  RESET(filet);
  readln(filet,DRIVEARC);
  close(filet);
  drivearc:=drivearc+'\';

  ASSIGN(filet,drive+'\DrivePrg.int');
  RESET(filet);
  readln(filet,DRIVPRG);
  close(filet);

  if not existdir(drivprg) then halt;



  ASSIGN(filet,'Drvmask.int');
  RESET(filet);
  readln(filet,DRIVEMASK);
  close(filet);

  if drivemask='CARTERM' then
  begin
    drivemask:=DRIVE+'\CARTERM\CART\';
    testat:=1;
  end;

  if drivemask='L10' then
  begin
    drivemask:=drive+'\CARTERM\L10\';
    testat:=195;
  end;


  if drivemask='DISP' then
  begin
    drivemask:=drive+'\CARTERM\DISP\';
    testat:=194;
  end;



  {$ifdef dos}
  InitNastro(Drive+'\carterm\');
  ReadColor;
  TextBackground(col[1]);
  ClrScr;
  Errori('Tprcart','Tpccart','Tprmcart');
   Mouse_init;
  if numeroprog = '' then
   begin
      writeln(mouset);
      delay(500);
   end;
  {$endif}
  Caricamento:=false;

  LOAD_ITA;

  DRIVEPLT := DRIVE+CH25;             {'\DISPLT\'}

  disdrive:=drive+CH26+'\';               {'\GRAPHINP\'}

  DATA_DRIVEP  :=DRIVE+'\carterm\';


  NumeroProg:='';
  NDisegno  := '';
  NumPiano:=1;

  FLAG_DATI:=FALSE;
  RESET_PUN;

  System_Init;
  System_Init_piani;

  if exist('carterm.ult') then
   begin
    assign(ftext,'carterm.ult');
    reset(ftext);
    read(ftext,numeroprog);
    close(ftext);
    DRIVEPROG:=DRIVPRG+'\'+numeroprog+'\carterm\';
    DISEGNO_DRIVE := DRIVPRG+'\'+numeroprog+'\graphinp\';

    if exist(DISDRIVE+'Disegno.ult') then
     begin
        assign(ftext,DISDRIVE+'Disegno.ult');
        reset(ftext);
        readln(ftext,NDisegno);
        read(ftext,numeroprog);
        read(ftext,numpiano);
        close(ftext);
     end;

    DISK('L');
    RicComuni;

    TRANSFER_GENERATORI(drivearc+'Generat.ark','L');
    TRANSFER_Relazione(RelGen,DriveArc+NomeR,'L');

    if NDisegno > '' then
     begin
        System_init_piani;
        DISK_P('L');
     end;
   end;



if (NumeroProg >'') And (NDisegno > '') then
   nomeProgetto :=W_M(testat)+' '+versTXT+'        '+W_M(2)+' '+NumeroProg+'('+NDisegno+')'
   {MC4 Software ==> Carterm rev. ,-, Progetto N.}
Else
  begin
   if NumeroProg >'' then
        nomeprogetto:=W_M(testat)+' '+versTXT+'        '+W_M(2)+' '+NumeroProg
        { MC4 Software ==> Carterm rev. ,-,Progetto Nø}
   else nomeprogetto:=W_M(testat)+' '+versTXT;
  end;



end;
end.