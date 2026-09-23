unit ULeggitxt;

interface
Uses Libreriagenerale, SysUtils, Dialogs,
     Udatalink,
     {$Ifdef Versione_14}
     udbT,
     {$else}
     udb,
     {$endif}
      definiz;

Procedure LeggiElencoRet1Txt;
Procedure LeggiReteTxt(Codice:string);
Procedure Cercarete(codice,Descr,Piano,Spec:string;Xorig,Yorig,Zorig,dps,maxvels,dpe,maxvele,Angolo,maxvcol:real);
Procedure OutTxt;
implementation
{$Ifdef Versione_14}
uses mess_reti;
{$else}
uses Umain_calctubi;
{$endif}

Var Par,Par1,Buf,Parx,Pary,Parz,Nomefile:string;
    FF:textFile;

Procedure Cercarete(codice,Descr,Piano,Spec:string;Xorig,Yorig,Zorig,dps,maxvels,dpe,maxvele,Angolo,maxvcol:real);
begin
{$Ifdef Versione_14}
dmtutti.T_Reti.first;
while (not dmtutti.T_Reti.Eof)and(upstring(V_Recgen.Codice)<>upstring(Codice)) do
dmtutti.T_Reti.next;
{$else}
dm1.tt1.first;
while (not dm1.tt1.Eof)and(upstring(V_Recgen.Codice)<>upstring(Codice)) do
dm1.tt1.next;
{$endif}
if upstring(V_Recgen.Codice) <> upstring(Codice) then
  begin
  {$Ifdef Versione_14}
  dmtutti.T_Reti.append;
  dmtutti.T_Reti.edit;
  {$else}
  dm1.tt1.append;
  dm1.tt1.edit;
  {$endif}
  V_Recgen.Set_Codice(codice);
  V_Recgen.Set_Progetto(Descr);
  V_Recgen.set_V('S');
  V_Recgen.set_Xori(xorig);
  V_Recgen.set_yori(yorig);
  V_Recgen.set_zori(zorig);
  // Emanuela 5/4/2004
  V_Recgen.Set_dps(dps);
  V_Recgen.Set_maxvels(maxvels);
  V_Recgen.Set_dpe(dpe);
  V_Recgen.Set_maxvele(maxvele);
  V_Recgen.Set_Piano(Piano);
  V_Recgen.Set_Angolo(Angolo);
  V_Recgen.Set_Spec(Spec);
  V_Recgen.set_maxvelColl(maxvcol);
  {$Ifdef Versione_14}
  dmtutti.T_Reti.POst;
  {$else}
  dm1.tt1.POst;
  {$endif}
  risultcalc.Origine:=1;
  end;
end;

Procedure LeggiElencoRet1Txt;

begin
{$Ifdef Versione_14}
{$else}

dm1.tt1.first;
while not dm1.tt1.Eof do
begin
  V_Recgen.set_V('');
  dm1.tt1.next;
end;
{$endif}

{
Nomefile:=PercorsoDrive + '\rete.txt';
AssignFile(ff,Nomefile);
reset(ff);
while not eof(ff) do
begin
  readln(ff,Buf);
  AzzeraIdentif;
  Par:=LeggiIdentif1(buf);
  if upstring(par)='RETE' then
  begin
    Par:=LeggiIdentif1(buf);
    Par1:=LeggiIdentif1(buf);
    Cercarete(par,Par1,'','',0,0,0,0,0,0,0,0);
  end
end;
closeFile(ff);
dm1.tt1.first; }
end;


{************************************************************************}

Procedure LeggiReteTxt(Codice:string);
Var Finerete,iniziorete,ultimo,Nuovoarco:Boolean;
    i,j:integer;
    parCodtubo:string;
    err:Integer;
    tipodato:string;
{------------------}
Procedure settapadre(CodNodo:string;Tubo,Termin:Boolean);
Var NN,err,CDD:Integer;

begin
if (tubo)or(Termin) then
  begin
  if termin then dati^[Ulttronco].term:=UltGterm
  else
  dati^[Ulttronco].ti:=ultriga+1
  end
else
  begin
  CDD:=strtoint(codnodo);
  NN:=1;
  while (NN<Ulttronco)and(CDD<>dati^[NN]^.CodiceNodo) do
  inc(NN);
  With dati^[NN]^ do
  If CDD=CodiceNodo then
    begin
    if NPros < 6 then
       inc(Npros)
    else MessageDlg('Un nodo non può avere più di 6 uscite', mtInformation, [mbOK], 0);
    Pros[Npros]:=Ulttronco;
    end;
  end;
end;
{------------------}

Function ADDLinea(primo:boolean;CdTubo:string):Boolean;
function RD_Real(Var Vuoto:boolean):real;
Var PP:string;
    err:Integer;
begin
Par:=LeggiIdentif1(buf);
val(par,Result,err);
Vuoto:=(err<>0)or(par='');
end;

