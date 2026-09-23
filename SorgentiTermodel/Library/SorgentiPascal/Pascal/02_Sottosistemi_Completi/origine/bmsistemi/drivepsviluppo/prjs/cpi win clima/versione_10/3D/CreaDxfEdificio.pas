unit CreaDXFEdificio;

interface
Uses  Varcarichi,dxf_in_out,UDataoutT,udbt,copialetturadisegno3d,grafica2d,UvariabiliLettura,
      UDataLink,sysutils,libreriagenerale,definiz,impterm,config_var,
      {$Ifdef tubi_14}
      Funz_reti,gestdim,angoli
      {$Else}
      Interf3D_reti
      {$endif};
Procedure AzzeraDXF;
Procedure DxfEdificio(piano:string);
Procedure Dxfrete(rete,piano:string);
Procedure DXF_origine(Nomepiano,Layer:string;sfondo:boolean);
Procedure Dxf_rete(rete,piano:string;layerseparati:boolean);
Procedure Aggiorna_Potenze;
implementation
uses init_cad3d;
const alttabcolori=1.0267;
      Largtabcolori=5.0016;
type reclim=record
            MaxX_X,Maxy_y,minX_X,MinY_Y:Real;
            set_lim:boolean;
            end;

Procedure Nuovaent;
begin
if NEntita < MaxEntita then
   begin
   inc(Nentita);
   if entita_d^[Nentita]=nil  then new(entita_d^[Nentita]);
   end;
end;
Procedure AzzeraDXF;
begin
Nentita:=0;
end;


Function colore_CAD(ind:integer):string;
begin
case ind of
1:Result:='Rosso';
2:Result:='Giallo';
3:Result:='Verde';
4:Result:='Ciano';
5:Result:='Blu';
6:Result:='Magenta';
7:Result:='Bianco';
else result:='Colore '+inttostr(ind);
end;
end;
 {
Function indcolore(nomecolore:string):integer;
begin
nomecolore:=Lowercase(nomecolore);
if copy(nomecolore,1,6)='colore' then
result:=strtoint(copy(nomecolore,8,length(nomecolore)-7))
else
if nomecolore='rosso' then result:=1  else
if nomecolore='giallo' then result:=2  else
if nomecolore='verde' then result:=3  else
if nomecolore='ciano' then result:=4  else
if nomecolore='blu' then result:=5  else
if nomecolore='magenta' then result:=6  else
if nomecolore='bianco' then result:=7
else result:=0;
end;

 }
function colorepareteCAD(cod:string):String;
var i:integer;
    indcol:integer;
begin
if uppercase(cod)='FITTIZIA' then
  begin
  result:='1';
  exit;
  end;
if cod='' then
  begin
  result:='';
  exit;
  end;
if cod[1]='?' then
  begin
  result:=copy(cod,2,length(cod)-1);
  exit
  end;
result:='0';
if nstrutture>0 then
  begin
  i:=1;
  cod:=uppercase(cod);
  while (i<Nstrutture)and(uppercase(strutture_D^[i].nfile)<>cod)do inc(i);
  if uppercase(strutture_D^[i].nfile)=cod then result:=inttostr(indcolore(strutture_D^[i].colcad));
  end;
end;

function coloretuboCAD(cod:string):String;
var i:integer;
    indcol:integer;
begin
if cod='FITTIZIA' then
  begin
  result:=cod;
  exit;
  end;
if cod='' then
  begin
  result:='';
  exit;
  end;
if cod[1]='?' then
  begin
  result:=copy(cod,2,length(cod)-1);
  exit
  end;
result:='0';
i:=1;
cod:=uppercase(cod);
while (i<NTipirete)and(uppercase(Tipirete_D^[i].cod)<>cod)do inc(i);
if uppercase(Tipirete_D^[i].cod)=cod then result:=inttostr(indcolore(Tipirete_D^[i].Colore));
end;

function TlineapareteCAD(cod:string):String;
var i:integer;
    indcol:integer;
begin
cod:=uppercase(cod);
result:='';
if cod='' then exit;
i:=1;
cod:=uppercase(cod);
while (i<Nconfini)and(uppercase(Confine_D^[i].Codice)<>cod)do inc(i);
if uppercase(Confine_D^[i].Codice)=cod then result:=Confine_D^[i].TLinea;
end;


