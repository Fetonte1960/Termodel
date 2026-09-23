unit Messwin;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  Tdomy = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    isok:boolean;
    { Public declarations }
  end;

var
  domy: Tdomy;
function inv_mes(nomefile,header,primariga:string):boolean;export;
implementation

{$R *.DFM}

procedure Tdomy.FormCreate(Sender: TObject);
var i:integer;
begin
   CAPTION:='Attenzione';
end;

procedure Tdomy.BitBtn1Click(Sender: TObject);
begin
  isok:=true;
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


function inv_mes(nomefile,header,primariga:string):boolean;
Var h,l,w,a,i:integer;
    cnt:integer;
    buft:string;
    ft:text;
    trovato:boolean;
    nomef,inizio,priga:string;
    hc:integer;
    nomehc:string;
begin
  if domy=nil then application.createform(tdomy,domy);
  domy.memo1.clear;
  nomef:=(nomefile);
  inizio:=(header);
  priga:=(primariga);
  domy.caption:=oem_ans(priga);
  if (Nomef<>'') and fileexists(nomef) then
  begin
    domy.memo1.clear;
    assign(ft,Nomef);
    reset(ft);
    inizio:=uppercase(inizio);
    buft:='';
    trovato:=false;
    cnt:=0;
    while NOT trovato and not eof(ft) do
    begin
      readln(ft,buft);
      trovato:=uppercase(buft)=inizio;
      inc(cnt)
    end;
    if trovato then
    begin
      trovato:=false;
      readln(ft,buft);
      inc(cnt);
      if buft>'' then
      begin
        i:=1;
        nomehc:='';
        while (i<length(buft)) and (buft[i]<>',') do
        begin
          nomehc:=nomehc+buft[i];
          inc(i);
        end;
        application.helpfile:=nomehc;
        if buft[i]=',' then inc(i);
        nomehc:=copy(buft,i,length(buft)-i+1);
        val(nomehc,hc,i);
        if i=0 then domy.helpcontext:=hc;
      end
      else domy.bitbtn2.hide;
      {domy.memo1.lines.add(oem_ans(priga));}
      CNT:=2;
      L:=LENGTH(PRIGA);
      while not trovato and not eof(ft) do
      begin
        readln(ft,buft);
        trovato:=uppercase(buft)='ENDMES';
        if not trovato then
        begin
          cnt:=cnt+1;
          domy.memo1.lines.add(oem_ans(buft));
          if length(buft)>l then l:=length(buft);
        end;
      end;
      close(ft);
      if trovato then
      begin
        h:=cnt;
        a:=h*14+42;
        if a>190 then
        BEGIN
          a:=190;
          domy.memo1.scrollbars:=ssVertical;
        end
        else domy.memo1.scrollbars:=ssnone;
        w:=ROUND(L*7.5);
        if w>400 then w:=400;
        if w<190 then w:=190;
        domy.Clientheight:=a;
        domy.clientwidth:=w;
        result:=domy.isok;
      end
      else
      begin
        domy.bitbtn2.hide;
        domy.memo1.lines.add('"ENDMES" Non trovato');
      end;
    end
    else
    begin
      domy.bitbtn2.hide;
      domy.memo1.lines.add(oem_ans(inizio)+' Non trovato');
    end;
  end
  else
  begin
    domy.bitbtn2.hide;
    domy.memo1.lines.add(oem_ans(nomef));
  end;
  domy.showmodal;
end;

end.
