{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$M 65000,16384,655360} {Turbo 3 default stack and heap}
{$F+}
{$O+}

unit defcom;

interface
uses defuti;

  CONST

    max = 60;                 { elementi di rec_inp }
    nusc = 3;
    nlinee = 32;
    npezzi = 260;
    maxpezzi = 400;           { massimo di elementi in stampa }
    ltabramo = 16;
  TYPE
    rec_inp = RECORD
                Tipo : st1;   { record di input da input.msk}
                lato_maggiore : INTEGER;
                lung_max_tron : INTEGER;
                lam_spessore : REAL;
                lam_peso : REAL;
                tipo_giunzio : STRING[2];
                cod_giu_tras : STRING[7];
                pes_giu_tras : REAL;
                rin_int_num : INTEGER;
                rin_int_tip : STRING[6];
                rin_int_pes : REAL;
                bul_tipo : STRING[3];
                bul_passo : INTEGER;
                bul_peso : REAL;
              END;
    RigaArch = RECORD
                 CodPezzo : STRING[5];
                 Descr : STRING[40];
                 CodDis : INTEGER;
                 Main, Branch, Fonte : STRING[8];
                 Varie : STRING[10];
                 TipoSez : STRING[5];
                 NUscite : INTEGER;
               END;           { 95 }

    RigaRamo = RECORD
                 Cod : STRING[5];
                 Descr : STRING[40];
                 CHFlag : CHAR;
                 portata, perdita : REAL;
                 D, A, B, ang, phi : INTEGER;
                 LUNGH, r, comval : REAL;
                 c0, x, y : REAL;
               END;

{    ST18 = STRING[18];}
    Link = ^TabRamo;
    TabRamo = RECORD
                t : ARRAY[0..ltabramo] OF rigaramo;
                ps, pd, pc : link;
                tr : BOOLEAN;
                CODTAB : INTEGER;
              END;

    testata1 = RECORD
                 name : st18;
                 data : st80;
                 pag : INTEGER;
                 ntab : st80;
               END;
    record_di_stampa = RECORD
                         count : INTEGER;
                         tratto_da : STRING[3];
                         tratto_a : STRING[3];
                         codice_pezzo : STRING[5];
                         dim_a, dim_b, Dim_d : INTEGER;
                         lunghezza_tratto : REAL;
                         Lamiera_superficie : REAL;
                         lamiera_peso : REAL;
                         Numero_giunzioni : INTEGER;
                         cdcg : STRING[7];
                         l_giunzioni : REAL;
                         peso_giunzioni : REAL;
                         numero_rinforzi : INTEGER;
                         cdcr : STRING[6];
                         l_rinforzi : REAL;
                         peso_rinforzi : REAL;
                         tipo_bulloni : STRING[3];
                         n_bulloni : INTEGER;
                         peso_bulloni : REAL;
                         totale_peso : REAL;
                       END;
    bulloneinstampa = RECORD
                        codicebullone : STRING[3];
                        quantitabullone : INTEGER;
                        pesobullone : REAL;
                      END;
    SPIGOLOINSTAMPA = RECORD
                        codiceSPG : STRING[3];
                        quantitaSPG : REAL;
                        pesoSPG : REAL;
                      END;
    rinforzoinstampa = RECORD
                         codrinf : STRING[6];
                         numrinf : INTEGER;
                         pesrinf : REAL;
                       END;
    lamiera = RECORD
                tot : INTEGER;
                sps : REAL;
                sup : REAL;
                pes : REAL;
              END;
    record_totali = RECORD
                      l_t_tratto : REAL;
                      s_t_lamiera : REAL;
                      l_t_peso : REAL;
                      n_t_giunzioni : INTEGER;
                      l_t_giunzioni : REAL;
                      p_t_giunzioni : REAL;
                      n_t_rinforzi : INTEGER;
                      l_t_rinforzi : REAL;
                      p_t_rinforzi : REAL;
                      n_t_bulloni : INTEGER;
                      p_t_bulloni : REAL;
                      N_T_DEFAULT : REAL;
                      P_T_DEFAULT : REAL;
                      N_T_SPIGOLI : REAL;
                      P_T_SPIGOLI : REAL;
                      n_t_morsetti:real;
                      p_t_morsetti:real;
                      p_t_totale : REAL
                    END;
    TabArch = ARRAY[1..NPezzi] OF RigaArch;
    bln = ARRAY[1..250] OF bulloneinstampa;
    bl1 = ARRAY[1..250] OF bulloneinstampa;
    rnf = ARRAY[1..250] OF rinforzoinstampa;
    bl2 = ARRAY[1..250] OF rinforzoinstampa;
    AX1 = ARRAY[1..250] OF SPIGOLOINSTAMPA;
    lmr = ARRAY[1..250] OF lamiera;
    bl3 = ARRAY[1..250] OF lamiera;


    RecPezSpe=record
                 Cod : STRING[5];
                 Descr : STRING[40];
		 D, A, B, ang : INTEGER;
		 r, LUNGH : REAL;
               END;



  VAR
    StamPezSpe:RecPezSpe;
    data_drive : string;
    filedati : FILE OF TabRamo;
    comodo, code : INTEGER;
    a1 : ^bln;
    a2 : ^bl1;
    b1 : ^rnf;
    b2 : ^bl2;
    c1 : ^lmr;
    c2 : ^bl3;
    G1 : ^AX1;
    bul_default,spg_default : real;
    riga : INTEGER;
    archivio : ^tabarch;
    test1 : testata1;
    count_giunzioni : REAL;
    filearchivio : STRING[40];
    ff : TEXT;
    InitMask,Errore : BOOLEAN;
    mul : ARRAY[1..MAX] OF rec_inp;
    SPZT : REAL;
    riepilfinbul : INTEGER;
    flagb :ARRAY[1..250] OF BOOLEAN;
    prn :ARRAY[1..maxpezzi] OF record_di_stampa;
    risposta : STRING[1];
    Tbmw, Tktm, Tnut ,TSPG : INTEGER;
    n : INTEGER;
    parzialebull : INTEGER;
    n_stringa : INTEGER;
    n_stringa1 : INTEGER;
    n_stringa2 : INTEGER;
    retvet : ARRAY[1..Max, 1..2] OF INTEGER;
    cirvet : ARRAY[1..Max, 1..2] OF INTEGER;
    conta : INTEGER;
    OK : INTEGER;
    p : Link;
    progcmt : STRING[18];
    nprog,prog:string;
    stringa : STRING[2];
    stringa1 : STRING[2];
    stringa2 : STRING[2];
    stringa3 : STRING[2];
    tot : record_totali;
    IAIAO : INTEGER;
    varstampa : st3;
{    z : INTEGER;
    z1 : REAL;}
    TotRighe:integer;
implementation
end.