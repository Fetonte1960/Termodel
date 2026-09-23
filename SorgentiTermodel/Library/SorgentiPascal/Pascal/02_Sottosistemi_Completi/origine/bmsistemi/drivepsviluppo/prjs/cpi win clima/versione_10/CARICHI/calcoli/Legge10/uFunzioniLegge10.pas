unit UFunzioniLegge10;

interface

uses
 Sysutils, dbtables, Dialogs, Classes,
 Uvariabili, Varcarichi, Metod10, utireport, udb,
 LibreriaGenerale;

Procedure stampadaticlimatici;
procedure InitVariab;
procedure dativento;

implementation

procedure InitVariab;
Var i:integer;
    y:integer;
begin
  fillchar(energm^,       sizeof(energm^),0);
  fillchar(generat^,      sizeof(generat^),0);
  fillchar(Qi^,           sizeof(Qi^),0);
  fillchar(Q^,            sizeof(Q^),0);
  fillchar(MatQhr^,       sizeof(MatQhr^),0);
  fillchar(MatQhr24^,     sizeof(MatQhr24^),0);
  fillchar(MatQhvs^,      sizeof(MatQhvs^),0);
  fillchar(IndMese^,      sizeof(IndMese^),0);
  fillchar(VentForzZona^, sizeof(VentForzZona^),0);  {stampa relazione ventilazione forzata }

  StampatoGen := false;
  y:=1;
  for i:=pdati10.InizRisc to 12 do
   begin
      IndMese^[y]:=i;
      y:=y+1;
   end;
  for i:=1 to pdati10.FinRisc do
   begin
      IndMese^[y]:=i;
      y:=y+1;
   end;
  MesiRisc:=y-1;
  Flag10:=true;
  MeseMagIns:=0;
  TotQs:=0;
  Toth2o:=0;
  MassaEdif:=0;
end;

function cercaprov(prov:string;var vvent:real;var zv:smallint):smallint;
var
  trovato:boolean;
  i,j:smallint;
  PROVA,PROVB:STRING;
begin
  i:=0;
  prova:=formst(prov);
  repeat
    i:=i+1;
    provb:=formst(prv^[i].nome);
    trovato:=prova=provb;
  until trovato or (i=maxlung);

  if trovato then
  begin
    vvent:=prv^[i].omega;
    //zv:=prv^[i].zv;
    zv:=Prog^.Zonavent;
    cercaprov:=prv^[i].indrad;
  end
  else
  begin
    //writemessage('temperatura provincia non trovata',39);
    MessageDLG('temperatura provincia non trovata', mtInformation, [mbOK], 0);
  end;
end;


procedure dativento;
const zvconst:array['A'..'E',1..9] of smallint=((3,2,1,1,2,2,3,3,4),
                                               (2,0,1,2,2,3,3,4,4),
                                               (3,0,2,2,3,3,3,4,4),
                                               (3,0,3,3,3,4,4,4,4),
                                               (4,0,3,3,3,4,4,4,4));

      constc:array[1..4,1..4] of real=((1,1.78,2.78,4),
                                       (0.562,1,1.56,2.25),
                                       (0.36,0.64,1,1.44),
                                       (0.25,0.445,0.694,1));
var c1,c2,indp,zonadivento:smallint;
    c3,vven:real;
begin
   indp:=cercaprov(prog^.comunerif,vven,zonadivento);
  if formst(prog^.comune)<>formst(prog^.comunerif) then
  begin
  c2:=2;
  if prog^.distmar<=20 then c2:=1;
  if (prog^.distmar>20) and (prog^.distmar<=40) and (prog^.regvento[1]='A') then c2:=2;
  if ((prog^.distmar>20) and(prog^.regvento<>'A')) or ((prog^.regvento='A') and (prog^.distmar>40)) then
  begin
    if (prog^.altcom<=300) then c2:=3;
    if (prog^.altcom>300) and  (prog^.altcom<=500) then c2:=4;
    if (prog^.altcom>500) and  (prog^.altcom<=800) then c2:=5;
    if (prog^.altcom>800) and  (prog^.altcom<=1200) then c2:=6;
    if (prog^.altcom>1200) and (prog^.altcom<=1500) then c2:=7;
    if (prog^.altcom>1500) and (prog^.altcom<=2000) then c2:=8;
    if (prog^.altcom>2000) Then c2:=9;
  end;

  c1:=zvconst[upcase(prog^.regvento[1]),c2];
  c3:=constc[zonadivento,c1];
  velocitavento:=vven*c3;
  end
  else
  velocitavento:=vven;
end;


