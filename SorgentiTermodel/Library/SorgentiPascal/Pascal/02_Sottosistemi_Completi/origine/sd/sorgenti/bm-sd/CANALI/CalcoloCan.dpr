library CalcoloCan;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  FastMM4 in 'C:\documenti\bmsistemi\FASTMM_490\FastMM4.pas',
  FastMM4Messages in 'C:\documenti\bmsistemi\FASTMM_490\FastMM4Messages.pas',
  SysUtils,
  Classes,
  UOggetti in '..\3dCAD\Uoggetti.pas',
  Uselcodice in 'Uselcodice.pas',
  U3dsd in 'pezzi3d\U3dsd.pas' {Form1},
  calcoloCanali in 'CalcoloCanali.pas',
  UCalcolareti in 'UCalcolareti.pas',
  Uarchpezzi in 'pezzi3d\uarchpezzi.pas',
  Interf3D in 'interf3d.pas',
  varcarichi in 'P:\prjs\cpi win clima\versione_10\CARICHI\varcarichi.pas',
  CopiaLibreriaGenerale in '..\estivo\copiaLibreriaGenerale.pas';

{$R *.res}

exports Uselcodice.Selcodice,UCalcolaReti.CalcolaReti;

begin
Init_PuntatoriCan;
initgrafo;
init_Ogg;
end.
