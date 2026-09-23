unit utiwindlg;
interface
uses OWindows, ODialogs, WinTypes, WinProcs, Strings,validate ;

  type
  pstatico=^tstatico;
  tstatico =object(tedit)
  constructor initresource(Aparent:pwindowsobject;Aid:integer;atextlength:integer);
  function Transfer(DataPtr: Pointer; TransferFlag: Word): Word; virtual;
  end;
  type Tdato=record
                s:string;
            end;
  var dlg_posx,dlg_posy:integer;
      var dato:tdato;
  type
  Pdialogo=^tdialogo;
  tdialogo=object(tdlgwindow)
  constructor Init(AParent:Pwindowsobject; AName:pchar);
  procedure wminitdialog(var msg:Tmessage); virtual wm_first+wm_initdialog;
  end;
implementation

constructor tstatico.initresource(Aparent:pwindowsobject;Aid:integer;atextlength:integer);
begin
  inherited Initresource(AParent, Aid,atextlength);
end;

function Tstatico.Transfer(DataPtr: Pointer; TransferFlag: Word): Word;
var
  ValCode: Integer;
  Text: {array[0..15] of Char}pchar;
begin
  case TransferFlag of
    tf_GetData:
      begin
        GetText(Text, SizeOf(Text));
      end;
    tf_SetData:
      begin
        SetText(Text);
      end;
  end;
  Transfer := SizeOf(text);
end;


constructor tdialogo.init(AParent:Pwindowsobject; AName:pchar);
  var p:pwindowsobject;
begin
  inherited Init(AParent, AName);

  transferbuffer:=@dato;
  p:=new(pstatico,initresource(@self,200,30));
  {New(messaggio,Init(@self,100,'miostatic',1,1,200,30,80));}
  {Messaggio^.clear;}
  {Messaggio^.settext('Messaggio');}
  {Transferdata(tf_setdata)};
end;
procedure Tdialogo.wminitdialog(var msg:Tmessage);
var R:trect;
begin
 inherited wminitdialog(msg);
 getwindowrect(msg.receiver,R);
 movewindow(msg.receiver,Dlg_POSX,dlg_POSY,r.right-r.left,r.bottom-r.top,false);
end;

end.