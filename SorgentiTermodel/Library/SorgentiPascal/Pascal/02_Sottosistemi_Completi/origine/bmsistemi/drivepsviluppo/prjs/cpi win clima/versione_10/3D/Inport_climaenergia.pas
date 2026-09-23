unit Inport_climaenergia;
interface
uses sysutils,varcarichi,libreriagenerale,grafica2d,letturainmemoria,init_cad3d,
dxf_in_out,angoli;
Procedure inporta_edificio_climaenergia(nome_int:string);

implementation
Procedure inporta_edificio_climaenergia(nome_int:string);
Var F_int:textfile;
    Buf,Piano_corrente,ent,ColLn,codloc,confbasso,tipobasso,confalto,tipoalto:string;
    i,count,count_conf,count_par,indice_piano:integer;
    xl1,yl1,zl1,xl2,yl2,zl2,altbasso:real;
    llayer,lcolore,ltlinea:string;
    LAng:real;
    LNomebl:string;
    trovatomisto,fittizia:boolean;

Procedure Salva_dxf;
Var trov:boolean;
    X_int,y_int,dir,dirZ,croce:real;
    res,K,j:integer;
{$I inters}
begin
croce:=0.1;
apr:=0.01;
if nentita=0 then exit;
//allineamento finestre
for k:=1 to Nentita do
if (entita_d^[k]^.Cod='B')and(entita_d^[k]^.NomeBl='FIN') then
  begin
  j:=0;
  trov:=false;
  while (j<Nentita)and(not trov) do
    begin
    inc(j);
    if (entita_d^[J]^.Cod='L') then
    with  entita_d^[J]^ do
      begin
      inters(x_int,Y_int,res,x1,x2,entita_d^[k]^.x1+croce,entita_d^[k]^.x1-croce,y1,y2,entita_d^[k]^.y1,entita_d^[k]^.y1);
      if res<>1 then
      inters(x_int,Y_int,res,x1,x2,entita_d^[k]^.x1,entita_d^[k]^.x1,y1,y2,entita_d^[k]^.y1+croce,entita_d^[k]^.y1-croce);
      if res=1 then
        begin
        Calc_d(x1,y1,0,x2,y2,0,dir,dirz);
        entita_d^[k]^.Ang:=-(dir*180/PI-90);
        trov:=true;
        end;
      //entita_d^[k]^.Ang:=45;
      end;
    end;
  end;

Output_dxf(nome_dxf(Piano_corrente,'','EDIFICIO'));
nentita:=0;
end;

begin
NParspeciali:=0;
Piano_corrente:='';
Nentita:=0;
count:=0;
count_conf:=0;
count_par:=0;
LLayer:='EDIFICIO';
for i:=1 to npiani do
  begin
  piani_d^[i].Indice:=i;
  piani_d^[i].ScalaP:=100;
  end;
for i:=1 to Nstrutture do
strutture_D^[i]^.ColCAD:='';

for i:=1 to nconfini do
confine_d^[i].TLinea:='';

