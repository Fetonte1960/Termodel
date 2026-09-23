

unit prntesto;

interface

procedure eseguistampa;

implementation

uses commdlg,WinDos, Strings, WinTypes, WinProcs, Objects, OWindows, OStdDlgs, OPrinter,bwcc,odialogs,
     utilitie,{$ifdef igro}halotp4,graph,igrograf,{$endif}definiz,defuti,def_win,main_w,WM
     {$ifdef delphi},messages {$else} ,win31{$endif};

{R PRNTEST.RES}

{ PRNTEST.INC}


type videotipo=record
                ch8514:string[1];
                chmess:string[1];
                STAMPE:STRING[1];
                drvprg:string[30];
                drvarc:string[30];
                drvcad:string[30];
                lincad:string[30];
           end;



type
  PPCharCollection = ^TPCharCollection;
  TPCharCollection = object(TCollection)
    procedure FreeItem(Item: Pointer); virtual;
  end;


TYPE
  PTextExtent =^TTextExtent;
  TTextExtent = array[1..8000]  of record
                                  x1, y1,
                                  x2,y2  : Word;
  end;

type

  pabrdlg=^tabrdlg;
  tabrdlg=object(TPrinterAbortDlg)
  mc:pcheckbox;
  mt:pstatic;
  constructor Init(AParent: PWindowsObject; Template, Title, Device,Port: PChar);
  procedure wmcommand(var msg:owindows.tmessage);virtual wm_First + wm_Command;

  end;


  pmyprdlg=^tmyprdlg;
  tmyprdlg=object(tprintdialog)
  procedure setstamp(var msg:tmessage);virtual id_first+110;
  procedure TransferData(Direction: Word); virtual;

  end;

  pmysetupdlg=^tmysetupdlg;
  tmysetupdlg=object(tprintersetupdlg)
  procedure cancel(var msg:owindows.tmessage);virtual id_first+id_cancel;
  end;

  pmyprint=^tmyprint;
  tmyprint=object(tprinter)
  abdl:pabrdlg;
  function InitPrintDialog(Parent: PWindowsObject; PrnDC: HDC; Pages: Integer;  SelAllowed: Boolean; var
         Data: TPrintDialogRec): PDialog; virtual;
  function InitAbortDialog(Parent: PWindowsObject; Title: PChar):PDialog; virtual;
  function InitSetupDialog(Parent: PWindowsObject): PDialog; virtual;
  end;


  PTextPrint = ^TTextPrint;
  TTextPrint = object(TPrintout)
  stampante:pmyprint;
    constructor Init;
    function GetDialogInfo(var Pages: Integer): Boolean; virtual;
    function HasNextPage(Page: Word): Boolean; virtual;
    procedure SetPrintParams(ADC: HDC; ASize: TPoint); virtual;
    procedure PrintPage(Page: Word; var Rect: TRect; Flags: Word); virtual;

  end;





const pghp=3367;
      hfinvis=700;
      lfinvis=1000;
      ndisprn=3000;
      htv =5;

type eldoc=array [1..ndisprn] of record pagina,nrighe:integer end;

var

  ALTEZZA_ESPANSO:INTEGER;
  altezza_compresso:integer;
  step_compresso,step_espanso:integer;
  Printout: Ptextprint;
  ANNULLA:boolean;
  paghp:longint;
  htcv:integer;
  xstepfont,ystepfont:integer;
  {FileName: array[0..fsPathName] of Char;}
  TheLines: PCollection;
  documento:^eldoc;
  fonthand   :hfont;
  mainfontrec:^tlogfont;
  FontMetric: ^tOutlineTextMetric;
  FontHeight: Integer;
  d         : Word;
  Theta     : Real;
  P         : PChar;
  CRect     : TRect;
  fi        : integer;
  BaseWidth,
  DesiredExtent,
  FanTextLen: Word;
  altpag,largpag:longint;
  DisPrn    : PTextExtent;
  d_cor     :integer;
  altezzafont,altfs,altfv:longint;
  Altezzatesto:integer;
  ll,llv,lls:integer;
  paginacor:integer;
  numeropag:integer;
  FileLines: PPCharCollection;
 { pagina:integer;}
  testo,video:boolean;
  punto:tpoint;
  rigav,rigas,riga:integer;
  config:^videotipo;