Procedure Azzeralim(var rl:reclim);
begin
with rl do
  begin
  MaxX_X:=-10E6;
  Maxy_y:=-10E6;
  minX_X:=10E6;
  MinY_Y:=10E6;
  set_lim:=false;
  end;
end;

Procedure Verlim(var rl:reclim;xx,yy:real);
begin
with rl do
  begin
  if xx> MaxX_X then
    begin
    MaxX_X:=xx;
    set_lim:=true;
    end;
  if yy> MaxY_Y then
    begin
    MaxY_Y:=YY;
    set_lim:=true;
    end;
  if xx< MinX_X then
    begin
    MinX_X:=xx;
    set_lim:=true;
    end;
  if yy< MinY_Y then
    begin
    MinY_Y:=yy;
    set_lim:=true;
    end;
  end;
end;

Function Cercaamb_mem(Indamb:string):integer;
var i:integer;
begin
result:=0;
i:=1;
while (i<Nambienti)and(ambienti_D^[i]^.CodNum<>Indamb)do inc(i);
if (Nambienti<>0)and (ambienti_D^[i]^.CodNum=Indamb) then result:=i;
end;

Procedure Ver_lim2P(var rl:reclim;xx,yy,xx1,yy1:real);
begin
Verlim(rl,xx,yy);
Verlim(rl,xx1,yy1);
end;

Procedure DXF_origine(Nomepiano,Layer:string;sfondo:boolean);
begin
i:=1;
PiantaEsterna:='';

while (i< Npiani) and  (Piani_D^[i].Cod<>V_recconfcad.PIANOCOR)do Inc(i);
if Piani_D^[i].Rif_Pianta<>'' then
  begin
  {$IfNdef dllbm}
  PiantaEsterna:='';
  if sfondo then PiantaEsterna:=perc_progcor+Piani_D^[i].Rif_Pianta;
  scalapiantaesterna:=Piani_D^[i].ScalaP;
  Add_BloccoDxf_col(-Piani_D^[i].AllineaX,-Piani_D^[i].AllineaY,0,0,'RIFEST','0','1');
  {$endif}
  // ripetuto
  {$Ifdef AcadVba}
  PiantaEsterna:='';
  if sfondo then PiantaEsterna:=perc_progcor+Piani_D^[i].Rif_Pianta;
  scalapiantaesterna:=Piani_D^[i].ScalaP;
  Add_BloccoDxf_col(-Piani_D^[i].AllineaX,-Piani_D^[i].AllineaY,0,0,'RIFEST','0','1');
  {$endif}

  end;

//if (Piani_D^[i].AllineaX<>0)or(Piani_D^[i].AllineaY<>0) then
Add_BloccoDxf(0,0,0,0,'ALLINEA',layer);
//Add_BloccoDxf(Piani_D^[i].AllineaX,Piani_D^[i].AllineaY,0,0,'ALLINEA',layer);//emergenza
end;

Procedure Aggiorna_Potenze;
type TIntPot = record
              NumAmb: Integer;
              NomeLoc, Piano, CodGen: String[30];
              Pot, Port, DispInf, Vol, Sup, TInv: Double;
            end;

type TintPOtE = record
                      NumAmb: integer;
                      POtE:   real;
                    end;
Var  BufIntPOt: TintPOt;
     FIntPOt: File of Tintpot;
Var
  BufIntPOtE:TintPOtE;
  FIntPOtE:file of TintpotE;
  fpottxt:Textfile;
Var ind_amb:integer;
begin
//Leggi_Locali(dmtutti.T_Locali,dmtutti.T_Pareti,dmtutti.ds_Locali);
if fileexists(IncludeTrailingPathDelimiter(percorsoDrive) + 'potinv.int') then
  begin
  assign(fpottxt, IncludeTrailingPathDelimiter(percorsoDrive) + 'potinv.txt');
  rewrite(fpottxt);
  assign(fintpot, IncludeTrailingPathDelimiter(percorsoDrive) + 'potinv.int');
  reset(fintpot);
  while not eof(fintpot) do
    begin
    read(fintpot,bufintpot);
    with bufintpot do
      begin
      write(fpottxt,'Amb:',inttostr(numamb),' Pot:',Float_to_str(pot,0));
      writeln(fpottxt,'');
      ind_amb:=cercaamb_mem(inttostr(numamb));
      if ind_amb<>0 then
      with ambienti_d^[ind_amb]^ do
         begin
         PINV:=Pot;
         end;
      end;
    end;
  close(fpottxt);
  close(fintpot);
  end;
