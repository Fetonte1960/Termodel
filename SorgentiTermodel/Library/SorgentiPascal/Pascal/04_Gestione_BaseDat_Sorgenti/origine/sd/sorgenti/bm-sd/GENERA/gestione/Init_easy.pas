unit Init_easy;

interface
uses sysutils,libreriagenerale,windows,uleggiscrividati,Varcarichi,umaingenera,menus,classes,dialogs;
Procedure Nuovoprog;
Procedure Apriprog;
Procedure Aggiorna_file;
Procedure Init_app;
Procedure Gest_menu(Voce:string);

Const Nomeapp='Programmazione facile 1.0 ';

implementation
uses  MainGestionegenera;
Var   perc_sorg:string='Q:\genera\gestione\';
      perc_distr:string='Q:\genera\distribuzione\';

Procedure Gest_menu(Voce:string);
begin
showmessage('Menu '+voce);
end;

Procedure copia_sostituisci(path1,path2,orig,sost:String;ListaOrig,Listasost:Tstringlist);
Var ffi,ffo:textfile;
    buf:string;
    bufch:char;
    i:integer;
    trov,solouno:boolean;
const maxl=200;
begin
assign(ffi,Path1);
assign(ffo,Path2);
reset(ffi);
rewrite(ffo);
buf:='';
while (not eof(ffi))or(buf<>'') do
  begin
  if not eof(ffi) then
    begin
    read(ffi,bufch);
    buf:=buf+bufch;
    end;
  i:=0;
  trov:=false;
  while (i<listasost.Count)and(not trov) do
    begin
    if length(buf)>=length(listaorig.Strings[i]) then
      begin
      {
      if uppercase('Nuova_formDB')=uppercase(copy(buf,1,length('Nuova_formDB')))then
        begin
        showmessage('Debug');
        end;
       }
      if uppercase(listaorig.Strings[i])=uppercase(copy(buf,1,length(listaorig.Strings[i])))then
        begin
        trov:=true;
        write(ffo,listasost.Strings[i]);
        buf:=copy(buf,length(listaorig.Strings[i])+1,length(buf)-length(listaorig.Strings[i]));
        end;
      end;
    inc(i);
    end;
  solouno:=true;
  while (length(buf)>maxl)or(eof(ffi)and solouno) do
    begin
    solouno:=false;
    write(ffo,buf[1]);
    if length(buf)=1 then buf:=''
    else buf:=copy(buf,2,length(buf)-1);
    end;
  end;