function ms(n:real):real;
var p:tpoint;
    alp,k:integer;
    alhp:integer;
begin
  ms:=n*altpag/paghp;
end;


procedure TPCharCollection.FreeItem(Item: Pointer);
begin
  StrDispose(PChar(Item));
end;


procedure LoadFile;
var
  TextLine: array[0..255] of Char;
  TextFile: Text;
  nome:string;
  Line,j,i: Integer;
    col:integer;
    st1:string[1];
    thetext:string[255];
    TheTextC:array[0..1] of char;
    TheTextp:pchar;
  st3:string[3];
begin
  nome:='stampe.lst';
  if Assigned(FileLines) then Dispose(FileLines, Done);
  FileLines := New(PPCharCollection, Init(1000, 100));
  Assign(TextFile, Nome);
  Reset(TextFile);
  while not eof(TextFile) do
  begin
    Readln(TextFile, TextLine);
    FileLines^.Insert(StrNew(TextLine));
  end;
  Close(TextFile);
  new(disprn);
  d_cor:=0;
  testo:=true;
  line:=0;
  numeropag:=0;
  j:=0;
  col:=1;

  repeat

  with documento^[col] do
  begin
    line:=line+1;
    j:=J+1;
    TheTextP := pchar(filelines^.At(Line));
    if TheTextP <> nil then
    begin
      thetext:=strpas(ThetextP);
      for i:=1 to length(thetext) do
      if (thetext[i]='') then
      begin
         numeropag:=numeropag+1;
         if col>1 then pagina:=documento^[col-1].pagina+J else pagina:=j;
         nrighe:=J;
         col:=col+1;
         j:=0;
      end;
    end;
  end;
  until line>=filelines^.count-1;
end;

procedure Init;
var
    x,i,j:longint;
    k:integer;
    fine:boolean;
    TextMetrics: TTextMetric;
    thetext:string;
    r:trect;
    dcgen:hdc;
    p:tpoint;
    lgpx,lgpy:longint;
begin

  new(documento);
  FileLines := New(PPCharCollection, Init(1000, 100));
  dcgen:=printout^.stampante^.getdc;
  altpag:=getdevicecaps(dcgen,vertres);
  largpag:=getdevicecaps(dcgen,Horzres);

  lgpx:=getdevicecaps(dcgen,logpixelsx);
  lgpy:=getdevicecaps(dcgen,logpixelsy);

  paghp:=3367;

  rigav:=round(hfinvis / 70);
  rigas:=round(altpag/66);
  altfs:=round(ms(48));
  fi:=2;
  altfv:=htv*fi;
  altezzafont:=altfs;
  {pagina:=1;}
  testo:=false;
  with MainFontRec^ do
  begin
    lfHeight        := 0;
    lfWidth         := 0;
    lfEscapement    := 0;
    lfOrientation   := 0;
    lfWeight        := fw_medium;
    lfItalic        := 0;
    lfUnderline     := 0;
    lfStrikeOut     := 0;
    lfCharSet       := 0;
    lfOutPrecision  := Out_Default_Precis;
    lfClipPrecision := Clip_Default_Precis;
    lfQuality       := default_Quality;

    lfPitchAndFamily:= Fixed_Pitch or ff_modern;
    StrCopy(lfFaceName,'Courier new');
    {

    lfPitchAndFamily:= Variable_Pitch or ff_roman;
    StrCopy(lfFaceName,'Times new roman');
     }
  end;
  for i:=1 to ndisprn do with documento^[i] do
  begin
    pagina:=0;
    nrighe:=0;
  end;
  ll:=round(ms(8));
  LoadFile;
end;





procedure neretto(dc:hdc);
 begin
   with mainfontrec^ do
   lfWeight:=fw_black;
   deleteobject(selectobject(dc,createfontindirect(mainfontrec^)));
 end;

