unit UGrafoDXF;

interface

Uses Dialogs,SysUtils,
     Definiz,Varcarichi,LibreriaGenerale, Angoli,esplodigrafo,udatalink,udbt;

Procedure costruiscigrafo(xx,yy,zz:real; var Orig: Integer; IndiceRete: Byte);
Procedure Aggiungi_perdita(Nodo:integer;Cod:string;NumPerd:integer);
Procedure TrovaPerdite;
Procedure SettaFiltro;
function PostFissoAngolo(Ind1, Ind2: Integer; Diram: Boolean): String;
function Togli2Car(S: String): String;
Procedure CodAngoloDiramazione(TipoRete, Nodo: Integer; Ind1, Ind2: Integer);
//Procedure InserisciErrore(Errore: String);
Procedure InserisciErrore(Errore,piano: String;Xer,Yer:real);
Procedure scriviquoteBM;
Procedure Inseriscivalvola(P_Piano:string;P_X,P_y,P_z:real;P_codperd:string);
Procedure LeggiFileTubi(nomef:string);
Procedure G_Linea(x1,y1,z1,x2,y2,z2:real;Layer, Piano:string);
Procedure Cercarimando(codice,lung,codp,nump,spec:string;Rimando:boolean;X1,Y1,Z1,angolo:real;Piano:String);
procedure ApriFileRitorno(NomeFile: String);
procedure ChiudiRitorno;
procedure CaricaTubo(Codice: Integer; DN, Piano, Collettore, Tipo: String; X, Y, Z, X1, Y1, Z1: Double);
procedure CaricaTerminale(codice, x, y, z, tipo, modello,fissamodello, serie,fissaserie, potenzaI, prof, alt, larg, perdita, st,
                          incr, largmax, ang, xe, ye, ze, piano, numel, port, spec, potest, codmont, valmont, nomebloccodxf: String);


                          
function RestituisciQuotaPiano(Piano: String): double;
procedure CalcolaQuotaPiano;

Var nome_rete:string='';
    conta_rami:integer;
implementation
uses
{$Ifdef Versione_14}
{$Else}
umain_calcTubi,
{$Endif}
Ritorno, ULeggiTXT{,letturainmemoria};

Var Flog:textfile;
    Buflog:string;
    FRitorno: TextFile;
const crealog=false;

Procedure Writelog(mess:string;xx,yy,zz:real);
begin
 if crealog then
 writeln(flog,mess+':'+float_to_str(xx,4)+','+float_to_str(yy,4)+','+float_to_str(zz,4)+',');
end;

Function TrovaTerm(Xpart,Ypart,Zpart:real;piano:string):integer;
Var trovato:boolean;
    i:integer;
begin
  writelog('Cerco collegamento a terminale',Xpart,Ypart,Zpart);
  i:=1;
  Trovato:=false;
  while (i<=NGterm)and(not trovato) do
    begin
    trovato:=Vicino(Xpart,Ypart,ZPart,Gterm^[i]^.xterm,Gterm^[i]^.yterm,Gterm^[i]^.zterm);

    if trovato then
    writelog('    collegato con terminale '+inttostr(i),Gterm^[i]^.xterm,Gterm^[i]^.yterm,Gterm^[i]^.zterm)
    else writelog('    fallito con terminale '+inttostr(i),Gterm^[i]^.xterm,Gterm^[i]^.yterm,Gterm^[i]^.zterm);

    if not trovato then Inc(i);
    end;
  if trovato then result:=i
  else
    begin
    InserisciErrore('Manca il terminale ',piano,XPart,YPart);
    result:=0;
    end;
end;

Procedure Settacollettori;
Var I,J,eliminati:integer;
    nocol,l1,l2:boolean;
begin
writeln(flog,'Pulizia rami morti del collettore');
for i:=1 to ultriga do
with dis^[i]^ do
if cl  then  VColl:=false;

  repeat
  eliminati:=0;
  for i:=1 to ultriga do
  with dis^[i]^ do
    begin
    nocol:=false;
    l1:=false;
    l2:=false;
    if (cl)and(not Vcoll) then
      begin
      for j:=1 to ultriga  do
      if not(nocol)and(not l1 or not l2 ) then
      if not dis^[j]^.Vcoll then
      if (i<>j) then
      if    vicino(x1,y1,z1,dis^[j]^.x1,dis^[j]^.y1,dis^[j]^.z1)
         or vicino(x1,y1,z1,dis^[j]^.x2,dis^[j]^.y2,dis^[j]^.z2)
         or vicino(x2,y2,z2,dis^[j]^.x1,dis^[j]^.y1,dis^[j]^.z1)
         or vicino(x2,y2,z2,dis^[j]^.x2,dis^[j]^.y2,dis^[j]^.z2)
      then
        begin
        if    vicino(x1,y1,z1,dis^[j]^.x1,dis^[j]^.y1,dis^[j]^.z1)
         or vicino(x1,y1,z1,dis^[j]^.x2,dis^[j]^.y2,dis^[j]^.z2) then l1:=true;
        if  vicino(x2,y2,z2,dis^[j]^.x1,dis^[j]^.y1,dis^[j]^.z1)
         or vicino(x2,y2,z2,dis^[j]^.x2,dis^[j]^.y2,dis^[j]^.z2) then l2:=true;
        if not dis^[j]^.cl then nocol:=true;
        end;
      if not (nocol) and (not l1 or not l2 ) then
        begin
        writeln(flog,'eliminata  riga'+inttostr(i));
        inc(eliminati);
        vcoll:=true;
        end;
      end;
    end;
  until eliminati=0;
end;

function stcl(ind:integer):string;
begin
if dis^[ind]^.CL then result:=' CL' else result:='';
end;
Function Trovalinea(Premessa:string;Xpart,Ypart,Zpart:real;Var i:integer;Escl:integer):boolean;
Var trovato:boolean;
    temp:real;
    P1:boolean;
    j: Integer;
