
Unit utilitie;
{$IFDEF FRANCIA}
{$R uti-fr.res}
{$ENDIF}

{$IFDEF INGLESE}
{$R util-eng.res}
{$ENDIF}

{$IFDEF ITALIA}
{$R utils.res}
{$ENDIF}

{$IFDEF tedesco}
{$R uti-ted.res}
{$ENDIF}

{$IFDEF ceco}
{$R utilcec.res}
{$ENDIF}

{$IFDEF slovacco}
{$R utilslo.res}
{$ENDIF}

{$IFDEF SPAGNA}
{$R utilesp.res}
{$ENDIF}
Interface

Uses

  {$ifdef delphi}
  messages,
  {$endif}
 //**N validate,
  {win31,}
//  bwcc,
//  objects,
//  winapi,
//  WinProcs,
 // Strings,
  definiz,
  Enter,
  {$ifdef tubi}
  wp,
  {$else}
  Wm,
  {$endif}
  misure,
  defuti;


procedure cambiadir(s:string);

procedure restoredir;

procedure faistampa(dove:string);

function ReadString(const Section, Ident, Default: string): string;

function ReadInteger(const Section, Ident: string; Default: Longint): Longint;

function ReadBool(const Section, Ident: string;Default: Boolean): Boolean;

procedure WriteString(const Section, Ident, Value: string);

procedure WriteBool(const Section, Ident: string; Value: Boolean);

procedure WriteInteger(const Section, Ident: string; Value: Longint);

procedure Prog_To_Ark(nomeark,nomefile,nomemask:string;nline:integer;modo:integer);

procedure Copiapianta(maschera:string;riga:integer);

procedure writeW(s:string;nst:integer);
procedure writelnW(s:string;nst:integer);

procedure InitTabella;

procedure initins;

function Ind_Ins(st_cerc:string;campo:integer):integer;

function  numerolum(ch:char):integer;

procedure LeggiMask(NomeF:st80;nlinea:integer);

procedure Leggi2Mask(NomeF:string);

function  UpString(St:string):string;

 function Exist(Nome:string):boolean;

function ExistDir(Nome:st80):boolean;

function Exists(Nome:string):boolean;

Function ReadLineHelp(Nomefile:string;RigaHp,campo:Integer):String;

function InRange(Num,Min,Max:integer):boolean;

FUNCTION SETLEFT(ST:STRING):STRING;

FUNCTION SETRIGHT(ST:STRING):STRING;

FUNCTION ALLTRIM(ST:STRING):STRING;

FUNCTION FORMAT(ST:STRING;StLength:INTEGER):STRING;

Function FormST(ST:STRING):StRING;

Function FormST1(ST:STRING):StRING;

function WritePrezzo(I:real):st20;

function Conferma(Nome,Aggiunta:string;i:integer):boolean;

procedure copia(org:string);

procedure copiafile(forg,fdest:string);

procedure WriteMessage(Nome:string;i:integer);

procedure WriteMessage1(Nome:st80;i:integer;agg:string);

function get_drive:string;

procedure WriteWd(Nome:st80);

procedure initumlav;

function eliminadir(dir:string):string;

procedure CarAddress(Base,OffSet:word);

procedure LeggiDato1(var Dato:linestr;I:integer);

function SpaceTab(InADDR:word):integer;

function Pos_ins(NomeMask:string;Campo:integer;Strx:string):integer;

function Ins_Pos(NomeMask:string;Campo,Ind:integer):string;

function Ins_PosV(NomeMask:string;Campo,Ind:integer):string;

Function ControlNom(Rag:string):boolean;


procedure generains(tipo:integer;nomemask,nfile:string;nrighe,nrighep,ncampir,campov,campoD,lcampov,lcampod:integer);


type

  PVAL=^TVAL;
  TVAL=OBJECT(TVALIDATOR)
  min,max:real;
  tipo:char;
  campo:integer;
  pint,pdec:integer;
  isstringa:boolean;
  Lunghezza:integer;
  NlineaUm,Num,N_fin :integer;
  Constructor init (amin,amax:real;stringa:boolean;atipo:char;
                    acampo,ALunghezza,ANlineaUm,ANum,apdec:integer);
  function isvalidINPUT(VAR s:string;b:boolean):boolean;virtual;
  function transfer(var s:string;buffer:pointer;flag:tvtransfer):word;virtual;
  end;

  type arstr=array[1..40] of string[80];
       punstr=^arstr;
  pfill_edit=^tfill_edit;
  tfill_edit=object
  Campo_cor:integer;
  Codice,ncampo_out,ncampo_agg,ncamporec_agg,
  nriga,nrighe,nrighep,ncampir      :integer;
  mask,nfile                        :string;
  iseg,iofs:word;
  elstring:pcollection;
  elstr:punstr;
  constructor init(acampo_cor:integer);
  procedure Lista_rec(acampo,acod:integer;AMask:string;var rec;Acampo_rec,
                      Acampo_agg,acamporec_agg,Anrighe,Anrighe_T,Ancampi_R:integer);
  procedure Lista_file(acampo,acod:integer;AMask,Anfile:string;Acampo_rec,
                      Acampo_agg,acamporec_agg,Anrighe,Anrighe_T,Ancampi_R:integer);
  procedure Lista(acampo,acod:integer;aelstr:punstr);
  destructor done;virtual;
  end;

  proc1=procedure(var p_f_e:pfill_edit);

  PMYRADIO=^tmyradio;
  tmyradio=object(tradiobutton)
  n_fin,campo:integer;
  tipo:char;
  constructor initresource(aparent:pwindowsobject;aid:integer;acampo:integer;atipo:char);
  procedure BnClicked(var msg:Owindows.Tmessage);virtual  Nf_first+Bn_Clicked;
  function Transfer(DataPtr: Pointer;TransferFlag: Word):word;virtual;
  end;


  pmybox=^Tmybox;
  tmybox=object(tcombobox)
  Carico:boolean;
  fill_box:proc1;
  campo,cod:integer;
  tcampo_agg:integer;
  nriga_sel:integer;
  possochiudere:boolean;
  elenco:pcollection;
  tipo:char;
  NlineaUm,Num,N_fin:integer;
  L:integer;
  cifreint,cifredec:integer;
  controll:boolean;
  function Transfer(DataPtr: Pointer;TransferFlag: Word):word;virtual;
  constructor initresource(aparent:pwindowsobject;aid:integer;atextlen:word;afill:proc1;
                           acampo:integer;atipo:char;ANlineaUm,ANum,al,acint,acdec:integer);
  procedure caricalista(var msg:tmessage);virtual wm_first+9101;
  procedure setupwindow;virtual;
  function canclose:boolean;virtual;
  procedure wmcommand(var msg:owindows.tmessage);virtual wm_first+wm_command;
  procedure wmkeydown(var msg:owindows.tmessage); virtual wm_first+wm_keydown;
  procedure wmkillfocus(var msg:owindows.tmessage);virtual wm_first+wm_killfocus;
  procedure wmsetfocus(var msg:owindows.tmessage);virtual wm_first+wm_setfocus;

  end;


  PFieldEdit = ^TfieldEdit;
  TfieldEdit = object(TEdit)
    MinValue, MaxValue: real;
    Tipo:char;
    controll:boolean;
    def_ins:recins;
    N_fin:integer;
    pint,pdec,Lcampo,lcampocorr:integer;

    constructor InitResource(AParent: PWindowsObject; ResourceID: Word;
                             Digits: Word; AMinValue, AMaxValue:real;
                             isstr:boolean;atipo:char;Ncampo,ANlineaUm,Anum,apdec:integer;adef_ins:recins);
    procedure wmkeydown(var msg:owindows.tmessage); virtual wm_first+wm_keydown;
    procedure wmchar(var msg:owindows.tmessage); virtual wm_first+wm_char;
    function setselection(startpos,Endpos:integer):boolean ; virtual;
    function Getselection(Var startpos,Endpos:integer):boolean ; virtual;
    procedure wmkillfocus(var msg:owindows.tmessage);virtual wm_first+wm_killfocus;
    procedure wmsetfocus(var msg:owindows.tmessage);virtual wm_first+wm_setfocus;

    procedure wmrbuttonup(var msg:tmessage);virtual wm_first+wm_rbuttonup;
    procedure wmlbuttondblclk(var msg:tmessage);virtual wm_first+wm_lbuttondblclk;

  end;
  pscrolla=^Tscrolla;
  tscrolla=object(tscrollbar)
  max,min,pgm,pos,n_fin:integer;

  constructor initresource(aparent:pwindowsobject;anid:integer;amin,amax,apgm:integer);
  procedure setupwindow;virtual;
  procedure sblinedown(var msg:owindows.tmessage);virtual nf_first+sb_linedown;
  procedure sblineup(var msg:owindows.tmessage);virtual nf_first+sb_lineup;
  procedure sbpagedown(var msg:owindows.tmessage);virtual nf_first+sb_pagedown;
  procedure sbpageup(var msg:owindows.tmessage);virtual nf_first+sb_pageup;
  procedure sbThumbposition(var msg:owindows.tmessage);virtual nf_first+sb_Thumbposition;
  end;

  pmycheck=^tmycheck;
  tmycheck=object(tcheckbox)
  tipo:char;
  campo,N_fin:integer;
  function Transfer(DataPtr: Pointer;TransferFlag: Word):word;virtual;
  constructor initresource(aparent:pwindowsobject;aid:integer;acampo:integer;atipo:char);
  procedure   wmkillfocus(var msg:owindows.tmessage);virtual wm_first+wm_killfocus;
  procedure wmsetfocus(var msg:owindows.tmessage);virtual wm_first+wm_setfocus;
  procedure BnClicked(var msg:Owindows.Tmessage);virtual  Nf_first+Bn_Clicked;
  end;


  {const
  rgb_Yellow      = $0000FFFF;
  rgb_DarkYellow  = $0000C1FF;
  rgb_Blue        = $00FF0000;
  rgb_Red         = $000000FF;
  rgb_Green       = $0000FF00;
  rgb_DarkGreen   = $00007F00;
  }

  type elstatici=array[1..maxinfo] of pstatic;
       elnumeririga=array[1..20] of pstatic;

  Pdialogo=^tdialogo;
  tdialogo=object(tdialog)
  isnrigheset:boolean;
  {TheBrush,BoxBrush: HBrush;}
  nomesfondo:pchar;
  nomtab:st8;
  linetemp:string;
  ar_instab:^tabellains;
  selezione:boolean;
  tab       :^tabellarec;
  tasti     :proc;
  fill_combo:proc1;
  St_Pag    :Pstatic;
  scrolla   :Pscrolla;
  Numerolineatabella:integer;
  st_mess   :elstatici;
  st_messum :elstatici;
  numeririga:elnumeririga;
  modificata:boolean;
  modale    :boolean;
  testodihelp:string;
  camposel:integer;
  campoprecedente:integer;
  UltCampo        : integer;
  ofsin:longint;
  BaseTab,ofsetTab:longint;
  Dofs,Rofs:longint;
  NDatg,DatPg,DatRg:longint;
  hlp:rechlp;
  hlp_ldescr,
  hlp_lval :integer;
  fh:file of rechlp;
  nomemaskhlp:string;
  pg:integer;
  campoattivo:integer;
  isiotab:boolean;
  possochiudere:boolean;
  {uncampo:PFieldEdit;}
  constructor Init(AParent:Pwindowsobject; AName:pchar;var dato;Setnrighe:boolean;Itasti:proc;
                   fill_lista:proc1;iotab,amodale:boolean;Ndat,DatP,DatR:integer);
  destructor done; virtual;
  function  canclose:boolean;virtual;
  procedure ok(var mes:owindows.Tmessage); virtual id_first + id_ok;
  procedure cancel(var mes:owindows.Tmessage); virtual id_first + id_cancel;
  function  wmerasebkgnd(var msg:owindows.Tmessage):boolean; virtual wm_first+wm_erasebkgnd;
  procedure wminitdialog(var msg:owindows.Tmessage); virtual wm_first+wm_initdialog;
  procedure setupwindow;virtual;
  procedure getwindowclass(var AWndClass:TWndClass); virtual;
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
  procedure tastoF16; virtual id_first+26;
  procedure tastoF17; virtual id_first+27;
  procedure tastoF18; virtual id_first+28;
  procedure tastoF19; virtual id_first+29;
  procedure tastoF20; virtual id_first+30;

  Procedure TastoHelp; virtual id_first+998;
  Procedure TastoPgUp; virtual Id_first+22;
  Procedure TastoPgDn; virtual Id_first+21;
  procedure wmNCHITTEST(var msg:owindows.tmessage);virtual wm_first+wm_NCHITTEST;
  {procedure WMControlColor(var Msg: TMessage);
      virtual wm_First + wm_CtlColor;}
  end;




  PPCharCollection = ^TPCharCollection;
  TPCharCollection = object(TCollection)
    procedure FreeItem(Item: Pointer); virtual;
  end;

  ppopup=^tpopup;
  tpopup=object(tdialog)
  lista:plistbox;
  def_ins:recins;
  x,y,h,w,nmessaggi,campo,fin:integer;
  azione:boolean;
  messaggio: {array[1..1000] of ^string;}PPCharCollection;
         constructor init(aparent:pwindowsobject;atitle:pchar;ax,ay,aw,ah,acampo,afin:integer;adef_ins:recins;uazione:boolean);
         procedure wminitdialog(var msg:owindows.Tmessage); virtual wm_first+wm_initdialog;
         procedure setupwindow; virtual;
         procedure wmcommand(var msg:owindows.tmessage);virtual wm_first+wm_command;
         function canclose:boolean;virtual;
  end;




  pviswin=^Tviswin;
  tviswin=object(twindow)
  font:tlogfont;
  TheLines: PCollection;
  FileLines: PPCharCollection;
  filename:string;
  constructor Init(AParent: PWindowsObject; atitle:pchar;afilename:string);
  PROCEDURE   setupwindow;virtual;
  procedure   paint(PaintDC: HDC; var PaintInfo: TPaintStruct); virtual;
  procedure   LoadFile;
  function    canclose:boolean;virtual;
  function    getclassname:pchar;virtual;
  end;

  (*PDLGVISWIN=^TDLGVISWIN;
  tdlgviswin=object(TDIALOG)
  visedit:pviswin;
  constructor Init(AParent:Pwindowsobject; AName:pchar;afilename:string);
 { procedure   setupwindow;virtual;}
  PROCEDURE WMINITDIALOG(VAR MSG:tmessage);virtual wm_first+wm_initdialog;
  end;
 *)


  tabcorr=array[1..maxtabelle]
          of record
              nome:st8;
              maniglia:hwnd;
              self:pwindowsobject;
              dialog:pdialogo;
          end;

  rec_postab=record
                nome:st8;
                x,y:integer;
             end;
  el_postab=array[1..1000] of rec_postab;

eltabcorr  =^Tabcorr;
procedure visbit(x1,y1,x2,y2:integer;bitmap:pchar);



procedure W_UsaMaskera(Var dato;NomeFile:st80;ITasti:proc;modal:boolean;var cod:integer;fill_lista:proc1;aself:pwindowsobject);
procedure W_IOTabella(var dato;NDat,DatP,DatR:integer;mask:st80;Setnrighe:boolean;
                      Itasti:proc;modal:boolean;var cod:integer;fill_lista:proc1;aself:pwindowsobject);
procedure generica;far;
procedure fill_listagen(var pcb:pfill_edit);far;
procedure aggtab
(nome:st8;ndat:integer;Rec_To_Mask:boolean);
procedure canctab(nomet:st8);
function readdato(i,n_w:integer):linestr;
function numerotabella(var tabcerc:st8;Var ahandle:hwnd;modo:integer):integer;
function nlinetab(nw:integer):integer;
function nlinetab1(nw:integer):integer;
procedure mostraTab(nomeT:st8);
procedure NascondiTab(nomeT:st8);
procedure aggiornadatowin(dato:string;i,n_w:integer);
procedure vishelp(filename:string);
procedure setwinactive(st:string);
function getriga(st:string):integer;
function getwin(st:string):integer;
function getrattiva(st:st8):integer;
PROCEDURE InitProc;
function  nomeins(Nome:string;Campo:integer;def_ins:recins):string;
function tastoins(campo,campotab,finestra:integer;azione:boolean;def_ins:recins):boolean;
procedure setposintab(ntab:string;pos:integer);
Function oem_ans(s:string):string;
Function ans_oem(s:string):string;
var

    popup:ppopup;
    hd     :hwnd;
    a_w     :integer;

    code    :integer;
    creazione:boolean;
    tabellacorrente:eltabcorr;
    postab:^el_postab;
    fpostab:file of rec_postab;
    ulttab:integer;
    f_deb:text;
    viswin:pviswin;
    elstr:punstr;


var w_UIo:boolean;
{===========================================================================}

Implementation


procedure faistampa(dove:string);
var s:string;
    st_80,st0,st,st01:string[80];
    pc_80:array[0..80] of char;
begin
  if not stampe_word then
  begin
    getdir(0,s);
    chdir(get_drive);
    st_80:='execstam.exe '+dove;
    strpcopy(pc_80,st_80);
    winexec(pc_80,sw_show);
    chdir(s);
  end
  else
  begin
    chdir(get_drive);
    st0:='convword.exe ';
    st:=dove+'\word ';;
    st01:=dove;
    st0:=st0+st+' '+st01;
    strpcopy(pc_80,st0);
    winexec(pc_80,SW_show);
    chdir(dove);
  end;
end;


{uses graph;}

var scrn_char : char;
    attrib,Mode_video,colnum,page_disp:byte;

function ComparaTesto(const S1, S2: string): Integer; assembler;
asm
        PUSH    DS
        LDS     SI,S1
        LES     DI,S2
        LODSB
        XOR     AH,AH
        MOV     DL,ES:[DI]
        XOR     DH,DH
        INC     DI
        MOV     CL,AL
        CMP     CL,DL
        JBE     @@1
        MOV     CL,DL
@@1:    XOR     CH,CH
@@2:    REPE    CMPSB
        JE      @@5
        MOV     BL,DS:[SI-1]
        CMP     BL,'a'
        JB      @@3
        CMP     BL,'z'
        JA      @@3
        SUB     BL,20H
@@3:    MOV     BH,ES:[DI-1]
        CMP     BH,'a'
        JB      @@4
        CMP     BH,'z'
        JA      @@4
        SUB     BH,20H
@@4:    CMP     BL,BH
        JE      @@2
        MOV     AL,BL
        MOV     DL,BH
@@5:    SUB     AX,DX
        POP     DS
end;


function StrToIntDefault(const S: string; Default: Longint): Longint;
var
  E: Integer;
  risultato:longint;
begin
  Val(S, Risultato, E);
  if E <> 0 then Risultato := Default;
  StrToIntDefault:=risultato;
end;


function ReadString(const Section, Ident, Default: string): string;
var
  Len: Integer;
  CSection: array[0..127] of Char;
  CIdent: array[0..127] of Char;
  CDefault: array[0..255] of Char;
  ssec,sid:string[127];
  sdef,risultato:string;
begin
  ssec:=section;
  sid:=ident;
  Len := GetPrivateProfileString(
    StrPCopy(CSection, Ssec),
    StrPCopy(CIdent, sId),
    StrPCopy(CDefault, Default),
    @risultato, 256, FFileName);
  Move(Risultato[0], Risultato[1], Len);
  Risultato[0] := Char(Len);
  readstring:=risultato;
end;


function ReadInteger(const Section, Ident: string; Default: Longint): Longint;
var
  IStr: string;
begin
  IStr := ReadString(Section, Ident, '');
  if ComparaTesto(Copy(IStr, 1, 2), '0x') = 0 then
    IStr := '$' + Copy(IStr, 3, 255);
  Readinteger := StrToIntDefault(IStr, Default);
end;


function ReadBool(const Section, Ident: string;Default: Boolean): Boolean;
var risultato:boolean;
begin
  Risultato := ReadInteger(Section, Ident, Ord(Default)) <> 0;
  ReadBool:=risultato;
end;


procedure WriteString(const Section, Ident, Value: string);
var
  CSection: array[0..127] of Char;
  CIdent: array[0..127] of Char;
  CValue: array[0..255] of Char;
  ssec,sid:string[127];
  sdef,risultato:string;
begin
  ssec:=section;
  sid:=ident;
  if not WritePrivateProfileString(
    StrPCopy(CSection, Ssec),
    StrPCopy(CIdent, sId),
    StrPCopy(CValue, Value), FFileName) then
  writemessage('Urils.msg',1);
end;


procedure WriteBool(const Section, Ident: string; Value: Boolean);
const
  Values: array[Boolean] of string[1] = ('0', '1');
begin
  WriteString(Section, Ident, Values[Value]);
end;



procedure WriteInteger(const Section, Ident: string; Value: Longint);
var s:string;
begin
  str(value,s);
  WriteString(Section, Ident, s);
end;



procedure initins;
begin
  fillchar(ar_ins^,sizeof(ar_ins^),0);
end;


{--------------------------------  SETLEFT  ----------------------------------}
function InRange(Num,Min,Max:integer):boolean;
begin
   if (Num >=Min) and (Num <= Max) then InRange:=true
   else InRange:=false;
end;

