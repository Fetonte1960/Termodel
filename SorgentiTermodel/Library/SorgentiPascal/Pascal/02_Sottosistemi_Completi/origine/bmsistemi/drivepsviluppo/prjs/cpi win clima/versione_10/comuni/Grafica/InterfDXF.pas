unit InterfDXF;

interface
uses sysutils,libreriagenerale
{$Ifdef Tubi}
,definiz,udb,udatalink
{$Else}
,UVariabililettura
{$Endif}
;
Procedure ScriviInterfDXF;

implementation
{$Ifdef Tubi}
Procedure ScriviInterfDXF;
//const maxsot=50;
//{$I M_Daticad}
type Datilink=record
              tipo:char;
              cod,descr,piano:string[50];
              x,y,z,ang:real;
              end;

Var Buf:CadRec;
    FHT:File of CadRec;
    BufT:RecGTerm;
    FHTT:File of RecGTerm;
    BufO:DatiLink;
    FHTO:File of DatiLink;
    Nomefile,perc,lay,nomerete: String;
    sr:Tsearchrec;
    trovato:integer;
    i:Integer;
begin
assign(Fht, IncludeTrailingPathDelimiter(percorsodrive) + 'intdxf.rtt');
rewrite(Fht);
for i:=1 to ultriga do
write(fht,dis^[i]^);
close(Fht);

assign(FhtO, IncludeTrailingPathDelimiter(percorsodrive) + 'intdxf.lkk');
rewrite(FhtO);
with dm1.TT1 do
  begin
  first;
  while not eof do
    begin
    bufO.tipo:='I';
    bufO.cod:=V_Recgen.Codice;
    bufO.Descr:=V_Recgen.Progetto;
    bufO.Piano:=V_Recgen.piano;
    bufO.X:=V_Recgen.Xori;
    bufO.y:=V_Recgen.yori;
    bufO.z:=V_Recgen.zori;
    //V_Recgen.set_zori(zorig);
    //V_Recgen.Set_dps(dps);
    //V_Recgen.Set_maxvels(maxvels);
    //V_Recgen.Set_dpe(dpe);
    //V_Recgen.Set_maxvele(maxvele);
    //V_Recgen.Set_Piano(Piano);
    //V_Recgen.Set_Angolo(Angolo);
    //V_Recgen.Set_Spec(Spec) ;
    write(FHTO,bufO);
    next;
    end;
  end;
close(FhtO);
end;
{$Else}
Procedure ScriviInterfDXF;
Var Buf:front;
    FHT:File of front;
    i:integer;
begin
assign(Fht, IncludeTrailingPathDelimiter(percorsodrive) + Pianocor + '.Fxf');
rewrite(Fht);
for i:=1 to ultft do
write(fht,ft^[i]);
close(fht);
end;
{$Endif}

end.
