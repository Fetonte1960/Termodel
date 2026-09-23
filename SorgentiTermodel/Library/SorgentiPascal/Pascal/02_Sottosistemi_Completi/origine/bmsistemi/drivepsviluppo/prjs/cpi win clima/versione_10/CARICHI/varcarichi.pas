unit varcarichi;
interface
Uses sysutils,libreriagenerale,utility_dll,copiavariabiligenerali;
{$IFDEF Versione_14}
{$I Typedef}

Const TPar='Parete';
      TFin='Finestra';
      TPOnte='Ponte_T';
var
      Dp,Da,PSupporto:string;
      SLorda,Vlordo:real;
      genCor:integer;
      NomeGeneratore: String;
      SUtilP: real;
      CodGenCor: String;
      Primavolta:boolean;
      DescGen:^RecGenerat;
      ErroreGen,calcolo_estivo:boolean;

Const MaxProfili=10;

Type
RigaProf=ARRAY[0..23] OF INTEGER;

TabProf=ARRAY[1..MaxProfili] OF RigaProf;

PunProf=^TabProf;
Var
Profili_D:Punprof;
Nprofili:integer;
reccontrollo:record
             angolo:real;
             Or_x,or_y,Altnetta:real;
             copiadi:string;
             end;
controlloValido:boolean=false;
indice_rete:integer;
Nlabsosp:integer=0;
const etic_rim='Va a';
const etic_rip='Viene da';
Var count_deb:integer=0;
    count_deb1:integer=0;
    debug3d_on:boolean=false;
    debug_2d:boolean=false;

Procedure InitPuntatori;
Procedure DisposePuntatori;
Function CalcolaCdFen:real;
function Leggi_controllo(cod:string):boolean;
function filecontrollo(piano_contr:string):string;
procedure  debugLinea3d(x1,y1,z1,x2,y2,z2:real);

{$I Definizioni_estivo}
implementation
{$I Implementation_estivo}
procedure  debugLinea3d(x1,y1,z1,x2,y2,z2:real);
Var par:string;
begin
inc(count_deb);
if count_deb=count_deb1 then
  begin
  par:=float_to_str(x1,5)+':';
  par:=par+float_to_str(y1,5)+':';
  par:=par+float_to_str(z1,5)+':';
  par:=par+float_to_str(x2,5)+':';
  par:=par+float_to_str(y2,5)+':';
  par:=par+float_to_str(z2,5)+':';
  Procedura_dll('Debug_Linea_3d','Projectbrowserdll',1,par,'','','');
  end;
end;
function filecontrollo(piano_contr:string):string;
begin
result:=I_sl(percorsodrive)+'controllo_'+Piano_contr+'.txe';
end;

function Leggi_controllo(cod:string):boolean;
Var fcontrollo:textfile;
    bufcontr:string;
    nome_contr:string;
begin
result:=false;
nome_contr:=filecontrollo(cod);
if fileexists(nome_contr) then
  begin
  result:=true;
  controlloValido:=true;
  assign(fcontrollo,filecontrollo(cod));
  reset(fcontrollo);
  with reccontrollo do
    begin
    readln(Fcontrollo,bufcontr);
    angolo:=str_tofloat(bufcontr);
    readln(Fcontrollo,bufcontr);
    or_x:=str_tofloat(bufcontr);
    readln(Fcontrollo,bufcontr);
    or_y:=str_tofloat(bufcontr);
    if not eof(Fcontrollo) then
      begin
      readln(Fcontrollo,bufcontr);
      Altnetta:=str_tofloat(bufcontr);
      end
    else Altnetta:=0;
    close(fcontrollo);
    end;
  end
else
  begin
  reccontrollo.or_x:=0;
  reccontrollo.or_y:=0;
  end;
end;
Function CalcolaCdFen:real;
begin
result:=1;
end;
{$I NewPun}
{$I DispPun}

{$else}  
  {$IFDEF tubi}
  Implementation
  {$else}
    {$IFDEF estivo}
    {$I Varcarichi_Estivo}
    {$else}
    {$I Varcarichi_Legge10}
    {$endif}
  {$endif}
{$endif}
end.





