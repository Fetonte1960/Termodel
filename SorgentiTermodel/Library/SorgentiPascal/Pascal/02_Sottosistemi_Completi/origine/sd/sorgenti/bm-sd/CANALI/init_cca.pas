UNIT Init_cca;
interface
uses definizcan,definiz,defuti,wm,Copialibreriagenerale,{$ifdef dos}demo,{$endif}crt,utilitie,prgduct,key,u_canfst;

procedure initcca(progetto:string);
procedure cercaer;
implementation
procedure initcca(progetto:string);
VAR DRIVE,drivprg,drivarc:STRING;
begin
  new(costant);
  new(mis);
  new(riduz);
  new(dpr2);
  new(dpr1);
  new(vprog);
  new(ept);
  new(sez);
  new(ErroreInp);
  new(vprogmto);
  FILETRADUZ:='GESTDUCT';
  {$ifdef protetto}
  ControlloChiave(ctrlkey,18,Versione);
  {$else}
  ctrlkey:=1;
  {$endif}

  erroraddr:=nil;

  //ASSIGN(filet,'drive1.int');
  //RESET(filet);
  //read(filet,drive);
  //close(filet);
  //chdir(drive+'\cca');
  {$ifdef dos}
  //initnastro(drive+'\cca');
  //ReadColor;
  //TextBackground(col[1]);
  //Errori('Tprcart','Tpccart','Tprmcart'); {problema}
  {$endif}
  Caricamento:=false;
  //assign(filet,drive+'\nomecom.dat');
  //reset(filet);
  //read(filet,nomecommessa);
  //close(filet);

  //assign(filet,drive+'\driveprg.int');
  //reset(filet);
  //read(filet,drivprg);
  //close(filet);

  //assign(filet,drive+'\drivearc.int');
  //reset(filet);
  //read(filet,drivarc);
  //close(filet);

  drivearc:=drivarc+'\DUCT\';

  Driveplt:=Drivprg+'\'+nomecommessa+'\DisPlt\';

//  DRIVEprog:=DRIVprg+'\'+nomecommessa+'\DUCT\'; {'\DATICCA\';}
    DRIVEprog:=i_sl(Percorsodrive);




  NumeroProg:='';
  Nomeprog:=progetto;
  Sottorete:='';

  FLAG_DATI:=FALSE;
  (*
  if exist(driveprog+'prog.can') then
    begin
      assign(ftext,driveprog+'prog.can');
      reset(ftext);
      read(ftext,numeroprog);
      close(ftext);
    end
  else
  clrscr;
  if exist('Sotto.can') then
    begin
      assign(ftext,'Sotto.can');
      reset(ftext);
      read(ftext,Sottorete);
      close(ftext);
    end;

{  if NumeroProg<>'' then DISKPROG(NumeroProg,'L');}

  nomeprogetto:=W_M(5)+' '+VersTXT; { MC4 Software ==> DUCT rev.}
  if numeroprog >'' then
    begin
       nomeprogetto:=Nomeprogetto+' '+W_M(1)+' '+NumeroProg+'  '+CaricaMisure(NumeroProg);
       { Progetto Nø}
    end;
    *)
end;

 procedure TRANSFER_ARCHIVIO;
        { Serve per caricare la tabella 'ARCHIVIO.CAN' con le descrizioni relative ai
        codici dei pezzi }
      VAR i : INTEGER;
        F : FILE OF RigaArch;
      BEGIN                   { lettura }
        if Exist(DRIVEARC+'archivio.can') then
         begin
            ASSIGN(f, DRIVEARC+'archivio.can');
            RESET(f);
            i := 1;
            WHILE NOT EOF(f) DO
              BEGIN
                READ(f, Archivio^[i]);
                i := i+1;
              END;
            CLOSE(f);
          end;
      END;                    { proc. transfer_archivio }


procedure cercaer;
var i,x:integer;
    f:text;
begin

 new(Archivio);
 TRANSFER_ARCHIVIO;
 assign(f,'coptrat.txt');
 rewrite(f);
for i:=1 to npezzi do
begin
   if archivio^[i].CodPezzo > '' then
    begin
       writeln(f,i:3);
       writeln(f,archivio^[i].CodPezzo);
       flush(f);
       if archivio^[i].Main > '' then x:=TRANSFER_TAB(archivio^[i].Main);
       if archivio^[i].Branch > '' then x:=TRANSFER_TAB(archivio^[i].Branch);
    end;
end;
close(f);
dispose(Archivio);
end;




end.