if fileexists(IncludeTrailingPathDelimiter(percorsoDrive) + 'potest.int') then
  begin
  try
  assign(fpottxt, IncludeTrailingPathDelimiter(percorsoDrive) + 'potest.txt');
  rewrite(fpottxt);
  assign(fintpotE, IncludeTrailingPathDelimiter(percorsoDrive) + 'potest.int');
  reset(fintpotE);
  while not eof(fintpotE) do
    begin
    read(fintpotE,bufintpotE);
    with bufintpotE do
      begin
      write(fpottxt,'Amb:',inttostr(numamb),' Pot:',Float_to_str(POtE,0));
      ind_amb:=cercaamb_mem(inttostr(numamb));
      if ind_amb<>0 then
      with ambienti_d^[ind_amb]^ do
         begin
         Pestsens:=POtE;
         pestlat:=0;
         end;
      end;
    end;
  close(fintpotE);
  close(fpottxt);
  except
  end;
  end;
//Salva_Locali(dmtutti.T_Locali,dmtutti.T_Pareti,dmtutti.ds_Locali);
end;
Procedure DXF_piano(Nomepiano:string;LayerSeparati,Tabellacolori:Boolean;sfondo:boolean);
Var NomeLayer,Tipolinea,colorecor,nomebb:string;
    i,j,k,Ind_amb:integer;
    rl:reclim;
    YProg:Real;
    desct:string;
