{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

Unit key;
interface

uses crt,dos,WM;


Procedure decrementa(VAR Valore : integer;Locazione : integer);

Procedure ControlloChiave(var Risultato : INTEGER;Locazione,vers : integer);

{==========================================================================}
implementation

{$I genKey}

Procedure decrementa(VAR Valore : integer;Locazione : integer);
var Retour,ValoreOk  : integer;


begin

  Retour:=Lecture(Locazione,valore);

  if (Valore> 1) and (Valore<300) then
   begin

     Valore := Valore - 1;

     ValoreOk := Ecriture(Locazione,Valore);

   end;

end;


procedure PassWordKey(VAR Valeur : integer;Locazione,Vers : integer);
var  V1,V2,Num1,Num2,num3,num4   : integer;

     carattere,Codice  : String[10];
     C1,c2             : String[5];
     ris               : integer;

begin

   V1 := Lecture(28,Valeur);  Num1 := Valeur;
   V1 := Lecture(29,Valeur);  Num2 := Valeur;

   V1 := Lecture(25,Valeur);  Num3 := Valeur;
   V1 := Lecture(26,Valeur);  Num4 := Valeur;

   If ( Num1 = Num3 ) AND (Num2 = Num4) then
   begin
     Ris := Ecriture(Locazione,Vers);
     Valeur := Vers;
   end

   else
    begin

      clrscr;

      gotoxy(8,6); write(W_M(1)); {' CHIAVE DISABILITATA ');}
      gotoxy(8,8);write(W_M(2));  {'Inserire codice di abilitazione :');}

      readLN(carattere);
      clrScr;

      C1 := '';  C2 := '';

      V1 := Lecture(25,Valeur);  STR(Valeur,C1);
      V1 := Lecture(26,Valeur);  STR(Valeur,C2);

      Codice := C1+C2;

      if Carattere = Codice then
       begin
         Ris := Ecriture(Locazione,Vers);
         Valeur := Vers;

         V1  := Ecriture(25,Num1);
         V2  := Ecriture(26,Num2);
       end
      else
       begin
         gotoxy(8,10);write(W_M(3)); { ' CODICE ERRATO !!!'); }
         Valeur := 1;
         delay(6000);
         Halt;
       end;
    end;
end;




Procedure ControlloChiave(var Risultato : INTEGER;Locazione,vers : integer);
Var
   Retour,valeur : integer;
   OLDFILETRADUZ:STRING;


procedure messerrore;
begin
 clrscr;
 write(chr(7));
 gotoxy(10,10);write(W_M(4)); { 'La protezione hardware non ‚ abilitata a funzionare');}
 gotoxy(10,11);write(W_M(5)); { 'con questa realese del programma ');}
 gotoxy(10,14);write(W_M(6)); {'Contattare l''MC4 Software tel. 011 43 43 297 oppure 011 43 43 630');}
 halt;
end;

Begin
   OLDFILETRADUZ:=FILETRADUZ;
   FILETRADUZ:='KEY';
   textbackground(0);
   textcolor(7);

   Valeur:=0;

   Retour:=Lecture(0,valeur);

   if retour <> 0 then
    begin
       clrscr;
       write(chr(7));
       gotoxy(10,10);write(W_M(7)); { 'Errore fatale ! La protezione hardware non risponde');}
       gotoxy(10,11);write(W_M(8)); { 'o non ‚ stata introdotta in modo corretto'); }

       gotoxy(10,13);write(W_M(9)); { 'Controllare che la protezione sia inserita nella porta parallela dello');}
       gotoxy(10,14);write(W_M(10)); { 'elaboratore (subito prima del cavo della stampante), in questo caso ‚');}
       gotoxy(10,15);write(W_M(11)); { 'probabile che la stampante sia spenta, occorre accenderla');}
       halt;
     end;



   Risultato:=(Valeur div 1492);

   Retour:=Lecture(16,valeur);
   if valeur<>0 then
     begin
       gotoxy(10,10);write('Errore fatale ! La protezione hardware non risponde correttamente');   {*TR*}
       gotoxy(10,13);write('Conttattare l''ufficio assistenza MC4 ');{*TR*}
       halt;
     end;
   Retour:=Lecture(23,valeur);
   if valeur<>0 then
     begin
       gotoxy(10,10);write('Errore fatale ! La protezione hardware non risponde correttamente');   {*TR*}
       gotoxy(10,13);write('Conttattare l''ufficio assistenza MC4 ');{*TR*}
       halt;
     end;
   Retour:=Lecture(24,valeur);
   if valeur<>0 then
     begin
       gotoxy(10,10);write('Errore fatale ! La protezione hardware non risponde correttamente');   {*TR*}
       gotoxy(10,13);write('Conttattare l''ufficio assistenza MC4 ');{*TR*}
       halt;
     end;

   Retour:=Lecture(Locazione,valeur);


   case valeur of

   0 : messErrore;    {chiave non abilitata con questa realise del pgm}

   1 : PassWordKey(Valeur,Locazione,vers);   {digitare la passWord per settare la chiave}

 end;

   if Valeur < 0 then messErrore;

   if (valeur > 299) and (valeur < vers) then messErrore;    {chiave non abilitata con questa realise del pgm}

  FILETRADUZ:= OLDFILETRADUZ;

End;


end.

