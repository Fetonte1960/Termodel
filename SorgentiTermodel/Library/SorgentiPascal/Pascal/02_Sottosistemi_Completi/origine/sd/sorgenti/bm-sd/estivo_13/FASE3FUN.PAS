{---------------------------------   FC   ------------------------------------}

FUNCTION FC(A:INTEGER):REAL;

BEGIN

  if PScamb > 0 then FC:=1-0.0116*(TrasmTot/PScamb)

  else FC:=1;

END;    { FUNC. FC }


{----------------------------------  CT  -------------------------------------}
FUNCTION CT(H,M,A:INTEGER):REAL;
BEGIN

  CT:=dat^[QACON,H,M]+
      dat^[QAIRR,H,M]+
      dat^[QAILL,H,M]+
      datb^[QAPS,H]+
      datb^[QOCS,H]+
      dat^[INSTOT,H,M];

END;     { FUNC. CT }

{--------------------------------  CTLAT  ------------------------------------}

FUNCTION CTLAT(H,M,A:INTEGER):REAL;

BEGIN

  CTLAT:=datb^[APLTOT,H]+
         datb^[OCLTOT,H]+
         dat^[INLTOT,H,M];

END;     { FUNC. CTLAT }

{---------------------------------  KKT   ------------------------------------}

FUNCTION KKT(A:INTEGER):REAL;

BEGIN

  KKT:=TrasmGen;

END;    { FUNC. KKT }