begin
AzzeraLim(rl);
if layerseparati then Nomelayer:='E_'+Nomepiano else Nomelayer:='EDIFICIO';
if sfondo then Nomelayer:='Piani adiacenti';
  //Apripiano(true,V_recconfcad.PIANOCOR);
  Apripiano(true,nomepiano);
  for j:=1 to grafica2d.ultimafrontiera do
  with Uvariabililettura.Ft^[j] do
    begin
    ver_lim2p(rl,x0/100,y0/100,x1/100,y1/100);
    tipolinea:='1';
    azzeraidentif;
    tipolinea:=leggiidentif1(Uvariabililettura.Ft^[j].tlinea);// htot
    tipolinea:=leggiidentif1(Uvariabililettura.Ft^[j].tlinea);// h2
    tipolinea:=leggiidentif1(Uvariabililettura.Ft^[j].tlinea);// confine
    tipolinea:=TlineapareteCAD(tipolinea);
    if tipolinea='' then tipolinea:='1'
    else  tipolinea:='Conf'+tipolinea;
    if uppercase(colore)='FITTIZIA' then tipolinea:='FITTIZIA';
    Colorecor:=colorepareteCAD(colore);
    if sfondo then
      begin
      tipolinea:='FITTIZIA';
      colorecor:='254';
      end;
    Add_LineaDxf(x0/100,y0/100,0,x1/100,y1/100,0,{'P'+inttostr(indice)}NomeLayer,colorecor,tipolinea);
    end;
  if not sfondo then
  if (not Layerseparati) then
  if (errorex<>0)and (errorey<>0)and(erroreneldisegno<>letturacorretta) then
    begin
    {$IfNDef dllbm}
    Add_LineaDxf(errorex/100,errorey/100,0,0,0,0,{'P'+inttostr(indice)}'ERRORI','1','Conf1');
    {$endif}
    {$IfDef AcadVba}
    Add_LineaDxf(errorex/100,errorey/100,0,0,0,0,{'P'+inttostr(indice)}'ERRORI','1','Conf1');
    {$endif}
    end;
  if not sfondo then
  for j:=1 to grafica2d.ultblocco do
  with Bll^[j] do
    begin
    if uppercase(nome)='AMB' then
      begin
      ind_amb:=cercaamb_mem(attrib1[1]);
      if (ind_amb<>0)and(ambienti_d^[ind_amb]^.TipoCalcTempNR<>'') then
      Add_BloccoDxf_col(X/100,Y/100,0,0,'LOCNR',NomeLayer,'1')
      else Add_BloccoDxf_col(X/100,Y/100,0,0,'LOC',NomeLayer,'1');

      Add_Attrib_Dxf('COD',attrib1[1]);
      azzeraidentif;
      Add_Attrib_Dxf('TPAV',leggiidentif1(attrib1[5]));
      Add_Attrib_Dxf('CPAV',leggiidentif1(attrib1[5]));
      azzeraidentif;
      Add_Attrib_Dxf('TSOF',leggiidentif1(attrib1[6]));
      Add_Attrib_Dxf('CSOF',leggiidentif1(attrib1[6]));
      azzeraidentif;
      Add_Attrib_Dxf('ZONA',leggiidentif1(attrib1[4]));
      Add_Attrib_Dxf('IMPIANTO',leggiidentif1(attrib1[4]));
      desct:='';
      for k:=1 to length(attrib1[2]) do
      if attrib1[2][k]='§' then desct:=desct+':' else desct:=desct+attrib1[2][k];
      Add_Attrib_Dxf('DESCR.',desct);

      if ind_amb<>0 then
      with ambienti_d^[ind_amb]^ do
        begin
        if TipoCalcTempNR<>'' then
          begin
          Add_Attrib_Dxf('TINV',float_to_str(TNInv,2));
          Add_Attrib_Dxf('TEST',float_to_str(TNest,2));
          Add_Attrib_Dxf('RICARIA',float_to_str(RICARIA,2));
          Add_Attrib_Dxf('APPGRA',float_to_str(CaricoInt,0));
          Add_Attrib_Dxf('FCONV',float_to_str(ValBxLNR,3));
          Add_Attrib_Dxf('ALT',float_to_str(HSoffitto,3));
          Add_Attrib_Dxf('TIPOBXSCELTO',TIPOBXSCELTO);
          Add_Attrib_Dxf('CALCOLOT',TipoCalcTempNR);
          end
        else
          begin
          Add_Attrib_Dxf('PINV',float_to_str(PINV,0));
          Add_Attrib_Dxf('PEST',float_to_str(Pestsens+pestlat,0));
          end
        end
      else
        begin
        Add_Attrib_Dxf('PINV','');
        Add_Attrib_Dxf('PEST','');
        end;
      end;
    if uppercase(nome)='FIN' then
      begin
      Nomebb:='FIN';
      if attrib1[5]='1' then nomebb:='FINLUCUP';
      if attrib1[5]='2' then nomebb:='FINLUCDWN';
      Add_BloccoDxf_col(X/100,Y/100,0,angolo,Nomebb,NomeLayer,'1');
      Add_Attrib_Dxf('LARGHEZZA',attrib1[3]);
      Add_Attrib_Dxf('ALTEZZA',attrib1[4]);
      Add_Attrib_Dxf('TIPO',attrib1[1]);
      end;
    if uppercase(nome)='PON' then
      begin
      Add_BloccoDxf_col(X/100,Y/100,0,0,'PON',NomeLayer,'1');
      Add_Attrib_Dxf('LUNG',attrib1[2]);
      Add_Attrib_Dxf('TIPO',attrib1[1]);
      end;
    end;
if not sfondo then
if tabellacolori then
  begin
  YProg:=0;
  Leggi_Strutture(dmtutti.T_Strutture,dmtutti.T_strati,dmtutti.ds_strutture);
  for i:=1 to NStrutture do
  with strutture_D^[i]^ do
    begin
    Add_BloccoDxf_col(-1-Largtabcolori+rl.MinX_X,yprog-1+rl.MinY_Y,0,0,'TABCOLORI','P1','1');
    Add_Attrib_Dxf('CODP',Nfile);
    Add_Attrib_Dxf('DESCP',Descr);
    Add_Attrib_Dxf('NOMECOLP',ColCad);
    YProg:=YProg+alttabcolori;
    end;
  end;
end;
Procedure DxfEdificio(piano:string);
Var i,J,indsup,indinf,indpiano:Integer;
    buf:string;
