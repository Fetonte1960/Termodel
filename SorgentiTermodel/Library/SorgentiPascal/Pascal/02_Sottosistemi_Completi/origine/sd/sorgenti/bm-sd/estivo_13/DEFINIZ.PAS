
Unit definiz;

Interface

Uses

  VariabiliGenerali;
  {defutig;}

(*{$ifdef francia}
{$I COSTCART.fra}
{$else}
{$I COSTCART.ita}
{$endif}*)



{$ifdef francia}
{$I \sorgenti\lavoro\carterm\COSTCART.fra}
{$ENDIF}

{$ifdef inglese}
{$I \sorgenti\lavoro\carterm\COSTCART.eng}
{$ENDIF}

{$ifdef italia}
{$I COSTCART.ita}
{$endif}

{$ifdef tedesco}
{$I \sorgenti\lavoro\carterm\COSTCART.ted}
{$endif}

{$ifdef spagna}
{$I \sorgenti\lavoro\carterm\COSTCART.esp}
{$ENDIF}
CONST
  versione = 700;
  versTXT  = '7.00';
  Maxsez  =40;
  MaxMuri=100;              {30->40}
  MaxFinestre=150;          {20->40}
  MaxPorte=20;             {10->20}
  MaxEsposizioni=100;
  MaxZone=30;              {10->20}
  MaxAmbienti=400;
  MaxFrontiere=1400;
  MaxPonti=30;
  MaxFrontiereLin=500;
  MaxProfili=10;
  MaxStrati=11;
  MaxStrutture=100;         {30->40}
  NProgetti=100;
  Maxtubaz=20;
  NMater = 950;
  MaxPav = 100;
  MaxTempAc=30;
  MaxGenerat=100;
  maxCapTermica=50;
  maxcarichiInterni=50;
  MaxPoint=16380;
  MaxPointAmb=5000;

CONST
  maxNStrutt = 150;
  COLTXTNRM=7;
  COLBAKNRM=0;

