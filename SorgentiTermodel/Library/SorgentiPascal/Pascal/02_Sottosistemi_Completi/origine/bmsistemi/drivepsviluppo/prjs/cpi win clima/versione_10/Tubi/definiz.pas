
unit definiz;


interface
{uses defuti,dos}
uses sysutils
    {$IFDEF Versione_14}
    ,varcarichi,graphics   
   {$endif};
var driveprog,drivearc,nomecommessa,driveplt,drivearia,drivecart,retecor:string;
    aprtemp:real;
    const TrTubi=1;
          TrCanali=2;
Var  Tipo_rete:integer;
{$IFDEF Versione_14}
var Un_errore:boolean=false;
    CalcUnaRete,CalcUnPiano:string;
    TestRete:boolean;
    cisono_collettori:boolean;
{$else}
{$I typedef}
{$endif}
{$I m_dtubivar}



Procedure Set_Tipo_rete(Descr:string);
Procedure DebugL3d(ind:integer);

implementation

Procedure DebugL3d(ind:integer);
begin
if debug3d_on then
with dis^[ind]^ do
debugLinea3d(x1,y1,z1,x2,y2,z2);
end;
Procedure Set_Tipo_rete(Descr:string);
begin
 descr:=uppercase(descr);
 if descr='TUBAZIONI'then Tipo_rete:=TrTubi else
 if descr='CANALI'then Tipo_rete:=TrCanali;
end;

end.