PROGRAM StampaLst;
uses crt,dos,defuti,utilitie,printer;
  CONST
    data_drive = '';
  TYPE
    st80 = STRING[80];
    type recstamp=record
          STepson:string[1];
          STlaser:string[1];
          LungMod:integer;
          Ruotata:string[1];
          PortaP :Integer;
          end;

  VAR fff : TEXT;
       fp : TEXT;
  esegui  : boolean;
        k : integer;

    ch : STRING[126];
    riga : STRING[80];
    I, Campo, Chiave, numcopie : INTEGER;
  Vstamp        :recstamp;
  Fstamp        :file of recstamp;
  startpos  : integer;
  ExitChar  : char;
  modflag   : boolean;


  FUNCTION Exist(Nome : st80) : BOOLEAN;
    VAR f : FILE;
    BEGIN
      {$I-} ASSIGN(f, Nome); RESET(f); {$I+}
      Exist := (IORESULT = 0);
      CLOSE(f);
    END;


Procedure StampaDati(VAR Esegui1 : boolean);

var f     :text;
    Riga  :string;
    err   :boolean;
    lpt1,lpt2,lpt3,com1,com2:text;


begin
  if vstamp.portap>0 then
  begin
    case vstamp.portap of
      1:begin
          assign(lpt1,'lpt1');
          rewrite(lpt1);
        end;
      2:begin
          assign(lpt2,'lpt2');
          rewrite(lpt2);
        end;
      3:begin
          assign(lpt3,'lpt3');
          rewrite(lpt3);
        end;
      end;
  end;
  assign(f,data_drive+'Stampe.lst');
  reset(f);

   while not eof(f) do
    begin
       readln(f,Riga);
       if keypressed then ch:=readkey;
       repeat
       err:=false;
       {$I-}
       if vstamp.portap>0 then
        begin
          case vstamp.portap of
            1:writeln(lpt1,riga);
            2:writeln(lpt2,riga);
            3:writeln(lpt3,riga);
          end;
        end;
      {$I+}

        if ioresult<>0 then
         begin
           err:=true;
           write(chr(7));

           if Conferma('stampeT.msg','',1) then
             begin
               esegui1 := false;
               exit;
             end;
         end
       until err<>true;

    end;
   close(f);
   if vstamp.portap>0 then
        begin
          case vstamp.portap of
            1:close(lpt1);
            2:close(lpt2);
            3:close(lpt3);
          end;
        end;
end;


procedure stampalaser;

const maxconv=20;

var
     epson:array[1..maxconv]of string[2];
     laser:array[1..maxconv]of string[20];
     ft,f:text;
     i,j,k,a:integer;
     linea,linea1,linea0:string;
     f1,lpt1,lpt2,lpt3:text;
     spi,spj:integer;
     compr,stb,stb1:boolean;



begin
  compr:=false;
  stb:=false;
  stb1:=false;
  for spi:=1 to maxconv do
  begin
  laser[spi]:='';
  for spj:=1 to 20 do laser[spi,spj]:=' ';
  end;
  for spi:=1 to maxconv do
  begin
    epson[spi]:='';
    for spj:=1 to 2 do epson[spi,spj]:=' ';
  end;
  assign(fstamp,'stamp.cfg');
  reset(fstamp);
  read(fstamp,vstamp);
  close(fstamp);
  if vstamp.portap>0 then
  begin
    case vstamp.portap of
      1:begin
          assign(lpt1,'lpt1');
          rewrite(lpt1);
          writeln(lpt1,'E','(10U','(s0P ');
        end;
      2:begin
          assign(lpt2,'lpt2');
          rewrite(lpt2);
          writeln(lpt1,'E','(10U','(s0P ');
        end;
      3:begin
          assign(lpt3,'lpt3');
          rewrite(lpt3);
          writeln(lpt1,'E','(10U','(s0P ');
        end;
      end;
  end;
  if exist('conv.ljm') then
  begin
    i:=1;
    j:=1;
    assign(ft,'conv.ljm');
    reset(ft);
    while (not eof(ft))and(i<=10)and(j<=10) do
    begin
      readln(ft,epson[i]);
      readln(ft,laser[j]);
      i:=i+1;
      j:=j+1;
    end;
    close(ft);
    if exist(data_drive+'stampe.lst') then
    begin
      linea:='';
      linea1:='';
      linea0:='';
      for i:=1 to 249 do linea[i] := ' ';
      for i:=1 to 249 do linea1[i] := ' ';
      for i:=1 to 249 do linea0[i] := ' ';

      assign(f,data_drive+'stampe.lst');
      reset(f);
      while (not eof(f))  do
      begin
        readln(f,linea);
        k:=1;
        if (linea>'')then
        repeat
          if linea[k]='' then compr:=true;
          if linea[k]='' then compr:=false;
          if (linea[k]<>' ')then
          for a:=1 to j do
          begin
              if (linea[k]=epson[a,1]) and (linea[k]<>chr(27)) then
              begin
                delete(linea,k,1);
                insert(laser[a],linea,k);
              end
              else
              begin
                if (linea[k]=epson[a,1])and (linea[k+1]=epson[a,2])then
                begin
                  delete(linea,k,2);
                  insert(laser[a],linea,k);
                end;
              end;
           end;
          k:=k+1;
        until k=length(linea)+1 ;
        if compr then
        begin
          linea1:=linea;
          linea0:=linea;
          stb1:=false;
          stb:=false;
          for i:=1 to length(linea1) do
          begin
            case linea1[i] of

'Ú','Â','¿','Å','Ñ','³','Ã','´'

           : begin
                linea1[i]:='³';
                stb:=true;
              end;
'É','Ë','»','Î','Ç','¶','º'
           : begin
                linea1[i]:='º';
                stb:=true;
              end;
