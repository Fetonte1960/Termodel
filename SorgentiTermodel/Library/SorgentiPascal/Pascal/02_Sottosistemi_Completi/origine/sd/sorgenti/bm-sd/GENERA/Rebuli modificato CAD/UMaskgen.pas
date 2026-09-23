unit UMaskgen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, DBCtrls, Db, DBTables;

type
  TFMaskgen = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    Panel1: TPanel;
    BOk: TButton;
    BCancel: TButton;
    DataSource1: TDataSource;
    Table1: TTable;
    procedure BOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMaskgen: TFMaskgen;
Procedure usamaschera(Nomedb,Titolo,Commento:string);
implementation
uses Udati;

Procedure usamaschera(Nomedb,Titolo,Commento:string);
Var i:integer;
    maxlab,maxsize,hmask:Integer;

Procedure settaLab(Lab:Tlabel;cap:string;size:integer);
Var i :integer;
    Cap1:string;
begin
Cap1:=cap+' ';
if size<>0 then
  begin
  Lab.Caption:=cap1;
  while lab.Width < MaxLab do
    begin
    cap1:=cap1+'.';
    Lab.Caption:=cap1;
    end;
  end;
Lab.Caption:=cap1;
if  (size=0)and(lab.Width >MaxLab) then Maxlab:=lab.Width;
lab.Visible:=true;
if lab.top>hmask then hmask:=lab.top;
end;

Procedure settaTutteLab(Ind:integer;Cap:String;size:integer);
begin
with  Fmaskgen do
  Case ind of
  1:SettaLab(Label1,Cap,size);
  2:SettaLab(Label2,Cap,size);
  3:SettaLab(Label3,Cap,size);
  4:SettaLab(Label4,Cap,size);
  5:SettaLab(Label5,Cap,size);
  6:SettaLab(Label6,Cap,size);
  7:SettaLab(Label7,Cap,size);
  8:SettaLab(Label8,Cap,size);
  9:SettaLab(Label9,Cap,size);
  end;
end;
Procedure settaDbe(Dbe:TDbedit;NomeC:string;POs:integer);
begin
Dbe.DataField:=NomeC;
Dbe.Left:=POs+5;
Dbe.Visible:=true;
  case dbe.Field.DataType of
  ftinteger,ftfloat:dbe.width:=50;
  ftstring:dbe.width:=dbe.Field.Datasize*7;
  end;
if dbe.width > maxsize then maxsize:=dbe.width;
end;

Procedure settaTutteDbe(Ind:integer;NomeC:String;Pos:integer);
begin
with  Fmaskgen do
  Case ind of
  1:settaDbe(Dbedit1,NomeC,POs);
  2:settaDbe(Dbedit2,NomeC,POs);
  3:settaDbe(Dbedit3,NomeC,POs);
  4:settaDbe(Dbedit4,NomeC,POs);
  5:settaDbe(Dbedit5,NomeC,POs);
  6:settaDbe(Dbedit6,NomeC,POs);
  7:settaDbe(Dbedit7,NomeC,POs);
  8:settaDbe(Dbedit8,NomeC,POs);
  9:settaDbe(Dbedit9,NomeC,POs);
  end;
end;

begin
with  Fmaskgen do
  begin
  Caption:=titolo;
  table1.close;
  table1.DatabaseName:=Nomecom;
  table1.Tablename:=NomeDb+'.Db';
  Table1.open;
  GroupBox1.Caption:=commento;
  hMask:=0;
  MaxLab:=0;
  for i:=1 to Table1.Fields.count do
  with Table1.Fields[i-1]do
  SettaTutteLab(i,FieldName,0);


  for i:=1 to Table1.Fields.count do
  with Table1.Fields[i-1]do
  SettaTutteLab(i,FieldName,20);
  Maxlab:=MaxLab+Label1.Left;
  maxsize:=0;
  for i:=1 to Table1.Fields.count do
  with Table1.Fields[i-1]do
    begin
    SettaTutteDbe(i,FieldName,MaxLab);
    end;
  width:=dbedit1.left+maxsize+label1.left*2;
  height:=hmask+panel1.height+Dbedit1.height+30;
  Table1.edit;
  showmodal;
  Table1.post;
  end;
end;
{$R *.DFM}

procedure TFMaskgen.BOkClick(Sender: TObject);
begin
Fmaskgen.close;
end;

end.
