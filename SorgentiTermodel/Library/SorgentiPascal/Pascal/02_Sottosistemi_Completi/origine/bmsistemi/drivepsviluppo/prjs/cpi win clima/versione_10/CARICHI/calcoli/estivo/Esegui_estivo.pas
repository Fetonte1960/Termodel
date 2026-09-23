unit Esegui_estivo;
interface
uses Warning,mainform,UrisultEstivo,diagramma,caricamento;
Procedure Estivo;

implementation
Procedure Estivo;
begin
//DMRisult:=TDMRisult.Create(nil);
//FDiagramma:=TFDiagramma.Create(nil);
//FWarning:=TFWarning.Create(nil);
//FormCaricamento:=TFormCaricamento.Create(nil);
FMainEstivo:=TFMainEstivo.Create(nil);
FMainEstivo.ShowModal;
end;
end.