begin
  writelog(premessa+'Cerco collegamento a partire dalla linea '+inttostr(i+1)+' a',Xpart,Ypart,Zpart);
  inc(i);
  Trovato:=false;
  if ultriga=0 then exit;
  while (i<=Ultriga)and(not trovato) do
    begin
    p1:=true;
    trovato:=(i<>escl)and Vicino(Xpart,Ypart,ZPart,
                                 dis^[i]^.x1,dis^[i]^.y1,dis^[i]^.z1);

    if premessa<>'Rami morti CL ' then
    //if Trovato and dis^[i]^.CL and (not Trovalinea('Rami morti CL ',Dis^[i]^.x2,Dis^[i]^.y2,Dis^[i]^.z2, j, i)) then
    if Trovato and dis^[i]^.Vcoll then
    begin
     writeln(flog,premessa+'    Ignotato ramo morto collettore '+inttostr(i));
     trovato := False;
    end;

    if trovato then
    begin
      writelog(premessa+'    collegato con linea ' + inttostr(i)+stCL(i)+' P1',dis^[i]^.x1,dis^[i]^.y1,dis^[i]^.z1);
      writelog(premessa+'    secondo punto',dis^[i]^.x2,dis^[i]^.y2,dis^[i]^.z2)
    end
    else
      begin
      if i=escl then writelog(premessa+'    non collegato con se stessa '+inttostr(i)+stCL(i)+' P1:',dis^[i]^.x1,dis^[i]^.y1,dis^[i]^.z1)
      else writelog(premessa+'    fallito con linea '+inttostr(i)+stCL(i)+' P1:',dis^[i]^.x1,dis^[i]^.y1,dis^[i]^.z1);
      end;

     if not trovato then
      begin
      p1:=false;
      trovato:=(i<>escl)and Vicino(Xpart,ypart,zpart,
                                  dis^[i]^.x2,dis^[i]^.y2,dis^[i]^.z2);

     //if Trovato and dis^[i]^.CL and (not Trovalinea('Rami morti CL ',Dis^[i]^.x1,Dis^[i]^.y1,Dis^[i]^.z1, j, i)) then
     if Trovato and dis^[i]^.Vcoll then
     begin
      writeln(flog,premessa+'    Ignotato ramo morto collettore '+inttostr(i));
      trovato := False;
     end;

     if trovato then
        begin
        writelog(premessa+'    collegato con linea '+inttostr(i)+stCL(i)+' P1:',dis^[i]^.x2,dis^[i]^.y2,dis^[i]^.z2);
        writelog(premessa+'    secondo punto',dis^[i]^.x1,dis^[i]^.y1,dis^[i]^.z1)
        end
      else
        begin
        if i=escl then writelog(premessa+'    non collegato con se stessa '+inttostr(i)+stCL(i)+' P1:',dis^[i]^.x2,dis^[i]^.y2,dis^[i]^.z2)
        else writelog(premessa+'    fallito con linea '+inttostr(i)+stCL(i)+' P1:',dis^[i]^.x2,dis^[i]^.y2,dis^[i]^.z2);
        end;
      end;
    if not trovato then Inc(i);
    end;
  if (trovato)and(not p1) then
  With dis^[i]^ do
  begin
    writeln(flog,premessa+'    Invertito orientamento linea '+inttostr(i));
    temp:=x1;
    x1:=x2;
    x2:=temp;
    temp:=y1;
    y1:=y2;
    y2:=temp;
    temp:=z1;
    z1:=z2;
    z2:=temp;
    p1:=true;
  end;
  result:=trovato;
end;

Function Trete(indl:integer):integer;
Var i:integer;
begin
  result:=0;
  i:=0;
  while (i<NTipirete)and(result=0) do
    begin
    inc(i);
    if Formst(dis^[indl].color)=Formst(Tipirete_d^[i].Cod) then result:=i;
    end;
  if result=0 then result:=1;
end;


Procedure CreaNodo(indl:integer; IndiceRete: Byte; var Inutile: Boolean;Ulttipotubo:string);
Var indln1,indln2,indln3,i,NumTronco, j:integer;
    trovata,almenouno, InutileLoc:boolean;
