{*************************************************************}
Const MaxCampi=200;
Type 
RecCampi=Record
       Codice:STRING[20];
       Lunga:STRING[50];
       Tipo:STRING[50];
       LungCar:INTEGER;
       Tag:INTEGER;
       TipoCampo:STRING[50];
       Griglia:INTEGER;
       LookUp:STRING[50];
       CampoLookUp:STRING[50];
       Combo1:STRING[150];
       Combo2:STRING[150];
       Combo3:STRING[150];
       Combo4:STRING[150];
       Combo5:STRING[150];
       Combo6:STRING[150];
       Combo7:STRING[150];
       Combo8:STRING[150];
       Combo9:STRING[150];
       Combo10:STRING[150];
       End;
Ar_RecCampi=array[1..MaxCampi]of RecCampi;
{*************************************************************}
Const MaxRec=200;
Var NRec:integer;
Type 
TabRec=Record
       Campi:Ar_RecCampi;
       NCampi:Integer;
       Num:INTEGER;
       Codice:STRING[8];
       Descrizione:STRING[50];
       Massimo:INTEGER;
       Tipo:STRING[50];
       Associato:STRING[50];
       Menu:STRING[20];
       Aggiorna:STRING[2];
       End;
Ar_TabRec=array[1..MaxRec]of TabRec;
Var Rec_D:^Ar_TabRec;
