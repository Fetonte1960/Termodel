unit Risultati;

interface
Uses copiaVariabiliGenerali,
     DbTables,
     Varcarichi,Varcarichi_estivo_14,DB,windows;
Var
   Fimp                            : FILE of TYHM       ;
   FimpH                           : FILE of TYH        ;
   Fout                            : ARRAY[1..21] of file of TYHM;
   countHM                         :ARRAY[1..21] of integer;
   Fouth                           : ARRAY[1..8]  of file of TYH;
   countH                          :ARRAY[1..8] of integer;
 {*************************************************************}

PROCEDURE OpenCan(NumCan:INTEGER;NomeVar:STRING;Dim,Modo:INTEGER);
{ NumCan = Numero canale di riferimento per le successive operazioni
  NomeVar= Nome variabile
  Dim    = Numero di elementi con cui si vuole creare il file
  Modo   = 1 o 2 per indicare se la tabella e` di tipo H o HM rispettivamente }
PROCEDURE LoadH(NumCan,CodA:INTEGER);
PROCEDURE LoadHM(NumCan,CodA:INTEGER);
PROCEDURE CloseH(NumCan:INTEGER);
PROCEDURE CloseHM(NumCan:INTEGER);
PROCEDURE RDHM(NVAR,NCOMP:INTEGER);
PROCEDURE RDH(NVAR,NCOMP:INTEGER);
PROCEDURE OPWHM(NVAR:INTEGER);
PROCEDURE OPWH(NVAR:INTEGER);
PROCEDURE WRHM(NVAR:INTEGER);
PROCEDURE WRH(NVAR:INTEGER);
Procedure WFhmDB(Nvar:TYhm;NomeFile:string;Ind:integer);
Procedure Salva_tuttiRisultatiDB(var Tabella1,Tabella3:TTable);
Procedure InitRisultati;
Procedure Closerisultati;
Procedure InitForm;
Procedure closeform;

implementation
Var TT1:Ttable;
 {*************************************************************}
Procedure Leggi_Risultati(var Tabella1:TTable;var Tabella3:TTable);
Var i:integer;
Begin
i:=0;
Tabella1.close;
Tabella1.tablename:='Risultati.DB';
Tabella1.open;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with RiS_d^ do
    Begin
    Nome:=tabella1.fields[0].asstring;
    Indice:=tabella1.fields[1].asInteger;
    Mese:=tabella1.fields[2].asinteger;
    H[0]:=tabella1.fields[3].asfloat;
    H[1]:=tabella1.fields[4].asfloat;
    H[2]:=tabella1.fields[5].asfloat;
    H[3]:=tabella1.fields[6].asfloat;
    H[4]:=tabella1.fields[7].asfloat;
    H[5]:=tabella1.fields[8].asfloat;
    H[6]:=tabella1.fields[9].asfloat;
    H[7]:=tabella1.fields[10].asfloat;
    H[8]:=tabella1.fields[11].asfloat;
    H[9]:=tabella1.fields[12].asfloat;
    H[10]:=tabella1.fields[13].asfloat;
    H[11]:=tabella1.fields[14].asfloat;
    H[12]:=tabella1.fields[15].asfloat;
    H[13]:=tabella1.fields[16].asfloat;
    H[14]:=tabella1.fields[17].asfloat;
    H[15]:=tabella1.fields[18].asfloat;
    H[16]:=tabella1.fields[19].asfloat;
    H[17]:=tabella1.fields[20].asfloat;
    H[18]:=tabella1.fields[21].asfloat;
    H[19]:=tabella1.fields[22].asfloat;
    H[20]:=tabella1.fields[23].asfloat;
    H[21]:=tabella1.fields[24].asfloat;
    H[22]:=tabella1.fields[25].asfloat;
    H[23]:=tabella1.fields[26].asfloat;
    end;
  Tabella1.Next;
  end;
Nmesi:=i;
end;

{*************************************************************}
Procedure Carica_RisultatiHM(var Tabella1:TTable;var Tabella3:TTable;numvar:integer;Namb:integer);
Var i,j:integer;
Begin
If Calcolimemoria then
  begin
  for  i:=1 to 12 do
  for j:=0 to 23 do dat^[numvar,j,i]:=0;
  for i:=1 to N_ris_mem do
  if (ris_mem[i]^.Nome=Nomhm[Numvar])and(ris_mem[i]^.Indice=Namb)then
  for j:=0 to 23 do dat^[numvar,j,ris_mem[i]^.Mese]:=ris_mem[i]^.H[j];
  end
else
  begin
  for  i:=1 to 12 do
  for j:=0 to 23 do dat^[numvar,j,i]:=0;
  Tabella1.close;
  Tabella1.tablename:='Risultati.DB';
  //if numvar=10 then
  //copyfile(pchar(Tabella1.databasename+Tabella1.tablename),'c:\temp\risestivo.db',false);
  Tabella1.open;
  Tabella1.first;
  While (not Tabella1.eof) do
    Begin
    if  (tabella1.fields[0].asstring =Nomhm[Numvar])and(Namb=tabella1.fields[1].asInteger) then
    for j:=0 to 23 do dat^[numvar,j,tabella1.fields[2].asInteger]:=tabella1.fields[j+3].asfloat;
    Tabella1.Next;
    end;
  end
end;
{*************************************************************}
Procedure Carica_RisultatiH(var Tabella1:TTable;var Tabella3:TTable;numvar:integer;Namb:integer);
Var i,j:integer;
Begin
for j:=0 to 23 do datb^[numvar,j]:=0;
If Calcolimemoria then
  begin
  i:=1;
  while (i<N_ris_mem)and((ris_mem[i]^.Nome<>Nomh[Numvar])or(ris_mem[i]^.Indice<>Namb))do inc(i);
  if (ris_mem[i]^.Nome=Nomh[Numvar])and(ris_mem[i]^.Indice=Namb)then
  for j:=0 to 23 do datb^[numvar,j]:=ris_mem[i]^.H[j];
  end
else
  begin
  Tabella1.close;
  Tabella1.tablename:='Risultati.DB';
  Tabella1.open;
  Tabella1.first;
  While (not Tabella1.eof) do
    Begin
    if  (tabella1.fields[0].asstring =Nomh[Numvar])and(Namb=tabella1.fields[1].asInteger) then
    for j:=0 to 23 do datb^[numvar,j]:=tabella1.fields[j+3].asfloat;
    Tabella1.Next;
    end;
  end
end;
{*************************************************************}
Procedure Salva_Risultati(var Tabella1,Tabella3:TTable);
Var i:integer;
Begin
If Calcolimemoria then
  begin
  inc(N_ris_mem);
  if ris_mem[N_ris_mem]=nil then new(ris_mem[N_ris_mem]);
  ris_mem[N_ris_mem]^:=RiS_d^;
  end
else
  begin
  Tabella1.open;
  Tabella1.append;
  Tabella1.edit;
  with RiS_d^ do
    Begin
    //if indice=2 then
    //showmessage('2');
    tabella1.fields[0].asstring:=Nome;
    tabella1.fields[1].asInteger:=Indice;
    tabella1.fields[2].asinteger:=Mese;
    tabella1.fields[3].asfloat:=H[0];
    tabella1.fields[4].asfloat:=H[1];
    tabella1.fields[5].asfloat:=H[2];
    tabella1.fields[6].asfloat:=H[3];
    tabella1.fields[7].asfloat:=H[4];
    tabella1.fields[8].asfloat:=H[5];
    tabella1.fields[9].asfloat:=H[6];
    tabella1.fields[10].asfloat:=H[7];
    tabella1.fields[11].asfloat:=H[8];
    tabella1.fields[12].asfloat:=H[9];
    tabella1.fields[13].asfloat:=H[10];
    tabella1.fields[14].asfloat:=H[11];
    tabella1.fields[15].asfloat:=H[12];
    tabella1.fields[16].asfloat:=H[13];
    tabella1.fields[17].asfloat:=H[14];
    tabella1.fields[18].asfloat:=H[15];
    tabella1.fields[19].asfloat:=H[16];
    tabella1.fields[20].asfloat:=H[17];
    tabella1.fields[21].asfloat:=H[18];
    tabella1.fields[22].asfloat:=H[19];
    tabella1.fields[23].asfloat:=H[20];
    tabella1.fields[24].asfloat:=H[21];
    tabella1.fields[25].asfloat:=H[22];
    tabella1.fields[26].asfloat:=H[23];
    Tabella1.POst;
    end;
  End
end;
{*************************************************************}
Procedure Salva_tuttiRisultatiDB(var Tabella1,Tabella3:TTable);
Var i:integer;
Begin
If not Calcolimemoria then exit;
Tabella1.open;
for i:=1 to N_ris_mem do
  begin
  Tabella1.append;
  Tabella1.edit;
  with RiS_Mem[i]^ do
    Begin
    //if indice=2 then
    //showmessage('2');
    tabella1.fields[0].asstring:=Nome;
    tabella1.fields[1].asInteger:=Indice;
    tabella1.fields[2].asinteger:=Mese;
    tabella1.fields[3].asfloat:=H[0];
    tabella1.fields[4].asfloat:=H[1];
    tabella1.fields[5].asfloat:=H[2];
    tabella1.fields[6].asfloat:=H[3];
    tabella1.fields[7].asfloat:=H[4];
    tabella1.fields[8].asfloat:=H[5];
    tabella1.fields[9].asfloat:=H[6];
    tabella1.fields[10].asfloat:=H[7];
    tabella1.fields[11].asfloat:=H[8];
    tabella1.fields[12].asfloat:=H[9];
    tabella1.fields[13].asfloat:=H[10];
    tabella1.fields[14].asfloat:=H[11];
    tabella1.fields[15].asfloat:=H[12];
    tabella1.fields[16].asfloat:=H[13];
    tabella1.fields[17].asfloat:=H[14];
    tabella1.fields[18].asfloat:=H[15];
    tabella1.fields[19].asfloat:=H[16];
    tabella1.fields[20].asfloat:=H[17];
    tabella1.fields[21].asfloat:=H[18];
    tabella1.fields[22].asfloat:=H[19];
    tabella1.fields[23].asfloat:=H[20];
    tabella1.fields[24].asfloat:=H[21];
    tabella1.fields[25].asfloat:=H[22];
    tabella1.fields[26].asfloat:=H[23];
    Tabella1.POst;
    end;
  end;
Tabella1.close;
end;
{*************************************************************}
Procedure Crea_Risultati(Var Tabella1:ttable);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:='Risultati';
  tableType:=ttdefault;
  Fielddefs.Add('Nome',ftstring,20,false);
  Fielddefs.Add('Indice',ftInteger,0,false);
  Fielddefs.Add('Mese',ftInteger,0,false);
  Fielddefs.Add('H0',ftFloat,0,false);
  Fielddefs.Add('H1',ftFloat,0,false);
  Fielddefs.Add('H2',ftFloat,0,false);
  Fielddefs.Add('H3',ftFloat,0,false);
  Fielddefs.Add('H4',ftFloat,0,false);
  Fielddefs.Add('H5',ftFloat,0,false);
  Fielddefs.Add('H6',ftFloat,0,false);
  Fielddefs.Add('H7',ftFloat,0,false);
  Fielddefs.Add('H8',ftFloat,0,false);
  Fielddefs.Add('H9',ftFloat,0,false);
  Fielddefs.Add('H10',ftFloat,0,false);
  Fielddefs.Add('H11',ftFloat,0,false);
  Fielddefs.Add('H12',ftFloat,0,false);
  Fielddefs.Add('H13',ftFloat,0,false);
  Fielddefs.Add('H14',ftFloat,0,false);
  Fielddefs.Add('H15',ftFloat,0,false);
  Fielddefs.Add('H16',ftFloat,0,false);
  Fielddefs.Add('H17',ftFloat,0,false);
  Fielddefs.Add('H18',ftFloat,0,false);
  Fielddefs.Add('H19',ftFloat,0,false);
  Fielddefs.Add('H20',ftFloat,0,false);
  Fielddefs.Add('H21',ftFloat,0,false);
  Fielddefs.Add('H22',ftFloat,0,false);
  Fielddefs.Add('H23',ftFloat,0,false);
  CreateTable;
  End;
end;

Procedure WhmDB(Nvar:integer);
var h,m:integer;
begin
inc(countHm[Nvar]);
ris_d^.Indice:=countHm[Nvar];
for m:=meseinizio to mesefine do
  begin
  for h:=0 to 23 do ris_d^.H[h]:=dat^[NVAR,H,M];
  ris_d^.Nome:=Nomhm[Nvar];
  //ris_d^.mese:=Nomemese(m);
  ris_d^.mese:=m;
  Salva_risultati(tt1,tt1);
  end;
end;

Procedure WFhmDB(Nvar:TYhm;NomeFile:string;Ind:integer);
var h,m:integer;
begin
Nomefile:=trasfnome(Nomefile);
ris_d^.Indice:=Ind;
for m:=meseinizio to mesefine do
  begin
  for h:=0 to 23 do ris_d^.H[h]:=Nvar[H,M];
  ris_d^.Nome:=Nomefile;
  //ris_d^.mese:=Nomemese(m);
  ris_d^.mese:=m;
  Salva_risultati(tt1,tt1);
  end;
end;


Procedure WhDB(Nvar:integer);
var h,m:integer;
begin
inc(countH[Nvar]);
for h:=0 to 23 do ris_d^.H[h]:=datb^[NVAR,H];
ris_d^.Nome:=Nomh[Nvar];
ris_d^.Indice:=countH[Nvar];
ris_d^.mese:=1;
Salva_risultati(tt1,tt1);
end;

Procedure RFhmDB(IndFile,Ind:integer);
var h,m:integer;
begin
Carica_RisultatiHM(tt1,tt1,indfile,ind);
end;

Procedure RFhDB(IndFile,Ind:integer);
var h,m:integer;
begin
Carica_RisultatiH(tt1,tt1,indfile,ind);
end;


Procedure RhDB(Nvar:integer);
var h,m:integer;
begin
inc(countH[Nvar]);
for h:=0 to 23 do ris_d^.H[h]:=datb^[NVAR,H];
ris_d^.Nome:=Nomh[Nvar];
ris_d^.Indice:=countH[Nvar];
ris_d^.mese:=1;
Salva_risultati(tt1,tt1);
end;

{-------------------------------  OpenCan  -----------------------------------}

PROCEDURE OpenCan(NumCan:INTEGER;NomeVar:STRING;Dim,Modo:INTEGER);
{ NumCan = Numero canale di riferimento per le successive operazioni
  NomeVar= Nome variabile
  Dim    = Numero di elementi con cui si vuole creare il file
  Modo   = 1 o 2 per indicare se la tabella e` di tipo H o HM rispettivamente }

