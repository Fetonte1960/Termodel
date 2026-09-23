
{-------------------------- FASE3 -------------------------------------------}


 PROCEDURE FASE3;

const mesi:array[1..12] of string[10]=(CH12,CH13,CH14,CH15,CH16,CH17,CH18,CH19,
                                       CH20,CH21,CH22,CH23);


VAR

   PAUSA                           : BOOLEAN;
   CH                              : CHAR;
   TOTHG,TOTCTSENS,TOTCLAT,TOTCTINV: REAL;
   g                               : file of Carichimax ;
   f                               : file of PotenzeMax ;
   PScamb,MFTot,TrasmTot,TrasmGen  : real               ;
   IOERR,A,N                       : INTEGER            ;
   V0Irr,V1Irr,V2Irr               : REAL               ;
   V0Con,V1Con,V2Con               : REAL               ;
   V0Ill,V1Ill,V2Ill               : REAL               ;
   
