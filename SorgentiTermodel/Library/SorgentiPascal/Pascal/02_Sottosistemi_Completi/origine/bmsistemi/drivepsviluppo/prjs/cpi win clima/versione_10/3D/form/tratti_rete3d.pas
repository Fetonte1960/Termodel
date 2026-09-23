unit tratti_rete3d;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, Mask, StdCtrls, ComCtrls, ExtCtrls,ucompilaform,udbt,udatalink,
  Libreriagenerale,definiz;

type
  TFTrattirete3d = class(TForm)
    PageControl6: TPageControl;
    TabSheet21: TTabSheet;
    lfisso: TLabel;
    LB_Lunghezza: TLabel;
    Label67: TLabel;
    Label66: TLabel;
    Label55: TLabel;
    Label54: TLabel;
    Label53: TLabel;
    Label48: TLabel;
    Label47: TLabel;
    Label46: TLabel;
    Label45: TLabel;
    Label44: TLabel;
    Label43: TLabel;
    Label42: TLabel;
    Label41: TLabel;
    Ed_PCar: TEdit;
    Edit8: TEdit;
    Edit5: TEdit;
    Edit4: TEdit;
    Edit1: TEdit;
    ED_Velocita: TEdit;
    ED_TipoTubo: TEdit;
    TabSheet22: TTabSheet;
    Label75: TLabel;
    Label74: TLabel;
    Label73: TLabel;
    Label72: TLabel;
    Label71: TLabel;
    Label70: TLabel;
    Label69: TLabel;
    Label68: TLabel;
    Edit2: TEdit;
    Edit7: TEdit;
    Edit6: TEdit;
    Edit3: TEdit;
    TabSheet23: TTabSheet;
    MPerdite: TMemo;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    DBMemo1: TDBMemo;
    Label3: TLabel;
    Panel1: TPanel;
    Button1: TButton;
    DBEdit3: TDBEdit;
    Label10: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTrattirete3d: TFTrattirete3d;
Procedure Gest_Trattirete3d;

implementation
uses grafica2d;
{$R *.dfm}
Procedure Gest_Trattirete3d;
Var item,i:integer;
begin
FTrattirete3d:=TFTrattirete3d.Create(nil);
with dmtutti.T_Reti do
  begin
  first;
  while (not eof)and(V_recgen.Codice<>V_recconfcad.ColoreTipoReteIRR )do next;
  end;