VAR
  I,H,M:INTEGER;
  Nome :ST80;
BEGIN
Nomevar:=Trasfnome(Nomevar);
  TT1.Open;
  CF:=CF+1;
  Nome:=NomeVar+'.DAT';
{  WRITELN('*\',CF,'/*',Nome,'!!',Dim,'??');  }
  IF Modo=1 THEN
    begin
    countH[Numcan]:=0;
    CanH[NumCan].A:=0;
    end
    ELSE
    begin
    countHm[Numcan]:=0;
    CanHM[NumCan].A:=0;
    end;
  IF Dim=0 THEN
  BEGIN
       IF Modo=1 THEN
       BEGIN
         //ASSIGN(CanH[NumCan].F,Nome);
         //RESET(CanH[NumCan].F);
       END
       ELSE BEGIN
         //ASSIGN(CanHM[NumCan].F,Nome);
         //RESET(CanHM[NumCan].F);
       END;

  END
  ELSE BEGIN
        IF Modo=1 THEN
          BEGIN
          //ASSIGN(CanH[NumCan].F,Nome);
          //REWRITE(CanH[NumCan].F);
          END
        ELSE BEGIN
          //ASSIGN(CanHM[NumCan].F,Nome);
          //REWRITE(CanHM[NumCan].F);
          END;

    IF Modo=1 THEN
    BEGIN
      FOR H:=0 TO 23 DO datb^[NumCan,H]:=0;
      //FOR I:=1 TO Dim DO    {$I-}  WRITE(CanH[NumCan].F,datb^[NumCan]);    {$I+}
    END
    ELSE BEGIN
      FOR M:=1 TO 12 DO FOR H:=0 TO 23 DO dat^[NumCan,H,M]:=0;
      //FOR I:=1 TO Dim DO    {$I-}  WRITE(CanHM[NumCan].F,dat^[NumCan]);    {$I+}
    END;
  END;
END;     { PROC. OpenCan }

{-------------------------------  LoadH  -------------------------------------}

PROCEDURE LoadH(NumCan,CodA:INTEGER);

BEGIN
  IF CanH[NumCan].A<>CodA THEN
  BEGIN
    IF CanH[NumCan].A > 0 THEN
    BEGIN
{$I-} whDB(NumCan);
      //SEEK(CanH[NumCan].F,CanH[NumCan].A-1);
      //WRITE(CanH[NumCan].F,datb^[NumCan]);
{$I+}
    END;
    IF CodA<>0 THEN
    BEGIN
      CanH[NumCan].A:=CodA;
{$I-}
      //SEEK(CanH[NumCan].F,CanH[NumCan].A-1);
      //READ(CanH[NumCan].F,datb^[NumCan]);
{$I+}
    END;
  END;
END;     { PROC. LoadH }

{-------------------------------  LoadHM  ------------------------------------}

PROCEDURE LoadHM(NumCan,CodA:INTEGER);

BEGIN
  IF CanHM[NumCan].A<>CodA THEN
  BEGIN
    IF CanHM[NumCan].A > 0 THEN
    BEGIN
{$I-} whmDB(NumCan);
      //SEEK(CanHM[NumCan].F,CanHM[NumCan].A-1);
      //WRITE(CanHM[NumCan].F,dat^[NumCan]);
{$I+}
    END;
    IF CodA<>0 THEN
    BEGIN
      RFhmDB(numcan,CodA);
      CanHM[NumCan].A:=CodA;
{$I-}
      //SEEK(CanHM[NumCan].F,CanHM[NumCan].A-1);
      //READ(CanHM[NumCan].F,dat^[NumCan]);
{$I+}
    END;
  END;

END;     { PROC. LoadHM }

{------------------------------  CloseH  ----------------------------------}

PROCEDURE CloseH(NumCan:INTEGER);

VAR IOERR:INTEGER;
BEGIN
  LoadH(NumCan,0);         { Flush dei dati nel buffer }
  //CLOSE(CanH[NumCan].F);
  CF:=CF-1;
  IOERR:=IOresult;
END;   { PROC. CloseH }

{-----------------------------  CloseHM  ----------------------------------}

PROCEDURE CloseHM(NumCan:INTEGER);

VAR IOERR:INTEGER;
BEGIN
  LoadHM(NumCan,0);        { Flush dei dati nel buffer }
{$I-} // CLOSE(CanHM[NumCan].F);     {$I+}
  CF:=CF-1;
  IOERR:=IOresult;
{! 7. IOR^esult now returns different values corresponding to DOS error codes.}
END;     { PROC.  CloseHM }

{ ----------------------- RDHM ------------------------------------------ }

PROCEDURE RDHM(NVAR,NCOMP:INTEGER);

var
    fimp:file of tyhm;

 BEGIN
   {
   ASSIGN(Fimp,nomHM[nvar]);
   reset(fimp);
   seek(fimp,ncomp-1);
   read(fimp,dat^[nvar]);
   close(fimp);
   }
   RFhmDB(NVar,NComp);
 END;

{ ----------------------- RDH ------------------------------------------ }

PROCEDURE RDH(NVAR,NCOMP:INTEGER);

var
    fimp:file of tyh;

 BEGIN
   {
   ASSIGN(Fimp,nomH[nvar]);
   reset(fimp);
   seek(fimp,ncomp-1);
   read(fimp,datb^[nvar]);
   close(fimp);
   }
   RFhDB(NVar,NComp);
 END;

{ ----------------------- OPWHM  ------------------------------------------ }

PROCEDURE OPWHM(NVAR:INTEGER);

var h,m:INTEGER;

 BEGIN
 countHM[Nvar]:=0;
//   ASSIGN(Fout[nvar],nomHM[nvar]);
//   rewrite(fout[nvar]);
   FOR M:=1 TO 12 DO FOR H:=0 TO 23 DO dat^[nvar,H,M]:=0;

 END;

{ ----------------------- OPWH  ------------------------------------------ }

PROCEDURE OPWH(NVAR:INTEGER);

var H:INTEGER;

 BEGIN

//   ASSIGN(FoutH[nvar],nomH[nvar]);
//   rewrite(foutH[nvar]);
   countH[Nvar]:=0;
   FOR H:=0 TO 23 DO datb^[NVAR,H]:=0;

 END;

{ ----------------------- WRHM  ------------------------------------------ }

PROCEDURE WRHM(NVAR:INTEGER);

var h,m:INTEGER;

 BEGIN
   WhmDB(Nvar);

//   WRITE(Fout[nvar],dat^[nvar]);
   FOR M:=1 TO 12 DO FOR H:=0 TO 23 DO dat^[nvar,H,M]:=0;

 END;

{ ----------------------- WRH  ------------------------------------------ }

PROCEDURE WRH(NVAR:INTEGER);

var H:INTEGER;

 BEGIN
   WHDB(NVar);
//   WRITE(Fouth[nvar],datb^[nvar]);
   FOR H:=0 TO 23 DO datb^[NVAR,H]:=0;

 END;

Procedure InitRisultati;
Var i:integer;
begin
//new(ris_d);
n_ris_mem:=0;
for i:=1 to 19 do countHM[i]:=0;
for i:=1 to 8 do countH[i]:=0;
tt1.DatabaseName:=dp;
Crea_Risultati(tt1);
end;
Procedure Closerisultati;
begin
Salva_tuttiRisultatiDB(tt1,tt1);
//dispose(ris_d);
end;
Procedure InitForm;
begin
TT1:=TTable.create(nil);
end;
Procedure closeform;
begin
Tt1.Free;
end;
end.
