unit UVIDEO;


interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls;

type
  TVIDEO = class(Tform)
    Edit1:Tedit;
    Edit2:Tedit;
    Edit3:Tedit;
    Edit4:Tedit;
    Edit5:Tedit;
    Edit6:Tedit;
    Label1:Tlabel;
    Label2:Tlabel;
    Label3:Tlabel;
    Label4:Tlabel;
    Label5:Tlabel;
    Label6:Tlabel;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
VIDEO:TVIDEO;
  

implementation

{$R *.DFM}

end.