begin
//InitSimbDXF;
//Nentita:=0;
Leggi_Strutture(dmtutti.T_Strutture,dmtutti.T_strati,dmtutti.ds_Strutture);
Leggi_Piani(dmtutti.T_Piani,dmtutti.T_PPiano,dmtutti.ds_Piani);
Leggi_Locali(dmtutti.T_Locali,dmtutti.T_Pareti,dmtutti.ds_Locali);
Leggi_Impianti(dmtutti.T_Impianti,dmtutti.T_Impianti,dmtutti.ds_Impianti);
//Aggiorna_Potenze;//attivato in attesa che non vengano spianati i dati ambiente
if piano='' then
  begin
  For i:=1 to Npiani do
  if piani_D^[i].CopiaDi='' then
  DXF_piano(Piani_D^[i].Cod,true,false,false);
  end
else
  begin
  //dxf_origine(V_recconfcad.PIANOCOR);

 // come sfondo i piani adiacenti
  i:=1;
  while (i<Npiani)and(uppercase(Piani_D^[i].Cod)<>uppercase(piano)) do inc(i);
  indinf:=i-1;
  indsup:=i+1;
  Indpiano:=i;
  if indsup<Npiani then
  while (indsup<Npiani)and(Piani_D^[indsup].CopiaDi<>'') do inc(indsup);
  if indinf>1 then
  while (indinf>1)and(Piani_D^[indinf].CopiaDi<>'') do dec(indinf);

  if (indinf>0)and(uppercase(Piani_D^[indPiano].Sfondo_Pinf)='SI') then
  DXF_piano(Piani_D^[indinf].Cod,false,false,true);
  if (indsup<=Npiani)and(uppercase(Piani_D^[indPiano].Sfondo_Psup)='SI') then
  DXF_piano(Piani_D^[indsup].Cod,false,false,true);

  DXF_piano(V_recconfcad.PIANOCOR,false,false,false);
  end;
end;
Function IndPiano(Nomep:string):string;
Var count:integer;
begin
nomep:=uppercase(nomep);
result:='1';
with dmtutti.T_Piani do
  begin
  count:=1;
  first;
  while (not (eof))and(uppercase(V_recpia.Cod)<>nomep) do
    begin
    next;
    inc(count);
    end;
  end;
result:=inttostr(count);
end;
Function IndRete(NomeR:string):string;
Var count:integer;
begin
nomer:=uppercase(nomer);
result:='1';
with dmtutti.T_reti do
  begin
  count:=1;
  first;
  while (not (eof))and(uppercase(V_recgen.Codice)<>nomer) do
    begin
    next;
    inc(count);
    end;
  end;
result:=inttostr(count);
end;


Procedure Dxf_rete(rete,piano:string;layerseparati:boolean);
Var i,j,k,l,volte,fineb,indlinea,numcirc,numambterm,indgterm:Integer;
    nomelayer,ss,ss2,passo,diamArrivo,diamPartenza,piano_elaborato:string;
    pe_x,dir,dirz,xtemp,Ytemp:real;

Function I_T(ind:integer):integer;
Var i,j:integer;
begin
result:=ind; //disattivato i terminali sono solo quelli del piano ??
exit;

piano:=uppercase(piano);
result:=0;
if ngterm=0 then exit;
i:=1;
while (i<Ngterm)and(uppercase(Gterm^[i]^.Piano)<>Piano)do inc(i);
if (i+ind-1<=ngterm)and(uppercase(Gterm^[i+ind-1]^.Piano)=Piano) then
result:=i+ind-1
else result:=0;
end;

Function tipolineatubo(ind:integer):string;
begin
if dis_I^[ind]^.CL then result:='COLLETTORE'
else result:='1';
end;
var num_diam:boolean;
begin
Piano_elaborato:=uppercase(piano);
num_diam:=Uppercase(leggi_var('num_diam'))='TRUE';
if layerseparati then Nomelayer:='R_'+IndRete(rete)+'_E_'+Indpiano(piano) else Nomelayer:='RETE';
if layerseparati then volte:=1 else volte:=2;
volte:=1;

