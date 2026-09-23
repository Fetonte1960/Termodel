{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$M 65000,16384,655360} {Turbo 3 default stack and heap}
{$F+}
{$O+}
Unit gestDuct;
interface
Procedure gestprg(scelta:integer);
implementation

Uses

  {$Ifdef dos}
  Crt, {Unit found in TURBO.TPL}
  Dos, {Unit found in TURBO.TPL}
  installa,
  demo,
  {$endif}
  {$Ifdef Win}
   WinDos, {Unit found in TURBO.TPL}
  {$endif}
  utilitie,
  Defuti,
  definiz,
  IODuct,
  prgDuct,
  datiDuct,
  key,
  maskcomp,
  arcpezzi,WM,init_cca;

Procedure gestprg(scelta:integer);

procedure SaveNProg;
var NPR:text;
begin
   assign(NPR,'Prog.can');
   rewrite(NPR);
   write(NPR,NumeroProg);
   close(NPR);
end;

Function ChiaveDiCalcolo(calc : integer) : integer;
 begin
    CASE Calc OF
          { MANDATA }
       51 : ChiaveDiCalcolo := 1;{predim. a perdita x attrito cost}
       52 : ChiaveDiCalcolo := 2;{Calc.+Bilanc. con serrande sui rami}
       53 : ChiaveDiCalcolo := 3;{Calc.+Bilanc. con serrande sui Term}
       54 : ChiaveDiCalcolo := 4;{Calc.+Bilanc. senza serrande}
       55 : ChiaveDiCalcolo := 5;{verif.di impianto esistente}
       56 : ChiaveDiCalcolo := 6;{Bilanc.con serrande sui rami}
       57 : ChiaveDiCalcolo := 7;{Bilanc.con serrande sui Term}
       58 : ChiaveDiCalcolo := 8;{Eliminazione serrande di taratura}

          { RIPRESA }
       61 : ChiaveDiCalcolo := 1;{predim. a perdita x attrito cost}
       62 : ChiaveDiCalcolo := 2;{Calc.+Bilanc. con serrande sui rami}
       63 : ChiaveDiCalcolo := 3;{Calc.+Bilanc. con serrande sui Term}
       64 : ChiaveDiCalcolo := 4;{Calc.+Bilanc. senza serrande}
       65 : ChiaveDiCalcolo := 5;{veloc.cost. e bilanc. della rete}
       66 : ChiaveDiCalcolo := 6;{verif.di una rete esistente}
       67 : ChiaveDiCalcolo := 7;{Bilanc.con serrande sui rami}
       68 : ChiaveDiCalcolo := 8;{Bilanc.con serrande sui Term}
       69 : ChiaveDiCalcolo := 9;{Eliminazione serrande di taratura}

    END;

end;

var
  fil : st30;
  Colleg:integer;

{*************************** MAIN *****************************************}

BEGIN
  chdir(get_drive+'\cca');
  {$Ifdef dos}
  initcca;
  Scelta:=21;
  Mouse_init;
  REPEAT
 {$endif}

    ERR:=false;
    errore:=true;
    fine:=false;
    fil:=' ';

    CASE Scelta OF

         21:begin
            ArchProgetti(scelta);
            savenprog;
          end;
  {$Ifdef dos}
   11,12,13,14,15:gestinst(scelta); { .. configurazione .. }
  {$endif}
   22,23,24:Gest_menu(scelta);
      25:ArkPezzi(scelta);
   31,32,
   43,44:if numeroprog>'' then Gest_menu(scelta)
         else
          begin
             scelta := 21;
             writemessage('duct.msg',2);
          end;
        41:begin   {.. Disegno in pianta ..}
              if numeroprog>'' then
               begin
                  if Exist(drivePROG+NumeroProg+'.Can') and
                     ( not Exist(drivePROG+NumeroProg+'.Ret')) then
                   begin
                      scelta:=21;
                      writemessage('duct.msg',5);
                   end
                  else
                   begin
                      assign(ftext,'Graf.sce');
                      rewrite(ftext);
                      write(ftext,fil);
                      close(ftext);
                      fine:=true;
                   end;
               end
              else scelta := 21;
           end;
      42:begin   {.. Disegno dimensionato..}
              if numeroprog>'' then
               begin
                  if Exist(driveprog+NumeroProg+'.Ret') then
                   begin
                      assign(ftext,'Dimen.sce');
                      rewrite(ftext);
                      write(ftext,fil);
                      close(ftext);
                      fine:=true;
                   end
                  else
                   begin
                      scelta := 21;
                      writemessage('duct.msg',6);
                   end;
               end
              else scelta := 21;
           end;

 51..58  :begin   { .. CALCOLO MANDATA --> collegato a canali.com .. }
            if numeroprog>'' then
              begin
                 Colleg:= 7; {mandata --> canali.com}
                 assign(fInt,'calc.sce'); {'\cca'}
                 rewrite(fInt);
                 write(fInt,Colleg);
                 close(fInt);

                 Colleg:=ChiaveDiCalcolo(Scelta);
                 assign(fInt,'calc1.sce'); {'\cca'}
                 rewrite(fInt);
                 write(fInt,Colleg);
                 close(fInt);
                 fine:=true;
              end;
            end;

 61..69  :begin   { .. CALCOLO RIPRESA --> collegato a canali.com .. }
            if numeroprog>'' then
              begin
                 Colleg:= 8; {ripresa --> canali.com}
                 assign(fInt,'calc.sce'); {'\cca'}
                 rewrite(fInt);
                 write(fInt,Colleg);
                 close(fInt);

                 Colleg:=ChiaveDiCalcolo(Scelta);
                 assign(fInt,'calc1.sce'); {'\cca'}
                 rewrite(fInt);
                 write(fInt,Colleg);
                 close(fInt);
                 fine:=true;
              end;
            end;
         71:begin  {stampa}
               if numeroprog>'' then
                begin
                   assign(ftext,'Stamp.sce');
                   rewrite(ftext);
                   write(ftext,fil);
                   close(ftext);
                   Colleg:=9;
                   assign(fInt,'Calc.sce'); {'\cca'}
                   rewrite(fInt);
                   write(fInt,Colleg);
                   close(fInt);
                   fine:=true;
                end
               else scelta := 21;
            end;
         72:begin  { computo }
               if numeroprog>'' then
                begin
                   assign(ftext,'prog.can');
                   rewrite(ftext);
                   write(ftext,NumeroProg);
                   close(ftext);
                   Computo(NumeroProg,scelta)
                end
               else scelta := 21;
            end;

    END;
    {$Ifdef dos}
  UNTIL  (Scelta=80)or(fine=true);
  {$endif}
  if scelta<>80 then
    begin
       assign(ftext,'sotto.can');
       rewrite(ftext);
       write(ftext,Sottorete);
       close(ftext);

       assign(ftext,'prog.can');
       rewrite(ftext);
       write(ftext,NumeroProg);
       close(ftext);
    end
  else
    begin
       assign(ftext,'sotto.can');
       rewrite(ftext);
       write(ftext,'');
       close(ftext);

       assign(ftext,'prog.can');
       rewrite(ftext);
       write(ftext,'');
       close(ftext);
    end;
if scelta=80 then

  begin
  end

else
  begin
  end;
  chdir(get_drive+'\cca\inpgraf');
end;
END.
