unit utiwin;
interface
uses OWindows, ODialogs, WinTypes, WinProcs, Strings,validate,defuti;

CONST Maxtasti=12;
type {st80=string[80];}
     tdatamodi= array[1..3]of array[1..10] of array[1..5] of real;
var modi:tdatamodi;
    posx,posy:integer;
    pmainwindow:pwindowsobject;


procedure UsaMaskera(Base,OffSet:word;NomeFile:st80;
                     var Campo,Chiave:integer;
                     CField,CText:integer;W,WVal,all,notzero:boolean;prarr:proc);

procedure IOTabella(ISeg,IOfs:word;NDat,DatP,DatR:integer;var Chiave,Riga,campo:integer;
                     mask:st80;SetNRighe,InitMask,IWVal,IWCampo:boolean;prarr:proc);

function Exist(Nome:st80):boolean;

function Conferma(Nome,Aggiunta:st80;i:integer):boolean;
 function UpString(St:st126):st126;
Implementation
{type campo= record
            tipo:char;
            l:integer;
          cifredec:integer;
          cifreint:integer;
          Oaddr,Baddr:word;
          end;
CONST maxcampi=400;
var
    ultimocampo,ncampi:INTEGER;
    tabella : array [1..maxcampi] of campo;}
var
    base,offset:word;
    ofsin:longint;
    BaseTab,ofsetTab:word;
    Dofs,Rofs,ncampi:integer;
    nomemask:string;
    NDatg,DatPg,DatRg:integer;
    PunDato:pointer;
    Linea:integer;

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
  end;

  PFieldEditTab=^TFieldEditTab;
  TFieldEditTab= object (TFieldEdit)
    constructor InitResource(AParent: PWindowsObject; ResourceID: Word;
                             Digits: Word; AMinValue, AMaxValue:real;
                             Atipo:char;Apint,Apdec:integer;isstr:boolean);
    procedure wmkeydown(var msg:tmessage); virtual wm_first+wm_keydown;
   { function  transfer(Dataptr:pointer;Transferflag:word):word;virtual;}
  end;


  Pdialogo=^tdialogo;
  tdialogo=object(tdlgwindow)
  nomesfondo:pchar;
  tasti:proc;
  constructor Init(AParent:Pwindowsobject; AName:pchar; var dato;arproc:proc);
  function canclose:boolean;virtual;
  procedure ok(var mes:Tmessage); virtual id_first + id_ok;
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
  function wmerasebkgnd(var msg:Tmessage):boolean; virtual wm_first+wm_erasebkgnd;
  procedure wminitdialog(var msg:Tmessage); virtual wm_first+wm_initdialog;
  end;

  PdialogoTab=^tdialogotab;
  TdialogoTab=object(tdialogo)
  constructor init(AParent:Pwindowsobject; AName:pchar; Iseg,iofs:word;arproc:proc);
  Procedure TastoPgDn; virtual Id_first+21;
  Procedure TastoPgUp; virtual Id_first+22;
  end;
var procarr:proc;
    dialog:pdialogo;
    DialogTab:PdialogoTab;

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

function tval.isvalidinput(var s:string;b:boolean):boolean;
var
  Valid1: Boolean;
  ValCode: Integer;
  Value: real;
  const
  CharSet = ['a'..'z','A'..'Z',' ','.','0'..'9'];
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
      (Value > Min) and (Value <= Max);
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
begin
seg_m:=seg(buffer^);
ofs_m:=ofs(Buffer^);
ofs_m:=ofs_m+(ofsetTab-ofsin);
Buffer:=Ptr(seg_m,ofs_m);

  case flag
   of vtGetData:
      begin
        case tipo of
          'I':Val(s, integer(buffer^), ValCode);
          'R':Val(s, real(buffer^), ValCode);
          '$':string(buffer^):=s;
        end;
      end;
   vtSetData:
      begin
        case tipo of
          'I':Str(integer(buffer^), s);
          'R':Str(real(buffer^):pint:pdec, s);
          '$':s:=string(buffer^);
        end;
      end;
  end;
  case tipo of
    'I':Transfer := SizeOf(integer);
    'R':Transfer := SizeOf(real);
    '$':Transfer := SizeoF(string);
  end;
end;

{  procedure CampoSucc(var Campo:integer);
   begin
      repeat
         if Campo >= UltimoCampo then Campo:=1
         else Campo:=Campo+1;
      until Tabella[Campo].Flag;
   end;}

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

