Unit metod10;

Interface

Uses
  //defutig,
  SysUtils, Dialogs,
  Uvariabili, Varcarichi, LibreriaGenerale, UMessaggiCarichi;
type
     dati10= class
             function ndg:real;
             function nag:real;
             function TiAmbx:real;
             function URx:real;
             function TNotMin:real;
             function Qnrd(mese:integer):real;
             function Pf:real;
             function Pd:real;
             function Pfbs:real;
             function Esen:real;
             function Epo:real;
             function Qpo:real;
             function Qbr:real;
             function PNomUtil:real;
             function PFoc:real;
             function TipoInvol:string;
{             function TipoCamin:st30;}
             function TipoTerm:string;
             function CodTipoTerm:integer;
             function TipoRegol:string;
             function InizRisc:integer;
             function FinRisc:integer;
             function GrGiorno:real;
             function PortMecNat:real;
           {  function Portata:real;}
             function comune:string;
             function descrprogetto:string;
             function commit:string;
             function Numconcess:string;
             function dataconcess:string;
             function Classif(zona:integer):string;
  {           function NumAbit:real;}
             function NAbitaz:real;
             function ZonaClim:string;
             function TempEst:real;
             function proget:string;
             function dirterm:string;
             function destedif:string;
             function RendTerm : real;
             function RendReg(mese:integer):real;

            end;



var
    Pdati10   : dati10;
implementation

uses procle10, FunzProc1;

// Emanuela funzione modificata affinchè vengano presi i dati giusti dell'impianto relativi
// al generatore esaminato, dato che i dati memorizzati in zona non garantiscono questo
function dati10.ndg:real;
var
  i: Integer;
  Trovato: Boolean;
begin
  Trovato := False;
  i := 1;
  while (i <= NImpianti) and (not Trovato) do
  begin
    if CompareStr(UpperCase(ImPianto_D^[i].GenInvt), UpperCase(DescGen1^[gencor].Descrizione)) = 0 then
    begin
      ndg := ImPianto_D^[i].NOreGiorno;
      Trovato := True;
    end;
    inc(i);
  end;
  // ndg:=zone10^[zonacalc].NOreGiorno;
end;

// Emanuela funzione modificata affinchè vengano presi i dati giusti dell'impianto relativi
// al generatore esaminato, dato che i dati memorizzati in zona non garantiscono questo
function dati10.nag:real;
var
  i: Integer;
  Trovato: Boolean;
begin
  Trovato := False;
  i := 1;
  while (i <= NImpianti) and (not Trovato) do
  begin
    if CompareStr(UpperCase(ImPianto_D^[i].GenInvt), UpperCase(DescGen1^[gencor].Descrizione)) = 0 then
    begin
      nag := ImPianto_D^[i].NOreNotte;
      Trovato := True;
    end;
    inc(i);
  end;
   //nag:=zone10^[zonacalc].NOreNotte;
end;

function dati10.TiAmbx:real;
begin
   TiAmbx:=zone10^[zonacalc].TAria;
end;

function dati10.URx:real;
begin
   URx:=zone10^[zonacalc].Ur;
   {zone_d^[zonacalc].Uinv;}
end;

function dati10.TNotMin:real;
begin
   TNotMin:=zone10^[zonacalc].TempMin;
end;

function dati10.Qnrd(mese:integer):real;
begin
   Qnrd:=energM^[mese].energ;
end;

function dati10.Pf:real;
begin
   Pf:=DescGen^.Pf; { compilarlo prelevandolo dai dati di progetto complemento a 100 del red.combustibile }
end;

function dati10.Pd:real;
begin
   Pd:=DescGen^.Pd;
end;

function dati10.PFbs:real;
begin
   Pfbs:=DescGen^.Pfbs;
end;

function dati10.PFoc:real;
begin
   PFoc:=DescGen^.PFoc;
end;

