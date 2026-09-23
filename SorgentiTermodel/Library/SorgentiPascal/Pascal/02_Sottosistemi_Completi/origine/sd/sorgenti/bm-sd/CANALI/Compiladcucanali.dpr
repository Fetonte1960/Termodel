program Compiladcucanali;

uses
  ExceptionLog,
  Forms,
  calcoloCanali in 'CalcoloCanali.pas',
  U3dsd in 'pezzi3d\U3dsd.pas' {Form1},
  Uarchpezzi in 'pezzi3d\Uarchpezzi.pas',
  Interf3D in 'interf3d.pas',
  UOggetti in '..\3dCAD\Uoggetti.pas',
  Dimens in 'dimens.pas',
  pezzi in 'PEZZI.PAS',
  UCalcoloCanDLL in 'UCalcoloCanDLL.pas';

{$R *.res}
Var codin:Pchar;
begin
  Application.Initialize;
  init_Ogg;
 // form1:=Tform1.Create(nil);
 // form1.Show;
  //Application.CreateForm(TForm1, Form1);
 //initgrafo;
 //Init_PuntatoriCan;
 //Calcolareti(pchar('o:\cpi_12\versione_12\cpi win clima\file_termico_12\cadesterno'),pchar('can'));
 percdll:='o:\cpi_12\versione_12\cpi win clima\file_termico_12\dlltermico';
 codin:=('R1R_CUR90C');
 settacodice(codin);
 Application.Run;
end.
