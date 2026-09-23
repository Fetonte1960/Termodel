{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$M 65000,16384,655360} {Turbo 3 default stack and heap}
{$F+}
{$O+}

program ComMet;
{interface}

Uses

  Crt, {Unit found in TURBO.TPL}
  Dos, {Unit found in TURBO.TPL}
  Turbo3, {Unit found in TURBO3.TPU}
  Defuti,
  utilitie,
  PRINTER,
  print,
  defcom,
  overproc,
  stampe;

{procedure Computo(Prog1:string;var Scelta:integer);


implementation}

Function CaricaMisure(NomeFile:st18):string;
 Var Miscor:integer;
     fint:file of integer;
    BEGIN
      if Exist(data_drive+nomefile+'.msc') then
       begin
          ASSIGN(FInt, data_drive+nomefile+'.msc');
          RESET(FInt);
          READ(FInt, miscor);
          CLOSE(FInt);
       end
      else
       begin
          Miscor:=1;
          ASSIGN(FInt, data_drive+nomefile+'.msc');
          REWRITE(FInt);
          WRITE(FInt, miscor);
          CLOSE(FInt);
       end;

      IF miscor = 1 THEN CaricaMisure:='Port.: mc/sec';
      IF miscor = 3600 THEN CaricaMisure:='Port.: mc/h';
    END;



  FUNCTION Circolare(Cod : INTEGER) : BOOLEAN;
    BEGIN
      IF Cod > 0 THEN Circolare := (UPCASE(Archivio^[Cod].TipoSez[2]) IN ['C', 'D'])
      ELSE Circolare := FALSE;
    END;

  PROCEDURE init_archivio;
    VAR I : INTEGER;
    BEGIN
      FOR I := 1 TO npezzi DO
        WITH archivio^[I] DO
          BEGIN
            CodPezzo := '';
            Descr := '';
            CodDis := 0;
            Main := '';
            Branch := '';
            Fonte := '';
            Varie := '';
            TipoSez := '';
            NUscite := 0;
          END;
    END;

  PROCEDURE scrittura_cmt;
    VAR f1 : FILE OF rec_inp;
      I : INTEGER;
    BEGIN
      ASSIGN(f1, data_drive+progcmt+'.cmt');
      REWRITE(f1);
      FOR I := 1 TO max DO WRITE(f1, mul[I]);
      CLOSE(f1);
    END;



  PROCEDURE azzera_mul;
    VAR I : INTEGER;
    BEGIN
      FOR I := 1 TO max DO
        BEGIN
          mul[I].tipo := '';
          mul[I].lato_maggiore := 0;
          mul[I].lung_max_tron := 0;
          mul[I].lam_spessore := 0;
          mul[I].lam_peso := 0;
          mul[I].tipo_giunzio := '';
          mul[I].cod_giu_tras := '';
          mul[I].pes_giu_tras := 0;
          mul[I].rin_int_num := 0;
          mul[I].rin_int_tip := '';
          mul[I].rin_int_pes := 0;
          mul[i].bul_tipo := '';
          mul[i].bul_passo := 0;
          mul[i].bul_peso := 0;
        END;
      FOR i := 1 TO 250 DO
        BEGIN
          a1^[i].codicebullone := '';
          a1^[i].quantitabullone := 0;
          a1^[i].pesobullone := 0;
        END;
      FOR i := 1 TO 250 DO
        BEGIN
          b1^[i].codrinf := '';
          b1^[i].numrinf := 0;
          b1^[i].pesrinf := 0;
        END;
      FOR i := 1 TO 250 DO
        BEGIN
          c1^[i].tot := 0;
          c1^[i].sps := 0;
          c1^[i].sup := 0;
          c1^[i].pes := 0;
        END;
    END;

  PROCEDURE azzera_record_di_stampa;
    VAR i : INTEGER;
    BEGIN
      FOR i := 1 TO maxpezzi DO
        BEGIN
          Prn[i].count := 0;
          Prn[i].tratto_da := '';
          Prn[i].tratto_a := '';
          Prn[i].codice_pezzo := '';
          Prn[i].dim_a := 0;
          Prn[i].dim_b := 0;
          Prn[i].Dim_d := 0;
          Prn[i].lunghezza_tratto := 0;
          Prn[i].Lamiera_superficie := 0;
          Prn[i].lamiera_peso := 0;
          Prn[i].Numero_giunzioni := 0;
          Prn[i].cdcg := '';
          Prn[i].l_giunzioni := 0;
          Prn[i].peso_giunzioni := 0;
          Prn[i].numero_rinforzi := 0;
          Prn[i].cdcr := '';
          Prn[i].l_rinforzi := 0;
          Prn[i].peso_rinforzi := 0;
          Prn[i].tipo_bulloni := '';
          Prn[i].n_bulloni := 0;
          Prn[i].peso_bulloni := 0;
          Prn[i].totale_peso := 0;
        END;
    END;

    {---------------------------  find_archivio  ---------------------------------}
  FUNCTION FIND_ARCHIVIO(Codice : ST5) : INTEGER;
      { Cerca all'interno di ARCHIVIO il codice di un pezzo e restituisce la posi_
      zione in tabella (indice dell'array ARCHIVIO) }
    VAR
      I : INTEGER;
    BEGIN
      Codice :=FormSt(Codice);
      I := 1;
      WHILE (I < NPezzi) AND (ARCHIVIO^[I].CodPezzo <> Codice) DO I := I+1;

      IF (I > NPezzi) THEN FIND_ARCHIVIO := 0
      ELSE FIND_ARCHIVIO := I;
    END;                      { func.  find_archivio }


   procedure transfer_archivio;
    VAR I, ioerr, n : INTEGER;
      f : FILE OF RigaArch;
    BEGIN
      init_archivio;
      ASSIGN(f, data_drive+'archivio.can');
      {$I-} RESET(f);         {$I+}
      IF IORESULT = 0 THEN
        BEGIN
          I := 1;
          WHILE NOT EOF(f) DO
            BEGIN
              READ(f, archivio^[I]);
              Archivio^[i].codpezzo := FormSt(Archivio^[i].codpezzo);
              I := I+1;
            END;
          CLOSE(f);
        END;
    END;

  PROCEDURE dividi;
    VAR i, j, k, k1, k2 : INTEGER;
    BEGIN
      k := 0;
      k1 := 0;
      FOR i := 1 TO Max DO
        FOR k2 := 1 TO 2 DO
          BEGIN
            cirvet[i, k2] := 0;
            retvet[i, k2] := 0;
          END;
      i := 1;
      WHILE (mul[i].lato_maggiore <> 0) DO i := i+1;
      {.. conto quante righe della tabella sono state riempite ..}
      FOR j := 1 TO i DO
        BEGIN
          IF ((mul[j].tipo = 'C') OR
          (mul[j].tipo = 'c')) THEN
            BEGIN
              k := k+1;
              cirvet[k, 1] := mul[j].lato_maggiore;
              cirvet[k, 2] := j;
            END
          ELSE
            BEGIN
              k1 := k1+1;
              retvet[k1, 1] := mul[j].lato_maggiore;
              retvet[k1, 2] := j;
            END;
        END;
    END;

  FUNCTION indice(valore : INTEGER; codtt : st1) : INTEGER;
    VAR i : INTEGER;
    BEGIN
      codtt := UPCASE(codtt[1]);
      IF (codtt = 'C') THEN
        BEGIN
          IF (valore < cirvet[1, 1]) THEN indice := 1
          ELSE
            BEGIN
              I := 1;
              WHILE ((valore > cirvet[I, 1]) AND
              (cirvet[I, 1] <> 0)) DO I := I+1;
{              write(' indice ',i:5); delay (1000);}
              IF (cirvet[I, 1] = 0) and ( i > 1) THEN
                indice := cirvet[I-1, 2]
              ELSE
                indice := cirvet[I, 2];
            END;
        END
      ELSE
        BEGIN
          IF (valore < retvet[1, 1]) THEN indice := RETVET[1, 2]
          ELSE
            BEGIN
              I := 1;
              WHILE ((valore > retvet[I, 1]) AND
              (retvet[I, 1] <> 0)) DO
               begin
                  writeln(' valore ',VAlore:5,' Vettore ',retvet[i,1]:5); delay(1000);
                  I := I+1;
               end;
              write(' indice ',i:5); delay (1000);
              IF (retvet[I, 1] = 0) and ( i > 1 ) THEN
                indice := retvet[I-1, 2]
              ELSE
                indice := retvet[I, 2];
            END;
        END;
    END;




  PROCEDURE leggi(p1 : Link);
   var
       PunA,PunB,PunC                    : link;

   {$I BulDef }

    BEGIN   {.. LEGGI ..}
      IF p1 <> NIL THEN
        BEGIN
          READ(filedati, P1^);
          PunA:=P1^.Pc;  PunB:=P1^.Ps;   PunC:=P1^.Pd;
          percorri (P1);
          leggi (PunA);
          leggi (PunB);
          leggi (PunC);
        END;                  {.. if p <> nil then ..}
    END;                      { .. procedure leggi ..}


  PROCEDURE lettura;

    BEGIN                     {lettura}
      NEW(archivio);
      transfer_archivio;
      ASSIGN(filedati, data_drive+prog+'.can');
      RESET(filedati);
      NEW(p);
      Assign(glst,Data_drive+prog+'.lp1');
      rewrite(glst);
      leggi(P);
      close(glst);
      DISPOSE(p);
      CLOSE(filedati);
    END;

  PROCEDURE azzera_totali;
    BEGIN
      tot.l_t_tratto := 0;
      tot.s_t_lamiera := 0;
      tot.l_t_peso := 0;
      tot.n_t_giunzioni := 0;
      tot.l_t_giunzioni := 0;
      tot.p_t_giunzioni := 0;
      tot.n_t_rinforzi := 0;
      tot.l_t_rinforzi := 0;
      tot.p_t_rinforzi := 0;
      tot.n_t_bulloni := 0;
      tot.p_t_bulloni := 0;
      TOT.N_T_DEFAULT := 0;
      TOT.P_T_DEFAULT := 0;
      TOT.N_T_SPIGOLI := 0;
      TOT.P_T_SPIGOLI := 0;
      tot.n_t_morsetti := 0;
      tot.p_t_morsetti := 0;
      tot.p_t_totale := 0;
    END;

  PROCEDURE Calcolo_totali(prog:string);
    VAR i : INTEGER;
      XXX : REAL;
      ch1 : STRING[126];
    BEGIN
      FOR i := 1 TO TotRighe DO
        BEGIN
{          writeln(' TotRighe ',TotRighe:3,' I ',i,' Num Giunz ',Prn[i].numero_giunzioni:5,' Lung Giunz ',
          Prn[i].l_giunzioni); delay (1000);}
          tot.l_t_tratto := tot.l_t_tratto+Prn[i].lunghezza_tratto;
          tot.s_t_lamiera := tot.s_t_lamiera+Prn[i].lamiera_superficie;
          tot.l_t_peso := tot.l_t_peso+Prn[i].lamiera_peso;
          tot.n_t_giunzioni := tot.n_t_giunzioni+Prn[i].numero_giunzioni;
          XXX := Prn[i].l_giunzioni*Prn[i].numero_giunzioni;
          tot.l_t_giunzioni := tot.l_t_giunzioni+XXX;
          tot.p_t_giunzioni := tot.p_t_giunzioni+Prn[i].peso_giunzioni;
          tot.n_t_rinforzi := tot.n_t_rinforzi+Prn[i].numero_rinforzi;
          tot.l_t_rinforzi := tot.l_t_rinforzi+(Prn[i].l_rinforzi*Prn[I].NUMERO_RINFORZI);
          tot.p_t_rinforzi := tot.p_t_rinforzi+Prn[i].peso_rinforzi;
          tot.p_t_totale := tot.l_t_peso+tot.p_t_giunzioni+tot.p_t_rinforzi;
        END;
      FOR i := 1 TO TBmw DO
        BEGIN
          IF (A1^[I].CODICEBULLONE [1] = '8' ) OR
             (A1^[I].CODICEBULLONE [1] = '1' ) THEN { 8m 10m 12m }
             BEGIN
               TOT.N_T_DEFAULT := TOT.N_T_DEFAULT + a1^[i].quantitabullone;
               TOT.P_T_DEFAULT := TOT.P_T_DEFAULT + a1^[i].PESObullone;
             END;
          if (a1^[i].codicebullone [2] = 'S') then  { ms }
             begin
               tot.n_t_morsetti := tot.n_t_morsetti + a1^[i].quantitabullone;
               tot.p_t_morsetti := tot.p_t_morsetti + a1^[i].pesobullone;
             end;
          if ((upstring(a1^[i].codicebullone [1]) = 'M') and
             (upstring(a1^[i].codicebullone [2]) <> 'S')) then { m* }
             begin
               tot.n_t_bulloni := tot.n_t_bulloni+a1^[i].quantitabullone;
               tot.p_t_bulloni := tot.p_t_bulloni+a1^[i].pesobullone;
             end;
        END;
      tot.p_t_totale := tot.p_t_totale+TOT.P_T_BULLONI+tot.P_t_default+tot.p_t_morsetti;
      FOR I := 1 TO TSpg DO
        BEGIN
          TOT.N_T_SPIGOLI := TOT.N_T_SPIGOLI + G1^[I].QUANTITASPG;
          TOT.P_T_SPIGOLI := TOT.P_T_SPIGOLI + G1^[I].PESOSPG;
        END;
      tot.p_t_totale := tot.p_t_totale+TOT.P_T_SPIGOLI;
{      ASSIGN(glst, data_drive+prog+'.ls1');
      REWRITE(glst);}
      WRITELN(glst, CHR(18));
      azzera_test1;
      StampaMask(SEG(TOT),OFS(TOT), data_drive+'riepil.PRN', TRUE);
      SaltoPag;
{      CLOSE(glst);}
    END;

  PROCEDURE ordina;
    VAR i, j : INTEGER;
      temp1 : STRING[3];
      temp2 : INTEGER;
      temp3 : REAL;
    BEGIN
      IF TBmw > 0 THEN
        BEGIN
          FOR i := 1 TO TBmw-1 DO
            BEGIN
              FOR j := i+1 TO TBmw DO
                BEGIN
                  IF (a1^[i].codicebullone > a1^[j].codicebullone) THEN
                    BEGIN
                      temp1 := a1^[i].codicebullone;
                      temp2 := a1^[i].quantitabullone;
                      temp3 := a1^[i].pesobullone;
                      a1^[i].codicebullone := a1^[j].codicebullone;
                      a1^[i].quantitabullone := a1^[j].quantitabullone;
                      a1^[i].pesobullone := a1^[j].pesobullone;
                      a1^[j].codicebullone := temp1;
                      a1^[j].quantitabullone := temp2;
                      a1^[j].pesobullone := temp3;
                    END;
                END;
            END;
        END;
    END;

  PROCEDURE ordinarinforzi;
    VAR i, j : INTEGER;
      temp1 : STRING[6];
      temp2 : INTEGER;
      temp3 : REAL;
    BEGIN
      IF TKtm > 0 THEN
        BEGIN
          FOR i := 1 TO TKtm-1 DO
            BEGIN
              FOR j := i+1 TO TKtm DO
                BEGIN
                  IF (b1^[i].codrinf > b1^[j].codrinf) THEN
                    BEGIN
                      temp1 := b1^[i].codrinf;
                      temp2 := b1^[i].numrinf;
                      temp3 := b1^[i].pesrinf;
                      b1^[i].codrinf := b1^[j].codrinf;
                      b1^[i].numrinf := b1^[j].numrinf;
                      b1^[i].pesrinf := b1^[j].pesrinf;
                      b1^[j].codrinf := temp1;
                      b1^[j].numrinf := temp2;
                      b1^[j].pesrinf := temp3;
                    END;
                END;
            END;
        END;
    END;

  PROCEDURE ordinaspessori;
    VAR i, j : INTEGER;
      temp1 : REAL;
      temp2 : REAL;
      temp3 : REAL;
    BEGIN
      IF TNUT > 0 THEN
        BEGIN
          FOR i := 1 TO Tnut-1 DO
            BEGIN
              FOR j := i+1 TO TNut DO
                BEGIN
                  IF (c1^[i].sps > c1^[j].sps) THEN
                    BEGIN
                      temp1 := c1^[i].sps;
                      temp2 := c1^[i].sup;
                      temp3 := c1^[i].pes;
                      c1^[i].sps := c1^[j].sps;
                      c1^[i].sup := c1^[j].sup;
                      c1^[i].pes := c1^[j].pes;
                      c1^[j].sps := temp1;
                      c1^[j].sup := temp2;
                      c1^[j].pes := temp3;
                    END;
                END;
            END;
        END;
    END;


  PROCEDURE STAMPA(prog:string);
    CONST NPperPag = 40;
    VAR
      i, Cont, T : INTEGER;
    BEGIN
{      ASSIGN(glst, data_drive+prog+'.lst');
      REWRITE(glst);}

      cont := 1;
      t := TotRighe;
      azzera_test1;
      test1.name := prog;
      test1.data := getdate;
      test1.ntab := progcmt;
      FOR i := 1 TO t DO
        BEGIN
          IF Cont MOD NPperPag = 1 THEN
            BEGIN
              conta := conta+1;
              test1.pag := conta;
              stampamask(SEG(test1), OFS(test1), data_drive+'cmtcmt.prn', TRUE);
              WriteTesto(data_drive+'Testcmt.prn');
            END;
          StampaMask(SEG(Prn[I]), OFS(Prn[I]),
          data_drive+'rigacmt.prn', TRUE);
          Cont := Cont+1;
          IF Cont MOD NPperPag = 0 THEN
            BEGIN
              WriteTesto(data_drive+'Ultcmt.prn');
              SaltoPag;
              Cont := 1;
            END;
        END;
      IF Cont MOD NPperPag <> 0 THEN
        BEGIN
          WriteTesto(data_drive+'Ultcmt.prn');
          SaltoPag;
        END;
{      CLOSE(glst);}
    END;

  PROCEDURE STAMPAPezzi(prog:string);
    CONST NPperPag = 40;
    VAR
      Cont: INTEGER;
      Stri:string[80];
    BEGIN
      ASSIGN(ff, data_drive+prog+'.lp1');
      RESET(ff);
      WRITELN(glst, CHR(18));
      azzera_test1;
      test1.name := prog;
      test1.data := getdate;
      test1.ntab := progcmt;
      Cont:=1;
      Repeat
        Readln(ff,Stri);
        IF Cont MOD NPperPag = 1 THEN
         BEGIN
            conta := conta+1;
            test1.pag := conta;
            stampamask(SEG(test1), OFS(test1), data_drive+'cmtcmt.prn', TRUE);
            WriteTesto(data_drive+'InitSpe.prn');
         END;
        writeln(glst,stri);
        Cont := Cont+1;
        IF Cont MOD NPperPag = 0 THEN
         BEGIN
            WriteTesto(data_drive+'UltSpe.prn');
            SaltoPag;
            Cont := 1;
         END;
      until Eof(ff);;
      IF Cont MOD NPperPag <> 0 THEN
        BEGIN
          WriteTesto(data_drive+'UltSpe.prn');
          SaltoPag;
        END;
      erase(ff);
    END;

  PROCEDURE lettura_maschera_input(var chiave:integer;prog:string);
    VAR Campo,I : INTEGER;
      f1 : FILE OF rec_inp;
      f10 : TEXT;
      Maskera:string;
      SI:STRING[1];

  procedure FormatCod;
  var j:integer;
   begin
      for j:=1 to Max do
       begin
          if mul[j].tipo > '' then
              mul[j].tipo :=FormST(mul[j].tipo);
          if mul[j].tipo_giunzio > '' then
              mul[j].tipo_giunzio :=FormST(mul[j].tipo_giunzio);
          if mul[j].cod_giu_tras > '' then
              mul[j].cod_giu_tras :=FormST(mul[j].cod_giu_tras);
          if mul[j].rin_int_tip > '' then
              mul[j].rin_int_tip :=FormST(mul[j].rin_int_tip);
          if mul[j].bul_tipo > '' then
              mul[j].bul_tipo :=FormST(mul[j].bul_tipo);
       end;
   end;

    BEGIN
      {.. identificazione del file .cmt da caricare ..}
      ASSIGN(f10, data_drive+'corren.mto');
      RESET(f10);
      READ(f10, progcmt);
      CLOSE(f10);

      IF Exist(data_drive+progcmt+'.cmt') THEN
        BEGIN
          AZZERA_MUL;
          { se esiste la tabella per quel progetto la devo leggere }
          ASSIGN(f1, data_drive+progcmt+'.cmt');
          RESET(f1);
          I:=0;
          WHILE NOT EOF(F1) DO
           BEGIN
              I:=I+1;
              READ(f1, mul[I]);
           END;
          FormatCod;
          CLOSE(f1);
        END
      ELSE azzera_mul;
      InitMask := TRUE;
      Campo := 1;  Riga := 1;
      Chiave:=0;

      REPEAT
        Mess[1]:=' Scheda Tipologica : '+upstring(progcmt);

        IOTabella(Seg(Mul[1]),Ofs(Mul[1]),Max,10,14,Chiave,Riga,Campo,Data_Drive+'Input.msk',
                    false,InitMask,not InitMask,false);
        scrittura_cmt;

        if Chiave = 59 then
         begin
            FormatCod;
            azzera_totali;
            azzera_record_di_stampa;
            dividi;
            lettura;
            ASSIGN(glst, data_drive+'stampe.lst');
            REWRITE(glst);
                Calcolo_totali(prog);
                stampa(prog);
                ordina;
                stampabulloni(prog);
                ordinarinforzi;
                stamparinforzi(prog);
                ordinaspessori;
                stampaspessori(prog);
                GOTOXY(1,21); WRITE(' VUOI LA STAMPA DEI PEZZI SPECIALI (s/n) ');
                READLN(SI); SI:=UPCASE(SI[1]);
                IF SI='S' THEN stampapezzi(prog);
            CLOSE(glst);
         end;

        if Chiave = 60 then stampalst;
(*         begin
                varstampa := 'ls1';
                stampalst(varstampa,prog);
                varstampa := 'lst';
                stampalst(varstampa,prog);
                varstampa := 'bul';
                stampalst(varstampa,prog);
                varstampa := 'rnf';
                stampalst(varstampa,prog);
                varstampa := 'sps';
                stampalst(varstampa,prog);
                GOTOXY(1,21); WRITE(' VUOI LA STAMPA DEI PEZZI SPECIALI (s/n) ');
                READLN(SI); SI:=UPCASE(SI[1]);
                IF SI='S' THEN
                 BEGIN
                    varstampa := 'lsp';
                    stampalst(varstampa,prog);
                 END;
         end; *)
      UNTIL (Chiave = 27) or (Chiave = 61);
    END;



  PROCEDURE ArchProg(prog:string);
    CONST NProgetti = 100;
    TYPE RecProg = RECORD
                     Descr : STRING[50];
                     Nome : STRING[18];
                   END;
      Archivio = ARRAY[1..NProgetti] OF RecProg;
    VAR i, Chiave, Campo : INTEGER;
      VProg : Archivio;
      f : FILE OF Archivio;
      f10 : TEXT;
      InitMask : BOOLEAN;
      NomeArch:string;

    PROCEDURE LoadArch;
      VAR i : INTEGER;
      BEGIN
        IF Exist(NomeArch) THEN
          BEGIN
            ASSIGN(f, NomeArch);
            RESET(f);
            READ(f, VProg);
            CLOSE(f);
          END
        ELSE
          BEGIN
            FOR i := 1 TO NProgetti DO
              WITH VProg[i] DO
                BEGIN
                  Descr := '';
                  Nome := '';
                END;
          END;
      END;

    PROCEDURE SaveArch;
      BEGIN
        ASSIGN(f, NomeArch);
        REWRITE(f);
        WRITE(f, VProg);
        CLOSE(f);
      END;

    begin
      NomeArch:=Data_Drive+'mto.apg';
      campo:=1;
      CLRSCR;
      LoadArch;
      InitMask := TRUE;
      REPEAT
        IOTabella(SEG(VProg), OFS(VProg), NProgetti, 10, 2, Chiave,Riga,campo,
                    Data_Drive+'Arkmto.msk',true, InitMask, NOT InitMask,false);

        InitMask := FALSE;
        CASE Chiave OF
          59 : WITH VProg[NProgetti] DO
                 IF (Nome = '') AND (Descr = '') THEN
                   BEGIN      {inserimento riga}
                     FOR i := NProgetti DOWNTO Riga+1 DO
                       VProg[i] := VProg[i-1];
                     WITH VProg[Riga] DO
                       BEGIN
                         Descr := '';
                         Nome := '';
                       END;
                   END
                 ELSE WRITE(CHR(7));
          60 : BEGIN
                 IF Conferma('Duct.msg','Confermi s/n ',4) then
                   BEGIN
                     FOR i := Riga TO NProgetti-1 DO
                       VProg[i] := VProg[i+1];
                     WITH VProg[NProgetti] DO
                       BEGIN
                         Descr := '';
                         Nome := '';
                       END;
                     NProg := '';
                   END;
               END;
          61 : BEGIN
                 NProg := VProg[Riga].Nome;
                 IF NProg > '' THEN
                   BEGIN
                     ASSIGN(f10, data_drive+'corren.mto');
                     REWRITE(f10);
                     WRITE(f10, nprog);
                     CLOSE(f10);
                     lettura_maschera_input(chiave,prog);
                     InitMask:=true;
                   END
                 ELSE WRITE(CHR(7));
               END;
        END;

      UNTIL (Chiave = 27) ;
      SaveArch;
    END;




{  procedure computo(Prog1:string;var scelta:integer);}

  BEGIN                       { main }

     if Exist('Drive1.int') then
        begin
           assign(ff,'drive1.int');
           reset(ff);
           read(ff,Data_Drive);
           close(ff);
          { DATA_DRIVE := Data_Drive+'\DATICCA\';}
           DATA_DRIVE := Data_Drive+'\CCA\';
        end
    else  {DATA_DRIVE := '\DATICCA\';}
           DATA_DRIVE := '\CCA\';
   if exist(DATA_DRIVE+'prog.can') then
    begin
      assign(ff,DATA_DRIVE+'prog.can');
      reset(ff);
      read(ff,prog);
      close(ff);
    end;

    ReadColor;
    Mouse_init;
    CtrlKey:=1;
    textbackground(col[1]);
    window(1,3,80,25);
(*
    nomeprogetto:='  MC4 Software ==> Duct rev. 5.00';
    if prog >'' then
    begin
       nomeprogetto:=Nomeprogetto+'  Progetto Nø '+Prog+'  '+CaricaMisure(Prog);
    end;
*)
    SPZT := 0;
{    for conta:=1 to 100 do
     begin}
    NEW(a1);   NEW(a2);   NEW(b1);
    NEW(b2);   NEW(c1);   NEW(c2);
    NEW(g1); {  NEW(FlagB);  NEW(Prn);}
{     end;}
    conta := 0;
    TotRighe := 0;  Tbmw := 0;
    Tktm := 0;      Tnut := 0;
    TSPG := 0;
    risposta := '';

    Archprog(prog);

    Dispose(a1);  Dispose(a2);  Dispose(b1);
    Dispose(b2);  Dispose(c1);  Dispose(c2);
    Dispose(g1);
    { Dispose(FlagB);  Dispose(Prn);
    Dispose(Archivio);
  END;}
end.
