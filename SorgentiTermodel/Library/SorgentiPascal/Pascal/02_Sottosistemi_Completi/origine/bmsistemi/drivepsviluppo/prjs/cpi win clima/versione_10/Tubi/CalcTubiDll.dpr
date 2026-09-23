Library CalcTubiDll;

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
  ShareMem,
  ExceptionLog,
  BMEureka in '..\..\..\..\Comp\Source\UNIT_CONDIVISE\BMEureka.pas' {FormEureka},
  SysUtils,
  Classes,
 {$IFDEF CANALI}
  CalcloloCanali,
  DispErrori,
 {$ENDIF}
  LibreriaGenerale in '..\comuni\LibreriaGenerale.pas',
  Ritorno in 'RITORNO.PAS',
  Tool_visualizza in '..\DllPrincipaleTermico\forms\Tool_visualizza.pas' {FTool_visualizza},
  Calcolo in 'Calcolo.pas',
  RITORNODXF in 'RITORNODXF.pas',
  UDB in '..\CARICHI\database\Udb.pas' {DM1: TDataModule},
  Utireport in '..\comuni\report\Utireport.pas',
  VariabiliGenerali in '..\comuni\VariabiliGenerali.pas',
  UMain_CalcTubi in 'UMain_CalcTubi.pas' {FMainTubi},
  ULeggitxt in 'Uleggitxt.pas',
  UStampe in 'UStampe.pas',
  UGrafoDXF in 'UGrafoDXF.pas',
  InitPunt_Tubi in 'InitPunt_Tubi.pas',
  Grafica in '..\comuni\Grafica\Grafica.pas',
  definiz in 'definiz.pas',
  AggAttrDXF in '..\comuni\Grafica\AggAttrDXF.pas',
  UCaricadati in 'database generati\UCaricadati.pas',
  ImpTerm in 'impterm.pas',
  Leggidxf in '..\comuni\Grafica\Leggidxf.pas',
  OutDXFBM in 'OutDXFBM.pas';

{$R *.res}

Exports CalcTubi;
begin
{$IFDEF CANALI}
 Init_PuntatoriCan;
 initerrori;
{$ENDIF}
end.
