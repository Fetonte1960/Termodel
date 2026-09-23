unit UMessaggiCarichi;

interface

uses {$IFDEF L10}Uvariabili,{$ENDIF} UFileLog, VariabiliGenerali,stdctrls,varcarichi;

Procedure Echo(mess:String);
procedure Writerror(mess,head:st80);
Procedure Canc_mess;
Procedure Init_Mess(boxmes:Tmemo);

implementation
{$IFDEF Versione_14}
Var Memoecho:Tmemo=nil;
    ListBox_VerCor:Tlistbox=nil;

Procedure Init_Mess(boxmes:Tmemo);
begin
memoecho:=boxmes;
end;
Procedure Echo(mess:String);
begin
if calcolo_estivo then memoecho.Lines.Add(mess);
//else ScriviLog(mess);
end;
Procedure Canc_mess;
begin
if calcolo_estivo then memoecho.Clear
else
if ListBox_VerCor<>nil then ListBox_VerCor.Clear;
end;

{$Else} //versione_14
{$IFDEF L10}
Uses {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}UFormL10 {$ELSE} UProvaL10 {$IFEND};
{$ELSE}
Uses MainForm;
{$ENDIF}

Procedure Canc_mess;
begin
{$IFDEF L10}
 if FCalcL10 <> nil then
  {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
    FCalcL10.ListBox_VerCor.Clear;
  {$ELSE}
    FCalcL10.memo1.clear;
  {$IFEND}
{$ELSE}
 FMainEstivo.memo1.clear;
{$ENDIF}
end;

Procedure Echo(mess:String);
begin
{$IFDEF L10}
  {$IF Defined(VERSIONE_12)}
   if FCalcL10 <> nil then
      FCalcL10.ListBox_VerCor.Items.Add('E:' + mess);
  {$ELSEIF Defined(VERSIONE_13)}
    ScriviLog(mess);
  {$ELSE}
   FCalcL10.memo1.Lines.Add(mess)
  {$IFEND}
{$ELSE}
 FMainEstivo.memo1.Lines.Add(mess)
{$ENDIF}
end;
{$ENDIF} //versione_14

procedure Writerror(mess,head:st80);
begin
 {$IFDEF L10}
  errore := true;
 {$ENDIF}
 {writeln(ferrori,mess+'#'+head);}
 echo(mess+','+head);
end;

end.
