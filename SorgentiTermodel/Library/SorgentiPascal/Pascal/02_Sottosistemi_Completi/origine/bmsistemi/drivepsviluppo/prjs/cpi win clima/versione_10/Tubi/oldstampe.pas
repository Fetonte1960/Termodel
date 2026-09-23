
unit stampe;
interface
uses
   {printer,
   crt,
   dos,
   print,
   defuti,
   utilitie,}
   {tubivar}definiz,varcarichi,
   {inituti,}
   iotubi,
   load,
   stampa3,
   stampa4,
   {wp,}
   uti_calc,
   {winprocs,
   wintypes,
   owindows,}
   {$ifdef delphi}
   messages
   {$endif}
   {key;}UUtigen, LibreriaGenerale;

procedure stampa_w;
implementation
var
   k,Chiave,ValoreS                 : integer;
   execstam                         :file of integer;

{ ************************************************************************ }


{***************************  RicercaDiametro  ******************************}

Procedure RicercaDiametro(Indice,IndCalc : integer;VAR IndiceSez : integer);
var j  : integer;
    Tr : boolean;

begin
  tr := false;
  j := 1;

  while ( not(tr) ) and (j <= maxsez) do
   begin
     if (Dati^[IndCalc]^.CodDiam = '' ) then
     begin
       {gotoxy(8,7);}
       str(Dati^[IndCalc]^.Num,st_8);
       writec(w_m(1)+' '+st_8 +w_m(2),20);   {Il Tronco N. /..../non ha codice diametro }
       halt;
     end;

     if UpString(Tubaz_D^[Indice].Sez[j].Dnom) =  UpString(Dati^[IndCalc]^.CodDiam) then
      begin
         tr := true;
         FormuleUsate[Tubaz_D^[Indice].Sez[j].Form] := cyes;
      end
     else j := j+1;
   end;

   if Tr then IndiceSez := j
   else IndiceSez := 0;
end;


{$I stampa1}
{$I stampa2}

{****************************************************************************}

{***************************  DatiGenerali  *********************************}

procedure datigenerali;
var circuito : st30;
procedure InitGen;
begin

 With gen do
  begin
     Prog        := Generalita_d^.progetto;
     rev         := Generalita_d^.revisione;
     datarev     := Generalita_d^.Luogo;
     Committente := Generalita_d^.committ;
     Progett     := Generalita_d^.progettista;

  end;
end;

procedure InitFluss;
begin
 With Fluss do
  begin
     tipoFluido  := UpString(Flum_D^.Cod);
     TempM       := Flum_D^.Tm;
     Press       := Flum_D^.Pm;
     Densita     := Flum_D^.Dens;
     Viscosita   := Flum_D^.Visc;
  end;

end;

begin
  InitGen;
  InitFluss;

  generalita_D^.ritorno := UpString(Generalita_D^.ritorno);


  if (Generalita_D^.Ritorno = cyes) or (rit=2) then Circuito := Circ1
{    if (Generalita_D^.Ritorno = 'S') or (rit=2) then Circuito := Circ1}
  else Circuito := Circ2;

  WriteTesto('Titolo.prn');
  nrighe := nrighe+lungTXT('titolo.prn');

{***  StampaMask(SEG(gen),OFS(gen),'generali.prn',true);

  StampaMask(SEG(fluss),OFS(fluss),'fluido.prn',true);

  StampaMask(SEG(Circuito),OFS(Circuito),'Circuito.prn',true);}

  nrighe := nrighe + LungTXT('generali.prn') + LungTXT('fluido.prn')+LungTXT('Circuito.prn');
end;


procedure InitCopie;
var i : integer;

begin
   with buffer do
   begin
      for i:=1 to 4 do  Scelte[i]:=0;
      NCopie := 1;
   end;
end;

{ ---------------------------- EseguiStampa --------------------------------- }

Procedure ESEGUISTAMPA(var BufferOK : boolean);
begin

 BufferOk := false;

 BufferOk := ( (Buffer.scelte[1] >= 0) AND (Buffer.scelte[1] <=4) AND
               (Buffer.scelte[2] >= 0) AND (Buffer.scelte[2] <=4) AND
               (Buffer.scelte[3] >= 0) AND (Buffer.scelte[3] <=4) AND
               (Buffer.scelte[4] >= 0) AND (Buffer.scelte[4] <=4) AND
               (Buffer.NCopie >=0 ) );

end;

{ ---------------------------- StampeTotali --------------------------------- }

procedure StampeTotali(var Chiave1: integer);

var ok,InitMask : boolean;
    campo       : integer;
    f:file of stampa;

begin
  assign(f,'buffer.dat');
  reset(f);
  read(f,buffer);
  close(f);
end;

{ ---------------------------- StampaDati --------------------------------- }

Procedure StampaDati(VAR Esegui1 : boolean);

var f     :text;
    Riga  :st126;
    err   :boolean;
    lpt1,lpt2,lpt3,com1,com2:text;


begin
  (*
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
  assign(f,'Stampe.lst');
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
         clrscr;
         write(chr(7));
         if Conferma('stampeT.msg','',1) then
         begin
           esegui1 := false;
           exit;
         end;
       end
     until err<>true;
     clrscr;
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
*)
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
  (*
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
          writeln(lpt1,'E','(10U','(s1P ','&a2L');
        end;
      2:begin
          assign(lpt2,'lpt2');
          rewrite(lpt2);
          writeln(lpt1,'E','(10U','(s1P ','&a2L');
        end;
      3:begin
          assign(lpt3,'lpt3');
          rewrite(lpt3);
          writeln(lpt1,'E','(10U','(s1P ','&a2L');
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
    if exist('stampe.lst') then
    begin
      linea:='';
      linea1:='';
      linea0:='';
      for i:=1 to 249 do linea[i] := ' ';
      for i:=1 to 249 do linea1[i] := ' ';
      for i:=1 to 249 do linea0[i] := ' ';

      assign(f,'stampe.lst');
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
 *)