function dati10.PnomUtil:real;
begin
   PnomUtil:=DescGen^.PNom;
end;
function dati10.Esen:real;
begin
   Esen:=0.36;
   {rendimento del sistema elettrico nazionale in assenza di obblichi specifici = 0.36 Uni10348}
end;

function dati10.Epo:real;
begin
   Epo:=0.85;
   {frazione utile dell'energia elettrica assorbita dalle pompe di circolazione o similari
    effettivamente trasferita al fluido convenzionalemte pari a 0.85}
end;

function dati10.Qpo:real;
begin
   Qpo:=DescGen^.Qpo;
end;

function dati10.Qbr:real;
begin
   Qbr:=DescGen^.Qbr;
end;

function dati10.TipoInvol:string;
begin
   TipoInvol:=DescGen^.TipoInvol;
end;

function dati10.TipoTerm:string;
begin
   TipoTerm:=Zone10^[zonacalc].tipoterm;
end;

function dati10.CodTipoTerm:integer;
begin
   CodTipoTerm:=IndImpiantoTipoTerminali(Zone10^[zonacalc].tipoterm);
end;

function dati10.TipoRegol:string;
begin
   TipoRegol:=Zone10^[zonacalc].tiporeg;
end;

function dati10.InizRisc:integer;
{VAR zcl:string;}
begin
   InizRisc:=Prog^.Mesein;;
 {  zcl:=formst(PROG^.zonacl);
   case zcl[1] of
    'A','B':InizRisc:=12;
    'C','D':InizRisc:=11;
    'E','F':InizRisc:=10;
   END;}
end;
function dati10.FinRisc:integer;
{VAR ZCL:STRING;}
begin
   FINRisc:=Prog^.mesefin;
   { zcl:=formst(PROG^.zonacl);
   case zcl[1] of
    'A','B','C':FINRisc:=3;
    'D','E','F':FINRisc:=4;
   END;}
end;

function dati10.GrGiorno:real;
begin
   GrGiorno:=prog^.gradi;
end;

function dati10.PortMecNat:real;
begin
   PortMecNat:=(VentTotZona*3600)  {m3/h}
end;

function dati10.comune:string;
begin
   comune:=prog^.comune;
end;
function dati10.Descrprogetto:string;
begin
   descrprogetto:=Prog^.DescrProgetto;
end;

function dati10.numconcess:string;
begin
   numconcess:=prog^.numconcess;
end;
function dati10.Dataconcess:string;
begin
   dataconcess:=prog^.dataconcess;
end;

function dati10.Classif(zona:integer):string;
begin
   classif:=upstring(Zone11^[Zona].classif);
end;

function dati10.NAbitaz:real;
begin
   nabitaz:=prog^.numabitaz;
end;
function dati10.zonaclim:string;
begin
   zonaclim:=prog^.zonacl;
end;
function dati10.Tempest:real;
begin
   tempEst:=prog^.tempest;
end;

function dati10.commit:string;
begin
   {commit:=prog^.committ;}
end;

function dati10.proget:string;
begin
   {proget:=Generalita_D^.progettista;}
end;

function dati10.dirterm:string;
begin
   dirterm:=prog^.diretImp;
end;

function dati10.destedif:string;
begin
   destedif:=prog^.destinaz;
end;

function DATI10.RendTerm : real;
const
   Term1:array[1..6] of real =(0.99,0.98,0.97,0.96,0.97,0.95);

var Ind:integer;
    Perc:real;
begin
   Perc:=0;
   Ind := IndImpiantoTipoTerminali(Zone10^[zonacalc].tipoterm);
   case ind of
     1: Perc := Term1[1];
     2: Perc := Term1[2];
     3: Perc := Term1[3];
   {$IFDEF VERSIONE_13}
     4,5: Perc := Term1[4];
     6:   Perc := Term1[5];
     7,8: Perc := Term1[6];
   {$ELSE}
     4: Perc := Term1[4];
     5: Perc := Term1[5];
     6: Perc := Term1[6];
   {$ENDIF}
   end;
   zone10^[zonaCalc].rendTerm:=perc;
   Result := Perc;
