unit UArchMat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ExtCtrls, Buttons;

type
  TFArchmat = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    ListBox1: TListBox;
    Button1: TSpeedButton;
    Button2: TSpeedButton;
    Button3: TSpeedButton;
    Button4: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FArchmat: TFArchmat;

implementation
Uses Usolomuri, Wizardusolomuri;
{$R *.dfm}

procedure TFArchmat.FormCreate(Sender: TObject);
begin
dbgrid1.datasource:=WizardFSoloMuri.Datasource2;
end;

procedure TFArchmat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;

procedure TFArchmat.FormDestroy(Sender: TObject);
begin
Farchmat:=nil;
end;

procedure TFArchmat.Button1Click(Sender: TObject);
begin
close;
end;

procedure TFArchmat.Button2Click(Sender: TObject);
begin
WizardFSoloMuri.table2.Edit;
WizardFSoloMuri.table2.POst;
end;

procedure TFArchmat.Button3Click(Sender: TObject);
begin
     if MessageDlg('Attenzione confermi la cancellazione della riga selezionata?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) <> mrYes then
        Exit;

WizardFSoloMuri.table2.Edit;
WizardFSoloMuri.table2.Delete;
end;

procedure TFArchmat.Button4Click(Sender: TObject);
begin
WizardFSoloMuri.table2.insert;
end;

procedure TFArchmat.ListBox1Click(Sender: TObject);
begin
     Case ListBox1.ItemIndex of
      - 1 : Exit;
        0 : begin
                WizardFSoloMuri.Table2.filter := '';
                WizardFSoloMuri.Table2.filtered := False;
            end;
        else
            WizardFSoloMuri.Table2.filter:='Categoria='''+ListBox1.Items.Strings[listbox1.Itemindex]+'''';
            WizardFSoloMuri.Table2.filtered:=true;
      end;
end;

end.