begin
  //Inutile := False;
  if Ulttronco < lungdati then
     inc(Ulttronco);
  if Dati^[Ulttronco]=Nil then new(Dati^[Ulttronco]);
  writeln(flog,'Creato nodo:'+inttostr(Ulttronco)+' , linea iniziale:'+Inttostr(indl));
  with Dati^[Ulttronco]^ do
  begin
   num := Ulttronco;
   Lungh:=sqrt(sqr(dis^[indl]^.x2-dis^[indl]^.x1)+sqr(dis^[indl]^.y2-dis^[indl]^.y1)+sqr(dis^[indl]^.z2-dis^[indl]^.z1));
   //Emanuela 20/06/2005: condizione inserita affinchè non si considerino le proprierà dei
   //trattini del collettore per poi assegnarli in un secondo momento quelli del tratto successivo
   //collegati ad esso
   //provv if not dis^[indl]^.Vcoll then
   if true then
   begin
     //inc(conta_rami);
     codicetubo:=ulttronco;
    //CodiceTubo := dis^[indl]^.CodiceTubo;
    // Emanuela 4/3/2004 inserito il tipo del tubo
    if (ulttipotubo<>'')and(dis^[indl]^.Rimando<>'')then //colonna montante verticale
    tipo:=ulttipotubo
    else Tipo := dis^[indl]^.tipo;
    ulttipotubo:=tipo;
    CodDiam:=dis^[indl]^.CodDiam;
    If (CodDiam<>'')and(CodDiam <> ' ') then
       SWDiam := '*'
    else SWDiam:='';
   end
   else
   begin
    CodiceTubo := 0;
    Tipo := '';
    CodDiam:='';
    SWDiam:='';
   end;
    Piano := dis^[indl]^.PianoCAD;
    Ti:=indl;
    xbase := 0;
    ybase := 0;
    x := 0;
    y := 0;
    CodiceNodo := 0;
    Dh := 0;
    Diam := 0;
    Velocita := 0;
    for i := 0 to PezziTr do Pezzi[i] := 0;
    Indtabcalc := 0;
    Npros:=0;
    term:=0;
    port:=0;
    porteff:=0;
    // Inizializzati a zero per evitare problemi di -NAN
    pd := 0;
    pl := 0;
    pp := 0;
    pr := 0;
    sfavorito:='';
    TipoRete := trete(indl);
    for i:=1 to 6 do pros[i]:=0;
    Npconc:=0;
    for i:=1 to Maxpconc do
    begin
      pconc[i].cod:='';
      pconc[i].n:=0;
    end;
    NCodTratti := 0;
    for i:=1 to 20 do
      CodTratti[i] := 0;
  end;
  NumTronco:=Ulttronco;
  dis^[Indl]^.Tronco := Numtronco;
  dis^[Indl]^.Visitato := true;

  Repeat
  almenouno:=false;
  Indln1:=0;
  trovata:=Trovalinea('',Dis^[indl]^.x2,Dis^[indl]^.y2,Dis^[indl]^.z2,indln1,indl);
  indln2:=indln1;
  if trovata then
    begin
      repeat
      trovata:=Trovalinea('',Dis^[indl]^.x2,Dis^[indl]^.y2,Dis^[indl]^.z2,indln2,indl);
      // Emanuela 17/6/2005: modifica per considerare l'ultimo ramo del collettore affinchè non
      // venga aggiunto all'arco e venga dimensionato come il collettore
      if (Dis^[indl]^.Coll) and (not Trovata) then Trovata := true;
      if trovata then
      begin
        if (not almenouno) then
        begin
         // Emanuela 17/03/2004: inserito controllo per verificare se il tratto
         // è stato visitato in modo da evitare che venga allocato più volte
         if (not dis^[Indln1]^.Visitato) then
         begin
           if Dati^[NumTronco]^.Npros < 6 then
              Inc(Dati^[NumTronco]^.Npros)
           else
           //MessageDlg('Un nodo non può avere più di 6 uscite', mtInformation, [mbOK], 0);
             begin
             InserisciErrore('Un nodo non può avere più di 6 uscite ','',Dati^[NumTronco]^.x,Dati^[NumTronco]^.y);
             exit;
             end;
           Dati^[NumTronco]^.Pros[Dati^[NumTronco]^.Npros]:=Ulttronco+1;
           Writeln(flog,'Il tronco '+inttostr(numtronco)+' arco '+inttostr(Dati^[NumTronco]^.Npros)+' agganciato al tronco '+inttostr(Ulttronco+1));
           CreaNodo(indln1, IndiceRete, InutileLoc,ulttipotubo);
         end
         else
         begin
           // Emanuela 30/7/2004 inserimento di un errore perchè si è trovato un ciclo
              InserisciErrore('E'' stato trovato un anello nella rete in prossimità dell''arco ' + IntToStr(dis^[Indln1]^.CodiceTubo) + ', il calcolo non può essere effettuato','',(dis^[Indln1]^.x1+dis^[Indln1]^.x2)/2,(dis^[Indln1]^.y1+dis^[Indln1]^.y2)/2);
              exit;
         end;
       end;
        almenouno:=true;
        // Emanuela 17/03/2004: inserito controllo per verificare se il tratto
        // è stato visitato in modo da evitare che venga allocato più volte
        // Emanuela 17/6/2005: modifica per considerare l'ultimo ramo del collettore affinchè non
        // venga aggiunto all'arco e venga dimensionato come il collettore
        if Indln2 <= ultriga then
        begin
          if (not dis^[Indln2]^.Visitato)  then
          begin
             if Dati^[NumTronco]^.Npros < 6 then
                Inc(Dati^[NumTronco]^.Npros)
             else
             begin
             InserisciErrore('Un nodo non può avere più di 6 uscite , il calcolo non può essere effettuato','',Dati^[NumTronco]^.x,Dati^[NumTronco]^.y);
             exit;
             end;
             //MessageDlg('Un nodo non può avere più di 6 uscite', mtInformation, [mbOK], 0);
              Dati^[NumTronco]^.Pros[Dati^[NumTronco]^.Npros]:=Ulttronco+1;
              Writeln(flog,'Il tronco '+inttostr(numtronco)+' arco '+inttostr(Dati^[NumTronco]^.Npros)+' agganciato al tronco '+inttostr(Ulttronco+1));
           CreaNodo(indln2, IndiceRete, InutileLoc,ulttipotubo);
          end
          else
          begin
            // Emanuela 30/7/2004 inserimento di un errore perchè si è trovato un ciclo
             Writeln(flog,'E'' stato trovato un anello nella rete in prossimità dell''arco ' + IntToStr(dis^[Indln2]^.CodiceTubo) );
             InserisciErrore('E'' stato trovato un anello nella rete in prossimità dell''arco ' + IntToStr(dis^[Indln2]^.CodiceTubo) + ', il calcolo non può essere effettuato','',0,0);
             exit;
          end;
        end
        else Trovata := False;
      end;
      until not trovata;
    trovata:=true;
    if not almenouno then
    begin
        Writeln(flog,'Collegata linea '+inttostr(indl)+' a linea '+inttostr(indln1));
        dis^[Indl]^.Nlinea:=indln1;
        dis^[Indln1]^.Tronco:=Numtronco;
        dis^[Indln1]^.indrete := IndiceRete;
        //Emanuela 20/06/2005: condizione inserita affinchè si considerino le proprierà dei
        //tratti collegati ai trattini del collettore collegati in modo da considerare le giuste proprietà
        if Dati^[NumTronco]^.codicetubo = 0 then
        begin
         Dati^[NumTronco]^.CodiceTubo := dis^[indln1]^.CodiceTubo;
         // Emanuela 4/3/2004 inserito il tipo del tubo
         Dati^[NumTronco]^.Tipo := dis^[indln1]^.tipo;
         Dati^[NumTronco]^.CodDiam := dis^[indln1]^.CodDiam;
         If Dati^[NumTronco]^.CodDiam <> ' ' then Dati^[NumTronco]^.SWDiam := '*'
         else Dati^[NumTronco]^.SWDiam := '';
        end{
        else Dati^[NumTronco]^.Tipo := dis^[indl]^.Tipo;
        dis^[Indln1]^.Codicetubo:=Numtronco};
        indl:=indln1;
        // Emanuela 17/03/2004: Indicazione che il pezzo di tratto è visitato
        dis^[indl]^.Visitato := True;
        if dis^[indl]^.rimando<>'' then
           Dati^[Numtronco]^.Lungh:=Dati^[Numtronco]^.Lungh+dis^[indl]^.lungtubo
        else
         if Dati^[Numtronco]^.CodiceTubo <> dis^[indl]^.codicetubo then
         begin
           inc(Dati^[Numtronco]^.NCodTratti);
           Dati^[Numtronco]^.CodTratti[Dati^[Numtronco]^.NCodTratti] := dis^[indl]^.codicetubo;
         end;
           Dati^[Numtronco]^.Lungh:=Dati^[Numtronco]^.Lungh+
           sqrt(sqr(dis^[indl]^.x2-dis^[indl]^.x1)+sqr(dis^[indl]^.y2-dis^[indl]^.y1)+sqr(dis^[indl]^.z2-dis^[indl]^.z1));
       end;
    end;

  until (Not Trovata)or(almenouno);
  if not almenouno then
     begin
     Dati^[Numtronco]^.Term:=Trovaterm(dis^[Indl]^.x2,dis^[Indl]^.y2,dis^[Indl]^.z2,dis^[Indl]^.piano);
     if Dati^[Numtronco]^.Term<>0 then gterm^[Dati^[Numtronco]^.Term].Taratura:='*';
     end;
end;

Procedure costruiscigrafo(xx,yy,zz:real; var Orig: Integer; IndiceRete: Byte);
Var
  indln1:integer;
  Inut: Boolean;
Begin
 Inut := False;
 conta_rami:=0;
 assignFile(flog, IncludeTrailingPathDelimiter(percorsoDrive) + 'tubilog.txt');
 try
   rewrite(Flog);
   Settacollettori;
  // writeln(Flog,inttostr(ultriga)+' linee ,'+inttostr(ngterm)+' Terminali');
  // writeln(Flog,'Origine in:'+float_to_str(xx,4)+','+float_to_str(yy,4)+','+float_to_str(zz,4));
   risultcalc.XOrig   := xx;
   risultcalc.yOrig   := yy;
   risultcalc.zOrig   := zz;
   if  (risultcalc.XOrig=0)and(risultcalc.yOrig=0)and(risultcalc.zOrig=0) then
   InserisciErrore('Inizio o ripresa rete non trovato','',0,0)
   else
     begin
     risultcalc.origine := UltTronco + 1;
     Orig := risultcalc.origine;
     Indln1 := 0;
     if Trovalinea('Inizio ',risultcalc.XOrig,risultcalc.yOrig,risultcalc.zOrig,indln1,0) then
       begin
       CreaNodo(indln1, IndiceRete, Inut,'');
       Trovaperdite;
       end
     else
       begin
       InserisciErrore('Nessun tratto collegato all''inizio rete','',risultcalc.XOrig,risultcalc.yOrig);
       // Emanuela 15/5/2005 correzione affinchè non venga considerato qualche origine che non ha
       // tubi associati
       risultcalc.origine:=0;
       orig := 0;
       end;
     //Settafiltro;
     end;
   closeFile(flog);
 except
   closeFile(flog);
 end;
