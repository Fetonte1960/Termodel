unit utiwindlg;
interface
uses OWindows, ODialogs, WinTypes, WinProcs, Strings,validate ;

  type
  pstatico=^tstatico;
  tstatico =object(tstatic)
  constructor initresource(Aparent:pwindowsobject;Aid:integer;atextlength:integer);
  function Transfer(DataPtr: Pointer; TransferFlag: Word): Word; virtual;
  end;
  VAR MSGhandle:hwnd;
      dato:string;
implementation

constructor tstatico.initresource(Aparent:pwindowsobject;Aid:integer;atextlength:integer);
begin
  inherited Initresource(AParent, Aid,atextlength);
end;

function Tstatico.Transfer(DataPtr: Pointer; TransferFlag: Word): Word;
var
  ValCode: Integer;
  Testo:pchar{string};
begin
  case TransferFlag of
    tf_GetData:
      begin
        GetText(Testo, SizeOf(Text));
        string(DataPtr^):=strpas(Testo);
      end;
    tf_SetData:
      begin
        testo:=strPcopy('',string(dataPtr^));
        SetText(testo);
      end;
  end;
  Transfer := SizeOf(string);
end;
end.