var vuoto:boolean;
begin
Vuoto:=false;
with Dis^[Ultriga+1]^ do
  begin
  if primo then
    begin
    x1:=RD_real(vuoto);
    y1:=RD_real(vuoto);
    z1:=RD_real(vuoto);
    end
  else
    begin
    x2:=RD_real(vuoto);
    y2:=RD_real(vuoto);
    z2:=RD_real(vuoto);
    NLinea:=0;
    entita:='L';
    tronco:=Ulttronco;
    val(CDTubo,Codicetubo,err);
    if not vuoto then
      begin
      if UltRiga < LungDis then
         inc(Ultriga);
      if dis^[ultriga+1]=nil then new(dis^[ultriga+1]);
      dis^[ultriga+1]^.x1:=dis^[ultriga].x2;
      dis^[ultriga+1]^.y1:=dis^[ultriga].y2;
      dis^[ultriga+1]^.z1:=dis^[ultriga].z2;
      if nuovoarco then Nuovoarco:=false
      else dis^[ultriga-1]^.NLinea:=ultriga;
      end;

    end
  end;
result:=vuoto;
end;
{------------------}

Procedure CaricaDatitubo(CodTubo:string);
Var i,j,err:Integer;
    cdd:integer;

begin
cdd:=strtoint(codtubo);
i:=1;
while (i< ultriga)and(cdd<>dis^[i]^.codicetubo) do inc(i);
if cdd=dis^[i]^.codicetubo then
With Dati^[dis^[i]^.tronco]^ do
  begin
  for j:=1 to 11 do
    begin
    readln(ff,Buf);
    AzzeraIdentif;
    tipodato:=Upstring(Leggiidentif1(Buf));
    if tipodato='TIPO' then Tipo:=leggiidentif1(Buf);
    if tipodato='LUNGHEZZA' then Val(leggiidentif1(Buf),Lungh,err);
    if tipodato='DIAMETRO' then Val(leggiidentif1(Buf),diam,err);
    if tipodato='PORTATA' then Val(leggiidentif1(Buf),POrt,err);
    if tipodato='PREVALENZA' then Val(leggiidentif1(Buf),Pr,err);
    if tipodato='PERDITE_PROGRESSIVE' then Val(leggiidentif1(Buf),Pp,err);
    if tipodato='PERDITE_DISTRIBUITE' then Val(leggiidentif1(Buf),Pd,err);
    //Gravimetriche:0:
    if tipodato='FISSO' then
      begin
      Val(leggiidentif1(Buf),CDD,err);
      if cdd=0 then swdiam:='' else swdiam:='*';
      end;
    //1:Curva_45:0:2:Curva_90:0:3:Curva_90+60:0:4:PezzoT:0:
    end;
   {
  Tipo:=leggiidentif1(Buf);
  Val(leggiidentif1(Buf),Lungh,err);
  Coddiam:='';
  SWDiam:='';
  POrt:=0;
  DH:=0;
   }
  end
else echo('Nodo :'+Codtubo+' non trovato.');
end;
{------------------}
Procedure SettaFiltro;

Procedure Itersetta(nn:integer;SettoreCor:string);
Var i:integer;
begin
with Dati^[NN]^ do
  begin
  i:=Ti;
  if Ti<>0 then
    repeat
    if dis^[i]^.settore<>'' then settorecor:=dis^[i]^.settore;
    dis^[i]^.filtro:=settorecor;
    i:=dis^[i].nlinea;
    until i=0;
  for i:=1 to Npros do Itersetta(Pros[i],SettoreCor);
  end;