procedure bianchetto(dc:hdc);
 begin
   deleteobject(fonthand);
   with mainfontrec^ do
   lfWeight:=fw_medium;
   deleteobject(selectobject(dc,createfontindirect(mainfontrec^)));
end;



procedure compresso(dc:hdc);
var stc:array[0..1] of char;
    sts:string[1];
begin
  with mainfontrec^ do
  begin
    lfHeight:=-altezza_compresso;
  end;
  deleteobject(selectobject(dc,createfontindirect(mainfontrec^)));
  xstepfont:=step_compresso;
end;

procedure setta_compresso(dc:hdc);
var textmetrics:TTextMetric;
    altcompr,altcs,altcv:longint;
    stc:array[0..1] of char;
    sts:string[1];
    lp,lpt:integer;
 begin

   altcompr:=round(ms(40));
   repeat
   with mainfontrec^ do
   begin
     lfHeight:=-altcompr;
   end;
   deleteobject(selectobject(dc,createfontindirect(mainfontrec^)));
   sts:='B';
   strpcopy(stc,sts);
   xstepfont:=Loword(GetTextExtent(dc,stC,strlen(stc)));


   lp:=xstepfont*126;
   lpt:=largpag-xstepfont*5;

   altcompr:=altcompr-1;

   until (lp <=lpt) or (altcompr < 6);
   altezza_compresso:=altcompr+1;
   step_compresso:=xstepfont;
end;


PROCEDURE ESPANSO(dc:hdc);
var stc:array[0..1] of char;
    sts:string[1];
BEGIN
  with mainfontrec^ do
   begin
     lfHeight:=-altezza_espanso;
   end;
   deleteobject(selectobject(dc,createfontindirect(mainfontrec^)));
   xstepfont:=step_espanso;
END;

procedure SETTA_espanso(dc:hdc);
var textmetrics:TTextMetric;
    stc:array[0..1] of char;
    sts:string[1];
    altcompr:longint;
    lp,lpt:integer;

 begin

   altcompr:=round(ms(60));
   repeat
   with mainfontrec^ do
   begin
     lfHeight:=-altcompr;
   end;
   deleteobject(selectobject(dc,createfontindirect(mainfontrec^)));
   sts:='B';
   strpcopy(stc,sts);
   xstepfont:=Loword(GetTextExtent(dc,stC,strlen(stc)));
   lp:=xstepfont*76;
   lpt:=largpag-xstepfont*5;
   altcompr:=altcompr-1;
   until (lp <=lpt) or (altcompr < 6);
   altezza_espanso:=altcompr+1;
   step_espanso:=xstepfont;
end;






procedure repaint(dc:hdc;page:integer);

var posy,posys,posyv,line,firstonpage,lastonpage :integer;

procedure grafico(nome:string);
{
type    disegno=record
              entita:string[1];
              testo:string;
	      tlinea:integer;
	      colore:integer;
              x1:real;
              y1:real;
              x2:real;
              y2:real;
           end;


   dis       :disegno;
   fdis      :file of disegno;
}
VAR
   int1,int2,int3,in1,in2,i:integer;
   real1,real2,tmp:real;
   pc1:array[0..80] of char;
   pc3:string[80];
   pc2:pchar;
   spy,spys,spyv:real;
   ft:text;
  begin
  {$ifdef igro}
  setcolor(0);
  setlinestyle(0,0,0);
  settapenna;
  int1:=0;
  posys:=round(rigas*23);
  posyv:=round(rigav*25)*fi;
  spys:=(rigas+((line+6)-firstonpage))*2;
  spyv:=rigav*25;
  if video then
  begin
    spy:=spyv;
    posy:=posyv;
    riga:=3*rigav;
  end
  else
  begin
    spy:=spys;
    posy:=posys;
    riga:=round(rigas/ms(3));
  end;
  {
  if exist(driveprog+nome+'.drw') then
  begin
    assign(fdis,driveprog+nome+'.drw');
    reset(fdis);
    while not eof(fdis) do}
  num:=nome;
  fillchar(disegno^,sizeof(disegno^),0);
  ndisegno:=0;
  EsGrafico(false);
  for i:=1 to ndisegno do
  begin
    if disegno^[i].entita>'' then
    case disegno^[i].entita[1] of
       'L':begin
             setcolor(0);
             setlinestyle(disegno^[i].tlinea,0,0);
             settapenna;
             real2:=(disegno^[i].y1-spy);
             real1:=(disegno^[i].x1);
	     movabs1(@real1,@real2);
             real2:=(disegno^[i].y2-spy);
             real1:=(disegno^[i].x2);
             lnabs1(@real1,@real2);
           end;
       'T':begin
             setlinestyle(disegno^[i].tlinea,0,0);
             setcolor(0);
             settapenna;
             real1:=disegno^[i].x1;
             real2:=disegno^[i].y1-spy{-riga};
             tmp:=real1*inx;
             in1:=round(tmp);
             in2:=round(ysp-real2*iny);
             pc3:=disegno^[i].testo;
             strpcopy(pc1,pc3);
             oemtoansi(pc1,pc1);
             settatesto4(30);
             textout(dc,in1,in2,pc1,strlen(pc1));
           end;
      end;
 {   end;
    close(fdis);}
  end;
  espanso(dc);
  {$endif}