end;






procedure stampa_w;
{ ------------------------------ main ------------------------------------- }
var drive:string;
    i:integer;
begin
   drivemess:=get_drive;
   ltx     := 0;
   CtrlKey := 1;
   {$ifdef dos}
   ReadColor;
   window(1,3,80,25);
   TextBackground(col[1]);
   TextColor(col[7]);
   mouse_Init;
   {$endif}

  ASSIGN(filet,'drive1.int');
  RESET(filet);
  read(filet,drive);
  close(filet);

  ASSIGN(filet,drive+'\driveprg.int');
  RESET(filet);
  read(filet,driveprog);
  close(filet);


  ASSIGN(filet,drive+'\drivearc.int');
  RESET(filet);
  read(filet,drivearc);
  close(filet);

  ASSIGN(filet,drive+'\nomecom.dat');
  RESET(filet);
  read(filet,nomecommessa);
  close(filet);

  driveprog:=driveprog+'\'+nomecommessa+'\'+ch63+'\';
  drivearc:=drivearc+'\'+ch63+'\';
  initprogram;
  drivemask:=get_drive+'\tubi\';
  if paramcount >0 then stampe_word:=true;
   new(dati);
   new(GTerm);
   for i:=1 to lungdati do dati^[i]:=nil;
   for i:=1 to maxterm  do gterm^[i]:=nil;

   new(Flum_D);


   Reset_Pun;
   System_init;
   ReadNprog;

   Disk('L');
   new(risultcalc);
   new(vprog);
   new(vvalv);

   (*Errori('Tprcart','Tpccart','Tprmcart');*)

   numeroprog1 := numeroprog;
   NumeroProg := driveprog+Numeroprog;


   if exist(NumeroProg+'.ria') then
   begin
     assign(frisult,NumeroProg+'.ria');
     reset(frisult);
     read(frisult,RisultCalc^);
     close(FRisult);
     if RisultCalc^.origine<>0 then rit:= 2 else rit:=1;
   end
   else rit:=1;


   if (upcase(Generalita_D^.Ritorno[1])= cyes) then
   begin
     divrit:=2;
     rit:=1;
   end
   else divrit:=1;

   piuReti := false;
   ExistSottorete(numeroprog1,piuReti);
   piuReti:=(piureti)or(rit=2);
   manrip:=true;
   loaddis(numeroprog);

{      if (upcase(Generalita_D^.Ritorno[1])='S') then rit:=1;}








   StampeTotali(Chiave);

   if Buffer.scelte[1]= 5 then flagstampa:=false
   else flagstampa:=true;


   if Chiave = 59 then
    begin
     {ClrScr;}
     Halt;
   end;


   new(Comodo);
   new(Com_M);
   new(k_Comp);
   new(Comp_Racc);
   new(Comp_R1);
   new(C_Valv);
   new(termal);

   Assign(glst,'Stampe.lst');
   Rewrite(glst);

   NumPag :=2;
   k := 0;

   NRighe := 0;
   DatiGenerali; {prima pagina stampe}

   CiSonoSottoreti := false;

   {clrScr;}

   repeat
      k := k+1;

      case Buffer.scelte[k] of

         1:begin
              {gotoxy(2,2);}
              writec(w_m(3),2);   { Opzione 1  }
              Dimensionamento(k);   {dimensionamento tubazioni}
           end;

         2:begin
            {gotoxy(2,3);}
             writec(w_m(4),3);    {  Opzione 2 }
              PerditeLocalizzate(k);
           end;

         3:begin
            {gotoxy(2,4);}
            writec(w_m(5),4);    { Opzione 3 }

              Elencoterminali(k);
           end;

         4:Begin
             {gotoxy(2,5);}
             writec(w_m(6),5);    { Opzione 4 }

              Computo(k); {computo metrico}
           end;
         5:Begin
              Computo(k); {crea file di computo metrico}
           end;

      end;

   until (k = 4) or (Buffer.Scelte[k] = 0);

   Close(glst);

   Dispose(termal);
   Dispose(C_Valv);
   Dispose(Comp_Racc);
   Dispose(Comp_R1);
   Dispose(Com_M);
   Dispose(K_Comp);
   Dispose(Comodo);
   Dispose(dati);
   Dispose(GTerm);
   Dispose(Flum_D);

   {$ifdef protetto}
   Decrementa(ValoreS,21);
   {$endif}

   assign(execstam,'execstam.sce');
   rewrite(execstam);
   write(execstam,Buffer.Ncopie);
   close(execstam);
   

   (*
   if Buffer.NCopie > 0 then
     begin
        clrscr;
        textcolor(15);
        gotoxy(2,21);
        write(w_m(7));    { A T T E N Z I O N E ,assicurarsi che la stampante sia settata correttamente}
        gotoxy(2,23);
        write(w_m(8));   {Premere un tasto per continuare }
        repeat until keypressed;

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
          for k:=1 to Buffer.NCopie do
          begin
             if esegui then StampaDati(esegui);
          end;
        end
        else
        begin
        if vstamp.stlaser='*' then
        for k:=1 to Buffer
        .NCopie do stampalaser;
        end;
     end;

      *)

end;
end.