unit Init_easy;

interface
uses sysutils,libreriagenerale,windows,dialogs,classes
{$I Uses}
;

Procedure Nuovoprog;
Procedure Apriprog;
Procedure Aggiorna_file;
Procedure Init_app;
Procedure Gest_menu(Voce:string);

Var  Nomeapp:string='Gestione dati';
implementation
uses maingestionegenera;
Procedure Init_app;
Var sl:Tstringlist;
begin
sl:=Tstringlist.create;
 FGestioneGenera.Generaapplicazione1.Visible:=false;
 {$I Init_app}
sl.free;
end;
Procedure Apriprog;
begin
end;
Procedure Gest_menu(Voce:string);
begin
{$I Gest_menu}
end;
Procedure Nuovoprog;
begin
end;
Procedure Aggiorna_file;
begin
end;
end.