dmtutti.T_reti.First;
while not  (dmtutti.T_Reti.eof)and  (uppercase(V_recgen.Codice)<>uppercase(rete))do
dmtutti.T_reti.next;

if ((V_recgen.Xori<>0)or(V_recgen.Yori<>0))and(uppercase(V_recgen.Piano)=uppercase(piano)) then
Add_BloccoDxf_col(V_recgen.Xori,V_recgen.Yori,0,V_recgen.angolo,'IRETED',NomeLayer,'1');

for k:=1 to volte do
  begin
  if k=2 then
    begin
    nomelayer:='ESECUTIVO_RETE';
    //disrit3d(Piano);
    end;
  if k= 1 then
  for i:=1 to ultriga_I do
  with dis_I^[i]^ do
    begin
    { TODO -oDiego -cReti : Etichetta rimando ripresa (inserimento nel DXF ) }
    if rimando<>'' then
      begin
      Diamarrivo:='';
      DiamPartenza:='';
      if tronco<>0 then
        begin
        end;
      if rimando[1]='A' then
        begin
        if tronco<>0 then
        Diamarrivo:='D '+dati^[tronco]^.Coddiam;
        ss:='RIMRETE';
        ss2:=etic_rim;
        end
      else
        begin
        if tronco<>0 then
          begin
          Diamarrivo:='D '+dati^[tronco]^.Coddiam;
          for l:=1 to 6 do
          if dati^[tronco]^.pros[l]<>0 then
          if dis^[dati^[dati^[tronco]^.pros[l]]^.ti].rimando<>'' then
          DiamPartenza:='Continua D '+dati^[dati^[tronco]^.pros[l]]^.coddiam;
          end;

        ss:='RIPRETE';
        ss2:=etic_rip;
        end;
      if rimando[3]='D' then
      ss:=ss+'D'
      else ss:=ss+'S';
      if (x_lab=0)and(y_lab=0) then
        begin
        x_lab:=x1+1;
        Y_lab:=y1;
        end;
      Add_BloccoDxf_col(X1,Y1,0,angolo,ss+'L',NomeLayer,'3');
      Add_Attrib_Dxf('CODICE',copy(rimando,5,length(rimando)-4));
      Add_BloccoDxf_col(X_lab,Y_lab,0,0,'ETICHETTA',NomeLayer,'3');
      Add_Attrib_Dxf('LINK','0');
      Add_Attrib_Dxf('RIF',ss2);
      //QOUT diametro in uscita
      Add_Attrib_Dxf('POTENZA',copy(rimando,5,length(rimando)-4));
      Add_Attrib_Dxf('MODELLO',diamarrivo);
      Add_Attrib_Dxf('DOUT',diampartenza);
      Add_LineaDxf(x1,y1,0,x_lab,y_lab,0,NomeLayer,'0'{colorepareteCAD(colore)},'QUOTE');
      end
    else
    if not dis_esecutivo then
      begin
      if tipo='FITTIZIA' then
      Add_LineaDxf(x1,y1,0,x2,y2,0,{'P'+inttostr(indice)}NomeLayer,'1','FITTIZIA')
      else Add_LineaDxf(x1,y1,0,x2,y2,0,{'P'+inttostr(indice)}NomeLayer,coloretuboCAD(tipo),tipolineatubo(i));
      end;
    end;

  if dis_esecutivo then  Dxf_esecutivo(rete,piano);

  for i:=1 to NGTerm_I do
  with Gterm_I^[i]^ do
    begin
    fineb:=pos('§',nomeblocco);
    if fineb=0 then fineb:=pos('_',nomeblocco);
    if fineb<>0 then
    nomeblocco:=copy(nomeblocco,1,fineb-1);
    //nomeblocco:='TermPannelloD';
    Add_BloccoDxf_col(XTerm,YTerm,0,angolo,NomeBlocco,NomeLayer,'3');
    Add_Attrib_Dxf('COD',inttostr(i));
    Add_Attrib_Dxf('MODELLO',MODELLO);
    if fissamodello then Add_Attrib_Dxf('FISSAMODELLO','SI')
    else Add_Attrib_Dxf('FISSAMODELLO','NO');
    Add_Attrib_Dxf('SERIE',SERIE);
    if fissaSERIE then Add_Attrib_Dxf('FISSASERIE','SI')
    else Add_Attrib_Dxf('FISSASERIE','NO');
    Add_Attrib_Dxf('PORT',float_to_str(PORTInp,2));
    Add_Attrib_Dxf('PERDITA',float_to_str(PERDInp,2));
    Add_Attrib_Dxf('LMAX',float_to_str(LarghezzaMax,2));
    Add_Attrib_Dxf('INCR',float_to_str(IncrPotenza,2));
    Add_Attrib_Dxf('POTENZA',float_to_str(PotInp,2));
    Add_Attrib_Dxf('MONTAGGIO',MONTAGGIO);
    {
    if coda='PORT' then port:=valnum(valore);
    if coda='PERDITA' then perdita:=valnum(valore);
    if coda='COD' then Codice:=valnum(valore);
    if coda='LMAX' then LargMax:=valnum(valore);
    if coda='INCR' then Incr:=valnum(valore);
    if coda='MODELLO' then modello:=valnum(valore);
    if coda='SERIE' then serie:=valnum(valore);
    if coda='FISSAMODELLO' then Fissamodello:=valnum(valore);
    if coda='FISSASERIE' then Fissaserie:=valnum(valore);
    if coda='POTENZA' then
    begin
    POTEST:=valnum(valore);
    PotenzaI:=valnum(valore);
    end;

    if coda='MONTAGGIO' then codmont:=valore;
    }
    if (xetic=0)and(Yetic=0) then
      begin
      Yetic:=YTerm+0.5;
      Xetic:=xTerm+0.2;
      if ((round(GTerm_I^[i]^.angolo)>180)and(round(GTerm_I^[i]^.angolo)<=270))or(round(GTerm_I^[i]^.angolo)<=90)then
      Xetic:=xTerm-1.7;
      end;
    //if (dis_esecutivo)or(layerseparati) then
      begin
      if pos('PAN',uppercase(Nomeblocco))<>0 then  //Provvisorio pannelli
      Add_BloccoDxf_col(Xetic,Yetic,0,0,'ETICHETTAPAN',NomeLayer,'3')
      else Add_BloccoDxf_col(Xetic,Yetic,0,0,'ETICHETTA',NomeLayer,'3');

      Add_Attrib_Dxf('LINK',inttostr(i));
      indgterm:=0;
      if ngterm<>0 then
      for indgterm:=1 to ngterm do
      if (uppercase(Gterm^[indgterm]^.Piano)=Piano_elaborato)and(strtoint(Gterm^[indgterm]^.CodentDxf)=i) then break;
      if ngterm<>0 then
      if (uppercase(Gterm^[indgterm]^.Piano)<>Piano_elaborato)or(strtoint(Gterm^[indgterm]^.CodentDxf)<>i) then indgterm:=0;

      if pos('PAN',uppercase(Nomeblocco))<>0 then //Provvisorio pannelli
        Begin
        if indgterm<>0 then
            begin
            Add_Attrib_Dxf('MODELLO',float_to_str(GTerm^[indgterm].Larghezza,0)+' m');
            passo:=float_to_str(GTerm^[indgterm].profondita,0);
            if altezza<>0 then passo:=passo+'\'+float_to_str(GTerm^[indgterm].altezza,0);
            Add_Attrib_Dxf('POTENZA','P '+passo);
            //numcirc:=Cercapuntoloc_D(GTerm^[indgterm].xterm,GTerm^[indgterm].yterm,Piano_elaborato);
            //numambterm:=Cercapuntoloc(GTerm^[indgterm].xterm,GTerm^[indgterm].yterm,Piano_elaborato); //Locale di appartenenza
            //numambterm:=( numambterm div 1000 )*1000+Numcirc;
            Add_Attrib_Dxf('NLOC','N°:'+GTerm^[indgterm]^.cod);    
            //altrimenti visualizza gli aggregati
            //Add_Attrib_Dxf('NLOC',inttostr(GTerm^[i]^.numamb));
            Add_Attrib_Dxf('TARATURA','Reg:'+GTerm^[indgterm].Taratura)
            //Add_Attrib_Dxf('TARATURA','')
            end;
        End
      else
      if indgterm<>0 then
        begin
        ss:=Gterm^[indgterm]^.modello;
        if Gterm^[i]^.NumElementi<>0 then ss:=ss+'-'+inttostr(Gterm^[indgterm]^.NumElementi)+'E';
        Add_Attrib_Dxf('MODELLO',ss);
        ss:=float_to_str(Gterm^[indgterm]^.pot,0)+ ' W';
        Add_Attrib_Dxf('POTENZA',ss);
        end;

      end;
    end;
