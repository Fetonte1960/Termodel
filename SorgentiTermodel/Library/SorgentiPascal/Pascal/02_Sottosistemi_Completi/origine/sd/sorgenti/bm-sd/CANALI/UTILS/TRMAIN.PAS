unit Main;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, FileCtrl,uldati10;

type
  TMainForm = class(TForm)
    DriveComboBox1: TDriveComboBox;
    DORG: TDirectoryListBox;
    FileListBox1: TFileListBox;
    ddest: TDirectoryListBox;
    DriveComboBox2: TDriveComboBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    Button1: TButton;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

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





type rettangolo=array[1..4] of integer;
var rec:rettangolo;
    rigares:string;
    Lungriga:integer;
    fpas,fprpas,fprdfm,fdfm,frc:textfile;
    nome:string[10];
    nlabel,nedit,npsbut,nbevel,ncombo,ncheck:integer;
    order:integer;

Procedure cercaPar(var Parola:string);
var  pos:integer;
begin
Pos:=1;
while (pos<lungriga)and(rigares[pos]In [' ',#9]) do Pos:=Pos+1;
Parola:='';
while (pos<lungriga)and(not(rigares[pos] in[' ','"'])) do
  begin
  Parola:=Parola+rigares[pos];
  pos:=Pos+1;
  end;
end;



Function Trovatext(testo:string):boolean;
Var pos:integer;
    trovato:boolean;
begin
lungriga:=length(rigares);
trovato:=false;
pos:=1;
repeat
  while(pos<LungRiga)and(rigares[pos]<>testo[1]) do pos:=pos+1;
  If rigares[pos]=testo[1] then
    begin
    if (testo=copy(rigares,pos,length(testo))) then trovato:=true
    else pos:=pos+1;
    end
  else pos:=pos+1;
until trovato or (pos>=lungriga);
Trovatext:=trovato;
end;

function Estrai:string;
Var POs:integer;
begin
lungriga:=length(rigares);
Pos:=1;
while (pos<lungriga)and(rigares[pos]<>'"') do Pos:=Pos+1;
result:='';
Pos:=POs+1;
while (pos<lungriga)and(rigares[pos] <>'"') do
  begin
  result:=result+rigares[pos];
  pos:=Pos+1;
  end;
end;



procedure ltwh;
var v,i,k,j,l:integer;
    s1,s2:string[5];
    s:string;
    trovato,trovult:boolean;
begin
  s:=rigares;
  i:=length(s);
  k:=5;
  repeat
    trovato:=false;
    s1:='';
    repeat
      trovato:=(s[i]in[',','A'..'Z']);
      if not trovato then s1:=s1+s[i] else
      begin
        dec(k);
        s1:=setleft(setright(s1));
        s2:='';
        l:=0;
        for j:=length(s1) downto 1 do s2:=s2+s1[j];
        val(s2,rec[k],v);
        if k mod 2 = 0 then rec[k]:=round(rec[k]*1.6666) else rec[k]:=round(rec[k]*1.75);
      end;
      dec(i);
    until trovato;
  until k=1;
end;


procedure sltwh;
begin
  LTWH;
  writeln(fdfm,'  Left = ',rec[1]);
  writeln(fdfm,'  Top = ',rec[2]);
  writeln(fdfm,'  Width = ',rec[3]);
  writeln(fdfm,'  Height = ',rec[4]);
end;

procedure scrivilabel;
var s,s1,s2,s3,s4:string;
    i,j:integer;
begin
  inc(nlabel);
  writeln(fpas,'    Label',nlabel,':Tlabel;');
  writeln(fdfm,'Object Label',nlabel,':Tlabel');
  sltwh;
  s:='  Caption = ''';
  s1:=estrai;
  i:=1;
  while (s1[i]<>'\') and (i<=length(s1)) do inc(i);
  if i<length(s1) then
  begin
    s3:=copy(s1,1,i-1);
    s2:='';
    inc(i);
    while (s1[i] in ['0'..'9']) and (i<=length(s1)) do
    begin
      s2:=s2+s1[i];
      inc(i);
    end;
    if i<length(s1) then s4:=copy(s1,i,length(s1)) else s4:='';
    if s2>'' then val(s2,j,i);
    case j of
    260:s1:=s3+'°'+s4;
    262:s1:=s3+'²'+s4;
    end;
  end;

  writeln(fdfm,s+s1+'''');
  writeln(fdfm,'  end');
end;

function cercaord:integer;
var i,j:integer;
    s:string[4];
begin
  i:=1;
  lungriga:=length(rigares);
  while (rigares[i]<>',') and (i<lungriga) do inc(i);
  j:=i+1;
  while (rigares[j]<>',') and (j<lungriga) do inc(j);
  s:=setleft(setright(copy(rigares,i+1,j-i-1)));
  val(s,i,j);
  result:=i-101;
end;

procedure scrivipsbut;
var s:string;
begin
  inc(npsbut);
  writeln(fpas,'    Button',npsbut,':Tbutton;');
  writeln(fdfm,'Object Button',npsbut,':Tbutton');
  sltwh;
  s:='  Caption = ''';
  writeln(fdfm,s+estrai+'''');
  writeln(fdfm,'  end');
end;


procedure scriviedit;
begin
  inc(nedit);
  writeln(fpas,'    Edit',nedit,':Tedit;');
  writeln(fdfm,'Object Edit',nedit,':Tedit');
  sltwh;
  if trovatext('NOT WS_VISIBLE') then
  writeln(fdfm,'Visible = false');
  writeln(fdfm,'Taborder = ',cercaord);
  writeln(fdfm,'  end');
end;


procedure scrivicombo;
begin
  inc(ncombo);
  writeln(fpas,'    Combobox',ncombo,':TComboBox;');
  writeln(fdfm,'Object ComboBox',ncombo,':TComboBox');
  sltwh;
  if trovatext('CBS_DROPDOWNLIST') then
  writeln(fdfm,'Style = csDropDownList')
  else
  writeln(fdfm,'Style = csDropDown');
  writeln(fdfm,'Taborder = ',cercaord);
  writeln(fdfm,'  end');
end;

procedure scrivicheck;
var s:string;
begin
  inc(ncheck);
  writeln(fpas,'    CheckBox',ncheck,':TCheckBox;');
  writeln(fdfm,'Object CheckBox',ncheck,':TCheckBox');
  sltwh;
  {if trovatext('CBS_DROPDOWNLIST') then
  writeln(fdfm,'Style = csDropDownList')
  else
  writeln(fdfm,'Style = csDropDown');}
  s:='  Caption = ''';
  writeln(fdfm,s+estrai+'''');
  writeln(fdfm,'Taborder = ',cercaord);
  writeln(fdfm,'  end');
end;




procedure scriviborbut;
procedure wbut(tipo:integer);
var nomebp,nomebd,kind,cap:string[50];

begin
  case tipo of
  1:begin
      nomebp:='    Okbtn:TbitBtn;';
      nomebd:='Object Okbtn:TbitBtn';
      kind:='Kind = bkOk';
      cap:='Caption = ''Ok''';
    end;
  2:begin
      nomebp:='    Cancelbtn:TbitBtn;';
      nomebd:='Object Cancelbtn:TbitBtn';
      kind:='Kind = bkCancel';
      cap:='Caption=''Annulla''';
    end;
  3:begin
      nomebp:='    Hlepbtn:TbitBtn;';
      nomebd:='Object Hlepbtn:TbitBtn';
      kind:='Kind = bkHelp';
      cap:='Caption = ''Help''';
    end;
  end;
  writeln(fpas,nomebp);
  writeln(fdfm,nomebd);
  writeln(fdfm,kind);
  writeln(fdfm,cap);
  ltwh;
  writeln(fdfm,'  Left = ',rec[1]);
  writeln(fdfm,'  Top = ',rec[2]);
  writeln(fdfm,'  Width = ',70);
  writeln(fdfm,'  Height = ',25);
  writeln(fdfm,'  end');
end;
begin
  if trovatext('1, "BorBtn"') then wbut(1);
  if trovatext('2, "BorBtn"') then wbut(2);
  if trovatext('998, "BorBtn"') then wbut(3);
end;


procedure scrivibvel;
procedure wbvel(tipo:integer);
var nomebp,nomebd,kind,cap:string[50];

begin
  inc(nbevel);
  writeln(fpas,'    Bevel',nbevel,':Tbevel;');
  writeln(fdfm,'Object Bevel',nbevel,':Tbevel');
  cap:='Style = bsLowered';
  case tipo of
  1:begin
      kind:='Shape = bsBox';
    end;
  2:begin
      kind:='Shape = bsLeftline';
    end;
  3:begin
      kind:='Shape = bsTopline';
    end;
  end;
  writeln(fdfm,kind);
  writeln(fdfm,cap);
  sltwh;
  writeln(fdfm,'  end');
end;
begin
  if trovatext('"BorShade", 32769') then wbvel(1);
  if trovatext('"BorShade", 2') then wbvel(3);
  if trovatext('"BorShade", 3') then wbvel(2);
end;





procedure scrivitesta;
var
    s:string;
    i:integer;
begin

  nome:='';
  i:=1;
  repeat
    if rigares[i]<>' ' then nome:=nome+rigares[i];
    inc(i);
  until rigares[i]=' ';
{-----------------  file pas ---------------}
  assignfile(fpas,mainform.ddest.directory+'\U'+nome+'.pas');
  rewrite(fpas);
  writeln(fpas,'unit U'+nome+';');
  writeln(fpas);
  writeln(fpas);
  assignfile(fprpas,'f:\sorgenti\lavoro\utils\prototip.pas');
  reset(fprpas);
  readln(fprpas,s);
  while s<>'type' do
  begin
    writeln(fpas,s);
    readln(fprpas,s);
  end;
  writeln(fpas,s);
  writeln(fpas,'  T'+nome+' = class(Tform)');
{-----------------  file TXT per DFM ---------------}
  assignfile(fdfm,mainform.ddest.directory+'\U'+nome+'.txt');
  rewrite(fdfm);
  writeln(fdfm,'object '+nome+': T'+nome);
  ltwh;
  writeln(fdfm,'  Left = ',rec[1]);
  writeln(fdfm,'  Top = ',rec[2]);
  writeln(fdfm,'  Width = ',rec[3]);
  writeln(fdfm,'  Height = ',rec[4]);
  writeln(fdfm,'BorderStyle = bsDialog');
  readln(frc,rigares);
  readln(frc,rigares);
  readln(frc,rigares);
  lungriga:=length(rigares);
  s:='Caption = ''';
  writeln(fdfm,s+estrai+'''');
  writeln(fdfm,'Font.Color = clBlack');
  writeln(fdfm,'Font.Height = -11');
  writeln(fdfm,'Font.Name = ''MS Sans Serif''');
  {writeln('Font.Style = [fsBold]');}
  writeln(fdfm,'PixelsPerInch = 96');
  writeln(fdfm,'Position = poScreenCenter');
  writeln(fdfm,'TextHeight = 13');
end;

procedure scrivicoda;
var s:string;
begin
  readln(fprpas,s);
  while s<>'var' do
  begin
    writeln(fpas,s);
    readln(fprpas,s);
  end;
  writeln(fpas,s);
  writeln(fpas,nome+':T'+nome+';');
  while not eof(fprpas) do
  begin
    readln(fprpas,s);
    writeln(fpas,s);
  end;
  closefile(fpas);
  closefile(fprpas);
  writeln(fdfm,'end');
  closefile(fdfm);
end;

procedure TMainForm.BitBtn1Click(Sender: TObject);
var parola:string;
begin
  nlabel:=0;
  nedit:=0;
  npsbut:=0;
  nbevel:=0;
  ncombo:=0;
  ncheck:=0;
  assignfile(frc,DORG.DIRECTORY+'\'+edit1.text);
  reset(frc);
  readln(frc,rigares);
  scrivitesta;
  while not eof(frc) do
  begin
    readln(frc,rigares);
    cercapar(parola);
    if (parola='LTEXT') or (parola='RTEXT') or (parola='TEXT') then scrivilabel
    else
    if (parola='PUSHBUTTON') then scrivipsbut
    else
    if parolA='CONTROL' THEN
      if trovatext('LTEXT') or trovatext('RTEXT') or trovatext('STATIC') or trovatext('"BorStatic"') then scrivilabel
      ELSE
      if trovatext('EDIT') THEN SCRIVIEDIT
      else
      if trovatext('BorBtn') then scriviborbut
      else
      if trovatext('BorShade') then scrivibvel
      else
      if trovatext('"COMBOBOX"') then scrivicombo
      else
      if trovatext('"BUTTON"') then scrivipsbut
      else
      if trovatext('"BorCheck"') then scrivicheck;

  end;
  closefile(frc);
  scrivicoda;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  application.createform(tldati10,ldati10);
  ldati10.showmodal;
end;

end.