assign(F_Int,nome_int);
reset(F_int);
reset(f_int);
while not eof(f_int) do
  begin
  readln(f_int,Buf);
  azzeraidentif;
  ent:=leggiidentif1(buf);
  if Uppercase(ent)='NORD' then
    begin
    ent:=leggiidentif1(buf);
    Cofcad_D^.AngNord:=str_tofloat(ent);
    end
  else
    begin
    if Uppercase(ent)='PIANO' then
      begin
      ent:=leggiidentif1(buf);
      if Piano_corrente='' then
        begin
        Piano_corrente:=ent;
        Cofcad_D^.PIANOCOR:=Piano_corrente;
        for indice_piano:=1 to Npiani do
        if uppercase(piani_d^[indice_piano].Cod)=uppercase(Piano_corrente) then break;
        end
      else
        begin
        salva_dxf;
        Piano_corrente:=ent;
        for indice_piano:=1 to Npiani do
        if uppercase(piani_d^[indice_piano].Cod)=uppercase(Piano_corrente) then break;
        end;
      end
    else
      begin
        begin
          case ent[1] of
          'M':begin
              ent:=leggiidentif1(buf);//numerazione parete
              ent:=leggiidentif1(buf);
              Lcolore:=colore_CAD(Nstrutture+1); //nel caso la parete non venisse associata
              if uppercase(ent)<>'FITTIZIA' then
                begin
                fittizia:=false;
                for i:=1 to nstrutture do
                if uppercase(strutture_d^[i]^.NFile)=uppercase(ent) then
                  begin
                  if strutture_D^[i]^.ColCAD='' then
                    begin
                    inc(count_par);
                    strutture_D^[i]^.ColCAD:=colore_cad(count_par);
                    end;
                  Lcolore:=inttostr(indcolore(strutture_D^[i]^.ColCAD));
                  Break;
                  end;
                end
              else
                begin
                fittizia:=true;
                Lcolore:=inttostr(indcolore(strutture_D^[1]^.ColCAD));
                end;
              ent:=leggiidentif1(buf);
              xL1:=str_tofloat(ent);
              ent:=leggiidentif1(buf);
              yL1:=str_tofloat(ent);
              ent:=leggiidentif1(buf);
              xL2:=str_tofloat(ent);
              ent:=leggiidentif1(buf);
              yL2:=str_tofloat(ent);
              ent:=leggiidentif1(buf);//h1
              ent:=leggiidentif1(buf);//h2
              ent:=uppercase(leggiidentif1(buf));
              zl1:=0;
              zl2:=0;
              if fittizia then
              LTlinea:='Fittizia'
              else
              if ent='ESTERNO' then
              LTlinea:='Continuous'
              else
              if ent='NON SC' then
              LTlinea:='NONSC'
              else
              if ent='MISTO' then
                begin
                LTlinea:='SPECIALE';
                confalto:=leggiidentif1(buf);
                tipoalto:=leggiidentif1(buf);
                altbasso:=str_tofloat(leggiidentif1(buf));
                confbasso:=leggiidentif1(buf);
                tipobasso:=leggiidentif1(buf);
                trovatomisto:=false;
                if Nparspeciali>0 then
                for i:=1 to Nparspeciali do
                with ParSpeciali_D^[i]^ do
                  begin
                  {
                  #5:AltParte1::Real:INI#0:
                  #6:TipoStruttura1::String[50]:INI#'':
                  #7:ConfineStruttura1::String[50]:INI#'':
                  #8:AltParte2::Real:INI#0:
                  #9:TipoStruttura2::String[50]:INI#'':
                  #10:ConfineStruttura2::String[50]:INI#'':
                  }
                  trovatomisto:=(AltParte1=altbasso)and(tipostruttura1=tipobasso)and(ConfineStruttura1=confbasso)and
                                (tipostruttura2=tipoalto)and(ConfineStruttura2=confalto);
                  if trovatomisto then break;
                  end;
                if not trovatomisto then
                  begin
                  inc(Nparspeciali);
                  if ParSpeciali_D^[Nparspeciali]=nil then new(ParSpeciali_D^[Nparspeciali]);
                  with ParSpeciali_D^[Nparspeciali]^ do
                    begin
                    codice:=Nparspeciali;
                    Categoria:='Pareti miste';
                    descrizione:='Mista '+inttostr(Nparspeciali);
                    colcad:=colore_cad(Nparspeciali);
                    AltParte1:=altbasso;
                    tipostruttura1:=tipobasso;
                    ConfineStruttura1:=confbasso;
                    tipostruttura2:=tipoalto;
                    ConfineStruttura2:=confalto;
                    i:=Nparspeciali;
                    end;
                  Lcolore:=inttostr(i);
                  end;
                end
              else
                begin
                for i:=1 to nconfini do
                if uppercase(confine_d^[i].Codice)=ent then
                  begin
                  if confine_d^[i].TLinea='' then
                    begin
                    inc(count_conf);
                    confine_d^[i].TLinea:='Conf'+inttostr(count_conf);
                    end;
                  Ltlinea:=confine_d^[i].TLinea;
                  end;
                end;
              Add_LineaDxf(xl1,yl1,zl1,xl2,yl2,zl2,llayer,lcolore,ltlinea);
              end;
          'P':begin
              ent:=leggiidentif1(buf); //codice ponte
              LNomebl:='PON';
              ent:=leggiidentif1(buf);
              xL1:=str_tofloat(ent);
              ent:=leggiidentif1(buf);
              yL1:=str_tofloat(ent);
              lang:=0;
              Add_BloccoDxf(xl1,yl1,zl1,LAng,LNomebl,llayer);
              ent:=leggiidentif1(buf);
              Add_Attrib_Dxf('TIPO',ent);
              ent:=float_to_str(str_tofloat(leggiidentif1(buf)),3);//per identificare correttamente la virgola
              Add_Attrib_Dxf('LUNG',ent);
              end;
          'L':begin
              ent:=leggiidentif1(buf); //codice locale
              codloc:=ent;
              for i:=1 to nambienti do
              if codloc= ambienti_d^[i]^.CodNum then break;
              if uppercase(ambienti_d^[i]^.codzona)='NON RISC' then
              LNomebl:='LOCNR'
              else LNomebl:='LOC';
              ent:=leggiidentif1(buf);
              xL1:=str_tofloat(ent);
              ent:=leggiidentif1(buf);
              yL1:=str_tofloat(ent);
              lang:=0;
              Add_BloccoDxf(xl1,yl1,zl1,LAng,LNomebl,llayer);
              Add_Attrib_Dxf('COD',inttostr(indice_piano*1000+strtoint(codloc)));
              Add_Attrib_Dxf('DESCR.',ambienti_d^[i]^.Denom);
              Add_Attrib_Dxf('ZONA',ambienti_d^[i]^.codzona);
              Add_Attrib_Dxf('IMPIANTO',ambienti_d^[i]^.impianto);
              Add_Attrib_Dxf('TSOF',ambienti_d^[i]^.T_Soff);
              if  uppercase(ambienti_d^[i]^.C_Soff)='NON SC' then ambienti_d^[i]^.C_Soff:='Non sc';
              Add_Attrib_Dxf('CSOF',ambienti_d^[i]^.C_Soff);
              Add_Attrib_Dxf('TPAV',ambienti_d^[i]^.T_Pav);
              if  uppercase(ambienti_d^[i]^.C_Pav)='NON SC' then ambienti_d^[i]^.C_Pav:='Non sc';
              Add_Attrib_Dxf('CPAV',ambienti_d^[i]^.C_Pav);
              Add_Attrib_Dxf('QUOTA','0');
              Add_Attrib_Dxf('ALT.',float_to_str(ambienti_d^[i]^.hsoffitto,3));
              Add_Attrib_Dxf('APP',inttostr(ambienti_d^[i]^.AppCorrisp));
              Add_Attrib_Dxf('LOCABIT',inttostr(ambienti_d^[i]^.LocAbit));
              Add_Attrib_Dxf('LOCSOTT',ambienti_d^[i]^.UnionLoc);

              if Lnomebl='LOCNR' then
                begin
                Add_Attrib_Dxf('TINV',float_to_str(ambienti_d^[i]^.TNInv,6));
                Add_Attrib_Dxf('TEST',float_to_str(ambienti_d^[i]^.TNEst,6));
                Add_Attrib_Dxf('RICARIA',float_to_str(ambienti_d^[i]^.RicAria,6));
                Add_Attrib_Dxf('APPGRA',float_to_str(ambienti_d^[i]^.CaricoInt,6));
                Add_Attrib_Dxf('FCONV',float_to_str(ambienti_d^[i]^.ValBxLNR,6));
                Add_Attrib_Dxf('CALCOLOT',ambienti_d^[i]^.TipoCalcTempNR);
                Add_Attrib_Dxf('TIPOBXSCELTO',ambienti_d^[i]^.TipoBXScelto);
                Add_Attrib_Dxf('POSTUBI',ambienti_d^[i]^.PosTubi);
                Add_Attrib_Dxf('LUNG',float_to_str(ambienti_d^[i]^.Lung,6));
                end;
              {
              if Uppercase(attrib[j].CodA)='ALT.' then
                  HSoffitto:=str_tofloat(attrib[j].valore);
                  if Uppercase(attrib[j].CodA)='QUOTA' then
                  Quotapav:=str_tofloat(attrib[j].valore);
                  if Uppercase(attrib[j].CodA)='APP' then
                    begin
                    val(attrib[j].valore,ttreal,resval);
                    if resval=0 then
                    APPCorrisp:=strtoint(attrib[j].valore)
                    else
                    APPCorrisp:=0;
                    end;

                  if Uppercase(attrib[j].CodA)='LOCABIT' then
                    begin
                    val(attrib[j].valore,ttreal,resval);
                    if resval=0 then
                    locabit:=strtoint(attrib[j].valore)
                    else
                    locabit:=0;
                    end;

                  if Uppercase(attrib[j].CodA)='LOCSOTT' then
                  UnioNLoc:=attrib[j].valore;
                  end;


              if Uppercase(attrib[j].CodA)='TINV' then
                  TNInv:=str_tofloat(attrib[j].valore);
                  if Uppercase(attrib[j].CodA)='TEST' then
                  TNest:=str_tofloat(attrib[j].valore);
                  if Uppercase(attrib[j].CodA)='RICARIA' then
                  Ricaria:=str_tofloat(attrib[j].valore);
                  if Uppercase(attrib[j].CodA)='APPGRA' then
                  CaricoInt:=str_tofloat(attrib[j].valore);
                  if Uppercase(attrib[j].CodA)='FCONV' then
                  ValBxLNR:=str_tofloat(attrib[j].valore);
                  if Uppercase(attrib[j].CodA)='CALCOLOT' then
                  TipoCalcTempNR:=attrib[j].valore;
                  if Uppercase(attrib[j].CodA)='TIPOBXSCELTO' then
                  TIPOBXSCELTO:=attrib[j].valore;
                  if Uppercase(attrib[j].CodA)='POSTUBI' then
                  POSTUBI:=attrib[j].valore;
                  if Uppercase(attrib[j].CodA)='LUNG' then
                  LUNG:=str_tofloat(attrib[j].valore);
                }
              end;
          'F':begin
              ent:=leggiidentif1(buf); //codice finestra
              LNomebl:='FIN';
              ent:=leggiidentif1(buf);
              xL1:=str_tofloat(ent);
              ent:=leggiidentif1(buf);
              yL1:=str_tofloat(ent);
              lang:=0;
              Add_BloccoDxf(xl1,yl1,zl1,LAng,LNomebl,llayer);
              ent:=leggiidentif1(buf);
              Add_Attrib_Dxf('TIPO',ent);
              end;
          end;
        end;
      end;
    end;
  end;
if piano_corrente<>'' then salva_dxf;
close(f_int);
end;
end.