procedure tfieldEdit.wmkeydown(var msg:tmessage);
var st,st1:string;
    i,id,campo:integer;
begin
  id:=getid;
  campo:=id-100;
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
     end
     else defwndproc(msg);
  end;
end;

constructor TFieldEditTab.InitResource(AParent: PWindowsObject;ResourceID: Word;
                               Digits: Word; AMinValue, AMaxValue: real;
                               Atipo:char;Apint,Apdec:integer;isstr:boolean);
begin
inherited InitResource(AParent,ResourceID,Digits,AMinValue,AMaxValue,
                       Atipo,Apint,Apdec,isstr);
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
     if Linea > datPg then
     begin
       Linea:=Linea-DatPg;
       dialogtab^.transferdata(tf_Getdata);
       OfsetTab:=OfsetTab-DOfs;
       Campo:=1;
       dialogtab^.transferdata(tf_setdata);
     end
     else messagebeep(10);
     SETFOCUS(DialogTab^.GETItemHANDLE(Campo+100));
     end;
  34:begin{pagDn}
     if Linea  < NDatg-DatPg then
     begin
       Linea:=Linea+DatPg;
       dialogtab^.transferdata(tf_Getdata);
       OfsetTab:=OfsetTab+DOfs;
       Campo:=1;
       dialogtab^.transferdata(tf_setdata);
     end
     else messagebeep(10);
     SETFOCUS(DialogTab^.GETItemHANDLE(Campo+100));
     end;
  38:Begin
        if campo > DatRg then  campo:=campo-DatRg
        else
        begin
          if Linea > 1 then
          begin
            Linea:=Linea-DatPg;
            OfsetTab:=OfsetTab-DOfs;
            Campo:=Campo+DatRg*(DatPg-1);
            dialogtab^.transferdata(tf_setdata);
          end
          else messagebeep(10);
        end;
       SETFOCUS(DialogTab^.GETItemHANDLE(Campo+100));
     end;
  40:Begin
       if campo <= (DatPg-1)*DatRg then campo:=campo+DatRg
       else
       begin
         if linea < NDatg-DatPg then
         begin
           linea:=linea+DatPg;
           OfsetTab:=ofsetTab+DOfs;
           if Campo = DatPg*DatRg then Campo:=DatRg
           else Campo:=Campo mod DatRg;
           str(basetab,st);
           str(ofsettab,st1);
           dialogtab^.transferdata(tf_setdata);
         end
         else messagebeep(7);
       end;
       SETFOCUS(DialogTab^.GETItemHANDLE(Campo+100));
     end
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
      inf='¿';
Var
    f:text;
    I,j,k:INTEGER;
    ch:char;
    variabile:String[240];
    flag1:integer;
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

constructor tdialogo.init(AParent:Pwindowsobject; AName:pchar;var dato;arproc:proc);




var p:pwindowsobject;
    p1:pcombobox;
    st1:string;
    i:integer;
begin
  inherited Init(AParent, AName);
  for i:= 1 to maxtasti do tasti[i]:=arproc[i];
  InitTab;
  ncampi:=0;
  transferbuffer:=@dato;
  nomemask:=strpas(aname)+'.rc';
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


procedure tdialogo.tastof1;
begin
  tasti[1];
end;
procedure tdialogo.tastof2;
begin
  tasti[2];
end;
procedure tdialogo.tastof3;
begin
  tasti[3];
end;
procedure tdialogo.tastof4;
begin
  tasti[4];
end;
procedure tdialogo.tastof5;
begin
  tasti[5];
end;
procedure tdialogo.tastof6;
begin
  tasti[6];
end;
procedure tdialogo.tastof7;
begin
  tasti[7];
end;
procedure tdialogo.tastof8;
begin
  tasti[8];
end;
procedure tdialogo.tastof9;
begin
  tasti[9];
end;
procedure tdialogo.tastof10;
begin
  tasti[10];
end;
function tdialogo.canclose:boolean;
begin
 {tasti[11]}
end;
procedure tdialogo.ok(var mes:tmessage);
begin
  transferdata(tf_getdata);
  tasti[12];
 transferdata(tf_setdata);
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


constructor TdialogoTab.init(AParent:Pwindowsobject; AName:pchar;iseg,iofs:word;arproc:proc);

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

var p:pwindowsobject;
    p1:pcombobox;
    st1:string;
    i:integer;
