procedure    stampcoeff;

begin



writeln ('V0Irr',V0IRR:6:2);
writeln ('V1Irr',V1IRR:6:2);
writeln ('V2Irr',V2IRR:6:2);
writeln ('V0Con',V0CON:6:2);
writeln ('V1Con',V1CON:6:2);
writeln ('V2Con',V2CON:6:2);
writeln ('V0Ill',V0ILL:6:2);
writeln ('V1Ill',V1ILL:6:2);
writeln ('V2Ill',V2ILL:6:2);

end;


{------------------------ START FASE3 ---------------------------------------}

BEGIN

   LOADMASK;

   PAUSA:=FALSE;

  { ** DATI DI INPUT ** }

//  Leggi_real(ArCalc,'P','Vent.mic');
{  assign (h1,'Vent.mic'     ); reset(h1); read(h1,PVent      ); close(h1);}

  { ** APERTURA CANALI DI OUTPUT ** }

  OPWHM(QACON);
  OPWHM(QAIRR);
  OPWHM(QAILL);
  OPWHM(TIE);
  OPWHM(EREST);
  OPWHM(UIE);
  OPWHM(LATEFF);

  OPWH(QAPS);
  OPWH(QOCS);
  OPWH(ERINV);
  OPWH(TIEINV);

  CalcoloInvernale;

  IOERR:=TRANSFER_TAB('TAB31','L');

  FOR  A:=1  TO  NAmbienti  DO
{  if (Zone_D^[Ambienti_D^[A]^.zona].ProfiloImpiantoInv in[1..MaxProfili]) and
     (Zone_D^[Ambienti_D^[A]^.zona].ProfiloImpianto in[1..MaxProfili]) then  } {*E*}

  begin
    try
    dinamica(A);
    except
    dinamica(A);
    end;
    ArCalc^[A]^.W1:=Interpola(MFtot,Ambienti_D^[A]^.CircolazAria);
    
  end;


  FOR A:=1 TO NAmbienti do
{  if (Zone_D^[Ambienti_D^[A]^.zona].ProfiloImpiantoInv in[1..MaxProfili]) and
     (Zone_D^[Ambienti_D^[A]^.zona].ProfiloImpianto in[1..MaxProfili]) then  } {*E*}

  begin
if not erroregen then
 begin
 //   CLRMASK;
 //   str(Ambienti_D^[A]^.codnum:5:0,st_8);
 //   GOTOXY(41,2);WRITEC(st_8,3);


//    WITH AMBIENTI_D^[A]^ DO
//    BEGIN
//      GOTOXY(46,2);WRITEC(Denom,44);
//      str(Superficie:5:0,st_8);
//      GOTOXY(7,4);WRITEC(st_8,4);
//    END;

//    TASTOPAUSA;

    {** CARICAMENTO DATI DI INPUT PER AMBIENTE **}

    RDHM(QCTOT,A);
    RDHM(QIRRTOT,A);
    RDHM(QIRCTOT,A);
    RDHM(ILLTOT,A);
    RDHM(INSTOT,A);
    RDHM(INLTOT,A);

    RDH(OCLTOT,A);
    RDH(OCSTOT,A);
    RDH(APSTOT,A);
    RDH(APLTOT,A);


    TASTOPAUSA;

    DINAMICA(A);
//    str(MFtot:7:1,st_8);
//    GOTOXY(32,4);WRITEC(st_8,5);
//    str(Trasmgen:8:2,st_8);
//    GOTOXY(59,4);WRITEC(st_8,6);

