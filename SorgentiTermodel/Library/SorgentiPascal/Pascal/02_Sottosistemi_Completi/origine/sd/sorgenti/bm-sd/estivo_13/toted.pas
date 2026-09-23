{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

Unit TotEd;

Interface

Uses
  Varcarichi,Varcarichi_estivo_14,
  copiaLibreriaGenerale,
  CalcFun,sysutils,
  Risultati;
//  Crt, {Unit found in TURBO.TPL}
//  Dos, {Unit found in TURBO.TPL}
//  definiz,
//  calcfun,
// inpdati,
//  utiGEN,
//  CALCUTID,
//  printer,
//  defutiG,
//  WM;

procedure Calcedif;

{=============================================================================}
Implementation


procedure CalcEdif;


type ResTabZ1 = ARRAY[0..23,1..MaxZone] OF REAL;
     ore      = array[0..23] of real;

var  //SzTotInv ,SaprInvAmb        : ^ResTabZ1;
     //SzVentInv,LZVentInv,SAPRInv : ^ResTabZ1;
     f,f1                        : file of ResTabZ1;
   //  SeTotInv,SeVentInv          : ^ore;
     g                           : file of ore;
   //  SeTot,SeVent,Sesens,Selat   : ^TyHM;
     g1                          : file of TyHm;

procedure AzzeraHM(var D:TyHM);
 var h,m:integer;
 begin
    for h:=0 to 23 do
     for m:=1 to 12 do
      D[h,m]:=0;
 end;

{------------------------------  CalcZone     --------------------------------}
procedure CalcZone;
VAR  A,M,H,Z                  : integer;
     //SzTot,LzTot,Erest,Lateff : ^TyHM;
     f1,   f2,   f3,   f4     : file of TyHM;
     //Erinv                    : ^TyH;
     g                        : file of TyH;
     fdebc:textfile;
begin
//   assign(f1,'SzTot.DAT');
//   assign(f2,'LzTot.DAT');
//   assign(f3,'Erest.DAT');
//   assign(f4,'Lateff.DAT');
//   assign(g ,'ErInv.DAT');
//   new(sztot);
//   new(lztot);
//   new(erest);
//   new(lateff);
//   new(erinv);

//   rewrite(f1);     rewrite(f2);
//   reset  (f3);     reset  (f4);       reset(g);

OpenCan(EREST,'EREST'  ,NAmbienti,2);
OpenCan(LATEFF,'LATEFF'  ,NAmbienti,2);
OpenCan(SZTOT,'SZTOT'  ,NImpianti,2);
OpenCan(LZTOT,'LZTOT'  ,NImpianti,2);


//   for Z:=1 to NZone do
//    for h:=0 to 23 do
//      SzTotInv^[h,z]:=0;

 //  ClrScr;
 //  writec(W_M(128),1);  {'Calcolo Zone'}
//assign(fdebc,'debugclima.txt');
//rewrite(fdebc);
   FOR Z:=1 TO NImpianti DO
    begin
    LoadHM(SZTOT,Z); LoadHM(LZTOT,Z);
       //AzzeraHM(SzTot^);  AzzeraHM(LzTot^);
       FOR A:=1 TO NAmbienti DO
          WITH Ambienti_D^[A]^ DO
           if Indimpianto = Z then
            begin
            canhm[EREST].A:=0;
            canhm[LATEFF].A:=0;
            LoadHM(EREST,A);
            LoadHM(LATEFF,A);

 //              seek(f3,A-1);       read(f3,Erest^);
 //              seek(f4,A-1);       read(f4,Lateff^);
               FOR M:=MeseInizio TO MeseFine DO
               FOR H:=0 TO 23 DO
                 begin
                 IF Dat^[ERest,H,M] > 0 THEN
                   begin
                   Dat^[SzTot,H,M]:=Dat^[SzTot,H,M] + AmbientiUguali*Dat^ [ERest,H,M];
                   Dat^[LZTot,H,M]:=Dat^[LZTot,H,M] + AmbientiUguali*Dat^[LATEFF,H,M];
                   end;

                 end;
            //writeln(fdebc,inttostr(a)+':'+codnum+':',denom+':'+float_to_str(Dat^ [ERest,15,7],0));
            end;

       //write(f1,SzTot^);   write(f2,LzTot^);
       //WFhmDB(SzTot^,'SZTOT.DAT',Z);WFhmDB(LZTot^,'LZTOT.DAT',Z);

       // FOR A:=1 TO NAmbienti DO
       //  WITH Ambienti_D^[A]^ DO
       //   if Zona = Z then
       //    begin
       //       seek(g,A-1);   read(g,ERInv^);
       //       FOR H:=0 TO 23 DO
       //       SzTotInv^[H,Z]:=SzTotInv^[H,Z]+AmbientiUguali*ERInv^[H];
       //    end;
    end;
//close(fdebc);
CloseHm(sztot);
CloseHm(Lztot);
 //  close(f1);   close(f2);    close(f3);    close(f4);    close(g);

//   assign(f,'SzTotInv.mic');  rewrite(f);   write(f,SzTotInv^);  close(f);

//  dispose(sztot);
//  dispose(lztot);
//  dispose(erest);
//  dispose(lateff);
//  dispose(erinv);
end;   { PROC. CalcZone }

{------------------------------  CalcVentZone --------------------------------}
function Ce_ventilazione(IndImp:integer):boolean;
begin
result:=(Uppercase(impianto_D^[indImp].TipoImpiantoVentilazione)<>'NESSUN IMPIANTO')and
        (Zone_D^[IndImp].ProfVentEst<>0);
end;
procedure CalcVentZone;

//type VentZone = Array[1..MaxZone] of real;

VAR
     //PVentZona       : VentZone         ;
     g               : file of VentZone ;
     H,M,Z           : integer          ;
     CPInv,CVAPInv   : REAL             ;
     TSK,USK         : REAL             ;
     PWSX,W,NU,ROInv : REAL             ;
     PwsUEst,PwUest,WUEst,Usp : real    ;

begin

// assign(g,'VentZone.mic');   reset(g);    read(g,PVentZona);      close(g);
 {.. lettura di PVentZona ..}

 OpenCan(14,'SzTot', 0,      2);
 OpenCan(15,'LZTot', 0,      2);
 OpenCan(16,'SzVent',Nimpianti,2);
 OpenCan(17,'LZVent',Nimpianti,2);
 OpenCan(18,'SAPR',  Nimpianti,2);
 OpenCan(19,'LAPR',  Nimpianti,2);
 OpenCan(20,'SaprAmb',Nimpianti,2);    {michele 14/10/88 su richiesta Battiloro}
 OpenCan(21,'LaprAmb',Nimpianti,2);    {michele 14/10/88 su richiesta Battiloro}

// ClrScr;

 FOR Z:=1 TO NImpianti DO

 IF (ZONE_D^[Z].TEST<>0) and
    (zone_d^[z].ProfiloImpiantoInv <> 0) and (zone_d^[z].ProfiloImpianto <> 0) THEN  {*** LOCALE CONDIZIONATO IN ESTATE ***}


 BEGIN

  LoadHM(SzTot ,Z);
  LoadHM(LZTot ,Z);
  LoadHM(SzVent,Z);
  LoadHM(LZVent,Z);
  LoadHM(SAPR  ,Z);
  LoadHM(LAPR  ,Z);
  LoadHM(20  ,Z);     {michele 14/10/88 su richiesta Battiloro}
  LoadHM(21  ,Z);     {michele 14/10/88 su richiesta Battiloro}

  FOR M:=MeseInizio TO MeseFine DO

  WITH Zone_D^[Z] DO

    begin

    TSK    :=TDA(M,Z);
    USK    :=UImmComp(M,Z);
    PwsUEst:=PWS(TI(M,Z));
    PwUEst :=PwsUEst*(UEst/100);
    WUest  :=0.62198*(PwUEst/(PATM-PwUEst));
    USp    :=WUEst/(1 + WUest);

    { IF USp < USK THEN USK:=USp; *** RICHIESTA ELIMINAZIONE IL 5-10-88 DA BAT }

    FOR H:=0 TO 23 DO

      BEGIN

      IF USK > US[H,M] THEN   dat^[LZVent,H,M]:=0

      else dat^[LZVent,H,M]:= (Profili_D^[Zone_D^[Z].ProfVentEst,H]*
                                                       PVentZona[Z]*
                                                        ROVent(M,Z)*
                                                          CVAP(M,Z)*
                                                     (US[H,M]-USK))/
                                                                100;
  {    if (h=15)and (m=7) then
      writeln(lst,'USEst [kg/kg]: ',us[h,m]:5:4,' USInt.[kg/kg: ',usk:5:4,' Dens.[kg/m3]: ',ROVent(M,Z),
      ' CLatVap[W/kg]: ',CVAP(M,Z));
     }

      IF TSK > TE^[H,M] THEN dat^[SzVent,H,M]:=0

      ELSE  dat^[SzVent,H,M]:= (Profili_D^[Zone_D^[Z].ProfVentEst,H]*
                                                        PVentZona[Z]*
                                                         ROVent(M,Z)*
                                                             CP(M,Z)*
                                                     (Te^[H,M]-TSK))/
                                                            100000.0;
    {  if (h=15) and(m=7) then
      begin
      writeln;
      writeln(lst,'Test[øC]: ',Te^[H,M],' Tint[øC]: ',tsk,' Dens.[kg/m3]:',ROVent(M,Z),' CT[W/kg]: ',CP(M,Z));
      end; }


      IF ( dat^[SzTot,H,M] > 0 ) THEN

      dat^[SAPR,H,M]:=    (Profili_D^[Zone_D^[Z].ProfVentEst,H]*
                                                   PVentZona[Z]*
                                                    ROVent(M,Z)*
                                                        CP(M,Z)*
                                       (TImmComp(M,Z)-TI(M,Z)))/
                                                       100000.0
      ELSE  dat^[SAPR,H,M]:=0;

      IF ( dat^[LzTot,H,M] > 0 ) THEN

      dat^[LAPR,H,M]:=    (Profili_D^[Zone_D^[Z].ProfVentInv,H]*
                                                   PVentZona[Z]*
                                                    ROVent(M,Z)*
                                                      CVAP(M,Z)*
                                                     (USK-USp))/
                                                            100

      else  dat^[LAPR,H,M]:=0;

      dat^[20  ,H,M]:= dat^[SAPR,H,M];  {michele 14/10/88 su richiesta Battiloro}
      dat^[21  ,H,M]:= dat^[LAPR,H,M];  {michele 14/10/88 su richiesta Battiloro}

      IF -dat^[SAPR,H,M] > dat^[SzTot,H,M] THEN dat^[SAPR,H,M]:=-dat^[SzTot,H,M];
      IF -dat^[LAPR,H,M] > dat^[LZTot,H,M] THEN dat^[LAPR,H,M]:=-dat^[LZTot,H,M];

      end;

    end;

  end;

{----------- CALCOLO INVERNALE DELLA VENTILAZIONE -------------------------}
 (*
FOR Z:=1 TO NImpianti DO
if CE_ventilazione(Z) then
  begin

  CPInv   := 0.237*4186;
  CVAPInv := 2453.48-2.368*(Zone_D^[Z].TInv-20);
  //  CVAPInv := 2453.48-2.368*(Zone_D^[Z].TImmInv-20);
  WITH Zone_D^[Z] DO

    begin         {----------- Calcolo di ROInv ---------------------------}

      ROInv := 0;
      PWSX  := USImmInv[Z]*PWS(TImmInv)/100;
      W     := 0.62198 * PWSX / (PATM-PWSX);
      NU    := (287055.0*(TImmInv+273.15)/PATM)*(1+1.6078*W);
      ROInv := 1000*(1 + W) / NU;

    end;

  for h:=0 to 23 do

    begin
    SzTotInv^[H,Z] :=(Profili_D^[Zone_D^[Z].ProfVentInv,H]*
                                              PVentZona[Z]*
                                                     ROInv*
                                                     CPInv*
       (Zone_D^[Z].TimmInv-LOCALITA_D^.TInvEsternaBS))/
                                                  100000.0;

    if Zone_D^[Z].TimmInvBU <> 0 then

    LZVentInv^[H,Z]:= (Profili_D^[Zone_D^[Z].ProfVentInv,H]*
                                              PVentZona[Z]*
                                                     ROInv*
                                                   CVAPInv*
                                     (USImmInv[Z]-UScost))/
                                                       100

    else LZVentInv^[H,Z]:=0;

    SAPRInv^[H,Z]:=   (Profili_D^[Zone_D^[Z].ProfVentInv,H]*
                                              PVentZona[Z]*
                                                     ROInv*
                                                     CPInv*
                    (-Zone_D^[Z].TimmInv+Zone_D^[Z].TInv))/
                                                  100000.0;

    SAPRInvAmb^[H,Z] := SAPRInv^[H,Z];   {michele 14/10/88 su richiesta Battiloro}

    if -SAPRInv^[H,Z] > SzTotInv^[H,Z] then SAPRInv^[h,z]:=-SzTotInv^[h,z];

    end;

  end;
 *)
//  assign(f,'SzVentInv.mic');     rewrite(f);    write(f,SzTotInv^);  close(f);
//  assign(f,'LzVentInv.mic');     rewrite(f);    write(f,LZVentInv^);  close(f);
//  assign(f,'SaprInv.mic');       rewrite(f);    write(f,SAPRInv^);    close(f);
//  assign(f,'SaprIAmb.mic');      rewrite(f);    write(f,SAPRInvAmb^); close(f);

  closeHM(SzTot);
  closeHM(LZTot);
  closeHM(SzVent);
  closeHM(LZVent);
  closeHM(SAPR);
  closeHM(LAPR);
  closeHM(20);
  closeHM(21);

end;   {-------  CalcVentZone --------}

{-------------------------------  CalcEdificio  -------------------------}

procedure CalcEdificio;

VAR  j,Z,M,H:integer;

begin

 OpenCan(14,'SzTot',0,2);
 OpenCan(15,'LZTot',0,2);
 OpenCan(16,'SzVent',0,2);
 OpenCan(17,'LZVent',0,2);
 OpenCan(SAPR,'SAPR',0,2);   //Diego
 OpenCan(LAPR,'LAPR',0,2);   //Diego

 AzzeraHM(SeTot^);       AzzeraHM(SeVent^);
 AzzeraHM(SeSens^);       AzzeraHM(SeLat^);

 FOR Z:=1 TO NImpianti DO

   BEGIN

   LoadHM(SzTot,Z);
   LoadHM(LZTot,Z);
   LoadHM(SzVent,Z);
   LoadHM(LZVent,Z);
   LoadHM(SAPR,Z); //Diego
   LoadHM(LAPR,Z); //Diego

   FOR M:=MeSeInizio TO MeSeFine DO

   FOR H:=0 TO 23 DO

    begin

      IF dat^[SzVent,H,M] > 0 THEN   SeVent^[H,M]:=      SeVent^[H,M]+
                                                   dat^[SzVent,H,M]+
                                                   dat^[LZVent,H,M];


      IF dat^[SzTot,H,M]  > 0 THEN
        begin
                                   SeTot^[H,M]:=       SeTot^[H,M]+
                                                    dat^[SzTot,H,M]+
                                                    dat^[LZTot,H,M]+
                                                    dat^[SAPR,H,M]+ //Diego
                                                    dat^[LAPR,H,M]; //Diego
                                   SeSens^[H,M]:=   SeSens^[H,M]+
                                                    dat^[SzTot,H,M];
                                   SeLat^[H,M]:=    SeLat^[H,M]+
                                                    dat^[LzTot,H,M]; 
        end;
    end;
   END;

 for j:=14 to 17 do closeHM(j);

 //assign(g1,'SeTot.mic');    rewrite(g1);    write(g1,SeTot^);   close(g1);
 //assign(g1,'SeVent.mic');   rewrite(g1);    write(g1,SeVent^);  close(g1);
 WFhmDB(SeTot^,'SETOT.MIC',1);
 WFhmDB(SeVent^,'SETVENT.MIC',1);
 WFhmDB(SeSens^,'SESENS.MIC',1);
 WFhmDB(SeLat^,'SELAT.MIC',1);

 for h:=0 to 23 do

  begin

     SeTotInv^[h] :=0;
     SeVentInv^[h]:=0;

  end;
  (*
 FOR H:=0 TO 23 DO

 FOR Z:=1 TO NImpianti  DO

   begin

   SeTotInv^[H]:=      SeTotInv^[H] +
                    SzTotInv^[H,Z] ;

   SeVentInv^[H]:=    SeVentInv^[H] +
                   SzTotInv^[H,Z] +
                   LZVentInv^[H,Z] ;

   end;
 *)
//  assign(g,'SeTotInv.mic');     rewrite(g);    write(g,SeTotInv^);    close(g);
//  assign(g,'SeVentInv.mic');    rewrite(g);    write(g,SeVentInv^);   close(g);

end;{ PROC. CalcEdificio }


{---------------------------  MAIN of CalcEdif  ------------------------------}
begin
  (*
  NEW(SzTotInv);
  NEW(SaprInvAmb);
  NEW(SzVentInv);
  NEW(LZVentInv);
  NEW(SAPRInv);
  NEW(SeTotInv);
  NEW(SeVentInv);
  NEW(SeTot);
  NEW(SeVent);
  NEW(SeSens);
  NEW(SeLat);
  *)
  CalcZone;
  CalcVentZone;
  CalcEdificio;
  (*
  DISPOSE(SzTotInv);
  DISPOSE(SaprInvAmb);
  DISPOSE(SzVentInv);
  DISPOSE(LZVentInv);
  DISPOSE(SAPRInv);
  DISPOSE(SeTotInv);
  DISPOSE(SeVentInv);
  DISPOSE(SeTot);
  DISPOSE(SeVent);
  DISPOSE(SeSens);
  DISPOSE(SeLat);
  *)
end;    {......CalcEdif........}

end.