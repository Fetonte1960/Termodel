unit GestUdb;

interface
uses udb,udbT,funzudbt,DbTablesQ,dbtables,controls,stdctrls,db,sysutils;
Procedure InitUdBT(Path,PathA:string);
Procedure NuovoUdBT;
Procedure OpenUdBT;
Procedure closeUdBT;
Procedure SaveUdBT(Path:string);
Procedure Compilaform_auto(var form:Tcontrol);
implementation
uses ucompilaform,libreriagenerale;
Function Data_source(nomet:string):Tdatasource;
Var i:integer;
begin
 i:=1;
  while (i< dmtutti.ComponentCount)and
        (not((dmtutti.Components[i-1] is TDatasource)and
         (uppercase(((dmtutti.Components[i-1] as TDatasource).DataSet as TTable).TableName)=nomet+'.DB'))
        )do inc(i);
  result:=dmtutti.Components[i-1] as Tdatasource;
end;
Procedure Compilaform_auto(var form:Tcontrol);
Var i:integer;
    nometab,ss:string;
begin
for i:=1 to form.ComponentCount do
if form.Components[i-1] is TGroupbox then
  begin
  ss:=(form.Components[i-1] as TGroupbox).Caption;
  if ss<>'' then
  if ss[1]='§' then
    begin
    azzeraidentif;
    nometab:=leggiidentif1(ss);
    nometab:=uppercase(copy (nometab,2,length(nometab)-1));
    (form.Components[i-1] as TGroupbox).Caption:=leggiidentif1(ss);
    compilaform(form.Components[i-1] as TGroupbox,nometab,data_Source(nometab));
    end;

  end
end;
Procedure InitUdBT(Path,PathA:string);
Var I:integer;
begin
DMTutti:=TdmTutti.Create(Nil);
DMTutti.ComDB(init,path,PathA);
{$Ifdef BDENEW}
TTTemp:=TTableq.Create(nil);
{$ELSE}
TTTemp:=TTable.Create(nil);
{$ENDIF}
Tabt:=true;
Tab0:=false;
end;
Procedure NuovoUdBT;
begin
DMTutti.ComDB(nuovo,'','');
end;
Procedure OpenUdBT;
begin
DMTutti.ComDB(apri,'','');
end;
Procedure closeUdBT;
begin
DMTutti.ComDB(chiudi,'','');
end;
Procedure SaveUdBT(Path:string);
begin
assignfile(txtout ,path);
rewrite(txtout);
{$I Data}
writeCampo('Versione database ' + datacor);
DMTutti.ComDB(salva,'','');
writeCampo('#ENDFILE#');
closefile(txtout);
end;
end.