write(ffo,buf);
close(ffi);
close(ffo);
end;
{
Var FForm:textfile;
Procedure scrivi_label(etic:string;x,y:integer);
begin
writeln(FForm,'object Label1: TLabel');
writeln(FForm,'  Left = 32');
writeln(FForm,'  Top = 32');
writeln(FForm,'  Width = 32');
writeln(FForm,'  Height = 13');
writeln(FForm,'  Caption = '''+etic+'''');
writeln(FForm,'end');
end;
}
Procedure Init_app;
begin
end;
Procedure Set_perc_prog;
begin
out_sorg:=extractfilepath(nomeprog);
out_base:=I_sl(out_sorg);
out_sorg:=I_sl(out_sorg)+'sorgenti\';
perc_sorg:=percorsodrive;
perc_distr:=percorsodrive;
//Percorsodrive:=perc+nome;
end;
Procedure Apriprog;
begin
Set_perc_prog;
end;

Procedure Nuovoprog;
begin
Set_perc_prog;
createdir(perc+nome+'\sorgenti');
createdir(perc+nome+'\sorgenti\generati');
createdir(perc+nome+'\sorgenti\libreriedatabase');
createdir(perc+nome+'\sorgenti\libreriedatabase\sudisco');
createdir(perc+nome+'\sorgenti\generati\inclusi');
createdir(perc+nome+'\Distribuzione');
createdir(perc+nome+'\Distribuzione\database');
createdir(perc+nome+'\DCU');
end;
Procedure Aggiorna_file;
Var Nome1,buff,TipoED:string;
    FF,FF1,ff2,ff3,ff4,ff5,fform,fdefc:textfile;
    I,J,K,K1,IndASS,countcampi,Campieff,colform,pos_l1,pos_l2,pos_ed1,pos_ed2,DASS:integer;
    G_MaxXForm,G_MaxYForm,GA_MaxXForm,GA_MaxYForm,G_campiform,G_ColonneForm,G_Labcol1,G_edcol1,G_infocol1,G_Labcol2,G_edcol2,G_infocol2:integer;
    primav,trov1,trov2:boolean;
    sl,sl2:Tstringlist;
    POsx,posy,deltay:integer;

Procedure Scriviarchivio(ind:integer);
Var IL,JL,KL:integer;
    TR:string;
    dind:integer;
begin
with Rec_D^[ind] do
  begin
  if not primav then writeln(ff,'*') else primav:=false;
  writeln(ff,'Vuoto:Tab'+Codice+':'+Codice+':1:fissa:');
  write(ff,'array:'+Codice+'_D:Max'+Codice+':200:N'+Codice+':');
  if tipo='Elenco con associato' then
    begin
    writeln(ff,'Master:Numero:20:'+Associato+':');
    writeln(ff,'Num:Numero:Autoinc:');
    end
  else
    begin
    if tipo='Elenco associato' then writeln(ff,'Slave:Numero:Integer:')
    else writeln(ff,'');
    end;
  for IL:=1 to Ncampi do
    begin
    if Campi[il].Tipo='Reale' then TR:='Real';
    if Campi[il].Tipo='Intero' then TR:='Integer';
    if Campi[il].Tipo='Caratteri' then TR:='String['+inttostr(Campi[il].LungCar)+']';
    write(ff,'#'+inttostr(Campi[il].Tag)+':'+Campi[il].codice+':'+Campi[il].lunga+':'+TR+':');
    if Campi[il].Griglia<>-1 then write(ff,'GRD#'+inttostr(Campi[il].Griglia)+':');
    if Campi[il].lookup<>'' then
      begin
      JL:=1;
      DInd:=0;
      while (JL<Nrec)and(Campi[il].lookup<>Rec_D^[JL].Codice)do Inc(JL);
      if Rec_D^[JL].Tipo='Elenco con associato' then DInd:=1;
      KL:=1;
      while (KL<Rec_D^[JL].NCampi)and(Uppercase(Campi[il].CampoLookUp)<>Uppercase(Rec_D^[JL].Campi[KL].Codice))do Inc(KL);
      write(ff,'LKK#'+Campi[il].lookup+'/'+inttostr(KL+DInd)+'/P:');
      end;
    if Campi[il].combo1<>'' then
      begin
      write(ff,'CMB#'+Campi[il].combo1+':');
      if Campi[il].combo2<>'' then write(ff,'CMB#'+Campi[il].combo2+':');
      if Campi[il].combo3<>'' then write(ff,'CMB#'+Campi[il].combo3+':');
      if Campi[il].combo4<>'' then write(ff,'CMB#'+Campi[il].combo4+':');
      if Campi[il].combo5<>'' then write(ff,'CMB#'+Campi[il].combo5+':');
      if Campi[il].combo6<>'' then write(ff,'CMB#'+Campi[il].combo6+':');
      if Campi[il].combo7<>'' then write(ff,'CMB#'+Campi[il].combo7+':');
      if Campi[il].combo8<>'' then write(ff,'CMB#'+Campi[il].combo8+':');
      if Campi[il].combo9<>'' then write(ff,'CMB#'+Campi[il].combo9+':');
      if Campi[il].combo10<>'' then write(ff,'CMB#'+Campi[il].combo10+':');
      end;
    writeln(ff,'');
    end;

  end;
end;
Procedure Calcolaingombri(arch:integer;Var MaxXForm,MaxYForm,campiCol1,ColonneForm,Labcol1,edcol1,infocol1,Labcol2,edcol2,infocol2:integer);
Var i,j,Numc,maxLab,Maxed,Led,campiform:integer;
    dsc:string;

Function s_car(Ls:integer):integer;
Begin
//100/17
result:=20+ls*round(100/17);
end;

Function spaziocar(ss:string):integer;
begin
result:=S_car(length(ss));
end;
Function spazioEd(Tipo:string;lung:integer):integer;
begin
if (tipo='Intero')or(tipo='Reale') then Result:=60
else result:=s_car(lung);
end;

begin
Numc:=0;
maxLab:=0;Maxed:=0;
Campiform:=rec_D^[arch].Ncampi;
if campiform<=4 then
     begin
     CampiCol1:=Campiform;
     ColonneForm:=1;
     end
  else
     begin
     CampiCol1:=(campiform div 2)+(campiform mod 2);
     ColonneForm:=2;
     end;

For i:=1 to rec_D^[arch].NCampi do
with rec_D^[arch].Campi[i] do
//if griglia=-1 then
  begin
  inc(numc);
  dsc:=codice;
  if lunga<>'' then dsc:=lunga;
  if spaziocar(dsc)>Maxlab then Maxlab:=spaziocar(dsc);
  if spazioed(tipo,Lungcar)>Maxed then Maxed:=spazioed(tipo,Lungcar);
  if (colonneform=2)and
     (((Numc=4)and(campiform<=8))or((Numc=(campiform div 2)+(campiform mod 2))and(campiform>8))) then
    begin
    Labcol1:=Maxlab;
    Edcol1:=MaxEd;
    maxLab:=0;Maxed:=0;
    end;
  end;

If colonneform=1 then
  begin
  Labcol1:=Maxlab;
  Edcol1:=MaxEd;
  end;

MaxYForm:=CampiCol1*20+30;
if MaxYForm<150 then MaxYForm:=150;
MaxXForm:=32+Labcol1+edcol1;
if (colonneform=2) then
  begin
  Labcol2:=Maxlab;
  Edcol2:=MaxEd;
  MaxXForm:=32+Labcol1+edcol1+Labcol2+edcol2;
  end;
if maxxform<500 then maxxform:=500;
if maxYform<250 then maxYform:=250;
end;

Procedure scriviedit(Tipoedit:string;arch,campo,indedit:integer);
Const UpY=5;
begin

with rec_D^[arch] do
  begin
  writeln(FForm,'    object '+copy(Tipoedit,2,length(tipoedit)-1)+inttostr(indedit)+':'+TipoEdit);
  writeln(FForm,'    Tag ='+inttostr(campi[campo].Tag));
  if tipoedit='TLabel' then
    begin
    writeln(FForm,'    Left = '+inttostr(posx));
    writeln(FForm,'    Width = 32');
    writeln(FForm,'    Height = 13');
    writeln(FForm,'    Top = '+Inttostr(posy));
    end
  else
    begin
    writeln(FForm,'    Left = '+inttostr(posx));
    writeln(FForm,'    Width = 121');
    writeln(FForm,'    Height = 21');
    writeln(FForm,'    Top = '+Inttostr(posy-upy));
    end;
  if tipoedit='TLabel' then
  if campi[campo].lunga<>'' then
  writeln(FForm,'    Caption = '''+campi[campo].lunga+'''')
  else writeln(FForm,'    Caption = '''+campi[campo].Codice+'''');
  if tipoedit<>'TLabel' then writeln(FForm,'    TabOrder ='+inttostr(campo));
  writeln(FForm,'    end');
  end;

end;
begin
sl:=tstringlist.Create;
sl2:=tstringlist.Create;
nome1:='gestionedati';


//copyfile(Pchar(perc_sorg+'Gestionedati.dpr'),Pchar(out_sorg+nome1+'.dpr'),false);
if not fileexists(out_sorg+'Calcolo.Pas')then
copyfile(Pchar(perc_sorg+'Calcolo.Pas'),Pchar(out_sorg+'Calcolo.Pas'),false);
copyfile(Pchar(perc_sorg+'Infogen.Pas'),Pchar(out_sorg+'Infogen.Pas'),false);
copyfile(Pchar(perc_sorg+'Varcarichi.Pas'),Pchar(out_sorg+'Varcarichi.Pas'),false);
copyfile(Pchar(perc_sorg+'Messaggi_easy.Pas'),Pchar(out_sorg+'Messaggi_easy.Pas'),false);
copyfile(Pchar(perc_sorg+'Gestionedati.dof'),Pchar(out_sorg+nome1+'.dof'),false);
copyfile(Pchar(perc_sorg+'Gestionedati.res'),Pchar(out_sorg+nome1+'.res'),false);
copyfile(Pchar(perc_sorg+'Gestionedati.cfg'),Pchar(out_sorg+nome1+'.cfg'),false);
copyfile(Pchar(perc_sorg+'Projectgroup.bpg'),Pchar(out_sorg+'Projectgroup.bpg'),false);
copyfile(Pchar(perc_sorg+'Projectgroup.dsk'),Pchar(out_sorg+'Projectgroup.dsk'),false);
copyfile(Pchar(perc_sorg+'Maingestionegenera.pas'),Pchar(out_sorg+'Maingestionegenera.pas'),false);
copyfile(Pchar(perc_sorg+'Maingestionegenera.dfm'),Pchar(out_sorg+'Maingestionegenera.dfm'),false);
copyfile(Pchar(perc_sorg+'Modello_ Init_easy.pas'),Pchar(out_sorg+'Init_easy.pas'),false);
copyfile(Pchar(perc_sorg+'Filtri_DB.pas'),Pchar(out_sorg+'Filtri_DB.pas'),false);
copyfile(Pchar(perc_sorg+'Gestdb.pas'),Pchar(out_sorg+'Gestdb.pas'),false);
copyfile(Pchar(perc_sorg+'Gestdb.dfm'),Pchar(out_sorg+'Gestdb.dfm'),false);
copyfile(Pchar(perc_distr+'dcu\Libreriagenerale.dcu'),Pchar(out_base+'dcu\Libreriagenerale.dcu'),false);
copyfile(Pchar(perc_distr+'dcu\Config_var.dcu'),Pchar(out_base+'dcu\Config_var.dcu'),false);
copyfile(Pchar(perc_distr+'dcu\Gest_form.dcu'),Pchar(out_base+'dcu\Gest_form.dcu'),false);
copyfile(Pchar(perc_distr+'dcu\Gest_form.dfm'),Pchar(out_base+'dcu\Gest_form.dfm'),false);
copiacartella(perc_distr+'Libreriedatabase',out_sorg+'libreriedatabase','');
copiacartella(perc_distr+'Libreriedatabase\sudisco',out_sorg+'libreriedatabase\sudisco','');

assign(ff4,out_sorg+'Uses.pas');
rewrite(ff4);
assign(ff2,out_sorg+'Init_app.pas');
rewrite(ff2);
writeln(ff2,'Nomeapp:='''+nome+''';');
assign(ff3,out_sorg+'Gest_menu.pas');
rewrite(ff3);
LeggidatiT;
assign(ff,out_sorg+'generati\base.dat');
rewrite(ff);

assign(ff1,out_sorg+nome1+'.dpr');
rewrite(ff1);
writeln(ff1,'program Gestionedati;');
writeln(ff1,'');
writeln(ff1,'uses');
writeln(ff1,'  Forms,');

Primav:=true;
For i:=1 to Nrec do
with Rec_D^[I] do
if tipo<>'Elenco associato' then
  begin
  if menu<>'' then
    begin
    j:=1;
    while (j<i-1)and((Rec_D^[j].Menu<>menu)or(Rec_D^[j].tipo='Elenco associato'))do inc(j);
    if (i=1)or(Rec_D^[j].Menu<>menu)or(Rec_D^[j].tipo='Elenco associato') then
      begin
      writeln(ff2,'sl.Clear;');
      writeln(ff2,'sl.Add('''+Descrizione+''');');
      for j:=i+1 to Nrec do
      if Rec_D^[j].tipo<>'Elenco associato' then
      if Rec_D^[j].menu=menu then
      writeln(ff2,'sl.Add('''+Rec_D^[j].Descrizione+''');');
      writeln(ff2,'FGestioneGenera.ADD_menu('''+menu+''',sl);');
      end;
    end;
  end;
For i:=1 to Nrec do
with Rec_D^[I] do
if tipo<>'Elenco associato' then
  begin
  if menu<>'' then
    begin
    writeln(ff1,'  Gestione_'+codice+' in ''Gestione_'+Codice+'.pas'' {F'+codice+'},');

    writeln(ff3,'If voce='''+Descrizione+''' then gest_'+codice+';');
    writeln(ff4,',Gestione_'+codice);



    {
    sl.Clear;
    sl.Add(Descrizione);
    FGestioneGenera.ADD_menu(menu,sl);
    }
    sl.Clear;sl2.Clear;
    sl.Add('NOMEDATABASE');
    sl2.Add(codice);
    k:=0;
    trov1:=false;
    trov2:=false;
    while (k<Ncampi)and(not(trov1) or not(trov2)) do
    //if campi[k+1].griglia=-1 then
      begin
      inc(k);
      if (not trov1)and(campi[k].TipoCampo='Codice') then
        begin
        trov1:=true;
        sl.Add('CAMPO_CODICE');
        sl2.Add(campi[k].Codice);
        end;
      if (not trov2)and(campi[k].TipoCampo='Descrizione') then
        begin
        trov2:=true;
        sl.Add('TAGDESCR');
        sl2.Add(inttostr(campi[k].tag));
        end;
      end;
    if not trov1 then
      begin
      sl.Add('CAMPO_CODICE');
      sl2.Add('');
      end;
    if not trov2 then
      begin
      sl.Add('TAGDESCR');
      sl2.Add('0');
      end;
    if associato<>'' then
      begin
      sl.Add('NOMEASSOCIATA');
      sl2.Add(associato);
      copia_sostituisci(perc_sorg+'Modello_associata.pas',out_sorg+'Associata_'+codice+'.pas','','',sl,sl2);
      end
    else copia_sostituisci(perc_sorg+'associata_Vuota.pas',out_sorg+'Associata_'+codice+'.pas','','',sl,sl2);
    sl.Add('DESCRIZIONE_DATABASE');
    sl2.Add(Descrizione);
    if (not fileexists(out_sorg+'Gestione_'+codice+'.pas'))or(aggiorna='SI') then
      begin
      assign(Fdefc,out_sorg+'Defcampi_'+codice+'.pas');
      rewrite(Fdefc);

      copia_sostituisci(perc_sorg+'gestione_nomedatabase.pas',out_sorg+'Gestione_'+codice+'.pas','','',sl,sl2);
      //copia_sostituisci(perc_sorg+'gestione_nomedatabase.dfm',out_sorg+'Gestione_'+codice+'.dfm','','',sl,sl2);

      copia_sostituisci(perc_sorg+'gestione_nomedatabase.dfm',perc_sorg+'temp_nomedatabase.dfm','','',sl,sl2);
      assign(ff5,perc_sorg+'temp_nomedatabase.dfm');
      reset(ff5);
      assign(FForm,perc_sorg+'temp1_nomedatabase.dfm');
      rewrite(fform);
      while not eof(ff5)do
        begin
        readln(ff5,buff);
        if buff='  object GroupBox1: TGroupBox' then
          begin
          writeln(FForm,buff);
          Calcolaingombri(I,G_MaxXForm,G_MaxYForm,G_campiform,G_ColonneForm,G_Labcol1,G_edcol1,G_infocol1,G_Labcol2,G_edcol2,G_infocol2);
          for k:=1 to 7 do
            begin
            readln(ff5,buff);
            writeln(FForm,buff);
            end;
          Posx:=16;POsy:=24;DeltaY:=100;
          countcampi:=0;
          for k:=1 to ncampi do
          //if campi[k].Griglia=-1 then
            begin
            inc(countcampi);
            if countcampi=G_campiform+1 then
              begin
              POsx:=32+G_Labcol1+G_edcol1;
              POsy:=24;
              end;

            if countcampi>G_campiform then POsx:=32+G_Labcol1+G_edcol1
            else POsx:=16;

            scriviedit('TLabel',i,k,k);
            writeln(Fdefc,'Label'+inttostr(k)+':Tlabel;');

            if countcampi>G_campiform then POsx:=32+G_Labcol1+G_edcol1+G_Labcol2
            else POsx:=16+G_Labcol1;

            TipoEd:='DbCombobox';
            if (campi[k].LookUp='')and(campi[k].Combo1='') then TipoEd:='DbEdit';

            scriviedit('T'+TipoEd,i,k,k);
            writeln(Fdefc,TipoEd+inttostr(k)+':T'+TipoEd+';');
            posy:=posy+20;
            end;
          end
        else
        if buff='  object GroupBox2: TGroupBox' then
          begin
          GA_MaxXForm:=0;GA_MaxYForm:=0;
          if associato<>'' then
            begin
            indass:=1;
            while (Indass<Nrec)and(rec_d^[indass].Codice<>associato)do inc(indass);
            writeln(FForm,buff);
            Calcolaingombri(indass,GA_MaxXForm,GA_MaxYForm,G_campiform,G_ColonneForm,G_Labcol1,G_edcol1,G_infocol1,G_Labcol2,G_edcol2,G_infocol2);
            for k:=1 to 7 do
              begin
              readln(ff5,buff);
              if k=3 then
              writeln(FForm,'Width ='+inttostr(GA_MaxXForm))
              else if k=4 then writeln(FForm,'Height ='+inttostr(GA_MaxYForm))
              else writeln(FForm,buff);
              end;
            DASS:=270-16;
            Posx:=270;POsy:=24;DeltaY:=100;
            countcampi:=0;
            for k:=1 to rec_d^[indass].ncampi do
            //if rec_d^[indass].campi[k].Griglia=-1 then
              begin
              inc(countcampi);
              if countcampi=G_campiform+1 then
                begin
                POsx:=DASS+32+G_Labcol1+G_edcol1;
                POsy:=24;
                end;

             if countcampi>G_campiform then POsx:=DASS+32+G_Labcol1+G_edcol1
             else POsx:=DASS+16;

              k1:=k+Ncampi;
              scriviedit('TLabel',indass,k,k1);
              writeln(Fdefc,'Label'+inttostr(k1)+':Tlabel;');

             if countcampi>G_campiform then POsx:=DASS+32+G_Labcol1+G_edcol1+G_Labcol2
             else POsx:=DASS+16+G_Labcol1;

              TipoEd:='DbCombobox';
              if rec_d^[indass].campi[k].LookUp='' then TipoEd:='DbEdit';

              scriviedit('T'+TipoEd,indass,k,k1);
              writeln(Fdefc,TipoEd+inttostr(k1)+':T'+TipoEd+';');
              posy:=posy+20;
              end;
            end
            else
              begin
              writeln(FForm,buff);
              for k:=1 to 4 do
              begin
              readln(ff5,buff);
              if k=4 then writeln(FForm,'Height =0')
              else writeln(FForm,buff);
              end;
          end;
          end
        else writeln(FForm,buff);

        end;
      close(ff5);
      close(fform);

      assign(ff5,perc_sorg+'temp1_nomedatabase.dfm');
      reset(ff5);
      assign(FForm,out_sorg+'Gestione_'+codice+'.dfm');
      rewrite(fform);
      for k:=1 to 3 do
        begin
        readln(ff5,buff);
        writeln(FForm,buff);
        end;
      if DASS+GA_MaxXForm>G_MaxXForm then G_MaxXForm:=DASS+GA_MaxXForm;
      readln(ff5,buff);
      writeln(FForm,'Width='+inttostr(G_MaxXForm));
      readln(ff5,buff);
      writeln(FForm,'Height ='+inttostr(G_MaxYForm+GA_MaxYForm+50));

      while not eof(ff5)do
        begin
        readln(ff5,buff);
        writeln(FForm,buff);
        end;
      close(ff5);
      close(fform);
      close(Fdefc);

      end;
    end;
  if tipo='Elenco con associato' then
  for J:=1 to Nrec do
  if codice=Rec_D^[J].associato then scriviarchivio(J);
  scriviarchivio(i);
  end;

close(ff4);
close(ff3);
close(ff2);
writeln(ff1,'  Calcolo in ''Calcolo.pas'' ,');
writeln(ff1,'  Varcarichi in ''Varcarichi.pas'' ,');
writeln(ff1,'  MainGestionegenera in ''MainGestionegenera.pas'' {FGestioneGenera};');
writeln(ff1,'');
writeln(ff1,'{$R *.res}');
writeln(ff1,'');
writeln(ff1,'begin');
writeln(ff1,'  Application.Initialize;');
writeln(ff1,'  InitPuntatori;');
writeln(ff1,'  Application.CreateForm(TFGestioneGenera, FGestioneGenera);');
writeln(ff1,'  Application.Run;');
writeln(ff1,'end.');
close(ff1);

writeln(ff,'**');
close(ff);
PathLoc:=out_sorg+'generati\';
form1:=Tform1.Create(nil);
locale:=true;
form1.Button1Click(Nil);
sl.Free;
sl2.Free;
end;
end.