end;

Procedure Aggiungi_perdita(Nodo:integer;Cod:string;NumPerd:integer);
Var Trov:boolean;
    i:integer;
begin
  cod:=upstring(cod);
  if (cod='')or(numperd=0) then exit;
  trov:=false;
  with Dati^[nodo]^ do
  begin
    i:=0;
    while (i<NPconc)and(not trov) do
    begin
      inc(i);
      if upstring(Pconc[i].Cod) = UpString(cod) then
      begin
        Trov:=true;
        Pconc[i].N:=Pconc[i].N+NumPerd;
      end;
    end;
    if not trov then
    begin
     if NPConc < Maxpconc then
        inc(NPconc);
      Pconc[NPconc].N:=NumPerd;
      Pconc[Npconc].Cod:=cod;
  end;
 end;
end;

function PostFissoAngolo(Ind1, Ind2: Integer; Diram: Boolean): String;
var
  Dir, Dirz: real;
  Orient: Integer;
  Vert: Boolean;
begin
 Result := '';
 if (Ind1 = 0) or (Ind2 = 0) then
  exit;
  CalcAng(Ind1, Ind2, Dir, DirZ, Orient, Vert, 0);
  if Dirz = 0 then Result := CodAngolo(Dir, Diram)
  else Result := CodAngolo(Dirz, Diram);
end;

function Togli2Car(S: String): String;
begin
  Result := Copy(S,1,Length(S) - 2);
end;

Procedure CodAngoloDiramazione(TipoRete, Nodo: Integer; Ind1, Ind2: Integer);
var
  Dir, Dirz: real;
  Orient: Integer;
  Vert: Boolean;
  Angolo: String;
begin
 if (Ind1 = 0) or (Ind2 = 0) then
    exit;
 CalcAng(Ind1, Ind2, Dir, DirZ, Orient, Vert, 0);
 if Dir = 0 then Dir := Dirz;
 if Dir <> 0 then
 begin
   Angolo := PostFissoAngolo(ind1, ind2, True);
   if Angolo <> '' then
    Aggiungi_perdita(Nodo,Togli2Car(tipirete_d^[Tiporete].TipoDiramazioni) + Angolo,1)
   else Aggiungi_perdita(Nodo,Angolo,1);
 end;
end;

const apr=0.001{0.01};

{$I Inters}

function IntersPuntolinea(xp,yp:real;indlin:integer):boolean;
Var res:integer;
    xint,yint:real;
begin
 with dis^[indlin]^ do
 begin
  inters(xint,yint,res,x1,x2,xp-apr,Xp+apr,Y1,Y2,Yp-apr,Yp+apr);
  if res=0 then
  inters(xint,yint,res,x1,x2,xp+apr,Xp-apr,Y1,Y2,Yp+apr,Yp-apr);
  if (res<>0)and(abs(xp-x1)<apr)and(abs(yp-y1)<apr) then  res:=0; //esclude punto iniziale agganciato dalla linea precedente
  if (res=0)and(abs(xp-x2)<apr)and(abs(yp-y2)<apr) then  res:=1; //include punto finale a volte non rilevato
 end;
result:=(res<>0);
end;

Procedure TrovaValvole;
Var i,j:integer;
begin
for i:=1 to ultblocco do
   blocchi^[i]^.riflinea:=0;
for i:=1 to ultblocco do
for j:=1 to ultriga do
with blocchi^[i]^ do
  begin
  if (uppercase(piano)=uppercase(dis^[j].PianoCad))and
     (interspuntolinea(x,y,j)) then
  riflinea:=j;
  end;
  for i:=1 to ultblocco do
    with blocchi^[i]^ do
      if riflinea<>0 then
         dis^[riflinea].Rid:=codperd;
end;

Procedure Trova_Valvole(indlinea:integer);
Var i:integer;
begin
 if indlinea=0 then exit;
for i:=1 to ultblocco do
 with blocchi^[i]^ do
   if riflinea=indlinea then
      Aggiungi_perdita(dis^[indlinea]^.tronco,codperd,1);
end;

Procedure Iter_trovaperdite(Nodo, IndLineaPadre:integer);
Var
  i:Integer;
  Angolo: String;
begin

with Dati^[nodo]^ do
  begin
  if (nodo<>RisultCalc^.Origine) then
  begin
    CodAngoloDiramazione(TipoRete, Nodo, indLineaPadre, dati^[nodo].Ti);
    //Aggiungi_perdita(nodo,tipirete_d^[Tiporete].TipoDiramazioni + PostFissoAngolo(indLineaPadre, dati^[nodo].Ti, True),1);
  end;
  i:=ti;
  trova_valvole(i);
  repeat
  if (i<>0)and(dis^[i]^.NLinea<>0) then
    begin
    if dis^[i]^.rimando<>'' then
    Aggiungi_perdita(nodo,dis^[i]^.codperd,dis^[i]^.numperd);

    if (dis^[i]^.rimando='')and(dis^[dis^[i]^.NLinea]^.rimando='') then
    if tipirete_d^[Tiporete].TipoCurve <> '' then
    begin
       Angolo := PostFissoAngolo(i, dis^[i]^.nlinea, False);
       if Angolo <> '' then
          Aggiungi_perdita(nodo,Togli2Car(tipirete_d^[Tiporete].TipoCurve) + Angolo,1)
       else Aggiungi_perdita(nodo,Angolo,1);
    end;
    i:=dis^[i]^.NLinea;
    trova_valvole(i);

    end;
  until (i=0)or(dis^[i]^.NLinea=0);
  for i:=1 to Npros do Iter_trovaperdite(pros[i], i);
  end;
end;

Procedure TrovaPerdite;
begin
 trovavalvole;
 Iter_trovaperdite(risultCalc^.origine,0);
end;


Procedure Iter_Settafiltro(Nodo:integer;ReteCor,Piano_cor:string);
Var i:Integer;
begin
 if Dati^[nodo] <> nil then
 begin
  with Dati^[nodo]^ do
  begin

  i:=ti;
  repeat
  if (i<>0) then
    begin
    if dis^[i]^.rimando='' then
      begin
      dis^[i]^.filtro:=retecor;
      //dis^[i]^.Piano:=Piano_cor;
      end
    else
      begin
      dis^[i]^.filtro:='';
      retecor:=dis^[i]^.rimando;
      Piano_cor:=dis^[i]^.Piano;
      {$Ifdef Versione_14}
      {$Else}
      fmaintubi.ComboBox2.Items.Add(retecor);
      {$Endif}
      end;
    i:=dis^[i]^.NLinea;
    end;
  until (i=0);
  for i:=1 to Npros do Iter_settafiltro(pros[i],retecor,Piano_cor);
  end;
 end;
