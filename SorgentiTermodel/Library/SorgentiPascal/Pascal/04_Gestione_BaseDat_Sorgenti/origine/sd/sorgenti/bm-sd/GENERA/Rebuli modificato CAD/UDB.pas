unit UDB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDM1 = class(TDataModule)
    TT1: TTable;
    TT2: TTable;
    TT3: TTable;
    TT4: TTable;
    procedure TT1NewRecord(DataSet: TDataSet);
    procedure TT1AfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM1: TDM1;

implementation
uses UCalcoli,sofrad,grafica,UdataLink;
{$R *.DFM}

procedure TDM1.TT1NewRecord(DataSet: TDataSet);
begin
InitAmb(TT1);
end;

procedure TDM1.TT1AfterPost(DataSet: TDataSet);
Var tl :integer;
begin
if not primopost then exit;
primopost:=false;
{rsz:=true;}
if not bloccaredraw then
  begin
  Redraw(bloccaredraw,form1.Disegno.Canvas,form1.Disegno,form1.Panel1,tl);
  {disegno.picture.Savetofile('C:\ded\sorgenti\rebuli\resources\fiore.bmp');}

  end;
with V_amb do
  begin
  if V_amb.allinea<>'' then AllineaMenu(allinea[1],allinea[2],false)
  else AllineaMenu('C','C',false);
  CalcoloPann(bloccaredraw,tt1,tl);
  end;
primopost:=true;
end;

end.
