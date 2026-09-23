
unit utiwin;
interface
uses OWindows, ODialogs, WinTypes, WinProcs, Strings,validate,defuti;


procedure W_UsaMaskera(Var dato;NomeFile:st80);
procedure W_IOTabella(var dato;NDat,DatP,DatR:integer;mask:st80);
Procedure modalmask (var dato;NomeFile:st80;var code:integer);
procedure notok;
procedure notcl;
procedure generica;far;
function Exist(Nome:st80):boolean;

function Conferma(Nome,Aggiunta:st80;i:integer):boolean;
function UpString(St:st126):st126;
function eliminadir(dir:string):string;
procedure aggtab;
var campoprec:integer;
    transfer1,transfdeb:word;
Implementation

type rechlp= record
             lungdescr:integer;
             lungval:integer;
             descr:string[60];
             val  :string[18];
             end;
var
    base,offset:word;
    ofsin:longint;
    BaseTab,ofsetTab:word;
    Dofs,Rofs,ncampi:integer;
    nomemask:string;
    NDatg,DatPg,DatRg:integer;
    hlp:rechlp;
    fh:file of rechlp;
    nomemaskhlp:string;
    static:pstatic;
    pg:integer;
    ft:text;

type

  PVAL=^TVAL;
  TVAL=OBJECT(TVALIDATOR)
  min,max:real;
  tipo:char;
  pint,pdec:integer;
  isstringa:boolean;
  Constructor init (amin,amax:real;atipo:char;apint,apdec:integer;stringa:boolean);
  function isvalidINPUT(VAR s:string;b:boolean):boolean;virtual;
  function transfer(var s:string;buffer:pointer;flag:tvtransfer):word;virtual;
  end;


  PFieldEdit = ^TfieldEdit;
  TfieldEdit = object(TEdit)
    MinValue, MaxValue: real;
    Tipo:char;
    pint,pdec,Lcampo,lcampocorr:integer;

    constructor InitResource(AParent: PWindowsObject; ResourceID: Word;
                             Digits: Word; AMinValue, AMaxValue:real;
                             Atipo:char;Apint,Apdec:integer;isstr:boolean);
    procedure wmkeydown(var msg:tmessage); virtual wm_first+wm_keydown;
    function setselection(startpos,Endpos:integer):boolean ; virtual;
    function Getselection(Var startpos,Endpos:integer):boolean ; virtual;
    procedure wmkillfocus(var msg:tmessage);virtual wm_first+wm_killfocus;
  end;
  PFieldEditTab=^TFieldEditTab;
  TFieldEditTab= object (TFieldEdit)
    constructor InitResource(AParent: PWindowsObject; ResourceID: Word;
                             Digits: Word; AMinValue, AMaxValue:real;
                             Atipo:char;Apint,Apdec:integer;isstr:boolean);
    procedure wmkeydown(var msg:tmessage); virtual wm_first+wm_keydown;
    procedure wmlbuttondblclk(var msg:tmessage); virtual wm_first+wm_lbuttondblclk;
  end;


  Pdialogo=^tdialogo;
  tdialogo=object(tdialog)
  nomesfondo:pchar;
  constructor Init(AParent:Pwindowsobject; AName:pchar;var dato);
  function  canclose:boolean;virtual;
  procedure ok(var mes:Tmessage); virtual id_first + id_ok;
  procedure transferdata(direction:word);virtual;
  procedure tastoF1; virtual id_first+11;
  procedure tastoF2; virtual id_first+12;
  procedure tastoF3; virtual id_first+13;
  procedure tastoF4; virtual id_first+14;
  procedure tastoF5; virtual id_first+15;
  procedure tastoF6; virtual id_first+16;
  procedure tastoF7; virtual id_first+17;
  procedure tastoF8; virtual id_first+18;
  procedure tastoF9; virtual id_first+19;
  procedure tastoF10; virtual id_first+20;

  function  wmerasebkgnd(var msg:Tmessage):boolean; virtual wm_first+wm_erasebkgnd;
  procedure wminitdialog(var msg:Tmessage); virtual wm_first+wm_initdialog;
  end;

  PdialogoTab=^tdialogotab;
  TdialogoTab=object(tdialogo)
  constructor init(AParent:Pwindowsobject; AName:pchar;var dato);
  procedure tastoF1; virtual id_first+11;
  procedure tastoF2; virtual id_first+12;
  procedure tastoF3; virtual id_first+13;