end;

Procedure SettaFiltro;
var
  i: Integer;
begin
  for i := 1 to UltRiga do
      dis^[i]^.Filtro := '';
  {$Ifdef Versione_14}
  {$Else}
  with fmaintubi.ComboBox2 do
  begin
    Items.Clear;
    items.add('Rete principale');
    text:='Rete principale';
    itemIndex := 0;
  end;
  {$Endif}
  if risultCalc^.origine <> 0 then
     Iter_settafiltro(risultCalc^.origine,'Rete principale','');
end;

{-----------------------------------------------------------------------------
  Procedure: InserisciErrore
  Author:    Emanuela
  Date:      30-lug-2004
  Arguments: Errore: String
  Result:    None

  Rinserisci gli errori durante la visite del grafo
-----------------------------------------------------------------------------}
Procedure InserisciErrore(Errore,piano: String;Xer,Yer:real);
var
  FErrori: TextFile;
  salva_err:string;
begin
salva_err:=errore;
if not testrete then errore:=' piano:'+piano+' '+errore;
if not(un_errore) then
  begin
  //if testrete then
  if CalcUnPiano='' then CalcUnPiano:=piano;
  Assign(Ferrori,I_Sl(percorsodrive)+'errori_'+CalcUnPiano+'_'+CalcUnaRete+'.txe');
  //else
  //Assign(Ferrori,I_Sl(percorsodrive)+'\errori_'+CalcUnaRete+'.txe');
  rewrite(Ferrori);
  //if testrete then writeln(Ferrori,CalcUnPiano);
  writeln(Ferrori,CalcUnPiano);
  writeln(Ferrori,salva_ERR);

  writeln(Ferrori,float_to_str(xer+reccontrollo.or_x,5));
  writeln(Ferrori,float_to_str(yer+reccontrollo.or_y,5));
  close(ferrori);
  V_recgen.set_report({'('+float_to_str(xer+reccontrollo.or_x,1)+','+float_to_str(yer+reccontrollo.or_y,1)+')'+}Errore);
  Dmtutti.T_Reti.Post;
  Dmtutti.T_Reti.edit;
  end;
//if (not testrete)and(un_errore)then V_recgen.set_report(V_recgen.report+Errore+' --- ');

un_errore:=true;
{
  // Emanuela inserimento degli errori nel file erroriimpianti.txt
  if not fileexists(I_Sl(percorsodrive)+NomeFile_Errori_Impianti) then
    begin
    assign(ferrori,I_Sl(percorsodrive)+NomeFile_Errori_Impianti);
    rewrite(Ferrori);
    close(Ferrori);
    end;
  AssignFile(FErrori, IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_Errori_Impianti);
  try
    Append(FErrori);
    if nome_rete='' then
    writeln(FErrori,Errore)
    else writeln(FErrori,nome_rete+':'+Errore+':');
    CloseFile(FErrori);
  except
    CloseFile(FErrori);
  end;
 } 
end;

{-----------------------------------------------------------------------------
  Procedure: scriviquoteBM
  Author:    Emanuela
  Date:      17-mar-2005
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}

Procedure scriviquoteBM;
Var
  i, j, k:   Integer;
  ft:  Text;
  buf: String;
begin
 AssignFile(ft, IncludeTrailingPathDelimiter(percorsodrive) + 'tubiout.txt');
 try
   Rewrite(ft);
   //Scrittura dati dei tubi
   for i:=1 to ultriga do
   begin
     with dis^[i]^ do
     if dati^[tronco] <> nil then
     begin
      if dati^[tronco]^.ti = i then
      begin
        buf := 'T:' + IntToStr(dati^[tronco]^.codicetubo) + ':' + dati^[tronco]^.coddiam + ':' + inttostr(dati^[tronco]^.num) + ':';
        //Emanuela 4/3/2004 Inserita la portata e la velocità del tubo
        buf := Buf + Format('%1.4f', [dati^[tronco]^.PortEff]) + ':' + Format('%1.4f', [dati^[tronco]^.Velocita]) + ':';
        //Emanuela 4/3/2004 Inseriti i pezzi speciali
        for j := 1 to dati^[tronco].NPConc do
        begin
          buf := Buf + dati^[tronco]^.PConc[j].Cod + ':' + IntToStr(dati^[tronco]^.PConc[j].N) + ':';
        end;
        writeln(ft,Buf);
        for K := 1 to dati^[tronco]^.NCodTratti do
        begin
          buf := 'T:' + IntToStr(dati^[tronco]^.CodTratti[K]) + ':' + dati^[tronco]^.coddiam + ':' + inttostr(dati^[tronco]^.num) + ':';
          //Emanuela 4/3/2004 Inserita la portata e la velocità del tubo
          buf := Buf + Format('%1.4f', [dati^[tronco]^.PortEff]) + ':' + Format('%1.4f', [dati^[tronco]^.Velocita]) + ':';
          //Emanuela 4/3/2004 Inseriti i pezzi speciali
          for j := 1 to dati^[tronco].NPConc do
          begin
            buf := Buf + dati^[tronco]^.PConc[j].Cod + ':' + IntToStr(dati^[tronco]^.PConc[j].N) + ':';
          end;
          writeln(ft,Buf);
        end;

      end;
     end;
   end;
   //Scrittura dati dei terminali
   for i := 1 to NGTerm do
   begin
     with GTerm^[i]^ do
     begin
       buf := 'R:' + IntToStr(GTerm^[i]^.codiceterminale) + ':' + Format('%1.4f', [GTerm^[i]^.pot]) + ':' + IntToStr(GTerm^[i]^.NumElementi) + ':';
       // Emanuela 15/11/2004: inserimento dei dati sul modello e numeri termici del terminale
       buf := buf + GTerm^[i]^.Modello + ':' + GTerm^[i]^.Serie + ':' + FloatToStr(GTerm^[i]^.Profondita) + ':' + FloatToStr(GTerm^[i]^.Altezza) + ':';
       buf := buf + FloatToStr(GTerm^[i]^.Larghezza) + ':' + Format('%1.4f', [GTerm^[i]^.potE]) + ':' + Format('%1.4f', [GTerm^[i]^.Sbil]) + ':';
       writeln(ft,Buf);
     end;
   end;
   CloseFile(Ft);
 except
   CloseFile(Ft);
 end;
end;

{-----------------------------------------------------------------------------
  Procedure: LeggiFileTubi
  Author:    Emanuela
  Date:      17-mar-2005
  Arguments: nomef:string
  Result:    None
-----------------------------------------------------------------------------}

Procedure LeggiFileTubi(nomef:string);
Var
  Fin: TextFile;
  Buf, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, pianoent:string;
  p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27: String;
