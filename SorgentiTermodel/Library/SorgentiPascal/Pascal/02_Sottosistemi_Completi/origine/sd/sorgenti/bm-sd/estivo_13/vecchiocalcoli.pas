
Unit vecchiocalcoli;

interface
Uses
  LibreriaGenerale,
  {defuti,}
  definiz;
  {utilitie,
  inpdati,
  calcfun,
  F1,
  F2,
  F3,
hen {----}
    begin
       assign(f,'mesi.inp');
       reset(f);
       read(f,MeseInizio,MeseFine);
      close(f)
    end
   else
    begin
       Meseinizio:=7;
       Mesefine:=7
    end;
end;



var g,m,a,x:word;
    ch:string[2];
    ch1:string[4];
procedure calccart;

BEGIN
  { chdir('c:\mc4-l10\carterm');}
   FILETRADUZ:='CARTERM';
   ctrlkey:=1;
   {$ifdef dos}
   Errori('Tprcart','Tpccart','Tprmcart');
   window(1,3,80,25);
   ReadColor;
   TextBackground(col[1]);
   ClrScr;
   {$endif}
   ASSIGN(filet,'drive1.int');
   RESET(filet);
   read(filet,drive);
   close(filet);
   ASSIGN(filet,drive+'\DriveArc.int');
   RESET(filet);
   read(filet,DRIVEARCC);
   close(filet);
   drivearcc:=drivearcc+'\carterm\';
   { dentro il file CALCOLO.SCE c'e il contenuto di DRIVEPROG }

   ASSIGN(filet,'Calc.sce');
   RESET(filet);
   readln(filet,DRIVEPROG);
   close(filet);
   {InitNastro(Drive+'\carterm\');

   ReadColor;
   TextBackground(col[1]);
   ClrScr; }



   assign(filet,DRIVE+'\NOMECOM.DAT');
   reset(filet);
   read(filet,nomecommessa);
   close(filet);


   ASSIGN(filet,drive+'\DrivePrg.int');
   RESET(filet);
   readln(filet,DRIVPRG);
   close(filet);
   drivprg:=formst(drivprg);


   DRIVEPLT := DRIVPrg+'\'+nomecommessa+CH25;             {'\DISPLT\'}
   DISEGNO_DRIVE := Drivprg+'\'+nomecommessa+'\graphinp\';   {'\GRAPHINP\PROGETTI\'}
   disdrive:=drive+CH26;               {'\GRAPHINP\'}

   DATA_DRIVEP  :=DRIVE+'\carterm\';

   IF EXIST('CALCOK.TST') THEN
    BEGIN
       assign(calcok,'calcok.tst');
       erase(calcok);
     end;

   RES  TotEd,
  WM,
  calcutiw,}
  { fcc}
  {fcc3,input1,}
  {}
  {Accoda,}
  {$ifdef dos}
   demo;
  {$else}
   {windos;}
  {$endif}

procedure calccart;

implementation

procedure CaricaMesi;
var
   f:file of integer;

begin
   if exist('mesi.inp') tET_PUN;
   System_Init;

   ReadNprog;
   AccodaAmb;
   Conta;
   CaricaMesi;
   CalcMem;
   Init_PCalc;


  FLAG_DATI:=FALSE;

  new(R1);
  new(R2);
  new(R3);
  new(TE);
  new(IDN);
  new(tabc0);
  new(dat);
  new(datb);
  memoria;
  CF:=0;

{  Superfici;}

  FASE1;
  FASE2;  {contiene CalcQCTot, CalcQCPT e CalcDatiAmbiente}
  FASE3;  {contiene CalcMF etc. }

  ClrScr;
  writec(W_M(122),1);     {'Calcolo edificio'}

  CalcEdif;

  if exist(drive+'\fcc.txt') then
   begin
  {ifdef fcc}
     FCC_INPUT1;
     Proc_fcc;
  {endif}
   end;

{  RipristinaSupMuro;}

  dispose(R1);
  dispose(R2);
  dispose(R3);
  dispose(TE);
  dispose(IDN);
  dispose(tabc0);
  dispose(dat);
  dispose(datb);

  assign(calcok,'calcok.tst');
  rewrite(calcok);
  writeln(calcok,nomecommessa);
  writeln(calcok,'CARTERM');
  close(calcok);

  if exist('Inv.tst') then
   begin
     assign(calcok,'calcok.tst');
     erase(calcok);
   end;
end;
end.