(*  procedure tastoF4; virtual id_first+14;*)
  procedure tastoF5; virtual id_first+15;
  procedure tastoF6; virtual id_first+16;
(*  procedure tastoF7; virtual id_first+17;
  procedure tastoF8; virtual id_first+18;
  procedure tastoF9; virtual id_first+19;
  procedure tastoF10; virtual id_first+20; *)

  Procedure TastoPgUp; virtual Id_first+22;
  Procedure TastoPgDn; virtual Id_first+23;
  function canclose:boolean;virtual;
  end;

  pdialmod=^tdialmod;
  tdialmod=object(tdialogo)
  procedure ok(var msg:Tmessage);virtual id_first+id_ok;
  end;

  ppopup=^tpopup;
  tpopup=object(tdialog)
  lista:plistbox;
  x,y,h,w,nmessaggi,campo:integer;
  messaggio: array[1..100] of array[0..70] of char;
         constructor init(aparent:pwindowsobject;atitle:pchar;ax,ay,aw,ah,acampo:integer);
         procedure wminitdialog(var msg:Tmessage); virtual wm_first+wm_initdialog;
         procedure setupwindow; virtual;
         procedure HandleListBoxMsg(var Msg: TMessage);virtual id_First + 10100;
  end;

var
    dialog:pdialogo;
    DialogTab:PdialogoTab;
    popup:ppopup;
    dialmod:pdialmod;
    testodihelp:string;
    campocorrente,camposel:integer;

constructor tpopup.init(aparent:pwindowsobject;atitle:pchar;ax,ay,aw,ah,acampo:integer);
begin
  x:=ax;
  y:=ay;
  h:=ah;
  w:=aw;
  campo:=acampo;
  inherited init(aparent,atitle);
  lista:=new(plistbox,init(@self,10100,5,5,w,h));

end;

procedure tpopup.setupwindow;
var i:integer;
begin
  inherited SetupWindow;
  for i:=1 to nmessaggi do lista^.addstring(messaggio[i])
end;

procedure Tpopup.wminitdialog(var msg:Tmessage);
var R:trect;
begin
 inherited wminitdialog(msg);
 movewindow(msg.receiver,X-5,Y-5,w+20,h+17,false);
end;
procedure Tpopup.HandleListBoxMsg(var Msg: TMessage);
var
  Idx: Integer;
  ItemText: array[0..70] of Char;
  st:string;
begin
  if Msg.LParamHi = lbn_SelChange then
  begin
    Idx := Lista^.GetSelIndex;
    if lista^.GetStringLen(Idx) < SizeOf(ItemText) then
    begin
      if dialog<>nil then dialog^.transferdata(Tf_getdata) else
         dialogtab^.transferdata(Tf_getdata) ;
      lista^.GetSelString(ItemText, 70);
      enddlg(id_ok);
      testodihelp:=strpas(itemtext);
      testodihelp:=copy(testodihelp,hlp.lungdescr+2,hlp.lungval);
      if dialog<>nil then setfocus(dialog^.getitemhandle(campo))
      else setfocus(dialogTab^.getitemhandle(campo));
      camposel:=campo;
      campocorrente:=101;
      if dialog<>nil then dialog^.transferdata(Tf_setdata) else
         dialogtab^.transferdata(Tf_setdata) ;
    end;
  end
  else DefWndProc(Msg);
end;
constructor tval.init(amin,amax:real;atipo:char;apint,apdec:integer;stringa:boolean);
begin
  tvalidator.init;
  isstringa:=stringa;
  min:=amin;
  max:=amax;
  tipo:=atipo;
  pint:=apint;
  pdec:=apdec;
end;

procedure tdialmod.ok(var msg:Tmessage);
begin
  transferdata(tf_getdata);
  procarr[12];
  enddlg(id_ok);