begin
CalcolaQuotaPiano;
AssignFile(fin,nomef);
try
 reset(fin);
 while not eof(fin) do
 begin
  buf := '';
  readln(fin,Buf);
  azzeraidentif;
  If copy(buf,1,6)='PIANO:' then
  begin
    p1:=leggiidentif1(buf); //Piano
    pianoent:=leggiidentif1(buf); //Nomepiano
  end;
  If copy(buf,1,2)='I:' then
  begin
    p1  := leggiidentif1(buf); // I
    p1  := leggiidentif1(buf); // codice entità
    p1  := leggiidentif1(buf); // X
    p2  := leggiidentif1(buf); // Y
    p3  := leggiidentif1(buf); // Z
    p4  := leggiidentif1(buf); // codice rete
    // Emanuela 5/4/2004
    p5  := Leggiidentif1(buf); // perdite ammesse in pred
    p6  := Leggiidentif1(buf); // velocità ammesse in pred
    p7  := Leggiidentif1(buf); // perdite ammesse rami favo
    p8  := Leggiidentif1(buf); // velocità ammesse rami fav
    p9  := Leggiidentif1(buf); // piano di riferimento
    p10 := Leggiidentif1(buf); // angolo di rotazione
   {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
    p12 := Leggiidentif1(buf); // tiporete Tubazioni o Canali
   {$IFEND}
    p11 := Leggiidentif1(buf); // specchiatura
    p13 := Leggiidentif1(buf); // velocità del collettore
    {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
    Cercarete(p4,p12,p9,p11,str_tofloat(p1),str_tofloat(p2),str_tofloat(p3) + RestituisciQuotaPiano(P9),str_tofloat(p5),str_tofloat(p6),str_tofloat(p7),str_tofloat(p8),str_tofloat(p10),str_tofloat(p13));
   {$ELSE}
    Cercarete(p4,'TUBAZIONI',p9,p11,str_tofloat(p1),str_tofloat(p2),str_tofloat(p3),str_tofloat(p5),str_tofloat(p6),str_tofloat(p7),str_tofloat(p8),str_tofloat(p10),str_tofloat(p13));
   {$IFEND}
  end;
  if copy(buf,1,2)='V:' then
  begin
    p1 := LeggiIdentif1(buf); //V
    p1 := LeggiIdentif1(buf); //Codice entità
    p1 := leggiidentif1(buf); //  X
    p2 := leggiidentif1(buf); //  Y
    p3 := leggiidentif1(buf); //  Z
    p4 := leggiidentif1(buf); //  codice rimando
    p5 := leggiidentif1(buf); //  lunghezza
    p6 := leggiidentif1(buf); //  tipo perdite
    p7 := leggiidentif1(buf); //  numeroperdite
    p8 := leggiidentif1(buf); //  Angolo di rotazione
    p9 := leggiidentif1(buf); //  Specchiatura
    //Cercarimando(p4,p5,p6,p7,true,str_tofloat(p1),str_tofloat(p2),0,'');
    // Emanuela inserito il caricamento delle Z
    Cercarimando(p4,p5,p6,p7,p9,true,str_tofloat(p1),str_tofloat(p2),str_tofloat(p3),str_tofloat(p8),Pianoent);
  end;
  if copy(buf,1,2)='C:' then
  begin
    p1 := LeggiIdentif1(buf); //C
    p1 := LeggiIdentif1(buf); //Codice entità
    p1 := leggiidentif1(buf); //  X
    p2 := leggiidentif1(buf); //  Y
    p3 := leggiidentif1(buf); //  Z
    p5 := leggiidentif1(buf); //  piano di riferimento
    p4 := leggiidentif1(buf); //  codice rimando
    p7 := leggiidentif1(buf); //  Angolo di rotazione
    p6 := leggiidentif1(buf); //  Specchiatura
    //Cercarimando(p4,'','','',false,str_tofloat(p1),str_tofloat(p2),0,'');
    // Emanuela inserito il caricamento delle Z
    Cercarimando(p5,'','','',p6,false,str_tofloat(p1),str_tofloat(p2),str_tofloat(p3),str_tofloat(p7),p4);
  end;
  If copy(buf,1,2)='T:' then
  begin
    p1:=leggiidentif1(buf); //  T
    p8:=leggiidentif1(buf); //  codice entità
    p1:=leggiidentif1(buf); //  X
    p2:=leggiidentif1(buf); //  Y
    p3:=leggiidentif1(buf); //  Z
    p4:=leggiidentif1(buf); //  X1
    p5:=leggiidentif1(buf); //  Y2
    p6:=leggiidentif1(buf); //  Z2
    p7:=leggiidentif1(buf); //  tipo tubo
    p9:=leggiidentif1(buf); //  DN
    p10:=leggiidentif1(buf); // Portata
    // Emanuela 17/6/2005: modifica per considerare l'ultimo ramo del collettore affinchè non
    // venga aggiunto all'arco e venga dimensionato come il collettore
    p11:=leggiidentif1(buf); // colettotre / tubo
    CaricaTubo(StrToInt(p8), p9, Pianoent, p11, p7, str_tofloat(p1),str_tofloat(p2),str_tofloat(p3),str_tofloat(p4),str_tofloat(p5),str_tofloat(p6));
  end;
  If copy(buf,1,2)='R:' then
    begin
    p1  := leggiidentif1(buf);  //  R
    p10 := leggiidentif1(buf);  //  codice entità
    p1  := leggiidentif1(buf);  //  X
    p2  := leggiidentif1(buf);  //  Y
    p3  := leggiidentif1(buf);  //  Z
    p23 := leggiidentif1(buf);  //  tipo terminale
    p4  := leggiidentif1(buf);  //  modello terminale
    p5  := leggiidentif1(buf);  //  Serie
    p6  := leggiidentif1(buf);  //  Potenza
    p8  := leggiidentif1(buf);  //  Profondità
    p9  := leggiidentif1(buf);  //  Altezza
    p11 := leggiidentif1(buf);  //  Larghezza
    p12 := leggiidentif1(buf);  //  Perdita
    p13 := leggiidentif1(buf);  //  Salto termico
    p14 := leggiidentif1(buf);  //  Incremento
    p15 := leggiidentif1(buf);  //  Larghezza Massima
    p19 := leggiidentif1(buf);  //  Angolo
    p16 := leggiidentif1(buf);  //  X dell'etichetta
    p17 := leggiidentif1(buf);  //  y dell'etichetta
    p18 := leggiidentif1(buf);  //  z dell'etichetta
    p21 := leggiidentif1(buf);  //  descrizione piano
    P22 := leggiidentif1(buf);  //  Numero elementi
    P7  := leggiidentif1(buf);  //  Portata terminale
    p20 := leggiidentif1(buf);  //  potenza estiva
    p24 := leggiidentif1(buf);  //  specchiato
   {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
    p25 := leggiidentif1(buf);  //  codice montaggio
    p26 := leggiidentif1(buf);  //  valore montaggio
    p27 := leggiidentif1(buf);  //  nome blocco DXF
   {$IFEND}
   CaricaTerminale(p10, p1, p2, p3, p23, p4,'NO', p5,'NO', p6, p8, p9, p11, p12, p13,
                   p14, p15, p19, p16, p17, p18, p21, p22, p7, p24, p20, p25, p26, p27);
   end;
  {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
   if copy(buf,1,2)='P:' then
   begin
      p1 := LeggiIdentif1(buf); //  P
      p1 := LeggiIdentif1(buf); //  Codice entità
      p1 := leggiidentif1(buf); //  X
      p2 := leggiidentif1(buf); //  Y
      p3 := leggiidentif1(buf); //  Z
      p5 := leggiidentif1(buf); //  piano di riferimento
      p4 := leggiidentif1(buf); //  codice valvola
      InserisciValvola(p4, StrToFloat(p1), StrToFloat(p2), StrToFloat(p3), p5);
   end;
  {$IFEND}
 end;
 CloseFile(fin);
except
 CloseFile(fin);
end;
end;

Procedure Inseriscivalvola(P_Piano:string;P_X,P_y,P_z:real;P_codperd:string);
begin
  if UltBlocco < LungBlocchi then
     inc(ultblocco);
  if blocchi^[ultblocco] = nil then new(blocchi^[ultblocco]);
  with blocchi^[ultblocco]^ do
  begin
    Piano := P_Piano;
    x := P_x;
    y := P_y;
    z := P_z;
    CodPerd := P_CodPerd;
  end;
end;

Procedure Cercarimando(codice,lung,codp,nump,spec:string;Rimando:boolean;X1,Y1,Z1,angolo:real;Piano:String);
Var i:integer;
begin
Codice:=Upstring(codice);
i:=1;
while (i<Ultriga)and(Upstring(dis^[i]^.rimando)<>UpString(codice))do inc(i);
if (Ultriga=0)or(Upstring(dis^[i]^.rimando)<>UpString(codice)) then
begin
  if UltRiga < LungDis then
     inc(ultriga);
  if dis^[ultriga]=Nil then new(dis^[ultriga]);
  // Inserito CL perchè non deve essere considerato come collettore
  dis^[Ultriga]^.CL := False;
  dis^[Ultriga]^.VL := False;
  dis^[Ultriga]^.Coll := False;
  dis^[Ultriga]^.Vcoll := False;
  dis^[Ultriga].color:='';
  dis^[Ultriga]^.Entita := '';
  dis^[Ultriga]^.codicetubo := 0;
  dis^[Ultriga]^.Tipo := '';
  dis^[Ultriga]^.Settore := '';
  dis^[Ultriga]^.NPezzo := 0;
  dis^[Ultriga]^.Rid := '';
  dis^[Ultriga].rimando:=codice;
  dis^[Ultriga].x1:=x1;
  dis^[Ultriga].y1:=y1;
  dis^[Ultriga].z1:=RestituisciQuotaPiano(Piano) + z1;
  dis^[Ultriga].x2:=0;
  dis^[Ultriga].Y2:=0;
  dis^[Ultriga].z2:=0;
  dis^[Ultriga].tronco:=0;
  dis^[Ultriga].nlinea:=0;
  dis^[Ultriga].Lungtubo:=0;
  dis^[Ultriga].filtro := '';
  if (piano<>'') then
   dis^[Ultriga].Piano  := Piano;
  dis^[Ultriga]^.PianoCAD := '';
  dis^[Ultriga]^.Spec   := spec;
  dis^[Ultriga]^.Angolo := angolo;
  dis^[Ultriga]^.color := '';
  dis^[Ultriga]^.flag := False;
  dis^[Ultriga]^.Visitato := False;
  if rimando then
  begin
    if lung <> '' then
       dis^[Ultriga].lungtubo := str_tofloat(lung)
    else dis^[Ultriga].lungtubo := 0;
    if nump = '' then
    begin
      dis^[Ultriga].NumPerd := 0;
      dis^[Ultriga].codperd := '';
    end
    else
    begin
     dis^[Ultriga].NumPerd:=strtoint(nump);
     dis^[Ultriga].codperd:=codp;
    end;
  end
  else
  begin
    dis^[Ultriga].NumPerd := 0;
    dis^[Ultriga].codperd := '';
  end;
end
else
  begin
  if (piano<>'') then
  dis^[i].Piano:= Piano;
  dis^[i].x2:=x1;
  dis^[i].Y2:=y1;
  dis^[i].z2:=RestituisciQuotaPiano(Piano) + z1;
  end;
end;

procedure CaricaTubo(Codice: Integer; DN, Piano, Collettore, Tipo: String; X, Y, Z, X1, Y1, Z1: Double);
begin
  z := RestituisciQuotaPiano(Piano) + z;
  z1 := RestituisciQuotaPiano(Piano) +  z1;
  if not vicino(X,Y,Z,X1,Y1,Z1) then
    begin
       if UltRiga < LungDis then
          inc(ultriga);
        if dis^[ultriga] = Nil then
           new(dis^[ultriga]);
        dis^[Ultriga]^.entita := '';
        dis^[Ultriga]^.codicetubo := codice;
        // Emanuela 4/3/2004 inserito il tipo affinchè venga ricordato
        dis^[UltRiga]^.Tipo := Tipo;
        dis^[UltRiga]^.CodDiam := DN;
        dis^[Ultriga]^.filtro := '';
        dis^[Ultriga]^.Settore := '';
        dis^[Ultriga]^.rimando:= '';
        dis^[Ultriga]^.color  := '';
        dis^[Ultriga]^.Lungtubo := 0;
        dis^[Ultriga]^.NumPerd := 0;
        dis^[Ultriga]^.codperd := '';
        dis^[Ultriga]^.x1 := x;
        dis^[Ultriga]^.y1 := y;
        // Emanuela inserito il caricamento delle Z
        //dis^[Ultriga].z1:=0;
        dis^[Ultriga]^.z1 := z;
        dis^[Ultriga]^.x2 := x1;
        dis^[Ultriga]^.Y2 := y1;
        // Emanuela inserito il caricamento delle Z
        //dis^[Ultriga].z2:=0;
        dis^[Ultriga]^.z2:= z1;
        dis^[Ultriga]^.tronco := 0;
        dis^[Ultriga]^.nlinea := 0;
        dis^[Ultriga]^.NPezzo := 0;
        dis^[Ultriga]^.Rid    := '';
        dis^[Ultriga]^.tlinea := 0;
        dis^[Ultriga]^.flag   := False;
        dis^[Ultriga]^.Visitato := False;
        dis^[Ultriga]^.Piano := '';
        dis^[Ultriga]^.PianoCAD := piano;
        dis^[Ultriga]^.Spec := '';
        dis^[Ultriga]^.x_lab:=0;
        dis^[Ultriga]^.y_lab:=0;
        // Emanuela 17/6/2005: modifica per considerare l'ultimo ramo del collettore affinchè non
        // venga aggiunto all'arco e venga dimensionato come il collettore
        if collettore = 'C' then
        begin
           dis^[Ultriga]^.CL := True;
           dis^[Ultriga]^.Coll := True;
           dis^[Ultriga]^.Vcoll := False;
        end
        else  if Collettore = 'CL' then
              begin
                 dis^[Ultriga]^.CL := True;
                 dis^[Ultriga]^.Coll := False;
                 dis^[Ultriga]^.Vcoll := True;
              end
              else
              begin
                dis^[Ultriga]^.CL := False;
                dis^[Ultriga]^.VL := False;
                dis^[Ultriga]^.Coll := False;
                dis^[Ultriga]^.Vcoll := False;
              end;
  end;
end;

procedure CaricaTerminale(codice, x, y, z, tipo, modello,fissamodello, serie,fissaserie, potenzaI, prof, alt, larg, perdita, st,
                          incr, largmax, ang, xe, ye, ze, piano, numel, port, spec, potest, codmont, valmont, nomebloccodxf: String);
begin
  if NGTerm < MaxGTerm then
     Inc(NGterm);
  if Gterm^[Ngterm]=nil then new(Gterm^[Ngterm]);
  Gterm^[Ngterm]^.POtInp  := str_tofloat(potenzaI);
  Gterm^[Ngterm]^.POtE  := str_tofloat(potEst);
  Gterm^[Ngterm]^.Dt   := str_tofloat(st);
  if Gterm^[Ngterm]^.Dt = 0 then Gterm^[Ngterm]^.Dt := 10;
  if CompareStr(UpperCase(Tipo), 'FANCOIL') = 0 then
     Gterm^[Ngterm]^.PerdInp := str_tofloat(perdita)
  else Gterm^[Ngterm]^.PerdInp := str_tofloat(perdita)/1000;       {kPA}
  // Emanuela 4/3/2004: Introdotto controllo per evitare una divisione per zero
  // Verificato se la portata è imposta al terminale
  if Str_ToFloat(port) <> 0 then
     Gterm^[Ngterm]^.PortInp := str_tofloat(port)
  else
  begin
   if (Gterm^[Ngterm]^.POt <> 0) and (Gterm^[Ngterm]^.DT  <> 0) then
       Gterm^[Ngterm]^.Port := Gterm^[Ngterm]^.pot * 2.427184E-4/Gterm^[Ngterm]^.Dt;
  end;
  //else Gterm^[Ngterm]^.port := str_tofloat(p7);
  Gterm^[Ngterm]^.XTerm := str_tofloat(x);
  Gterm^[Ngterm]^.Yterm := str_tofloat(y);
  Gterm^[Ngterm]^.ZTerm := RestituisciQuotaPiano(Piano) + str_tofloat(z);
  Gterm^[Ngterm]^.cod   := ''; //CaricaCodice(Gterm^[Ngterm]^.XTerm,Gterm^[Ngterm]^.YTerm,pianoent,Gterm^[Ngterm]^.Numamb);
  if codice<>'??' then Gterm^[Ngterm]^.Codiceterminale := StrToInt(codice)
  else Gterm^[Ngterm]^.Codiceterminale :=0;
  // Emanuela inserito il caricamento delle Z
  //Gterm^[Ngterm]^.ZTerm:=0;
  if Fgtb^[NGterm]=Nil then new(Fgtb^[NGterm]);
  Fgtb^[NGterm].IndM       := Ngterm;
  Gterm^[Ngterm]^.Taratura := '';
  Gterm^[Ngterm]^.NumTer   := 0;
  // Emanuela 5/4/2004 inserite le altre proprietà del terminale
  Gterm^[Ngterm]^.TipoTerm     := Tipo;
  Gterm^[Ngterm]^.Modello      := Modello;
  Gterm^[Ngterm]^.FissaModello:=uppercase(fissamodello)='SI';
  Gterm^[Ngterm]^.Serie        := Serie;
  Gterm^[Ngterm]^.FissaSerie:=uppercase(fissaSerie)='SI';
  Gterm^[Ngterm]^.Profondita   := str_tofloat(prof);
  Gterm^[Ngterm]^.Altezza      := str_tofloat(alt);
  Gterm^[Ngterm]^.Larghezza    := str_tofloat(larg);
  Gterm^[Ngterm]^.IncrPotenza  := str_tofloat(incr);
  Gterm^[Ngterm]^.LarghezzaMax := str_tofloat(largmax);
  Gterm^[Ngterm]^.Angolo := str_tofloat(ang);
  Gterm^[Ngterm]^.XEtic  := str_tofloat(xe);
  Gterm^[Ngterm]^.YEtic  := str_tofloat(ye);
  Gterm^[Ngterm]^.ZEtic  := RestituisciQuotaPiano(Piano) + str_tofloat(ze);
  Gterm^[Ngterm]^.Spec   := spec;
  Gterm^[Ngterm]^.Piano  := piano;
  if numel <> '' then
     Gterm^[Ngterm]^.NumElementi := StrToInt(numel);
 {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
  if Valmont = 'Nessuno' then
     Gterm^[Ngterm]^.Montaggio := codmont
  else Gterm^[Ngterm]^.Montaggio := valmont;
  Gterm^[Ngterm]^.NomeBlocco := nomebloccoDXF;
 {$ELSE}
  Gterm^[Ngterm]^.Montaggio := '';
 {$IFEND}
  Gterm^[Ngterm]^.CodentDxf := '';
  Gterm^[Ngterm]^.sbil := 0;
  Gterm^[Ngterm]^.Diam := '';
end;



Procedure G_Linea(x1,y1,z1,x2,y2,z2:real;Layer, Piano:string);
Var
  Xi, Yi, Zi, Xf, Yf,Zf: String;
begin
  Xi := Format('%1.4f', [x1]);
  Yi := Format('%1.4f', [y1]);
  Zi := Format('%1.4f', [z1]);
  Xf := Format('%1.4f', [x2]);
  Yf := Format('%1.4f', [y2]);
  Zf := Format('%1.4f', [z2]);
  writeln(FRitorno,'T:' + Piano + ':' + Xi +':'+ Yi +':'+ Zi +':'+ Xf +':'+ Yf +':'+ Zf +':');
end;

procedure ApriFileRitorno(NomeFile: String);
begin
  AssignFile(FRitorno, IncludeTrailingPathDelimiter(percorsodrive) + 'tubirit.txt');
  try
    Rewrite(FRitorno);
  except
    CloseFile(FRitorno);
  end;
end;

procedure ChiudiRitorno;
begin
  CloseFile(FRitorno);
end;

procedure CalcolaQuotaPiano;
var
  i: Integer;
begin
if NPiani <> 0 then
 for i := 2 to NPiani do
   Piani_d[i].Quota := Piani_d[i-1].Quota + Piani_d[i].AltL;
end;

function RestituisciQuotaPiano(Piano: String): double;
var
  i: Integer;
  Trovato: Boolean;
begin
  Result := 0;
  i := 1;
  Trovato := False;
  while (i <= NPiani) and (not Trovato) do
  begin
    if CompareStr(UpperCase(Piani_d[i].Cod), UpperCase(Piano)) = 0 then
    begin
       Result := Piani_d[i].Quota;
       Trovato := True;
    end;
    inc(i);
  end;
end;

end.
