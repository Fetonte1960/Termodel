
Unit CalcVent;

INTERFACE

Uses
  uVariabili,Varcarichi,
  metod10, SysUtils, procle13,Utireport, LibreriaGenerale, URicercaDati;

procedure StampCalcVent(var npag,nr:smallint);
// Emanuela DPR 192
procedure DatiVentZona;

{ ************************************************************************* }

IMPLEMENTATION


function AltEdif:real;
var AltMax,AltMin:real;
    i,k:smallint;
begin
   ALTMIN:=1000;
   ALTMAX:=-1000;
   k:=UltimoPiano;
   for i:=1 to k do
    begin
       if AltMin > EPt^[I].ZMin then AltMin:=EPt^[I].ZMin;
       if AltMax < EPt^[I].ZMax then AltMax:=EPt^[I].ZMax;
    end;
   AltEdif:=AltMax-AltMin;
end;

procedure StampCalcVent(var npag,nr:smallint);

const
  TabA1:array[1..3,1..3] of real=((0.0076,0.0475,0.19),(0.0146,0.0913,0.365),(0.0332,0.2075,0.83));
  TabB1:array[1..3] of real=(0.91,0.69,0.42);
  TabA2:array[1..3,1..3] of real=((0.0526,0.0404,0.028),(0.0263,0.0202,0.014),(0.1526,0.117,0.0814));
  TabB2:array[1..3] of real=(1,0.69,0);
  TabRic:array[1..3,1..3] of real=((1.2,0.7,0.5),(0.9,0.6,0.5),(0.6,0.5,0.5));

var Ind,Ind1,Pag,i:smallint;
    H,A1,A2,B1,B2,TotaleK:real;
    TipoNat,TipoScher,x:smallint;
    Tac,Tsp,Nf,Nx,No:real;

