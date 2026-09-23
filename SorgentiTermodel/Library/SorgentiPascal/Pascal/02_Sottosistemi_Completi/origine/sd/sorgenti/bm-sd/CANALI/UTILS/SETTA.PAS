Program LOAdKey;

USES dos,CRT,defuti,utilitie,key,demo,mphar,inituti;

{$F-}

type
    Contenuto_chiave=array[0..30] of integer;

Var
    valeur:longint;
    retour,scelta:integer;
    I:integer;
    CONTKEY:Contenuto_chiave;
    glst:text;Titolo:st80;
    Keys:string[5];
    PStr : St80;


{L SKTP5F.}
{I mphkey    }



Procedure INitvettore;

VAr
   I:integer;

   begin
        for I:=0 to 27 Do
        contkey[i]:=0;
        For i:=28 to 30  do
        contkey[i]:=100;
 end;



procedure Error;
var
  i:Integer;

Begin
   if keys='Micro' then
    begin
       valeur:=0;
       Retour:=lecture(0,valeur);
       If Retour<>0 then
        begin
          case Retour of
           2:Writemessage('errkey.msg',1);
           3:Writemessage('errkey.msg',2);
          end;
          delay(3000);
          halt;
        end;
    end;
end;

procedure Readkey;
 var
  i:integer;

 Begin
    if keys ='Rain' then
     begin
        For i:= 0 to 30 DO
         begin
            Str(i,Pstr);
            Pstr:='R/'+Pstr;
            Contkey[i]:=SK_COMMAND(Pstr);
         end;
     end
    else
     begin
        error;
        valeur:=0;
        For i:= 0 to 30 DO
         begin
            retour := lecture (i,valeur);
            Contkey[i]:=valeur;
         end;
     end;
 end;

procedure Writekey(Ini,Fin:integer);
 var
  i:integer;
  St1:string;

 Begin
    if keys ='Rain' then
     begin
        For i:= Ini to Fin DO
         begin
            Str(i,Pstr);
            Str(ContKey[i],St1);
            Pstr:='W/'+Pstr+'/'+St1;
            Retour:=SK_COMMAND(Pstr);
         end;
     end
    else
     begin
        error;
        For i:= Ini to Fin DO retour := ecriture(i,Contkey[i]);
     end;
 end;



Procedure Initkey;
var i:integer;
Begin
   scelta:=10;
   Error;
   Valeur:=0;
   clrscr;
   gotoxy(12,35);
   textcolor(15);
   Write('Attendere prego...........');
   delay(200);
   i:=1;
   Repeat
     if Keys ='Rain' then
      begin
         Str(i,Pstr);
         Pstr:='W/'+Pstr+'/0';
         Retour:=SK_COMMAND(Pstr);
      end
     else Retour:=ecriture(i,valeur);
     I:=I+1;
   Until (i>30);
   if Keys ='Rain' then Retour:=SK_COMMAND('W/0/1492')
   else Retour:=ecriture(0,1492);
end;




Procedure  Cliente;

Type
    CodClie=Record
               Cl:St6;
               GG,MM:INTEGER;
            End;

Var

Dtacle:Codclie;
Initmask:Boolean;
Campo,Chiave:Integer;


procedure ConvertiNumeroData;
var
  comodo:string;

Begin
    with Dtacle do
     Begin
        gg:=contkey[30] div 100;
        mm:=contkey[30] - gg*100;
     end;
end;


procedure ConvertiDataNumero;
var Comodo:real;

Begin
    With  Dtacle do
    begin
        contkey[30]:=gg*100+mm;
     End;
 END;

 Procedure Genera_Numero;
 Var
 I:Integer;
 Co1,co2:Integer;
 Rst1,Rst2:St3;
 Err:Integer;

  Begin
  Co1:=0;Co2:=0;Rst1:=' ';Rst2:=' ';Err:=0;
      With Dtacle Do
      Begin
         For I:=1 to Length(Cl) do
         Begin
             If Cl[i]='0' Then Cl[i]:='9' Else
             If Cl[i]='1' Then Cl[i]:='8' Else
             If Cl[i]='2' Then Cl[i]:='7' Else
             If Cl[i]='3' Then Cl[i]:='6' Else
             If Cl[i]='4' Then Cl[i]:='5' Else
             If Cl[i]='5' Then Cl[i]:='4' Else
             If Cl[i]='6' Then Cl[i]:='3' Else
             if Cl[i]='7' then Cl[i]:='2' Else
             If CL[I]='8' Then Cl[i]:='1' Else
             If Cl[i]='9' Then Cl[i]:='0'
          End;
          Rst1:=Copy(Cl,1,3);
          Rst2:=Copy(Cl,4,6);
       End;
       Val(Rst1,Contkey[28],err);
       VaL(Rst2,Contkey[29],Err);

   End;