end;
function tval.isvalidinput(var s:string;b:boolean):boolean;
var
  Valid1: Boolean;
  ValCode: Integer;
  Value: real;
  const
  CharSet = ['a'..'z','A'..'Z',' ','.','0'..'9','\'];
var
  I, Len: Integer;
  Msg: array[0..63] of Char;
  testo:string;
begin
  if not isstringa then
  begin
    VALID1:=TRUE;
    Val(s, Value, ValCode);
    Valid1:= (ValCode = 0) and
      (Value >= Min) and (Value <= Max);
    if not Valid1 then
    begin
      messagebeep(10);
    end;
    isvalidinput := Valid1;
   end
   else
   begin
      valid1:=true;
      len:=length(s);
      i:=1;
      while i<len  do
      begin
        Valid1 := s[i] in CharSet;
        Inc(I);
      end;
      if not Valid1 then
      begin
       Messagebeep(10);
      end;
      isvalidinput:=valid1;
    end;
end;
function tval.transfer(var s:string;buffer:pointer;flag:tvtransfer):word;
var
  ValCode: Integer;
  seg_m,ofs_m:word;
  st:string;
begin
seg_m:=seg(buffer^);
ofs_m:=ofs(Buffer^);
ofs_m:=ofs_m+(ofsetTab-ofsin);
Buffer:=Ptr(seg_m,ofs_m);
  case flag
   of vtGetData:
      begin
        case tipo of
          'I':begin
                Val(s, integer(buffer^), ValCode);
              end;
          'R':begin
                Val(s, real(buffer^), ValCode);
              end;
          '$': begin
               case tabella[campocorrente-100].L of
               255:st255(buffer^):=s;
               240:st240(buffer^):=s;
               26 :st126(buffer^):=s;
               80 :st80 (buffer^):=s;
               70 :st70 (buffer^):=s;
               60 :st60 (buffer^):=s;
               50 :st50 (buffer^):=s;
               35 :st35 (buffer^):=s;
               30 :st30 (buffer^):=s;
               25 :st25 (buffer^):=s;
               18 :st18 (buffer^):=s;
               15 :st15 (buffer^):=s;
               11 :st11 (buffer^):=s;
               10 :st10 (buffer^):=s;
               8  :st8  (buffer^):=s;
               6  :st6  (buffer^):=s;
               5  :st5  (buffer^):=s;
               4  :st4  (buffer^):=s;
               3  :st3  (buffer^):=s;
               2  :st2  (buffer^):=s;
               1  :st1  (buffer^):=s;
               40 :st40 (buffer^):=s;
               20 :st20 (buffer^):=s;
           end;
           end;
        end;
      end;
   vtSetData:
      begin
        case tipo of
          'I':Str(integer(buffer^), s);
          'R':Str(real(buffer^):pint:pdec, s);
          '$':case tabella[campocorrente-100].L of
               255:s:=st255(buffer^);
               240:s:=st240(buffer^);
               26 :s:=st126(buffer^);
               80 :s:=st80 (buffer^);
               70 :s:=st70 (buffer^);
               60 :s:=st60 (buffer^);
               50 :s:=st50 (buffer^);
               35 :s:=st35 (buffer^);
               30 :s:=st30 (buffer^);
               25 :s:=st25 (buffer^);
               18 :s:=st18 (buffer^);
               15 :s:=st15 (buffer^);
               11 :s:=st11 (buffer^);
               10 :s:=st10 (buffer^);
               8  :s:=st8  (buffer^);
               6  :s:=st6  (buffer^);
               5  :s:=st5  (buffer^);
               4  :s:=st4  (buffer^);
               3  :s:=st3  (buffer^);
               2  :s:=st2  (buffer^);
               1  :s:=st1  (buffer^);
               40 :s:=st40 (buffer^);
               20 :s:=st20 (buffer^);
            end;
        end;

      if (testodihelp>'') and(camposel=campocorrente) then s:=testodihelp;

      end;
  end;
  case tipo of
    'I':begin
          Transfer := SizeOf(integer);
        end;
    'R':Transfer := SizeOf(real);
    '$':case tabella[campocorrente-100].L of
               255:transfer:=sizeof( st255 );
               240:transfer:=sizeof( st240 );
               26 :transfer:=sizeof( st126 );
               80 :transfer:=sizeof( st80 );
               70 :transfer:=sizeof( st70 );
               60 :transfer:=sizeof( st60 );
               50 :transfer:=sizeof( st50 );
               35 :transfer:=sizeof( st35 );
               30 :transfer:=sizeof( st30 );
               25 :transfer:=sizeof( st25 );
               18 :transfer:=sizeof( st18 );
               15 :transfer:=sizeof( st15 );
               11 :transfer:=sizeof( st11 );
               10 :transfer:=sizeof( st10 );
               8  :transfer:=sizeof( st8  );
               6  :transfer:=sizeof( st6  );
               5  :transfer:=sizeof( st5  );
               4  :transfer:=sizeof( st4  );
               3  :transfer:=sizeof( st3  );
               2  :transfer:=sizeof( st2  );
               1  :transfer:=sizeof( st1  );
               40 :transfer:=sizeof( st40 );
               20 :transfer:=sizeof( st20 );
            end;
            end;
  campocorrente:=campocorrente+1;
end;


constructor TFieldEdit.InitResource(AParent: PWindowsObject;
  ResourceID: Word; Digits: Word; AMinValue, AMaxValue: real;Atipo:char;Apint,Apdec:integer;isstr:boolean);
begin
  TEdit.InitResource(AParent, ResourceID, Digits + 1);
  MinValue := AMinValue;
  MaxValue := AMaxValue;
  tipo:=atipo;
  pint:=apint;
  pdec:=apdec;
  Lcampo:=digits+1;
  validator:=new(pval,init(aminvalue,amaxvalue,atipo,apint,apdec,isstr));
end;

Function TfieldEdit.setselection(startpos,endpos:integer):boolean;
begin
  startpos:=0;
  endpos:=lcampo;
  inherited setselection(startpos,endpos);
  setselection:=true;
end;
Function TfieldEdit.Getselection(var startpos,endpos:integer):boolean;
begin
  inherited getselection(startpos,endpos);
  lcampocorr:=endpos;
  getselection:=true;
end;
procedure tfieldedit.wmkillfocus(var msg:tmessage);
var st:string[3];
    pc:array[0..3] of char;
begin
campoprec:=getid;
defwndproc(msg);
end;


procedure tfieldEdit.wmkeydown(var msg:tmessage);
var st,st1:string;
    i,id,campo:integer;

procedure tastoins;
begin
  if exist(nomemaskhlp+'.L'+st) then
  begin
    assign(fh,nomemaskhlp+'.L'+st);
    reset(fh);
    read(fh,hlp);
    close(fh);
  end;
  popup:=new(ppopup,init(@self,'popup',150,100,(hlp.lungdescr+hlp.lungval)*8,165,campo+100));
  popup^.nmessaggi:=0;
  str(campo,st);
  if exist(nomemaskhlp+'.L'+st) then
  begin
    assign(fh,nomemaskhlp+'.L'+st);
    reset(fh);
    while not eof(fh) do
    with popup^ do
    begin
    nmessaggi:=nmessaggi+1;
    read(fh,hlp);
    strpCopy(messaggio[nmessaggi],hlp.descr+hlp.val);
  end;
  application^.execdialog(popup);
  end;
end;

begin
  id:=getid;
  campo:=id-100;
  str(msg.wparam,st);
  {messagebox(0,strpcopy('',st),'',0);}
  case MSG.wparam of

  39:begin {freccia a destra}
       getselection(i,lcampocorr);
       if lcampocorr>lcampo-2 then
       begin
         if campo<datrg*datpg then
         begin
           campo:=campo+1;
           SETFOCUS(DialogTab^.GETItemHANDLE(Campo+100));
         end
         else messagebeep(10);
       end
       {else};
     end;
  37:begin {freccia a sinistra}
       getselection(i,lcampocorr);
       if lcampocorr=0 then
       begin
         if campo>1 then
         begin
           campo:=campo-1;
           SETFOCUS(DialogTab^.GETItemHANDLE(Campo+100));
         end
         else messagebeep(10);
       end
       {else};
     end;

  45:begin
       tastoins;
      end
      else defwndproc(msg);
    END;


end;

constructor TFieldEditTab.InitResource(AParent: PWindowsObject;ResourceID: Word;
                               Digits: Word; AMinValue, AMaxValue: real;
                               Atipo:char;Apint,Apdec:integer;isstr:boolean);
begin
inherited InitResource(AParent,ResourceID,Digits,AMinValue,AMaxValue,
                       Atipo,Apint,Apdec,isstr);
end;


procedure tfieldedittab.wmlbuttondblclk(var msg:tmessage);
var st:string;
begin
  setfocus(getid);
  campoprec:=getid;
  dialogtab^.tastof3;
end;

procedure pagdn;
var st:string[6];
    pag:array[0..6] of char;
begin
  if numerolineatabella  < NDatg-DatPg then
     begin
       numerolineatabella:=numerolineatabella+DatPg;
       dialogtab^.transferdata(tf_Getdata);
       OfsetTab:=OfsetTab+DOfs;
       if pg < ndatg then pg:=pg+1;
       str(pg,st);
       st:='Pag:'+st;
       strpcopy(pag,st);
       static^.settext(pag);
       dialogtab^.transferdata(tf_setdata);
     end
     else messagebeep(10);
     SETFOCUS(DialogTab^.GETItemHANDLE(101));
end;
procedure pagup;
var st:string[6];
    pag:array[0..6] of char;
begin
  if numerolineatabella > datPg then
     begin
       numerolineatabella:=numerolineatabella-DatPg;
       dialogtab^.transferdata(tf_Getdata);
       OfsetTab:=OfsetTab-DOfs;
       if pg>1 then pg:=pg-1 else pg:=1;
       str(pg,st);
       st:='Pag:'+st;
       strpcopy(pag,st);
       static^.settext(pag);
       dialogtab^.transferdata(tf_setdata);
     end
     else messagebeep(10);
     SETFOCUS(DialogTab^.GETItemHANDLE(101));
end;


procedure tfieldEditTab.wmkeydown(var msg:tmessage);
var st,st1:string;
    Campo,iD:integer;
begin
  inherited wmkeydown(msg);
  id:=getid;
  campo:=id-100;
  CASE MSG.wPARAM OF
  33:begin{pagUp}
       pagUp;
     end;
  34:begin{pagDn}
       PagDn;
     end;
  38:Begin
        if campo > DatRg then
        begin
           campo:=campo-DatRg;
           SETFOCUS(DialogTab^.GETItemHANDLE(Campo+100));
        end
        else PagUp;
     end;
  40:Begin
       if campo <= (DatPg-1)*DatRg then
       begin
         campo:=campo+DatRg;
         SETFOCUS(DialogTab^.GETItemHANDLE(Campo+100));
       end
       else PagDn;
     end;
 114:begin
        campoprec:=getid;
        dialogtab^.tastof3
     end;
 116:begin
        messagebox(0,'tastof5','',0);
      end;
     else defwndproc(msg);

  END
end;








{Usamaskera}

Procedure initTab;
var i:integer;
begin
  for i:= 1 to maxcampi do
  with tabella[i] do
  begin
   tipo:=' ';
   cifredec:=0;
   cifreint:=0;
   l:=0;
  end;
end;

Procedure LeggiMask;

CONST
      x='¥';
      inf='¨';
Var
    f:text;
    I,j,k:INTEGER;
    ch:char;
    variabile:String[240];
    flag1:integer;
    st:string;
begin
  assign(f,nomemask);
  reset(f);
  I:=0;
  while not(eof(f)) do
  begin
     read(f,ch);
     if (ch) = x then
     begin
       I:=I+1;
       with Tabella[I] do
       begin
         read(f,Tipo);
         variabile:='';
         repeat
           read(f,ch);
           if ch in ['0'..'9'] then variabile:=variabile+ch;
         until not(ch in['0'..'9']);
         flag1:=0;
         val(variabile,L,flag1);
         if (flag1 <> 0) or (length(variabile) = 0) then L:=0;
         if ch = ':' then
         begin
           variabile:='';
           repeat
             read(f,ch);
             if ch in ['0'..'9'] then variabile:=variabile+ch;
           until not(ch in['0'..'9']);
           flag1:=0;
           val(variabile,CifreDec,flag1);
           if (flag1 <> 0) or (length(variabile) = 0) then CifreDec:=0;
         end;

         BAddr:=Base;OAddr:=OffSet;
         case Tipo of
         'I','i':
         begin
           CifreInt:=L;
           OffSet:=OffSet+2;
         end;
         'R','r':
         begin
         if L > 0 then L:=L+1;
           OffSet:=OffSet+6;
           CifreInt:=L;
         end;
         '$','s':
         begin
           OffSet:=OffSet+L+1;
         end;
         'C','c':
         begin
           OffSet:=OffSet+L;
         end;
         end;
       end;
     end;
   end;
   close(f);
   ncampi:=i;
   ultimocampo:=i;
end;

constructor tdialogo.init(AParent:Pwindowsobject; AName:pchar;var dato);




var p:pwindowsobject;
    p1:pcombobox;
    st1:string;
    i:integer;
    st:string;
begin
  campoprec:=101;
  testodihelp:='';
  nomemaskhlp:=eliminadir(strpas(aname));
  nomemask:=strpas(aname)+'.rc';
  st:=eliminadir(strpas(aname));
  Aname:=strPcopy('',st);
  inherited Init(AParent, AName);
  InitTab;
  ncampi:=0;
  transferbuffer:=@dato;
  LeggiMask;
  for i:=1 to ncampi do
  with tabella[i] do
  case tipo of
     'R','I'    :p :=new(pfieldedit,initresource(@self,100+i,L,0,999999,tipo,L,cifredec,false));
     '$'        :p :=new(pfieldedit,initresource(@self,100+i,L+1,0,999999,tipo,L+1,cifredec,true));
     'r','i','s':p1:=new(pcombobox,initresource(@self,100+i,L+1));
   end;
   nomesfondo:=aname;
 end;
procedure tdialogo.transferdata(Direction:word);
begin
  campocorrente:=101;
  transfer1:=0;
  transfdeb:=0;
  inherited transferdata(direction);
end;

procedure tdialogo.tastof1;
begin
  procarr[1];
end;
procedure tdialogo.tastof2;
begin
  procarr[2];
end;
procedure tdialogo.tastof3;
begin

  procarr[3];
end;
procedure tdialogo.tastof4;
begin
  procarr[4];
end;
procedure tdialogo.tastof5;
begin
  procarr[5];
end;
procedure tdialogo.tastof6;
begin
  procarr[6];
end;
procedure tdialogo.tastof7;
begin
  procarr[7];
end;
procedure tdialogo.tastof8;
begin
  procarr[8];
end;
procedure tdialogo.tastof9;
begin
  procarr[9];
end;
procedure tdialogo.tastof10;
begin
  procarr[10];
end;

function tdialogo.canclose:boolean;
begin
  canclose:=cancl;
end;
procedure tdialogo.ok(var mes:tmessage);
begin
  transferdata(tf_getdata);
  procarr[12];
  enddlg(id_ok);
  show(sw_hide);
end;
function tdialogo.wmerasebkgnd(var msg:Tmessage):boolean;

procedure sfondomask(nome:pchar);
var
  BM: HBitmap;
  Ps: TPaintStruct;
  DC, MemDC: HDC;
  BitInfo: TBitmap;
begin
  DC := BeginPaint(msg.receiver,Ps);
  MemDC := CreateCompatibleDC(DC);
  BM := LoadBitmap(HInstance, nome);
  GetObject(BM, SizeOf(BitInfo), @BitInfo);
  BM := SelectObject(MemDC, BM);   { swap BMs}
  BitBlt(DC,0,0, BitInfo.bmWidth, BitInfo.bmHeight,
         MemDC, 0, 0, SrcCopy);
  DeleteObject(SelectObject(MemDC, BM));
  DeleteDC(MemDC);
  EndPaint(msg.receiver,Ps);
end;
begin
  sfondomask(nomesfondo);
  wmerasebkgnd:=true;
end;
procedure Tdialogo.wminitdialog(var msg:Tmessage);
var R:trect;
begin
 inherited wminitdialog(msg);
 getwindowrect(msg.receiver,R);
 movewindow(msg.receiver,POSX,POSY,r.right-r.left,r.bottom-r.top,false);
 {ULTFIN.X1:=POSX;
 ULTFIN.Y1:=POSY;
 ULTFIN.X2:=R.RIGHT;
 ULTFIN.Y2:=R.BOTTOM;}
end;


constructor TdialogoTab.init(AParent:Pwindowsobject; AName:pchar;var dato);

var st:string;
function SpaceTab(InADDR:word):integer;
  var OfsAddr:word;i:integer;
  begin
     with Tabella[ULTIMOCAMPO] do
      begin
         OfsAddr:=OAddr-InADDR;
         case Tipo of
          '$','s':OfsAddr:=OfsAddr+L+1;
          'C','c':OfsAddr:=OfsAddr+L;
          'R','r':OfsAddr:=OfsAddr+6;
          'I','i':OfsAddr:=OfsAddr+2;
         end;
      end;
     SpaceTab:=OfsAddr;
  end;

var p:array[1..400] of pwindowsobject;
    i:integer;
begin
  nomemaskhlp:=eliminadir(strpas(aname));
  campocorrente:=101;
  testodihelp:='';
  nomemask:=strpas(aname)+'.rc';
  st:=eliminadir(strpas(aname));
  Aname:=strPcopy('',st);
  Tdialog.Init(AParent, AName);
  InitTab;
  ncampi:=0;
  transferbuffer:=@dato;
  LeggiMask;
  dofs:=spacetab(ofsetTab);
  ROFs:=DOfs div DatPg; {..spazio occupato da una riga..}
  for i:=1 to ncampi do
  with tabella[i] do

  case tipo of
     'R','I'    :begin
                   p[i]:=new(pfieldeditTab,initresource(@self,100+i,L,0,999999,tipo,L,cifredec,false));
                 end;
     '$'        :begin
                   p[i]:=new(pfieldeditTab,initresource(@self,100+i,L+1,0,999999,tipo,L+1,cifredec,true));
                 end;
    { 'r','i','s':}
   end;
   static:=new(pstatic,initresource(@self,201,8));
   static^.disabletransfer;
   nomesfondo:=aname;
 end;


Procedure Tdialogotab.tastof1 ;
begin
  numerolineatabella:=(campoprec-100) div datrg;
  if (campoprec-100) mod datrg <>0 then numerolineatabella:=numerolineatabella+1;
  dialogTab^.transferdata(tf_getdata);
  procarr[1];
end;
Procedure Tdialogotab.tastof2 ;
begin
  numerolineatabella:=(campoprec-100) div datrg;
  if (campoprec-100) mod datrg <>0 then numerolineatabella:=numerolineatabella+1;
  dialogTab^.transferdata(tf_getdata);
  procarr[2];
  dialogTab^.transferdata(tf_setdata);
end;

Procedure Tdialogotab.tastof3 ;
begin
  numerolineatabella:=(campoprec-100) div datrg;
  if (campoprec-100) mod datrg <>0 then numerolineatabella:=numerolineatabella+1;
  dialogTab^.transferdata(tf_getdata);
  procarr[3];
end;

Procedure Tdialogotab.tastof6 ;
var limite:integer;
begin
end;


Procedure Tdialogotab.tastof5 ;
var i,j,k,limite,lin:integer;
    pprec,psucc:pointer;
begin
  {
  Limite:=(NDatg-1);

  numerolineatabella:=(campoprec-100) div datrg;
  if (campoprec-100) mod datrg <>0 then numerolineatabella:=numerolineatabella+1;
  dialogTab^.transferdata(tf_getdata);

  lin:=numerolineatabella;
  ..cancellazione linea..
  for j:=Lin to Limite do
  begin
    for k:=0 to ROfs-1 do
    begin
      PPrec:=ptr(ISeg,IOfs+(j-1)*ROfs+k);
      PSucc:=ptr(ISeg,IOfs+j*ROfs+k);
      PPrec:=@PSucc;
    end;
  end;
  for k:=0 to ROfs-1 do
  begin
    PSucc:=ptr(ISeg,IOfs+Limite*ROfs+k);
    fillchar(PSucc,sizeof(psucc),0);{:=chr(0);
  end;
  transferdata(tf_setdata);
  setfocus(dialogtab^.getitemhandle(campoprec)); }
end;


Procedure Tdialogotab.tastopgup ;
begin
  pagUp;
end;

Procedure Tdialogotab.tastopgDn ;
begin
  pagDn;
end;

function tdialogotab.canclose:boolean;
begin
  inherited canclose;
end;








procedure W_UsaMaskera(var dato;NomeFile:st80);
var pc:array[0..80] of char;
begin
  strpcopy(pc,nomefile);
  Dialog := New(pdialogo, Init(pmainwindow,pc,dato));
  application^.makewindow(dialog);
  dialog^.show(sw_show);
end;

procedure modalmask(var dato;NomeFile:st80;var code:integer);
var pc:array[0..80] of char;
begin
  strpcopy(pc,nomefile);
  Dialmod := New(pdialmod, Init(pmainwindow,pc,dato));
  code:=application^.execdialog(dialmod);
end;

procedure W_IOTabella(var dato;NDat,DatP,DatR:integer;mask:st80);
var pc:array[0..80] of char;

begin
    assign(ft,'debug.txt');
    rewrite(ft);
    strpcopy(pc,mask);
    Base:=seg(dato);Offset:=ofs(dato);
    BaseTab:=base;ofsetTab:=offset;
    ofsin:=offset;
    numerolineatabella:=1;
    Pg:=1;
    NDatg:=Ndat;DatPg:=DatP;DatRg:=DatR;
    DialogTab := New(pdialogoTab, Init(pmainwindow,pc,dato));
    application^.makewindow(dialogTab);
           (*
                63:{..cancellazione linea..}
                   begin
                      Limite:=(NDat-1)-(i-1);
                      for j:=Lin to Limite do
                       begin
                          for k:=0 to ROfs-1 do
                           begin
                              PPrec:=ptr(ISeg,IOfs+(j-1)*ROfs+k);
                              PSucc:=ptr(ISeg,IOfs+j*ROfs+k);
                              PPrec^:=PSucc^;
                           end;
                       end;
                      for k:=0 to ROfs-1 do
                       begin
                          PSucc:=ptr(ISeg,IOfs+Limite*ROfs+k);
                          PSucc^:=chr(0);
                       end;

                      IWVal:=true; IWCampo :=true;
                   end;
                64:{..inserzione linea..}
                   begin
                      Limite:=(NDat-1)-(i-1);
                      for j:=Limite downto Lin do
                       begin
                          for k:=0 to ROfs-1 do
                           begin
                              PPrec:=ptr(ISeg,IOfs+(j-1)*ROfs+k);
                              PSucc:=ptr(ISeg,IOfs+j*ROfs+k);
                              PSucc^:=PPrec^;
                           end;
                       end;

                      for k:=0 to ROfs-1 do
                       begin
                          PSucc:=ptr(ISeg,IOfs+(Lin-1)*ROfs+k);
                          PSucc^:=chr(0);
                       end;

                      IWVal:=true;
                   end;


           end; { case } *)
    end;       {maskera}
 function Exist(Nome:st80):boolean;
 var f:file;
 begin
    exist:=false;
    {$I-} assign(f,Nome);reset(f);{$I+}
    if (ioresult=0) then
    begin
      close(f);
      Exist:=true
    end;
 end;
function Conferma(Nome,Aggiunta:st80;i:integer):boolean;
var f      : text;
    Riga   : string[80];
    riga1  : st80;
    pc     :array[0..80] of char;
    k      : integer;
    ch,ch1 : char;
begin
   {ssign(f,Nome);
   reset(f);}
   for k:=1 to i do readln(f,Riga1);
   close(f);
   Riga:=Riga1 + Aggiunta;
   messagebeep(10);
   strpcopy(pc,riga);
   conferma:=messagebox(0,pc,'',mb_yesnocancel)=idyes;
 end;
 function UpString(St:st126):st126;
 var c,i:integer;
 begin
    c := LENGTH(St);
    FOR i := 1 TO c DO
      St[i] := UPCASE(St[i]);
    UpString:=St;
 end;
function eliminadir(dir:string):string;
var i:integer;

begin
  eliminadir:=dir;
  for i:=1 to length(dir) do
  if dir[i]='\' then eliminadir:=copy(dir,i+1,length(dir))
end;
procedure aggtab;
begin
  dialogTab^.transferdata(tf_getdata);
  procarr[12];
  dialogTab^.transferdata(tf_setdata);
end;
procedure generica;
var st:string;
begin
end;
function cangen:boolean;far;
begin
cangen:=true;
end;

procedure notok;
begin
procarr[12]:=generica;
end;

procedure notcl;
begin
  cancl:=cangen;
end;

end
.