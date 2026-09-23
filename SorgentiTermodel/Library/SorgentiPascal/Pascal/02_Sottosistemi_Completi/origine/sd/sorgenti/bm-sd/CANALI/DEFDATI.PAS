{$R-}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

Unit DefDati;

Interface

Uses
  Crt, {Unit found in TURBO.TPL}
  Dos, {Unit found in TURBO.TPL}
  Turbo3; {Unit found in TURBO3.TPU}

TYPE

  DatiProg1 = RECORD
                  Cliente, Localita        : STRING[40];
                  Progettista              : STRING[20];
                  Impianto                 : STRING[40];
                  NOrdine                  : STRING[20];
                  Disegno                  : STRING[8];
                  Riferimento              : STRING[40];
                  Edificio, Sistema, Zona  : STRING[40];
                  Circuito                 : STRING[40];
                  AltSulMare, Altezza      : INTEGER;
                  TempAria, UmRel          : REAL;
                END;

    DatiProg2 = RECORD
                  Visc, Dens                            : REAL;
                  RivestInt                             : STRING[20];
                  SpessRivest, Rugosita                 : REAL;
                  TipoSezione                           : STRING[20];
                  Rapp, DimW, DimH, DPuMTronco, MinTronco, MaxTronco, VelTronco : REAL;
                  DPuMRami, MinRami, MaxRami, VelRami   : REAL;
                  SbilDPu, SerrTermMax, SerrDPuMin      : REAL;
                  VCostante                             : REAL;
                END;

VAR
   DPR1   : DatiProg1;
   DPR2   : DatiProg2;
implementation
end.