end;

const GrafStr ='(grafico) file ';
var
  l,h: Integer;
  st1:string[1];
  TheTextC:array[0..1] of char;
  thetextpr:array[0..140] of char;
  stprint:string[140];
  TheTextp:pchar;
  i:integer;
  fine:boolean;
  thetext:string;
  ag:integer;
  ll2,l2,h2,xt,x,y,yt:integer;
  TextMetrics:TTextMetric;
  lfontrec:tlogfont;
  punto:tpoint;
  st1a:string;
  hgv,hgs,xinit,xtemp:integer;
  stampariga,caricax,prima:boolean;
  temp,h_win,w_win:real;
  buffer:string[140];
  xbuff:integer;

procedure sc_bf;
var cbuff:array[0..140] of char;
begin
  if (buffer>'') then
  begin
    strpcopy(cbuff,buffer);
    oemtoansi(cbuff,cbuff);
    TextOut(DC, xbuff+xstepfont,yt, cbuff, StrLen(cbuff));
  end;
  buffer:='';
  xbuff:=x;
end;

begin
  buffer:='';
  xbuff:=0;
  caricax:=false;
  line:=0;
  prima:=true;
  posy:=0;
  cont:=dc;

  setta_espanso(dc);
  setta_compresso(dc);
  espanso(dc);
  hgv:=157*fi;
  hgs:=round(ms(1200));
  video:=false;
  if video then h_win:=hgv else h_win:=hgs;
  ystepfont:=altpag div 66;
  with documento^[page] do
  begin
    FirstOnPage :=Pagina-nrighe;
    LastOnPage :=Pagina;
  end;
  if video then ll:=2 else ll:=round(ms(8));
  ll2:=ll div 2;
  ag:=0;
  d_cor:=0;
  {$ifdef free}
   st1a:=format(punmainwin^.citta,25);
   stprint:=format(punmainwin^.ditta,25);
   stprint:=stprint+' '+st1a;
   strpcopy(thetextpr,stprint);
   textout(dc,1,1,thetextpr,strlen(thetextpr));
   posy:=posy+2*ystepfont;
  {$endif}
  for i:=1 to 255 do thetext[i]:=' ';
  for Line := FirstOnPage to LastOnPage do
  begin
    stprint:='';
    Y:=(line-firstonpage)*ystepfont;
    YT:=((line-firstonpage)*ystepfont)+posy;
    TheTextP := pchar(filelines^.At(Line));
    if TheTextP <> nil then
    begin
      thetext:=strpas(ThetextP);
      st1a:=copy(thetext,1,15);
      if st1a = GrafStr then
      begin
        st1a:=(copy(thetext,16,length(thetext)));
        delete(thetext,1,80);
        Temp:=h_win;
        Temp:=Temp*1000/750;
        w_win:=Round(temp);
        Xsp:=round(W_win*Rap_alt);
        Ysp:=round(H_win*Rap_alt);
        inx:=xsp/1000;
        iny:=ysp/750;
        grafico(st1a);
      end
      else
      begin
      x:=0;
      i:=0;
      xt:=0;
      xinit:=0;
      repeat
        L:=xstepfont;
        H:=ystepfont;
        l2:=l DIV 2;
        h2:=h DIV 2;
        i:=i+1;
        case thetext[i] of
        #15:begin
              sc_bf;
              thetext[i]:=' ';
              ag:=round(altezzatesto*0.5);
              compresso(dc);
            end;
        #18:begin
              sc_bf;
              thetext[i]:=' ';;
              espanso(dc);
              ag:=0;
            end;
        #12:begin
              sc_bf;
              thetext[i]:=' ';;
            end;
        #14:begin
              sc_bf;
              thetext[i]:=' ';
              neretto(dc);
            end;
       #179:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2;
                x2:=x+l2;
                y1:=(y)+posy;
                y2:=(y)+h+ag+posy;
                xinit:=x1+xstepfont;
                caricax:=not caricax;
                prima:=true;
              end;
              end;
        #186:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2-ll2;
                x2:=x1;
                y1:=(y)+posy;
                y2:=y1+h+ag;
                xinit:=x1+xstepfont;
                caricax:=not caricax;
                prima:=true;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2+ll2;
                x2:=x1;
                y1:=(y)+posy;
                y2:=y1+h +ag;
              end;
              end;
        #196:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x;
                x2:=x+L;
                y1:=(y)+h2+posy;
                y2:=y1;
              end;
              end;
         #205:begin
                sc_bf;
                thetext[i]:=' ';
                d_cor:=d_cor+1;
                with disprn^[d_cor] do
                begin
                  x1:=x;
                  x2:=x+L;
                  y1:=(y)+h2-ll2+posy;
                  y2:=y1;
                end;
                d_cor:=d_cor+1;
                with disprn^[d_cor] do
                begin
                  x1:=x;
                  x2:=x+L;
                  y1:=(y)+ll2+h2+posy;
                  y2:=y1;
                end;
              end;

         #197:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x;
                x2:=x+L;
                y1:=(y)+h2+posy;
                y2:=y1;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2;
                x2:=x+l2;
                y1:=(y)+posy;
                y2:=y1+h+ag;
              end;
              end;

       #206:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x;
                x2:=x+L;
                y1:=(y)+posy;
                y2:=(y)+posy;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x-l2;
                x2:=x-l2;
                y1:=(y)-h2-ag+posy;
                y2:=(y)+h2+ag+posy;
              end;

              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x;
                x2:=x+L;
                y1:=(y)+ll+posy;
                y2:=(y)+ll+posy;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+ll;
                x2:=x+ll;
                y1:=(y)-(h div 2)-ag+posy;
                y2:=(y)+(h div 2)+ag+posy;
              end;
              end;
       #218:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2;
                x2:=x+L;
                y1:=(y)+h2+posy;
                y2:=y1;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2;
                x2:=x1;
                y1:=(y)+h2+posy;
                y2:=y1+(h div 2)+ag;
              end;
            end;

        #201:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2-ll2;
                x2:=x+L;
                y1:=(y)+h2-ll2+posy;
                y2:=y1;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2-ll2;
                x2:=x1;
                y1:=(y)+h2-ll2+posy;
                y2:=y1+h2+ag+round(ll);
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2+ll2;
                x2:=x+L;
                y1:=(y)+h2+ll2+posy;
                y2:=y1;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2+ll2;
                x2:=x1;
                y1:=(y)+h2+ll2+posy;
                y2:=y1+h2+ag+round(ll);
              end;

            end;
       #191:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x;
                x2:=x+L2;
                y1:=(y)+h2+posy;
                y2:=y1;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+L2;
                x2:=x1;
                y1:=(y)+h2+posy;
                y2:=(y)+h+ag+posy;
              end;
            end;
       #187:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x-l2-ll2;
                x2:=x+L2+ll2;
                y1:=(y)+h2-ll2+posy;
                y2:=y1;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2+ll2;
                x2:=x1;
                y1:=(y)+h2-ll2+posy;
                y2:=(y)+h+ll2+ag+posy;
              end;

              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x-l2-ll2;
                x2:=x+l2-ll2;
                y1:=(y)+h2+ll2+posy;
                y2:=y1;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2-ll2;
                x2:=x1;
                y1:=(y)+h2+ll2+posy;
                y2:=(y)+h+ag+ll2+posy;
              end;

            end;
       #217:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x;
                x2:=x+L2;
                y1:=(y)+h2+posy;
                y2:=y1;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+L2;
                x2:=x1;
                y1:=(y)+h2+posy;
                y2:=(y)-h2-ag+posy;
              end;
            end;
       #188:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x-l2;
                x2:=x+L2-ll2;
                y1:=(y)+h2-ll2+posy;
                y2:=y1;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2-ll2;
                x2:=x1;
                y1:=(y)+h2-ll2+posy;
                y2:=y1-h2-ll2;
              end;

              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x-l2;
                x2:=x+L2+ll2;
                y1:=(y)+ll2+h2+posy;
                y2:=y1;
              end;

              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2+ll2;
                x2:=x1;
                y1:=(y)+h2+ll2+posy;
                y2:=y1-h-ll2;
              end;
            end;
       #192:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2;
                x2:=x+L;
                y1:=(y)+h2+posy;
                y2:=y1;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2;
                x2:=x1;
                y1:=(y)+h2+posy;
                y2:=(y)-h2-ag+posy;
              end;
            end;

       #200:begin
              sc_bf;
              thetext[i]:=' ';

              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2-ll2;
                x2:=x+l+ll2;
                y1:=(y)+h2+ll2+posy;
                y2:=y1;
              end;



              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2-ll2;
                x2:=x1;
                y1:=(y)+h2+ll2+posy;
                y2:=(y)-h2-ll2+posy;
              end;



              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2+ll2;
                x2:=x+L;
                y1:=(y)+h2-ll2+posy;
                y2:=y1;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2+ll2;
                x2:=x1;
                y1:=(y)+h2-ll2+posy;
                y2:=(y)-h2-ll2+posy;
              end;

            end;
       #194:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x;
                x2:=x+L;
                y1:=(y)+h2+posy;
                y2:=y1;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2;
                x2:=x+l2;
                y1:=(y)+h2+posy;
                y2:=(y)+H+ag+posy;
              end;
            end;
        #209:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x;
                x2:=x+L;
                y1:=((Line - FirstOnPage) * Altezzatesto)-ll2+h2+posy;
                y2:=y1;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x;
                x2:=x+L;
                y1:=(y)+ll2+h2+posy;
                y2:=y1;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+L2;
                x2:=x+L2;
                y1:=(y)+ll2+h2+posy;
                y2:=(y)+H+ag;
              end;
            end;
       #180:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2;
                x2:=x+l2;
                y1:=(y)+posy;
                y2:=(y)+h+ag+posy;
                prima:=true;
                xinit:=x1+xstepfont;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2;
                x2:=x-l2;
                y1:=(y)+h2+posy;
                y2:=y1;
              end;
              end;
        #182:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2-ll2;
                x2:=x1;
                y1:=(y)+posy;
                y2:=y1+h+ag;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2+ll2;
                x2:=x1;
                y1:=(y)+posy;
                y2:=y1+h +ag;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2-ll2;
                x2:=x-l2;
                y1:=(y)+h2+posy;
                y2:=y1;
              end;
             end;
        #195:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2;
                x2:=x1;
                y1:=(y)+posy;
                y2:=(y)+h+ag+posy;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2;
                x2:=x+L;
                y1:=(y)+h2+posy;
                y2:=y1;
              end;
              end;
        #199:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2-ll2;
                x2:=x1;
                y1:=(y)+posy;
                y2:=y1+h+ag;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2+ll2;
                x2:=x1;
                y1:=(y)+posy;
                y2:=y1+h +ag;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2+ll2;
                x2:=x+l;
                y1:=(y)+h2+posy;
                y2:=y1;
              end;
             end;

        #193:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x;
                x2:=x+l;
                y1:=(y)+h2+posy;
                y2:=y1;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin

                x1:=x+l2;
                x2:=x1;
                y1:=(y)+h2+posy;
                y2:=y1-h2-ag;

              end;
            end;
       #207:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x;
                x2:=x+L;
                y1:=(y)+h2-ll2+posy;
                y2:=y1;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x;
                x2:=x+L;
                y1:=(y)+ll2+h2+posy;
                y2:=y1;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2;
                x2:=x1;
                y1:=(y)-ll2+h2+posy;
                y2:=y1-h2;
              end;
            end;
       #204:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2-ll2;
                x2:=x1;
                y1:=(y)+posy;
                y2:=y1+h+ag;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2+ll2;
                x2:=x+L;
                y1:=(y)+h2-ll2+posy;
                y2:=y1;
              end;
              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2+ll2;
                x2:=x1;
                y1:=(y)+h2-ll2+posy;
                y2:=(y)-h2-ll2+posy;
              end;

              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2+ll2;
                x2:=x+L;
                y1:=(y)+h2+ll2+posy;
                y2:=y1;
              end;

              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2+ll2;
                x2:=x1;
                y1:=(y)+h2+ll2+posy;
                y2:=y1+h2+ag+round(ll);
              end;
            end;
      #185:begin
              sc_bf;
              thetext[i]:=' ';
              d_cor:=d_cor+1;

              with disprn^[d_cor] do
              begin
                x1:=x+l2+ll2;
                x2:=x1;
                y1:=(y)+posy;
                y2:=y1+h +ag;

              end;


              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x-l2-ll2;
                x2:=x+l2-ll2;

                y1:=(y)+h2-ll2+posy;
                y2:=y1;
              end;


              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2-ll2;
                x2:=x1;
                y1:=(y)-ll2-h2+posy;
                y2:=y+h2-ll2;
              end;


              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x-l2-ll2;
                x2:=x+l2-ll2;
                y1:=(y)+h2+ll2+posy;
                y2:=y1;
              end;

              d_cor:=d_cor+1;
              with disprn^[d_cor] do
              begin
                x1:=x+l2-ll2;
                x2:=x1;
                y1:=(y)+h2+ll2+posy;
                y2:=(y)+h+ag+ll2+posy;
              end;

            end;



        #27:begin
              sc_bf;
              i:=i+1;
              case thetext[i] of
               'E':begin
                    neretto(dc);

                   end;
               'F':begin

                    bianchetto(dc);
                   end
               else thetext[i]:=' ';
              end;
            end;
          else
          begin
          if thetext[i]= #254 then thetext[i]:=#249;
          buffer:=buffer+thetext[i];
          end;
        end;
        {
        if  thetext[i]<>' '   then
        begin
          strpcopy(thetextc,thetext[i]);
          oemtoansi(thetextc,thetextc);
          if i<= length(thetext) then TextOut(DC, x,yt, TheTextc, StrLen(TheTextc));
        end;}
        x:=x+xstepfont;
      until (i >= length(thetext));
      x:=0;
      sc_bf;
      end;
    end;
  end;
  for i:=1 to d_cor do
  with disprn^[i] do
  begin
    moveto(dc,x1,y1);
    lineto(dc,x2,y2);
  end;
