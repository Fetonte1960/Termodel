unit HeaderDllTermico;

interface
Type TSuperficiScambianti=Procedure;
     TSaveTxt=Procedure(database,FileTxt:pchar);
     TOpenTxt=Procedure(database,FileTxt:pchar);
     TNuovoTxt=Procedure(database:Pchar);
     TItem_Menu=procedure(item:PChar);
     TAggiornaDisegno=procedure;
     TFineDisegno=procedure(numamb:Pchar);
     TAggiungiEntita=procedure(Entita:char;x1,y1,z1,x2,y2,z2,r:real;testo,parametri:Pchar);
     TEditTabella=procedure (Nomedb,Database,Titolo,Commento:Pchar;Campotab:integer);
     TCalcoloL10=procedure;
     TDefinisciPercorsi=Procedure(pathDll,PathDrive:Pchar); // con slash finale  valido se diverso da vuoto
Var SuperficiScambianti:TSuperficiScambianti;
    SaveTxt:TSaveTxt;
    OpenTxt:TOpenTxt;
    NuovoTxt:TNuovoTxt;
    Item_Menu:TItem_Menu;
    AggiornaDisegno:TAggiornaDisegno;
    AggiungiEntita:TAggiungiEntita;
    FineDisegno:TFineDisegno;
    EditTabella:TEditTabella;
    CalcoloL10:TcalcoloL10;
    DefinisciPercorsi:TDefinisciPercorsi;
implementation

end.
