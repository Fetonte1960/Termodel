UNIT METODL10;

INTERFACE

Uses
  Uvariabili, SysUtils,
  Varcarichi, LibreriaGenerale;

{ ------------------------------------------------------------------------ }
const  parete = 1;
       porta  = 2;
       ponte  = 3;
type
   dati_amb = object

                frontCorr, murocorr, IndEsp_cart, finCorr: integer;

                function SettaMuroCor(i:integer):boolean;
                function SettaFrontCor(i:integer):boolean;
                function CALC_ALFA_F(M:boolean;codM:integer): REAL;
                function HE_F   :real;
                function K_F    :real;
                function FER_F(IndEsp:integer):real;
                function Cod_Esp_A :INTEGER;
                function RagrupEsp:integer;
                function SettaFinCor(i:integer):boolean;
                function SettaEspCor(i:integer):boolean;
                function Descr_fin: string;
                function k_Fin: real;
                Function Fc_Fin: real;
                Function Ff_Fin: real;
                Function CoefTrasp_Fin: real;

   END;

   procedure CALC_FS1(IndE,IndFin,IndPiano:integer;var fo,fa : real;Pareti:boolean;Var Xa:real);

   var  POb_A: ^Dati_amb;

IMPLEMENTATION

   function dati_amb.SettaFrontCor(i:integer):boolean;
   begin
      FrontCorr:=i;
   end;

   function dati_amb.SettaMuroCor(i:integer):boolean;
   begin
      MuroCorr:=i;
   end;

   function PortVal(nstru : integer;var cod_p : integer) : boolean;
   begin
     PortVal := false;
     cod_p := Frontiere_D^[nstru]^.codporta;
     if (Cod_p>0) and (cod_p <=Nporte) then portVal:= true;
   end;

   function Dati_Amb.FER_F(IndEsp:integer):real;
   begin
     if InRange(IndEsp,1,MaxEsposizioni) then
      with esposizioni_D^[indEsp] do
       if inclin = 0 then fer_f := 0.8
       else
        begin
          if inclin = 90 then fer_f := 1
          else fer_f:= 0.9;
        end;
     IndEsp_cart:=indEsp;
   end;

   function Dati_amb.RagrupEsp:integer;
   var direzLoc : real;
       inddir   : integer;
       temp     : real;
   begin
      RagrupEsp:=0;
      with esposizioni_D^[pob_a^.IndEsp_cart] do
       begin
          if inclin = 0 then RagrupEsp := 1
          else
           begin
            direzLoc := orient+22.5;
            if direzLoc >= 360 then direzLoc := direzLoc -360;
            temp :=45.;
            inddir := trunc (direzLoc /temp);
            case inddir of
             0:RagrupEsp :=6;
             1:RagrupEsp :=5;
             2:RagrupEsp :=4;
             3:RagrupEsp :=3;
             4:RagrupEsp :=2;
             5:RagrupEsp :=3;
             6:RagrupEsp :=4;
             7:RagrupEsp :=5;
            end;
           end;
       end;
   end;

   function DATI_AMB.Cod_Esp_A :INTEGER;
   begin
    COD_eSP_a := Pob_A^.RagrupEsp;
   end;

   function dati_amb.CALC_ALFA_F(M:boolean;codM:integer): REAL;
    { m = true x dire che e un muro }
    var cod_S : integer;
        Color:string;
    begin
       CALC_ALFA_F :=0;
       if M then
        begin
          Color:=Strutture_D^[codm].colore
        end
       else
        begin
           if PortVal(frontCorr,cod_s) then
           Color:=Porte_D^[Cod_s].colore
        end;
       Color:=formst(color);
       if color<>'' then
        begin
           case color[1] of
            'C' : CALC_ALFA_F := 0.3;
            'M' : CALC_ALFA_F := 0.6;
            'S' : CALC_ALFA_F := 0.9;
            ELSE CALC_ALFA_F  := 0.3;
           end;
        end;
    end;

    Function Dati_amb.Descr_fin : string;
    begin
     descr_fin :=Finestre_D^[finCorr]{.fin_cart}.denom;
    end;

    function Dati_Amb.HE_F   :real;
    var CODMURO : INTEGER;
    begin
      he_f := 0;
      he_f := k10^[MuroCorr].he;
    end;

    function dati_amb.K_F    :real;
    var codMuro : integer;
    begin
     k_f := 0;
     k_f := k10^[MuroCorr].ka;  {ho fatto questa modifica per usare muro2}
    end;

    function dati_amb.SettaFinCor(i:integer):boolean;
    begin
      FinCorr:=i;
    end;

    function dati_amb.SettaEspCor(i:integer):boolean;
    begin
      IndEsp_cart:=i;
    end;

    Function dati_amb.k_Fin     : real;
    var k_not, kt, km, rt: real;
    const t1=43200.0;
          t2=43200.0;
    begin
       result := finestre_d^[finCorr].TrasmittL10;
       exit;
    //*Fabio - Parte modificata da rivedere se si vuole attivare il k Medio tra giorno e notte
       if finestre_d^[finCorr]{.fin_cart}.lineak = 0 then
       begin
         {k_not :=finestre_d^[finCorr].fin_l10.trasm;}
         {rt:=finestre_d^[finCorr].fin_l10.dr;}
       end
       else
       begin
        { k_not :=finestre_d^[finestre_d^[finCorr].fin_cart.lineak].fin_l10.trasm;
         rt:=finestre_d^[finestre_d^[finCorr].fin_cart.lineak].fin_l10.dr;}
       end;
       if rt>0 then
       begin
         kt:=1/(1/(K_not)+rt);
         km:=((t1*k_not)+(t2*kt))/(t1+t2);
         k_Fin:=km;
       end
       else
       k_fin:=k_not;
    end;

    Function Dati_amb.Fc_Fin    : real;
    begin
      { if finestre_d^[finCorr].fin_cart.lineak = 0 then}
      //Emanuela e Fabio 25-Giu-2004 Sostituita la variabile Shadingsc con ShadingSchermo
        Fc_Fin :=finestre_d^[finCorr]{.fin_cart}.ShadingSchermo
      { else  Fc_Fin :=finestre_d^[finestre_d^[finCorr].fin_cart.lineak].fin_cart.Shedingsc;}
    end;

    Function Dati_amb.Ff_Fin    : real;
    begin
    {   if finestre_d^[finCorr].fin_cart.lineak = 0 then}
         Ff_Fin :=finestre_d^[finCorr]{.fin_cart}.percvetr/100
    {   else  Ff_Fin :=finestre_d^[finestre_d^[finCorr].fin_cart.lineak].fin_cart.percvetr/100;}
    end;

    Function Dati_amb.CoefTrasp_Fin : real;
    begin
    {   if finestre_d^[finCorr].fin_cart.lineak = 0 then}
      //Emanuela e Fabio 25-Giu-2004 Sostituita la variabile ShadingV con ShadingVetro
        CoefTrasp_Fin :=finestre_d^[finCorr]{.fin_cart}.ShadingVetro
     {  else   CoefTrasp_Fin :=finestre_d^[finestre_d^[finCorr].fin_cart.lineak].fin_cart.shedingV;}
    end;


    {*****************************************************************************}
    {***                            Procedure CALC_FS1                         ***}
    {*****************************************************************************}
    procedure CALC_FS1(IndE,IndFin,IndPiano:integer;var fo,fa : real;Pareti:boolean;Var Xa:real);

        function RagrupEsp(IndE:integer):integer;
        var Ang:real;
            Esp:integer;
        begin
          ang:=Esposizioni_D^[IndE].Orient;

          repeat
              if (Ang < -22.5) then Ang:=Ang+360;
              if (Ang > 337.5) then Ang:=Ang-360;
          until (ANG >= -22.5) AND (ANG <= 337.5);

          if ( Ang >=-22.5) AND (Ang <= 22.5)   then  Esp:=5;  {NORD}
          if ( Ang > 22.5)  AND (Ang <= 67.5 )  then  Esp:=4;  {NORD-EST}
          if ( Ang > 67.5 ) AND (Ang <= 112.5 ) then  Esp:=3;  {EST}
          if ( Ang > 112.5) AND (Ang <= 157.5 ) then  Esp:=2;  {SUD-EST}
          if ( Ang > 157.5) AND (Ang <= 202.5 ) then  Esp:=1;  {SUD}
          if ( Ang > 202.5) AND (Ang <= 247.5 ) then  Esp:=2;  {SUD-OVEST}
          if ( Ang > 247.5) AND (Ang <= 292.5 ) then  Esp:=3;  {OVEST}
          if ( Ang > 292.5) AND (Ang <= 337.5 ) then  Esp:=4;  {NORD-OVEST}
          RagrupEsp:=Esp;
        end;

        procedure TrovaInd(var Esp,IndF:integer);
        var Trovato:boolean;
            i:integer;
        begin
          Indf:=0; Exit;

          Esp:=RagrupEsp(IndE);

          i:=1;
          repeat
             Trovato:=formst(Facciata^[i].Cod)=formst(Esposizioni_d^[IndE].CodOst);
             if not Trovato then i:=i+1;
          until Trovato or (i > MaxFac);

          if Trovato then IndF:=i
          else IndF:=0;

        end;


        type
          VetInd=array[1..5] of real;
          Cube=array[1..3,1..4,1..5] of real;

        CONST
          IndOriz:VetInd=(0.8,0.6,0.4,0.2,0);
          IndVert:VetInd=(0.5,0.3,0.2,0.1,0);

          C:array[1..5,1..4] of real =((1.0,1.0,1.0,1.0),(0.17097E-1,0.189113E-2,-0.13872E-1,-0.34286E-2),
                                       (-0.7766E-2,-0.38336E-2,0.38965E-3,0),(0.33599E-3,0.137790E-3,-0.8506E-4,0),
                                       (-0.4303E-5,-0.13335E-5,0.21213E-5,0));

          C_OR:Cube = (((1.0,1.0,1.0,1.0,1.0),(-0.4126E-1,-0.7187E-2,-0.8504E-1,-0.1804,-0.6415),      {sud}
                        (0.9340E-3,-0.1591,-0.8706E-2,-0.2463,0.57022),(0.0,0.1062,-0.4511E-2,0.2049,-0.3551)),

                       ((1.0,1.0,1.0,1.0,1.0),(-0.2703E-1,-0.8504E-1,-0.8111E-1,-0.8797E-1,-0.3974),   {sud-est,sud-ovest}
                        (-0.3221E-1,0.8707E-2,-0.9664E-1,-0.4005,-0.1342),(-0.1001E-2,-0.4511E-2,-0.3005E-2,0.2075,0.8774E-1)),

                       ((1.0,1.0,1.0,1.0,1.0),(-0.2131E-1,-0.931E-1,-0.609E-1,-0.2008,-0.4548),        {est-ovest}
                        (-0.7773E-1,-0.1002,-0.3683,-0.2141,0.1615),(-0.1173E-2,-0.7704E-2,0.2085,0.9273E-1,-0.1312)));

          C_Vr:Cube = (((1.0,1.0,1.0,1.0,1.0),(0.4520E-2,-0.2065E-1,-0.10360,-0.22198,-0.3830),    {sud}
                        (-0.8046E-1,-0.7951E-1,-0.7726E-1,0.4278E-2,0.9997E-1),(0,0,0,0,0)),

                       ((1.0,1.0,1.0,1.0,1.0),(0.4590E-2,0.8135E-1,-0.873E-1,-0.2547,-0.4708),     {sue-est,sud-ovest}
                        (-0.3949,-0.6182,-0.5039,-0.3510,-0.5673E-1),(0.2102,0.3203,0.31744,0.2532,0.8298E-1)),

                       ((1.0,1.0,1.0,1.0,1.0),(-0.819E-1,0.876E-1,-0.2014,-0.3205,-0.7343),        {est,ovest}
                        (-0.4110,-0.7657,-0.6286,-0.4229,0.3543),(-0.2133,0.5333,0.4800,0.3733,0)));

        function InterpC(indE,IndCiclo:integer;rap:real;vet:vetInd;C_tab:Cube):real;

        var IndPar:integer;
            x1,x2:real;

        begin
           IndPar:=5;
           while (Rap > Vet[IndPar]) and (IndPar > 1 ) do IndPar:=IndPar-1;
           if (indPar < 5) and (Rap < Vet[IndPar] )then
            begin
               x1:=vet[IndPar]-rap;
               x2:=vet[IndPar+1]-rap;
               if X1 > x2 then IndPar:=IndPar+1;
            end;
           InterpC:=C_Tab[IndE,IndCiclo,IndPar];
        end;


        VAR
          i,IEsp,IndF:integer;
          b,Param,Fa1,Fa2,x:real;
          Altez,AltMed:real;
          PassVert,PassOriz:boolean;
        BEGIN
           x:=0; fo:=1; fa:=1; fa1:=1;  Fa2:=1; Xa:=0;
           PassVert:=false; PassOriz:=false;

           TrovaInd(IEsp,indF);

           if (IEsp in [1..4]) and (IndF>0) then
            begin
               if (IEsp < 4) then
                begin
                   {aggetti orizzontali}
                   if (formst(Facciata^[indF].Orizzontale) > '') or (Finestre_D^[IndFin]{.fin_cart}.LOrizz > 0) then
                   BEGIN
                   if Pareti then
                    begin
                       if CalcEsp^[IndE].Alt > 0 then
                        begin
                           X:=Facciata^[IndF].ProfOrizz/CalcEsp^[IndE].Alt;
                           param:=Facciata^[IndF].DistOrizz/CalcEsp^[IndE].Alt;
                        end
                       else
                        begin
                           X:=0;
                           Param:=0;
                        end;
                    end
                   else
                    begin
                       if Finestre_D^[IndFin]{.fin_cart}.Altezza > 0 then
                        begin
                           X:=Finestre_D^[IndFin]{.fin_cart}.LOrizz/Finestre_D^[IndFin]{.fin_cart}.Altezza;
                           param:=Finestre_D^[IndFin]{.fin_cart}.DOrizz/Finestre_D^[IndFin]{.fin_cart}.Altezza;
                        end
                       else
                        begin
                           X:=0;
                           Param:=0;
                        end;
                    end;

                   if X > 1 then X:=1; {correzione fatta su direttiva data da fiabane}

                   Fa1:=1; {C_Or(IEsp,1,1);} { sono tutti uguali a 1 }
                   for i:=2 to 4 do Fa1:=Fa1+InterpC(IEsp,i,param,IndOriz,C_Or)*Esp(x,i-1);
                   PassOriz:=true;

                   END;
                   {aggetti verticali}
                   if (formst(Facciata^[indF].LateraleLeft) > '') or (formst(Facciata^[indF].LateraleDestro) > '') or
                      (Finestre_D^[IndFin]{.fin_cart}.LVertDX > 0) or (Finestre_D^[IndFin]{.fin_cart}.LVertSX > 0) then
                   BEGIN
                   PassVert:=true;
                   if Pareti then
                    begin
                       if (CalcEsp^[IndE].Alt > 0) and (CalcEsp^[IndE].Sup > 0) then
                        begin
                           X:=0;  Param:=0;
                           B:=CalcEsp^[IndE].Sup/CalcEsp^[IndE].Alt;
                           if (formst(Facciata^[indF].LateraleLeft) > '') and (formst(Facciata^[indF].LateraleDestro) > '') then
                           begin
                              if Facciata^[IndF].ProfDestro > Facciata^[IndF].ProfLeft then
                               begin
                                  X:=Facciata^[IndF].ProfDestro/B;
                                  Param:=Facciata^[IndF].DistDestro/B;
                               end
                              else
                               begin
                                  X:=Facciata^[IndF].ProfLeft/B;
                                  Param:=Facciata^[IndF].DistLeft/B;
                               end;
                           end
                           else
                            begin
                              if formst(Facciata^[indF].LateraleDestro) > '' then
                               begin
                                  X:=Facciata^[IndF].ProfDestro/B;
                                  Param:=Facciata^[IndF].DistDestro/B;
                               end
                              else
                               if formst(Facciata^[indF].LateraleLeft) > '' then
                                begin
                                   X:=Facciata^[IndF].ProfLeft/B;
                                   Param:=Facciata^[IndF].DistLeft/B;
                                end;
                            end;

                           if X > 1 then X:=1; {correzione fatta su direttiva data da fiabane}
                           Fa2:=1;
                           for i:=2 to 4 do Fa2:=Fa2+InterpC(IEsp,i,param,IndVert,C_Vr)*Esp(x,i-1);
                        end;
                    end
                   else
                    begin
                       if Finestre_D^[IndFin]{.fin_cart}.Larghezza > 0 then
                        begin
                           if Finestre_D^[IndFin]{.fin_cart}.LVertDX > Finestre_D^[IndFin]{.fin_cart}.LVertSX then
                            begin
                               X:=Finestre_D^[IndFin]{.fin_cart}.LVertDX/Finestre_D^[IndFin]{.fin_cart}.Larghezza;
                               Param:=Finestre_D^[IndFin]{.fin_cart}.DVertDX/Finestre_D^[IndFin]{.fin_cart}.Larghezza;
                            end
                           else
                            begin
                               X:=Finestre_D^[IndFin]{.fin_cart}.LVertSX/Finestre_D^[IndFin]{.fin_cart}.Larghezza;
                               Param:=Finestre_D^[IndFin]{.fin_cart}.DVertSX/Finestre_D^[IndFin]{.fin_cart}.Larghezza;
                            end;
                        end
                       else
                        begin
                           X:=0;
                           Param:=0;
                        end;

                       if X > 1 then X:=1; {correzione fatta su direttiva data da fiabane}
                       Fa2:=1; {C_Vr(IEsp,1,1);} { sono tutti uguali a 1 }
                       for i:=2 to 4 do Fa2:=Fa2+InterpC(IEsp,i,param,IndVert,C_Vr)*Esp(x,i-1);
                    end;
                   END;
                   if (PassVert and PassOriz) then
                    begin
                       if fa1 > fa2 then fa:=fa2
                       else fa:=Fa1;
                    end
                   else
                    begin
                       if PassOriz then fa:=fa1;
                       if Passvert then fa:=fa2;
                    end;

                   if fa > 1 then fa:=1;
                   if fa < 0 then fa:=0;

                end;
               {ostruzioni esterne}
               if formst(Facciata^[indF].Frontale) > '' then
                begin
                   fo:=0.25;
                   if Pareti then Xa:=Facciata^[IndF].ang
                   else
                    begin
                       Altez:=EPt^[IndPiano].ZMax-EPt^[IndPiano].ZMin;
                       if (Altez-(Finestre_D^[IndFin].Altezza+1)) > 0 then
                         AltMed:=EPt^[IndPiano].ZMin+Finestre_D^[IndFin].Altezza/2+1
                       else AltMed:=EPt^[IndPiano].ZMax-Finestre_D^[IndFin].Altezza/2;
                       if Facciata^[IndF].DistFront > 0 then Xa:=ArcTan((Facciata^[IndF].ProfFront-AltMed)/Facciata^[IndF].DistFront)
                       else Xa:=0;
                       Xa:=Xa*180/pi;
                    end;
                   if (Xa>=0) and (Xa<=30) then
                    begin
                       fo:=C[1,IEsp];
                       for i:=2 to 5 do fo:=fo+C[i,IEsp]*Esp(xa,i-1);
                    end;

                   if fo > 1 then fo:=1;
                   if fo < 0 then fo:=0.25;

                   if Xa > 30 then fo:=0.25;
                end;
            end;
           if Pareti then
            begin
               RisFc^[indE].Fo:=Fo;
               RisFc^[indE].FaOr:=Fa1;
               RisFc^[indE].FaVe:=Fa2;
            end;
        END;

END.