begin
   VentTotZona:=0;
   VentNatZona:=0;
   Nf:=0;
   Nx:=0;

   Zone10^[zonacalc].CalcAnal:= 'N' ; // Diego 5-7-2004 disattivato calcolo analitico

   if formst(Zone10^[zonacalc].CalcAnal) = 'S'then
    begin
       A1:=1;  A2:=1;
       B1:=1;  B2:=1;

       TotaleK:=0;
       fillchar(Numf^,sizeof(Numf^),0);
       fillchar(Nump^,sizeof(Nump^),0);
       for i:=1 to NFrontiere do
        begin
        //if (zone_d^[Ambienti_D^[CodAmb]^.Zona].ZonaLegge10=ZonaCalc) then

           with Frontiere_D^[i]^ do
            // Emanuela 21/4/2006 messo anche che sia lo stesso alloggio
            if ((Ambienti_D^[CodAmb]^.Z10 = ZonaCalc) and
                 (CompareStr(uppercase(DescGen1^[gencor].Descrizione), uppercase(Impianto_d^[CodiceImpianto(Ambienti_D^[CodAmb].Impianto)].GenInvt)) = 0)) then
             begin
                if (InRange(CodFinestra,1,MaxFinestre)) then Numf^[CodFinestra]:=Numf^[CodFinestra]+(ModFinestra*
                                                                                 Ambienti_D^[CodAmb]^.AmbientiUguali);
                if (InRange(CodPorta,1,MaxPorte)) then Nump^[CodPorta]:=Nump^[CodPorta]+(ModPorta*
                                                                        Ambienti_D^[CodAmb]^.AmbientiUguali);
             end;
        end;


       for i:=1 to MaxFinestre do
        with St1Loc^ do
         if Numf^[i] > 0 then
          begin
             cod:=i;
             desc:=Finestre_D^[i]{.fin_cart}.denom;
             Num:=Numf^[i];
             if finestre_d^[i]{.fin_cart}.Lineak = 0 then
              begin
                { Lun:=finestre_d^[i].Fin_l10.LungCass;
                 V:=finestre_d^[i].Fin_l10.PermCass;
                 m:=finestre_d^[i].Fin_l10.PermSerr;}
                 Lun:=finestre_d^[i].LUNGHEZZACASSONETTO;
                 V:=finestre_d^[i].PERMEABILITACASSONETTO;
                 m:=finestre_d^[i].PERMEABILITASERRAMENTO;
              end
             else
              begin
                { Lun:=finestre_d^[finestre_d^[i].fin_cart.lineak].fin_l10.lungcass;
                 V:=finestre_d^[finestre_d^[i].fin_cart.lineak].fin_l10.permcass;
                 M:=finestre_d^[finestre_d^[i].fin_cart.lineak].fin_l10.permserr;}
                 Lun:=finestre_d^[finestre_d^[i]{.fin_cart}.lineak].LUNGHEZZACASSONETTO;
                 V:=finestre_d^[finestre_d^[i]{.fin_cart}.lineak].PERMEABILITACASSONETTO;
                 m:=finestre_d^[finestre_d^[i]{.fin_cart}.lineak].PERMEABILITASERRAMENTO;
              end;
             Ltot:=Num*Lun;
             v_l:=V*LTot;
             ArUn:=Finestre_D^[i]{.fin_cart}.SuperfUnit;
             ArTot:=ArUn*Num;
             m_a:=M*ArTot;
             Ktot:=V_L+M_A;
             TotaleK:=TotaleK+Ktot;
          end;

       for i:=1 to MaxPorte do
        with St1Loc^ do
         if NumP^[i] > 0 then
          begin
             cod:=i;
             desc:=Porte_D^[i].denom;
             Num:=NumP^[i];
             Lun:=0;
             Ltot:=0;
             V:=0;
             v_l:=0;
             ArUn:=Porte_D^[i].SuperfUnit;
             ArTot:=ArUn*Num;
             m:=Porte_D^[i].Permaria;
             m_a:=M*ArTot;
             Ktot:=M_A;
             TotaleK:=TotaleK+Ktot;
       end;


       //Ind:=pos_combo(drivecombo,'Fabbricato','codub',Prog^.codub);
       Ind := IndFabbricatoCodUb(Prog^.codub);
       Ind1:=2;

       if VELOCITAVENTO > 5 then Ind1:=3;
       if VELOCITAVENTO < 2 then Ind1:=1;
       if InRange(ind,1,3) then
        begin
           A1:=tabA1[ind,ind1];
           B1:=Tabb1[ind];
        end;

       //Ind:=pos_combo(drivecombo,'Fabbricato','CodPerm',Prog^.CodPerm);
       Ind := IndFabbricatoSerram(Prog^.CodPerm);
       Ind1:=2;

       if TempStag > 10 then Ind1:=3;
       if TempStag < 7  then Ind1:=1;
       if InRange(ind,1,3) then
        begin
           A2:=tabA2[ind,ind1];
           B2:=Tabb2[ind];
        end;

       H := AltEdif;
       // H:=Prog^.AltPianoLorda;


       with St2Loc^ do
        begin
        {Pv} R1:=A1*Esp(H,B1);
        {Pc} R2:=A2*Esp(H,B2);
        {Dp} R3:=sqrt((R1*R1)+(R2*R2));
        {Po} R4:=(R3/VolumeZona)*(TotaleK);
        {inf}R5:=(R4*VolumeZona)/3600;      {m3/s}
           VentNatZona:=R5/VolumeZona;      {vol/s}
           HvZona:=1000*1.2*R5;
        end;

     end;
{   else
    begin}
       //TipoNat:=pos_combo(drivecombo,'zone10','ClSerram',Zone10^[zonacalc].ClSerram);

       TipoNat:=1 ;//Diego 5-7-2004 disattivato calcolo analitico

       if TipoNat = 1 then
       begin
           VentNatZona:=VentNatZona+(Zone10^[zonacalc].PortNat/3600);  {Vol/s}
           HvZona:=1000*1.2*(VentNatZona*VolumeZona);         {m3/s}
           Nx:=(Volumezona*Zone10^[zonacalc].PortNat)/3600;                  {Vol/h}
       end
       else
        begin
           if formst(Zone10^[zonacalc].CalcAnal) <> 'S'then
           begin
           //TipoSCher:=pos_combo(drivecombo,'Fabbricato','Tiposchermo',Prog^.Tiposchermo);
           TipoSCher := IndFabbricatoSchermo(Prog^.Tiposchermo);
           if InRange(TipoScher,1,3) and InRange(TipoNat,2,4) then
            begin
               TipoNat:=TipoNat-1;
               VentNatZona:=(TabRic[TipoScher,tiponat]/3600);   {Vol/s}
               HvZona:=1000*1.2*(VentNatZona*VolumeZona);        {m3/s}
               St3Loc^.schermo:=Prog^.Tiposchermo;
               St3Loc^.ClSer:=Zone10^[zonacalc].ClSerram;
               St3Loc^.Ric:=TabRic[TipoScher,TipoNat];             {vol/h}
             end;
           end;
        end;
{    end;}

    VentTotZona:=VentNatZona*VolumeZona;

    with Zone10^[zonacalc] do
     begin
        Tac:=(OreOn*3600);
        Tsp:=86400-Tac;
        Nf:=(PortMec/3600);                  {Vol/s}
        No:=VentNatZona;                     {Vol/s}
        Nx:=VMVolImpOn/3600;                 {Vol/s}

        if OreOn > 0 then
         begin
            VentTotZona:=(VolumeZona*(No*Tsp+(Nf+Nx)*Tac))/(Tac+Tsp); {m3/s}
            if EtaRecup/100 > 0 then // Poichè EtaRecupero è espresso in % divido x 100
             begin
               if OreOn = 24 then HvZona:=1000*1.2*(Nf*(1-EtaRecup/100)+Nx)*Volumezona
               else HvZona:=(1000*1.2*Volumezona*((Nf*(1-EtaRecup/100)+Nx)*(Tac+No*Tsp)))/(Tac+Tsp);
             end
            else HvZona:=1000*1.2*VentTotZona;        {m3/s}
            St2Loc^.R1:=PortMec;                         {vol/h}
            St2Loc^.R2:=VMVolImpOn;                      {vol/h}
            St2Loc^.R3:=OreOn;
            St2Loc^.R4:=EtaRecup; // non lo divido per 100 poichè deve essere stampato il valore inserito in %
        end;
     end;

    if VolumeZona <> 0 then St2Loc^.R1:=(VentTotZona*3600)/VolumeZona   {vol/h}
    else St2Loc^.R1:=0;

    VentForzZona^[ZonaCalc].port:=St2Loc^.R1;

    St2Loc^.R2:=HvZona;

    prn_totH^.HVent:=HvZona;

    // -----------------------------------------------
    // Stampa Tabella
    // RIEPILOGO DATI DI VENTILAZIONE ED INFILTRAZIONI
    // -----------------------------------------------
    Wrep_str('COD_ZONA',    CodiceZona_D(zone10^[zonacalc].descr));
    Wrep_str('NOME_ZONA',   Zone10^[zonacalc].descr);
    W_reale('VENT_NATURALE', Zone10^[zonacalc].PortNat, 2);             // Ventilazione naturale zona {Vol/s}
    W_reale('RICAMB_IMP_VENTIL', Zone10^[zonacalc].PortMec, 2);         // PortMec {vol/h}
    W_reale('RICAMBNAT_IMPV_ON', Zone10^[zonacalc].VMVolImpOn, 2);      // VMVolImpOn
    W_reale('ORE_ACCENSIONE', Zone10^[zonacalc].OreOn, 0);              // OreOn
    W_reale('ETA_RECUPERATORE', Zone10^[zonacalc].EtaRecup, 0);         // EtaRecup


   {dispose(St1);
   dispose(St2);
   dispose(St3);
   dispose(NumP);
   dispose(NumF); }