Procedure stampadaticlimatici;
type dgen=record
               com: string[20];
               alt,
               lat,
               theta:real;
               regven:string[1];
               zonaven:smallint;
               distmar,
               velven:real;
          end;
      eldgen=array[1..3] of dgen;

      temprad=record
                 descr: string[40];
                 tr:tabdatclim;
              end;
      eltera=array[1..7] of temprad;

var vven:real;
    indp,Ind:smallint;
    {datst:^eldgen;}
    zonadivento:smallint;
    {tera:^eltera;}
    gradiente:real;
    i,j:INTEGER;
const
    elgrad:array[1..5] of real =(1/178,1/200,1/147,1/174,1/192);
      procedure datitemperatura;
      var i, j, k:integer;
          f:file of RecTempProv;
          ListaClass: TStringList;
          Trovato: Boolean;
          ClassEdif, DestEdif: String;
      begin
        indp:=cercaprov(prog^.comunerif,vven,zonadivento);
        TempStag:=0;
        // 21/12/2004 Emanuela commentata perchè non ha senso
        //prog^.altcom:=tempmed^[indp].altitudine;
        for i :=1 to 12 do
        //tempestmed^[i]:=tempmed^[indp].datc[i]-((prog^.altcom-prog^.altitudine)*gradiente);

        // o5-o7-2oo4 Emanuela Correzione valori altitudine località - prov di riferimento

        tempestmed^[i]:=tempmed^[indp].datc[i]-((prog^.altcom-prog^.AltProv)*gradiente);
        for i :=1 to 12 do
         if IndMese^[i] > 0 then TempStag:=TempStag+tempestmed^[IndMese^[i]];

        TempStag:=TempStag/MesiRisc;

        for i:=1 to 12 {mesirisc_st} do W_Mesi12L10_real(i,'T',tempestmed^[i],1);

        {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
         ListaClass := TStringList.Create;
         for j := 1 to NZone11 do
         begin
           if ListaClass.Count = 0 then ListaClass.Add(Zone11^[j].Classif)
           else
           begin
             Trovato := False;
             for k := 0 to ListaClass.Count - 1 do
               if ListaClass[k] = Zone11^[j].Classif then Trovato := True;
             if Not Trovato then ListaClass.Add(Zone11^[j].Classif);
           end;
         end;
         ClassEdif := '';
         for j := 0 to ListaClass.Count - 1 do
         begin
           if (j <> 0) then ClassEdif := ClassEdif + '#13#10';
           ClassEdif := ClassEdif + ListaClass[j] + ' - ';
           if ListaClass[j] = 'E1(1)' then
            ClassEdif := ClassEdif + 'Abitazioni adibite a residenza con carattere continuativo'
           else
           if ListaClass[j] = 'E1(2)' then
               ClassEdif := ClassEdif + 'Abitazioni adibite a residenza con occupazione saltuaria'
           else
           if ListaClass[j] = 'E1(3)' then
                ClassEdif := ClassEdif + 'Edifici adibiti ad albergo, pensione ed attività similari'
           else
           if ListaClass[j] = 'E2' then ClassEdif := ClassEdif + 'Edifici adibiti a uffici e assimilabili'
           else
           if ListaClass[j] = 'E3' then
              ClassEdif := ClassEdif + 'Edifici adibiti a ospedali, cliniche o case di cura e assimilabili'
           else
           if ListaClass[j] = 'E4(1)' then ClassEdif := ClassEdif + 'Cinema, teatri, sale congressi'
           else
           if ListaClass[j] = 'E4(2)' then ClassEdif := ClassEdif + 'Mostre, musei, biblioteche, luoghi di culto'
           else
           if ListaClass[j] = 'E4(3)' then ClassEdif := ClassEdif + 'Bar, ristoranti, sale da ballo'
           else
           if ListaClass[j] = 'E5' then ClassEdif := ClassEdif + 'Edifici adibiti ad attività commerciali e assimilabili'
           else
           if ListaClass[j] = 'E6(1)' then ClassEdif := ClassEdif + 'Piscine, saune e simili'
           else
           if ListaClass[j] = 'E6(2)' then ClassEdif := ClassEdif + 'Palestre e simili'
           else
           if ListaClass[j] = 'E6(3)' then ClassEdif := ClassEdif + 'Servizi di supporto alle attività sportive'
           else
           if ListaClass[j] = 'E7' then ClassEdif := ClassEdif + 'Edifici adibiti ad attività scolastiche a tutti i livelli e assimilabili'
           else
           if ListaClass[j] = 'E8' then ClassEdif := ClassEdif + 'Edifici adibiti ad attività industriali e artigianali e assimilabili';
         end;
         Wrep_str('CATEGORIA_EDIFICIO', ClassEdif);        // OK Destinazione Uso Edificio
         ListaClass.Free;
        {$ELSE}

        // -----------------------------------------
        // Stampa Dati Caratteristici della Località
        // -----------------------------------------

        Wrep_str('CATEGORIA_EDIFICIO', prog^.Classif);      // OK Classificazione Edificio
        // Emanuela 23/9/2004 inserita la descrizione della classificazione dell'attività
        if prog^.Classif = 'E1(1)' then
            prog^.Destinaz := 'Abitazioni adibite a residenza con carattere continuativo'
        else
        if prog^.Classif = 'E1(2)' then
           prog^.Destinaz := 'Abitazioni adibite a residenza con occupazione saltuaria'
        else
        if prog^.Classif = 'E1(3)' then
            prog^.Destinaz := 'Edifici adibiti ad albergo, pensione ed attività similari'
        else
        if prog^.Classif = 'E2' then prog^.Destinaz := 'Edifici adibiti a uffici e assimilabili'
        else
        if prog^.Classif = 'E3' then
           prog^.Destinaz := 'Edifici adibiti a ospedali, cliniche o case di cura e assimilabili'
        else
        if prog^.Classif = 'E4(1)' then prog^.Destinaz := 'Cinema, teatri, sale congressi'
        else
        if prog^.Classif = 'E4(2)' then prog^.Destinaz := 'Mostre, musei, biblioteche, luoghi di culto'
        else
        if prog^.Classif = 'E4(3)' then prog^.Destinaz := 'Bar, ristoranti, sale da ballo'
        else
        if prog^.Classif = 'E5' then prog^.Destinaz := 'Edifici adibiti ad attività commerciali e assimilabili'
        else
        if prog^.Classif = 'E6(1)' then prog^.Destinaz := 'Piscine, saune e simili'
        else
        if prog^.Classif = 'E6(2)' then prog^.Destinaz := 'Palestre e simili'
        else
        if prog^.Classif = 'E6(3)' then prog^.Destinaz := 'Servizi di supporto alle attività sportive'
        else
        if prog^.Classif = 'E7' then prog^.Destinaz := 'Edifici adibiti ad attività scolastiche a tutti i livelli e assimilabili'
        else
        if prog^.Classif = 'E8' then prog^.Destinaz := 'Edifici adibiti ad attività industriali e artigianali e assimilabili';
        Wrep_str('CLASSE_EDIFICIO', prog^.Destinaz);        // OK Destinazione Uso Edificio
       {$IFEND}

       {$If Defined(VERSIONE_13)}
         DatiAtt[Gencor-1].Classif := ClassEdif;
       {$ELSEIF Defined(VERSIONE_12)}
         DatiAtt.Classif := ClassEdif;
       {$IFEND}

        Wrep_str('LOCALITA', prog^.Localita);               // OK Località
        Wrep_str('NOMECOMUNE', prog^.Comune);               // OK Comune della Località
        Wrep_str('PROV', prog^.ComuneRif);                  // OK Provincia della Località
        W_Reale('LATIT_COMUNE', prog^.LatCom, 2);           // OK Latitudine Località
        W_Reale('LONG_COMUNE', abs(prog^.Longitudine), 2);  // OK Longitudine Località
        Wrep_str('ZONA_GEOGR', prog^.Zonageo);              // OK Zona Geografica
        Wrep_str('REGIONE_VENTO', prog^.regvento);          // OK Regione di Vento
        W_Reale('ZONA_VENTO', prog^.zonavent, 0);           // OK Zona di Vento
        W_Reale('ALTITUDINE', prog^.AltCom, 0);             // OK Altitudine del Comune
        Wrep_str('ZONA_CLIMA', prog^.ZonaCl);               // OK Zona Climatica
        W_Reale('GRADIGIORNO', prog^.gradi, 0);             // OK Gradi Giorno

        W_Reale('G_START', prog^.GiornoIn, 0);              // OK Giorno Iniziale Riscaldamento
        W_Reale('G_END', prog^.GiornoFin, 0);               // OK Giorno Finale Riscaldamento
        W_Reale('M_START', prog^.Mesein, 0);                // OK Mese Iniziale Riscaldamento
        W_Reale('M_END', prog^.mesefin, 0);                 // OK Mese Finale Riscaldamento

        Wrep_str('LOC_RIFERIM', prog^.ComuneRif);           // OK Nome Comune di Riferimento
        Wrep_str('PROVRIF', prog^.Localitarad);             // OK Nome Prov Com di Riferimento

        W_Reale('TEMP_EST_PROG', prog^.TEst, 1);            // OK Temp. Esterna di Progetto
        W_Reale('DIST_MARE', prog^.distmar, 1);             // OK Distanza dal mare


      end;

        // -----------------------------------------------
        // Stampa Dati Irradiazione Solare della Provincia
        // -----------------------------------------------

      procedure datiradiazione;
      var i:smallint;
          a:real;
          indp1:smallint;


            Procedure CalcRad(Nomeark:string;Var RRR:PtabDatClim;prefisso:string);
            Var i:Integer;
            Var NRadProv:integer;
          
                    Procedure Leggi_RadProv(var Tabella1:TTable);
                    Var i:integer;
                        primo,molt:integer;
                    Begin
                    i:=0;
                    Tabella1.close;
                    if nomeark='hbh' then
                      begin
                      primo:=0;
                      Molt:=1;
                      Tabella1.tablename:='Prosp_VIII_DIR_10349';
                      end;
                    if nomeark='hdh' then
                      begin
                      primo:=0;
                      Molt:=1;
                      Tabella1.tablename:='Prosp_VIII_DIF_10349';
                      end;
                    if nomeark='Verteo' then
                      begin
                      primo:=0;
                      Molt:=1;
                      Tabella1.tablename:='Prosp_XI_10349';
                      end;
                    if nomeark='VertN' then
                      begin
                      primo:=0;
                      Molt:=1;
                      Tabella1.tablename:='Prosp_XIII_10349';
                      end;
                    if nomeark='VertSud' then
                      begin
                      primo:=0;
                      Molt:=1;
                      Tabella1.tablename:='Prosp_IX_10349';
                      end;
                    if nomeark='VertNONE' then
                      begin
                      primo:=0;
                      Molt:=1;
                      Tabella1.tablename:='Prosp_XII_10349';
                      end;
                    if nomeark='VertSose' then
                      begin
                      primo:=0;
                      Molt:=1;
                      Tabella1.tablename:='Prosp_X_10349';
                      end;

                    //Tabella1.tablename:=nomeark;
                    tabella1.close;
                    tabella1.databasename:=percorso_archivi;
                    Tabella1.open;
                    Tabella1.first;
                    While not Tabella1.eof do
                      Begin
                      inc(i);
                      with dclLoc^[i] do
                        Begin
                        Ind:=tabella1.fields[0].asinteger;
                        //T1:=tabella1.fields[1].asinteger;
                        datc[1]:=tabella1.fields[primo+Molt*1].asfloat;
                        datc[2]:=tabella1.fields[primo+Molt*2].asfloat;
                        datc[3]:=tabella1.fields[primo+Molt*3].asfloat;
                        datc[4]:=tabella1.fields[primo+Molt*4].asfloat;
                        datc[5]:=tabella1.fields[primo+Molt*5].asfloat;
                        datc[6]:=tabella1.fields[primo+Molt*6].asfloat;
                        datc[7]:=tabella1.fields[primo+Molt*7].asfloat;
                        datc[8]:=tabella1.fields[primo+Molt*8].asfloat;
                        datc[9]:=tabella1.fields[primo+Molt*9].asfloat;
                        datc[10]:=tabella1.fields[primo+Molt*10].asfloat;
                        datc[11]:=tabella1.fields[primo+Molt*11].asfloat;
                        datc[12]:=tabella1.fields[primo+Molt*12].asfloat;
                        end;
                      Tabella1.Next;
                      end;
                    NRadProv:=i;
                    end;

                    begin
                     // New(dcl);
                      Leggi_RadProv(dm1.tt1);
                      if (formst(prog^.localitarad)>'') and (prog^.latrad<>prog^.latitudine) and (prog^.latcom<>prog^.latitudine) then
                      for i :=1 to 12 do RRR^[i]:=dclLoc^[indp].datc[i]+
                                         (dclLoc^[indp1].datc[i] - dclLoc^[indp].datc[i])/
                                         (prog^.latrad-prog^.latitudine)*
                                         (prog^.latcom-prog^.latitudine)
                      else
                      for i :=1 to 12 do RRR^[i]:=dclLoc^[indp].datc[i];

                      for i:=1 to 12 do W_Mesi12L10_real(i,prefisso,RRR^[i],1);

                    //  dispose(dcl);
                    end;

                begin

                  indp := cercaprov(prog^.comunerif,a,i);
                  indp1 := cercaprov(prog^.localitarad,a,i);

                  CalcRad('VertSud',VERTSUD,'H1');
                  CalcRad('VertSose',VERTSose,'H2');
                  CalcRad('Verteo',VERTEO,'H3');
                  CalcRad('VertNONE',VERTNONE,'H4');
                  CalcRad('VertN',VERTN,'H5');
                  CalcRad('hdh',HDH,'H6');
                  CalcRad('hbh',HBH,'H7');

                end;

begin {main Principale}
   ind := IndZonaGeografica(prog^.Zonageo);
   if not(InRange(ind,1,5)) then ind:=1;
   gradiente:=elgrad[ind];
   datitemperatura;
   dativento;
   datiradiazione;
end;

end.





