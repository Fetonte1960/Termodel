{Unit in cui c'è la procedura del calcolo della Hg: coefficiente di accoppiamento
 termico in regine stazionario.
 Coefficiente usato nel calcolo di confini con il terreno
}

Unit CalcHg;

Interface

Uses
  SysUtils,
  Uvariabili, VarCarichi, Metodl10, LibreriaGenerale;

 function CalcCp(CodStr:integer;Esterno:boolean):real;
 Function ParetIsolata(Cod:integer):Integer;
 function IndLocNRis(Codice:real):integer;


{===========================================================================}

Implementation
uses UFunzioniLegge10 {ex StampCoz};

Function ParetIsolata(Cod:integer):Integer;
var j,IndIs:integer;
begin
   IndIs:=0;
   j:=1;
   repeat
    if Strutture_D^[Cod]^.strati[j].ConduttivitaLineare = 0 then
     Strutture_D^[Cod]^.strati[j].ConduttivitaLineare:=Strutture_D^[Cod]^.strati[j].Conduttanza*Strutture_D^[Cod]^.strati[j].Spessore;
    if (Strutture_D^[Cod]^.strati[j].Spessore > 0) then
    if (Strutture_D^[Cod]^.strati[j].ConduttivitaLineare > 0) and
       (Strutture_D^[Cod]^.strati[j].ConduttivitaLineare < 0.05) then IndIs:=j;
        if IndIs = 0 then j:=j+1;
    until (j > MaxStrati) or (IndIs > 0);
   ParetIsolata:=IndIs;
end;


function CalcCp(CodStr:integer;Esterno:boolean):real;
var ValCp1,ValCp2,D,PCalc,R,risult:real;
    IndMat,UltMat,IndIs,i,j:integer;


function CalcInd(var UltMat:integer):integer;
var Ult:integer;
begin
   Ult:=MaxStrati;
   while (Strutture_D^[CodStr]^.strati[Ult].Spessore=0) and (Ult > 1) do Ult:=Ult-1;
   UltMat:=Ult;
   if (Strutture_D^[CodStr]^.strati[Ult].Spessore < 0.05) and (Ult > 1) then Ult:=Ult-1;
   CalcInd:=Ult;
end;


procedure Cp2(Cod,Iniz:integer; var Cp:real);
Const  W=7.2685E-5;
var j:integer;
    R,C2:real;
begin
   with Strutture_D^[Cod]^ do
   begin
      Cp:=0;
      for j:=Iniz-1 downto 1 do
       begin
        R:=0;
        if strati[j].Spessore <> 0 THEN
        R:=strati[j].ConduttivitaLineare/strati[j].Spessore;
        if R > 1 then exit;
        C2:=strati[j].PesoSpecifico*strati[j].Spessore*strati[j].CaloreSpecifico;
        if not ((R < 0.4) and (strati[j].Spessore <= 0.02)) then
         Cp:=Cp+(sqrt(esp(C2,2)/(1+(esp(W,2)*esp(R,2)*Esp(C2,2)))));
       end;
   end;
end;

function Ps(Cod,initFor:integer):real;
var i,j:integer;
    Ps1,Incr:real;
begin
   if (not Esterno) and (InitFor = 1) then Incr:=0.5
   else Incr:=1;
   Ps1:=0;
   for j:=MaxStrati downto InitFor do
    Ps1:=Ps1+incr*(Strutture_D^[Cod]^.strati[j].PesoSpecifico*Strutture_D^[Cod]^.strati[j].Spessore);
   Ps:=Ps1;
end;

begin
   MassaMuro:=0;
   ValCp1:=10000000;  ValCp2:=10000000;

    with Strutture_D^[CodStr]^ do
     begin
        for i:=1 to MaxStrati do
         if strati[i].ConduttivitaLineare = 0 then strati[i].ConduttivitaLineare:=strati[i].Conduttanza*strati[i].Spessore;
        IndMat:=CalcInd(UltMat);
        IndIs:=ParetIsolata(CodStr);
        if IndIs > 0 then
         begin
            R:=0;
            if strati[UltMat].ConduttivitaLineare<>0 THEN
             R:=strati[UltMat].Spessore/strati[UltMat].ConduttivitaLineare;
            if (R >= 0.4) and (R <= 1) then
             begin
                Cp2(CodStr,IndMat,ValCp2);
                CalcCp:=ValCp2;
              {  writeln(gfor,'isolata - CP  con R >= 0.4 : ',valcp2:10:4);}
                if IndMat > 0 then
                 MassaMuro:=ValCp2/strati[indMat].CaloreSpecifico;
                exit;
             end;
            ValCp1:=Ps(CodStr,IndIs);
          {  writeln(gfor,'isolata - CP1  : ',valcp1:10:4);}
         end
        else ValCp1:=Ps(CodStr,1);
       { writeln(gfor,'non isolata - CP1  : ',valcp1:10:4);}
        D:=0;
        if strati[IndMat].PesoSpecifico <> 0 then
         if (strati[IndMat].ConduttivitaLineare/strati[IndMat].PesoSpecifico) > 0 then
          D:=3.71*sqrt(strati[IndMat].ConduttivitaLineare/strati[IndMat].PesoSpecifico);
       { writeln(gfor,' D  : ',d:10:4);}
        Pcalc:=strati[UltMat].PesoSpecifico;
       { writeln(gfor,' Pcalc (massa volumica)  : ',pcalc:10:4);}
        if UltMat > 1 then
         if (D > strati[UltMat].Spessore) and
            ((D-strati[UltMat].Spessore) > (strati[UltMat-1].Spessore*0.2)) and
            (((strati[UltMat].PesoSpecifico*2) > strati[UltMat-1].PesoSpecifico) or
              (strati[UltMat].PesoSpecifico < (strati[UltMat-1].PesoSpecifico*2)))  then
             Pcalc:=(strati[UltMat].Spessore/(strati[UltMat].Spessore+strati[UltMat-1].Spessore))*strati[UltMat].PesoSpecifico+
                    (strati[UltMat-1].Spessore/(strati[UltMat].Spessore+strati[UltMat-1].Spessore))*strati[UltMat-1].PesoSpecifico;
      {  writeln(gfor,' Pcalc corretto (massa volumica) : ',pcalc:10:4);}
        ValCp2:=Pcalc*D;
     {   writeln(gfor,' CP2 pareti non isolate  ',valcp2:10:4);}
{        if ValCp1 < ValCp2 then CalcCp:=ValCp1*S[UltMat].ConduttivitaLineare
       else CalcCp:=ValCp2*S[UltMat].ConduttivitaLineare;}
        if ValCp1 < ValCp2 then
         begin
            CalcCp:=ValCp1*strati[UltMat].CaloreSpecifico;
            MassaMuro:=ValCp1;
         end
       else
        begin
           risult:= ValCp2*strati[UltMat].CaloreSpecifico;    {kj}
           CalcCp:=risult;
           MassaMuro:=ValCp2;
        end;
      { writeln(gfor,' calore specifico ultimo strato',S[UltMat].CaloreSpecifico:10:4);
       writeln(gfor,' calcCP  ',risult:10:4);}
    end;

end;

function IndLocNRis(Codice:real):integer;
var i:integer;
    Trovato:boolean;
begin
   i:=1;
   repeat
    with Ambienti_D^[i]^ do
     begin
        Trovato:=(Ambienti_D^[i]^.CodNum =floattostr(Codice));
        if not Trovato then i:=i+1;
    end;
   until Trovato or (i > NAmbienti);
  IndLocNRis:=i;
end;




end.
