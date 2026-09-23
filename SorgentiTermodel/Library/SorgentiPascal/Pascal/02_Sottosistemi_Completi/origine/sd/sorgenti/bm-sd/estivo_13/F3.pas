
Unit F3;

Interface

Uses
VarCarichi,Varcarichi_estivo_14,warning,
Calcfun,
copiaLibreriaGenerale,
Risultati;
// Crt, {Unit found in TURBO.TPL}
//  Dos, {Unit found in TURBO.TPL}
//  definiz,
//  calcfun,
//  utigen,
//  calcutid,
//  defutig,
//  inpdati,WM
//  ,wintypes
//  ,winprocs


procedure Fase3;

{=============================================================================}

Implementation

{$I fase3def  } { DEFINIZIONI }

{$I fase3inv  } { CALCOLO INV.}

{$I fase3fun  }

{$I fase3din  } { DINAMICA }

{$I fase3ct   }

{$I fase3pot  } { CALCOLO POTENZE ESTIVE INVERNALI E MASSIMI }

{$I fase3um   } { CALCUMREL }

{$I fase3uti  }

{$I fase3mai  } { MAIN FASE3 }

end.