unit Funzudbt;

interface
uses dbtablesQ,dbtables;
Var TxtOut:textfile;
    datacor:string;
    {$Ifdef bdenew}
    tttemp:TTableQ;
    {$else}
    tttemp:TTable;
    {$endif}

Procedure Writecampo(valore:string);
implementation
Procedure Writecampo(valore:string);
  begin
  writeln(TxtOut,Valore);
  end;
end.