FUNCTION SETLEFT(ST:STRING):STRING;
BEGIN
  WHILE (COPY(ST,1,1)=' ') AND (ST>'') DO ST:=COPY(ST,2,LENGTH(ST)-1);
  SETLEFT:=ST;
END;     { FUNC. SETLEFT }



FUNCTION SETRIGHT(ST:STRING):STRING;
VAR
  I:INTEGER;
BEGIN
  I:=LENGTH(ST);
  while (I > 1) and (ST[i] = ' ') do i:=i-1;
  if i = 1 then
   begin
     if st[i] = ' ' then i:=0;
   end;

  if i = 0 then SetRight:=''
  else SETRIGHT:=COPY(ST,1,I);

END;     { FUNC. SETRIGHT }


procedure initumlav;
var i,j:integer;
begin
  for i:=1 to maxunmisure do
  with umlav^[i] do
  for j:=1 to 2 do
  with um[j] do coeffum:=1;
end;


function eliminadir(dir:string):string;
var i:integer;

begin
  eliminadir:=dir;
  for i:=1 to length(dir) do
  if dir[i]='\' then eliminadir:=copy(dir,i+1,length(dir))
end;

{--------------------------------  SETright  ----------------------------------}


{----------------------------------ALLTRIM--------------------------------------}
FUNCTION ALLTRIM(ST:STRING):STRING;
var l,p,i,u : integer;
    c       : string;

begin
i := length(st);
p := 1         ;
c := ' '       ;
while c = ' ' do
begin
   c := copy(st,1,1);

   if c = ' ' then  st := copy(st,2,length(st)-1);
   p := p + 1 ;
   if p > i then c := 'x';
end ;
c := ' ';
l := length(st) ;
while c = ' ' do
begin
   c := copy(st,length(st),1);
   if c = ' ' then st := copy(st,1,length(st)-1);
   p := p + 1 ;
   if p > i then c := 'x';
end;
alltrim := st;
end;     { FUNC. alltrim }




{----------------------------  FORMAT_STRING  --------------------------------}
FUNCTION FORMAT(ST:STRING;StLength:INTEGER):STRING;
BEGIN
  ST:=COPY(ST,1,StLength);
  FORMAT:=ST+COPY(Fill,1,StLength-LENGTH(ST));
END;      { FUNC.  FORMAT }

Function FormST(ST:STRING):String;
begin
   St:=(SetLeft(SetRight(St)));
   FormSt:=UpString(St);
end;

Function FormST1(ST:STRING):String;
begin
   St:=(SetLeft(SetRight(St)));
   FormSt1:=(St);
end;

function WritePrezzo(I:real):st20;   { --- st18 --- }
var Riga :st20;
    Riga1:st20;
    j,L,k:integer;

begin

   Riga:='';   Riga1:='';
   Str(I:20:0,Riga);
   Riga:=SetLeft(Riga);

   L:=length(Riga);

   while L mod 3 <> 0 do
    begin
       Riga:=' '+Riga;
       L:=length(Riga);
    end;
   j:=1;
   k:=1;
   if L > 3 then
    begin
       repeat
          if j mod 3 = 0 then
           begin
              Riga1[k]:=Riga[j];
              Riga1:=Riga1+riga1[k];
              if j < L then
               begin
                  Riga1[k+1]:='.';
                  Riga1:=Riga1+riga1[k+1];
                  k:=k+2;
               end;
           end
          else
          begin
             Riga1[k]:=Riga[j];
             riga1:=riga1+riga1[k];
             k:=k+1;
          end;
         j:=j+1;

       Until (j > L) or (Riga[j]='');
       riga1:=setleft(riga1);
       WritePrezzo:=Riga1;
    end
   else WritePrezzo:=Riga;
end;