end;

procedure tmysetupdlg.cancel(var msg:owindows.tmessage);
begin
  tprintersetupdlg.cancel(msg);
  annulla:=true;
end;
procedure tmyprdlg.setstamp(var msg:tmessage);
begin
  printer^.setup(@self);
end;

procedure tmyprdlg.TransferData(Direction: Word);
begin
  inherited transferdata(direction);
end;

function tmyprint.InitPrintDialog(Parent: PWindowsObject; PrnDC: HDC; Pages: Integer;  SelAllowed: Boolean; var
Data: TPrintDialogRec): PDialog;
begin
   InitPrintDialog:=new(pmyprdlg,init(Parent,'PRINTDIALOGB',PrnDC,Pages,printout^.stampante, SelAllowed ,Data))
end;

function tmyprint.InitAbortDialog(Parent: PWindowsObject; Title: PChar):PDialog;
var pd:pabrdlg;
begin
  if config^.stampe='*' then
  pd:=new(pabrdlg,init(parent,'ABORTDIALOGB',printout^.title,printout^.stampante^.device,
  printout^.stampante^.port))
  else
  pd:=new(pabrdlg,init(parent,'ABORTDIALOGC',printout^.title,printout^.stampante^.device,
  printout^.stampante^.port));
  InitAbortDialog:=pd;
  abdl:=pd;