end;
begin
Itersetta(RisultCalc^.Origine,V_recGen.Progetto);
end;
{------------------}
begin
{$Ifdef Versione_14}
{$else}
FMainTubi.ComboBox2.Items.Clear;
FMainTubi.ComboBox2.Items.Add(V_recgen.Progetto);
FMainTubi.ComboBox2.Text:=V_recgen.Progetto;
{$endif}
Nomefile := IncludeTrailingPathDelimiter(PercorsoDrive) + 'rete.txt';
AssignFile(ff,Nomefile);
try
  reset(ff);
  finerete:=false;
  Iniziorete:=false;
  UltRiga:=0;
  UltTronco:=0;
  UltGterm:=0;
  if dis^[ultriga+1]=nil then new(dis^[ultriga+1]);

  while (not eof(ff))and (not Finerete) do
    begin
    readln(ff,Buf);
    AzzeraIdentif;
    Par:=LeggiIdentif1(buf);
    if upstring(par)='RETE' then
      begin
      if iniziorete then
      finerete:=true
      else
        begin
        Par:=LeggiIdentif1(buf);
        if upstring(par)=upstring(codice) then
        iniziorete:=true;
        end;
      end
    else
      begin
      if iniziorete then
        begin
        If par='TUBO' then
          begin
          nuovoarco:=true;
          //Par:=LeggiIdentif1(buf);  //Tubo rimando
          //else
          dis^[Ultriga+1].Settore:='';
          ParCodtubo:=LeggiIdentif1(buf);
          SettaPadre(ParCodtubo,true,false);
          addlinea(true,ParCodtubo);
          repeat
          ultimo:=addlinea(false,ParCodtubo)
          until ultimo;
          end;
        If (par='RADICE')or(par='NODO')  then
          begin
          If (par='RADICE') then risultCalc^.origine:=1;
          if UltTronco < LungDati then
             inc(Ulttronco);
          if dati^[ulttronco]=Nil then new(dati^[ulttronco]);
          with dati^[ulttronco]^ do
            begin
            Codicenodo:=strtoint(LeggiIdentif1(buf));
            If (par='NODO') then settapadre(LeggiIdentif1(buf),false,false);
            Npros:=0;
            term:=0;
            for i:=1 to 10 do pros[i]:=0;
            for i:=1 to MaxPConc do
              begin
              pconc[i].cod:='';
              pconc[i].n:=0;
              end;
            LeggiIdentif1(Parx);
            LeggiIdentif1(Pary);
            LeggiIdentif1(Parz);
            end;
          end;
        If (par='DATI') then
          begin
          Par:=LeggiIdentif1(buf); // Tubo o rimando
          if Par<>'T' then
            begin
            //dis^[Ultriga+1].Settore:=par;
            //FMainTubi.ComboBox2.Items.Add(par);
            end;
          CaricaDatitubo(LeggiIdentif1(buf));
          end;
        If (par='TERMINALI') then
          begin
          if UltGTerm < MaxGTerm then
             inc(UltGterm);
          if Gterm^[ultGterm]=Nil then new(Gterm^[ultGterm]);
          if Fgtb^[ultGterm]=Nil then new(Fgtb^[ultGterm]);
          Fgtb^[ultGterm].IndM:=Ultgterm;
          with Gterm^[ultGterm]^ do
            begin
            CodiceTerminale:=strtoint(LeggiIdentif1(buf));
            Taratura:='';
            NumTer:=0;
            settapadre(Inttostr(codiceterminale),false,true);

            for j:=1 to 9 do
              begin
              readln(ff,Buf);
              AzzeraIdentif;
              tipodato:=Upstring(Leggiidentif1(Buf));
              if tipodato='PORTATA' then Val(leggiidentif1(Buf),port,err);
              if port=0 then port:=0.1;// da togliere;
              if tipodato='PERDITECARICO' then Val(leggiidentif1(Buf),perd,err);
              end
            (*
            val(LeggiIdentif1(buf),POrt,err);
            val(LeggiIdentif1(buf),Perd,err);
            //LeggiIdentif1(Parx);
            //LeggiIdentif1(Pary);
            //LeggiIdentif1(Parz);

            Disegno:Radiatore:
            Tipo:ARGO:
            Serie:POKER:
            Modello:3-835:
            Elementi:6:
            Portata:50:
            PerditeCarico:8,74235326478002E-318:
            Prevalenza:0:
            Regolazione:0:
            *)
            end;
          end;
        end;
      end;
    end;
  closeFile(ff);
except
  closeFile(ff);
end;
SettaFiltro;
end;
{************************************************************************}
Procedure OutTxt;
Var Buf:String;
    FF:TextFile;
    j:integer;
Procedure IterOutTxt(NN,Padre:integer);
Var i:integer;
    stt:string;
begin
with dati^[NN]^ do
  begin
  If Padre=0 then
    begin
    writeln(ff,'RETE:'+V_RecGen.Codice+':'+V_RecGen.Progetto+':');
    writeln(ff,'RADICE:'+IntTostr(Codicenodo)+':0:0:0:')
    end
  else
  writeln(ff,'NODO:'+IntTostr(Codicenodo)+':'+IntTostr(Padre)+':0:0:0:');
  i:=ti;
  Stt:='T';
  if dis^[i]^.Settore<>'' then stt:=dis^[i]^.Settore;
  with dis^[i]^ do
  Buf:='TUBO:'+stt+':'+inttostr(codicetubo)+':'+Float_tostr(x1)+':'+Float_tostr(y1)+':'+Float_tostr(z1)+':'+
           Float_tostr(x2)+':'+Float_tostr(y2)+':'+Float_tostr(z2)+':';
  while dis^[i]^.Nlinea<>0 do
    begin
    i:=dis^[i]^.Nlinea;
    with dis^[i]^ do
    buf:=buf+Float_tostr(x2)+':'+Float_tostr(y2)+':'+Float_tostr(z2)+':'
    end;
  writeln(ff,Buf);
  for i:= 1 to Npros do IterOutTxt(Pros[i],NN);
  end;
end;
begin
  AssignFile(ff, IncludeTrailingPathDelimiter(PercorsoDrive) + 'reteout.txt');
  try
    Rewrite(ff);
    IterOutTxt(risultCalc^.Origine,0);
    for j:=1 to UltTronco do
    with Dati^[j]^ do
    writeln(FF,'DATI:T:'+inttostr(codiceNodo)+':'+Tipo+':'+Float_tostr(Lungh)+':'+codDiam+':');
    Closefile(FF);
  except
    Closefile(FF);
  end;
end;


end.