end;

{-----------------------------------------------------------------------------
  Procedure: DatiVentZona
  Author:    e.diquattro
  Date:      16-dic-2005
  Arguments: None
  Result:    None

  Cosa fa: DPR 192 stampa i dati di ventilazione della zona
-----------------------------------------------------------------------------}
procedure DatiVentZona;
begin
    // -----------------------------------------------
    // Stampa Tabella
    // RIEPILOGO DATI DI VENTILAZIONE ED INFILTRAZIONI
    // -----------------------------------------------
    Wrep_str('COD_ZONAV',         CodiceZona_D(zone10^[zonacalc].descr));
    Wrep_str('NOME_ZONAV',        Zone10^[zonacalc].descr);              
    W_reale('VENT_NATURALEV',     Zone10^[zonacalc].PortNat, 2);         // Ventilazione naturale zona {Vol/s}
    W_reale('RICAMB_IMP_VENTILV', Zone10^[zonacalc].PortMec, 2);         // PortMec {vol/h}
    W_reale('RICAMBNAT_IMPV_ONV', Zone10^[zonacalc].VMVolImpOn, 2);      // VMVolImpOn
    W_reale('ORE_ACCENSIONEV',    Zone10^[zonacalc].OreOn, 0);           // OreOn
    W_reale('ETA_RECUPERATOREV',  Zone10^[zonacalc].EtaRecup, 0);        // EtaRecup
end;

end.

