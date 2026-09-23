UNIT Init_tubi;
interface
uses key,definiz,defuti,wp,{$ifdef dos}demo,{$endif}crt,utilitie,iotubi;

procedure inittubi;
procedure caricanomeprogetto;
implementation

procedure caricanomeprogetto;
{$I \SORGENTI\LAVORO\costant}
 VAR DRIVE,drivprg,drivarc:STRING;
begin
  ASSIGN(filet,'drive1.int');
  RESET(filet);
  read(filet,drive);
  close(filet);
  drivemess:=get_drive;
  chdir(drive+'\tubi');

  {$ifdef dos}
  initnastro(drive+ch102);
  ReadColor;
  TextBackground(col[1]);
  Errori('Tprcart','Tpccart','Tprmcart');
  {$endif}
  Caricamento:=false;
  assign(filet,drive+'\nomecom.dat');
  reset(filet);
  read(filet,nomecommessa);
  close(filet);

  assign(filet,drive+'\driveprg.int');
  reset(filet);
  read(filet,drivprg);
  close(filet);

  assign(filet,drive+'\drivearc.int');
  reset(filet);
  read(filet,drivarc);
  close(filet);

  drivecart:=drive+'\carterm\';

  drivearc:=drivarc+ch102+'\';

  Driveplt:=Drivprg+'\'+nomecommessa+'\DisPlt\';

  DRIVEprog:=DRIVprg+'\'+nomecommessa+ch102+'\'; {'\DATICCA\';}

  drivearia:=drivprg+'\'+nomecommessa+'\carterm\';


  if exist(driveprog+'prog.DAT') then
    begin
      assign(ftext,driveprog+'prog.DAT');
      reset(ftext);
      read(ftext,numeroprog);
      close(ftext);
    end;
  if exist(driveprog+'Sotto.DAT') then
    begin
      assign(ftext,driveprog+'Sotto.DAT');
      reset(ftext);
      read(ftext,Sottorete);
      close(ftext);
    end;
    nomeprogetto:=w_m(46)+' '+VersTXT;
  if numeroprog >'' then
   begin
     nomeprogetto:=Nomeprogetto+w_m(11)+' '+NumeroProg;    {  Progetto Nø }
     if Sottorete >'' then
      nomeprogetto:=Nomeprogetto+'('+Sottorete+')';
   end;
end;

procedure inittubi;


begin

  FILETRADUZ:='mestui';
  {$ifdef protetto}
  ControlloChiave(ctrlkey,21,{Versione});
  {$else}
  ctrlkey:=1;
  {$endif}
  erroraddr:=nil;




  FLAG_DATI:=FALSE;
  FLAG_DATI:=FALSE;
  RESET_PUN;
  new(vprog);

  System_Init;
  DISKARK('L');

if NumeroProg<>'' then DISKPROG('L');
end;
end.