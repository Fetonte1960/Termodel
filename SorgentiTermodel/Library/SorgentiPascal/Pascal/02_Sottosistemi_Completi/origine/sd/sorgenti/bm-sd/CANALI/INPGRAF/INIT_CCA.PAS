UNIT Init_cca;
interface
uses definiz,defuti,wm,{$ifdef dos}demo,{$endif}crt,utilitie;

procedure initcca;
implementation
procedure initcca;
VAR DRIVE,drivprg,drivarc:STRING;
    filet:text;
begin
  {chdir('c:\mc4-l10\cca\inpgraf');}
  FILETRADUZ:='DUCT';
  {ControlloChiave(ctrlkey,18,Versione);}
  ctrlkey:=1;
  erroraddr:=nil;
  new(mis);
  new(riduz);
  new(dpr2);
  new(dpr1);
  new(vprog);
  new(ept);
  new(sez);
  new(ErroreInp);
  new(vprogmto);
  
  ASSIGN(filet,'drive1.int');
  RESET(filet);
  read(filet,drive);
  close(filet);
  chdir(drive+'\cca\inpgraf');
  drivecca:=drive+'\cca\';
  {$ifdef dos}
  initnastro(drive+'\cca');
  ReadColor;
  TextBackground(col[1]);
  {$endif}
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

  drivearc:=drivarc+'\DUCT\';

  Driveplt:=Drivprg+'\'+nomecommessa+'\DisPlt\';

  DRIVEprog:=DRIVprg+'\'+nomecommessa+'\DUCT\'; {'\DATICCA\';}

  drivecart:=drivprg+'\'+nomecommessa+'\carterm\';{pino}
  drivearia:=drivprg+'\'+nomecommessa+'\carterm\';




end;
end.