end;

function tmyprint.InitSetupDialog(Parent: PWindowsObject): PDialog;
begin
  initsetupdialog:=new(pmysetupdlg,init(parent,'PRINTERSETUPB',printout^.stampante));
end;

constructor TTextPrint.Init;
var i:integer;
begin
  inherited Init('');
end;

function TTextPrint.GetDialogInfo(var Pages: Integer): Boolean;
begin
  Pages := 0;
  GetDialogInfo :=false;
end;

function TTextPrint.HasNextPage(Page: Word): Boolean;
var msg:tmsg;
    s1,s2:string;
    ps:string[79];
    pc:array[0..79] of char;
begin
  IF config^.stampe<>'*' then
  HasNextPage :=  false
  else
  begin
  if stampante^.abdl^.mc^.getcheck=bf_checked then
  HasNextPage :=false
  else
  begin
  HasNextPage :=page<numeropag+1;
  str(numeropag,s1);
  str(page-1,s2);
  ps:=W_MW(129){'In stampa pagina '}+s2+' '+w_mw(130)+' '{' di '}+s1;
  strpcopy(pc,ps);
  stampante^.abdl^.mt^.settext(pc);
  end;
  end
end;

procedure TTextPrint.SetPrintParams(ADC: HDC; ASize: TPoint);
begin
  inherited SetPrintParams(ADC, ASize);
