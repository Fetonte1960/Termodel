
procedure percorri (p2 : link);
var z,j,i,o,OK:integer;
    bmw, ktm, nut ,SPG : INTEGER;
    g, oldj : INTEGER;
    c_gravita, temp, temp1 : REAL;
    mim : STRING[3];
    flag_tipo_giunzione, flag_diritto : BOOLEAN;

begin
          z:= TotRighe;  bmw := TBmw;  ktm := TKtm;
          nut := TNut;   SPG := TSpg;  oldj := 0;
          FOR J := 1 TO ltabramo DO
            WITH P2^.t[J] DO
              BEGIN
                IF ((Cod > '') AND ((A+B > 0) OR (D > 0))) THEN
                  BEGIN
                    OK := 1;
                    Cod := FormSt(Cod);

                    {tutti i codici maiuscoli}
                    OK:=Find_archivio(Cod);
{                    writeln(' Codice ',cod,' OK ',ok);}
                    if OK <> 0 then
                    begin
{                    WHILE (Cod <> archivio^[OK].codpezzo) AND (OK < npezzi) DO OK := OK+1;}

                    IF ((Archivio^[OK].coddis = 1) AND (ARCHIVIO^[OK].MAIN = '')) THEN
                      { se codice disegno = 1 il pezzo e' canale diritto }
                      BEGIN
                        IF (A <> 0) AND (B <> 0) THEN {rettangolare}
                          BEGIN
                            IF A > B THEN
                              comodo := A
                            ELSE
                              comodo := B;
                            flag_tipo_giunzione := FALSE;
                            I := indice(comodo, 'R');
                            z := z+1;
                            count_giunzioni := 0;
                            Prn[z].count := z;
                            STR(oldj:3, mim);
                            FOR o := 1 TO 3 DO IF mim[o] = ' ' THEN mim[o] := '0';
                            Prn[z].tratto_da := mim;
                            STR(P2^.codtab:3, mim);
                            FOR o := 1 TO 3 DO IF mim[o] = ' ' THEN mim[o] := '0';
                            Prn[z].tratto_a := mim;
                            oldj := P2^.codtab;
                            Prn[z].codice_pezzo := cod;
                            Prn[z].dim_a := a;
                            Prn[z].dim_b := b;
                            Prn[z].Dim_d := d;
                            Prn[z].lunghezza_tratto := lungh;
                            writeln(' valore ind ',i:4); delay (1500);
                            IF (mul[i].tipo_giunzio[1] = 'S') THEN
                              BEGIN
                                {tronchi diritti rettangolari saldati longitudinalmente}
                                {calcolo superficie della lamiera}
                                Prn[z].Lamiera_superficie := (2*(a+b)*(lungh*1000))*0.000001;
                                {calcolo peso della lamiera}
                                Prn[z].lamiera_peso := Prn[z].lamiera_superficie*mul[i].lam_peso;
                                flag_tipo_giunzione := TRUE;
			      END;
			    IF (mul[i].tipo_giunzio = 'G1') THEN
                              BEGIN
                                {tronchi diritti rettangolari graffati pittsburg agli spigoli}
                                {calcolo superficie della lamiera}
                                Prn[z].Lamiera_superficie := (2*(a+b+40)*(lungh*1000))*0.000001;
                                {calcolo peso della lamiera}
                                Prn[z].lamiera_peso := Prn[z].lamiera_superficie*mul[i].lam_peso;
                                flag_tipo_giunzione := TRUE;
                              END;
			    IF (mul[i].tipo_giunzio = 'G2') THEN
                              BEGIN
                                {tronchi diritti rettangolari con 2 graffature agli spigoli opposti}
                                {calcolo superficie della lamiera}
                                Prn[z].Lamiera_superficie := (2*(a+b+40)*(lungh*1000))*0.000001;
                                {calcolo peso della lamiera}
                                Prn[z].lamiera_peso := Prn[z].lamiera_superficie*mul[i].lam_peso;
                                flag_tipo_giunzione := TRUE;
                              END;
                            IF flag_tipo_giunzione = FALSE THEN
                              BEGIN
                                CLRSCR;
                                WRITE(CHR(7));
                                WRITELN('Codice Giunzione ', mul[i].tipo_giunzio, ' inadeguato per canali rettangolari');
                                delay(3000);
                                Exit;
                              END;
                            nut := nut+1;
                            c1^[nut].sps := mul[i].lam_spessore;
                            c1^[nut].sup := Prn[z].lamiera_superficie;
                            c1^[nut].pes := Prn[z].lamiera_peso;
                            IF mul[i].cod_giu_tras > '' THEN
                              BEGIN
                                Prn[z].cdcg := mul[i].cod_giu_tras;
                                stringa := mul[i].cod_giu_tras;
                                stringa := FormSt(stringa);
                                IF (stringa = 'BP') OR
                                (stringa = 'FS') OR
                                (stringa = 'FP') THEN
                                  BEGIN
                                    {calcolo numero di giunzioni}
                                    IF ((lungh*1000)/mul[i].lung_max_tron <= 1) THEN
                                      count_giunzioni := 1;
                                    count_giunzioni :=
                                    count_giunzioni+INT((lungh*1000)/mul[i].lung_max_tron)-1;
                                    IF FRAC((lungh*1000)/mul[i].lung_max_tron) > 0 THEN
                                      count_giunzioni := count_giunzioni+1;
                                    Prn[z].Numero_giunzioni := TRUNC(count_giunzioni);
                                    {calcolo lunghezza delle giunzioni}
                                    IF (stringa = 'BP') OR (stringa = 'FS') THEN
                                      {tipo giunzioni : baionette piane}
                                      {tipo giunzioni : flange sagomate} {bullonate ai 4 spigoli}
                                      BEGIN
                                        SPZT := (2*(A+B));
                                        Prn[z].l_giunzioni := SPZT*0.001;
{                                        writeln(' Z ',z:3,' Lung Giunz ',Prn[i].l_giunzioni); delay (1000);}
                                      END;
                                    IF (stringa = 'FP') THEN
                                      {tipo giunzioni : flange profilate} {saldate ai 4 spigoli}
                                      BEGIN
                                        stringa:='';
                                        stringa[1]:=mul[i].cod_giu_tras[3];
                                        stringa[2]:=mul[i].cod_giu_tras[4];
                                        VAL(stringa, n_stringa, code);
                                        SPZT := (2*(a+2*n_stringa));
                                        Prn[z].l_giunzioni := (SPZT+(2*b))*0.001;
                                      END;
                                    {peso giunzioni}
                                    Prn[z].peso_giunzioni := Prn[z].l_giunzioni*
                                    mul[i].pes_giu_tras;
                                    Prn[z].peso_giunzioni := Prn[z].peso_giunzioni*
                                    Prn[z].Numero_giunzioni;
                                  END
                                ELSE {if (stringa = 'bp') or (stringa = 'fs') or (stringa = 'fp') then}
                                  BEGIN
                                    CLRSCR;
                                    WRITE(CHR(7));
                                    WRITELN('Codice Giunzione Trasvers. ', mul[i].cod_giu_tras);
                                    WRITELN('Inadeguato per canali rettangolari ');
                                    delay(3000);
                                    Exit;
                                  END;
                              END;
                            {bulloni}
                            IF ((mul[i].bul_tipo > '') AND
                            (mul[i].bul_passo > 0) AND
                            (mul[i].bul_peso > 0)) THEN
                              BEGIN
                                Prn[z].tipo_bulloni := mul[i].bul_tipo;
                                Prn[z].n_bulloni := TRUNC(((2*(a+b))/mul[i].bul_passo)*
                                Prn[z].numero_giunzioni);
                                Prn[z].peso_bulloni := Prn[z].n_bulloni*mul[i].bul_peso;
                                {.. caricamento del record di stampa ..}
                                bmw := bmw+1;
                                a1^[bmw].codicebullone := mul[i].bul_tipo;
                                a1^[bmw].quantitabullone := Prn[z].n_bulloni;
                                a1^[bmw].pesobullone := Prn[z].peso_bulloni;
                              END;
                            {rinforzi}
                            IF mul[i].rin_int_tip > '' THEN
                              BEGIN
                                Prn[z].cdcr := mul[i].rin_int_tip;
                                stringa := mul[i].rin_int_tip;
                                stringa := FormST(stringa);
                                IF (stringa = 'PB') OR (STRINGA = 'LP') THEN
                                  BEGIN
                                    temp1 := (lungh*1000)/(mul[i].lung_max_tron);
                                    IF temp1 < 1 THEN temp1 := 1;
                                    Prn[z].numero_rinforzi := TRUNC(temp1*mul[i].rin_int_num*1.00);
                                    {lunghezza rinforzi}
                                    {leggo la lunghezza del profilato da mul[i].rin_int_tip [3..4] }
                                    stringa:='';
                                    stringa[1]:=mul[i].rin_int_tip[3];
                                    stringa[2]:=mul[i].rin_int_tip[4];
                                    VAL(stringa, n_stringa, code);
                                    Prn[z].l_rinforzi := ((2*(a+b))+8*n_stringa)*0.001;
                                    {peso dei rinforzi}
                                    temp1 := Prn[z].l_rinforzi*mul[i].rin_int_pes;
                                    Prn[z].peso_rinforzi := temp1*Prn[z].numero_rinforzi;
                                    ktm := ktm+1;
                                    b1^[ktm].codrinf := Prn[z].cdcr;
                                    b1^[ktm].numrinf := Prn[z].numero_rinforzi;
                                    b1^[ktm].pesrinf := Prn[z].peso_rinforzi;
                                  END;
                                IF stringa = 'PS' THEN
                                  BEGIN
                                    temp1 := (lungh*1000)/(mul[i].lung_max_tron);
                                    IF temp1 < 1 THEN temp1 := 1;
                                    Prn[z].numero_rinforzi := TRUNC(temp1*mul[i].rin_int_num*1.00);
                                    {lunghezza rinforzi}
                                    {leggo la lunghezza del profilato da mul[i].rin_int_tip [3..4] }
                                    stringa:='';
                                    stringa[1]:=mul[i].rin_int_tip[3];
                                    stringa[2]:=mul[i].rin_int_tip[4];
                                    VAL(stringa, n_stringa, code);
                                    Prn[z].l_rinforzi := ((2*(a+(2*n_stringa)))+(2*b))*0.001;
                                    {peso dei rinforzi}
                                    temp1 := Prn[z].l_rinforzi*mul[i].rin_int_pes;
                                    Prn[z].peso_rinforzi := temp1*Prn[z].numero_rinforzi;
                                    ktm := ktm+1;
                                    b1^[ktm].codrinf := Prn[z].cdcr;
                                    b1^[ktm].numrinf := Prn[z].numero_rinforzi;
                                    b1^[ktm].pesrinf := Prn[z].peso_rinforzi;
                                  END;
                              END;

                            bul_default :=0;
			    spg_default :=0;

                            {.. conteggio dei bulloni di default ..}

                            stringa := '';
                            stringa := mul[i].cod_giu_tras;
                            stringa := FormST(stringa);
                            stringa2:='';
                            stringa2[1]:=mul[i].COD_GIU_TRAS[3];
                            stringa2[2]:=mul[i].COD_GIU_TRAS[4];
                            VAL(stringa2, n_stringa1, code);
                            IF (stringa = 'FS') THEN
                              BEGIN
                                CASE N_STRINGA1 OF
                                  0..20 : BEGIN
                                            BMW := BMW+1;
                                            A1^[BMW].CODICEBULLONE := '8M ';
                                            A1^[BMW].QUANTITABULLONE := 4*Prn[Z].NUMERO_GIUNZIONI;
                                            A1^[BMW].PESOBULLONE := 4*0.0191*Prn[Z].NUMERO_GIUNZIONI;
                                            bul_default := A1^[BMW].PESOBULLONE;
{ calcolo e peso spigoli

  fs20 ... 8 spigoli 0.53 kg
  fs30 ... 8 spigoli 1.15 kg
  fs40 ... 8 spigoli 2.24 kg}
                                            SPG := SPG + 1;
                                            G1^[SPG].CODICESPG := 'S20';
                                            G1^[SPG].QUANTITASPG := 8*Prn[Z].NUMERO_GIUNZIONI;
                                            G1^[SPG].PESOSPG := Prn[Z].NUMERO_GIUNZIONI*0.53;
                                            spg_default := G1^[SPG].PESOSPG;
                                          END;
                                  21..30 : BEGIN
                                             BMW := BMW+1;
                                             A1^[BMW].CODICEBULLONE := '10M';
                                             A1^[BMW].QUANTITABULLONE := 4*Prn[Z].NUMERO_GIUNZIONI;
                                             A1^[BMW].PESOBULLONE := 4*0.0391*Prn[Z].NUMERO_GIUNZIONI;
                                             bul_default := A1^[BMW].PESOBULLONE;
                                             SPG := SPG + 1;
                                             G1^[SPG].CODICESPG := 'S30';
                                             G1^[SPG].QUANTITASPG := 8*Prn[Z].NUMERO_GIUNZIONI;
                                             G1^[SPG].PESOSPG := Prn[Z].NUMERO_GIUNZIONI*1.15;
                                             spg_default := G1^[SPG].PESOSPG;
                                           END;
                                  31..40 : BEGIN
                                             BMW := BMW+1;
                                             A1^[BMW].CODICEBULLONE := '12M';
                                             A1^[BMW].QUANTITABULLONE := 4*Prn[Z].NUMERO_GIUNZIONI;
                                             A1^[BMW].PESOBULLONE := 4*0.0602*Prn[Z].NUMERO_GIUNZIONI;
                                             bul_default := A1^[BMW].PESOBULLONE;
                                             SPG := SPG + 1;
                                             G1^[SPG].CODICESPG := 'S40';
                                             G1^[SPG].QUANTITASPG := 8*Prn[Z].NUMERO_GIUNZIONI;
                                             G1^[SPG].PESOSPG := Prn[Z].NUMERO_GIUNZIONI*2.24;
                                             spg_default := G1^[SPG].PESOSPG;
                                          END;
                                END;
                                stringa1 := '';
                                stringa1 := mul[i].rin_int_tip;
                                stringa1 := FormST(stringa1);
                                stringa3:='';
                                stringa3[1]:=mul[i].rin_int_tip[3];
                                stringa3[2]:=mul[i].rin_int_tip[4];
                                VAL(stringa3, n_stringa2, code);
                                IF (stringa1 = 'PB') OR (stringa1 = 'LP') THEN
                                  BEGIN
                                    CASE N_STRINGA2 OF
                                      0..45 : BEGIN
                                                BMW := BMW+1;
                                                A1^[BMW].CODICEBULLONE := '8M ';
                                                A1^[BMW].QUANTITABULLONE := 4*Prn[Z].NUMERO_RINFORZI;
                                                A1^[BMW].PESOBULLONE := 4*0.0191*Prn[Z].NUMERO_RINFORZI;
                                                bul_default := A1^[BMW].PESOBULLONE;
                                              END;
                                      46..60 : BEGIN
                                                 BMW := BMW+1;
                                                 A1^[BMW].CODICEBULLONE := '10M';
                                                 A1^[BMW].QUANTITABULLONE := 4*Prn[Z].NUMERO_RINFORZI;
                                                 A1^[BMW].PESOBULLONE := 4*0.0391*Prn[Z].NUMERO_RINFORZI;
                                                 bul_default := A1^[BMW].PESOBULLONE;
                                               END;
                                      61..80 : BEGIN
                                                 BMW := BMW+1;
                                                 A1^[BMW].CODICEBULLONE := '12M';
                                                 A1^[BMW].QUANTITABULLONE := 4*Prn[Z].NUMERO_RINFORZI;
                                                 A1^[BMW].PESOBULLONE := 4*0.0602*Prn[Z].NUMERO_RINFORZI;
                                                 bul_default := A1^[BMW].PESOBULLONE;
                                               END;
                                    END;
                                  END;
                              END;
                            IF (stringa = 'BP') THEN
                              BEGIN
                                stringa1 := '';
                                stringa1 := mul[i].rin_int_tip;
                                stringa1 := FormST(stringa1);
                                stringa3:='';
                                stringa3[1]:=mul[i].rin_int_tip[3];
                                stringa3[2]:=mul[i].rin_int_tip[4];
                                VAL(stringa3, n_stringa2, code);
                                IF (stringa1 = 'LP') THEN
                                  BEGIN
                                    CASE N_STRINGA2 OF
                                      0..45 : BEGIN
                                                BMW := BMW+1;
                                                A1^[BMW].CODICEBULLONE := '8M ';
                                                A1^[BMW].QUANTITABULLONE := 4*Prn[Z].NUMERO_RINFORZI;
                                                A1^[BMW].PESOBULLONE := 4*0.0191*Prn[Z].NUMERO_RINFORZI;
                                                bul_default := A1^[BMW].PESOBULLONE;
                                              END;
                                      46..60 : BEGIN
                                                 BMW := BMW+1;
                                                 A1^[BMW].CODICEBULLONE := '10M';
                                                 A1^[BMW].QUANTITABULLONE := 4*Prn[Z].NUMERO_RINFORZI;
                                                 A1^[BMW].PESOBULLONE := 4*0.0391*Prn[Z].NUMERO_RINFORZI;
                                                 bul_default := A1^[BMW].PESOBULLONE;
                                               END;
                                      61..80 : BEGIN
                                                 BMW := BMW+1;
                                                 A1^[BMW].CODICEBULLONE := '12M';
                                                 A1^[BMW].QUANTITABULLONE := 4*Prn[Z].NUMERO_RINFORZI;
                                                 A1^[BMW].PESOBULLONE := 4*0.0602*Prn[Z].NUMERO_RINFORZI;
                                                 bul_default := A1^[BMW].PESOBULLONE;
                                               END;
                                    END;
                                  END;
                              END;
                            IF (stringa = 'FP') THEN
                              BEGIN
                                stringa1 := '';
                                stringa1 := mul[i].rin_int_tip;
                                stringa1 := FormST(stringa1);
                                stringa3:='';
                                stringa3[1]:=mul[i].rin_int_tip[3];
                                stringa3[2]:=mul[i].rin_int_tip[4];
                                VAL(stringa3, n_stringa2, code);
                                IF (STRINGA1 = 'PB') OR (stringa1 = 'LP') THEN
                                  BEGIN
                                    CASE N_STRINGA2 OF
                                      0..45 : BEGIN
                                                BMW := BMW+1;
                                                A1^[BMW].CODICEBULLONE := '8M ';
                                                A1^[BMW].QUANTITABULLONE := 4*Prn[Z].NUMERO_RINFORZI;
                                                A1^[BMW].PESOBULLONE := 4*0.0191*Prn[Z].NUMERO_RINFORZI;
                                                bul_default := A1^[BMW].PESOBULLONE;
                                              END;
                                      46..60 : BEGIN
                                                 BMW := BMW+1;
                                                 A1^[BMW].CODICEBULLONE := '10M';
                                                 A1^[BMW].QUANTITABULLONE := 4*Prn[Z].NUMERO_RINFORZI;
                                                 A1^[BMW].PESOBULLONE := 4*0.0391*Prn[Z].NUMERO_RINFORZI;
                                                 bul_default := A1^[BMW].PESOBULLONE;
                                               END;
                                      61..80 : BEGIN
                                                 BMW := BMW+1;
                                                 A1^[BMW].CODICEBULLONE := '12M';
                                                 A1^[BMW].QUANTITABULLONE := 4*Prn[Z].NUMERO_RINFORZI;
                                                 A1^[BMW].PESOBULLONE := 4*0.0602*Prn[Z].NUMERO_RINFORZI;
                                                 bul_default := A1^[BMW].PESOBULLONE;
                                               END;
                                    END;
                                  END;
                              END;
                            {.. fine del conteggio bulloni di default ..}

                            Prn[z].totale_peso := Prn[z].lamiera_peso+
                            Prn[z].peso_giunzioni+
                            Prn[z].peso_rinforzi+
                            Prn[z].peso_bulloni+
                            bul_default+
                            spg_default;
                          END
                        ELSE {if (a <> 0) and (b <> 0) then} {circolare}
                          BEGIN
                            flag_tipo_giunzione := FALSE;
                            I := indice(D, 'C');
                            z := z+1;
                            count_giunzioni := 0;
                            Prn[z].count := z;
                            STR(oldj:3, mim);
                            FOR o := 1 TO 3 DO IF mim[o] = ' ' THEN mim[o] := '0';
                            Prn[z].tratto_da := mim;
                            STR(P2^.codtab:3, mim);
                            FOR o := 1 TO 3 DO IF mim[o] = ' ' THEN mim[o] := '0';
                            Prn[z].tratto_a := mim;
                            oldj := P2^.codtab;
                            Prn[z].codice_pezzo := cod;
                            Prn[z].dim_a := a;
                            Prn[z].dim_b := b;
                            Prn[z].Dim_d := d;
                            Prn[z].lunghezza_tratto := lungh;
                            IF (mul[i].tipo_giunzio[1] = 'S') OR
                            (mul[i].tipo_giunzio[1] = 's') THEN
                              BEGIN
                                {tronchi diritti circolari saldati longitudinalmente}
                                {calcolo superficie della lamiera}
                                Prn[z].Lamiera_superficie := (3.1415*d*(lungh*1000))*0.000001;
                                {calcolo peso della lamiera}
                                Prn[z].lamiera_peso := Prn[z].lamiera_superficie*mul[i].lam_peso;
                                flag_tipo_giunzione := TRUE;
                              END;
			    IF (mul[i].tipo_giunzio = 'G1') then
                              BEGIN
                                {tronchi diritti circolari graffati longitudinalmente}
                                {calcolo superficie della lamiera}
                                Prn[z].Lamiera_superficie := (3.1415*(d+30)*(lungh*1000))*0.000001;
                                {calcolo peso della lamiera}
                                Prn[z].lamiera_peso := Prn[z].lamiera_superficie*mul[i].lam_peso;
                                flag_tipo_giunzione := TRUE;
                              END;
			    IF (mul[i].tipo_giunzio = 'G3') then
                              BEGIN
                                {tronchi diritti circolari graffati spiroidalmente}
                                {calcolo superficie della lamiera}
                                Prn[z].Lamiera_superficie := (3.585*d*(lungh*1000))*0.000001;
                                {calcolo peso della lamiera}
                                Prn[z].lamiera_peso := Prn[z].lamiera_superficie*mul[i].lam_peso;
                                flag_tipo_giunzione := TRUE;
                              END;
                            IF flag_tipo_giunzione = FALSE THEN
                              BEGIN
                                CLRSCR;
                                WRITE(CHR(7));
                                TEXTCOLOR(Col[4]);
                                WRITELN('Codice Giunzione ', mul[i].tipo_giunzio, ' inadeguato per canali circolari');
                                delay(3000);
                                Exit;
                              END;
                            nut := nut+1;
                            c1^[nut].sps := mul[i].lam_spessore;
                            c1^[nut].sup := Prn[z].lamiera_superficie;
                            c1^[nut].pes := Prn[z].lamiera_peso;
                            IF mul[i].cod_giu_tras > '' THEN
                              BEGIN
                                Prn[z].cdcg := mul[i].cod_giu_tras;
                                stringa := mul[i].cod_giu_tras;
                                stringa := FormST(stringa);
                                IF (stringa = 'GN') OR
                                (stringa = 'GD') THEN
                                  BEGIN
                                    {calcolo numero di giunzioni}
                                    IF ((lungh*1000)/mul[i].lung_max_tron <= 1) THEN count_giunzioni := 1;
                                    count_giunzioni := count_giunzioni+INT((lungh*1000)/mul[i].lung_max_tron)-1;
                                    IF FRAC((lungh*1000)/mul[i].lung_max_tron) > 0 THEN
                                      count_giunzioni := count_giunzioni+1;
                                    Prn[z].Numero_giunzioni := TRUNC(count_giunzioni);
                                    {calcolo lunghezza delle giunzioni}
                                    IF (stringa = 'GN') THEN
                                      {tipo giunzioni : baionette piane}
                                      BEGIN
                                        Prn[z].l_giunzioni := (3.1415*d)*0.001;
                                      END;
                                    IF (stringa = 'GD') THEN
                                      BEGIN
                                        stringa:='';
                                        stringa[1]:=mul[i].cod_giu_tras[3];
                                        stringa[2]:=mul[i].cod_giu_tras[4];
                                        VAL(stringa, n_stringa, code);
                                        CASE n_stringa OF
                                          0..25 : c_gravita := 7.2;
                                          26..30 : c_gravita := 8.4;
                                          31..35 : c_gravita := 9.6;
                                          36..40 : c_gravita := 11.2;
                                          41..45 : c_gravita := 12.8;
                                          46..50 : c_gravita := 14;
                                          51..60 : c_gravita := 16.9;
                                          61..70 : c_gravita := 19.7;
                                          71..999 : c_gravita := 22.6;
                                        END;
                                        temp := (d+(2*c_gravita));
                                        Prn[z].l_giunzioni := (3.1415*temp)*0.001;
                                      END;
                                    {peso giunzioni}
                                    Prn[z].peso_giunzioni := Prn[z].l_giunzioni*mul[i].pes_giu_tras;
                                    Prn[z].peso_giunzioni := Prn[z].peso_giunzioni*Prn[z].Numero_giunzioni;


                                  END
                                ELSE {if (stringa = 'gn') or (stringa = 'gd') then}
                                  BEGIN
                                    CLRSCR;
                                    WRITE(CHR(7));
                                    WRITELN('Codice Giunzione Trasvers. ', mul[i].cod_giu_tras);
                                    WRITELN('Inadeguato per canali circolari ');
                                    delay(3000);
                                    exit;
                                  END;
                              END; {..mul[i].cod_giu_tras > '' then..}
                            IF ((mul[i].bul_tipo > '') AND
                            (mul[i].bul_passo > 0) AND
                            (mul[i].bul_peso > 0)) THEN
                              BEGIN
                                Prn[z].tipo_bulloni := mul[i].bul_tipo;
                                Prn[z].n_bulloni := TRUNC(((2*(d/2)*3.1415)/mul[i].bul_passo)*
                                Prn[z].numero_giunzioni);
                                Prn[z].peso_bulloni := Prn[z].n_bulloni*mul[i].bul_peso;
                                bmw := bmw+1;
                                a1^[bmw].codicebullone := mul[i].bul_tipo;
                                a1^[bmw].quantitabullone := Prn[z].n_bulloni;
                                a1^[bmw].pesobullone := Prn[z].peso_bulloni;
                              END;
                            Prn[z].totale_peso := Prn[z].lamiera_peso+
                            Prn[z].peso_giunzioni+
                            Prn[z].peso_bulloni;
                          END; {else if (a <> 0) and (b <> 0) then }
		      END    {.. archivio^[ok].coddis = 1 then ..}
		     else
                      begin
{                      writeln(' Codice pezzo speciale ',Archivio^[OK].codPezzo,'  ',Cod,'Ind ',OK:3);}
                      IF (Archivio^[OK].codPezzo = Cod) THEN
                      begin
               	         StamPezSpe.Cod:=P2^.t[J].Cod;
			 StamPezSpe.Descr:=archivio^[OK].DESCR;
			 StamPezSpe.D:=P2^.t[J].D;
			 StamPezSpe.A:=P2^.t[J].A;
			 StamPezSpe.B:=P2^.t[J].B;
			 StamPezSpe.ang:=P2^.t[J].ANG;
			 StamPezSpe.R:=P2^.t[J].R;
			 StamPezSpe.LUNGH:=P2^.t[J].LUNGH;
                         stampamask(SEG(StamPezSpe), OFS(StamPezSpe), data_drive+'cmtspe.prn', TRUE);
		       end;
                     end;
                  END;        {..((cod > 0 ) and ((a+b>0) or (d>0)) then..}
              END;            {.. with p2^.t1[j] do ..}
          end;
         TotRighe:=Z;  TBmw:=bmw;  TKtm:=ktm;
         TNut:=nut;    TSpg:=SPG;

{         writeln(' TOTRIGHE ',TOTRIGHE:5); delay(1000);}

end;

