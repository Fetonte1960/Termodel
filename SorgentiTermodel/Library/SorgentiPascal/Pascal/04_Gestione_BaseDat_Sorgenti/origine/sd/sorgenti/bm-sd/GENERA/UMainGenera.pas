unit UMainGenera;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Tabnotbk,dbtables, DBCtrls, Grids, DBGrids,
  Db;

type
  TForm1 = class(TForm)
    Button3: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    CBNobde: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure DBGrid3DblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses UCalc,UFunzgenera;

{$R *.DFM}
Var i:Integer;
procedure TForm1.Button1Click(Sender: TObject);
{$I Genera}
begin
CreaMappa;
showmessage('Generazione completata');
//GeneraProc;
end;

procedure TForm1.Button2Click(Sender: TObject);

begin
//Calcolo(tabella1,tabella3);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
//Calcolo(Tabella1,Tabella3);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
(*
Tabella1.Tablename:=tabella2Nome.Value;
Tabella1.Open;
tabella1.refresh;
*)
end;

procedure TForm1.DBGrid3DblClick(Sender: TObject);
begin
(*
Dbgrid2.Visible:=False;
Tabella3.Close;
tabella3.MasterSource:=datasource1;
tabella3.MasterFields:='';
tabella3.IndexName:='';

Tabella1.close;
Tabella1.tablename:=Tabella2Nome.Value+'.db';
Tabella1.open;
Tabella1.refresh;
if Tabella2Slave.Value<>'' then
  begin
  if tabella2Indice.Value<>'' then
    begin
    tabella3.MasterSource:=DataSource1;
    tabella3.MasterFields:=tabella2Indice.Value;
    tabella3.IndexName:='Per'+tabella2Indice.Value;
    end;
  Dbgrid2.Visible:=true;
  Tabella3.tablename:=Tabella2Slave.Value+'.db';
  Tabella3.open;
  Tabella3.refresh;
  end;
*)
end;

procedure TForm1.FormActivate(Sender: TObject);
Var ss:string;
begin
GetDir(0,ss);
edit1.text:=ss;
if paramcount>0 then
  begin
  ss:=paramstr(1);
  end
else ss:='Manca il parametro';
form1.Edit1.text:=ss;


//if paramcount>1 then
//  begin
//  ss:=paramstr(2);
//  end
//else ss:='Manca il parametro';

//form1.Edit2.text:=ss;
end;

procedure TForm1.FormCreate(Sender: TObject);
Var ss:string;
begin
end;

end.