begin
  TdlgWindow.Init(AParent, AName);
  for i:= 1 to maxtasti do tasti[i]:=arproc[i];
  InitTab;
  ncampi:=0;
  transferbuffer:=ptr(Basetab,ofsettab);
  nomemask:=strpas(aname)+'.rc';
  LeggiMask;
  dofs:=spacetab(ofsetTab);
  ROFs:=DOfs div DatPg; {..spazio occupato da una riga..}
  for i:=1 to ncampi do
  with tabella[i] do
  case tipo of
     'R','I'    :p :=new(pfieldeditTab,initresource(@self,100+i,L,0,999999,tipo,L,cifredec,false));
     '$'        :p :=new(pfieldeditTab,initresource(@self,100+i,L+1,0,999999,tipo,L+1,cifredec,true));
     'r','i','s':p1:=new(pcombobox,initresource(@self,100+i,L+1));
   end;
   nomesfondo:=aname;
 end;

(*function  TFieldEditTab.transfer(Dataptr:pointer;Transferflag:word):word;
var segmento,larghezza:word;
    temp:longint;
    a:real;
begin
  {if dataptr=nil then messagebeep(10);}
  {messagebox(0,'indata','',0);
  a:=200;
  dataPtr:=@a;
  Segmento:=seg(dataptr^);
  larghezza:=ofs(DataPtr^);
{  temp:=Larghezza;
  temp:=temp-ofsin;
  temp:=temp+OfsetTab;}
  {Larghezza:=larghezza{+dofs};
  {dataptr:=ptr(segmento,larghezza);}
  {dataptr:=Ptr(base,ofsin);}
  tedit.transfer(dataptr,transferflag);
end; *)

Procedure TdialogoTab.TastoPgDn;
begin
end;

Procedure TdialogoTab.TastoPgUp;
begin
end;








procedure UsaMaskera(Base,OffSet:word;NomeFile:st80;
                     var Campo,Chiave:integer;
                     CField,CText:integer;W,WVal,all,notzero:boolean;prarr:proc);
var pun:pointer;
    procarr:proc;
begin
  pun:=ptr(base,offset);
  Dialog := New(pdialogo, Init(pmainwindow,strpcopy('',nomefile),pun^,procarr));
  application^.makewindow(dialog);
  dialog^.show(sw_show);
end;

procedure IOTabella(ISeg,IOfs:word;NDat,DatP,DatR:integer;var Chiave,Riga,campo:integer;
                     mask:st80;SetNRighe,InitMask,IWVal,IWCampo:boolean;prarr:proc);
  {... ISeg & IOfs contengono il SEG e l'OFS della tabella
   ... NDat Š il numero totale di righe
   ... DatP Š il numero di righe per pagina
   ... DatR Š il numero di CAMPI per riga
   ... Riga contiene il N. della riga da cui si Š usciti
   ... IWVal e' true se si fa riferimento all'ultima tabella usata :
       in tal caso si puo' specificare con riga la riga di accesso alla tabella
   ... IWCampo e' true se si fa riferimento all'ultima tabella usata :
       in tal caso si puo' specificare con campo il campo di accesso alla tabella
       il Campo ha precedenza sulla riga se IWCampo e' true ,cioe` il cursore
       si posizionera' sulla tabella in base al valore del campo e non della riga
   ... SetNRighe = true se si vogliono numerare  le righe della tabella
                   in tal caso occorre che il primo campo della tabella
                   venga introdotto in riga 8.
                                                               }

  type buffer = array[1..80] of char;
  var i,j,k,Lin,NPag,Limite : integer;
      IBase                                 : word;
      ExRet                                 : boolean;
      PPrec,PSucc                           : ^char;
      PBuff,PBuffMask                       : ^Buffer;
      Pun                                   :pointer;
      x:integer;
      grigiolight,giallo:integer;



(*
  procedure tastopgdn;
  var i:integer;
      msg:tmessage;
  begin
  if i < NDat-DatP then
  begin
    i:=i+DatP;
    IOfs:=IOfs+DOfs;
    Campo:=0;   CampoSucc(Campo);
    IWVal:=true;   ExRet:=true; IWCampo :=true;
  end
  else messagebeep(7);
  end;
  procedure tastopgup;
  var i:integer;
  begin
  if i > datP then
    begin



    i:=i-DatP;
    IOfs:=IOfs-DOfs;
    Campo:=0;   CampoSucc(Campo);
    IWVal:=true;   ExRet:=true; IWCampo :=true;
    end
  else messagebeep(7);
  end;*)
  {-------------- Main -------------}
  var st,st1:string;
  begin           {maskera}
    Base:=iseg;Offset:=iofs;
    BaseTab:=iseg;ofsetTab:=iofs;
    ofsin:=Iofs;
    linea:=1;
    pun:=ptr(iseg,iofs);
    NDatg:=Ndat;DatPg:=DatP;DatRg:=DatR;
    DialogTab := New(pdialogoTab, Init(pmainwindow,strpcopy('',mask),iseg,iofs,procarr));
    application^.makewindow(dialogTab);
           (*
           if (PBuff^ <> PBuffMask^) or (Chiave in [59..68]) then CalcMask(IBase,NDat,DatR,Lin,Campo,Chiave,Mask);
           case Chiave of
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

                13,77:
                   begin
{                      writeln('campo ',campo, ' ultimoaccesso  ',ultimoaccesso);
                      delay(2000);}

                      if campo < UltimoAccesso then CampoSucc(campo)
                      else
                       begin

                          if i < NDat-DatP then
                           begin
                              i:=i+DatP;
                              IOfs:=IOfs+DOfs;
                              Campo:=0;   CampoSucc(Campo);

                              IWVal:=true;   ExRet:=true; IWCampo :=true;
                           end
                          else write(chr(7));
                       end
                   end;
                27,59..62,65..68:;
                75:
                   begin
                      if campo > 1 then
                       begin
                          CampoPrec(campo);
                       end
                      else
                       begin
                          if i > 1 then
                           begin
                              i:=i-DatP;
                              IOfs:=IOfs-DOfs;
                              Campo:=DatP*DatR+1;   CampoPrec(Campo);
                              IWVal:=true;   ExRet:=true; IWCampo :=true;
                           end
                          else write(chr(7));
                       end
                   end;
                80:  {..freccia in giu'..}
                   if campo <= (DatP-1)*DatR then campo:=campo+DatR
                   else
                    begin
                       if i < NDat-DatP then
                        begin
                           i:=i+DatP;
                           IOfs:=IOfs+DOfs;
                           if Campo = DatP*DatR then Campo:=DatR
                           else Campo:=Campo mod DatR;
                           IWVal:=true;   ExRet:=true;  IWCampo :=true;
                        end
                       else write(#7);
                    end;
                72:  {..freccia in su'...}
                   if campo > DatR then  campo:=campo-DatR
                   else
                    begin
                       if i > 1 then
                        begin
                           i:=i-DatP;
                           IOfs:=IOfs-DOfs;
                           Campo:=Campo+DatR*(DatP-1);
                           IWVal:=true;   ExRet:=true; IWCampo :=true;
                        end
                       else write(#7);
                    end;
                81:{PgDn}
                   if i < NDat-DatP then
                    begin
                       i:=i+DatP;
                       IOfs:=IOfs+DOfs;
                       Campo:=0;   CampoSucc(Campo);
                       IWVal:=true;   ExRet:=true; IWCampo :=true;
                    end
                   else write(chr(7));
                73:{pgUp}
                   if i > datP then
                    begin
                       i:=i-DatP;
                       IOfs:=IOfs-DOfs;
                       Campo:=0;   CampoSucc(Campo);
                       IWVal:=true;   ExRet:=true; IWCampo :=true;
                    end
                   else write(chr(7));
           end; { case } *)
        Riga:=i+(Campo div DatR);
        if Campo mod DatR = 0 then Riga:=Riga-1;
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
    Riga   : st80;
    k      : integer;
    ch,ch1 : char;
begin
  (* assign(f,Nome);
   reset(f);
   for k:=1 to i do readln(f,Riga);
   close(f);
   Riga:=Riga + Aggiunta;
   { write(chr(7));}
   textbackground(4);   textcolor(14);

   repeat
      gotoxy(1,21);  write(Riga);
      textbackground(col[1]);   textcolor(col[2]);   ClrEol;
      repeat
         read(kbd,ch);
         if not (UpCase(ch) in ['S','N']) then write(#7);
      until UpCase(ch) in ['S','N'];
      textbackground(4);   textcolor(14);
      write('--> ',ch);
      read(kbd,ch1);
   until ch1 = #13;

   gotoxy(1,21);
   textbackground(col[1]);   textcolor(col[2]);   ClrEol;
   Conferma:=(UpCase(ch) = 'S');
   *)
end;
 function UpString(St:st126):st126;
 var c,i:integer;
 begin
    c := LENGTH(St);
    FOR i := 1 TO c DO
      St[i] := UPCASE(St[i]);
    UpString:=St;
 end;

end.