(*
function Conferma(Nome,Aggiunta:st80;i:integer):boolean;
var f      : text;
    Riga   : st80;
    r1,r2  :string[31];
    r3     :string[20];
    k,campop: integer;
    ch,chX : char;

    {$ifdef win}
    pc:record
           pc1:array[0..30] of char;
           pc2:array[0..30] of char;
           pc3:array[0..20] of char;
       end;
    pcl,pcs,pcat:array[0..82] of char;
    rigal:string[82];
    aw:integer;
    {hd:hwnd;}
    {$endif}
begin
   if exist(nome) then
   begin
   assign(f,Nome);
   reset(f);
   for k:=1 to i do readln(f,Riga);
   close(f);
   end
   else riga:=nome;
   Riga:=Riga + Aggiunta;

  {$Ifdef dos}
   write(chr(7));
   textbackground(4);   textcolor(14);

   repeat
      gotoxy(1,21);  write(Riga);
      textbackground(col[1]);   textcolor(col[2]);   ClrEol;
      repeat
         readkbd(ch);
{S,N}         if not (UpCase(ch) in [CHUT1,CHUT2]) then write(#7);
{S,N}      until UpCase(ch) in [CHUT1,CHUT2];
      textbackground(4);   textcolor(14);
      write('--> ',ch);
      readkbd(chX);
   until chX = #13;

   gotoxy(1,21);
   textbackground(col[1]);   textcolor(col[2]);   ClrEol;
{S}   Conferma:=(UpCase(ch) =CHUT1);
   {$endif}
  {$Ifdef Win}

   r1:=copy(riga,1,30)+#10;
   r2:=copy(riga,31,60)+#10;
   r3:=copy(riga,61,80);
   rigal:=r1+r2+r3;
   strpcopy(pcs,rigal);
   oemtoansi(pcs,pcl);
   rigal:='Mc4-hvac';
   strpcopy(pcs,rigal);
   oemtoansi(pcs,pcat);
   messagebeep(10);
   {
   if  a_w in [1..maxtabelle] then
   with tabellacorrente^[a_w] do
   begin
   campop:=dialog^.campoprecedente;
   conferma:=bwccmessagebox(maniglia,pcl,'Richiesta di conferma',mb_yesnocancel or mb_iconquestion)=id_yes;
   setfocus(dialog^.getitemhandle(campop));
   end
   else}
   conferma:=bwccmessagebox(0,pcl,pcat,mb_yesno or mb_iconquestion)=id_yes;
  {$endif}

end;
*)

function Conferma(Nome,Aggiunta:string;i:integer):boolean;
var f      : text;
    Riga   : string;
    r1,r2,r3 :string[50];
    pc1:array[0..150] of char;
    rigal:string[150];
    k,a,j:integer;
begin
   if exist(nome) then
   begin
     assign(f,Nome);
     reset(f);
     for k:=1 to i do readln(f,Riga);
     close(f);
   end
   else riga:=nome;
   Riga:=Riga +' '+Aggiunta;
   if length(riga)>50 then
   begin
     k:=length(riga) div 3;
     a:=k;
     while (riga[a]<>' ') and (a<length(riga)) do inc(a);
     r1:=copy(riga,1,a)+#10;
     j:=a+k;
     while (riga[j]<>' ') and (j<length(riga)) do inc(j);
     r2:=copy(riga,a+1,j-a)+#10;
     if j<length(riga) then
     r3:=copy(riga,j+1,length(riga))
     else r3:='';
     rigal:=r1+r2+r3;
   end
   else
   rigal:=riga;
   strpcopy(pc1,rigal);
   oemtoansi(pc1,pc1);
   messagebeep(10);
   k:=length(rigal);
   wvsprintf(pc1,pc1,k);
   if pmainwin<>nil then
   conferma:=WINPROCS.messagebox(pmainwin^.hwindow,pc1,'Mc4-hvac',mb_yesno or mb_iconquestion)=id_yes
   else
   conferma:=WINPROCS.messagebox(0,pc1,'Mc4-hvac',mb_yesno or mb_iconquestion)=id_yes
end;



 function UpString(St:string):string;
 var c,i:integer;
 begin
    c := LENGTH(St);
    FOR i := 1 TO c DO
      St[i] := UPCASE(St[i]);
    UpString:=St;
 end;


function Exists(Nome:string):boolean;
var f:file;
    i:integer;
begin
  if exist(nome) then exists:=true
  else
  begin
    for i :=1 to length(nome) do  if nome[i]=' ' then
    begin
      exists:=false;
      exit;
    end;
    {$I-} assign(f,Nome);rewrite(f);{$I+}
    if (ioresult=0) then
    begin
      close(f);
      assign(f,nome);
      erase(f);
      ExistS:=true
    end
    else exists:=false;
  end;
end;



 function Exist(Nome:string):boolean;
 var i:integer;
 pc:array[0..80] of char;
 n:string[80];
 s:tsearchrec;
 var f:file;
    begin
    n:=nome;
    strpcopy(pc,n);
    exist:=false;
    findfirst(pc,faAnyFile,s);
    exist:=doserror=0;
 end;

function ExistDir(Nome:st80):boolean;
 var f:file;
     corr:string;
 begin
    getdir(0,corr);
    {$I-}   chdir(Nome);  {$I+}
    if IOResult = 0 then
     begin
        ExistDir:=true;
     end
    else ExistDir:=false;
    chdir(corr);
 end;

procedure writeW(s:string;nst:integer);
var str70:st70;
    pc70,PC71:array[0..70] of char;
begin
  {$ifdef dos}
  write(s);
  {$endif}
  {$ifdef win}
   {case aw of
   1:st_8:='writewin';
   2:st_8:='wwin1';
   end;
   }
   a_w:=numerotabella(st_8,hd,2);
   if nst>0 then
   begin
   str70:=s;
   strpcopy(pc71,str70);
   OEMtoANSI(PC71,PC70);
   tabellacorrente^[a_w].dialog^.st_mess[nst]^.settext(pc70);
   end;
  {$endif}
end;

procedure writelnW(s:string;nst:integer);
var str80:st80;
    pc80,PC81:array[0..80] of char;
begin
  {$ifdef dos}
   writeln(s);
  {$endif}
  {$ifdef win}
   if nst>0 then
   begin
   {case aw of
   1:st_8:='writewin';
   2:st_8:='wwin1';
   end;}
   a_w:=numerotabella(st_8,hd,2);
   str80:=s;
   strpcopy(pc81,str80);
   OEMTOANSI(PC81,PC80);
   tabellacorrente^[a_w].dialog^.st_mess[nst]^.settext(pc80);
   end;
  {$endif}
end;

procedure copia(org:string);
var
{$ifdef win}
s:tsearchrec;
nomep:array[0..80] of char;
nomes:string[80];
{$endif}
{$ifdef dos}
s:searchrec;
{$endif}
pathcorr:string;
begin
  {$ifdef dos}
  findfirst(org,Archive,s);
  {$endif}
  {$ifdef win}
  nomes:=org;
  strpcopy(nomep,nomes);
  findfirst(nomep,faArchive,s);
  {$endif}
  getdir(0,pathcorr);
  while doserror=0 do
  begin
   copiafile(copy(org,1,3)+s.name,pathcorr+'\'+s.name);
   findnext(s);
  end;
end;

procedure copiafile(forg,fdest:string);

var numletti,numscritti:word;
    buf:array[1..2048] of char;
    daf,af:file;
begin
  if not exist(forg) then
  begin
    writemessage('utiliti.msg',3);
    exit;
  end;
  assign(daf,forg);
  reset(daf,1);
  assign(af,fdest);
  rewrite(af,1);
  repeat
    blockread(daf,buf,sizeof(buf),numletti);
    blockwrite(af,buf,numletti,numscritti);
  until (numletti=0) or (numscritti<>numletti);
  close(daf);
  close(af);
end;


procedure writewd(nome:st80);
var pcs:array[0..80] of char;
begin
  {$ifdef dos}
  write(nome);
  {$endif}
  {$ifdef win}
   strpcopy(pcs,nome);
   messagebeep(10);
   oemtoansi(pcs,pcs);
   bwccmessagebox(0,'Mc4-Hvac',pcs,mb_ok or mb_iconhand);
  {$endif}
end;
procedure Copiapianta(maschera:string;riga:integer);
var  FILeplt:STRING[79];
     p79:array[0..79] of char;
     dircorr:string;
     linea:integer;
     filedplt:string;
     filepname:pchar;
     startpos:integer;
     exitchar:char;
     modflag:boolean;
     x:integer;
     f:file;
begin
  if formst(maschera)='PIANTE' then
    x:=3
  else
    x:=11;
  hd:=0;
  if maschera>'' then
  begin
    st_8:=maschera;
    a_w:=numerotabella(st_8,hd,2);
    linea:=tabellacorrente^[a_w].dialog^.numerolineatabella;
  end;
  filepname:=@p79;
  strpcopy(filepname,'*.plt');
  getdir(0,dircorr);
  if Application^.ExecDialog(New(PFileDialog,
  Init(nil, MakeIntResource(sd_Fileopen),filepname))) = id_OK then
  begin
    fileplt:=strpas(filepname);
    filedplt:=eliminadir(fileplt);
    setcursor(cur_asp);
    if driveplt>'' then
    begin
      if maschera='' then filedplt:=nomeprog+'.plt';
      copiafile(fileplt,driveplt+filedplt);
      if maschera>'' then
      begin
        aggiornadatowin(copy(filedplt,1,length(filedplt)-4),linea*x-(x-1),a_w);
        setdata:=false;
      end;
      filedplt:=copy(filedplt,1,length(filedplt)-3);
      filedplt:=driveplt+filedplt+'dlt';
      if exist(filedplt) then
      begin
        assign(f,filedplt);
        erase(f);
      end;
    end;
  end;
  chdir(dircorr);
end;

function get_drive:string;
var f:text;
    dr:string;
begin
  ASSIGN(f,'drive1.int');
  RESET(f);
  read(f,dr);
  close(f);
  Get_drive:=dr;
end;

(*
procedure WriteMessage(Nome:st80;i:integer);
var f    : text;
    Riga : st80;
    k,fn : integer;

    r1,r2  :string[30];
    r3     :string[20];
    pc: record
           pc1,pc2:array[0..30] of char;
           pc3:array[0..20] of char;
        end;
    {$ifdef win}
    rigal:string[82];
    pcl,pcs,pcat:array[0..82] of char;
    hd:hwnd;
    {$endif}
    CH:CHAR;
begin
   if exist(nome) then
   begin
     assign(f,Nome);
     reset(f);
     for k:=1 to i do readln(f,Riga);
     close(f);
   end
   else
   begin
   str(i,r1);
   riga:=nome+' linea numero '+r1;
   end;
    {$Ifdef dos}
     write(chr(7));
     textbackground(4);   textcolor(14);
     gotoxy(1,21);  write(Riga+' <ENTER>');
     textbackground(col[1]);   textcolor(col[2]);   ClrEol;
     REPEAT
       ch:=readkey;
     until ch=#13;
     gotoxy(1,21);     ClrEol;
    {$endif}
    {$Ifdef Win}
     r1:=copy(riga,1,30)+#10;
     r2:=copy(riga,31,60)+#10;
     r3:=copy(riga,61,80);
     rigal:=r1+r2+r3;

     strpcopy(pcs,rigal);
     messagebeep(10);
     oemtoansi(pcs,pcl);
     rigal:='Mc4-hvac';
     strpcopy(pcs,rigal);
     messagebeep(10);

     oemtoansi(pcs,pcat);
     bwccmessagebox(0,pcl,pcat,mb_ok or mb_iconhand);
    {$endif}
end;
*)

procedure WriteMessage(Nome:string;i:integer);
var f      : text;
    Riga   : string;
    r1,r2,r3 :string[50];
    pc1:array[0..150] of char;
    rigal:string[150];
    k,a,j:integer;
begin
   if exist(nome) then
   begin
     assign(f,Nome);
     reset(f);
     for k:=1 to i do readln(f,Riga);
     close(f);
   end
   else riga:=nome;
   if length(riga)>50 then
   begin
     k:=length(riga) div 3;
     a:=k;
     while (riga[a]<>' ') and (a<length(riga)) do inc(a);
     r1:=copy(riga,1,a)+#10;
     j:=a+k;
     while (riga[j]<>' ') and (j<length(riga)) do inc(j);
     r2:=copy(riga,a+1,j-a)+#10;
     if j<length(riga) then
     r3:=copy(riga,j+1,length(riga))
     else r3:='';
     rigal:=r1+r2+r3;
   end
   else
   rigal:=riga;
   strpcopy(pc1,rigal);
   oemtoansi(pc1,pc1);
   messagebeep(10);
   k:=length(rigal);
   wvsprintf(pc1,pc1,k);
   if pmainwin<>nil then
   WINPROCS.messagebox(pmainwin^.hwindow,pc1,'Mc4-hvac',mb_ok)
   else
   WINPROCS.messagebox(0,pc1,'Mc4-hvac',mb_ok)
end;

procedure WriteMessage1(Nome:st80;i:integer;agg:string);
var f    : text;
    Riga : st80;
    k,fn : integer;

    r1,r2  :string[30];
    r3     :string[20];
    pc: record
           pc1,pc2:array[0..30] of char;
           pc3:array[0..20] of char;
        end;
    {$ifdef win}
    rigal:string[82];
    pcl,pcs,pcat:array[0..82] of char;
    hd:hwnd;
    {$endif}
    CH:CHAR;
begin
   if exist(nome) then
   begin
     assign(f,Nome);
     reset(f);
     for k:=1 to i do readln(f,Riga);
     close(f);
   end
   else
   begin
   str(i,r1);
   riga:=nome+' linea numero '+r1;
   end;
    {$Ifdef dos}
     write(chr(7));
     textbackground(4);   textcolor(14);
     gotoxy(1,21);  write(Riga+' '+agg+' <ENTER>');
     textbackground(col[1]);   textcolor(col[2]);   ClrEol;
     REPEAT
       ch:=readkey;
     until ch=#13;
     gotoxy(1,21);     ClrEol;
    {$endif}
    {$Ifdef Win}
     r1:=copy(riga,1,30)+#10;
     r2:=copy(riga,31,60)+#10;
     r3:=copy(riga,61,80);
     rigal:=r1+r2+r3+agg;
     strpcopy(pcs,rigal);
     messagebeep(10);
     oemtoansi(pcs,pcl);
     rigal:='Mc4-hvac';
     strpcopy(pcs,rigal);
     messagebeep(10);

     oemtoansi(pcs,pcat);
     bwccmessagebox(0,pcl,pcat,mb_ok or mb_iconhand);
    {$endif}
end;


Function ReadLineHelp(Nomefile:string;RigaHp,campo:Integer):String;

Var i:Integer;
    FHP:Text;
    BufH:String[80];
    nome_ins:string[80];
    campO_ins:string[3];
begin
ReadLineHelp:='';

{$I-}
NomeFile:=(copy(nomefile,1,length(Nomefile)-3)+'lhp');

NOMEFILE:=DRIVEMASK+NOMEFILE;
IF NOT EXIST(NOMEFILE) THEN
NOMEFILE:=ELIMINADIR(NOMEFILE);
{NomeFile:=(copy(nomefile,1,length(Nomefile)-3)+'lhp');}
assign(FHp,NomeFile);
reset(fhp);
for i:=1 to RigaHp do readln(Fhp,bufH);
close(Fhp);
{$I+}
if ioresult=0 then
begin
  {$ifdef win}
  ar_ins^[campo]:=tabellacorrente^[a_w].dialog^.ar_instab^[campo];
  {$endif}
  str(campo,campo_ins);
  nome_ins:=(copy(nomefile,1,length(Nomefile)-3)+'L'+campo_ins);
  if exist(nome_ins) or ((ar_ins^[campo].nfile>'') and (exist(ar_ins^[campo].nfile))) then
  BEGIN
    delete(Bufh,74,79);
    insert('<INS>',BUFH,74);
  end;
  ReadLineHelp:=BufH;
end;
end;


function Ind_Ins(st_cerc:string;campo:integer):integer;
begin
  ind_ins:=1;
end;



procedure CampoSucc(var Campo:integer);
   begin
      repeat
         if Campo >= UltimoCampo then Campo:=1
         else Campo:=Campo+1;
      until Tabella^[Campo].Flag;
   end;

procedure CampoPrec(var Campo:integer);
   begin
      repeat
         if Campo > 1 then Campo:=Campo-1
         else Campo:=UltimoCampo;
      until Tabella^[Campo].Flag;
   end;


function numerolum(ch:char):integer;

 begin
   case ch  of
   'L':  numerolum:=1;
   'S':  numerolum:=2;
   'l':  numerolum:=3;
   'K':  numerolum:=4;
   'D':  numerolum:=5;
   'J':  numerolum:=6;
   'Q':  numerolum:=7;
   'W':  numerolum:=8;
   'w':  numerolum:=9;
   'M':  numerolum:=10;
   'm':  numerolum:=11;
   'P':  numerolum:=12;
   'V':  numerolum:=13;
   'v':  numerolum:=14;
  end;
 end;



  procedure InitTabella;
  var i:integer;
  begin

     for i:=1 to 25 do Mappa^[i]:=format(' ',79);
     for i:=1 to MaxCampi do
     with Tabella^[i] do
       begin
          Flag:=false;
          Tipo:='n';
          L:=0;
          x:=0;y:=0;
          BAddr:=0;OAddr:=0;
          CifreInt:=0;CifreDec:=0;
          help:=0;
          NCampoTab:=i;
          modificato:=false;
          nlineum:=0;
          num:=0;
          subtipo:=' ';
          {$ifdef win}
          p:=nil;
          pcb:=nil;
          pck:=nil;
          {$endif}
       end;
  end;

procedure LeggiMask(NomeF:st80;nlinea:integer);
  const
     x=#157;
     xcb=#158;
     xrb=#155;
     xmb=#154;
     inf=#168;
     infum=#176;
  var
     f,fhp:text;
     ch:char;
     variabile:String[240];
     I,J,Cx,Cy,cyn:integer;
     flag1:integer;
     buff:String;
     NCP:integer;
     stNcp,nomefilef:String;
     nCifre,error:integer;
     CampiTab,NumHelp:Integer;
     mescor:integer;
     num2,nriga:integer;
     finemaskera,trovato,exfile:boolean;
     procedure cercamask;
     begin
       readln(f,buff);
       inc(nriga);
       nomef:=upstring(nomef);
       while not trovato and not eof(f) do
       begin
         trovato:=buff[1]='#';
         if not trovato then
         begin
           readln(f,buff);
           inc(nriga);
         end
         else
         begin
           trovato:=copy(buff,2,length(buff)-1)=nomef;
           if not trovato then
           begin
             readln(f,buff);
             inc(nriga);
           end;
         end;
       end;
     end;
  begin
     mescor:=0;
     {
     Nom_mask:=NomeF;
     NOMEF:=DRIVEMASK+NOMEF;
     IF NOT EXIST(NOMEF) THEN
     NOMEF:=ELIMINADIR(NOMEF);
     IF NOT EXIST(NOMEF) THEN
     BEGIN

     WRITE('FILE INSISTENTE ',NOMEF);
     HALT;

     END;
     }
     nriga:=0;
     NumHelp:=0;
     ninfo:=0;
     ninfoum:=0;
     CampiTab:=0;
     UltimoAccesso:=0;
     I:=0;Cx:=0;Cy:=1;
     {$ifdef scanplus}
     nomefilef:='masks.mas';
     {$else}
     nomefilef:=DRIVEMASK+'masks.mas';
     {$endif}

     assign(f,NomefileF);
     reset(f);
     trovato:=false;
     cercamask;
     if not trovato then
     begin
       close(f);
       nomefilef:=eliminadir(nomefilef);
       assign(f,NomefileF);
       reset(f);
       cercamask;
       if not trovato then
       begin
         write('Non trovo ',nomef,' in ',nomefilef);
         halt;
       end;
     end
     else
     {$ifdef scanplus}
     {$else}
     nomef:=drivemask+nomef;
     {$endif}

     assign(fhp,copy(NomeF,1,length(nomef)-3)+'lhp');
     rewrite(fhp);

     if nlinea>0 then  for j:=1 to nlinea do readln(f,buff);
     finemaskera:=false;
     while not(eof(f)) and not finemaskera do
     if cy<=23 then     {-- Help --}
     begin
         read(f,ch);
         finemaskera:=ch='#';
         Cx:=Cx+1;
         if (ch = x) or (ch=xcb) or (ch=xrb) or (ch=xmb) then
         begin
             I:=I+1;
             with Tabella^[I] do
              begin
                 if (ch=xcb) then subtipo:='B';
                 if (ch=xrb) then subtipo:='R';
                 if (ch=xmb) then subtipo:='M';
                 read(f,Tipo);
                 x:=Cx;y:=Cy;
                 Cx:=Cx+1;
                 variabile:='';
                 if tipo in ['i','I','r','R','$','s','C','c','T','t'] then
                 begin
                   repeat
                      read(f,ch);
                      Cx:=Cx+1;
                      if ch in ['0'..'9'] then variabile:=variabile+ch;
                   until not(ch in['0'..'9']);
                   flag1:=0;
                   val(variabile,L,flag1);

                   if (flag1 <> 0) or (length(variabile) = 0) then L:=2;

                  if ch = ':' then
                  begin
                     variabile:='';
                     repeat
                        read(f,ch);
                        Cx:=Cx+1;
                        if ch in ['0'..'9'] then variabile:=variabile+ch;
                     until not(ch in['0'..'9']);
                     flag1:=0;
                     val(variabile,CifreDec,flag1);
                     if (flag1 <> 0) or (length(variabile) = 0) then CifreDec:=0;
                  end;
                 end
                 else
                 begin
                   mescor:=mescor+1;
                   variabile:='';
                   read(f,ch);
                   Cx:=Cx+1;
                   if ch in ['0'..'9'] then variabile:=variabile+ch;
                   flag1:=0;
                   val(variabile,L,flag1);
                   if (flag1 <> 0) or (length(variabile) = 0) then L:=0;
                   read(f,ch);
                   Cx:=Cx+1;
                   variabile:='';
                   read(f,ch);
                   Cx:=Cx+1;
                   if ch in ['0'..'9'] then variabile:=variabile+ch;
                   flag1:=0;
                   val(variabile,num,flag1);
                   if (flag1 <> 0) or (length(variabile) = 0) then num:=0;
                   nlineum:=numerolum(tipo);
                   case num of
                   1:tipo:='R';
                   2:begin
                      num:=1;
                      tipo:='r';
                     end;
                  3:BEGIN
                     tipo:='R';
                     num:=2;
                    END;
                  4:begin
                      num:=2;
                      tipo:='r';
                     end;
                  end;
                  cifredec:=arkum^[nlineum].um[num].dec;
                 end;
                 BAddr:=BaseMask;OAddr:=OffSetMask;
                 case Tipo of
                   'I','i':
                     begin
                        CifreInt:=L;
                        OffSetMask:=OffSetMask+2;
                        Flag:=(Tipo = 'I');
                     end;
                   'R','r':
                     begin
                        if L > 0 then L:=L+1;
                        OffSetMask:=OffSetMask+6;
                       CifreInt:=L;
                        Flag:=(Tipo = 'R');
                     end;
                   'T','t':
                     begin
                        if L > 0 then L:=L+1;
                        OffSetMask:=OffSetMask+6;
                        CifreInt:=L;
                        Flag:=(Tipo = 'T');
                     end;
                   '$','s':
                     begin
                        OffSetMask:=OffSetMask+L+1;
                        Flag:=(Tipo = '$');
                     end;
                   'C','c':
                     begin
                        OffSetMask:=OffSetMask+L;
                        Flag:=(Tipo = 'C');
                     end;
                   else
                 end;
(*                 writeln('ultimoCampo ',ultimocampo);delay(1000);*)
                 UltimoCampo:=I;
                 if Tipo in ['$','R','I','C','T'] then UltimoAccesso:=I;
             end;
         end;

         if ch = chr(13) then
          begin
             Cy:=Cy+1;
             Cx:=-1;
          end;

         if (ch <> #13) and (ch <> ' ') and (ch <> #10)  then
          begin
          if ch=inf then
            begin
            ninfo:=ninfo+1;
            with info^[ninfo] do
              begin
              ix:=cx;iy:=cy;
              end
            end
          else
          if ch=infum then
            begin
            ninfoum:=ninfoum+1;
            with infoum^[ninfoum] do
              begin
              ix:=cx;iy:=cy;
              read(f,ch);
              Cx:=Cx+1;
              if ch<>'T' then
              begin
                messum^[ninfoum].n1:=numerolum(ch);
                variabile:='';
                read(f,ch);
                Cx:=Cx+1;
                if ch in ['0'..'9'] then variabile:=variabile+ch;
                flag1:=0;
                val(variabile,num2,flag1);
                if (flag1 <> 0) or (length(variabile) = 0) then num2:=0;
                messum^[ninfoum].n2:=num2;
              end
              else
              begin
                messum^[ninfoum].n1:=0;
                messum^[ninfoum].n2:=1;
              end;
              end
            end
          else

{            write(lst,' cy  ',cy,'  cx  ',cx);}
            if W_Uio then Mappa^[Cy][Cx]:=ch;
          end;
    end
    else
    begin            {--- stringa di help ---}
      readln(f,Buff);
      if length(buff)>2 then
      begin
        if buff[1]=Chr(13) then Buff:=copy(Buff,2,length(Buff));
        stncp:='';
        NCifre:=1;
        while (Buff[NCifre]<>':')and(NCifre<length(Buff)) do
          begin
          stncp:=stncp+buff[ncifre];
          NCifre:=NCifre+1;
          end;
        val(stncp,NCP,error);
        if (error=0)and(copy(Buff,NCifre+1,Length(Buff))='TAB') then
        Campitab:=NCP
        else
        begin
          if error=0 then
          begin
            NumHelp:=NumHelp+1;
            Tabella^[NCP].Help:=NumHelp;
            writeln(fhp,copy(Buff,NCifre+1,Length(Buff)));
            if CampiTab<>0 then
            for i:=1 to ultimocampo do
            if ((i mod Campitab)=Ncp)or(((i mod Campitab)=0)and(ncp=Campitab))
            then
            begin
              Tabella^[i].Help:=NumHelp;
              Tabella^[i].NCampoTab:=NCP;
            end;
          end;
        end;
      end;
      finemaskera:=buff[1]='#';
    end;

     close(f);
     close(fhp);
     If CampiTab<>0 then NumCampiTab:=CampiTab
     else CampiTab:=UltimoCampo;

     for i:=Cy+1 to 25 do Mappa^[i]:='';


  end;


procedure leggi2mask(nomef:string);
var linea:string;
    i,nlinea,k:integer;
    ch:char;
    f:text;
    variabile:String[240];
    J:integer;
    flag1:integer;
    oscurato:boolean;
    conta : integer;
    buff:String;
    NCP:integer;
    stNcp:String;
    nCifre,error:integer;
    CampiTab,NumHelp:Integer;
    exfile:BOOLEAN;
    OFFSETTEMP:INTEGER;
    nomefilef:string;
    trovato:BOOLEAN;
const x='';
      xb='ž';
      xrb=#155;
      xmb=#154;

procedure cercamask;
begin
  readln(f,linea);
  nomef:=upstring(nomef);
  while not trovato and not eof(f) do
  begin
    trovato:=linea[1]='#';
    if not trovato then
    begin
      readln(f,linea);
    end
    else
    begin
      trovato:=copy(linea,2,length(linea)-1)=nomef;
      if not trovato then
      begin
        readln(f,linea);
      end;
    end;
  end;
end;

begin

  dimtab:=0;
  ncampscuri:=0;
  ncampimista:=false;
  exfile:=false;
  nlinea:=1;
  {$ifdef scanplus}
  nomefilef:='masks.mas';
  {$else}
  nomefilef:=DRIVEMASK+'masks.mas';
  {$endif}
  assign(f,nomefilef);
  reset(f);
  trovato:=false;
  cercamask;
  if not trovato then
  begin
    close(f);
    nomefilef:=eliminadir(nomefilef);
    assign(f,nomefilef);
    reset(f);
    cercamask;
    if not trovato then
    begin
      write('Non trovo ',nomef,' in ',nomefilef);
      halt;
    end;
  end;
  readln(f,linea);
  linea:=setleft(setright(linea));
  I:=0;
  tabellamista:=false;
  if upstring(linea)='MISTA' then
  begin
    offsettemp:=offsetmask;
    while not (linea='FINEMISTA') do
      begin
         readln(f,linea);
         linea:=setleft(setright(linea));
         nlinea:=nlinea+1;
         j:=0;
         if linea>'' then
         repeat
         j:=j+1;
         if (linea[j] = x) or (linea[j] = xb) or (linea[j]=xrb) or (linea[j]=xmb) then
          begin
             I:=I+1;
             with Tabella^[I] do
              begin
                 j:=j+1;
                 Tipo:=linea[j];
                 variabile:='';
                 if tipo in ['i','I','r','R','$','s','C','c'] then
                 begin
                   repeat
                      j:=j+1;
                      ch:=linea[j];
                      if ch in ['0'..'9'] then variabile:=variabile+ch;
                   until not(ch in['0'..'9']);
                   flag1:=0;
                   val(variabile,L,flag1);

                   if (flag1 <> 0) or (length(variabile) = 0) then L:=2;

                  if ch = ':' then
                  begin
                     variabile:='';
                     repeat
                         j:=j+1;
                         ch:=linea[j];
                        if ch in ['0'..'9'] then variabile:=variabile+ch;
                     until not(ch in['0'..'9']);
                     flag1:=0;
                     val(variabile,CifreDec,flag1);
                     if (flag1 <> 0) or (length(variabile) = 0) then CifreDec:=0;
                  end;
                 end;
                 BAddr:=BaseMask;OAddr:=OffSetMask;
                 case Tipo of
                   'I','i':
                     begin
                        CifreInt:=L;
                        OffSetMask:=OffSetMask+2;
                        Flag:=(Tipo = 'I');
                     end;
                   'R','r':
                     begin
                        if L > 0 then L:=L+1;
                        OffSetMask:=OffSetMask+6;
                        CifreInt:=L;
                        Flag:=(Tipo = 'R');
                     end;
                   'T','t':
                     begin
                        if L > 0 then L:=L+1;
                        OffSetMask:=OffSetMask+6;
                        CifreInt:=L;
                        Flag:=(Tipo = 'T');
                     end;
                   '$','s':
                     begin
                        OffSetMask:=OffSetMask+L+1;
                        Flag:=(Tipo = '$');
                     end;
                   'C','c':
                     begin
                        OffSetMask:=OffSetMask+L;
                        Flag:=(Tipo = 'C');
                     end;
                   else
                 end;
             end;
          end;
          UltimoCampo:=I;
          until j>=length(linea);
      end;
      readln(f,Buff);
      nlinea:=nlinea+1;
      if length(buff)>2 then
      begin
        if buff[1]=Chr(13) then Buff:=copy(Buff,2,length(Buff));
        stncp:='';
        NCifre:=1;
        while (Buff[NCifre]<>':')and(NCifre<length(Buff)) do
        begin
          stncp:=stncp+buff[ncifre];
          NCifre:=NCifre+1;
        end;
        val(stncp,NCP,error);

        if (error=0)and(copy(Buff,NCifre+1,Length(Buff))='TAB') then
        Campitab:=NCP;

        if CampiTab<>0 then
        for i:=1 to ultimocampo do

        if (((i mod Campitab)=0)and(ncp=Campitab))
        then Tabella^[i].NCampoTab:=NCP
        else tabella^[i].NCampoTab:=(i mod campiTab);

      end;
     fillchar(campivis,sizeof(campivis),0);
     while linea<>'CAMPI' do
     begin
       readln(f,linea);
       linea:=setleft(setright(linea));
       nlinea:=nlinea+1;
     end;
     while linea<>'FINECAMPI' do
     begin
       readln(f,linea);
       linea:=setleft(setright(linea));
       nlinea:=nlinea+1;
       j:=0;
       i:=0;
       if (linea>'') and (upstring(linea)<>'CAMPI') AND (upstring(linea)<>'FINECAMPI') then
       repeat
         variabile:='';
         repeat
           j:=j+1;
           ch:=linea[j];
           if ch<>',' then variabile:=variabile+ch;
         until (ch=',') or (ch=' ');
         i:=i+1;
         flag1:=0;
         val(variabile,campivis[i],flag1);
         if flag1<>0 then
         campivis[i]:=0 else
         ncampscuri:=i;
         ncampimista:=true;
       until j>=length(linea);

     end;
     ultimocampomista:=ultimocampo;
     i:=spacetab(offsettemp);
     dimtab:=i;
     tabmista^:=tabella^;
     mappamista^:=mappa^;
     tabellamista:=true;
     inittabella;
     offsetmask:=offsettemp;
     close(f);
     NOMEF:=ELIMINADIR(NOMEF);
     leggimask(nomef,nlinea);
     k:=0;
     for i:=1 to ultimocampomista do
     with tabmista^[i] do
     begin
       oscurato:=false;
       j:= 1;
       While (j<= maxcampivis) and not oscurato do
       begin
         if campivis[j]=ncampotab then oscurato:=true;
         j:=j+1;
       end;
       if not oscurato then
       begin
         k:= k+1;
         tabella^[k].oaddr:=tabmista^[i].oaddr;
       end;
     end;
  end
  else
  begin
    close(f);
    NOMEF:=ELIMINADIR(NOMEF);
    leggimask(nomef,0);
  end;
end;

procedure Prog_To_Ark(nomeark,nomefile,nomemask:string;nline:integer;modo:integer);

type pt1=array[1..2048] of char;

var f,f1:file ;
    tab:^tabellarec;
    map:^tabellamap;
    i,j:integer;
    iofs,iseg,spag,nletti:word;
    pcombo1:^pt1;
    fs,nl:longint;

begin
{if exist(nomemask) then}
begin
  new(tab);
  new(map);
  tab^:=tabella^;
  map^:=mappa^;
  new(pcombo1);
  inittabella;
  fillchar(pcombo1^,sizeof(pcombo1^),0);
  iofs:=ofs(pcombo1^);
  iseg:=seg(pcombo1^);
  basemask:=iseg;
  offsetmask:=iofs;
  w_uio:=false;
  leggi2mask(eliminadir(NOMEmask));
  IF TABELLAMISTA then
  begin
    tabella^:=tabmista^;
    tabellamista:=false;
    ultimocampo:=ultimocampomista;
  end;
  iofs:=0;
  spag:=spacetab(iofs);

  tabella^:=tab^;
  mappa^:=map^;

  case modo of
  1:begin{inserisce}
    if exist(nomeark) then
    begin
      assign(f,nomeark);
      reset(f,spag);
      seek(f,filesize(f));
    end
    else
    begin
      assign(f,nomeark);
      rewrite(f,spag);
    end;
    assign(f1,nomefile);
    reset(f1,spag);
    seek(f1,nline-1);
    {for i:= 1 to  do
    begin
      fillchar(pcombo1^,sizeof(pcombo1^),0);
      blockread(f1,pcombo1^,1,nletti);
    end;}
    fillchar(pcombo1^,sizeof(pcombo1^),0);
    blockread(f1,pcombo1^,1,nletti);
    blockwrite(f,pcombo1^,1,nletti);
    end;

  2:begin{richiama}
    if exist(nomeark) then
    begin
      assign(f,nomeark);
      reset(f,spag);
      seek(f,nline-1);
      assign(f1,nomefile);
      reset(f1,spag);
      fs:=filesize(f1);
      if riga<fs then
      seek(f1,riga-1)
      else
      seek(f1,fs);
      fillchar(pcombo1^,sizeof(pcombo1^),0);
      blockread(f,pcombo1^,1,nletti);
      blockwrite(f1,pcombo1^,1,nletti);
    end;
    end;
  3:begin{cancella}
    if exist(nomeark) then
    begin
      assign(f,nomeark);
      reset(f,spag);
      assign(f1,nomefile);
      rewrite(f1,spag);
      j:=1;
      while not eof(f) do
      begin
        fillchar(pcombo1^,sizeof(pcombo1^),0);
        blockread(f,pcombo1^,1,nletti);
        if j<> nline then blockwrite(f1,pcombo1^,1,nletti);
        inc(j);
      end;
      close(f);
      close(f1);
      assign(f,nomeark);
      erase(f);
      assign(f,nomefile);
      rename(f,nomeark);
    end;
    end;
  end;
  if modo <> 3 then
  begin
    close(f);
    close(f1);
  end;
  dispose(map);
  dispose(tab);
  dispose(pcombo1);
end;
end;



procedure generains(tipo:integer;nomemask,nfile:string;nrighe,nrighep,ncampir,campov,campoD,lcampov,lcampod:integer);
type pt=array[1..65535] of BYTE;
     pt1=array[1..2048] of BYTE;
var
   pcombo1:^pt1;
   pcombo:^pt;

    dato,dato1:linestr;
    vhlp:rechlp;
    fhlp:file of rechlp;
    npag,spag,nletti,j:integer;
    iofs,iseg:word;
    f:file;
    nomeins:string[80];
    tab:^tabellarec;
    map:^tabellamap;
begin
  new(tab);
  new(map);
  {nomemask:=formst(nomemask);
  nfile:=formst(nfile);
  if not exist(nomemask) then
  NOMEmask:=DRIVEMASK+eliminadir(nomemask);
  IF NOT EXIST(NOMEmask) THEN
  NOMEMASK:=ELIMINADIR(NOMEmask);
  IF NOT EXIST(NOMEmask) THEN
  BEGIN
    WRITE('FILE INSISTENTE ',NOMEmask);
    HALT;
  END;
  }
  if exist(nfile) then
  begin
      npag:=nrighe div nrighep;
      tab^:=tabella^;
      map^:=mappa^;
      inittabella;
      new(pcombo);
      new(pcombo1);
      fillchar(pcombo1^,sizeof(pcombo1^),0);
      iofs:=ofs(pcombo1^);
      iseg:=seg(pcombo1^);
      basemask:=iseg;
      offsetmask:=iofs;
      w_uio:=false;

      leggi2mask(eliminadir(NOMEmask));
      IF TABELLAMISTA then
      begin
        tabella^:=tabmista^;
        tabellamista:=false;
        ultimocampo:=ultimocampomista;
      end;
      iofs:=0;
      spag:=spacetab(iofs);
      iofs:=ofs(pcombo1^);
      caraddress(iseg,iofs);
      assign(f,nfile);
      reset(f,spag);
      case tipo of
      1:nomeins:=Copy(Nfile,1,Length(Nfile)-4);
      3:begin
          nomeins:=Copy(Nomemask,1,Length(Nomemask)-4);
          nomeins:=eliminadir(nomeins);
          nomeins:=drivearc+'\'+nomeins;
        end;
      2:begin
          nomeins:=Copy(NomeMask,1,Length(Nomemask)-4);
          nomeins:=eliminadir(nomeins);
          nomeins:=driveprog+nomeins;
        end;
      end;
      assign(fhlp,nomeins+'.ins');
      rewrite(fhlp);
      str(lcampod,vhlp.descr);
      str(lcampov,vhlp.val);
      write(fhlp,vhlp);
      npag:=0;
      while not eof(f) do
      begin
        fillchar(pcombo1^,sizeof(pcombo1^),0);
        blockread(f,pcombo1^,1,nletti);

        for j:=1 to nrighep do
        begin
          leggidato1(dato,ncampir*(j-1)+campod);
          if campov >0 then
          begin
            leggidato1(dato1,ncampir*(j-1)+campov);
            vhlp.val:=dato1;
            dato1:='';
          end;

          if campov=0 then
          str(npag*nrighep+j,vhlp.val);
          if campov=-1 then vhlp.val:='';

          vhlp.descr:=dato;
          dato:='';
          IF setleft(setright(vhlp.descr))>'' then
           begin
              if campov > 0 then
               begin
                  IF setleft(setright(vhlp.Val))>'' then write( fhlp,vhlp);
               end
              else write( fhlp,vhlp);
           end;
        end;
        npag:=npag+1;
      end;
      close(f);
      close(fhlp);
      dispose(pcombo);
      dispose(pcombo1);
      tabella^:=tab^;
      mappa^:=map^;
      dispose(map);
      dispose(tab);
   end;
end;





function SpaceTab(InADDR:word):integer;
  var OfsAddr:word;i:integer;
  begin
     if dimtab=0 then
     begin
     with Tabella^[UltimoCampo] do
      begin
         OfsAddr:=OAddr-InADDR;
         case Tipo of
          '$','s':OfsAddr:=OfsAddr+L+1;
          'C','c':OfsAddr:=OfsAddr+L;
          'R','r',
          'T','t':OfsAddr:=OfsAddr+6;
          'I','i':OfsAddr:=OfsAddr+2;
         end;
      end;
     SpaceTab:=OfsAddr;
     end
     else
     spacetab:=dimtab;
  end;


procedure LeggiDato1(var Dato:linestr;I:integer);
 var realtemp:real;
      PInt :^integer;
      PStr :^st240;
      PReal:^real;
      Pchar:^char;
      notzero:boolean;

  begin
     notzero:=true;
     with Tabella^[I] do
      begin
         case Tipo of
           'I','i':
             begin
                PInt:=ptr(BAddr,OAddr);
                if (PInt^ = 0) and notzero then Dato:=''
                else str(PInt^:L,Dato);
                Dato:=SetLeft(SetRight(Dato));
             end;
           'R','r':
             begin
                PReal:=ptr(BAddr,OAddr);
                if (PReal^ = 0) and notzero then Dato:=''

                else
                begin
                   realtemp:=preal^;
                   str(realtemp:L:CifreDec,Dato);
                end;
                Dato:=SetLeft(SetRight(Dato));
             end;
           'T','t':
             begin
                PReal:=ptr(BAddr,OAddr);
                realtemp:=preal^;
                str(realtemp:L:CifreDec,Dato);
                Dato:=SetLeft(SetRight(Dato));
             end;
           '$','s':
             begin
                PStr:=ptr(BAddr,OAddr);
                Dato:=SetLeft(SetRight(PStr^));
             end;
           'C','c':
             begin
                PChar:=ptr(BAddr,OAddr);
                Dato:=' ';
                Dato[1]:=PChar^;
             end;
           else Dato:='';
         end;
         {Dato:=format(Dato,L);}
      end;

  end;

 procedure CarAddress(Base,OffSet:word);
 var i,j,k:integer;
     oscurato:boolean;
 begin
   if not tabellamista then
   begin
   for I:=1 to UltimoCampo do
    with Tabella^[i] do
      begin
         BAddr:=Base;OAddr:=OffSet;
         case Tipo of
          'I','i':
            begin
               CifreInt:=L;
               OffSet:=OffSet+2;
            end;
    'T','t','R','r':
            begin
               CifreInt:=L;
               OffSet:=OffSet+6;
            end;
          '$','s':OffSet:=OffSet+L+1;
          'C','c':OffSet:=OffSet+L;
          else
         end;
      end;
   end
   else
   begin

     for I:=1 to UltimoCampomista do
     with Tabmista^[i] do
     begin
       BAddr:=Base;OAddr:=OffSet;
       case Tipo of
        'I','i':
               begin
                 CifreInt:=L;
                 OffSet:=OffSet+2;
               end;
    'T','t','R','r':
               begin
                 CifreInt:=L;
                 OffSet:=OffSet+6;
               end;
          '$','s':OffSet:=OffSet+L+1;
          'C','c':OffSet:=OffSet+L;
          else
         end;
      end;
     k:=0;
     for i:=1 to ultimocampomista do
     with tabmista^[i] do
     begin
       oscurato:=false;
       j:= 1;
       While (j<= maxcampivis) and not oscurato do
       begin
         if campivis[j]=ncampotab then oscurato:=true;
         j:=j+1;
       end;
       if not oscurato then
       begin
         k:= k+1;
         tabella^[k].oaddr:=tabmista^[i].oaddr;
       end;
     end;
   end
  end;







{$Ifdef Win}

function nlinetab(nw:integer):integer;
var lm:integer;
    hd:hwnd;

begin
  with tabellacorrente^[nw].dialog^ do
  if isiotab then
  begin
  lm:=(campoprecedente-100) div datrg;
  if  (campoprecedente-100) mod datrg <>0 then lm:=lm+1;
  nlinetab:=scrolla^.GETPOSITION+lm-1;
  end;

end;

function nlinetab1(nw:integer):integer;
var lm:integer;
    hd:hwnd;

begin
  with tabellacorrente^[nw].dialog^ do
  if isiotab then
  begin
  lm:=(campoattivo-100) div datrg;
  if  (campoattivo-100) mod datrg <>0 then lm:=lm+1;
  nlinetab1:=scrolla^.GETPOSITION+lm-1;
  end;

end;



 function numerotabella(var tabcerc:st8;Var ahandle:hwnd;modo:integer):integer;
var i,vuoto:integer;
    trovato:boolean;
begin
  i:=1;
  trovato:=false;
  vuoto:=0;
  case modo of
  1:begin {trova la tabella con l'handle specificato}
      while (i<= maxtabelle) and (not trovato) do
      begin
        trovato:=ahandle=tabellacorrente^[i].maniglia;
        i:=i+1;
      end;
      if trovato then
      begin
        numerotabella:=i-1;
        tabcerc:=tabellacorrente^[i-1].nome;
      end
      else numerotabella:=0;
    end;
  2:begin {trova la tabella con il nome specificato}
      while (i<= maxtabelle) and (not trovato) do
      begin
        trovato:=upstring(tabcerc)=upstring(tabellacorrente^[i].nome);
        i:=i+1;
      end;
      if trovato then
      begin
        numerotabella:=i-1;
        ahandle:=tabellacorrente^[i-1].maniglia;
      end
      else numerotabella:=0;
    end;
   3:begin {trova il primo spazio libero in tabella}
       repeat
         vuoto:=vuoto+1;
       until tabellacorrente^[vuoto].nome='';
       numerotabella:=vuoto;
     end
   end;
end;

{-----------------------   tasto ins ----------------------------}


constructor tpopup.init(aparent:pwindowsobject;atitle:pchar;ax,ay,aw,ah,acampo,afin:integer;adef_ins:recins;uazione:boolean);
var style,tlen:word;
begin
  azione:=uazione;
  x:=ax;
  y:=ay;
  h:=ah;
  w:=aw;
  campo:=acampo;
  fin:=afin;
  def_ins:=adef_ins;
  nmessaggi:=0;
  inherited init(aparent,atitle);

  tlen:=w div 8;
  lista:=new(plistbox,initresource(@self,10100));{,5,5,w,h));}
  messaggio:=new(ppcharcollection,INIT(10,10));

end;

procedure tpopup.setupwindow;
var i:integer;
    pcm:pchar;
begin
  inherited SetupWindow;
  for i:=0 to nmessaggi-1 do
  begin
    pcm:=pchar(messaggio^.at(i));
    if pcm<>nil then
    begin
      oemtoansi(pcm,pcm);
      lista^.addstring(pcm)
    end;
  end;
end;

procedure Tpopup.wminitdialog(var msg:owindows.Tmessage);
var R:trect;
    dc:hdc;
    ls,a_s:integer;
begin
 inherited wminitdialog(msg);
 dc:=getdc(msg.receiver);
 Ls:=getdevicecaps(dc,horzres);
 A_s:=getdevicecaps(dc,vertres);
 releasedc(msg.receiver,dc);
 x:=(ls-(w+15)) div 2 ;
 y:=(a_s-(h+25)) div 2;
 movewindow(msg.receiver,X,Y,w+15,h+25,false);
 movewindow(lista^.hwindow,1,1,w,h,false);
end;



procedure tpopup.wmcommand(var msg:owindows.tmessage);
var
  Idx: Integer;
  ItemText: array[0..70] of Char;
  st:string;
  hd:hwnd;
  i:integer;
  wr:word;
  campopostins,rigains:integer;
  chltemp,chltemp1:string;
begin
  inherited wmcommand(msg);

  if (HIWORD(msg.lParam)=lbn_dblclk) or (HIWORD(msg.lParam)=0) then
  begin
    Idx := Lista^.GetSelIndex;
    if lista^.GetStringLen(Idx) < SizeOf(ItemText) then
    begin
      with tabellacorrente^[fin].dialog^ do
      begin
        testodihelp:='';
        tpopup.enddlg(id_ok);
        lista^.GetSelString(ItemText, 70);
        st:=strpas(itemtext);
        {st:=ans_oem(st);}
        i:=0;
        repeat
        i:=i+1;
        until (st[i]=':') or (i=length(st));
        if (i< length(st)) or (st[i]=':') then
          begin
            if i< length(st) then
            begin
            testodihelp:=copy(st,i+1,length(st)-i);
            chltemp1:=copy(st,i+1,length(st)-i);
            chltemp:=copy(st,1,i-1);
            linetemp:=chltemp;
            end
            else
            testodihelp:='';
          end
        else
        BEGIN
          testodihelp:=st;
          linetemp:=st;
        END;
        if selezione and azione then
        begin
          if def_ins.ncampoagg=0 then
          begin
            aggiornadatowin(testodihelp,campo,fin);

          end
          else
          begin
            if def_ins.ncampiriga>0 then
            begin
              rigains:=campo div def_ins.ncampiriga;
              if campo mod def_ins.ncampiriga<> 0 then
              rigains:=rigains+1;
              campopostins:=(rigains-1)*def_ins.ncampiriga+
                                def_ins.ncampoagg;
            end
            else campopostins:=def_ins.ncampoagg;
            aggiornadatowin(chltemp,campo,fin);
            aggiornadatowin(chltemp1,campopostins,fin);
          end;
        end;
        tab^[campo].modificato:=true;
        sendmessage(tabellacorrente^[a_w].dialog^.getitemhandle(campo+100),wm_killfocus,
                    0,0);
        setfocus(tabellacorrente^[a_w].dialog^.getitemhandle(campo+101));
      end;
    end;
  end
  else DefWndProc(Msg);
end;

function tpopup.canclose:boolean;
var i:integer;
begin
  dispose(messaggio,done);
  canclose:=true;
end;

{-----------------------   tasto ins   fine ----------------------------}


{-----------------------   pfill_edit       ----------------------------}

constructor tfill_edit.init(acampo_cor:integer);

begin
Codice:=0;
campo_cor:=acampo_cor;
ncampo_out:=0;ncampo_agg:=0;
nriga:=0;nrighe:=0;nrighep:=0;ncampir:=0;
mask:='';nfile:='';
iseg:=0;iofs:=0;
new(elstring,init(10,10));
new(elstr);
end;

destructor tfill_edit.done;
begin
  dispose(elstring,done);
  dispose(elstr);
end;
procedure tfill_edit.Lista_rec(acampo,acod:integer;AMask:string;var rec;Acampo_rec,
                               Acampo_agg,acamporec_agg,Anrighe,Anrighe_T,Ancampi_R:integer);
begin
  iseg:=seg(rec);
  iofs:=ofs(rec);
  codice:=acod;
  ncampo_out:=acampo_rec;ncampo_agg:=Acampo_agg;ncamporec_agg:=acamporec_agg;
  nriga:=0;nrighe:=anrighe;nrighep:=anrighe_t;ncampir:=ancampi_r;
  mask:=Amask;
end;


procedure tfill_edit.Lista_file(acampo,acod:integer;AMask,Anfile:string;Acampo_rec,
                                Acampo_agg,acamporec_agg,Anrighe,Anrighe_T,Ancampi_R:integer);
begin

if campo_cor=acampo then
  begin

  codice:=acod;
  ncampo_out:=acampo_rec;ncampo_agg:=Acampo_agg;ncamporec_agg:=acamporec_agg;
  nriga:=0;nrighe:=anrighe;nrighep:=anrighe_t;ncampir:=ancampi_r;
  mask:=Amask;nfile:=Anfile;
  end;
end;

procedure tfill_edit.lista(acampo,acod:integer;aelstr:punstr);
begin
    codice:=acod;
    elstr^:=aelstr^;
end;


{-----------------------   fine pfill_edit  ----------------------------}




{-----------------------   combobox         ----------------------------}
constructor tmybox.initresource(aparent:pwindowsobject;aid:integer;atextlen:word;afill:proc1;
                                acampo:integer;atipo:char;ANlineaUm,ANum,al,acint,acdec:integer);

begin
  inherited initresource(aparent,aid,atextlen);
  cifreint:=acint;
  cifredec:=acdec;
  L:=al;
  nlineaum:=anlineaum;
  num:=anum;
  fill_box:=afill;
  campo:=acampo;
  tcampo_agg:=0;
  possochiudere:=true;
  new(elenco,init(10,10));
  carico:=false;
  tipo:=atipo;
  N_fin:=a_w;
end;

procedure tmybox.wmkillfocus(var msg:owindows.tmessage);
var st:string[3];
    pc:array[0..3] of char;
    hd:hwnd;
    Dato:linestr;
    campob:integer;
begin
    {ifdef testo}
    a_w:=N_fin;
    IF A_w>0 then
    with tabellacorrente^[a_w] do
    if dialog<>nil then
    with dialog^ do
    begin
      campoprecedente:=tmybox.getid;
      campob:=Campoprecedente-100;
      if (campob>=1) and (campob <= ultcampo) then
      begin
        dato:=readdato(campob,a_w);
        if (dato>'') and (Tab<>nil)  then
        TastoEnter(Dato,Nome+'.MSK',campob,Tab^[campob].NCampoTab,NumCampiTab);
      end;
    end;
  {endif}
  defwndproc(msg);
end;


procedure scrivibarra;
begin
  {$ifdef nobarra}
  {$else}
  {$ifdef testo}
  SendMessage(pmainwin^.HWindow,am_DrawStatusLine, A_W, 0);
  {$else}
  SendMessage(pmainwin^.HWindow,am_DrawStatusLine1, A_W, 0);
  {$endif}
  {$endif}
end;


procedure tmybox.wmsetfocus(var msg:owindows.tmessage);
var hd:hwnd;
    i:integer;

begin
   a_w:=n_fin;
   i:=getid;
   if tabellacorrente^[a_w].dialog <> nil then
   tabellacorrente^[a_w].dialog^.campoattivo:=i;
   scrivibarra;
   defwndproc(msg);
end;



procedure tmybox.wmkeydown(var msg:owindows.tmessage);
var st:string[3];
    pc:array[0..3] of char;
    st1:string;
    i,id:integer;
    action:boolean;
    hd:hwnd;
    campob:integer;
begin
  {Ifdef testo}

  a_w:=n_fin;
  with tabellacorrente^[a_w] do
  with dialog^ do
  begin
    campoprecedente:=getid;
    campob:=campoattivo-100;
    case MSG.wparam of

    39:begin {freccia a destra}
           if campob<datrg*datpg then
           begin
             camposucc(campob);
             if dialog<> nil then  SETFOCUS(Dialog^.GETItemHANDLE(Campob+100))
             else SETFOCUS(Dialog^.GETItemHANDLE(Campob+100));
           end
           else messagebeep(10);
           defwndproc(msg);
       end;

    37:begin {freccia a sinistra}
           if campob>1 then
           begin
             campoprec(campob);
             SETFOCUS(Dialog^.GETItemHANDLE(Campob+100))
           end
           else messagebeep(10);
           defwndproc(msg);
       end;
    17:begin
         controll:=true;
       end;
   112:begin
         if not controll then dialog^.tastof1 else
         begin
           controll:=false;
           vishelp(nome+'.hlp');
         end;
       end;
   113:begin
         if not controll then dialog^.tastof2 else
         begin
           controll:=false;
           str(campob,st_8);
           vishelp(nome+'.h'+st_8);
         end;
       end;
   114:begin
         if not controll then dialog^.tastof3 else
         begin
           controll:=false;
           vishelp('errori.hlp');
         end;
       end;
   115:begin
         dialog^.tastof4
       end;
   116:begin
         dialog^.tastof5
       end;
   117:begin
         dialog^.tastof6
       end;
   118:begin
         dialog^.tastof7
       end;
   119:begin
         dialog^.tastof8
       end;
   120:begin
         dialog^.tastof9
       end;
   121:begin
         dialog^.tastof10
       end;
   122:begin
         MESSAGEBEEP(19);
         dialog^.transferdata(tf_getdata);
         cambiamisure;
         dialog^.transferdata(tf_setdata);
         dialog^.setupwindow;
       end;
    else
    begin
      modificata:=true;
      defwndproc(msg);
    end;
  END;
end;
{endif}
end;



procedure tmybox.caricalista;

type pt=array[1..65535] of BYTE;
     pt1=array[1..65535] of BYTE;
var
npag,spag,i,j:integer;
strins:array[0..126] of char;
dato:linestr;
nletti:integer;
f:file;
pcombo1:^pt1;
pcombo:^pt;
pcb:pfill_edit;
NOMEF:string;
hlp:rechlp;
hlp_ldescr,
hlp_lval :integer;
fh:file of rechlp;
pass:array[0..15] of char;
sass:string[15];
begin

  new(pcb,init(campo));
  fill_box(pcb);
  cod:=pcb^.codice;



case cod of
2:begin
   NOMEF:=pcb^.mask;
   {if not exist(pcb^.mask) then
   NOMEF:=DRIVEMASK+eliminadir(pcb^.mask)
   else nomef:=pcb^.mask;
   IF NOT EXIST(NOMEF) THEN
   NOMEF:=ELIMINADIR(NOMEF);
   IF NOT EXIST(NOMEF) THEN
   BEGIN
    WRITE('FILE INSISTENTE ',NOMEF);
    HALT;
   END;}
   if exist(pcb^.nfile) then
   with pcb^ do
   begin
    if pcb^.campo_cor=campo then
    begin
      carico:=true;
      sass:=w_mw(134);
      strpcopy(pass,sass);
      elenco^.deleteall;
      elenco^.Insert(StrNew(pass));
      oemtoansi(pass,pass);
      addstring(pass);
      npag:=nrighe div nrighep;
      inittabella;
      new(pcombo);
      new(pcombo1);
      fillchar(pcombo1^,sizeof(pcombo1^),0);
      iofs:=ofs(pcombo1^);
      iseg:=seg(pcombo1^);
      basemask:=iseg;
      offsetmask:=iofs;
      leggi2mask(eliminadir(NOMEF));
      IF TABELLAMISTA then
      begin
        tabella^:=tabmista^;
        tabellamista:=false;
        ultimocampo:=ultimocampomista;
      end;
      iofs:=0;
      spag:=spacetab(iofs);
      iofs:=ofs(pcombo1^);
      caraddress(iseg,iofs);
      assign(f,nfile);
      reset(f,spag);
      while not eof(f) do
      begin
        fillchar(pcombo1^,sizeof(pcombo1^),0);
        blockread(f,pcombo1^,1,nletti);
        for j:=1 to nrighep do
        begin
          leggidato1(dato,ncampir*(j-1)+ncampo_out);
          dato:=formst1(dato);
          if dato>'' then
          begin
            dato:=oem_ans(dato);
            strpcopy(strins,dato);
            {oemtoansi(strins,strins);}
            addstring(strins);
            if Ncampo_agg>0 then
            begin
              tcampo_agg:=ncampo_agg;
              leggidato1(dato,ncampir*(j-1)+ncamporec_agg);
              strpcopy(strins,dato);
              oemtoansi(strins,strins);
              elenco^.Insert(StrNew(strins));
            end;
          end;
        end;
      end;
      close(f);
      dispose(pcombo);
      dispose(pcb,done);
     end;
   end;
   end;
 1:begin
     with pcb^ do
     begin
       if exist(drivemask+nfile) then
       if campo_cor=campo then
       begin
         assign(fh,drivemask+nfile);
         reset(fh);
         read(fh,hlp);
         while not eof(fh) do
         begin
           read(fh,hlp);
           dato:=(hlp.Descr);
           dato:=formst(dato);
           dato:=oem_ans(dato);
           if dato >'' then
           begin
             strpcopy(strins,dato);
             addstring(strins);
           end;
           if Ncampo_agg>0 then
            begin
              tcampo_agg:=ncampo_agg;
              dato:=hlp.val;
              strpcopy(strins,dato);
              oemtoansi(strins,strins);
              elenco^.Insert(StrNew(strins));
            end;
         end;
         close(fh);
       end;
     end;
   end;
 3:begin

   end;
 end;
end;

procedure tmybox.setupwindow;
var pc:array[0..70] of char;
    msg:tmessage;
begin
  inherited setupwindow;
  caricalista(msg);
  if tcampo_agg>0 then
  begin
  end;
end;

function tmyradio.Transfer(DataPtr: Pointer;TransferFlag: Word):word;
var seg_m,ofs_m:word;
begin
  with tabellacorrente^[n_fin].dialog^ do
  begin
    seg_m:={seg(Dataptr^);}tab^[campo].baddr;
    ofs_m:={ofs(Dataptr^);{}tab^[campo].oaddr;
    ofs_m:=ofs_m+(ofsetTab-ofsin);
    Dataptr:=Ptr(seg_m,ofs_m);
  end;
  case transferflag of
    tf_getdata:begin
                 if getcheck=1 then
                 integer(Dataptr^):=1
                 else
                 integer(Dataptr^):=0;
               end;
   tf_setdata:Begin
                setcheck(integer(Dataptr^))
              end;
  end;
  transfer:=sizeof(integer);
end;

procedure tmyradio.BnClicked(var msg:Owindows.Tmessage);
begin
  tabellacorrente^[n_fin].dialog^.tab^[campo].modificato:=true;
  tabellacorrente^[n_fin].dialog^.transferdata(tf_getdata);
  tabellacorrente^[n_fin].dialog^.tasti[27];
  tabellacorrente^[n_fin].dialog^.transferdata(tf_setdata);
{  tabellacorrente^[n_fin].dialog^.tab^[campo].modificato:=true;}
end;


constructor tmyradio.initresource(aparent:pwindowsobject;aid:integer;acampo:integer;atipo:char);
begin
  campo:=acampo;
  tipo:=atipo;
  n_fin:=a_w;
  inherited initresource(aparent,aid);
end;




procedure tmybox.wmcommand(var msg:owindows.tmessage);
var s:linestr;
    a,i:integer;
    hd:hwnd;
    strpc:pchar;
    pc40:array[0..40] of char;
begin
  inherited wmcommand(msg);
  if HIWORD(msg.lParam)=cbn_selchange then
  begin
  nriga_sel:=tlistbox.getselindex;
  tabellacorrente^[n_fin].dialog^.tab^[campo].modificato:=true;
  if tcampo_agg>0 then
  begin
    hd:=parent^.hwindow;
    a_w:=numerotabella(st_8,hd,1);
    strpc:=pchar(elenco^.at(nriga_sel));
    if (strpc<> nil) {and (nriga_sel>0)}then
    begin
      case tabellacorrente^[a_w].dialog^.tab^[tcampo_agg].subtipo of
      ' ':begin
            s:=strpas(strpc);
            aggiornadatowin(s,tcampo_agg,a_w);
          end;
      'B':begin
            tabellacorrente^[a_w].dialog^.transferdata(tf_getdata);
            tabellacorrente^[a_w].dialog^.tab^[tcampo_agg].pcb^.clearlist;
            tabellacorrente^[a_w].dialog^.tasti[25];
            for i:=1 to 40 do
            begin
              if elstr^[i] >'' then
              begin
                strpcopy(pc40,elstr^[i]);
                tabellacorrente^[a_w].dialog^.tab^[tcampo_agg].pcb^.addstring(pc40);
              end;
            end;
          end;
      end;
    end;
  end;
  end;
end;

function tmybox.canclose:boolean;

begin
  canclose:=possochiudere;
end;

function tmybox.Transfer(DataPtr: Pointer;TransferFlag: Word):word;
var st_10:array[0..10] of char;
    st_010:st10;
    s15:string[15];
    sc:array[0..15]of char;
    pch:pchar;
    pc:array[0..70] of char;
    ValCode: Integer;
    seg_m,ofs_m:word;
    sct:array[0..255] of char;
    sct1:pchar;
    st:string[255];
    s:string;
    hd:hwnd;
    realtemp:real;
    pstr:^string;
    scel:pchar;
    campocorrente:integer;
    i:integer;
    hw:hwnd;

begin
  sct1:=@sct;

  with tabellacorrente^[n_fin].dialog^ do
  begin
    possochiudere:=true;
    seg_m:={seg(Dataptr^);}tab^[campo].baddr;
    ofs_m:={ofs(Dataptr^);{}tab^[campo].oaddr;
    ofs_m:=ofs_m+(ofsetTab-ofsin);
    Dataptr:=Ptr(seg_m,ofs_m);
  end;
    valcode:=0;
    case transferflag of
    tf_getdata:begin
                 case tipo of
                 'i','I':begin
                           case cod of
                           1:begin
                               gettext(sc,sizeof(sc));
                               s15:=strpas(sc);
                               s15:=setleft(setright(s15));
                               Val(s15, integer(Dataptr^), ValCode);
                               if valcode<>0 then
                               begin
                                 writemessage('utiliti.msg',1);
                                 setfocus(hwindow);
                                 possochiudere:=false;
                               end;
                             end;
                           2:begin
                               gettext(sc,sizeof(sc));
                               s15:=strpas(sc);
                               s15:=setleft(setright(s15));
                               if s15>'' then
                               integer(dataptr^):=getselindex
                               else
                               integer(dataptr^):=0;
                             end;

                           end;
                         end;
                 'r','R':begin
                           case cod of
                           1:begin
                               gettext(sc,sizeof(sc));
                               s15:=strpas(sc);
                             end;
                           2:begin
                               scel:=pchar(elenco^.At(nriga_sel));
                               s15:=strpas(scel);
                             end;
                           end;
                           s15:=setleft(setright(s15));
                           Val(s15,realtemp , ValCode);
                           if nlineaum >0 then
                           realtemp:=realtemp*arkum^[nlineaum].um[num].coeffum*UmLav^[nlineaum].um[num].coeffum;
                           real(Dataptr^):=realtemp;
                           if valcode<>0 then
                           begin
                             writemessage('utiliti.msg',1);
                             setfocus(hwindow);
                             possochiudere:=false;
                           end;
                         end;
                 'T','t':begin
                           gettext(sc,sizeof(sc));
                           s15:=strpas(sc);
                           s15:=setleft(setright(s15));
                           Val(s15,realtemp , ValCode);
                           real(Dataptr^):=(realtemp-costaddtemp)/costmolttemp;
                           if valcode<>0 then
                           begin
                             writemessage('utiliti.msg',1);
                             setfocus(hwindow);
                             possochiudere:=false;
                           end;
                         end;

                 '$','s':begin
                           gettext(sct,L+1);
                           st:=setleft(setright((strpas(sct))));
                           s:=st;
                           if upstring(s)=w_mw(134){'ASSENTE'} then
                           s:='';
                           string(dataptr^):=s;
                         end;
                 end;
               end;{tf_getdata}
    tf_setdata:begin
                 case tipo of
          'i','I':begin
                    case cod of
                    1:begin
                        str(integer(Dataptr^),s15);
                        strpcopy(sc,s15);
                        settext(sc);
                      end;
                    2:begin
                        nriga_sel:=integer(Dataptr^);
                        if (nriga_sel>0) and carico then
                        begin
                          fillchar(pc,sizeof(pc),0);
                          if getstring(pc,nriga_sel) >0 then
                          begin
                          {oemtoansi(pc,pc);}
                          settext(pc);
                          end
                          else
                          begin
                            fillchar(pc,sizeof(pc),0);
                            settext(pc);
                          end;
                        end
                        else
                        begin
                          fillchar(pc,sizeof(pc),0);
                          settext(pc);
                        end;
                        if (tcampo_agg>0)  then
                        begin
                         { s:=strpas(pchar(elenco^.at(nriga_sel)));
                          case tab^[tcampo_agg].tipo of:
                          'R':;}
                        end;
                      end;
                    end;
                  end;
          'r','R':begin
                    case cod of
                    1:begin
                        realtemp:=real(dataptr^);
                        if nlineaum >0 then
                        realtemp:=realtemp/arkum^[nlineaum].um[num].coeffum/UmLav^[nlineaum].um[num].coeffum;
                        str(realtemp:cifreint:cifredec,s15);
                        if realtemp=0 then s15:='';
                        strpcopy(sc,s15);
                        settext(sc);
                      end;
                    2:begin
                      end;
                    end;
                  end;
          'T','t':begin
                    realtemp:=(real(dataptr^)*costMolttemp)+costAddTemp;
                    str(realtemp:cifreint:cifredec,s15);
                    strpcopy(sc,s15);
                    settext(sc);
                  end;
          '$','s':begin
                   pstr:=dataptr;
                   s:=pstr^;
                   st:=s;
                   strpcopy(sct1,st);
                   settext(sct1);
                 end;
          end; {tf_setdata}
     end;{case}
  end;
  {with tab^[campocorrente-100] do}
    case tipo of
    'i','I':transfer:=sizeof(integer);
    'r','R',
    't','T':transfer:=sizeof(real);
    '$','s':transfer:=l+1;
    end;
end;

procedure tmycheck.BnClicked(var msg:Owindows.Tmessage);
begin
  inherited BnClicked(msg);
  tabellacorrente^[n_fin].dialog^.tab^[campo].modificato:=true;
end;

procedure tmycheck.wmsetfocus(var msg:owindows.tmessage);
var hd:hwnd;
    i:integer;

begin
   a_w:=n_fin;
   i:=getid;
   if tabellacorrente^[a_w].dialog <> nil then
   tabellacorrente^[a_w].dialog^.campoattivo:=i;
   scrivibarra;
   defwndproc(msg);
end;


function tmycheck.Transfer(DataPtr: Pointer;TransferFlag: Word):word;
var
    seg_m,ofs_m:word;
    s:string;
    hd:hwnd;
    hw:hwnd;

begin
  with tabellacorrente^[n_fin].dialog^ do
  begin
    seg_m:={seg(Dataptr^);}tab^[campo].baddr;
    ofs_m:={ofs(Dataptr^);{}tab^[campo].oaddr;
    ofs_m:=ofs_m+(ofsetTab-ofsin);
    Dataptr:=Ptr(seg_m,ofs_m);
  end;
  case transferflag of
    tf_getdata:begin
                 case tipo of
                 'i','I':begin
                         end;

                 '$','s':begin
                           if getcheck=bf_checked then s:='*' else s:='';
                           st1(dataptr^):=s;
                         end;
                  end;
               end;{tf_getdata}
    tf_setdata:begin
                 case tipo of
          'i','I':begin
                  end;

          '$','s':begin
                    s:=st1(dataptr^);
                    if s='*' then setcheck(1) else setcheck(0);
                 end;
               end;
          end; {tf_setdata}
     end;{case}
  case tipo of
  'i','I':transfer:=sizeof(integer);
  '$','s':transfer:=sizeof(st1);
  end;
end;


procedure tmyCHECK.wmkillfocus(var msg:owindows.tmessage);
var st:string[3];
    pc:array[0..3] of char;
    hd:hwnd;
    Dato:linestr;
    campob:integer;
begin
    {ifdef testo}
    a_w:=N_fin;
    IF A_w>0 then
    with tabellacorrente^[a_w] do
    if dialog<>nil then
    with dialog^ do
    begin
      campoprecedente:=tmyCHECK.getid;
      campob:=Campoprecedente-100;
      if (campob>=1) and (campob <= ultcampo) then
      begin
        dato:=readdato(campob,a_w);
        if (dato>'') and (Tab<>nil)  then
        TastoEnter(Dato,Nome+'.MSK',campob,Tab^[campob].NCampoTab,NumCampiTab);
      end;
    end;
  {endif}
  defwndproc(msg);
end;


constructor tmycheck.initresource(aparent:pwindowsobject;aid:integer;acampo:integer;atipo:char);
begin
  inherited initresource(aparent,aid);
  campo:=acampo;
  tipo:=atipo;
  N_fin:=a_w;
end;



constructor tval.init(amin,amax:real;stringa:boolean; atipo:char;
                      acampo,ALunghezza,ANlineaUm,Anum,apdec:integer);
begin
  tvalidator.init;
  tipo:=atipo;
  campo:=acampo;
  Lunghezza:=ALunghezza;
  NlineaUm:=ANlineaUm;
  num:=Anum;
  pdec:=apdec;
  isstringa:=stringa;
  min:=amin;
  max:=amax;
  n_fin:=a_w;
end;



function tval.isvalidinput(var s:string;b:boolean):boolean;
var
  Valid1: Boolean;
  ValCode: Integer;
  Value: real;
  const
  CharSet = [#0..#255];
var
  I, Len: Integer;
  Msg: array[0..63] of Char;
  testo:string;
begin

  if not isstringa then
  begin
    VALID1:=TRUE;
    Val(s, Value, ValCode);
    Valid1:= ((ValCode = 0) or (s='-')) and
      (Value >= Min) and (Value <= Max);
    if not Valid1 then
    begin
      messagebeep(10);
    end;
    isvalidinput := Valid1;
   end
   else
   begin
      isvalidinput:=valid1;
    end;
end;

procedure aggiornadatowin(dato:string;i,n_w:integer);
var hd:hwnd;
    var pc:array[0..126] of char;
begin
  with tabellacorrente^[n_w] do
  with dialog^ do
  begin
    strpcopy(pc,dato);
    oemtoansi(pc,pc);
    tab^[i].p^.disabletransfer;
    tab^[i].p^.settext(pc);
    tab^[i].p^.enabletransfer;
  end;
end;

function readdato(i,n_w:integer):linestr;
var pc:array[0..126] of char;
    hd:hwnd;
    l:linestr;
begin
  if (i<0) or (i>300) then exit;
  with tabellacorrente^[n_w].dialog^  do
  begin
    if tab<>nil then
    if (tab^[i].subtipo<>'B') and (tab^[i].subtipo<>'R') and (tab^[i].subtipo<>'M') then
    begin
    fillchar(pc,sizeof(pc),0);
    l:='';
    tab^[i].p^.disabletransfer;
    tab^[i].p^.gettext(pc,tab^[i].L+1);
    tab^[i].p^.enabletransfer;
    l:=strpas(pc);
    readdato:=l;
    end
    else
    readdato:='';
  end;
end;



function tval.transfer(var s:string;buffer:pointer;flag:tvtransfer):word;
var
  ValCode: Integer;
  seg_m,ofs_m:longint;
  st:string;
  hd:hwnd;
  realtemp:real;
  PStr :^st240;
begin
  with tabellacorrente^[n_fin].dialog^ do
  begin
    seg_m:={seg(buffer^);}tab^[campo].baddr;
    ofs_m:={ofs(Buffer^);}tab^[campo].oaddr;
    ofs_m:=ofs_m+(ofsetTab-ofsin);
    Buffer:=Ptr(seg_m,ofs_m);
  end;
  case flag of
  vtGetData:
      begin
        case tipo of
        'i','I':begin
                  Val(s, integer(buffer^), ValCode);
                end;
        'r','R':begin
                  Val(s,realtemp , ValCode);
                  if nlineaum >0 then
                  realtemp:=realtemp*arkum^[nlineaum].um[num].coeffum*UmLav^[nlineaum].um[num].coeffum;
                  real(buffer^):=realtemp;
             end;
        'T','t':begin
                  Val(s,realtemp , ValCode);
                  real(buffer^):=(realtemp-costaddtemp)/costmolttemp;
                end;
        's','$':begin
                  s:=ans_oem(s);
                  s:=setleft(setright((s)));
                  string(buffer^):=s;
                end;

        end;
      end;
      vtSetData:
      begin
        case tipo of
       'i','I':begin
                 Str(integer(buffer^), s);
                 if integer(buffer^) =0  then s:='';
               end;
       'r','R':begin
                 if nlineaum>0 then
                   realtemp:=real(buffer^)/arkum^[nlineaum].um[num].coeffum/UmLav^[nlineaum].um[num].coeffum
                 else
                 realtemp:=real(buffer^);
                 str(realtemp:Lunghezza:PDec,s);
                 if realtemp=0 then s:='';
               end;
       'T','t':
            begin
               realtemp:=(real(buffer^)*costMolttemp)+costAddTemp;
               str(realtemp:Lunghezza:PDec,s);
            end;

       's','$':begin
                 pstr:=buffer;
                 s:=setleft(setright(pstr^));
                 s:=oem_ans(s);
               end;

            end;
          end;

     end;
    case tipo of
    'I','i':begin
              transfer := SizeOf(integer);
            end;
'T','t','R','r':transfer := SizeOf(real);
        '$','s':transfer:=Lunghezza+1;

          end;
end;


constructor TFieldEdit.InitResource(AParent: PWindowsObject;
                                    ResourceID: Word; Digits: Word;
                                    AMinValue, AMaxValue: real;isstr:boolean;
                                    atipo:char;ncampo,ANlineaUm,Anum,apdec:integer;adef_ins:recins);
begin
  TEdit.InitResource(AParent, ResourceID, Digits + 1);
  MinValue := AMinValue;
  MaxValue := AMaxValue;
  lcampo:=digits;
  controll:=false;
  def_ins:=adef_ins;
  N_fin:=a_w;
  validator:=new(pval,init(aminvalue,amaxvalue,isstr,atipo,ncampo,digits,anlineaum,anum,apdec));

end;



Function nomeins(nome:string;Campo:integer;def_ins:recins):string;
var stcampo:string[3];
begin
nomeins:='';
if def_ins.ncampo=0 then
begin
  Str(Campo,StCampo);
  Nome:=Nome+'.L'+StCampo;
  if exist(drivemask+Nome) then Nomeins:= drivemask+Nome
  else
  if exist(nome) then Nomeins:=Nome
  else
  nomeins:='';
end
else
if exist(def_ins.nfile) then nomeins:=def_ins.nfile;
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
procedure tfieldedit.wmkillfocus(var msg:owindows.tmessage);
var st:string[3];
    pc:array[0..3] of char;
    hd:hwnd;
    Dato:linestr;
    campo:integer;
begin
    inherited wmkillfocus(msg);
    {ifdef testo}

    a_w:=n_fin;
    IF A_w>0 then
    with tabellacorrente^[a_w] do
    if dialog<>nil then
    with dialog^ do
    begin
      campoprecedente:=tfieldedit.getid;
      campo:=Campoprecedente-100;
      if (campo>=1) and (campo <= ultcampo) then
      begin
        dato:=readdato(campo,a_w);
        if (dato>'')and (Tab<>nil) then
        TastoEnter(Dato,Nome+'.MSK',campo,Tab^[campo].NCampoTab,NumCampiTab);
      end;
    end;
  {endif}
end;

procedure tfieldedit.wmsetfocus(var msg:owindows.tmessage);
var hd:hwnd;
    i:integer;
begin

   a_w:=n_fin;
   i:=getid;
   if (tabellacorrente^[a_w].dialog <> nil)  then
   begin
   tabellacorrente^[a_w].dialog^.campoattivo:=i;
   tabellacorrente^[a_w].dialog^.tasti[24];
   scrivibarra;
   end;

   defwndproc(msg);
end;



function tastoins(campo,campotab,finestra:integer;azione:boolean;def_ins:recins):boolean;
var ctrl:integer;
    stringa:string[70];
    n_ins:string;
    st:string[3];
    pcm:array[0..70] of char;
    hd:hwnd;
    i:integer;
procedure generaindice(Var nforig:string;lineains,nomedientrata:string;var insmisto:boolean);
var fo,fd:file of rechlp;
    vo,vd:rechlp;
    l_d,v:integer;

begin
  insmisto:=false;
  if nforig <> 'indins.ins' then
  begin
    assign(fo,nforig);
    reset(fo);
    assign(fd,'indins.ins');
    rewrite(fd);
    read(fo,vo);
    write(fd,vo);
    while not eof(fo) do
    begin
      read(fo,vo);
      if vo.descr[1]='-' then
      begin
        write(fd,vo);
        insmisto:=true;
      end;
    end;
    close(fd);
    close(fo);
   end
   else
   begin
     insmisto:=false;
     assign(fo,nomedientrata);
     reset(fo);
     read(fo,vo);
     assign(fd,'elenins.ins');
     rewrite(fd);
     write(fd,vo);
     lineains:=formst(lineains);
     while (not eof(fo)) and (formst(vo.descr)<>lineains) do read(fo,vo);
     if not eof(fo) then
     begin
       write(fd,vo);
       read(fo,vo);
       while (not eof(fo)) and (vo.descr[1]<>'-') do
       begin
       write(fd,vo);
       read(fo,vo);
       end;
       nforig:='elenins.ins';
     end;
     close(fo);
     close(fd);
   end;
end;

procedure tastoins1(var code:integer);
var ld:integer;
begin
  a_w:=finestra;
  with tabellacorrente^[a_w] do
  with dialog^ do
  begin
    st_8:=nome;

    if n_ins='' then
    begin
      exit;
    end
    else
    if popup=nil then
    begin
      setcursor(cur_asp);
      i:=0;
      assign(fh,n_ins);
      reset(fh);
      read(fh,hlp);
      ctrl:=0;
      val(hlp.descr,hlp_ldescr,ctrl);
      if ctrl=0 then
      val(hlp.val,hlp_lval,ctrl);
      if ctrl<>0 then
      messagebeep(10);
      ld:=(hlp_ldescr+hlp_lval)*10;
      if ld>630 then ld:=630;
      popup:=new(ppopup,init(self,'popupins',150,100,ld,165,campo,finestra,def_ins,azione));
      popup^.nmessaggi:=0;
      while not eof(fh) do
      with popup^ do
      begin
        i:=i+1;
        nmessaggi:=nmessaggi+1;
        read(fh,hlp);
        if hlp_lval>0 then stringa:=format(hlp.Descr,hlp_lDescr)+':'+format(hlp.Val,hlp_lVal)
        else stringa:=format(hlp.Descr,hlp_ldescr);
        stringa:=setleft(setright(stringa));
        if stringa >'' then
        begin
          strpcopy(pcm,stringa);
          messaggio^.insert(StrNew(pcm));
        end;
      end;
      code:=application^.execdialog(popup);
      if code = idcancel then setfocus(maniglia);
      close(fh);
      popup:=nil;
    end;
  end;
end;
var insmisto:boolean;
    nomeT:string;
    codice:integer;
begin
  if popup=nil then
  begin
  a_w:=finestra;
  with tabellacorrente^[a_w] do
  with dialog^ do
  begin
    selezione:=true;
    n_ins:=nomeins(nomemaskhlp,campotab,def_ins);
    if n_ins >'' then
    begin
      nomeT:=n_ins;
      generaindice(n_ins,'','',insmisto);
      if not insmisto then tastoins1(codice) else
      begin
        n_ins:='indins.ins';
        selezione:=false;
        tastoins1(codice);
        if codice<> id_cancel then
        begin
          generaindice(n_ins,linetemp,nomeT,insmisto);
          n_ins:='elenins.ins';
          SELEZIONE:=true;
          tastoins1(codice);
        end;
      end;
    end;
  end;
  if codice<>id_cancel then tastoins:=true else tastoins:=false;
  end;
end;

procedure tfieldEdit.wmrbuttonup(var msg:tmessage);
var action:boolean;
    hd:hwnd;
    cp:integer;
begin
  cp:=getid-100;
  setfocus(hwindow);
  hd:=parent^.hwindow;
  a_w:=numerotabella(st_8,hd,1);
  tastoins(cp,tabellacorrente^[a_w].dialog^.Tab^[cp].NCampoTab,a_w,true,def_ins);
end;



procedure tfieldEdit.wmchar(var msg:owindows.tmessage);
var campo:integer;
    hd:hwnd;
begin
  inherited wmchar(msg);
  {ifdef testo}
  a_w:=n_fin;
  campo:=Attr.id-100;
  tabellacorrente^[a_w].dialog^.tab^[campo].modificato:=true;
  {endif}
end;

procedure tfieldEdit.wmkeydown(var msg:owindows.tmessage);
var st:string[3];
    pc:array[0..3] of char;
    st1:string;
    i,id,campo:integer;
    action:boolean;
    hd:hwnd;

begin
  inherited wmkeydown(msg);
  {Ifdef testo}
  a_w:=n_fin;
  with tabellacorrente^[a_w] do
  with dialog^ do
  begin
    campoprecedente:=tfieldedit.getid;
    campo:=campoattivo-100;
    case MSG.wparam of

    39:begin {freccia a destra}
         getselection(i,lcampocorr);
         if lcampocorr>lcampo-2 then
         begin
           if campo<datrg*datpg then
           begin
             camposucc(campo);
             if dialog<> nil then  SETFOCUS(Dialog^.GETItemHANDLE(Campo+100))
             else SETFOCUS(Dialog^.GETItemHANDLE(Campo+100));
           end
           else messagebeep(10);
         end
         else defwndproc(msg);
       end;

    37:begin {freccia a sinistra}
         getselection(i,lcampocorr);
         if lcampocorr=0 then
         begin
           if campo>1 then
           begin
             campoprec(campo);
             SETFOCUS(Dialog^.GETItemHANDLE(Campo+100))
           end
           else messagebeep(10);
         end
         else defwndproc(msg);
       end;

    45:begin
         IF Not controll then
         tastoins(campo,tab^[campo].ncampotab,a_w,true,def_ins);
         defwndproc(msg);
        end;

    33:begin{pagUp}
        {if isiotab then scrolla^.sbpageUp(msg);}
        tastoPgUp;
       end;
    34:begin{pagDn}
         {if isiotab then scrolla^.SbPageDown(msg);}
         tastoPgDn;
       end;
    38:Begin
         if isiotab then
         begin
         if campo > DatRg then
         begin
           campo:=campo-DatRg;
           SETFOCUS(Dialog^.GETItemHANDLE(Campo+100));
         end
         else scrolla^.sbPageUp(msg);
         end;
       end;
    40:Begin
         if isiotab then
         begin
         if campo <= (DatPg-1)*DatRg then
         begin
           campo:=campo+DatRg;
           SETFOCUS(Dialog^.GETItemHANDLE(Campo+100));
         end
         else scrolla^.sbPageDown(msg);
         end;
       end;
    17:begin
         controll:=true;
       end;
   112:begin
         if not controll then dialog^.tastof1 else
         begin
           controll:=false;
           vishelp(nome+'.hlp');
         end;
       end;
   113:begin
         if not controll then dialog^.tastof2 else
         begin
           controll:=false;
           str(tab^[campo].ncampotab,st_8);
           vishelp(nome+'.h'+st_8);
         end;
       end;
   114:begin
         if not controll then dialog^.tastof3 else
         begin
           controll:=false;
           vishelp('errori.hlp');
         end;
       end;
   115:begin
         dialog^.tastof4
       end;
   116:begin
         dialog^.tastof5
       end;
   117:begin
         dialog^.tastof6
       end;
   118:begin
         dialog^.tastof7
       end;
   119:begin
         dialog^.tastof8
       end;
   120:begin
         dialog^.tastof9
       end;
   121:begin
         dialog^.tastof10
       end;
   122:begin
         MESSAGEBEEP(19);
         dialog^.transferdata(tf_getdata);
         cambiamisure;
         dialog^.transferdata(tf_setdata);
         dialog^.setupwindow;
       end;
    else
    begin
      modificata:=true;
      defwndproc(msg);
    end;
  END;
end;
{endif}
end;





procedure tfieldedit.wmlbuttondblclk(var msg:tmessage);
var st:string;
    hd:hwnd;
    campo:integer;
begin
  {ifdef testo}
  a_w:=n_fin;
  with tabellacorrente^[a_w] do
  with dialog^ do
  begin
    if isiotab then
    begin
      campo:=tfieldedit.getid;
      setfocus(getitemhandle(campo));
      campoprecedente:=campo;
      dialog^.tastof3;
    end;
  end;
  {endif}
end;


procedure tdialogo.wmNCHITTEST(var msg:owindows.tmessage);
begin
  {
  if mhcur<0 then
  repeat
    mhcur:=showcursor(true);
  until mhcur=0;}
  defwndproc(msg);
end;

(*
procedure Tdialogo.WMControlColor(var Msg: TMessage);
begin
  case Msg.LParamHi of
    ctlColor_Btn:
      begin
        SetTextColor(Msg.WParam, Rgb_Blue);
        SetBkMode(Msg.WParam, transparent);
        Msg.Result := TheBrush;
      end;
    ctlColor_Static:
      begin
        SetTextColor(Msg.WParam, Rgb_Blue);
        SetBkMode(Msg.WParam, transparent);
        Msg.Result := TheBrush;
      end;
    ctlColor_ListBox, ctlColor_Edit:
      begin
        SetTextColor(Msg.WParam, Rgb_red);
        SetBkMode(Msg.WParam, transparent);
        Msg.Result := BoxBrush;
      end;
    {ctlcolor_Dlg:
      begin
        SetBkMode(Msg.WParam, Transparent);
        Msg.Result := TheBrush;
      end;}
  else
    DefWndProc(Msg);
  end;
end;

*)


constructor tdialogo.init(AParent:Pwindowsobject; AName:pchar;var dato;Setnrighe:boolean;itasti:proc;
                          fill_lista:proc1;iotab,amodale:boolean;Ndat,DatP,DatR:integer);
var
    st1:st8;
    i,j:integer;
    st,nomemask:string;
    stinfo:array[0..80] of char;
    pc1:array[0..10] of char;
    var LogBrush: TLogBrush;
    f:text;
begin
  begin
  {LogBrush.lbStyle := bs_Null;
  LogBrush.lbColor := RGB(148,148,148);
  LogBrush.lbHatch := bs_Solid;
  TheBrush  := CreateBrushIndirect(LogBrush);
  LogBrush.lbStyle := bs_Solid;
  LogBrush.lbColor := RGB(255,255,255);
  LogBrush.lbHatch := bs_Solid;
  BoxBrush := CreateBrushIndirect(LogBrush);
  }
  isnrigheset:=setnrighe;
  new(tab);
  new(ar_instab);
  ar_instab^:=ar_ins^;
  modale:=amodale;
  isiotab:=iotab;
  campoprecedente:=101;
  campoattivo:=0;
  testodihelp:='';
  st:=eliminadir(strpas(aname));
  popup:=nil;
  nomemaskhlp:=copy(st,1,length(st)-4);
  nomemask:=strpas(aname);
  st:=eliminadir(nomemask);
  st:=copy(st,1,length(st)-4);
  for i:=1 to maxtasti do tasti[i]:=itasti[i];
  initproc;
  fill_combo:=fill_lista;
  nomtab:=st;
  case testat of
  1:st:='C'+st;
  194:st:='D'+st;
  195:st:='L'+st;
  end;
  Aname:=strPcopy(Aname,st);
  inherited Init(AParent, AName);
  tabellacorrente^[a_w].self:=@self;
  InitTabella;
  transferbuffer:=@dato;
  BaseMask:=seg(dato);OffsetMask:=ofs(dato);
  BaseTab:=baseMask;ofsetTab:=offsetMask;
  ofsin:=offsetmask;
  ultcampo:=ultimocampo;
  Pg:=1;
  NDatg:=Ndat;DatPg:=DatP;DatRg:=DatR;
  Leggi2Mask(nomemask);
  tab^:=Tabella^;
  numerolineatabella:=1;
  possochiudere:=true;
  ultcampo:=ultimocampo;
  for i:=1 to ultcampo do
  with Tab^[i] do
  case tipo of
     'R','I','i','r':begin
                       if isiotab then p :=new(pfieldedit,initresource(@self,100+i,L,-9999999,999999999,false,
                                                      tipo,i,Nlineum,num,cifredec,ar_ins^[ncampotab]))
                       else
                       case subtipo of
                       'B':begin
                           pcb:=new(pmybox,initresource(@self,100+i,L+1,fill_lista,i,
                                    tipo,nlineum,num,l,cifreint,cifredec));
                           end;
                       'M':prb:=new(pmyradio,initresource(@self,100+i,i,tipo));
                       else

                       p :=new(pfieldedit,initresource(@self,100+i,L,-9999999,999999999,false,
                                                      tipo,i,Nlineum,num,cifredec,ar_ins^[ncampotab]))
                       end;
                     end;
     '$','C','c','s':begin
                       if isiotab then p :=new(pfieldedit,initresource(@self,100+i,L,0,999999999,true,
                                                        tipo,i,Nlineum,num,cifredec,ar_ins^[ncampotab]))
                       else
                       case subtipo of
                       'B':begin
                             pcb:=new(pmybox,initresource(@self,100+i,L+1,fill_lista,i,
                                      tipo,nlineum,num,l,cifreint,cifredec));
                           end;
                       'R':pck:=new(pmycheck,initresource(@self,100+i,i,tipo));
                       else
                       p :=new(pfieldedit,initresource(@self,100+i,L,0,99999999,true,
                                                        tipo,i,Nlineum,num,cifredec,ar_ins^[ncampotab]));
                       end;
                     end;

   end;
   if ninfo >0 then
   for i:=1 to ninfo do
   begin
     st_mess[i]:=new(pstatic,initresource(@self,351+i,80+1));
     st_mess[i]^.disabletransfer;
   end;
   if ninfoum >0 then
   for i:=1 to ninfoum do
   begin
     st_messum[i]:=new(pstatic,initresource(@self,370+i,10+1));
     st_messum[i]^.disabletransfer;
   end;
   nomesfondo:=aname;
   end;
   if iotab then
   begin
     st_pag:=new(pstatic,initresource(@self,351,9));
     st_pag^.disabletransfer;
     scrolla:=new(pscrolla,initresource(@self,401,1,ndatg,datpg));
     scrolla^.disabletransfer;
     dofs:=spacetab(ofsetTab);
     ROFs:=DOfs div DatPg; {..spazio occupato da una riga..}
     if setnrighe then for i:= 1 to datp do
     begin
       numeririga[i]:=new(pstatic,initresource(@self,401+i,5));
       numeririga[i]^.disabletransfer;
     end;
   end;
 end;


destructor tdialogo.done;
var i:integer;
begin
  dispose(tab);
  tab:=nil;
  inherited done;
end;
procedure tdialogo.getwindowclass(var AWndClass:TWndClass);
begin
  inherited getwindowclass(AWndClass);
end;


(*procedure tdialogo.transferdata(Direction:word);
var hd:hwnd;
    i:integer;
    s:string;
    tsfr:tvtransfer;
begin
 { case direction of
                 tf_getdata:tsfr:=vtgetdata;
                 tf_setdata:tsfr:=vtsetdata;
                 tf_sizedata:tsfr:=vtdatasize;
  end;

  for i:=1 to ultcampo do
  if  (tab^[i].tipo in ['R','I','$','C','r','i','s','c']) and (tab^[i].subtipo=' ') then
      tab^[i].p^.validator^.transfer(s,transferbuffer,tsfr)
  else
  if tab^[i].subtipo='B' then tab^[i].pcb^.transfer(transferbuffer,direction);}

  tabellacorrente^[a_w].dialog^ .transferdata(direction);
end;
*)
function tdialogo.canclose:boolean;
var hd:hwnd;
    i:integer;
    temp:boolean;
begin
  hd:=hwindow;
  a_w:=numerotabella(st_8,hd,1);
  campoattivo:=0;
  scrivibarra;
  with tabellacorrente^[a_w] do
  begin
    tasti[11];
    if modale and possochiudere then  enddlg(id_cancel)
    else
    if possochiudere then
    begin
      nome:='';
      maniglia:=0;
      dialog:=nil;
    end;
  end;
  temp:=tdialog.canclose;
  temp:=temp and possochiudere;
  canclose:=temp;
  a_w:=0;
  INITINS;
  initproc;
end;

procedure tdialogo.cancel(var mes:owindows.tmessage);
begin
  if ismodal then canclose
  else
  inherited cancel(mes);
end;


procedure tdialogo.ok(var mes:owindows.tmessage);
var hd:hwnd;
    r:wintypes.trect;
    i:integer;
    trovato:boolean;
begin

   i:=1;
   trovato:=false;
   while (i<= ulttab) and not trovato do
   begin
     trovato:=upstring(postab^[i].nome)=upstring(nomtab);
     inc(i);
   end;

   if not trovato then inc(ulttab) else dec(i);

  getwindowrect(hwindow,r);

  postab^[i].nome:=nomtab;
  postab^[i].x:=r.left;
  postab^[i].y:=r.top;
  hd:=hwindow;
  a_w:=numerotabella(st_8,hd,1);
  campoattivo:=0;
  scrivibarra;
  with tabellacorrente^[a_w] do
  begin

    {$ifdef demo}
    {$else}
    transferdata(tf_getdata);
    tasti[12];
    {$endif}
    if cancloseok then
    begin
      if modale then
      begin
        tasti[11];
        if possochiudere  then
        enddlg(id_ok)
      end
      else
      begin
        tasti[11];
        if possochiudere then
        begin
        nome:='';
        maniglia:=0;
        dispose(dialog,done);
        dialog:=nil;
        end;
      end
    end;
  end;
  initins;
  cancloseok:=true;
  initproc;
end;
function tdialogo.wmerasebkgnd(var msg:owindows.Tmessage):boolean;

procedure sfondomask(nome:pchar);
var
  BM: HBitmap;
  Ps: TPaintStruct;
  DC, MemDC: HDC;
  BitInfo: TBitmap;
  pc:array[0..5] of char;
  r:wintypes.trect;
begin

  getclientrect(msg.receiver,r);
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

{
procedure tdialogo.wmactivate(var msg:tmessage);
var hw:hwnd;
begin
  if (msg.wparam=wa_active) or (msg.wparam=WA_CLICKACTIVE) then
  begin
    hw:=(msg.receiver);
    a_w:=numerotabella(st_8,hw,1);
  end;
end;
}

procedure tdialogo.setupwindow;
var i:integer;
    stinfo:array [0..80] of char;
    stinfoum:array [0..10] of char;
    stv,stv1:string[4];
    stc:array[0..4] of char;

begin
  inherited setupwindow;
  fillchar(stinfo,sizeof(stinfo),0);
  with tabellacorrente^[a_w] do
  begin
  maniglia:=hwindow;
  if ninfo >0 then
    begin
     for i:= 1 to ninfo do
     begin
       if mess^[i] >'' then
       begin
       mess^[i]:=oem_ans(mess^[i]);
       strpCopy(stinfo,mess^[i]);
       st_mess[i]^.settext(stinfo);
       end;
     end;
    end;
  if ninfoum >0 then
    begin
     for i:= 1 to ninfoum do
     begin
       with messum^[i] do
       strpCopy(stinfoum,arkum^[n1].um[n2].descum);
       st_messum[i]^.settext(stinfoum);
     end;
    end;
  end;
  i:=1;
  if isnrigheset then
  begin
    if (DatPG <> 1) then
    for vv:=1 to DatPg do
    begin
      str( (i-1+vv),stv);
      stv1:= format(stv,4);
      strpcopy(stc,stv1);
      numeririga[vv]^.settext(stc);
    end;
  end;
  tasti[23];
end;




procedure Tdialogo.wminitdialog(var msg:owindows.Tmessage);
var R:wintypes.trect;
    x1,y1,h1,w1,i,j:integer;
    l_fin1,l_fin2,risp:integer;
    dc:hdc;
    ls,a_s:integer;
    trovato:boolean;
begin
 inherited wminitdialog(msg);
(* getwindowrect(msg.receiver,R);
 w1:=r.right-r.left;
 h1:=r.bottom-r.top;
 if not tab_testo then
 begin
   x1:=posx;
   y1:=posy;
 end
 else
 begin
   {$IFNDEF NOBARRA}
   dc:=getdc(PARENT^.hwindow);
   {$ELSE}
   dc:=getdc(0);
   {$ENDIF}
   Ls:=getdevicecaps(dc,horzres);
   A_s:=getdevicecaps(dc,vertres);
   {$IFNDEF NOBARRA}
   releasedc(PARENT^.hwindow,dc);
   {$ELSE}
   releasedc(0,dc);
   {$ENDIF}
   x1:=(ls-w1) div 2 ;
   y1:=(a_s-h1) div 2;
 end;
 movewindow(msg.receiver,X1,Y1,w1,h1,false);
 *)
 getwindowrect(msg.receiver,R);
 x1:=posx;
 y1:=posy;
 w1:=r.right-r.left;
 h1:=r.bottom-r.top;
 if not tab_testo then
 begin
   {$ifdef ducttubi}
   if dueres then
   begin
     if h1 > {el_win[1].h_win}alt_scheda-(el_win[3].y_ang+el_win[3].h_win) then
     begin
       done;
       dueres:=false;
       tabellacorrente^[a_w].nome:='';
       tabellacorrente^[a_w].maniglia:=0;
     end
     else
     if x1+w1>larg_scheda then
     begin
       risp:=2;
       x1:=larg_scheda-w1;
       for i:=1 to nresource do
       with el_res[i] do
       case cod of
       cost_mw1:
       begin
         l_fin1:=larg_scheda-w1-risp*3;
         Load_win(1,risp,risp,L_fin1);
         w:=el_win[1].w_win;
         h:=el_win[1].h_win;
         movewindow(andle,x,y,w,h,false);
       end;
       cost_mw2:
       begin
         l_fin2:=larg_scheda-l_fin1-risp*3;
         load_win(2,L_fin1+2*risp,risp,L_fin2);
         w:=el_win[2].w_win;
         h:=el_win[2].h_win;
         x:=el_win[2].x_ang;
         movewindow(andle,x,y,w,h,false);
         y1:=h+risp*2;
       end;
       cost_mw3:
       begin
         l_fin2:=larg_scheda-l_fin1-risp*3;
         load_win(3,L_fin1+2*risp,el_win[2].y_ang+el_win[2].h_win+2*risp,L_fin2);
         y:=el_win[3].y_ang;
         w:=el_win[3].w_win;
         h:=el_win[3].h_win;
         x:=el_win[3].x_ang;
         movewindow(andle,x,y,w,h,false);
         y1:=h+risp*2;
       end;
       cost_dial1:
       begin
         IF upstring(tabellacorrente^[a_w].nome)=upstring(nome) then
         begin
           andle:=msg.receiver;
           with el_win[3] do
           begin
             x:=x_ang;
             y:=y_ang+h_win+2*risp;
             h:=el_win[1].h_win-y+2*risp;
             Y:=el_win[1].h_win-H1;
             w:=w1;
           end;
           if h1 > el_win[1].h_win-(el_win[3].y_ang+el_win[3].h_win) then
           begin
             done;
             dueres:=false;
             tabellacorrente^[a_w].nome:='';
             tabellacorrente^[a_w].maniglia:=0;
           end
           else
           begin
             movewindow(msg.receiver,X,Y,w,h1,false);
             tabellacorrente^[a_w].maniglia:=msg.receiver;
             dialogo:= @self;
           end;
         end;
       end;
       end;
     end
     else
     begin
       x1:=larg_scheda-(w1+2);
       {H1:=el_win[1].h_win-(el_win[3].y_ang+el_win[3].h_win);}
       movewindow(msg.receiver,X1,Y1,w1,h1,false);
       tabellacorrente^[a_w].maniglia:=msg.receiver;
       el_res[n_res].andle:= msg.receiver;
       el_res[n_res].dialogo:= @self;
     end;
   end
   else
   begin
     x1:=larg_scheda-(w1+2);
{     y1:=alt_scheda-(h1+6); }
     movewindow(msg.receiver,X1,Y1,w1,h1,false);
     tabellacorrente^[a_w].maniglia:=msg.receiver;
   end;
 {$else}

   {if upstring(tabellacorrente^[a_w].nome)='M1024' then}

   If (2*h1+6 >= alt_scheda-el_win[2].h_win) and dueres then
   begin
     done;
     tabellacorrente^[a_w].nome:='';
     tabellacorrente^[a_w].maniglia:=0;
     dueres:=false;
   end
   else
   if x1+w1>larg_scheda then
   begin
     risp:=2;
     x1:=larg_scheda-w1;
     for i:=1 to nresource do
     with el_res[i] do
     case cod of
     cost_mw1:
     begin
       l_fin1:=larg_scheda-w1-risp*2;
       Load_win(1,risp,risp,L_fin1);
       w:=el_win[1].w_win;
       h:=el_win[1].h_win;
       movewindow(andle,x,y,w,h,false);
     end;
     cost_mw2:
     begin
       l_fin2:=larg_scheda-l_fin1-risp*3;
       load_win(2,L_fin1+2*risp,risp,L_fin2);
       w:=el_win[2].w_win;
       h:=el_win[2].h_win;
       x:=el_win[2].x_ang;
       movewindow(andle,x,y,w,h,false);
       y1:=h+risp*2;
     end;
     cost_dial1:
     begin
       IF upstring(tabellacorrente^[a_w].nome)=nome then
       begin
         andle:=msg.receiver;
         x:=x1;
         y:=y1;
         h:=h1;
         w:=w1;
         movewindow(msg.receiver,X1,Y1,w1,h1,false);
         tabellacorrente^[a_w].maniglia:=msg.receiver;
         el_res[n_res].dialogo:=@self;
       end;
     end;
     cost_dial2:
     begin
       if upstring(tabellacorrente^[a_w].nome)=nome THEN
       begin
         andle:=msg.receiver;
         j:=0;
         repeat
           j:=j+1;
         until el_res[j].cod=cost_dial1;
         if dueres then
         begin
           y:=y1+el_res[j].h+2*risp;
           y1:=y;
         end
         else y:=y1;
         x:=x1;
         h:=h1;
         w:=w1;
         movewindow(msg.receiver,X1,Y1,w1,h1,false);
         tabellacorrente^[a_w].maniglia:=msg.receiver;
         el_res[n_res].dialogo:=@self;
       end;
     end;
     end;
   end
   else
   begin
     movewindow(msg.receiver,X1,Y1,w1,h1,false);
     tabellacorrente^[a_w].maniglia:=msg.receiver;
     el_res[n_res].andle:= msg.receiver;
     el_res[n_res].dialogo:= @self;
     el_res[n_res].h:=h1;
   end;
  {$endif}
 end
 else
 begin
   i:=1;
   trovato:=false;
   while (i<= ulttab) and not trovato do
   begin
     trovato:=upstring(postab^[i].nome)=upstring(nomtab);
     inc(i);
   end;
   dec(i);
   if trovato and (posx=0) then
   movewindow(msg.receiver,postab^[i].X,postab^[i].Y,w1,h1,false)
   else
   begin
     if posx=0 then
     begin
       {$IFNDEF NOBARRA}
       dc:=getdc(PARENT^.hwindow);
       {$ELSE}
       dc:=getdc(0);
       {$ENDIF}
       Ls:=getdevicecaps(dc,horzres);
       A_s:=getdevicecaps(dc,vertres);
       {$IFNDEF NOBARRA}
       releasedc(PARENT^.hwindow,dc);
       {$ELSE}
       releasedc(0,dc);
       {$ENDIF}

       x1:=(ls-w1) div 2 ;
       y1:=(a_s-h1) div 2;

     end
     else
     begin
       x1:=posx;
       y1:=posy;
     end;
     movewindow(msg.receiver,X1,Y1,w1,h1,false);
   end;
   tabellacorrente^[a_w].maniglia:=msg.receiver;
 end;
 {tab_testo:=true;}
 posx:=0;
end;



Procedure Tdialogo.tastof16;
begin
  tasti[16];
end;

Procedure Tdialogo.tastof17;
begin
  tasti[17];
end;

Procedure Tdialogo.tastof18;
begin
  tasti[18];
end;

Procedure Tdialogo.tastof19;
begin
  tasti[19];
end;

Procedure Tdialogo.tastof20;
begin
  tasti[20];
end;



Procedure Tdialogo.tastof1 ;
var hd:hwnd;
begin
  setcursor(cur_asp);
  hd:=hwindow;
  st_8:=nomtab;
  a_w:=numerotabella(st_8,hd,2);
  with tabellacorrente^[a_w] do
  begin
  if getdata then
  transferdata(tf_getdata);
  numerolineatabella:=nlinetab(a_w);
  tasti[1];
  if setdata then
  begin
    transferdata(tf_setdata);
    with tabellacorrente^[a_w] do
    begin
       setfocus(dialog^.getitemhandle(campoprecedente))
    end;
  end;
  end;
  setdata:=true;
  getdata:=true;
end;

Procedure Tdialogo.tastof2;
var hd:hwnd;
begin
  setcursor(cur_asp);
  hd:=hwindow;
  st_8:=nomtab;
  a_w:=numerotabella(st_8,hd,2);
  with tabellacorrente^[a_w] do
  begin
  if getdata then transferdata(tf_getdata);
  numerolineatabella:=nlinetab(a_w);
  tasti[2];
  if setdata then
  begin
    transferdata(tf_setdata);
    with tabellacorrente^[a_w] do
      begin
        setfocus(dialog^.getitemhandle(campoprecedente))
      end;
  end;
  end;
  setdata:=true;
  getdata:=true;
end;
Procedure Tdialogo.tastof9 ;
var hd:hwnd;
begin
  setcursor(cur_asp);
  hd:=hwindow;
  st_8:=nomtab;
  a_w:=numerotabella(st_8,hd,2);
  if getdata then transferdata(tf_getdata);
  numerolineatabella:=nlinetab(a_w);
  tasti[9];
  if setdata then
  begin
    transferdata(tf_setdata);
    with tabellacorrente^[a_w] do
      begin
        setfocus(dialog^.getitemhandle(campoprecedente))
      end;
   end;
   setdata:=true;
   getdata:=true;
end;
Procedure Tdialogo.tastof10 ;
var hd:hwnd;
begin
  setcursor(cur_asp);
  hd:=hwindow;
  st_8:=nomtab;
  a_w:=numerotabella(st_8,hd,2);
  if getdata then transferdata(tf_getdata);
    numerolineatabella:=nlinetab(a_w);
  with tabellacorrente^[a_W] do
  begin
    tasti[10];
    if setdata then
    begin
      transferdata(tf_setdata);
      setfocus(dialog^.getitemhandle(campoprecedente))
    end;
  end;
  setdata:=true;
  getdata:=true;
end;

procedure tdialogo.tastohelp;
var hd:hwnd;
    est:string[4];
    nomehlp:string;
begin
  hd:=hwindow;
  st_8:=nomtab;
  a_w:=numerotabella(st_8,hd,2);
  {IF EXIST(drivemask+tabellacorrente^[a_w].nome+'.hlp') or EXIST(drivemask+tabellacorrente^[a_w].nome+'.hlp') THEN
  vishelp(tabellacorrente^[a_w].nome+'.hlp')
  ELSE}
  with tabellacorrente^[a_w].dialog^ do
  begin
    str(tab^[campoprecedente-100].ncampotab,est);
    est:='.H'+est;
    nomehlp:=tabellacorrente^[a_w].nome+est;
    {if exist(nomehlp) or exist(drivemask+nomehlp) then}
    vishelp(nomehlp)
  end;
end;


constructor tscrolla.initresource(aparent:pwindowsobject;anid:integer;amin,amax,apgm:integer);
begin
  inherited initresource(aparent,anid);
  max:=amax;
  min:=amin;
  pgm:=apgm;
end;

procedure tscrolla.setupwindow;
var hd:hwnd;
begin
  inherited setupwindow;
  setrange(min,max);
  setposition(min);
  pagemagnitude:=pgm;
end;



procedure tscrolla.sblinedown(var msg:owindows.tmessage);
   var st:string[8];
       pag:array[0..8] of char;
       hd:hwnd;
       stc:array[0..4] of char;

begin
  inherited sblinedown(msg);
  hd:=parent^.hwindow;
  a_w:=numerotabella(st_8,hd,1);
  if a_w =0 then
  a_w:=numerotabella(st_8,hd,2);
  with tabellacorrente^[a_w] do
  with dialog^ do
  begin
    transferdata(tf_getdata);
    pg:=(getposition div datpg)+1;
    if getposition mod datpg =0 then pg:=pg-1;

    str(pg,st);
    st:='Pag:'+st;
    strpcopy(pag,st);
    st_pag^.clear;
    st_pag^.settext(pag);
    pos:=getposition;
    if pos-1>ndatg-datpg then  pos:= (ndatg-datpg)+1;
    ofsettab:=ofsin+(pos-1)*rofs;
    transferdata(tf_setdata);
    scrivibarra;
    if isnrigheset then
    begin
      if (DatPG <> 1) then
      for vv:=1 to DatPg do
      begin
        str( (getposition-1+vv),stv);
        stv1:= format(stv,4);
        strpcopy(stc,stv1);
        numeririga[vv]^.settext(stc);
      end;
    end;
  end
end;
procedure tscrolla.sblineup(var msg:owindows.tmessage);
var st:string[8];
    pag:array[0..8] of char;
    hd:hwnd;
    stc:array[0..4] of char;
begin
  hd:=parent^.hwindow;
  a_w:=numerotabella(st_8,hd,1);
  with tabellacorrente^[a_w] do
  with dialog^ do
  begin
    inherited sblineup(msg);
    dialog^.transferdata(tf_getdata);
    numerolineatabella:=getposition;
    pg:=(getposition div datpg)+1;
    if getposition mod datpg =0 then pg:=pg-1;
    str(pg,st);
    st:='Pag:'+st;
    strpcopy(pag,st);
    st_pag^.clear;
    st_pag^.settext(pag);
    pos:=getposition;
    if pos-1>ndatg-datpg then  pos:= (ndatg-datpg)+1;
    ofsettab:=ofsin+(pos-1)*rofs;
    dialog^.transferdata(tf_setdata);
    scrivibarra;
    if isnrigheset then
    begin
      if (DatPG <> 1) then
      for vv:=1 to DatPg do
      begin
        str( (getposition-1+vv),stv);
        stv1:= format(stv,4);
        strpcopy(stc,stv1);
        numeririga[vv]^.settext(stc);
      end;
    end;
  end;
end;

procedure tscrolla.sbpagedown(var msg:owindows.tmessage);
var st:string[8];
    pag:array[0..8] of char;
    hd:hwnd;
    stc:array[0..4] of char;
begin
  hd:=parent^.hwindow;
  a_w:=numerotabella(st_8,hd,1);

  with tabellacorrente^[a_w] do
  with dialog^ do
  begin
  BEGIN
    inherited sbpagedown(msg);
    if pg < ndatg div DatPg then pg:=pg+1;
    str(pg,st);
    st:='Pag:'+st;
    strpcopy(pag,st);
    st_pag^.clear;
    st_pag^.settext(pag);
    dialog^.transferdata(tf_getdata);
    if getposition-1<= ndatg-datpg then
    begin
      ofsettab:=ofsin+(getposition-1)*rofs;
      dialog^.transferdata(tf_setdata);
      scrivibarra;
      if isnrigheset then
      begin
        if (DatPG <> 1) then
        for vv:=1 to DatPg do
        begin
          str( (getposition-1+vv),stv);
          stv1:= format(stv,4);
          strpcopy(stc,stv1);
          numeririga[vv]^.settext(stc);
        end;
      end;
    end;
  end
  end;
end;
procedure tscrolla.sbpageup(var msg:owindows.tmessage);
var st:string[8];
    pag:array[0..8] of char;
    hd:hwnd;
    stc:array[0..4] of char;
begin
  hd:=parent^.hwindow;
  a_w:=numerotabella(st_8,hd,1);
  with tabellacorrente^[a_w] do
  with dialog^ do
  begin

  begin
    inherited sbpageup(msg);
    if pg > 1 then pg:=pg-1;
    str(pg,st);
    st:='Pag:'+st;
    strpcopy(pag,st);
    st_pag^.clear;
    st_pag^.settext(pag);
    dialog^.transferdata(tf_getdata);
    scrivibarra;
    if getposition-1<= ndatg-datpg then
    begin
      ofsettab:=ofsin+(getposition-1)*rofs;
      dialog^.transferdata(tf_setdata);
      if isnrigheset then
      begin
        if (DatPG <> 1) then
        for vv:=1 to DatPg do
        begin
          str( (getposition-1+vv),stv);
          stv1:= format(stv,4);
          strpcopy(stc,stv1);
          numeririga[vv]^.settext(stc);
        end;
      end;
    end;
  end
  end;
end;

procedure tscrolla.sbThumbposition(var msg:owindows.tmessage);
var st:string[8];
    pag:array[0..8] of char;
    i:integer;
    hd:hwnd;
    stc:array[0..4] of char;
begin
  inherited sbThumbposition(msg);
  hd:=parent^.hwindow;
  a_w:=numerotabella(st_8,hd,1);
  with tabellacorrente^[a_w] do
  with dialog^ do
  begin
    dialog^.transferdata(tf_getdata);
    numerolineatabella:=getposition;
    pg:=(getposition div datpg)+1;
    if getposition mod datpg =0 then pg:=pg-1;
    str(pg,st);
    st:='Pag:'+st;
    strpcopy(pag,st);
    st_pag^.clear;
    st_pag^.settext(pag);
    if getposition-1<= ndatg-datpg then
    begin
      ofsettab:=ofsin+(getposition-1)*rofs;
      dialog^.transferdata(tf_setdata);
      scrivibarra;
      if isnrigheset then
      begin
        if (DatPG <> 1) then
        for vv:=1 to DatPg do
        begin
          str( (getposition-1+vv),stv);
          stv1:= format(stv,4);
          strpcopy(stc,stv1);
          numeririga[vv]^.settext(stc);
        end;
      end;
    end;
  end;
end;



Procedure Tdialogo.tastof3 ;
var hd:hwnd;
begin
  setcursor(cur_asp);
  hd:=hwindow;
  st_8:=nomtab;
  a_w:=numerotabella(st_8,hd,2);
  with tabellacorrente^[a_w] do
  begin
    transferdata(tf_getdata);
    numerolineatabella:=nlinetab(a_w);
    tasti[3];
    if setdata then
    begin
      transferdata(tf_setdata);
      setfocus(dialog^.getitemhandle(campoprecedente));
    end;
  end;
  setdata:=true;
  getdata:=true;
end;

Procedure Tdialogo.tastof6 ;
var i,j,k,limite,lin:integer;
    pprec,psucc:Pchar;
    hd:hwnd;
begin
  hd:=hwindow;
  st_8:=nomtab;
  a_w:=numerotabella(st_8,hd,2);
  with tabellacorrente^[a_w] do
  begin
    Limite:=(NDatg-1);
    transferdata(tf_getdata);
    numerolineatabella:=nlinetab(a_w);
    tasti[6];
    if ins_data then
    begin
      Lin:=nlinetab(a_w);
      for j:=Limite downto Lin do
      begin
        for k:=0 to ROfs-1 do
        begin
          PPrec:=ptr(BaseTab,Ofsin+(j-1)*ROfs+k);
          PSucc:=ptr(Basetab,Ofsin+j*ROfs+k);
          PSucc^:=PPrec^;
        end;
      end;

      for k:=0 to ROfs-1 do
      begin
        PSucc:=ptr(BaseTab,Ofsin+(Lin-1)*ROfs+k);
        PSucc^:=chr(0);
      end;

    end;
  end;
  transferdata(tf_setdata);
  setfocus(getitemhandle(campoprecedente));
  setdata:=true;
  getdata:=true;
  ins_data:=true;
end;


Procedure Tdialogo.tastof5 ;
var i,j,k,limite,lin:word;
    hd:hwnd;
    pprec,psucc:Pchar;
    oflprec,oflcor:word;
begin
  hd:=hwindow;
  st_8:=nomtab;
  a_w:=numerotabella(st_8,hd,2);
  with tabellacorrente^[a_w] do
  begin
    transferdata(tf_getdata);
    numerolineatabella:=nlinetab(a_w);
    tasti[5];
    if Canc_data then
    begin
      lin:=nlinetab(a_w);
      Limite:=(NDatg-1){-lin-(i-1);};
      for j:=Lin to Limite do
      begin
        for k:=0 to ROfs-1 do
        begin
          PPrec:=ptr(Basetab,Ofsin+(j-1)*ROfs+k);
          PSucc:=ptr(BaseTab,Ofsin+(j)*ROfs+k);
          PPrec^:=PSucc^;
        end;
      end;
      for k:=0 to ROfs-1 do
      begin
        PSucc:=ptr(BaseTab,Ofsin+Limite*ROfs+k);
        PSucc^:=chr(0);
      end;

    end;
  end;
  transferdata(tf_setdata);
  setfocus(getitemhandle(campoprecedente));
  setdata:=true;
  getdata:=true;
  Canc_data:=true;
end;

Procedure Tdialogo.tastof4 ;
var i,j,k,limite,lin:integer;
    hd:hwnd;
    pprec,psucc:Pchar;
begin
  setcursor(cur_asp);
  hd:=hwindow;
  st_8:=nomtab;
  a_w:=numerotabella(st_8,hd,2);
  with tabellacorrente^[a_w] do
  begin
    if getdata then transferdata(tf_getdata);
    numerolineatabella:=nlinetab(a_w);
    tasti[4];
    if setdata then
    begin
      transferdata(tf_setdata);
      setfocus(dialog^.getitemhandle(campoprecedente));
    end;
  end;
  setdata:=true;
  getdata:=true;
end;
Procedure Tdialogo.tastof7 ;
var i,j,k,limite,lin:integer;
    hd:hwnd;
    pprec,psucc:Pchar;
begin
  setcursor(cur_asp);
  hd:=hwindow;
  st_8:=nomtab;
  a_w:=numerotabella(st_8,hd,2);
  with tabellacorrente^[a_w] do
  begin
    if getdata then transferdata(tf_getdata);
    numerolineatabella:=nlinetab(a_w);
    tasti[7];
    if setdata then
    begin
      transferdata(tf_setdata);
      setfocus(dialog^.getitemhandle(campoprecedente));
    end;
  end;
  setdata:=true;
  getdata:=true;
end;

Procedure Tdialogo.tastof8 ;
var hd:hwnd;
begin
  setcursor(cur_asp);
  hd:=hwindow;
  st_8:=nomtab;
  a_w:=numerotabella(st_8,hd,2);
  with tabellacorrente^[a_w] do
  begin
    if getdata then transferdata(tf_getdata);
    numerolineatabella:=nlinetab(a_w);
    tasti[8];
    if setdata then
    begin
      transferdata(tf_setdata);
      setfocus(dialog^.getitemhandle(campoprecedente));
    end;
  end;
  setdata:=true;
  getdata:=true;
end;


Procedure Tdialogo.tastopgup ;
var msg:owindows.tmessage;
    hd:hwnd;
begin
  if isiotab then scrolla^.sbpageUp(msg) else tasti[21];
end;

Procedure Tdialogo.tastopgDn ;
var msg:owindows.tmessage;
    hd:hwnd;
begin
  if isiotab then
  BEGIN
    scrolla^.sbpageDown(msg);
    scrivibarra;
  END
  else
  tasti[22];
end;




function tviswin.getclassname:pchar;
begin
  getclassname:='tviswin';
end;


(*
constructor tdlgviswin.Init(AParent:Pwindowsobject; AName:pchar;afilename:string);
begin
  inherited init(aparent,ANAME);
  new(visedit,init(@self,'',afilename));
  {visedit^.disabletransfer;}
end;
*)


constructor tviswin.Init(AParent: PWindowsObject; Atitle:pchar;afilename:string);

begin
  twindow.init(aparent,atitle);
  with attr do
  begin
    style:=style or ws_overlappedwindow OR WS_VSCROLL;
    x:=1;
    y:=1;
    h:=10;
    w:=10;
  end;
  scroller:=new(pscroller,init(@self,10,10,100,100));
  scroller^.HasHScrollBar:=false;
  filename:=afilename;
  FileLines := New(PPCharCollection, Init(10,10));
  loadfile;
  with Font do
  begin
    lfHeight        := -6;
    lfWidth         := 0;
    lfEscapement    := 0;
    lfOrientation   := 0;
    lfWeight        := fw_semibold;
    lfItalic        := 0;
    lfUnderline     := 0;
    lfStrikeOut     := 0;
    lfCharSet       := 1;
    lfOutPrecision  := Out_Default_Precis;
    lfClipPrecision := Clip_Default_Precis;
    lfQuality       := default_Quality;
    lfPitchAndFamily:= Fixed_Pitch or ff_modern; {default_pitch or ff_roman;}
    StrCopy(lfFaceName,'Courier new');{'Times new roman');}
  end;
end;

function TVisWin.canclose:boolean;
begin
  if Assigned(FileLines) then Dispose(FileLines, Done);
  tviswincl:=true;
end;

procedure TVisWin.LoadFile;
var
  stline:string[80];
  TextLine: array[0..80] of Char;
  TextFile: Text;
  trovato,ce:boolean;
  nomefile,nomefile1:string;
  i:integer;
procedure cercamask;
begin
  readln(TextFile,stline);
  filename:=upstring(filename);
  while not trovato and not eof(textfile) do
  begin
    trovato:=stline[1]='#';
    if not trovato then
    begin
      readln(TextFile,stline);
    end
    else
    begin
      trovato:=copy(stline,2,length(stline)-1)=filename;
      if not trovato then
      begin
        readln(TextFile,stline);
      end;
    end;
  end;
end;



begin
  FileLines^.deleteall;
  if eliminadir(filename)='errori.hlp' then
  begin
    if not exist(filename) then
    begin
      stline:='Non esiste '+filename;
      strpcopy(textline,stline);
      FileLines^.Insert(StrNew(TextLine));
      exit;
    end;
    Assign(TextFile, FileName);
    Reset(TextFile);
    trovato:=true;
  end
  else
  begin
    trovato:=false;
    nomefile:=filename;
    i:=1;
    nomefile1:='';
    while filename[i]<>'.' do
    begin
      nomefile1:=nomefile1+filename[i];
      inc(i);
    end;
    filename:=nomefile1+'.hlp';
    if exist(drivemask+'masks.elp') then
    begin
      ce:=true;
      Assign(TextFile, drivemask+'masks.elp');
      reset(textfile);
      cercamask;
    end
    else
    ce:=false;
    if not trovato then
    begin
      if ce then close(textfile);
      if exist('masks.elp') then
      begin
        ce:=true;
        Assign(TextFile, 'masks.elp');
        reset(textfile);
        cercamask;
      end
      else
      ce:=false;
    end;
    if not trovato then
    begin
      filename:=nomefile;
      if ce then close(textfile);
      if exist(drivemask+'masks.elp') then
      begin
        Assign(TextFile, drivemask+'masks.elp');
        reset(textfile);
        cercamask;
        ce:=true;
      end
      else
      ce:=false;
      if not trovato then
      begin
        if ce then close(textfile);
        if exist('masks.elp') then
        begin
          ce:=true;
          Assign(TextFile, 'masks.elp');
          reset(textfile);
          cercamask;
        end
        else
        ce:=false;
      end;
    end;
  end;
  if not trovato then
  begin
    if ce then close(textfile);
    stline:='WARNING';
    strpcopy(textline,stline);
    FileLines^.Insert(StrNew(TextLine));
    stline:='Help non disponibile per questo campo';
    strpcopy(textline,stline);
    FileLines^.Insert(StrNew(TextLine));
  end
  else
  begin
    trovato:=false;
    while not eof(TextFile) and not trovato do
    begin
      Readln(TextFile, StLine);
      trovato:=(stline[1]='#') and (stline>'');
      if not trovato then
      begin
        strpcopy(textline,stline);
        FileLines^.Insert(StrNew(TextLine));
      end;
    end;
    Close(TextFile);
  end;
end;


procedure Tviswin.setupwindow;
var dc:hdc;
    textmetrics:ttextmetric;
    altezzatesto,largtesto:LONGINT;
    testo:string[78];
    parola:ARRAY[0..78] OF CHAR;
    ilfont:hfont;
begin
  dc:=getdc(hwindow);
  {ilfont:=createfontindirect(font);}
  selectobject(dc,getstockobject(10));
  GetTextMetrics(DC,TextMetrics);
  testo:='BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB';
  strpcopy(parola,testo);
  largtesto:=GetTextExtent(DC,PAROLA,SIZEOF(PAROLA));
  Altezzatesto := TextMetrics.tmHeight;
  larg_scheda:=getdevicecaps(dc,horzres);
  with attr do
  begin
  x:=larg_scheda-640;
  y:=1;
  w:=640;
  h:=25*altezzatesto;
  movewindow(hwindow,x,y,w,h,true);
  end;
  deleteobject(getstockobject(10));
  releasedc(hwindow,dc);
end;


procedure tviswin.paint(PaintDC: HDC; var PaintInfo: TPaintStruct);
var
  Line,j,i,k: Integer;
  TheText: PChar;
  altezzatesto,largtesto,y,x,colore,verr:integer;
  textmetrics:ttextmetric;
  buf:string;
  chp:array[0..1]of char;
  chs:string[1];
  int1:integer;
  real1,real2:real;
  R:TRECT;
  S:STRING;
  ilfont:hfont;
  st_s:string[80];
  st_c:array[0..80] of char;
begin
  y:=5;
  {ilfont:=createfontindirect(font);}
  selectobject(Paintdc,getstockobject(10));
  GetTextMetrics(PaintDC,TextMetrics);
  Altezzatesto :=TextMetrics.tmHeight;;
  THETEXT := pchar(filelines^.At(0));
  if thetext<> nil then
  begin
    OEMTOANSI(thetext,thetext);
    setcaption(thetext);
  end;
  for Line := 1 to filelines^.count-1 do
  begin
    THETEXT := pchar(filelines^.At(Line));
    if Thetext <> nil then
    begin
      {OEMTOANSI(thetext,thetext);}
      buf:=strpas(thetext);
      st_s:='';
      fillchar(st_c,sizeof(st_c),0);
      for i :=1 to length(buf) do
      if buf[i]=#157 then
      begin
        i:=i+1;
        repeat
          i:=i+1;
          if buf[i]<>#157 then st_s:=st_s+buf[i];
        until buf[i]=#157;
      end
      else
      st_s:=st_s+buf[i];

      strpcopy(st_c,st_s);
      TextOut(PaintDC, 10,y, st_c, StrLen(st_c));
      y:=5+(line*altezzatesto);
    end
    else
    begin
      st_s:='';
      strpcopy(st_c,st_s);
      TextOut(PaintDC, 10,y, st_c, StrLen(st_c));
      y:=5+(line*altezzatesto);
    end;
  end;
  deleteobject(getstockobject(10));
end;

procedure vishelp(filename:string);
var esegui:boolean;
begin
  {esegui:=false;
  IF exist (drivemask+filename) then
  begin
    esegui:=true;
    filename:=drivemask+filename;
  end
  else
  if exist(filename) then
  begin
    esegui:=true;
  end;
  if esegui then}
  if tviswincl then
  begin
    tviswincl:=false;
    new(viswin,init(pmainwin,'',filename));
    application^.makewindow(viswin);
    with viswin^.attr do
    viswin^.show(sw_show);
  end
  else
  begin
    viswin^.filename:=filename;
    viswin^.loadfile;
    setactivewindow(viswin^.hwindow);
    invalidaterect(viswin^.hwindow,nil,true);
  end;
end;


procedure TPCharCollection.FreeItem(Item: Pointer);
begin
  StrDispose(PChar(Item));
end;








procedure W_UsaMaskera(var dato;NomeFile:st80;itasti:proc;modal:boolean;var cod:integer;fill_lista:proc1;aself:pwindowsobject);

var pc: array[0..80]of char;
    nomemask:st8;
    st:string;
    a:hwnd;
    i:integer;
    stinfo:array[0..80] of char;
    p:pwindowsobject;
    ht:thandle;
begin
  setcursor(cur_asp);
  creazione:=true;
  a:=0;
  strpcopy(pc,nomefile);
  st:=eliminadir(nomefile);
  nomemask:=copy(st,1,length(st)-4);
  a_w:=numerotabella(nomemask,a,3);
  WITH tabellacorrente^[a_w] do
  begin
    if aself=nil then Dialog := New(pdialogo, Init(pmainwin,pc,dato,false,itasti,fill_lista,false,modal,1,0,1))
    else
    Dialog := New(pdialogo, Init(aself,pc,dato,false,itasti,fill_lista,false,modal,1,0,1));
    i:=a_w;
    nome:=nomemask;
    st_8:=nome;
    a_w:=i;
    if modal then
    begin
      cod:=application^.execdialog(dialog);
      nome:='';
      dialog:=nil;
      maniglia:=0;
    end
    else
    begin
      ht:=0;

      ht:=findresource(hinstance,'',rt_dialog);
      p:=nil;
      p:=application^.validwindow(dialog);
      application^.makewindow(p);
    end;
  end;
  initins;
end;


procedure W_IOTabella(var dato;NDat,DatP,DatR:integer;mask:st80;Setnrighe:boolean;
                          itasti:proc;modal:boolean;var cod:integer;fill_lista:proc1;aself:pwindowsobject);
var pc:array[0..80] of char;
    i:integer;
    nomemask:st8;
    st:string;
    hd:hwnd;
    stinfo:array[0..80] of char;
    p:pwindowsobject;
begin
  setcursor(cur_asp);
  creazione:=true;
  hd:=0;
  a_w:=numerotabella(nomemask,hd,3);
  with tabellacorrente^[a_w] do
  begin
    strpcopy(pc,mask);
    st:=eliminadir(mask);
    nomemask:=copy(st,1,length(st)-4);
    st_8:=nomemask;
    nome:=nomemask;
    if aself=nil then Dialog := New(pdialogo, Init(pmainwin,pc,dato,setnrighe,itasti,fill_lista,true,modal,Ndat,DatP,DatR))
    else Dialog := New(pdialogo, Init(aself,pc,dato,setnrighe,itasti,fill_lista,true,modal,Ndat,DatP,DatR));

    if modal then
    begin
      cod:=application^.execdialog(dialog);
      {tabellacorrente^[a_w].dialog^.campoattivo:=0;
      SendMessage(pmainwin^.HWindow,am_DrawStatusLine, A_W, 0);}
      nome:='';
      dialog:=nil;
      maniglia:=0;
      {if a_w>1 then
      with tabellacorrente^[a_w-1] do
      begin

        setfocus(dialog^.getitemhandle(dialog^.campoprecedente))

      end;}
    end
    else
    begin
      application^.makewindow(dialog);
    end;

  end;
  initins;
end;


procedure aggtab(nome:st8;ndat:integer;Rec_To_Mask:boolean);
var hd:hwnd;
    st:string[8];
    pag:array[0..8] of char;
begin
  a_w:=numerotabella(nome,hd,2);
  with tabellacorrente^[a_w].dialog^ do
  begin
    if isiotab then
    begin
      ndatg:=ndat;
      scrolla^.max:=ndat;
      ofsettab:=ofsin;
      pg:=1;
      str(pg,st);
      st:='Pag:'+st;
      strpcopy(pag,st);
      st_pag^.clear;
      st_pag^.settext(pag);
      scrolla^.max:=ndat;
      scrolla^.setupwindow;
      st_pag^.settext(pag);
      numerolineatabella:=1;
    end;
    if Rec_to_mask
    then transferdata(tf_setdata)
    else
    transferdata(tf_getdata);
  end;
end;

procedure canctab(nomeT:st8);
begin
  a_w:=numerotabella(nomet,hd,2);
  if a_w>0 then
  with tabellacorrente^[a_w] do
  begin
    nome:='';
    dispose(dialog,done)
  end;
end;
procedure mostraTab(nomeT:st8);
begin
  a_w:=numerotabella(nomet,hd,2);
  with tabellacorrente^[a_w].dialog^ do
  begin
    show(sw_show);
  end;
end;

procedure NascondiTab(nomeT:st8);
begin
  a_w:=numerotabella(nomet,hd,2);
  with tabellacorrente^[a_w].dialog^ do
  begin
    show(sw_hide);
  end;
end;

procedure generica;
var st:string;
begin
  ins_data:=true;
  canc_data:=true;
end;
function cangen:boolean;far;
begin
cangen:=true;
end;

procedure fill_listagen(var pcb:pfill_edit);
begin
end;

procedure visbit(x1,y1,x2,y2:integer;BitMap:Pchar);
var
  BM: HBitmap;
  DC, MemDC: HDC;
  BitInfo: TBitmap;
  pc:array[0..5] of char;
  paL:tlogpalette;
    i:integer;
    pe:tpaletteentry;
begin
  DC := cont;
  MemDC := CreateCompatibleDC(DC);
  BM := LoadBitmap(HInstance, Bitmap);
  GetObject(BM, SizeOf(BitInfo), @BitInfo);
  BM := SelectObject(MemDC, BM);   { swap BMs}
 { R.Left := GetDeviceCaps(DC,HORZRES) div 2 - BitInfo.bmWidth div 2;
  R.Top := GetDeviceCaps(DC,VERTRES) div 2 - BitInfo.bmHeight div 2;
  BitBlt(DC, x1, y1, BitInfo.bmWidth, BitInfo.bmHeight,
         MemDC, 0, 0, SrcCopy);}

   stretchBlt(DC, x1, y1, x2,y2,
         MemDC, 0, 0, BitInfo.bmWidth, BitInfo.bmHeight,SrcCopy);

  DeleteObject(SelectObject(MemDC, BM));
  DeleteDC(MemDC);
  {ReleaseDC(0, DC);
  R.Right := R.Left + BitInfo.bmWidth;
  R.Bottom := R.Top + BitInfo.bmHeight;}
end;



procedure setwinactive(st:string);
begin
st_8:=st;
a_w:=numerotabella(st_8,hd,2);
with tabellacorrente^[a_w] do
setactivewindow(maniglia);
end;

function getriga(st:string):integer;
begin
  st_8:=st;
  a_w:=numerotabella(st_8,hd,2);
  getriga:=tabellacorrente^[a_w].dialog^.numerolineatabella;
end;

function getwin(st:string):integer;
begin
  st_8:=st;
  a_w:=numerotabella(st_8,hd,2);
  getwin:=a_w;
end;


PROCEDURE InitProc;
var i:integer;
begin

  for i:=1 to maxtasti do procarr[i]:=generica;

end;

function getrattiva(st:st8):integer;
var lm:integer;
    hd:hwnd;

begin
  st_8:=st;
  a_w:=numerotabella(st_8,hd,2);
  with tabellacorrente^[a_w].dialog^ do
  if isiotab then
  begin
  lm:=(campoattivo-100) div datrg;
  if  (campoattivo-100) mod datrg <>0 then lm:=lm+1;
  getrattiva:=scrolla^.GETPOSITION+lm-1;
  end;

end;

procedure setposintab(ntab:string;pos:integer);
var msg:owindows.tmessage;
begin
  st_8:=ntab;
  a_w:=numerotabella(ST_8,hd,2);
  with tabellacorrente^[a_w] do
  with dialog^ do
  begin
    numerolineatabella:=pos;
    scrolla^.setposition(pos);
    fillchar(msg,sizeof(msg),0);
    msg.message:=wm_hscroll;
    msg.lparam:=pos;
    msg.wparam:=SB_THUMBPOSITION;
    scrolla^.sbThumbposition(msg);
    setdata:=true;
  end;
end;
Function oem_ans(s:string):string;
var s1:string[255];
    p1:array[0..255] of char;
begin
  s1:=s;
  strpcopy(p1,s1);
  oemtoansi(p1,p1);
  oem_ans:=strpas(p1);
end;


Function ans_oem(s:string):string;
var s1:string[255];
    p1:array[0..255] of char;
begin
  s1:=s;
  strpcopy(p1,s1);
  ansitooem(p1,p1);
  ans_oem:=strpas(p1);
end;



{$endif}

function Pos_ins(NomeMask:string;Campo:integer;Strx:string):integer;
Type Opzioni=Record
                Descr :String[64];
                valore:String[16];
             end;
var BufOpz :Opzioni;
    Fopz   :File of Opzioni;
    i:integer;
    Ex:string;
    Trovato:boolean;
    pcc:array[0..79] of char;
    pcs:string[79];
    st_5:string[5];
begin
   str(campo:2,Ex);
   Ex:=FormSt(Ex);
   Strx:=FormSt(Strx);
   Trovato:=false;
   if (exist(NomeMask+'.L'+Ex)) or (exist(nomemask))  then
   begin
     if (exist(NomeMask+'.L'+Ex)) then
     begin
       assign(fopz,NomeMask+'.L'+Ex);
       reset(fopz);
     end
     ELSE
     begin
       assign(fopz,NomeMask);
       reset(fopz);
     end;
     i:=-1;    {parto da -1 perche la prima riga non e valida }
     while  (not(Eof(Fopz))) and (Not Trovato) do
     begin
       i:=i+1;
       read(Fopz,BufOpz);
       BufOpz.Descr:=FormSt(BufOpz.Descr);
       Trovato:=BufOpz.Descr=Strx;
     end;
     if not trovato then
     begin
       i:=-1;    {parto da -1 perche la prima riga non e valida }
       close(fopz);
       reset(Fopz);
       while  (not(Eof(Fopz))) and (Not Trovato) do
       begin
         i:=i+1;
         read(Fopz,BufOpz);
         BufOpz.Valore:=FormSt(BufOpz.Valore);
         Trovato:=BufOpz.Valore=Strx;
       end;
     end;
     close(fopz);
    end;
    if not Trovato then
     begin

        (*
        {$ifdef dos}
        gotoxy(1,23);
        textcolor(15);
        write(chr(7));
        write(nomemask,'  ',campo,'  ',strx); delay(1000);
        {$endif}
        {$ifdef win}
        str(campo,st_5);
        pcs:='Manca un dato nella maskera '+nomemask+' al campo N. '+st_5;
        strpcopy(pcc,pcs);
        Bwccmessagebox(0,pcc,'Mc4-hvac',mb_ok or mb_iconhand);
        {$endif}
        *)
        Pos_Ins:=0;
     end
    else Pos_Ins:=i;
end;


function Ins_Pos(NomeMask:string;Campo,Ind:integer):string;
Type Opzioni=Record
                Descr :String[64];
                valore:String[16];
             end;
var BufOpz :Opzioni;
    Fopz   :File of Opzioni;
    i:integer;
    Ex,strx:string;

begin
   str(campo:2,Ex);
   Ex:=FormSt(Ex);
   Strx:='';
   if exist(NomeMask+'.L'+Ex) then
    begin
       assign(fopz,NomeMask+'.L'+Ex);
       reset(fopz);
       i:=-1;
       while  (not(Eof(Fopz))) and (not (i=Ind)) do
        begin
           i:=i+1;
           read(Fopz,BufOpz);
        end;
       close(fopz);
       if i = ind then
        begin
           {if setleft(setright(BufOpz.Valore)) > '' then  Strx:=BufOpz.Valore   else}
           Strx:=BufOpz.Descr;
        end
       {else writeMessage('carterm.msg',28);}
    end;
   {else writeMessage('carterm.msg',28);}
   Ins_pos:=Strx;
end;

function Ins_PosV(NomeMask:string;Campo,Ind:integer):string;
Type Opzioni=Record
                Descr :String[64];
                valore:String[16];
             end;
var BufOpz :Opzioni;
    Fopz   :File of Opzioni;
    i:integer;
    Ex,strx:string;

begin
   str(campo:2,Ex);
   Ex:=FormSt(Ex);
   Strx:='';
   if exist(NomeMask+'.L'+Ex) then
    begin
       assign(fopz,NomeMask+'.L'+Ex);
       reset(fopz);
       i:=-1;
       while  (not(Eof(Fopz))) and (not (i=Ind)) do
        begin
           i:=i+1;
           read(Fopz,BufOpz);
        end;
       close(fopz);
       if i = ind then Strx:=BufOpz.Valore
    end;
   Ins_posV:=Strx;
end;

Function ControlNom(Rag:string):boolean;

var j,Lung:integer;
    Pass:boolean;
    s:string[50];

begin
 { getdir(0,s);
  chdir(get_drive);
  Rag:=UpString(Rag);
  Rag:=setleft(setright(Rag));
  Lung:=length(Rag);
  if lung=0 then
  begin
    writeMessage('hvac.msg',1);
    ControlNom:=false;
    exit;
  end;}
  ControlNom:=true;
 { j:=1;
  repeat
   if ((Rag[j] < 'A') or (Rag[j] > 'Z')) and
      ((Rag[j] < '0') or (Rag[j] > '9')) and
      ((Rag[j] <> '_') and (Rag[j] <> '-')) then
    begin
       writeMessage('hvac.msg',1);
       ControlNom:=false;
       j:=Lung+1;
    end;
    j:=j+1;
  until j > Lung;
  chdir(s);}
end;

procedure cambiadir(s:string);
begin
  getdir(0,olddir);
  chdir(s);
end;

procedure restoredir;
begin
  chdir(olddir);
end;



End.
