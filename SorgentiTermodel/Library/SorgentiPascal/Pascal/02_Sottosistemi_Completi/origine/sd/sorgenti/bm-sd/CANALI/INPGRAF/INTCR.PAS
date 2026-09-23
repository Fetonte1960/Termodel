{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit IntCR;

INTERFACE

Uses Definiz,Printer;

Procedure SetPezzi(Var PezzoMain,PezzoBr1,PezzoBr2:integer;tr1,indcroce,Main,Br1,Br2:integer);

Procedure Scarica_Nodo(Lung_Ing,Lung_Main,Lung_br1,Lung_br2:real;
             Pezzi_Ing,Pezzi_Main,Pezzi_Br1,Pezzi_Br2:integer);

Procedure Carica_LMin(Var Lung_Ing,Lung_Main,Lung_br1,Lung_br2:real;
                      Pezzi_Ing,Pezzi_Main,Pezzi_Br1,Pezzi_Br2:integer);

Procedure Spezza_can(tr1,pez:integer;
                     Xins_p,Yins_p,Zins_p,Xins_A,Yins_A,Zins_A,
                     Xout_p,Yout_p,Zout_p,Xout_A,Yout_A,Zout_A:real;
                     Var L_Eff1,LEff2:real) ;

Procedure ScaricaPezzoTR(L_eff1,L_eff2:real;Ind_Ult,Ind_ult1:integer);

{---------------------------------------------------------------------------}
implementation

{*****************************  SetPezzi **********************************}

{-- Trova l'inidirizzo dei dati degli stacchi --}

Procedure SetPezzi(Var PezzoMain,PezzoBr1,PezzoBr2:integer;tr1,indcroce,Main,Br1,Br2:integer);
begin
Pezzomain:=0;
if Main<>0 then PezzoMain:=Dati^[tr1]^.pros[main];
if Pezzomain<>0 then Pezzomain:=Dati^[pezzomain]^.Pezzi[0];

PezzoBr1:=0;
if Br1<>0 then PezzoBr1:=Dati^[tr1]^.pros[Br1];
if PezzoBr1<>0 then PezzoBr1:=Dati^[pezzoBr1]^.Pezzi[0];

PezzoBr2:=0;
if Br2<>0 then PezzoBr2:=Dati^[tr1]^.pros[Br2];
if PezzoBr2<>0 then PezzoBr2:=Dati^[pezzoBr2]^.Pezzi[0];

end;

{***************************  Scarica_nodo     *****************************}

Procedure Scarica_Nodo(Lung_Ing,Lung_Main,Lung_br1,Lung_br2:real;
             Pezzi_Ing,Pezzi_Main,Pezzi_Br1,Pezzi_Br2:integer);

Var CodP:string;

{

 Lung_?? =Lunghezze delle varie uscite a partire dall'origine.
 Pezzi_??=Indice di --> V_Pezzi^[Pezzi_??] <--  che contiene i dati.

            | Br2                                    | Br1
            |                                        |
   Ing   ------- Main     Ing  ------- Main   Ing ---|
            |                     |                  |
            | Br1                 | Br1              | Main

}

Begin
{
CodP:=VPezzi^[Pezzi_ing]^.Codice;
 }
{

if CodP='..' etc,etc
interfaccia di tutti i pezzi che realizzano diramazioni.
}

end;

{***************************  Carica_LMIn     *****************************}

Procedure Carica_LMin(Var Lung_Ing,Lung_Main,Lung_br1,Lung_br2:real;
                      Pezzi_Ing,Pezzi_Main,Pezzi_Br1,Pezzi_Br2:integer);

Var CodP:string;

{

 Lung_?? =Lunghezze delle varie uscite a partire dall'origine.
 Pezzi_??=Indice di --> V_Pezzi^[Pezzi_??] <--  che contiene i dati.

            | Br2                                    | Br1
            |                                        |
   Ing   ------- Main     Ing  ------- Main   Ing ---|
            |                     |                  |
            | Br1                 | Br1              | Main

}

Begin

CodP:=VPezzi^[Pezzi_ing]^.Codice;

{

if CodP='..' etc,etc
  Settaggio di LMIN in
}

end;


{***************************  Spezza_can     *****************************}

{pez se e` riduzione  automatica vale sempre uno}

Procedure Spezza_can(tr1,pez:integer;
                     Xins_p,Yins_p,Zins_p,Xins_A,Yins_A,Zins_A,
                     Xout_p,Yout_p,Zout_p,Xout_A,Yout_A,Zout_A:real;
                     Var L_Eff1,LEff2:real) ;

{ Xins_p,..,.. = Punto di inserimento del pezzo a monte del canale
  Xins_A,..,.. = Punto di inserimento del pezzo a valle del canale
  Xout_p,..,.. = Punto di uscita del pezzo a monte del canale
  Xout_A,..,.. = Punto di entrata del pezzo a valle del canale
  L_Eff1  in entrata=Lunghezza minima del pezzo a monte
          in uscita =Lunghezza calcolata del pezzo a monte

  L_Eff2  Come sopra per il pezzo a valle
}

begin
Writeln(lst,' Tronco:',Dati^[tr1]^.Num);
Writeln(lst,' P1:',Xins_p*Conf^.altNum/40:6:0,' ',Yins_p*Conf^.altNum/40:6:0,' ',Zins_p*Conf^.altNum/40:6:0,' ');
Writeln(lst,' P2:',Xins_A*Conf^.altNum/40:6:0,' ',Yins_A*Conf^.altNum/40:6:0,' ',Zins_A*Conf^.altNum/40:6:0,' ');
Writeln(lst,' Lung:',sqrt(sqr(Xins_A-Xins_P)+sqr(Yins_A-Yins_P)+sqr(Zins_A-Zins_P))*Conf^.altNum/40:6:0);
Writeln(lst,' Out_Prec:',Xout_P*Conf^.altNum/40:6:0,' ',Yout_P*Conf^.altNum/40:6:0,' ',Zout_P*Conf^.altNum/40:6:0,' ');
Writeln(lst,' Ing_Succ:',Xout_A*Conf^.altNum/40:6:0,' ',Yout_A*Conf^.altNum/40:6:0,' ',Zout_A*Conf^.altNum/40:6:0,' ');
{-> Calcolo lunghezza totale }
{-> Divisione in moduli      }
{-> Caricamento del residuo su LEff_.. }
{-> Disegno del canale se non e' vereticale }

end;

{***************************  ScaricaPezzo     *****************************}

Procedure ScaricaPezzoTR(L_eff1,L_eff2:real;Ind_Ult,Ind_ult1:integer);
{ Codifica di un pezzo ad una uscita
  Leff_1 L_eff2 Lunghezza pezzo in ingresso ed uscita
  ind_ult indirizzo di VPezzi[] contenente i dati del pezzo
  ind_ult1 indirizzo di VPezzi[] contenente i dati sulle dimensioni dell`uscita }
begin
end;



end.