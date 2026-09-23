unit UGestpezzi;

interface
uses definizcan,sysutils;
FUNCTION Cerca_ARCHIVIONuovo(Codnuovo : String) : INTEGER;
FUNCTION Cerca_ARCHIVIOVecchio(Codvecchio : String) : INTEGER;
Function Nuovocodice(vecchio:string):string;

implementation
{------------------------RICERCA-------------------------}

FUNCTION Cerca_ARCHIVIOVecchio(Codvecchio : String) : INTEGER;
    VAR
      I, j : INTEGER;
      Trovato : BOOLEAN;
    BEGIN
      CodVecchio:= Uppercase(Codvecchio);


      I := 1; Trovato := FALSE;
      WHILE (I <= NPezzi) AND NOT Trovato DO
        BEGIN
           Trovato := (archpezzi[i].CodPezzo = Codvecchio);
           IF NOT Trovato THEN i := i+1;
        END;

      IF NOT Trovato THEN Cerca_ARCHIVIOVecchio := 0
      ELSE Cerca_ARCHIVIOVecchio := I;

    END;

{------------------------RICERCA-------------------------}

FUNCTION Cerca_ARCHIVIONuovo(Codnuovo : String) : INTEGER;
    VAR
      I, j : INTEGER;
      Trovato : BOOLEAN;
    BEGIN
      Codnuovo:= UPpercase(Codnuovo);


      I := 1; Trovato := FALSE;
      while  (I <= Numpezzican) AND( NOT Trovato) DO
        BEGIN
           Trovato := (archpezzi[i].Codice = Codnuovo);
           IF NOT Trovato THEN i := i+1;
        END;

      IF NOT Trovato THEN Cerca_ARCHIVIONuovo := 0
      ELSE Cerca_ARCHIVIOnuovo := I;

    END;

Function Nuovocodice(vecchio:string):string;
Var Ind:integer;
begin
result:='';
ind:=Cerca_ARCHIVIOVecchio( vecchio);
if ind<>0 then result:=archpezzi[ind].Codice;
end;

end.
