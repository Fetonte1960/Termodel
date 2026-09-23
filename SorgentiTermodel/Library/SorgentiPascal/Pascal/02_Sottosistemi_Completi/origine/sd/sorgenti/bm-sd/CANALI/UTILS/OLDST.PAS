unit Mainst;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus,printers,igrigro,definiz;



type videotipo=record
                ch8514:string[1];
                chmess:string[1];
                STAMPE:STRING[1];
                drvprg:string[30];
                drvarc:string[30];
                drvcad:string[30];
                lincad:string[30];
           end;





const pghp=3367;
      hfinvis=700;
      lfinvis=1000;
      ndisprn=3000;
      htv =5;
      rap_alt=1000/750;

type eldoc=array [1..ndisprn] of record rigain,rigafin:integer end;

TYPE
  PTextExtent =^TTextExtent;
  TTextExtent = array[1..8000]  of record
                                  x1, y1,
                                  x2,y2  : Word;
  end;


type
  TMainForm = class(TForm)
    stdlg: TPrintDialog;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    box: TScrollBox;
    Box1: TPaintBox;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Box1Paint(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Box1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    private
      DisPrn:PTextExtent;
      ALTEZZA_ESPANSO:INTEGER;
      altezza_compresso:integer;
      step_compresso,step_espanso:integer;
      ANNULLA:boolean;
      paghp:longint;
      htcv:integer;
      xstepfont,ystepfont:integer;
      documento:^eldoc;
      fonthand   :hfont;
      Courfontrec,timefontrec:^tlogfont;
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
      d_cor     :integer;
      altezzafont,altfs,altfv:longint;
      Altezzatesto:integer;
      ll,llv,lls:integer;
      paginacor:integer;
      testo,video:boolean;
      punto:tpoint;
      rigav,rigas,riga:integer;
      config:^videotipo;
      posy,posys,posyv,firstonpage,lastonpage :integer;
      FileLines: tstringlist;
      numeropag:integer;
      heigtpag:integer;
      inx,iny:real;
      xsp,ysp,pagecor:integer;
      xpag,ypag:integer;
      fs:real;
      procedure setfont(dc:hdc;altezza:integer;fontrec:integer);
      procedure LoadFile;
      procedure Init(dc:hdc);
      procedure stampa(dc:hdc;page:integer);
      function  ms(n:real):real;
      procedure lnabs1(dc:hdc;orc0,orc1 :real);
      procedure movabs1(dc:hdc; orc0,orc1 :real);
      procedure stampatesto(dc:hdc;x,y:real;ts:string);
      function  xvid(x:real):real;
      function  yvid(y:real):real;
      procedure setta_compresso(dc:hdc);
      procedure SETTA_espanso(dc:hdc);
      procedure posbox1;
  end;

procedure faistampa;export;

implementation

{$R *.DFM}


procedure tmainform.posbox1;
begin
  box1.height:=round(ypag*fs)+50;
  Box1.width:=round(xpag*fs)+50;
  if (clientwidth-box1.width) div 2>5 then
  box1.left:=(clientwidth-box1.width) div 2
  else
  box1.left:=5;
end;



function tmainform.xvid(x:real):real;
begin

end;

function tmainform.yvid(y:real):real;
begin

end;


procedure tmainform.setfont(dc:hdc;altezza:integer;fontrec:integer);
begin
  if fontrec=1 then
  with courfontrec^ do
  begin
    lfHeight := -round(altezza*fs);
    deleteobject(selectobject(dc,createfontindirect(courfontrec^)));
  end
  else
  with timefontrec^ do
  begin
    lfHeight := -round(altezza*fs);
    deleteobject(selectobject(dc,createfontindirect(timefontrec^)));
  end;
end;


procedure TMainForm.movabs1(dc:hdc; orc0,orc1 :real);
var in1,in2:real;
    tmp:real;
begin
  begin
  {$R-}
  tmp:=orc0*inx;
  in1:=tmp;
  in2:=ysp-orc1*iny;
  {$R+}
  end;

  Moveto(dc,round(in1*fs),round(in2*fs));

end;



procedure TMainForm.lnabs1(dc:hdc;orc0,orc1 :real);
var real1,real2:real;
Begin
{$R-}
  real1:=(orc0*inx);
  real2:=ysp-orc1*iny;
  LineTo(dc,round(real1*fs),round(real2*fs));
{$R+}
end;


procedure TMainForm.stampatesto(dc:hdc;x,y:real;ts:string);
var int1,int2:integer;
    st_140:string[140];
    pc_140:array[0..140] of char;
begin
  int1:=round(x*inx);
  int2:=round(ysp-y*iny);
  st_140:='';
  st_140:=ts;
  strpcopy(pc_140,st_140);
  oemtoansi(pc_140,pc_140);
  textout(dc,round(int1*fs),round(int2*fs),pc_140,strlen(pc_140));
end;




procedure TMainForm.LoadFile;
var
  TextLine: string;
  TFile: Textfile;
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
  {if Assigned(FileLines) then FileLines.free;}
  FileLines := tstringlist.create;
  Assignfile(TFile, Nome);
  Reset(TFile);
  while not eof(TFile) do
  begin
    Readln(TFile, TextLine);
    FileLines.add(TextLine);
  end;
  CloseFile(TFile);
  d_cor:=0;
  testo:=true;
  line:=0;
  numeropag:=1;
  j:=0;
  col:=1;

  repeat

  with documento^[numeropag] do
  begin
    line:=line+1;
    TheText := filelines.strings[Line];
    if TheText <> '' then
    begin
      for i:=1 to length(thetext) do
      if (thetext[i]='') then
      begin
         if numeropag>1 then rigain:=documento^[numeropag-1].rigafin+1
         else
         rigain:=0;
         rigafin:=line;
         numeropag:=numeropag+1;
      end;
    end;
  end;
  until line>=filelines.count-1;
end;


procedure TMainForm.Init(dc:hdc);
var
    x,i,j:longint;
    k:integer;
    fine:boolean;
    TextMetrics: TTextMetric;
    thetext:string;
    r:trect;
    p:tpoint;
    lgpx,lgpy:longint;
    var s79:string[79];
    drv:string;
    p79:array[0..79] of char;
    np:pchar;
    st:string[3];
    fVIDEO:file of videotipo;
    ft:textfile;
    s1:string;

begin

  assignfile(ft,'drive1.int');
  reset(ft);
  read(ft,drv);
  closefile(ft);
  assignfile(fvideo,drv+'\video.cfg');
  reset(fvideo);
  read(fvideo,config^);
  closefile(fvideo);
  annulla:=false;
  altpag:=getdevicecaps(dc,vertres);
  largpag:=getdevicecaps(dc,Horzres);
  lgpx:=getdevicecaps(dc,logpixelsx);
  lgpy:=getdevicecaps(dc,logpixelsy);
  paghp:=3367;
  rigav:=round(hfinvis / 70);
  rigas:=round(altpag/66);
  altfs:=round(ms(48));
  fi:=2;
  altfv:=htv*fi;
  altezzafont:=altfs;
  {pagina:=1;}
  testo:=false;
  with courFontRec^ do
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
  with TimeFontRec^ do
  begin
    lfHeight        := 0;
    lfWidth         := 0;
    lfEscapement    := 0;
    lfOrientation   := 0;
    lfWeight        := fw_bold;
    lfItalic        := 0;
    lfUnderline     := 0;
    lfStrikeOut     := 0;
    lfCharSet       := 0;
    lfOutPrecision  := Out_Default_Precis;
    lfClipPrecision := Clip_Default_Precis;
    lfQuality       := default_Quality;
    lfPitchAndFamily:= Variable_Pitch or ff_roman;
    StrCopy(lfFaceName,'Times new roman');
  end;
  ll:=round(ms(8));
end;

procedure TMainForm.setta_compresso(dc:hdc);
var textmetrics:TTextMetric;
    altcompr,altcs,altcv:longint;
    stc:array[0..1] of char;
    sts:string[1];
    lp,lpt:integer;
 begin
   altcompr:=round(ms(80));
   repeat
   with courfontrec^ do
   begin
     lfHeight:=-altcompr;
   end;
   deleteobject(selectobject(dc,createfontindirect(courfontrec^)));
   sts:='B';
   strpcopy(stc,sts);
   xstepfont:=Loword(GetTextExtent(dc,stC,strlen(stc)));


   lp:=xstepfont*126;
   lpt:=largpag-xstepfont*5;

   altcompr:=altcompr-1;

   until (lp <=lpt) or (altcompr <= 8);
   {if video then altezza_compresso:=8 else }altezza_compresso:=altcompr+1;
   step_compresso:=xstepfont;
   if video then
   begin
     if altezza_compresso>8 then
     begin
       altezza_compresso:=8;
       xstepfont:=6;
       step_compresso:=xstepfont;
     end;
   end;

end;



procedure TMainForm.SETTA_espanso(dc:hdc);
var textmetrics:TTextMetric;
    stc:array[0..1] of char;
    sts:string[1];
    altcompr:longint;
    lp,lpt:integer;

 begin
   altcompr:=round(ms(120));
   repeat
   with courfontrec^ do
   begin
     lfHeight:=-altcompr;
   end;
   deleteobject(selectobject(dc,createfontindirect(courfontrec^)));
   sts:='B';
   strpcopy(stc,sts);
   xstepfont:=Loword(GetTextExtent(dc,stC,strlen(stc)));
   lp:=xstepfont*76;
   lpt:=largpag-xstepfont*5;
   altcompr:=altcompr-1;
   until (lp <=lpt) or (altcompr <=8 );
   altezza_espanso:=altcompr+1;
   step_espanso:=xstepfont;
   if video then
   begin
     if altezza_espanso>12 then
     begin
       altezza_espanso:=12;
       xstepfont:=12;
       step_espanso:=xstepfont;
     end;
   end;

end;




function TMainForm.ms(n:real):real;

begin
  ms:=n*ypag/paghp;
end;



procedure TMainForm.stampa(dc:hdc;page:integer);
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
  st1a:string;
  hgv,hgs,xinit,xtemp:integer;
  stampariga,caricax,prima:boolean;
  temp,h_win,w_win:real;
  buffer:string[140];

  xbuff,line:integer;






procedure neretto(dc:hdc);
 begin
   with courfontrec^ do
   lfWeight:=fw_black;
   deleteobject(selectobject(dc,createfontindirect(courfontrec^)));
 end;

procedure bianchetto(dc:hdc);
 begin
   deleteobject(fonthand);
   with courfontrec^ do
   lfWeight:=fw_medium;
   deleteobject(selectobject(dc,createfontindirect(courfontrec^)));
end;



procedure compresso(dc:hdc);
var stc:array[0..1] of char;
    sts:string[1];
begin
  with courfontrec^ do
  begin
    lfHeight:=-round(altezza_compresso*fs);
  end;
  deleteobject(selectobject(dc,createfontindirect(courfontrec^)));
  xstepfont:=step_compresso;
end;



PROCEDURE ESPANSO(dc:hdc);
var stc:array[0..1] of char;
    sts:string[1];
BEGIN
  with courfontrec^ do
   begin
     lfHeight:=-round(altezza_espanso*fs);
   end;
   deleteobject(selectobject(dc,createfontindirect(courfontrec^)));
   xstepfont:=step_espanso;
END;



procedure grafico(nome:string);

VAR
   int1,int2,int3,in1,in2,i:integer;
   real1,real2,tmp:real;
   pc1:array[0..80] of char;
   pc3:string[80];
   pc2:pchar;
   spy,spys,spyv:real;
   ft:textfile;
  begin

  {if video then setfont(dc,10,2)
  else}

  setfont(dc,round(ms(30)),2);
  posys:=yt+hgs+5*ystepfont;
  {posyv:=(2*(line-firstonpage))*ystepfontyt+hgv+5*ystepfont;
  {spys:=(rigas+((line+8)-firstonpage))*2;
  spyv:=rigav*25;
  {spys:=posys;
  spyv:=posyv;
  if video then
  begin
    spy:=yt+5*ystepfont;
    posy:=posyv;
    riga:=round(1.5*Hiword(GetTextExtent(dc,'B',strlen('B'))));
  end
  else
  begin       }
  spy:=yt+ystepfont;
  posy:=posys;

  {end;}

  new(disegno);
  esgrafico(false,nome);
  for i:=1 to ndisegno do
  begin
    if disegno^[i].entita>'' then
    case disegno^[i].entita[1] of
       'L':begin
             if disegno^[i].tlinea<>0 then
             deleteobject(selectobject(dc,createpen(ps_dot,1,0)))
             else
             deleteobject(selectobject(dc,createpen(ps_solid,1,0)));
             real2:=(disegno^[i].y1-spy);
             real1:=(disegno^[i].x1);
	     movabs1(dc,real1,real2);
             real2:=(disegno^[i].y2-spy);
             real1:=(disegno^[i].x2);
             lnabs1(dc,real1,real2);
             deleteobject(selectobject(dc,createpen(ps_solid,1,0)));
           end;
       'T':begin
             {setlinestyle(disegno^[i].tlinea,0,0);
             setcolor(0);
             settapenna;}
             real1:=disegno^[i].x1;
             real2:=disegno^[i].y1-spy+riga;;
             stampatesto(dc,real1,real2,disegno^[i].testo);
             {
             tmp:=real1*inx;
             in1:=round(tmp);
             in2:=round(ysp-real2*iny);
             pc3:=disegno^[i].testo;
             strpcopy(pc1,pc3);
             oemtoansi(pc1,pc1);
             {settatesto4(30);
             textout(dc,in1,in2,pc1,strlen(pc1));}
           end;
    end;
  end;
  espanso(dc);
  dispose(disegno);
end;

const GrafStr ='(grafico) file ';

procedure sc_bf;
var cbuff:array[0..140] of char;
begin
  if (buffer>'') then
  begin
    strpcopy(cbuff,buffer);
    oemtoansi(cbuff,cbuff);
    TextOut(DC, round((xbuff+xstepfont)*fs),round(yt*fs), cbuff, StrLen(cbuff));
  end;
  buffer:='';
  xbuff:=x;
  heigtpag:=yt;
end;

begin
  buffer:='';
  xbuff:=0;
  caricax:=false;
  line:=0;
  prima:=true;
  posy:=0;
  {cont:=dc;}
  espanso(dc);
  hgv:=300;
  hgs:=round(ms(900));
  if video then h_win:=hgv else h_win:=hgs;
  if video then ystepfont:=altezza_espanso else ystepfont:=altpag div 66;
  {if not video then}
  with documento^[page] do
  begin
    FirstOnPage :=rigain;
    LastOnPage :=rigafin;
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
    TheText := filelines.strings[Line];
    {if TheText <> '' then}
    begin
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
    moveto(dc,round(x1*fs),round(y1*fs));
    lineto(dc,round(x2*fs),round(y2*fs));
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  new(courfontrec);
  new(timefontrec);
  new(config);
  new(disprn);
  new(documento);
  video:=false;
  fillchar(documento^,sizeof(documento^),0);
  canvas.brush.style:=bsclear;
  box1.canvas.brush.style:=bsclear;
  {box.brush.color:=clwhite;}
  Loadfile;
  pagecor:=1;
  printer.begindoc;
  init(printer.canvas.handle);
  xpag:=printer.canvas.cliprect.right;
  ypag:=printer.canvas.cliprect.bottom;
  setta_espanso(printer.canvas.handle);
  setta_compresso(printer.canvas.handle);
  {setfont(printer.canvas.handle,30,2);
  riga:=round(0.5*Hiword(GetTextExtent(printer.canvas.handle,'B',strlen('B'))));}
  riga:=round(ms(22));
  if printer.printing then
  begin
  printer.abort;
  end;
  fs:=0.1;
  posbox1;
  {box1.cursor:=loadcursor(hinstance,'zoom');}
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
var i,j,k:integer;
begin
  printer.title:='Stampa di stampe.lst';
  stdlg.topage:=numeropag;
  if  stdlg.execute then
  begin
    video:=false;
    printer.begindoc;
    {init(printer.canvas.handle);}
    if stdlg.printrange=prpagenums then
    begin
      j:=stdlg.frompage;
      k:=stdlg.topage;
    end
    else
    begin
      j:=1;
      k:=numeropag;
    end;
    fs:=1;
    for i:=j to k do
    begin

      {printer.canvas.rectangle(round(printer.canvas.cliprect.left*fs),
                        round(printer.canvas.cliprect.top*fs),
                        round(printer.canvas.cliprect.right*fs),
                        round(printer.canvas.cliprect.bottom*fs));
      }
      stampa(printer.canvas.handle,i);
      printer.NewPage;
    end;
    fs:=0.1;
    posbox1;
    printer.enddoc;
    video:=false;
    box1.invalidate;
  end;
end;

procedure TMainForm.Box1Paint(Sender: TObject);
begin
  {init(box1.canvas.handle);
  stampa(box1.canvas.handle,pagecor);
  box.Vertscrollbar.range:=heigtpag;}
 { printer.begindoc;}
  {box1.canvas.rectangle(round(printer.canvas.cliprect.left*fs),
                        round(printer.canvas.cliprect.top*fs),
                        round(printer.canvas.cliprect.right*fs),
                        round(printer.canvas.cliprect.bottom*fs));
  }
{printer.enddoc;      }
video:=false;
box1.canvas.pen.color:=clwhite;
box1.canvas.rectangle(0,0,box1.width,box1.height);
box1.canvas.pen.color:=clblack;
stampa(box1.canvas.handle,pagecor);
box.Vertscrollbar.range:=box1.height+(box1.height div 30);
box.Horzscrollbar.range:=box1.width+(box1.width div 30);

end;

procedure faistampa;
var MainForm: TMainForm;
begin
  chdir('c:\mc4-l10\igro');
  Mainform := TMainform.Create(Application);
  try
    Mainform.ShowModal;
  finally
    Mainform.Free;
  end;

end;

procedure TMainForm.SpeedButton2Click(Sender: TObject);
begin
  if pagecor>1 then
  begin
    dec(pagecor);
    box1.invalidate;
  end;
end;

procedure TMainForm.SpeedButton3Click(Sender: TObject);
begin
  if pagecor<numeropag then
  begin
    inc(pagecor);
    box1.invalidate;
  end;
end;

procedure TMainForm.Box1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if button=mbLeft then
  begin
    if fs<1 then
    begin
      fs:=fs+0.1;
      posbox1;
      box1.invalidate;
    end;
  end
  else
  begin
    if fs>0.11 then
    begin
      fs:=fs-0.1;
      posbox1;
    end;
  end;

end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  posbox1;
end;

end.
