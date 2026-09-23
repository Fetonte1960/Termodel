unit Urec;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs;

type tfilename=(a1,a2,a3);
type
  Trecord = class(TComponent)
  private
    FFileName: TFileName;
    procedure SetFileName(const Value: TFileName);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    property NomeFile: TFileName read FFileName write SetFileName;
    { Published declarations }
  end;

procedure Register;

implementation

Procedure trecord.SetFileName(const Value: TFileName);
begin
  ffilename:=value;
end;

procedure Register;
begin
  RegisterComponents('Data Access', [Trecord]);
end;

end.