end;

procedure Tabrdlg.wmcommand(var Msg: owindows.TMessage);
begin
  inherited wmcommand(msg);
end;

constructor Tabrdlg.Init(AParent: PWindowsObject; Template, Title, Device,Port: PChar);
begin
  TPrinterAbortDlg.init(aparent,template,title,device,port);
  new(mc,initresource(@self,106));
  new(mt,initresource(@self,107,80));
end;


procedure TTextPrint.PrintPage(Page: Word; var Rect: TRect; Flags: Word);
var t:real;
begin
  IF config^.stampe<>'*' then
  repaint(dc,paginacor)
  else
  repaint(dc,page)
end;


procedure eseguistampa;
var s79:string[79];
    drv:string;
    p79:array[0..79] of char;
    np:pchar;
    st:string[3];
    fVIDEO:file of videotipo;
    ft:text;
    s1:string;
begin
  new(mainfontrec);
  new(config);
  assign(ft,'drive1.int');
  reset(ft);
  read(ft,drv);
  close(ft);
  assign(fvideo,drv+'\video.cfg');
  reset(fvideo);
  read(fvideo,config^);
  close(fvideo);
  annulla:=false;
  Printout := New(PTextPrint,Init);
  printout^.stampante := New(Pmyprint, Init);
  printout^.stampante^.setup(pmainwin);
  if not annulla then
  begin
    init;
    IF config^.stampe<>'*' then
    begin
      for paginacor:=1 to numeropag do
      begin
        str(paginacor,st);
        s79:='Pagina:'+st;
        np:=@p79;
        strpcopy(np,s79);
        printout^.title:=np;
        printout^.stampante^.Print(pmainwin,Printout)
      end
    end
    else
    begin
      s79:='stampe.lst';
      np:=@p79;
      strpcopy(np,s79);
      printout^.title:=np;
      printout^.stampante^.Print(pmainwin,Printout)
    end;
    dispose(documento);
    dispose(disprn);
  end;
  dispose(mainfontrec);
  dispose(config);
end;
end.