(*
for i:=1 to ulttronco do
with dati^[i]^ do
  begin
  if (xbase=0)and(Ybase=0) then
    begin
    j:=ti;
    while dis^[j].nlinea<>0 do j:=dis^[j].nlinea;
    xbase:=(dis^[j]^.x1+dis^[j]^.x2)/2;
    ybase:=(dis^[j]^.y1+dis^[j]^.y2)/2;
    x:=xbase+0.1;
    y:=ybase+0.1;
    end;
  Add_BloccoDxf_col(X,Y,0,0,'QUOTA',NomeLayer,'3');
  Add_Attrib_Dxf('DIAM',coddiam);
  Add_LineaDxf(xbase,ybase,0,x,y,0,NomeLayer,'0'{colorepareteCAD(colore)},'QUOTE');
  end;
 *)
// if (dis_esecutivo)or(layerseparati) then
  for i:=1 to nquote do
  with quote^[i] do
    begin
    calc_D(x2,y2,0,x1,y1,0,dir,dirz);
    if (dir >pi)and (dir<2*PI) then
      begin
      Add_BloccoDxf_col(X1,Y1,0,0,'QUOTAD',NomeLayer,'3');
      if num_diam then
      Add_Attrib_Dxf('&DIAM',quota2)
      else Add_Attrib_Dxf('&DIAM',quota1);

      Add_Attrib_Dxf('&CODTR',{quota2}'');
      end
    else
      begin
      Add_BloccoDxf_col(X1,Y1,0,0,'QUOTA',NomeLayer,'3');
      if num_diam then
      Add_Attrib_Dxf('CODTR',quota2);
      Add_Attrib_Dxf('DIAM',quota1);
      end;
    Add_LineaDxf(x1,y1,0,x2,y2,0,NomeLayer,'0'{colorepareteCAD(colore)},'QUOTE');
    end;
  end;
