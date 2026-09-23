unit Duplicapiani;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,dbtables, StdCtrls, ExtCtrls,libreriagenerale,gestionedxf, Grids, DBGrids,udb,ucompilaform,udatalink;

type
  TFcopiaPIani = class(TForm)
    Panel1: TPanel;
    CBPOrig: TComboBox;
    RBVUOTO: TRadioButton;
    RBcopiaP: TRadioButton;
    Label1: TLabel;
    CBEDIFICIO: TCheckBox;
    CBTubi: TCheckBox;
    CBPDest: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    Button4: TButton;
    Button5: TButton;
    Button3: TButton;
    Button6: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RBcopiaPClick(Sender: TObject);
    procedure RBVUOTOClick(Sender: TObject);
    procedure CBPOrigChange(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FcopiaPIani: TFcopiaPIani;

Procedure copiaPiano;
Procedure copiaprototipo;
Procedure initcbpiano;
Function IndCodPiano(cod:string):string;

implementation

uses Cpi_Win_Clima_CadLT;
{$R *.dfm}

Function IndCodPiano(cod:string):string;
var tt:TTable;
    i:Integer;
begin
cod:=uppercase(cod);
result:='';
tt:=TTable.create(nil);
with tt do
  begin
  databasename:=percorso_progetti;
  tablename:='Piani';
  open;
  first;
  i:=1;
  while (not eof)and(uppercase(fieldbyname('Codice').Value)<>Cod) do
    begin
    inc(i);
    next;
    end;
  if uppercase(fieldbyname('Codice').Value)=Cod then
  result:='P'+fieldbyname('Indice').asstring;
  free;
  end;
end;

Procedure initcbpiano;
begin
if V_recconfcad.Pianocor='' then
  begin
  dm1.TT0.edit;
  V_recconfcad.Set_Pianocor('P1');
  dm1.TT0.Post;
  dm1.TT0.edit;
  end;
end;
Procedure copiaPiano;
begin
FCopiaPIani:=TFcopiaPiani.Create(nil);
//initudb(percorso_progetti);
dm1.TT2.TableName:='Piani';
dm1.TT2.Open;
Fcopiapiani.ShowModal;
end;
procedure TFcopiaPIani.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Disposeudb;
action:=cafree;
end;

procedure TFcopiaPIani.FormActivate(Sender: TObject);
Var i:integer;
begin
compilagriglia(dbgrid1,'PIANI',dm1.datasource2);
if rbvuoto.Checked then panel1.Visible:=false;
cbPorig.Items:=Fpannelloclima.CBPiano.Items;
cbPorig.Text:=Fpannelloclima.CBPiano.text;
for i:=1 to cbPorig.Items.Count do
if cbPorig.Items[i-1] <>cbPorig.Text then
cbpdest.Items.Add(cbPorig.Items[i-1]);
cbpdest.Text:=cbpdest.Items[0];
end;

Procedure Scrivilayer;
Var ff,fo,ff1:textfile;
    buf,bufprec:string;
    indpiano:integer;

procedure scrivipiano(nomep:string);
begin
writeln(fo,'  2');
writeln(fo,nomeP);
writeln(fo,' 70');
writeln(fo,'     0');
writeln(fo,' 62');
writeln(fo,'     7');
writeln(fo,'  6');
writeln(fo,'CONTINUOUS');
writeln(fo,'  0'); // serviranno per il layer successivo
writeln(fo,'LAYER');
end;
begin
assign(ff,percorsodrive+'\prototipo.dxf');
assign(ff1,percorsodrive+'\disegno.dxf');
assign(fo,percorsodrive+'\temp.dxf');

reset(ff);
reset(ff1);
rewrite(fo);
buf:='';
bufprec:='';
while (not(eof(ff1)))and((buf<>'LAYER')or(bufprec<>'  0')) do
  begin
  bufprec:=buf;
  readln(ff1,buf);
  end;
buf:='';
bufprec:='';
while (not(eof(ff)))and((buf<>'LAYER')or(bufprec<>'  0')) do
  begin
  bufprec:=buf;
  readln(ff,buf);
  writeln(fo,buf)
  end;
if not(eof(ff) )then
  begin
  with dm1.TT2 do
    begin
    open;
    first;
    while not eof do
      begin
      indpiano:=fieldbyname('Indice').asinteger;
      if indpiano>1 then
        begin
        scrivipiano('P'+inttostr(indpiano));
        scrivipiano('P'+inttostr(indpiano)+'_TUBI');
        scrivipiano('P'+inttostr(indpiano)+'_TUBISIMB');
        scrivipiano('P'+inttostr(indpiano)+'_TUBICOL');
        scrivipiano('P'+inttostr(indpiano)+'_RITORNO');
        scrivipiano('P'+inttostr(indpiano)+'_COLLE');
        scrivipiano('P'+inttostr(indpiano)+'_QUOTE');
        end;
      next;
      end;
    close;
    end;
  while (not(eof(ff))) do
    begin
    readln(ff,buf);
    writeln(fo,buf)
    end;
  end;
close(ff);
close(ff1);
close(fo);
copyfile(pchar(PercorsoDrive+'\temp.dxf'),pchar(PercorsoDrive+'\disegno.dxf'),false)
end;

Procedure copiaprototipo;
begin
copyfile(pchar(PercorsoDrive+'\Prototipo.dxf'),pchar(PercorsoDrive+'\disegno.dxf'),false);
Scrivilayer;
end;
procedure TFcopiaPIani.Button2Click(Sender: TObject);
begin
dm1.TT2.Edit;
dm1.TT2.POst;
scrivilayer;
close;
end;

Var ff,fo,fc:textfile;
    buf,buf1:string;

Procedure openbufcopia;
begin
assign(fc,percorsodrive+'\bufcopia.dxf');
rewrite(fc);
end;

Procedure Scaricabufcopia;
Var bufloc:string;
begin
close(fc);
reset(fc);
while not eof(fc) do
  begin
  readln(fc,bufloc);
  writeln(fo,bufloc);
  end;
close(fc);
rewrite(fc);
end;

Procedure chiudifile;
begin
close(fo);
close(fc);
close(ff);
end;

function cercapar(par1,par2:string;WR,WR1,Wrc,Wrc1:boolean):boolean;
begin
buf:='';buf1:='';
while not eof(ff)and((par1<>buf)or((par2<>'')and(par2<>buf1))) do
  begin
  readln(ff,Buf);
  readln(ff,Buf1);
  if (wr and ((par1<>buf)or((par2<>'')and(par2<>buf1))))or wr1 then
    begin
    writeln(fo,Buf);
    writeln(fo,Buf1);
    end;
  if (wrc and ((par1<>buf)or((par2<>'')and(par2<>buf1))))or wrc1 then
    begin
    writeln(fc,Buf);
    writeln(fc,Buf1);
    end;
  end;
result:=(par1=buf)and((par2='')or(par2=buf1));
if not result then
showmessage('errore nella lettura del dxf -'+par1+'-'+par2);
end;

function cercapar1(par1:string;WR,WR1,Wrc,Wrc1:boolean):boolean;
begin
buf:='';
while not eof(ff)and((par1<>buf)) do
  begin
  readln(ff,Buf);
  if (wr and (par1<>buf))or wr1 then
  writeln(fo,Buf);
  if (wrc and (par1<>buf))or wrc1 then
  writeln(fc,Buf);
  end;
result:=(par1=buf);
if not result then
showmessage('errore nella lettura del dxf -'+par1);
end;


function cercapar2(par1,par2:string;WR,WR1,Wrc,Wrc1:boolean):boolean;
begin
buf:='';
while not eof(ff)and(par1<>buf)and(par2<>buf) do
  begin
  readln(ff,Buf);
  readln(ff,Buf1);
  if (wr and (par1<>buf)and (par2<>buf))or wr1 then
    begin
    writeln(fo,Buf);
    writeln(fo,Buf1);
    end;
  if (wrc and (par1<>buf)and (par2<>buf))or wrc1 then
    begin
    writeln(fc,Buf);
    writeln(fc,Buf1);
    end;
  end;
result:=(par1=buf)or(par2=buf);
if not result then
showmessage('errore nella lettura del dxf -'+par1);
end;


Function esistonoallineamenti(p1,p2:string;Var xx1,yy1,xx2,yy2:real):boolean;
Var trov,al1,al2:boolean;
    ly:string;
    XX,YY:real;
begin
result:=false;
al1:=false;
al2:=false;
assign(ff,percorsodrive+'\disegno.dxf');
reset(ff);
if cercapar1('ENTITIES',false,false,false,false) then
  repeat
  trov:=cercapar('  0','INSERT',false,false,false,false);
  if trov then
    begin
    cercapar('  8','',false,false,false,false);
    ly:=buf1;
    cercapar('  2','',false,false,false,false);
    if uppercase(buf1)='ALLINEA' then
       begin
       cercapar(' 10','',false,false,false,false);
       xx:=str_tofloat(buf1);
       cercapar(' 20','',false,false,false,false);
       yy:=str_tofloat(buf1);
       if uppercase(ly)=uppercase(p1) then
         begin
         al1:=true;
         xx1:=xx;yy1:=yy;
         end
       else
       if uppercase(ly)=uppercase(p2) then
         begin
         al2:=true;
         xx2:=xx;yy2:=yy;
         end;
       end;
    end;
  until (not trov)or(al1 and al2);
result:=al1 and al2;
close(ff);
end;

Function IndPiano(layer:string):string;
Var pp:string;
begin
pp:='';
if pos('_',layer)<>0 then pp:=copy(layer,1,pos('_',layer)-1);
result:=pp;
end;

Function SUBPiano(layer:string):string;
begin
result:='';
if pos('_',layer)<>0 then result:=copy(layer,pos('_',layer)+1,length(layer)-pos('_',layer));
end;

Function PianoTubi(layer:string):boolean;
var subP:string;
begin
subp:=uppercase(subpiano(layer));
result:=(subp='TUBI')or(subp='TUBICOL')or(subp='TUBISIMB')or(subp='QUOTE');
end;

Procedure copiaPiani(pO,Pd:string;spx,spy:real;edificio,tubi:boolean);
var trov,trov1,trattrib,pdest,giacercato:boolean;
    ly,ent,ent1,nome:string;
    x1,y1,x2,y2:real;
    count:integer;

Procedure ScriviIncNum(Increm:real);
begin
buf1:=float_to_str(str_tofloat(buf1)+increm,16);
writeln(fc,buf);
writeln(fc,buf1);
end;

begin
count:=0;
assign(ff,percorsodrive+'\disegno.dxf');
reset(ff);
assign(fo,percorsodrive+'\temp.dxf');
rewrite(fo);
openbufcopia;
if cercapar1('ENTITIES',true,true,false,false) then
  begin
  cercapar('  0','',true,false,true,false);
  repeat
  close(fc);
  rewrite(fc);
  writeln(fo,buf);
  writeln(fo,buf1);
  writeln(fc,buf);
  writeln(fc,buf1);

  ent:=Buf1;
  cercapar('  5','',true,true,true,false);    //Gestore non lo duplico
  inc(count);
  writeln(fc,buf);
  writeln(fc,inttostr(count));


  cercapar('  8','',true,true,true,false);

  pdest:=(FcopiaPIani.cbedificio.checked and (buf1=pd))or
          (FcopiaPIani.cbtubi.checked and (buf1<>pd)and (indpiano(buf1)=pd)and(pianotubi(buf1)));

  if FcopiaPIani.cbedificio.checked and (buf1=po) then buf1:=pd;
  if FcopiaPIani.cbtubi.checked and (buf1<>po)and (indpiano(buf1)=po)and(pianotubi(buf1)) then
  buf1:=pd+'_'+subpiano(buf1);
  ly:=buf1;
  writeln(fc,buf);
  writeln(fc,buf1);

  if ent='INSERT' then
    begin
    cercapar('  2','',true,true,true,true);
    nome:=Uppercase(buf1);
    end
  else nome:='';

  if pdest and ( (nome<>'ALLINEA') or  (ent<>'INSERT') )then
    begin
    showmessage('Il piano destinazione contiene già degli oggetti , cancellarli prima di duplicare');
    chiudifile;
    exit;
    end;
  cercapar(' 10','',true,true,true,false);
  ScriviIncNum(spx);

  cercapar(' 20','',true,true,true,false);
  ScriviIncNum(spy);
  trattrib:=false;
  giacercato:=false;
  if ent='LINE' then
    begin
    cercapar(' 11','',true,true,true,false);
    ScriviIncNum(spx);

    cercapar(' 21','',true,true,true,false);
    ScriviIncNum(spy);

    end
  else
  if ent='INSERT' then
    repeat
    if not giacercato then cercapar('  0','',true,false,true,false);
    trov1:=(buf1='ATTRIB')or eof(ff);
    if trov1 then
      begin
      trattrib:=true;

      writeln(fo,buf);
      writeln(fo,buf1);
      writeln(fc,buf);
      writeln(fc,buf1);

      cercapar(' 10','',true,true,true,false);
      ScriviIncNum(spx);

      cercapar(' 20','',true,true,true,false);
      ScriviIncNum(spy);

      cercapar2(' 11','  0',true,false,true,false);
      if buf=' 11' then
        begin
        writeln(fo,buf);
        writeln(fo,buf1);
        giacercato:=false;
        ScriviIncNum(spx);
        cercapar(' 21','',true,true,true,false);
        ScriviIncNum(spy);
        end
      else giacercato:=true;
      end;
    until not trov1;
  if ent<>'INSERT' then
    begin
    cercapar('  0','',true,false,true,false);
    end
    else
    begin
    if trattrib then
      begin
      writeln(fc,buf);//seqend
      writeln(fc,buf1);
      writeln(fo,buf);
      writeln(fo,buf1);
      cercapar('  0','',true,false,true,false);
      end;
    end;
  if  (FcopiaPIani.cbedificio.checked and
      (uppercase(ly)=uppercase(pd))and
      ((ent<>'INSERT')or((nome<>'ALLINEA')and(nome<>'NORD'))))or
      (FcopiaPIani.cbtubi.checked and (ly<>pd)and (indpiano(ly)=pd)and(pianotubi(ly)))
       then
      begin
      scaricabufcopia;
      //if (ent='INSERT')and trattrib then
      //  begin
      //  close(fo);
      //  close(fc);
      //  exit;
      //  end;
      end
  else rewrite(fc);
  trov:=not((buf1='ENDSEC')or eof(ff));
  until  not trov;
  end;
writeln(fo,buf);
writeln(fo,buf1);
buf1:='EOF';
writeln(fo,buf);
writeln(fo,buf1);
close(fc);
close(ff);
close(fo);
copyfile(pchar(PercorsoDrive+'\temp.dxf'),pchar(PercorsoDrive+'\disegno.dxf'),false)
end;

procedure TFcopiaPIani.Button1Click(Sender: TObject);
Var xx1,yy1,xx2,yy2:real;
    indpiano,riga:integer;
begin
dm1.TT2.Edit;
dm1.TT2.post;
indpiano:=dm1.tt2.fieldbyname('Indice').asinteger;
if  indpiano<>0 then
  begin
  with dm1.TT2 do
    begin
    riga:=recno;
    first;
    while (not eof)and((fieldbyname('Indice').asinteger<>indpiano)or(recno=riga)) do next;
    end;
  if (dm1.TT2.fieldbyname('Indice').asinteger<>indpiano)or(dm1.TT2.recno=riga) then
    begin
    if RbVuoto.Checked then
      begin
      //incnumpiani;
      //aggiungilayer(2,indpiano);
      end
    else
      begin
      if esistonoallineamenti(CBPOrig.text,CbPdest.Text, xx1,yy1,xx2,yy2)then
      copiaPIani(CBPOrig.text,CbPdest.Text,xx2-xx1,yy2-yy1,cbedificio.checked,cbtubi.checked)
      else showmessage('Inserire gli oggetti di allineamento piante sul piano di origine e di destinazione');
      end;
    end
  else  showmessage('l''indice cad del piano è duplicato');
  end
else  showmessage('Inserire l''indice cad del piano');
end;

procedure TFcopiaPIani.RBcopiaPClick(Sender: TObject);
begin
rbvuoto.Checked:=not RBcopiaP.checked;
panel1.Visible:=not rbvuoto.Checked;
end;

procedure TFcopiaPIani.RBVUOTOClick(Sender: TObject);
begin
RBcopiaP.checked:=not rbvuoto.Checked;
panel1.Visible:=not rbvuoto.Checked;
end;

procedure TFcopiaPIani.CBPOrigChange(Sender: TObject);
Var i:integer;
begin
cbpdest.Items.Clear;
for i:=1 to cbPorig.Items.Count do
if cbPorig.Items[i-1] <>cbPorig.Text then
cbpdest.Items.Add(cbPorig.Items[i-1]);
cbpdest.Text:=cbpdest.Items[0];
end;

procedure TFcopiaPIani.Button5Click(Sender: TObject);
begin
dm1.TT2.Edit;
dm1.TT2.Post;
end;

procedure TFcopiaPIani.Button4Click(Sender: TObject);
begin
dm1.TT2.Edit;
dm1.TT2.Delete;
end;

procedure TFcopiaPIani.Button3Click(Sender: TObject);
begin
dm1.TT2.Append;
end;

procedure TFcopiaPIani.Button6Click(Sender: TObject);
begin
dm1.TT2.insert;
end;

end.