end;

function DATI10.RendReg(mese:integer):real;
type
  Cube = array[1..4,1..3,1..3] of real;

CONST

  Reg1: array[1..3] of real =(0.96,0.94,0.90);
  Reg2: array[1..3] of real =(1,0.98,0.94);

  Reg3: Cube = (((0.94,0.92,0.88),(0.98,0.96,0.92),(0.96,0.94,0.90)),
               ((0.97,0.95,0.93),(0.99,0.98,0.96),(0.98,0.97,0.95)),
               ((0.93,0.91,0.87),(0.97,0.96,0.92),(0.95,0.93,0.89)),
               ((0.96,0.94,0.92),(0.98,0.97,0.95),(0.97,0.96,0.94)));

var Ind,ind1,ind2,ind3:integer;
    TotRend:real;

procedure errorex(Ind: Integer);
begin
 if not Erroregen then
 begin
   Erroregen := true;
   Case ind of
     1:begin
        Echo('Tipologie terminali, regolazione e produzione inesistenti');
        MessageDlg('La tipologia Terminale, o la tipologia dei rendimenti di regolazione e produzione sono inesistenti'
                   + #13#10 + 'controllare i dati inseiri in Impianto', mtInformation, [mbOK], 0);
       end;
     2:begin
        Echo('Tipologie regolazione e produzione incongruenti');
        MessageDlg('Il tipo di rendimento di regolazione inserito e il tipo rendimento di'
                   + #13#10 + 'produzione non sono conguenti, verificare i dati inseriri in Impianto', mtInformation, [mbOK], 0);
       end;
   end;
 end;  
end;

begin
   TotRend:=0;
   {Ind:=pos_combo(drivecombo,'Impianti','TipoReg',Zone10^[zonacalc].TipoReg );
   Ind1:=pos_combo(drivecombo,'Impianti','TipoProd',Zone10^[zonacalc].TipoProd);
   Ind2:=pos_combo(drivecombo,'Impianti','tipoterm',Zone10^[zonacalc].tipoterm); }
   Ind := IndImpiantoTipoRegolazione(Zone10^[zonacalc].TipoReg);
   Ind1:= IndImpiantoTipoProduzione(Zone10^[zonacalc].TipoProd);
   Ind2:= IndImpiantoTipoTerminali(Zone10^[zonacalc].tipoterm);
   if (InRange(ind,1,6)) and (InRange(ind1,1,5)) and (InRange(ind2,1,9)) then
   begin
      if ((Ind=1) and (Ind1<>1)) or
         ((Ind<>1) and (Ind1=1)) then errorex(2);
      if ((Ind=2) and (Ind1<>2)) or
         ((Ind<>2) and (Ind1=2)) then errorex(2);
      case Ind2 of
        1..5:ind3:=1;
         6,7:ind3:=2;
         8,9:ind3:=2;
      end;
      case Ind of
        1:if mese <> 0 then TotRend:=Reg1[ind3]-(0.6*CalcGamma(mese)*CalcEu(mese))
          else TotRend:=Reg1[ind3];
        2:if mese <> 0 then TotRend:=Reg2[ind3]-(0.6*CalcGamma(mese)*CalcEu(mese))
          else TotRend:=Reg2[ind3];
        3..6: begin
                TotRend := 0;
                if (Ind-2 <> 0) and (Ind1-2 <> 0) and (ind3 <> 0) then
                  if (Ind - 2 > 0) and (Ind1 - 2 > 0) then
                     TotRend := Reg3[Ind-2,Ind1-2,ind3];
              end;
      end;
      rendReg := TotRend-zone10^[zonaCalc].rendReg;
   end
   else Errorex(1);
end;

end.


