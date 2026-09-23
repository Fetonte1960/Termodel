unit CalkAll;
interface
uses
  Sysutils,
  metod10, calchg, Varcarichi, UVariabili, LibreriaGenerale;

  procedure CaricaCapTermAll;

implementation
uses calccd;

procedure CaricaCapTermAll;
var
  i,TrovaZona,k,IndArc:integer;
  VetStrEst:array [1..maxstrutture] of real;
  VetStrInt:array [1..maxstrutture] of real;
  SupPav,SupLord:real;

    procedure CarParInt;
    type Rfi=array[1..MaxFrontiere] of RecFrontInt;
         PRfi=^Rfi;
    var x,i:integer;
        TabFrInt:PRfi;
        T:boolean;
    begin
       if Exist(DriveProg+Ndisegno+'.Div') then
        begin
           New(TabFrInt);
           fillchar(TabFrInt^,sizeof(TabFrInt^),0);
           assign(ffint,DriveProg+Ndisegno+'.Div');
           try
             reset(Ffint);
             i:=0;
             while not (eof(Ffint)) do
             begin
                 i:=i+1;
                 read(Ffint,TabFrInt^[i]);
             end;
             close(Ffint);
           except
             close(Ffint);
           end;
           for x:=1 to MaxStrutture do
           begin
               for i:=1 to MaxFrontiere do
               with TabFrInt^[i] do
                begin
                   T:=false;
                   if CodZona1 > 0 then
                    if (Zone_D^[CodZona1].VecchiaZonalegge10=TrovaZona) then T:=True;
                   if CodZona2 > 0 then
                    if (Zone_D^[CodZona2].VecchiaZonalegge10=TrovaZona) then T:=True;
                 {  if (CodZona1=TrovaZona) or (CodZona2=TrovaZona) then}
                   if T then
                    if CodMuro=X  then VetStrInt[x]:=VetStrInt[x]+SupMuro;
                end;
           end;
           dispose(TabFrInt);
        end;
    end;

    procedure CaricFEst;
    var i,x:integer;
        area,snetta:real;
        Trovato:boolean;
    begin
       for x:=1 to NStrutture do
        begin
           SNetta:=0;
           Trovato:=false;
           for i:=1 to NFrontiere do
            with Frontiere_D^[i]^ do
             begin
                if (CodAmb>=1)and(codamb<=NAmbienti) then
                 if (Ambienti_D^[CodAmb]^.Denom > '') then
                  if (Ambienti_D^[CodAmb]^.Zona in [1..MaxZone]) then
                   if Zone_D^[Ambienti_D^[CodAmb]^.Zona].VecchiaZonalegge10 =TrovaZona then
                    begin
                       if InRange(codesposiz,1,maxesposizioni) then
                        begin
                           if (x=1) then if esposizioni_d^[codesposiz].Inclin = 180 then
                           SupPav:=SupPav+SupMuro*Ambienti_D^[CodAmb]^.AmbientiUguali;
                           { faccio questa controllo per fare un solo passaggio }
                        end;
                       if (CodMuro=X)  then
                        begin
                           Area:=SupMuro;
                           if (CodMuro2<>X)  then Area:=Area-SUPMURO2-SUPFINESTRA-SUPPORTA
                           else Area:=Area-SUPFINESTRA-SUPPORTA;
                           SNetta:=SNetta+Area*Ambienti_D^[CodAmb]^.AmbientiUguali;
                           Trovato:=true;
                        end
                       else
                        if (CodMuro2=X)  then
                         begin
                            SNetta:=SNetta+SupMuro2*Ambienti_D^[CodAmb]^.AmbientiUguali;
                            Trovato:=true;
                         end;
                    end;
             end;
            if Trovato then  VetStrEst[x]:=VetStrEst[x]+SNetta;
        end;
    end;
{MAIN FUNZIONE PRINCIPALE}
begin
   IndArc:=1;
   fillchar(capTermica^,sizeof(capTermica^),0);
   for TrovaZona:=1 to Nzone10 do
   begin
       fillchar(VetStrEst,sizeof(VetStrEst),0);
       fillchar(VetStrInt,sizeof(VetStrInt),0);

       SupPav:=0; SupLord:=0;
       for i:=1 to NAmbienti do
        if (Zone_D^[Ambienti_D^[i]^.Zona].VecchiaZonalegge10=TrovaZona) then
         SupLord:=SupLord+Ambienti_D^[i]^.Superficie*Ambienti_D^[i]^.AmbientiUguali;

       CarParInt;
       CaricFEst;
       { pareti disperdenti }
       for i:=1 to NStrutture do
        begin
           if VetStrEst[i] > 0 then
            begin
               if IndArc < Maxcaptermica then
                with capTermica^[IndArc] do
                 begin
                    CodZona:=TrovaZona;
                    CodStrut:=i;
                    Tipo:=CH7;
                    DescStrut:=strutture_D^[i]^.descr;
                    Sup:=VetStrEst[i];
                    Cp:=CalcCp(i,True);
                    CTot:=Cp*Sup;
                    IndArc:=IndArc+1;
                 end;
            end;
        end;
       { soffitti non disperdenti  }

       if (IndArc < Maxcaptermica) and (Zone10^[TrovaZona].TipoPav in[1..MaxStrutture]) and (SupLord-SupPav > 0.01) then
        with capTermica^[IndArc] do
         begin
            CodZona:=TrovaZona;
            CodStrut:=Zone10^[TrovaZona].TipoPav;
            Tipo:=CH8;
            DescStrut:=strutture_D^[Zone10^[TrovaZona].TipoPav]^.descr;
            Sup:=SupLord-SupPav;
            Cp:=CalcCp(CodStrut,false);
            CTot:=Cp*Sup;
            IndArc:=IndArc+1;
         end;
       { pareti divisorie non disperdenti }

        for i:=1 to NStrutture do
        begin
           if VetStrInt[i] > 0 then
            begin
               if IndArc < Maxcaptermica then
                with capTermica^[IndArc] do
                 begin
                    CodZona:=TrovaZona;
                    CodStrut:=i;
                    Tipo:=CH8;
                    DescStrut:=strutture_D^[i]^.descr;
                    Sup:=VetStrInt[i];
                    Cp:=CalcCp(i,false);
                    CTot:=Cp*Sup;
                    IndArc:=IndArc+1;
                 end;
            end;
        end;
    end;
end;


end.