end;
Procedure Dxfrete(rete,piano:string);
Var layerseparati:boolean;
    i,j,k:integer;
    pianoc:string;
begin
Leggi_Piani(dmtutti.T_Piani,dmtutti.T_PPiano,dmtutti.ds_Piani);
Leggi_reti(dmtutti.T_reti,dmtutti.T_reti,dmtutti.ds_reti);
layerseparati:=false;
if rete='' then
  begin
  layerseparati:=true;
  for i:=1 to NGen do
  for j:=1 to npiani do
    begin
    Caricadistubi(GENERALITA_D1^[i].codice,Piani_D^[j].Cod,true);
    Dxf_rete(GENERALITA_D1^[i].codice,Piani_D^[j].Cod,layerseparati);
    end;
  Caricadistubi(V_recconfcad.ColoreTipoReteIRR,V_recconfcad.PIANOCOR,true);
  end
else
  begin
  pianoc:=uppercase(V_recconfcad.PIANOCOR);
  k:=1;while (k<Npiani)and(uppercase(piani_D^[k].Cod)<>Pianoc) do inc(k);
  Dxf_rete(rete,piano,layerseparati);
  if not fileexists(perc_work+'Edificio_'+pianoc+'.dxf') then
  for j:=1 to grafica2d.ultimafrontiera do
  with Uvariabililettura.Ft^[j] do
  if (uppercase(colore)='FITTIZIA')or(piani_D^[k].Rif_Pianta='') then
  if (uppercase(colore)='FITTIZIA') then
  Add_LineaDxf(x0/100,y0/100,0,x1/100,y1/100,0,'PANNELLI','254','FITTIZIA')
  else Add_LineaDxf(x0/100,y0/100,0,x1/100,y1/100,0,'PANNELLI','254','CONTINUOUS');
  end;
end;

end.