TYPE
  ST72=STRING[72];
  ST32=STRING[32];


  RecGen=RECORD
           Progetto,Committ,Progettista:STRING[50];
           Revisione:Integer;
           Data:STRING[20];
           Luogo:STRING[32];
         END;
  PunGen=^RecGen;

  type InMesi=record
             MeseIn,MeseFin:integer;
          end;


  RecLoc=RECORD
           Nome:STRING[64];
           Hmare,LAT,LON:REAL;      { altezza sul mare/latitudine/longitudine }
           MeridRifOra:REAL;        { Meridiano di riferimento orario         }

           {**********   BS=bulbo secco BU=bulbo umido   ************}
           TInvEsternaBS:REAL;      { Temperatura Invernale esterna }
           TInvEsternaBU:REAL;      {      "         "        "     }
           UInvEsterna:REAL;        { Umidita`       "        "     }

           TEstEsternaBS:REAL;      { Temperatura Estiva Esterna    }
           TEstEsternaBU:REAL;      {      "         "      "       }
           UEstEsterna:REAL;        { Umidita`       "      "       }

           ET:REAL;                 { Escursione Termica giornaliera }
           FattFoschia:REAL;        { Fattore di Foschia }
           Riflettivita:REAL;       { Coeff. Riflettivita` del terreno }
           OraLegInizio,OraLegFine:INTEGER;  { Inizio e fine ora legale   }

         END; { RecLoc }
  PunLoc=^RecLoc;


  RecEdif=RECORD
            TInvBS:REAL;           { Temperatura Invernale Bulbo Secco   }
            TEstBS:REAL;           { Temperatura Estiva Bulbo Secco      }
            TolleranzaT:REAL;      { Tolleranza Temperatura              }
            UInv:REAL;             { Umidita` relativa Invernale         }
            UEst:REAL;             { Umidita` relativa Estiva            }
            TolleranzaU:REAL;      { Tolleranza Umidita`                 }

            AffollPersona:REAL;    { Affollamento                        }
            ProfiloOccupaz:INTEGER;{ Profilo Occupazione            [Cod]}
            RicambioPersona:REAL;  { Ricambio per Persona                }
            SensibilePersona:REAL; { Sensibile per Persona               }
            LatentePersona:REAL;   { Latente per Persona                 }

            IlluminazFissa:REAL;   { Densita` di illuminazione parte fissa    }
            IlluminazVar:REAL;     { Densita` di illuminazione parte variabile}
            TipoIlluminaz:INTEGER; { Tipo di illuminazione          [Cod]}
            ProfiloIlluminaz:INTEGER;{Profilo Illuminazione         [Cod]}

            SensApparecch:REAL;    { Sensibile per Apparecchiature       }
            LatenteApparecch:REAL; { Latente per Apparecchiature         }
            RappRS:REAL;           { Radiante/sensibile [%]              }
            ProfiloApparecch:INTEGER;{Profilo Apparecchiature       [Cod]}

            MassaFrontDivisInt:REAL;  { Massa Frontale Divisori Interni  }
            MassaFrontSoletteInt:REAL;{ Massa Frontale Solette Interne   }
            HSoffittoRicorr:REAL;  { Altezza Soffitto Ricorrente         }

            ProfiloInv,ProfiloImpianto:INTEGER; { Profili funzionamento Impianto [Cod] }
            CoeffIntermittInv:real;
            CoeffIntermittEst:real;
            CircolazAria:INTEGER;       { Codice nel range 1..5                    }
            InfInv,InfEst:REAL;         { Infiltrazioni estive e invernali    }

            TimmInv,TimmEst:REAL;      {  Temperatura di immissione dell'aria }
            TimmInvBU,TimmEstBU:REAL;  { Temperatura di immissione dell'aria BU}

            Ventilazione:REAL;     { Ventilazione Meccanica                   }
            ProfVentInv:INTEGER;      { Profilo ventilazione                     }
            ProfVentEst:INTEGER;      { Profilo ventilazione                     }

          END; { RecEdif }
  PunEdif=^RecEdif;


  RecMuri=RECORD
            Denom:ST20;
            CodArch:INTEGER;
            Colore:st1;        { Colore del muro : Chiaro/Medio/Scuro    }
            IncrSic:REAL;       { Incremento sicurezza }
          END; { RecMuri }
  TabMuri=ARRAY[1..MaxMuri] OF RecMuri;
  PunMuri=^TabMuri;


RecFin=RECORD
           Trasmittanza:REAL;
           SuperfUnit:REAL;   { Superficie unitaria per lavorare con i moduli }
           PercVetr:INTEGER;  { Percentuale vetrata sul totale con telaio     }
           IncrSic:REAL;      { Percentuale di incremento di sicurezza        }

           TipoSchermatura:ST30;
           Shedingsc:real;
           descrV:string[50];
           shedingV:real;
           PosizSchermo:st1;
           Shading:REAL;

           Altezza:REAL;
           Larghezza:REAL;
           Rientranza:REAL;

           LOrizz:REAL;  { Lunghezza aggetti : Orizzontale               }
           DOrizz:REAL;  { Distanza aggetti esterni : Orizzontale        }
           LVertDX:REAL; { Lunghezza aggetti : Verticale Destra          }
           DVertDX:REAL; { Distanza aggetti esterni : Verticale Destra   }
           LVertSX:REAL; { Lunghezza aggetti : Verticale Sinistra        }
           DVertSX:REAL; { Distanza aggetti esterni : Verticale Sinistra }

           Denom:ST20;
           Lineak:integer;
         END; { RecFin }

rfin10=record
              Codv1:st5;
              codv2:st5;
              kg1:real;
              kg2:real;
              supvete,
              supveti:real;
              kf1,
              kf2,
              suptele,
              supteli,
              lungvete,
              lungveti,
              kdistanze,
              kdistanzi,
              Kw1,kw2,
              dist,
              dr,
              trasm,
              permserr,
              permcass,Lungcass:real;
           end;

 rfinnew=record
              codpont:integer;
              codsottofin:string[5];
              hsottofin:real;
              codsoprafin:string[5];
              hsoprafin:real;
              harco:real;
              nsuddiv,nante:integer;
              stelaioL,stelaioV,stelaioI:real;
              stelaioS,ssuddiv:real;
          end;

  fin_tot=record
             fin_l10:rfin10;
             Fin_cart:Recfin;
              fin_cart1:rfinnew;
          end;
  TabFin=ARRAY[1..MaxFinestre] OF Fin_Tot;
  PunFin=^TabFin;

  RecPorte=RECORD
             Denom:ST20;
             Trasmittanza:REAL;
             TrasmL10:real;
             Colore:st1;        { Colore del muro : Chiaro/Medio/Scuro       }
             SuperfUnit:REAL; { Superficie unitaria per lavorare con i moduli }
             IncrSic,PermAria:REAL;
           END; { RecPorte }
  TabPorte=ARRAY[1..MaxPorte] OF RecPorte;
  PunPorte=^TabPorte;


  RecEsp=RECORD
           Denom:ST20;
           Tipo:ST1;    { Tipo di esposizione : E(sterno)/I(nterno)          }
           Orient:REAL;
           Inclin:REAL;
           TrifEst:REAL;
           TrifInv:REAL;
           IncrSic:REAL;
           CodPav :ST8;
           CodOst : ST8;
                    {Tipo:   Esterno      *            Interno                }
                    {      Orientamento   *   Temperatura riferim. estiva     }
                    {      Inclinazione   *   Temperatura riferimento invern. }
         END; { RecEsp }
  TabEsp=ARRAY[1..MaxEsposizioni] OF RecEsp;
  PunEsp=^TabEsp;


RecZone=RECORD
            TInv:REAL;     { Temperatura interna Invernale                    }
            TEst:REAL;     { Temperatura interna Estiva                       }
            TolleranzaT:REAL;  { Tolleranza Temperatura                       }
            UInv:REAL;     { Umidita` relativa interna Invernale              }
            UEst:REAL;     { Umidita` relativa interna Estiva                 }
            TolleranzaU:REAL;  { Tolleranza Umidita`                          }

            AffollPersona:REAL;    { Affollamento                             }
            ProfiloOccupaz:INTEGER;{ Profilo Occupazione            [Cod]     }
            RicambioPersona:REAL;  { Ricambio per Persona                     }
            SensibilePersona:REAL; { Sensibile per Persona                    }
            LatentePersona:REAL;   { Latente per Persona                      }

            IlluminazFissa:REAL;   { Densita` di illuminazione parte fissa    }
            IlluminazVar:REAL;     { Densita` di illuminazione parte variabile}
            TipoIlluminaz:INTEGER; { Tipo di illuminazione          [Cod]     }
            ProfiloIlluminaz:INTEGER;{Profilo Illuminazione         [Cod]     }

            SensApparecch:REAL;    { Sensibile per Apparecchiature            }
            LatenteApparecch:REAL; { Latente per Apparecchiature              }
            RappRS:REAL;           { Radiante/sensibile [%]                   }
            ProfiloApparecch:INTEGER;{Profilo Apparecchiature       [Cod]     }
            MassaFrontDivisInt:REAL;  { Massa Frontale Divisori Interni  }
            MassaFrontSoletteInt:REAL;{ Massa Frontale Solette Interne   }
            HSoffittoRicorr:REAL;  { Altezza Soffitto Ricorrente              }
            CoeffIntermittInv:REAL;   { Coefficiente di intermittenza invernale  }
            CoeffIntermittEst:REAL;   { Coefficiente di intermittenza estivo  }
            CircolazAria:INTEGER;  { Codice nel range 1..5                    }
            InfInv,InfEst:REAL;    { Infiltrazioni estive e invernali         }

            TimmInv,TimmEst:REAL; { Temperatura di immissione dell'aria       }
            URimmInv,URimmEst:REAL; { Umidita relativa di immissione dell'aria }

            Ventilazione:REAL;     { Ventilazione Meccanica                   }
            ProfVentInv:INTEGER;      { Profilo ventilazione                     }
            ProfVentEst:INTEGER;      { Profilo ventilazione                     }

            TimmInvBU,TimmEstBU:REAL; { Temperatura di immissione dell'aria BU}

            ZonaLegge10 : integer; { campo aggiunto x la legge 10 }

            TipoImpianto:STRING[32];
            ProfiloImpiantoInv:INTEGER;{Profilo funzionamento Impianto invernale[Cod]     }
            ProfiloImpianto:INTEGER;{Profilo funzionamento Impianto [Cod]     }

            Denom:ST20;

          END; { RecZone }

  TabZone=ARRAY[1..MaxZone] OF RecZone;
  PunZone=^TabZone;


  RecAmb=RECORD
           NPersone:INTEGER;      { N persone=ROUND(Affollamento/Superficie) }
           ProfiloOccupaz:INTEGER;{ Profilo Occupazione            [Cod]     }
           RicambioPersona:REAL;  { Ricambio per Persona                     }
           SensibilePersona:REAL; { Sensibile per Persona                    }
           LatentePersona:REAL;   { Latente per Persona                      }

           IlluminazFissa:REAL;   { Densita` di illuminazione parte fissa    }
           IlluminazVar:REAL;     { Densita` di illuminazione parte variabile}
           TipoIlluminaz:INTEGER; { Tipo di illuminazione          [Cod]     }
           ProfiloIlluminaz:INTEGER;{Profilo Illuminazione         [Cod]     }

           SensApparecch:REAL;    { Sensibile per Apparecchiature            }
           LatenteApparecch:REAL; { Latente per Apparecchiature              }
           RappRS:REAL;           { Radiante/sensibile [%]                   }
           ProfiloApparecch:INTEGER;{Profilo Apparecchiature       [Cod]     }


           InfInv,InfEst:REAL;     { Infiltrazioni estive e invernali        }
           Ventilazione:REAL;      { Ventilazione Meccanica                  }
           CircolazAria:INTEGER;   { Codice nel range 1..5                   }

           inf_risc    :real; { aggiunti x legge 10 }
           alfaSerra   :real; { aggiunti x legge 10 }
           alloggio    :integer; { aggiunti x disp }
           PotenzaWatt :real; { aggiunti x disp }

           CodNum:real;
           Denom:ST20;
           Zona:INTEGER;
           Superficie:REAL;      { Superficie in pianta                      }
           HSoffitto:REAL;       { Altezza Soffitto                          }
           AmbientiUguali:INTEGER;{ Numero ambienti uguali                   }
         END; { RecAmb }


  PunAmb=^RecAmb;
  TabAmb=array[1..MaxPointAmb]of PunAmb;


  RecFront=RECORD
             CodNum:real;
             CodAmb    :INTEGER; { Codice Ambiente                         }
             CodEsposiz:INTEGER; { Codice Esposizione                      }
             LungMuro  :REAL;    { Lunghezza muro * HSoffito ==> SupParete }
             CodMuro:INTEGER;    { Codice descrizione Muro                 }
             SupMuro:REAL;       { Superficie Muro non evidenz. in INPUT   }
             CodMuro2:INTEGER;   { Codice descrizione Muro aggiuntivo      }
             SupMuro2:REAL;      { Superficie Muro aggiuntivo              }
             CodFinestra:INTEGER;{ Codice Finestra                         }
             ModFinestra:INTEGER;{ N di elementi a superficie unitaria     }
             SupFinestra:REAL;   { Superficie Finestra                     }
             CodPorta:INTEGER;   { Codice Porta                            }
             ModPorta:INTEGER;   { N di elementi a superficie unitaria     }
             SupPorta:REAL;      { Superficie Porta                        }
           END;    { RecFront }
  PunFront=^RecFront;
  TabFront=array [1..MaxPoint] of PunFront;



  RecFrontInt=RECORD
                CodZona1  :INTEGER; { Codice Zona 1                           }
                CodZona2  :INTEGER; { Codice Zona 2                           }
                LungMuro  :REAL;    { Lunghezza muro * HSoffito ==> SupParete }
                CodMuro:INTEGER;    { Codice descrizione Muro                 }
                SupMuro:REAL;       { Superficie Muro non evidenz. in INPUT   }
              END;    { RecFront int }

  RecPonti=RECORD
            Denom:ST20;
            KL:REAL;
           END; { RecPonti }
  TabPonti=ARRAY[1..MaxPonti] OF RecPonti;
  PunPonti=^TabPonti;


  RecFrontLin=RECORD
                CodNum:real;
                CodAmb:INTEGER;
                CodEsp   :INTEGER;
                CodPonte1:INTEGER;
                LUNG1    :REAL;
                CodPonte2:INTEGER;
                LUNG2    :REAL;
                Kappa    :real;
              END; { RecFrontLin }


  PunFrontLin=^RecFrontLin;
  TabFrontLin=array [1..MaxPoint] of PunFrontLin;




  RigaProf=ARRAY[0..23] OF INTEGER;

  TabProf=ARRAY[1..MaxProfili] OF RigaProf;

  PunProf=^TabProf;

  Ambienti=ARRAY[1..MaxAmbienti] OF REAL;
  PunAmbienti=^Ambienti;


  DescrOrizz=ARRAY[0..23] OF REAL; { (array index)*15=zona di orizzonte }
  PunOrizz=^DescrOrizz;


  RecStrato=RECORD
              Cod  :string[5];
              Descr:STring[30];      { Descrizione strato }
              Spessore:REAL;   { Spessore dello strato }
              ConduttivitaLineare:REAL;
              Conduttanza:REAL;
              CaloreSpecifico:REAL;
              PesoSpecifico:REAL;
            END;   { RecStrato }
  TabStruttura=RECORD
                 Descr:STring[30];
                 HI:REAL;               { Adduttanza interna }
                 HE:REAL;               { Adduttanza esterna }
                 NFile : st5;
                 NStrati:INTEGER;       { Numero strati presenti in S[] }
                 NK:INTEGER;
                 B0,B1,SC,D1,Trasmitt:REAL;   { Coeff. di trasferimento }
                 MFstrutt:REAL;         { Massa frontale della parete   }
                 S:ARRAY[1..MaxStrati] OF RecStrato;
               END;
  TabStrutture=ARRAY[1..MaxStrutture] OF ^TabStruttura;
  PunStrutt=^TabStrutture;




    PavSuTerreno = record
               Codice    : st8;
               Tipo      : Integer;
               Area      : real;
               CodPav    : integer;
               Perimetro : real;
               CodMuro   : integer;
               LambdaTerr: real;
               H         : real;
               Epson     : real;
               D         : real;
               Dis       : real;
               LambdaIs  : real;
               {Ga        : real;}
               Hg        : real;

            end;

    TabPavSuTerreno = array[1..maxpav] of pavsuTerreno;

    PunPavSuTer=^TabpavSuterreno;

    Recsez=RECORD
         Dnom:st8;
         Dint:Real;
         spes:Real;
         form:integer;
         end;

    RecTubaz=RECORD
           Cod  :st8;
           Descr:string[55];
           Dens :Real;
           Rug  :Real;
           sez:Array[1..maxsez] of Recsez;
           end;
  Artubaz=array[1..maxtubaz]of rectubaz;
  PunTubaz=^Artubaz;




   Archivio=record
               cod:string[5];
               nome:string[30];
               lamda,Cond,mu,densita,ct:real;
            end;

   Arch=array[1..NMater]of Archivio;

  tmese=ARRAY[1..12] OF STRING[10];
  SuperficieMuri = array[1..MaxFrontiere] of real;
  {----------------------- strutture---------------------}
   materiali=record
                cod : string[5];
                nome: string[30];
                s   : real;
             end;

   tabMat=array[-1..MaxStrati]of materiali;


   Contorno=record
               Ti,Te,URi,URe,wind,PercInc,EsTi,EsTe,EsURI,EsURE,EsG,alfa,beta:real;
               TipoStrut:integer;
            end;

   StruttPrg=record
               Descr:string[30];
               KNorm:real;
               KAdot:real;
               NFile:st5;
             end;

   Elenco = array[1..MaxNStrutt] of StruttPrg;


   RigaStrutture = record
                     DescrS:string[30];
                     Addut_int:real;
                     Addut_est:real;
                     col:st1;
                     incrsic:real;
                     CodIgro:string[5];
                     trasm,peso:real;
                   end;

   tabstr  =array[1..MaxStrati] of RecStrato;
   TabFinA = array[1..maxstrutture] of ^tabstr;
   TabFinB = array[1..MaxStrutture] of RigaStrutture;

{------------------ fine strutture   ----------------------------------}
{_---------  inpmnu -------------------------}
 type
   RecPCopy1 = array[0..11] of integer;
   RecPCopy2 = array[12..23] of integer;
   TabCopy1  = array[1..MaxProfili] of RecPCopy1;
   TabCopy2  = array[1..MaxProfili] of RecPCopy2;

 type
  RigaArch = RECORD
               Localita:string[23];
               Nazione:STring[25];
               Altitud:integer;
               Latit,Longitud:real;
               T_inverBS,T_estivBS,T_estivBU:real;
               EscTerm:real;
             END;
 punrigaarch=^rigaarch;

 type
    RigaAmbienti = record
                    CodNum   :real;
                    DescrA   :st20;
                    Superf   :real;
                    Altezza  :real;
                    NAmbiente:integer;
                    CZona    :integer;
                    Ventil   :real;
                    InfInv1  :real;
                    Inf_Risc1:real;
                    AlfaSerra1:real;
                    alloggio1 :integer;
                    potWatt   :real;

                   end;

    TabAmbLoc = record
                  Nome : st20;
                  Ambiente : RecAmb;
             end;
    TabellaAmbiente = Array[1..MaxAmbienti] of TabAmbLoc;

 type

   RigaZona = record
                 DescrZ      :st20;
                 TipoImp     :string[32];
                 CodProfInv  :integer;
                 CodProfEst  :integer;
                 ZonaL10     :integer;
                 ventil      :real;
                 InfInv1     :real;
                 Inf_Risc1   :real;
                 hsoffittoRicorr1:real;

              end;

 type
  Finestra = record
              Nome : st20;
              Fines : recfin;
             end;

  elstrutigro = array[1..160] of string[8];
  TabFinest   = array[1..MaxFinestre] of Finestra;
  Tabzona     = array[1..MaxZone] of RigaZona;
  TabAmbien   = array[1..MaxAmbienti] of RigaAmbienti;

  Tabfines    = array[1..MaxFinestre] of record
                                            descr:st20;
                                            lineak:integer;
                                         end;


{-------------------------fine inpmnu---------------------------}
{-------------------------arkprg---------------------------}
type RecProg = record
                  Descr:string[50];
                  Nome:string[8];
               end;
     ArchivioProg = array[1..NProgetti] of RecProg;

{-------------------------fine arkprg---------------------------}
{-------------------------arkloc---------------------------}
const
   NLoc = 261;

  type
  ArchivioLoc = array[1..NLoc] of RigaArch;


{-------------------------fine arkloc---------------------------}

type rectac=record
              descr:string[40];
              cod:st8;
              temp:array[1..12] of real;
            end;
     elrecac=array[1..maxtempac] of rectac;



{-------------------------fine tempac---------------------------}

VAR
  calcinv:boolean;
  VProg                              :^ArchivioProg;
  Indice:^Elenco;    Cond_Cont:^Contorno;
  tabe  :^tabMat;
  FinB                                            :^tabfinb;
  FinA                                            :^tabfina;
  TabArcLoc                                       : ^ArchivioLoc;

  Fin                            : ^tabfines;
  Finestrevar                    : ^Tabfinest;
  Zon                            : ^Tabzona;
  Amb                            : ^Tabambien;
  StruttAmb                      : ^TabellaAmbiente;
  Elem                           :  PunRigaArch;
  Fin1                           : ^TabCopy1;
  Fin2                           : ^TabCopy2;
  dirstrutt                      : ^elstrutigro;

  FrInt         :RecFrontInt;
  FFInt         :file of RecFrontInt;
  AreaMuri      :^Superficiemuri;
  GENERALITA_D  :PunGen;
  LOCALITA_D    :PunLoc;
  Edificio_D    :PunEdif;
  Muri_D        :PunMuri;
  Porte_D       :PunPorte;
  Finestre_D    :PunFin;
  Esposizioni_D :PunEsp;
  Zone_D        :PunZone;
  Ambienti_D    :^tabamb;
  Frontiere_D   :^tabfront;
  Ponti_D       :PunPonti;
  FrontiereLin_D:^TabFrontLin;
  Profili_D     :PunProf;
  Orizzonte_D   :PunOrizz;
  Strutture_D   :PunStrutt;
  Tubaz_d       :PunTubaz;
  PavSuTer      :PunPavSuTer;
  Arcigro       :^Arch;
  DInmesi       :InMesi;
  NTubaz:integer;
  FlagZone:ARRAY[1..MaxZone] OF BOOLEAN;
  FlagAmbienti:ARRAY[1..MaxAmbienti] OF BOOLEAN;
  TempAC:^elrecac;
  Ntempac:integer;

  NMuri        :INTEGER;
  NFinestre    :INTEGER;
  NPorte       :INTEGER;
  NEsposizioni :INTEGER;
  NZone        :INTEGER;
  NAmbienti    :INTEGER;
  NFrontiere   :INTEGER;
  NPonti       :INTEGER;
  NFrontiereLin:INTEGER;
  NStrutture   :INTEGER;
  NumPiano     :integer;
  NPavSuTer    :integer;
  NZone10      :integer;
  NGenerat     :integer;
  NCapTermica  :integer;
  NCarInterni  :integer;

{CONST
  Vers=407;}
VAR
  ftext,f,ferrori:text;
  ERR:BOOLEAN;
  Scelta:INTEGER;
  Messaggio:st80;
  errore:boolean;
  Testo1,Testo2:string[80];
  Ver:string[4];
  Valeur:integer;
  ErrorFin,ErrorPor:boolean;

VAR
  FLAG_DATI:BOOLEAN;
  ftxt:text;
  Titolo:st80;
  ch : char;
  NumeroProg:st80;
  NOMECOMMESSA:STRING;
  Caricamento:boolean;
  InitMask,InitMenu:boolean;
  Meseinizio,mesefine:integer;



const
   NCanHM=21;
   NCanH =8;

(*   Mese:ARRAY[1..12] OF STRING[10]
       =('GENNAIO','FEBBRAIO','MARZO','APRILE','MAGGIO','GIUGNO','LUGLIO',
         'AGOSTO','SETTEMBRE','OTTOBRE','NOVEMBRE','DICEMBRE'); *)

   Mese_ITA:tmese
       =(CH12,CH13,CH14,CH15,CH16,CH17,CH18,CH19,CH20,CH21,CH22,CH23);

   Mese_ING:tmese
       =('JANUARY','FEBRUARY','MARCH','APRIL','MAY','JUNE','JULY',
         'AUGUST','SEPTEMBER','OCTOBER','NOVEMBER','DECEMBER');

   Mese_SPA:tmese
       =('JANUARY','FEBRUARY','MARCH','APRIL','MAY','JUNE','JULY',
         'AUGUST','SEPTEMBER','OCTOBER','NOVEMBER','DECEMBER');


   Mese_FRA:tmese
       =('JANVIER','FêVRIER','MARS','AVRIL','MAI','JUIN','JUILLET',
         'AOöT','SEPTEMBE','OCTOBRE','NOVEMBRE','DêCEMBRE');
type

   tab=array[0..23,1..12] of real;
   ore=array[0..23] of real;
   mesi=array[1..12] of real;
   esposizione=array[1..4] of real;
   inttabz=ARRAY[1..MaxZone] OF INTEGER;
   ResTabZ1=ARRAY[0..23,1..MaxZone] OF REAL;
   ResTabZ2=ARRAY[1..MaxZone] OF REAL;
   CarichiMax=RECORD
                CTMAX:REAL;
                CTTOTMAX:REAL;
                Ht,Mt:INTEGER;
              END;
  ARRCTM = ARRAY[1..MaxAmbienti] OF CarichiMax;
  PotenzeMax=RECORD
                PTMAX:REAL;
                PTTOTMAX:REAL;
                Ht,Mt:INTEGER;
              END;
  ARRPTM = ARRAY[1..MaxAmbienti] OF PotenzeMax;
  arrptmax=ARRAY[1..MaxAmbienti] OF RECORD
                                        PTMAX:REAL;
                                        Ht:INTEGER;
                                      END;
  arrvent=ARRAY[1..MaxAmbienti]  OF REAL;
  type



     RecPtm     = RECORD
                     PTMAX:REAL;
                     Ht:INTEGER;
                  END;

  RecVarCalc = record
                    Ctm       : CarichiMax;
                    Ptm       : Potenzemax;
                    PtMinv    : RecPtm;
                    Pvent     : real;
                    InsTotInv : real;
                    QcTotInv  : real;
                    w1        : real;
                  end;
    PunCalc=array[1..MaxPointAmb] of ^RecVarcalc;
    PuntCalc=^PunCalc;



VAR
   Mese:^tmese;
   fmenu:text;
   ScMenu:st80;
   TMAXBS,TMAXBU,WMAX,HMIN:mesi;
   PATM:REAL;                                         { Pressione atmosferica }
   A0,T0:REAL;
   US,UR:tab;
   UScost,URcost:REAL;

   SZTOTInv:^ResTabZ1;
   SZVENTInv,LZVENTInv,SAPRInv:^ResTabZ1;
   {ISZTOT,ILZTOT:ResTabZ2;}
   SETOTInv,SEVENTInv:^ore;
   MA,HA,MV,HV,MZ,HZ,HI:^inttabz;
   MAE,HAE,HVE,MVE,HIE,HEst,ME:INTEGER;

   CTM      :^ARRCTM;
   PTM      :^ARRPTM;
   PTMInv   :^arrptmax;
   PVent    :^arrvent;
   PVentZona,TDAvar:^restabz2;

   USImm,USImmInv:ARRAY[1..MaxZone] OF REAL;
   Operazione :integer;


   SceltaM:integer;
   SLapr:real;


CONST
  HE:ARRAY[ -10..47 ] of integer = (14,15,16,17,18,19,20,21,22,23,
                                    0,1,2,3,4,5,6,7,8,9,10,11,
                                    12,13,14,15,16,17,18,19,20,21,22,23,
                                    0,1,2,3,4,5,6,7,8,9,10,11,
                                    12,13,14,15,16,17,18,19,20,21,22,23);

  QCTOT  :INTEGER=1;
  QIRRTOT:INTEGER=2;
  QIRCTOT:INTEGER=3;
  ILLTOT :INTEGER=4;
  QACON  :INTEGER=5;
  QAIRR  :INTEGER=6;
  QAILL  :INTEGER=7;
  INSTOT :INTEGER=8;
  INLTOT :INTEGER=9;
  EREST  :INTEGER=10;
  TIE    :INTEGER=11;
  UIE    :INTEGER=12;
  LATEFF :INTEGER=13;
  SZTOT  :INTEGER=14;
  LZTOT  :INTEGER=15;
  SZVENT :INTEGER=16;
  LZVENT :INTEGER=17;
  SAPR   :INTEGER=18;
  LAPR   :INTEGER=19;

  OCSTOT:INTEGER=1;
  OCLTOT:INTEGER=2;
  APSTOT:INTEGER=3;
  APLTOT:INTEGER=4;
  QAPS  :INTEGER=5;
  QOCS  :INTEGER=6;
  ERInv :INTEGER=7;
  TIEInv:INTEGER=8;

NOMHM:ARRAY[1..19]OF STRING[12]=
('LHS_TRASM'  ,{1}
 'LHS_IRRAGDIR',{2}
 'LHS_IRRAGINDIR',{3}
 'LHS_ILL' ,{4}
 'LCS_TRASM'  ,{5}
 'LCS_IRR'  ,{6}
 'LCS_ILL'  ,{7}
 'LCS_INF' ,{8}
 'LCL_INF' ,{9}
 'LPS_TOT'  ,{10}
 'LTI_TEMP'    ,{11}
 'LUI_UMID'    ,{12}
 'LPL_TOT' ,{13}
 'ZPS_TOT'  ,{14}
 'ZPL_TOT'  ,{15}
 'ZPS_VENT' ,{16}
 'ZPL_VENT' ,{17}
 'LPS_APPVENT'   ,{18}
 'LPL_APPVENT'   ){19};

VECCHIONOMHM:ARRAY[1..19]OF STRING[12]=
('QCTOT.DAT'  ,{1}
 'QIRRTOT.DAT',{2}
 'QIRCTOT.DAT',{3}
 'ILLTOT.DAT' ,{4}
 'QACON.DAT'  ,{5}
 'QAIRR.DAT'  ,{6}
 'QAILL.DAT'  ,{7}
 'INSTOTes.DAT' ,{8}
 'INLTOTes.DAT' ,{9}
 'EREST.DAT'  ,{10}
 'TIE.DAT'    ,{11}
 'UIE.DAT'    ,{12}
 'LATEFF.DAT' ,{13}
 'SZTOT.DAT'  ,{14}
 'LZTOT.DAT'  ,{15}
 'SZVENT.DAT' ,{16}
 'LZVENT.DAT' ,{17}
 'SAPR.DAT'   ,{18}
 'LAPR.DAT'   ){19};
      pippo
NOMH:array[1..8] of string[12]=

('OCSTOT.DAT',{1}
 'OCLTOT.DAT',{2}
 'APSTOT.DAT',{3}
 'APLTOT.DAT',{4}
 'QAPS.DAT'  ,{5}
 'QOCS.DAT'  ,{6}
 'ERInv.DAT' ,{7}
 'TIEInv.DAT');{8}

VECCHIONOMH:array[1..8] of string[12]=

('OCSTOT.DAT',{1}
 'OCLTOT.DAT',{2}
 'APSTOT.DAT',{3}
 'APLTOT.DAT',{4}
 'QAPS.DAT'  ,{5}
 'QOCS.DAT'  ,{6}
 'ERInv.DAT' ,{7}
 'TIEInv.DAT');{8}

type
  TyHM=ARRAY[0..23,1..12] OF REAL;
  TyH =ARRAY[0..23] OF REAL;
  FHM =FILE OF TyHM;
  FH  =FILE OF TyH;
  tst =string[20];
  RecHM=RECORD
          F:FHM;
          A:INTEGER;         { Codice Ambiente/record attualmente in buffer }
        END;
  RecH =RECORD
          F:FH;
          A:INTEGER;         { Codice Ambiente/record attualmente in buffer }
        END;
  tDAT  =ARRAY[1..NCanHM] OF TyHM;
  tdATB =ARRAY[1..NCanH]  OF TyH;



CONST
  DIM_X=16;
  DIM_Y=16;
TYPE
  TabInterp=ARRAY[0..DIM_X,0..DIM_Y] OF REAL;

VAR
  TabC0:^TabInterp;


VAR
   calcok:text;

   DAT  :^tdat;
   DATB :^tdatb;
   CanHM:ARRAY[1..NCanHM] OF RecHM;
   CanH :ARRAY[1..NCanH]  OF RecH;

TYPE
  Dati1 =RECORD
           Progetto:string[50];
           NumProg:string[8];
           Rev:integer;
           Data:STRING[20];
           Committ,Progettista:STRING[50];
           Luogo:STRING[32];
         END;



  NumeroProgetto = record
                      progetto:string[8];
                      data    :string[12];
                      pagina  :integer;
                   end;

  NumeroProgetto1 = record
                       pagina  :integer;
                    end;

  ScelteStampe = array[1..14] of integer;

  StCopie = record
               Scelte:ScelteStampe;
               C :integer;
               D :integer;
               A :real;
               B :real;
               Nc:integer;
               Lingua :integer;
            end;

  IndicePag = record
              NumeroPagina:integer;
           end;

  NumeroPagine = array[1..14] of IndicePag;

VAR
  Npr                          :text            ;
  NomeSt                       :St20            ;
  NP,NumPagina,j,i             :integer         ;
  Mesimp                       :file of integer ;
  QCTOTINV                     :PunAmbienti     ;
  MFtot                        :PunAmbienti     ;
  PScamb                       :PunAmbienti     ;
  TrasmTot                     :PunAmbienti     ;
  TrasmGen                     :PunAmbienti     ;
  W1                           :PunAmbienti     ;
  R1,R2,R3,TE,IDN,SETOT,SEVENT :^tab            ;
  CF                           :integer         ;
  NomProgetto                  :NumeroProgetto  ;
  NomProgetto1                 :NumeroProgetto1 ;
  Copie                        :StCopie         ;
  NPagine                      :NumeroPagine    ;

  { Grafici }
type

  ScelteStampe1 = array[1..5] of integer;

  StCopie1 = record

               Scelte     :ScelteStampe1;
               scale      :St1;
               MeseInizio :integer;
               MeseFine   :integer;
               AmbZonInit :integer;
               AmbZonFin  :integer;

            end;



{ ---------------------------- unit setstamp ---------------------------------- }
var   buff1            :^stcopie1;
      impag            :integer;
      NProg            :st8;
      Init             :text;
      grafico          :array[1..5] of boolean;
      {chiave           :integer;}
      filet            :TEXT;

      vecchiaexit      : pointer; {usata nelle stampe}
      Data_drivep       :STring;
      DRIVEPLT          :ST126;
      DISDRIVE          :ST126;
      DRIVPRG :ST126;
      DRIVEARCG,DRIVE    :ST126;
      DRIVEARCC,DRIVEARCT:ST126;
      DRIVEARCI,DRIVEARCD:ST126;
      driveprog,drivearc           :st126;
{ ---------------------------- tipi del programma setstamp ---------------- }

type recstamp=record
          STepson:string[1];
          STlaser:string[1];
          LungMod:integer;
          Ruotata:string[1];
          PortaP :Integer;
          end;
type recplot=record
          tipo     :integer;
          TipoCarta:string[14];
          ruotata  :string[1];
          pORTA    :INTEGER;
          Penne    :array[1..8] of integer;
          end;
var
  Fplot         :file of reCplot;
  Fstamp        :file of recstamp;
  Vstamp        :^recstamp;
  Vplot         :^ReCplot;
  annulla       :boolean;

  valMaxAmb,ValMinAmb     : integer;   { valore max di ambiente per il calcolo di fht }

  execst2:array[1..maxzone]of Boolean;
  archivioprogetti,
  dirstrutcl,
  strutturecl,
  stratocl,
  arclocalitacl,
  portecl,
  finestrecl,
  esposizionicl,
  arcponticl,
  daticl,
  zonastdcl,
  localitacl,
  profilicl,
  orizzontecl,
  zonecl,
  ambienticl,
  frontierecl,
  frontlincl,
  arcPavSuTer,
  piantecl,dxfcl,nodxfcl,comunecl,
  ostacolicl,arkgenacl,cdcl:boolean;

  CalcEsp:ARRAY[1..MaxEsposizioni] OF record
                                         Sup,Alt:real;
                                         end;
(******************  type10 *******************************************)

const
   maxComuni=50;
   ncom=50;
   MaxZone10=30;
   maxfin10=40;
   Maxfac=30;


 Type

    RectabZona=record
                 nag1,ndg1:real;
                 Dsb:st15;
                 k:real;
                 term:St55;
                 a,b,Fil,Fig,fil1,fig1,t1,t2,goff,nag2,ndg2:real;
              end;


     RecGenerat=record
                  Cp,Pf1,Pd1,Pfbs1,Fc,ETu,Etu100,Etu30,Qc,Qe:real;
                  DtH20Zona,Qpo1,Qbr1,Ta,cop:real;
                end;


     reccd=record
               dispers,VolLord,SupLord,SV,Dt,CdLeg,CdAdot:real;
               Fts,VolRisc,GrGiorno,Fen,RicAr,IrradS,DtMed,AppGr,CoerUtilAg,RedETg,FenLim:real;
           end;

   DescrProgetto = record
                       DiretImp:st30;
                       DescrProgetto:st50;
                       Comune:st20;
                       AltCom:real;
                       LatCom:real;
                       gradi:real;
                       ZonaCl:st1;
                       ComuneRif:st20;
                       altitudine,
                       latitudine:real;
                       CD1,
                       Cda1,
                       CD2,
                       CDa2:real;
                       TEst,
                       TempEst:real;
                       H2oRisc:st1;
                       Destinaz:st35;
                       Classif:st10;
                       Ubicazione:st35;
                       Mesein,
                       mesefin:integer;
                       valc_anal,
                       TipoDistr:st1;
                       NumConcess,
                       DataConcess:st10;
                       NumAbitaz:integer;
                       NumAbit:STRING[10];
                       Zonageo:st35;
                       localitarad:string[20];
                       latrad:real;
                       distmar:real;
                       regvento:st1;
                       zonavent:integer;
                       Tiposchermo:string[25];
                       CodUb:st20;
                       Codperm:ST10;
                    end;





                       RecZone10 = record
                                      descr       : st20;
                                      TAria       : real; {temperatura aria}
                                      UR          : real;
                                      ClSerram    : st20; {Classe serramenti}
                                      CalcAnal    : st1;  {calcolo analitico}
                                      VMVolImpOn  : real; {ventilazione meccanica Volume naturali ad impianto acceso}
                                      OreOn       : real;
                                      EtaRecup    : real;
                                      TipoPav     : integer;{tipo pavimento non sacambiante}
                                      TipoEdif    : string[55];
                                      TipoTerm    : st55; {tipo terminali}
                                      RendTerm    : real; {rendimento terminali}
                                      PotNom      : real;
                                      Perc        : real; {%}
                                      TempAT      : real;
                                      TipoProd    : st50; {tipologia di prodotto}
                                      TipoReg     : st30; {sistema di regolazione}
                                      RendReg     : real; {rendimento regolazione}
                                      NOreNotte   : real;
                                      NOreGiorno  : real;
                                      DayWeekOff  : integer;  { giorni settimanali di spegnimento impianto }
                                      TempMin     : real; { temperatura minima in attenuazione }
                                    end;
       tabZone10 = array[1..maxzone10] of RecZone10;
       PunZone10=^TabZone10;

         Comune = record
                  Com:st20;
                  Alt:real;
                  Lat:real;
                  ComRif:st20;
                  Altrif:real;
                  Latrif:real;
                  ComRad:st20;
                  Latrad:real;
                  regven:st1;
                  zonven:integer;
                  distmar:real;
                  Gradi:real;
                  ZoCl:st1;
                  TemEs:real;
                  omega:st35;
                  Cod:real;
                  Cod1:real;
               end;



   ArComune = array[1..NCom] of Comune;

   RecStampZone=array[1..MaxZone10] of record
                                         Desc:st20;
                                         Riscalc:array[1..7] of real;
                                       end;

   Maskgenerat=record
                   Tipo:st30;
                   Cod:st8;
                   Model:st30;
                   Numero:integer;
                   fluido,
                   combust:st10;
                   PNom:real;
                   Qpo:real;
                   Pfoc:real;
                   Pf,
                   Pfbs,
                   Pd,
                   Qbr:real;
                   TipoInvol:st35;
                   TempH2O:real;
                   CopT,
                   CopE:real;
                   TempSorg:real;
               end;

   TabGenerat=array[1..MaxGenerat] of MaskGenerat;


RecFacciata=record
                 cod            :st8;
                 Frontale       :st30;
                 Ang            :real;
                 DistFront      :real;
                 ProfFront      :real;

                 LateraleDestro :st30;
                 DistDestro     :real;
                 ProfDestro     :Real;

                 LateraleLeft   :st30;
                 DistLeft       :real;
                 ProfLeft       :real;

                 Orizzontale    :st30;
                 DistOrizz      :real;
                 ProfOrizz      :real;
              end;

  TabFacciata=array[1..maxfac] of recfacciata;

  vetFc=array[1..maxfac] of record
                               Fo,faOr,faVe:real;
                            end;

   Potenza = record
                 Pt:real;
                 Vt:real;
                 Ris:string[1];
              end;


  vetfz=array[1..maxzone10] of record
                                    vol,port:real;
                                end;



var
  TabZona10 : ^RectabZona;
  Cd        : ^recCd;
  Generat   : RecGenerat;
  Faccia    : ^tabfacciata;
  RisFc     : ^vetFc;
  B         : potenza;

  Ival:boolean;
  campo,riga:integer;
  ZonaCalc:integer;
  Prog:^descrProgetto;

  Zone10:PunZone10;

  RisultZon:^RecStampZone;
  DescGen:^MaskGenerat;
  ArkGenerat:^TabGenerat;
  vet:^arcomune;
  VentForzZona:^vetfz;


    { ********************** ARCHIVI TUBAZIONI ***************************** }

const maxtt = 50;
      maxE  = 20;

type
   TTubi = record
         Cod1       : st8;
         cod2       : st8;
         Dnom       : st8;
         DIntT      : real;
         DEstT      : real;
         DEstIs     : real;
         LambdaIs   : real;
         He         : real;
         Tipo       : integer;
         H          : real;
         E          : real;
         LambdaPO   : real;
         Tzona      : string[8];
         descr      :string[55];
       end;


qdtubi=array[1..12] of real;


ArkTTubi = array[1..maxTT] of TTubi;



ElencoTDisp = record
         Codice : st8;
         Zona   :integer;
         L      : real;
         Tipo   : st50;
         Percent: real;
        end;


arkElenco = array[1..maxE] of elencoTDisp;


 recCapTermica =record
       CodZona   :integer;
       CodStrut  :integer;
       Tipo      :st1;
       DescStrut :st30;
       Sup       :real;
       Cp        :real;
       CTot      :real;
    end;

 TabCapTermica = array[1..maxCapTermica] of RecCapTermica;


  RecCarichiInterni = record
            codzona :integer;
            Descr   :st30;
            MJouleM2:real;
            MjTOT   :real;
           end;

  tabCarichiInterni =array[1..maxCarichiinterni] of recCarichiInterni;


type
   RigaTubaz = record
                 Cod   :st8;
                 Descr:string[55];
                 dens,rug:real;
               end;

   elrigatubaz=array[1..MaxTubaz] of RigaTubaz;

var FinTub :^elrigatubaz;




var  arcTTubi    : ^ArkTTubi;
     FElenco     :file of ARKelenco;
     ftubi       :file of ttubi;
     elentub       :^arkelenco;
     CapTermica  :^TabCapTermica;
     CarInterni  :^tabCarichiInterni;
     ArCalc:PuntCalc;
     da1         :dati1;


{*********************** Variabili di gestione *****************************}


var
    {--- Modo corrente di disegno ---}

    snapx,snapz:Boolean;
    asp:real;
    PXSez,PYSez,PZsez:real;
    M_sez,C_sez:real;
    Nomesez:string;
    Nomepianta:string;
    ZMin_P,ZMax_P:real;

    {----- Limiti del disegno ------}

    limXi,limXs,limYI,limYS:real;
    S_limXi,S_limXs,S_limYI,S_limYS,S_limZI,S_limZS:real;

     {--- Limiti della finestra -----}

    L_Xsup,L_Xinf,L_YSup,L_YInf:real;
    Xsup,Xinf,YSup,YInf,ZInf,ZSup:real;
    sezione   :boolean;

    xp,yp:real;

    AltSez:string;

    {------ Variabili di uso libero ---}

    real1,real2,real3,real4:real;
    int1,int2,int3,int4:integer;
    XFilo,YFilo:real;

    {--------- Halo ------------------}

    const
       fonti :string='halo106.fnt';


     {--- cursore iso---}

var  iso             :boolean;
     direz,direzprec :integer;


Const  maxxw:real=1000.0;maxyw:real=750;
       minxw:real=0.0;minyw:real=0;
       maxamp=100;
       maxmont=40;


       Curcol:integer=8;

type frec=record
          DescrScheda:string[80];
          Scheda:string;
          Modo:integer;
          DescrDigitizer:string[80];
          Digitizer:string;
          DescrPlotter:string[80];
          Plotter:string;
          DescrStampante:string[80];
          Stampante:string;
          end;




   {------- Dati Generali ---------}

Type DatiInt=record
                Origine :integer;
                Sfavor:integer;
                Disdimens:boolean;
                DisUnif  :boolean;
                Nodi     :Boolean;
                Quota    :real;
                SL_Xsup,SL_Xinf,SL_YSup,SL_YInf:real;
                SXsup,SXinf,SYSup,SYInf,SZInf,SZSup:real;
                Ssezione   :boolean;
             end;
curtype=array[1..maxamp]of record xo,yo,col1,col2 :word end;

var RisultCalc:^DatiInt;
    FRisult   :File of DatiInt;




var

xinfp,yinfp,xsupp,ysupp,zinfp,zsupp,
x,y,x1,y1,xw1,xw2,yw1,yw2   :real;
oldx,oldy,fscalag,orientg   :real;

Device             :string;

line1,line2,line3           :^curtype;






xsp,ysp,s_up        :integer;
X_move,Y_Move:integer;


type
ptr_int  =^integer;
ptr_real =^real;
Ptr_st   =^String;

Var DimCur:integer;

Var ColSfond,ColText,ColDraw:integer;
    Cur:Boolean;
    XCur,YCur,ColCur:integer;
    xrb,yrb,xrb1,yrb1:integer;
    RBLine:Boolean;
    xrx,yrx,xrx1,yrx1:integer;
    Inx,Iny:real;
    RBx:Boolean;
    XPrecM,YPrecM:integer;
  {  Registri:Registers;}
    Ton     :Boolean;
    olD_x,old_y:integer;
    Buf_image   :pointer;
    Stored      :boolean;
    XImage,YImage:integer;
    arcrelazione,StampemskCl,zone10Cl,CaptermicaCL,CarichiIntCL,SupEstCL,
    dati10cl,dati11cl,datigcl,taccl,
    eltubcl,showtubcl,showelcl:boolean;

          {------- Record Disegno ------}

Const lungdis=10;

type cadrec=record
            entita:string[1];
            x1    :real;
            y1    :real;
            z1    :real;
            x2    :real;{Nel caso di un simbolo contiene il numero simbolo "nsim" riferito al disegno caricato  in elsimb}
            y2    :real;
            z2    :real;
            color :integer;
            tlinea:integer;
            flag  :boolean; {-- Serve per marcare il tratto  --}
            nblocco : integer;{ -- indica l`indice nell`array dei blocchi --}
            end;

elencod=array[1..lungdis] of ^cadrec;

var dis    :^elencod;





var
  AreaZona,VolumeZona,VentNatZona,VentMecZona,PortNatZona,PortMecZona,HvZona,HgZona,CapTermZona: real;
  SaveFalgStampa:boolean;


{I VarLeg10}

{I INPUTVAR}


{=============================================================================}
type
 dati_Ponti=object
              function K(Cod:integer): real;
            end;
var  Kappa_PT: ^Dati_Ponti;

Implementation

Function dati_Ponti.K(Cod:integer): real;
begin
   K := 0;
   k:=FrontiereLin_D^[Cod]^.Kappa;
end;

end.