Procedure Genera_Codice;
Var
   Interno:Integer;
   Int1,Int2:St3;
   Coda:St6;
Begin
     Interno:=0;Int1:=' ';Int2:=' ';Coda:=' ';
     Readkey;
     Str(contkey[28],Int1);
     Str(Contkey[29],int2);

      With Dtacle Do
      Begin
      Cl:=Int1+int2;
         For I:=1 to Length(Cl) do
         Begin
             If Cl[i]='9' Then Cl[i]:='0' Else
             If Cl[i]='8' Then Cl[i]:='1' Else
             If Cl[i]='7' Then Cl[i]:='2' Else
             If Cl[i]='6' Then Cl[i]:='3' Else
             If Cl[i]='5' Then Cl[i]:='4' Else
             If Cl[i]='4' Then Cl[i]:='5' Else
             If Cl[i]='3' Then Cl[i]:='6' Else
             if Cl[i]='2' then Cl[i]:='7' Else
             If CL[I]='1' Then Cl[i]:='8' Else
             If Cl[i]='0' Then Cl[i]:='9'
          End;

       End;

End;


Begin
     Initmask:=true;
     clrscr;
     ReadKey;
     ConvertiNumeroData;
     Genera_Codice;
     repeat
      M_UsaMaskera(SEG(DtaCle),OFS(DtaCle),'Memoria.MSK','pm',Campo,chiave,scelta,bianco,grigiolight,
                   InitMask,not InitMask,false,true,true);

     Until Chiave=27;
     ConvertiDataNumero;
     Genera_Numero;
     WriteKey(27,30);
END;



Procedure caricaleggicodicipr(valeur:integer);

var
  i,CAMPO,CHIAVE:INTEGER;
  Initmask:boolean;
 Begin
    clrscr;
    Initmask:=true;
    campo:=1;
    readkey;
    repeat
      M_UsaMaskera(SEG(ContKey),OFS(ContKey),'Verifica.MSK','pm',Campo,chiave,scelta,bianco,grigiolight,
                   InitMask,not InitMask,false,true,true);
    Until Chiave=27;
    WriteKey(0,30);
end;












procedure Micro;
var
  i:Integer;
  Pstr:string;

 Begin
    Retour:=lecture(0,valeur);
    If Retour<>0 then
     begin
        i:=1;
        while (retour <> 0) and (i < 5) do
         begin
            Str(i,Pstr);
            Pstr:='I/'+Pstr+'/10';
            Retour :=SK_COMMAND(Pstr);
            i:=i+1;
         end;
        IF Retour = 0 then
         begin
            Keys:='Rain';
            Retour:=SK_COMMAND('E/hyTAyAjqscoDyada');
            Retour:=SK_COMMAND('E/aAdaUabdcjtNcorc');
         end
        else
         begin
            Writemessage('errkey.msg',5);
            halt;
         end;
     end
    else Keys:='Micro';
 end;


begin
    initprogram;
    ReadColor;
    valeur:=1;
    ctrlkey:=1;
    TextBackGround(col[1]);
    InitVettore;
    clrscr;
    Micro;
    if Keys='Rain' then
     nomeprogetto:=' Rainbow Technologies  Sentinel Scribe Evaluation Program '
    else
     nomeprogetto:='  MICROPHAR 1993 VERSION LINKED for MsPascal    ';

    Scelta:=10;
    Mouse_init;
    writeln(mouset);
    delay(500);
    initnastro('');



    REPEAT

      CASE Scelta OF
        10:Caricaleggicodicipr(valeur);
        20:Cliente;
        30:Initkey;
        else scelta:=40;
      end;
    until scelta=40;
END.