item:=1;
if V_recgen.Report=Str_Calc_OK  then
  begin
  while (item<ultriga)and((dis^[item]^.Item_input<>itemselreti)or(Uppercase(dis^[item]^.PianoCad)<>Uppercase(V_recconfcad.pianocor)))do inc(item);
  FTrattirete3d.PageControl6.Visible:=true;
  FTrattirete3d.PageControl6.ActivePageIndex:=0;
  with dis^[item]^ do
      begin
      //tronco_sel:=tronco;
      //FTrattirete3d.Panel_base.ActivePageIndex:=6;
      FTrattirete3d.label10.Caption:=inttostr(Dati^[tronco]^.codicetubo);
      // Emanuela introdotta la formattazione dei dati affinchè non compaiono molti
      // valori dopo la virgola
      //FMainTubi.edit1.Text:=Floattostr(Dati^[tronco]^.Lungh);
      FTrattirete3d.edit1.Text := Format('%1.2f', [Dati^[tronco]^.Lungh]);
      FTrattirete3d.ED_TipoTubo.Text := Dati^[tronco]^.Tipo;
      FTrattirete3d.edit4.Text:=Dati^[tronco]^.CodDiam;
      FTrattirete3d.lfisso.caption:=Dati^[tronco]^.SWDiam;
      // Emanuela introdotta la formattazione dei dati affinchè non compaiono molti
      // valori dopo la virgola
      //FMainTubi.edit5.Text:= Floattostr(Dati^[tronco]^.PortEff);
      FTrattirete3d.edit5.Text:= Format('%1.4f', [Dati^[tronco]^.PortEff]);
      FTrattirete3d.Ed_Velocita.Text:= Format('%1.4f', [Dati^[tronco]^.Velocita]);
      FTrattirete3d.Ed_PCar.Text:= Format('%1.4f', [Dati^[tronco]^.pd * 1000]);
      FTrattirete3d.Edit8.Text:= Format('%1.4f', [Dati^[tronco]^.pl * 1000]);
      FTrattirete3d.mperdite.Lines.Clear;
      for i:=1 to Maxpconc do
        begin
        if Dati^[tronco]^.Pconc[i].N<>0 then  FTrattirete3d.mperdite.Lines.Add('COD : '+Dati^[tronco]^.Pconc[i].Cod+'    N°: '+Inttostr(Dati^[tronco]^.Pconc[i].N));
        end;
     // if Dati^[tronco]^.Pconc[1].N<>0 then FMainTubi.edit8.Text:=Inttostr(Dati^[tronco]^.Pconc[1].N)
      //else FMainTubi.edit8.Text:='';
      //FMainTubi.edit7.Text:=Dati^[tronco]^.Pconc[1].Cod;
      //if Dati^[tronco]^.Pconc[2].N<>0 then FMainTubi.edit10.Text:=Inttostr(Dati^[tronco]^.Pconc[2].N)
      //else FMainTubi.edit10.Text:='';
      //FMainTubi.edit9.Text:=Dati^[tronco]^.Pconc[2].Cod;
      if {(Nlinea=0)and}(dati^[tronco]^.Term<>0) then
        begin
        FTrattirete3d.tabsheet22.TabVisible:=true;
        //FMainTubi.Groupbox5.Visible:=true;
        // Emanuela introdotta la formattazione dei dati affinchè non compaiono molti
        // valori dopo la virgola
        {FMainTubi.edit2.Text:=floattostr(Gterm^[dati^[tronco]^.Term]^.port);
        FMainTubi.edit3.Text:=floattostr(Gterm^[dati^[tronco]^.Term]^.perd);
        FMainTubi.edit6.Text:=floattostr(Gterm^[dati^[tronco]^.Term]^.pot);  }
        FTrattirete3d.edit2.Text := Format('%1.4f', [Gterm^[dati^[tronco]^.Term]^.port]);
        FTrattirete3d.edit3.Text := Format('%1.4f', [Gterm^[dati^[tronco]^.Term]^.perd]);
        FTrattirete3d.edit7.Text := Format('%1.4f', [(risultcalc^.perdita / 2) - dati^[tronco]^.pp]);
        if (CompareStr(UpperCase(Gterm^[dati^[tronco]^.Term]^.TipoTerm), Uppercase('Fancoil')) = 0) and
           (Gterm^[dati^[tronco]^.Term]^.potE <> 0)
        then
          FTrattirete3d.edit6.Text := Format('%1.0f', [Gterm^[dati^[tronco]^.Term]^.potE])
        else
          FTrattirete3d.edit6.Text := Format('%1.0f', [Gterm^[dati^[tronco]^.Term]^.pot]);
        end
      else FTrattirete3d.tabsheet22.TabVisible:=false;
      //else FMainTubi.Groupbox5.Visible:=false;
      //if CL then
      //cnv.Pen.Color:=clyellow;
      end;
    //end
    //else
    //begin
      //if Rete_Sel <> dis^[item]^.indRete then
      //   cnv.Pen.Color := clYellow;

    //end
  end
else FTrattirete3d.PageControl6.Visible:=false;
compilaform(FTrattirete3d.GroupBox1,'Reti',dmtutti.ds_reti);
FTrattirete3d.ShowModal;
end;


procedure TFTrattirete3d.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
action:=cafree;
end;

procedure TFTrattirete3d.Button1Click(Sender: TObject);
begin
Close;
end;

end.