'À','Á','Ù','Ï'
           : begin
               linea0[i]:='³';
               stb1:=true;
             end;
'Ì','¹','È','Ê': begin
               linea0[i]:='º';
               stb1:=true;
             end;
      '¼'   :begin
               if i<length(linea1) then
               begin
                 linea1[i]:='³';
                 stb:=true;
               end
               else
               begin
                  linea0[i]:='º';
                  stb1:=true;
               end;
             end;
             else
             begin
               linea1[i]:=' ';
               linea0[i]:=' ';
            end;
          end;
         end;
        end;
        if vstamp.portap>0 then
        begin
          case vstamp.portap of
            1:begin
                if (compr)and (stb1) then writeln(lpt1,linea0);
                writeln(lpt1,linea);
                if (compr) and (not stb1) then writeln(lpt1,linea1);
              end;
            2:begin
                if (compr)and (stb1) then writeln(lpt2,linea0);
                writeln(lpt2,linea);
                if (compr) and (not stb1) then writeln(lpt2,linea1);
              end;
            3:begin
                if (compr)and (stb1) then writeln(lpt3,linea0);
                writeln(lpt3,linea);
                if (compr) and (not stb1) then writeln(lpt3,linea1);
              end;
          end;
        end;
      end;
      close(f);
      if vstamp.portap>0 then
        begin
          case vstamp.portap of
            1:close(lpt1);
            2:close(lpt2);
            3:close(lpt3);
          end;
        end
    end;
 end;
end;

procedure SettaLaStampante(var ok : boolean);
{.. settaggio stampante per i vari formati carta ..}
var   f1 : file of recstamp;
      err: boolean;
      riga:string[126];
      lpt1,lpt2,lpt3,com1,com2:text;


begin

 ok := true;

  if vstamp.stepson='*' then riga:=chr(24)+chr(27)+chr(67)+chr(vstamp.lungmod)
                      else riga:='';
  if vstamp.portap>0 then
  begin
    case vstamp.portap of
      1:begin
          assign(lpt1,'lpt1');
          rewrite(lpt1);
        end;
      2:begin
          assign(lpt2,'lpt2');
          rewrite(lpt2);
        end;
      3:begin
          assign(lpt3,'lpt3');
          rewrite(lpt3);
        end;
    end;
  end;
  if keypressed then ch:=readkey;
  repeat
  err:=false;
  {$I-}
  if vstamp.portap>0 then
  begin
   case vstamp.portap of
     1:writeln(lpt1,riga);
     2:writeln(lpt2,riga);
     3:writeln(lpt3,riga);
   end;
  end;
  {$I+}

  if ioresult<>0 then
         begin
           err:=true;

           if Conferma('stampeT.msg','',1) then
            begin {fine stampa}
              ok := false;
              exit;
            end
        end;

    until err<> true;

  if vstamp.portap>0 then
        begin
          case vstamp.portap of
            1:close(lpt1);
            2:close(lpt2);
            3:close(lpt3);
          end;
        end;
end;


  BEGIN
    ctrlkey:=1;
    Mouse_init;
    readcolor;
    NumCopie := 0;  Campo:=1;
    M_off;
    textbackground(col[1]);
    TEXTCOLOR(Col[4]);
    WINDOW(1, 3, 80, 25);
    gotoxy(3,1);clreol;
    WRITE('NUMERO COPIE DA STAMPARE : ');
    startpos:=1;
    Riga:=line_input(30,1,3,StartPos,' ',' ', 1, ExitChar, false, ModFlag,1);
    val(Riga,NumCopie,campo);

    if exist('stamp.cfg') then
        begin
          assign(fstamp,'stamp.cfg');
          reset(fstamp);
          read(fstamp,vstamp);
          close(fstamp);
        end;
        if (vstamp.stepson='*') and (NumCopie > 0) then
        begin
          SettaLaStampante(Esegui);
          for k:=1 to NumCopie do
           if esegui then
            begin
               gotoxy(1,1);clreol;
               gotoxy(21,1);writeln('Stampa copia Nø ',k,' in corso ...');
               StampaDati(esegui);
            end;
        end
        else
        begin
        if (vstamp.stlaser='*') and (NumCopie > 0) then
        begin
(*        SettaLaStampante(Esegui);*)
          for k:=1 to NumCopie do
           if esegui then
            begin
               gotoxy(1,1);clreol;
               gotoxy(21,1);writeln('Stampa copia Nø ',k,' in corso ...');
               StampaLaser;
            end;
        end;
        end;
END.
(*

  BEGIN
    numcopie := 1; Campo := 1;
    BEGIN
      ASSIGN(fp, DATA_DRIVE+'Testata.int');
      RESET(fp);
      READ(fp, Riga);
      CLOSE(fp);
      textbackground(1);
      TEXTCOLOR(15);
      WRITELN(riga);
      WINDOW(1, 3, 80, 25);
      WRITE('Numero di copie da stampare : ');
      READLN(numcopie);
    END;

    if exist('stamp.cfg') then
        begin
          assign(fstamp,'stamp.cfg');
          reset(fstamp);
          read(fstamp,vstamp);
          close(fstamp);
        end;
        if vstamp.stepson='*' then
        begin
          SettaLaStampante(Esegui);
          for k:=1 to NumCopie do
           if esegui then
            begin
               gotoxy(10,11);writeln('Stampa copia Nø ',k,' in corso ...');
               if esegui then StampaDati(esegui);
            end;
        end
        else
        begin
        if vstamp.stlaser='*' then
        begin
        SettaLaStampante(Esegui);
          for k:=1 to NumCopie do
          begin
             gotoxy(10,11);writeln('Stampa copia Nø ',k,' in corso ...');
             if esegui then StampaLaser;
          end;
        end;
        end;

  END.
*)