//    TASTOPAUSA;

    IOERR:=TRANSFER_TAB('TAB32','L');

    CalcCoeff(A);
    CalcQACON(A);
    //if dat^[5,14,7]<0 then
   // CalcQACON(A);

    CalcQAIRR(A);
    CalcQAILL(A);
    CalcQOCS(A);
    CalcQAPS(A);
    CalcCTMax(A);

  TASTOPAUSA;
   GOTOXY(3,7);WRITEC(mesi[ArCalc^[A]^.CTM.MT],7);
   str((  HE[ArCalc^[A]^.CTM.HT] ):2,st_8);
   GOTOXY(20,7);WRITEC(st_8,8);
    tothg:=0;
    totctsens:=0;
    totctinv:=0;
    totclat:=0;
                    {** STAMPA HEAT GAIN **}
    str(dat^[QCTOT,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT]:6:0,st_8);
    GOTOXY(26,9);WRITEC(st_8,9);
    tothg:=tothg+dat^[QCTOT,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT];

    str(( dat^[QIRRTOT,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT]+dat^[QIRCTOT,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT]):6:0,st_8);
    GOTOXY(26,10);
    WRITEC(st_8,13);
    tothg:=tothg+dat^[QIRRTOT,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT]+dat^[QIRCTOT,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT];

    str(dat^[INSTOT,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT]:6:0,st_8);
    GOTOXY(26,11);WRITEC(st_8,17);
    tothg:=tothg+dat^[INSTOT,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT];

    str(datb^[OCSTOT,ArCalc^[A]^.CTM.HT]:6:0,st_8);
    GOTOXY(26,12);WRITEC(st_8,21);
    tothg:=tothg+datb^[OCSTOT,ArCalc^[A]^.CTM.HT];

    str(datb^[APSTOT,ArCalc^[A]^.CTM.HT]:6:0,st_8);
    GOTOXY(26,13);WRITEC(st_8,25);
    tothg:=tothg+datb^[APSTOT,ArCalc^[A]^.CTM.HT];

    str(dat^[ILLTOT,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT]:6:0,st_8);
    GOTOXY(26,14);WRITEC(st_8,29);
    tothg:=tothg+dat^[ILLTOT,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT];

    str(TOTHG:6:0,st_8);
    GOTOXY(26,16);WRITEC(st_8,33);

    TASTOPAUSA;

           {** STAMPA CARICHI SENSIBILI **}

    str(dat^[QACON,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT]:6:0,st_8);
    GOTOXY(39,9);WRITEC(st_8,10);
    TOTCTSENS:=TOTCTSENS+dat^[QACON,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT];

    str(dat^[QAIRR,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT]:6:0,st_8);
    GOTOXY(39,10);WRITEC(st_8,14);
    TOTCTSENS:=TOTCTSENS+dat^[QAIRR,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT];

    str(dat^[INSTOT,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT]:6:0,st_8);
    GOTOXY(39,11);WRITEC(st_8,18);
    TOTCTSENS:=TOTCTSENS+dat^[INSTOT,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT];

    str(datb^[QOCS,ArCalc^[A]^.CTM.HT]:6:0,st_8);
    GOTOXY(39,12);WRITEC(st_8,22);
    TOTCTSENS:=TOTCTSENS+datb^[QOCS,ArCalc^[A]^.CTM.HT];

    str(datb^[QAPS,ArCalc^[A]^.CTM.HT]:6:0,st_8);
    GOTOXY(39,13);WRITEc(st_8,26);
    TOTCTSENS:=TOTCTSENS+datb^[QAPS,ArCalc^[A]^.CTM.HT];

    str(dat^[QAILL,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT]:6:0,st_8);
    GOTOXY(39,14);WRITEc(st_8,30);
    TOTCTSENS:=TOTCTSENS+dat^[QAILL,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT];

    str(TOTCTSENS:6:0,st_8);
    GOTOXY(39,16);WRITEC(st_8,34);


    TASTOPAUSA;

      {** STAMPA CARICHI LATENTE **}


    str(dat^[INLTOT,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT]:6:0 ,st_8);
    GOTOXY(52,11);WRITEC(st_8,19);
    TOTCLAT:=TOTCLAT+dat^[INLTOT,ArCalc^[A]^.CTM.HT,ArCalc^[A]^.CTM.MT];

    str(datb^[OCLTOT,ArCalc^[A]^.CTM.HT]:6:0,st_8);
    GOTOXY(52,12);WRITEC(st_8,23);
    TOTCLAT:=TOTCLAT+datb^[OCLTOT,ArCalc^[A]^.CTM.HT];

    str(datb^[APLTOT,ArCalc^[A]^.CTM.HT]:6:0,st_8);
    GOTOXY(52,13);WRITEC(st_8,27);
    TOTCLAT:=TOTCLAT+datb^[APLTOT,ArCalc^[A]^.CTM.HT];

    str(TOTCLAT:6:0,st_8);
    GOTOXY(52,16);WRITEC(st_8,35);

         {** STAMPA CARICHI INVERNALI **}

    str(ArCalc^[A]^.QCTOTINV:6:0,st_8);
    GOTOXY(65,9);WRITEc(ST_8,12);
    STR(ArCalc^[A]^.INSTOTINV:6:0,ST_8);
    GOTOXY(65,11);WRITEC(ST_8,20);
    STR((ArCalc^[A]^.QCTOTINV+ArCalc^[A]^.INSTOTINV):6:0,ST_8);
    GOTOXY(65,16);WRITEC(ST_8,36);


    TASTOPAUSA;

    CalcPotenze(A);

    TASTOPAUSA;

    CalcPTMaxinv(A);

    TASTOPAUSA;

    CalcUmRel(A);

    TASTOPAUSA;

    CalcPTMax(A);

    TASTOPAUSA;

    GOTOXY(28,18);WRITEC(MESI[ArCalc^[A]^.PTM.MT],37 );
    STR(( HE[ArCalc^[A]^.PTM.HT] ):2 ,ST_8);
    GOTOXY(47,18);WRITEC(ST_8,38);
    STR(dat^[EREST,ArCalc^[A]^.PTM.HT,ArCalc^[A]^.PTM.MT]:6:0 ,ST_8);
    GOTOXY(22,20);WRITEC( ST_8,39);
    STR(dat^[LATEFF,ArCalc^[A]^.PTM.HT,ArCalc^[A]^.PTM.MT]:6:0 ,ST_8);
    GOTOXY(36,20);WRITEC(ST_8,40 );
    STR(ArCalc^[A]^.PtMInv.PTMAX:6:0,ST_8);
    GOTOXY(58,20);WRITEC(ST_8,41);
    STR(( he[ArCalc^[A]^.PtMInv.HT] ):2 ,ST_8);
    GOTOXY(73,18);WRITEC(ST_8,42);

    IF PAUSA THEN
      BEGIN
        GOTOXY(1,22);WRITE(W_M(153));  {'PREMERE  [G] PER CONTINUARE.                              '}
        {$ifdef dos}
        REPEAT CH:=READKEY UNTIL UPCASE(CH)='G';
        PAUSA:=FALSE;
        GOTOXY(1,22);WRITE(W_M(154)) {'PREMERE [S] PER FERMARE I RISULTATI DELL`AMBIENTE.'}
        {$endif}
        {$ifdef win}
        {$endif}
      END;

    {** SALVATAGGIO RISULTATI **}

    WRHM(QACON);
    WRHM(QAIRR);
    WRHM(QAILL);
    WRHM(TIE);
    WRHM(EREST);
    WRHM(UIE);
    WRHM(LATEFF);

    WRH(QAPS);
    WRH(QOCS);
    WRH(ERINV);
    WRH(TIEINV);
 //   D_m1.free;

  END;

 //   CLOSE(Fout[QACON]);
 //   CLOSE(Fout[QAIRR]);
 //   CLOSE(Fout[QAILL]);
 //   CLOSE(Fout[TIE]);
 //   CLOSE(Fout[EREST]);
 //   CLOSE(Fout[UIE]);
 //   CLOSE(Fout[LATEFF]);

 //   CLOSE(Fouth[QAPS]);
 //   CLOSE(Fouth[QOCS]);
 //   CLOSE(Fouth[ERINV]);
 //   CLOSE(Fouth[TIEINV]);


   { ** Salvataggio dati ** }

 // Scrivi_Tab(ArCalc,'C','CTM.mic');
 // Scrivi_Tab(ArCalc,'P','PTM.mic');
 end;
if war then
Fwarning.showmodal
else Fwarning.close;
END;
