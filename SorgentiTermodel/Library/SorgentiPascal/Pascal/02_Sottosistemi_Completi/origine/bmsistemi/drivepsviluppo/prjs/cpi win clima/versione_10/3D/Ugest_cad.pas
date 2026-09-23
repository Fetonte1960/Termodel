unit UGest_cad;

interface
uses sysutils,windows,dialogs,libreriagenerale,{HeaderDllTermico,}olectnrs,udatalink,config_var; //cadparete;

Var acadok:boolean;
    Percacad,percorsodis,estens:string;

Procedure ScriptApri;
Procedure ScriptLoop;
Procedure ScriptCalcoli;
Procedure ScriptStopLoop;
Procedure ScriptParete(Piano,colore,Tlinea:string);
Procedure ScriptTubo(Piano,colore,Tlinea:string);
Procedure ScriptLocale(Descr,piano,zona,imp,tpav,cpav,tsof,csof,CalcoloT,TIPOBXSCELTO:string;Alt,Tinv,Test,Fconv,Ricaria,Appgra:real);
Procedure ScriptFinestra(piano,codice,l,h:string;Luc,Specluc:boolean);
Procedure ScriptPonte(piano,codice,l:string);
Procedure ScriptTerminale(piano,simb,att,incr,lmax,Port,potenza,perd,montaggio,serie,fissaserie,modello,fissamodello:string);
Procedure ScriptIniziorete(piano:string);
Procedure ScriptNord(piano:string);
Procedure ScriptPianta(piano:string);
Procedure ScriptValvola(simb,codperd:string);
Procedure Init_Cadesterno;
Procedure run_cadesterno;
Procedure Save_conf;
Procedure eseguiautocad(cerca:boolean);
Procedure esegui_cad(cerca:boolean;Disegno:string);
Procedure CreaBlocco(Nomemod,NomeBl,P1,V1,p2,V2,p3,v3,p4,v4,p5,v5,p6,v6,p7,v7:string);
Procedure CreaBlocco10(Nomemod,NomeBl,P1,V1,p2,V2,p3,v3,p4,v4,p5,v5,p6,v6,p7,v7,p8,v8,p9,v9,p10,v10:string);
Procedure CreaBlocco16(Nomemod,NomeBl,P1,V1,p2,V2,p3,v3,p4,v4,p5,v5,p6,v6,p7,v7,p8,v8,p9,v9,p10,v10,
                       p11,v11,p12,v12,p13,v13,p14,v14,p15,v15,p16,v16:string);
Procedure ScriptSalva;
Procedure ScriptAggiorna;
Procedure ScriptGestrete(Modello,Comando,Tiporete,piano,codice,l,nc,tc:string);
Procedure ScriptCollettore(piano,usc,att,colore:string);
Procedure Scriptriprendi;
Procedure ScriptInterfaccia;

//Procedure ScriptEdifOn;
//Procedure ScriptEdifOFF;
//Procedure ScriptTUBIOFF;
//Procedure ScriptDISTUBION;
//Procedure ScriptINPTUBION;
//Procedure copiaprototipo;
Procedure ScriptAllinea(piano:string);
Procedure puliscifile;
Procedure ScriptNuovo;
procedure InitCad;
Procedure ScriptProjectBRS;
Procedure ScriptCadInterno;
Function IndCodPiano(cod:string):string;


//comandi workgroup
Procedure ScriptapriDiscor;

implementation
//uses Cpi_Win_CLIMA_CadLT;
uses interfdll,u3dsd,init_cad3d;

Type tipocad=(acadltIta,acadeng);
Var Slayer,ssi,sno:string;

function Indblocco:string;
begin
inc(COUNTBLOCCHI);
result:=inttostr(countblocchi);
salva_var('COUNTBLOCCHI',result);
result:='§'+result;
end;

Procedure InitVercad(TCad:tipocad);
begin
  case Tcad of
  acadltIta:
    begin
    Slayer:='R';
    SSi:='S';
    sno:='N';
    end;
  acadeng:
    begin
    Slayer:='_S';
    SSi:='_Y';
    sno:='_N';
    end;
  end;
end;

Function IndCodPiano(cod:string):string;
begin
InitVercad(acadeng);
end;

procedure InitCad;
begin
acadOk:=true;
end;
Procedure puliscifile;
Var sr:tsearchrec;
    ff:file;
    tt:string;
begin
findfirst(percorsodrive+'\*.*',faarchive,sr);
repeat
if (uppercase(copy(sr.Name,1,length('IRETE§')))='IRETE§')or
    (uppercase(copy(sr.Name,1,length('RIPRETE§')))='RIPRETE§')or
    (uppercase(copy(sr.Name,1,length('RIMRETE§')))='RIMRETE§')or
   (uppercase(copy(sr.Name,1,length('RAD§')))='RAD§')or
   (uppercase(copy(sr.Name,1,length('PON§')))='PON§')or
   (uppercase(copy(sr.Name,1,length('FIN§')))='FIN§')or
   (uppercase(copy(sr.Name,1,length('LOC§')))='LOC§') then
  begin
  assign(ff,percorsodrive+'\'+sr.Name);
  erase(ff);
  end;
until FindNext(sr) <> 0;
//FindClose(sr);
end;

Function Pul(valore:string):string;
Var i:integer;
begin
result:='';
for i:=1 to length(Valore) do
if Valore[i] In [' ','_','.',',','*','[',']',':'] then result:=result+'%'
else result:=result+Valore[i];
end;

Function no_slash(st:string):string;
begin
result:=st;
if st>'' then
if st[length(st)]='\' then result:=copy(st,1,length(st)-1);
end;

Procedure esegui_cadwin(cerca:boolean;Disegno:string);
Var ret:integer;
    Opendialog:Topendialog;
begin
if cerca then percacad:='';
if not acadok then exit;
//if acadok then FSuite.autocad.run;
if fileexists(Percacad{+'acad.exe'}) then
  begin
  ret:=winexec(Pchar(Percacad+{acad.exe}' "'+disegno+'"'),SW_MAXIMIZE);
  //ret:=winexec(Pchar('"'+disegno+'"'),SW_MAXIMIZE);
  //ret:=winexec(Pchar(Percacad+{acad.exe}' "'+no_slash(PercorsoDis)+'\disegno.'+estens+'"'),SW_MAXIMIZE);
  // Eseguire qui il controllo se esiste un AUTOCAD aperto con stesso Progetto corrente
  {
  case ret of
  ERROR_BAD_FORMAT:VMessaggio('Apertura di Autocad','The .EXE file is invalid (non-Win32 .EXE or error in .EXE image)');
  ERROR_FILE_NOT_FOUND:VMessaggio('Apertura di Autocad','	The specified file was not found.');
  ERROR_PATH_NOT_FOUND:VMessaggio('Apertura di Autocad','	The specified path was not found.');
  end;
  }
  acadok:=true;

  end
else
  begin
  opendialog:=Topendialog.Create(nil);
  OpenDialog.Title:='Indicare il percorso del cad esterno';
  OpenDialog.Execute;
  OpenDialog.Filter:='Programma|*.exe';
  OpenDialog.Defaultext:='*.exe';
  percacad:=OpenDialog.filename;
  if fileexists(Percacad) then
    begin
    acadok:=true;
    Save_conf;
    ret:=winexec(Pchar(Percacad+{acad.exe}' "'+disegno+'"'),SW_MAXIMIZE);
    //ret:=winexec(Pchar(Percacad+{acad.exe}' "'+PercorsoDis+'\disegno.'+estens+'"'),SW_MAXIMIZE);
    end
  else acadok:=false;
  opendiaLOG.Free;
  end;
end;
Procedure esegui_cad(cerca:boolean;Disegno:string);
Var ret:integer;
begin
CercaPiano;
ultspox:=V_recpia.AllineaX;
ultspoy:=V_recpia.Allineay;
{
ret:=winexec(Pchar('OPEN "'+disegno+'" ,,'),SW_MAXIMIZE);
case ret of
0:showmessage('Out of memory');
ERROR_BAD_FORMAT:showmessage('The .EXE file is invalid (non-Win32 .EXE or error in .EXE image).');
ERROR_FILE_NOT_FOUND	:showmessage('The specified file was not found.');
ERROR_PATH_NOT_FOUND	:showmessage('The specified path was not found.');
end;
exit;
}
chdir(percorsodrive);
//esegui_cadwin(cerca,Disegno);
//exit;

with  form1.olecontainer1 do
  begin
  DestroyObject;
  //if linked then showmessage('linked');
  CreateObjectFromFile(disegno,false);
  //CreateLinkToFile(disegnocorrente,false);
  DoVerb(0);
  end;

end;
Procedure eseguiautocad(cerca:boolean);
begin
esegui_cadwin(cerca,no_slash(PercorsoDis)+'\Hello autocad.dwg');
end;

Function TipoLinea(tl:string;campo:integer):string;
begin
if (Uppercase(tl)='FITTIZIA')or(uppercase(copy(tl,1,4))='CONF') then
  begin
  result:=tl;
  exit;
  end;
Azzeraidentif;
result:=leggiidentif1(tl);
if campo=1 then exit
else result:=leggiidentif1(tl);
end;

function col(Nomecol:string):string;
begin
result:=nomecol;
nomecol:=Uppercase(nomecol);
if Nomecol='ROSSO' then result:='1';
if Nomecol='GIALLO' then result:='2';
if Nomecol='VERDE' then result:='3';
if Nomecol='CIANO' then result:='4';
if Nomecol='BLU' then result:='5';
if Nomecol='MAGENTA' then result:='3';
if Nomecol='BIANCO' then result:='3';
end;

Procedure ScriptFinestra(piano,codice,l,h:string;Luc,Specluc:boolean);
Var ff:textfile;
    nomebl:string;
begin
Nomebl:='fin';
if Luc then
if specluc then Nomebl:='Finlucdwn' else Nomebl:='Finlucup';
assign(ff,percorsodrive+'\finestra.scr');
rewrite(ff);
writeln(ff,'_Layer '+Slayer);
writeln(ff,Piano);
writeln(ff,'');
//writeln(ff,'_insert '+nomebl+'§'+Pul(codice)+'§'+Pul(L)+'§'+Pul(H)+'§§§§.dxf');
writeln(ff,'_insert '+nomebl+indblocco+'.dxf') ;
writeln(ff,'S 1');
writeln(ff,'Codice   ');
close(ff);
creaBlocco(nomebl,nomebl,'TIPO',Codice,'L',l,'H',h,'','','','','','','','');
end;

Procedure ScriptGestrete(Modello,Comando,Tiporete,piano,codice,l,nc,tc:string);
Var ff:textfile;
begin
piano:='RETE';
assign(ff,percorsodrive+'\'+comando+'.scr');
rewrite(ff);
writeln(ff,'Layer '+Slayer);
writeln(ff,Piano);
writeln(ff,'');
//writeln(ff,'insert '+Comando+'§'+Modello+'§'+Tiporete+'§'+Pul(codice)+'§'+Pul(L)+'§'+Pul(nc)+'§'+Pul(Tc)+'§§.dxf');
writeln(ff,'insert '+Modello+indblocco+'.dxf');
writeln(ff,'S 1');
close(ff);
//creaBlocco(Modello,comando+'§'+Modello,'TIPORETE',Tiporete,'CODICE',Codice,'L',l,'NC',NC,'TC',TC,'','','','');
creaBlocco(Modello,Modello,'TIPORETE',Tiporete,'CODICE',Codice,'L',l,'NC',NC,'TC',TC,'','','','');
end;


Procedure ScriptPonte(piano,codice,l:string);
Var ff:textfile;
begin
assign(ff,percorsodrive+'\POnte.scr');
rewrite(ff);
writeln(ff,'_Layer '+Slayer);
writeln(ff,Piano);
writeln(ff,'');
//writeln(ff,'_insert Pon§'+Pul(codice)+'§'+Pul(L)+'§§§§§.dxf');
writeln(ff,'_insert Pon'+indblocco+'.dxf');
writeln(ff,'S 1');
writeln(ff,'R 0');
close(ff);
creaBlocco('Pon','Pon','COD',Codice,'L',l,'','','','','','','','','','');
end;

Procedure ScriptLocale(Descr,piano,zona,imp,tpav,cpav,tsof,csof,CalcoloT,TIPOBXSCELTO:string;Alt,Tinv,Test,Fconv,Ricaria,Appgra:real);
Var ff:textfile;
    NomeBl:string;
begin
NomeBl:='Loc';
if uppercase(imp)='NESSUNO' then NomeBl:='LocNR';
Piano:='EDIFICIO';
assign(ff,percorsodrive+'\Locale.scr');
rewrite(ff);
writeln(ff,'_Layer '+Slayer);
writeln(ff,Piano);
writeln(ff,'');
//writeln(ff,'insert '+percorsodrive+'\amb.dwg');
//writeln(ff,'_insert loc§'+pul(zona)+'§'+pul(imp)+'§'+pul(tsof)+'§'+pul(csof)+'§'+pul(tpav)+'§'+pul(cpav)+'§'+pul(descr)+'.dxf');
writeln(ff,'_insert '+nomebl+indblocco+'.dxf');
writeln(ff,'S 1');
writeln(ff,'R 0');
//writeln(ff,'');
//writeln(ff,'R 0');
//writeln(ff,'filedia 0');
//writeln(ff,'script locale');
close(ff);
if NomeBl='LocNR' then
creaBlocco16(NomeBl,NomeBl,'ZONA',Zona,'IMP',imp,'TSOF',Tsof,'CSOF',Csof,'TPAV',Tpav,'CPAV',Cpav,'DESCR',Descr,'ALTEZZA',float_to_Str(alt,2),'TINV',float_to_Str(TInv,2),'TEST',float_to_Str(TEst,2),'TINV',float_to_Str(TInv,2),'RICARIA',float_to_Str(RICARIA,2),'APPGRA',float_to_Str(APPGRA,2),'FCONV',float_to_Str(FConv,4),'CALCT',CalcoloT,'TIPOBXSCELTO',TIPOBXSCELTO)
else creaBlocco(NomeBl,NomeBl,'ZONA',Zona,'IMP',imp,'TSOF',Tsof,'CSOF',Csof,'TPAV',Tpav,'CPAV',Cpav,'DESCR',Descr);
end;

Procedure ScriptTubo(Piano,colore,Tlinea:string);
Var ff:textfile;
begin
if uppercase(copy(colore,1,6))='COLORE' then colore:=copy(colore,8,length(colore)-7);
//with FPannelloclima do
  begin
  assign(ff,percorsodrive+'\Tratto.scr');
  rewrite(ff);
  writeln(ff,'_Color '+col(Colore));
  //writeln(ff,'-Color '+colore);
  writeln(ff,'_Layer '+Slayer);
  //writeln(ff,Piano+'_TUBI');
  writeln(ff,'RETE');
  writeln(ff,'');
  writeln(ff,'_Linetype _S '+Tlinea+' ');
  writeln(ff,'_Line');
  close(ff);
  end;
end;

Procedure ScriptTerminale(piano,simb,att,incr,lmax,Port,potenza,perd,montaggio,serie,fissaserie,modello,fissamodello:string);
Var ff:textfile;
begin
if (att='')or(simb='') then exit;
if att<>'' then att:=att[1];
assign(ff,i_sl(percorsodrive)+'Terminale.scr');
rewrite(ff);
writeln(ff,'_Layer '+Slayer);
//writeln(ff,Piano+'_TUBISIMB');
writeln(ff,'RETE');
writeln(ff,'');
//writeln(ff,'_insert term'+simb+att+'§'+pul(incr)+'§'+pul(lmax)+'§'+pul(port)+'§'+pul(potenza)+'§'+pul(perd)+'§'+pul(montaggio)+'§'+pul(serie)+'§'+pul(fissaserie)+'§'+pul(modello)+'§'+pul(fissamodello)+'.dxf');
writeln(ff,'_insert term'+simb+att+indblocco+'.dxf');
writeln(ff,'S 1');
close(ff);
creaBlocco10('TERM'+Simb+ATT,'TERM'+Simb+ATT,'INCR',incr,'LMAX',lmax,'PORT',POrt,'POTENZA',POtenza,'PERD',Perd,'MONTAGGIO',Montaggio,'SERIE',serie,'FISSASERIE',fissaserie,'MODELLO',modello,'FISSAMODELLO',fissamodello);
end;


Procedure ScriptValvola(simb,codperd:string);
Var ff:textfile;
const piano='Rete';
begin
assign(ff,percorsodrive+'\Componente.scr');
rewrite(ff);
writeln(ff,'Layer '+Slayer);
writeln(ff,Piano+'_TUBISIMB');
writeln(ff,'');
writeln(ff,'insert VAL§'+simb+'§'+pul(codperd)+'§§§§§.dxf');
writeln(ff,'S 1');
close(ff);
creaBlocco(Simb,'VAL'+'§'+Simb,'PERDITA',codperd,'','','','','','','','','','','','');
end;


Procedure ScriptCollettore(piano,usc,att,colore:string);
Var ff,fo:textfile;
    buf:string;
    inizio:boolean;
begin
if strtoint(usc)<=5 then usc:='5'
else usc:='8';
att:='S';
assign(ff,percorsodrive+'\Collettore.scr');
rewrite(ff);
writeln(ff,'-Color '+colore);
writeln(ff,'Layer '+Slayer);
writeln(ff,'RETE');
writeln(ff,'');
//writeln(ff,'Snap 0.1');
//writeln(ff,'Snap ON');
//writeln(ff,'griglia snap');
//writeln(ff,'griglia ON');
writeln(ff,'_insert *Colle'+USC+att+'.dxf');
//writeln(ff,'1');
close(ff);
{
assign(ff,percorsodrive+'\H_Colle'+usc+att+'.dxf');
assign(fo,percorsodrive+'\Colle'+USC+att+'.dxf');
reset(ff);
rewrite(fo);
inizio:=false;
while not eof(ff) do
  begin
  readln(ff,buf);
  if not (inizio) then
    begin
    inizio:=uppercase(buf)='ENTITIES';
    writeln(fo,buf);
    end
  else
    begin
    if buf='COLLE' then writeln(fo,'RETE')
    else
    if buf='DISCOLLE' then writeln(fo,'RETE')
    else
    if buf=' 62' then
      begin
      writeln(fo,buf);
      readln(ff,buf);
      if buf='     1'then
      buf:=colore;
      writeln(fo,buf);
      end
    else writeln(fo,buf);
    end;
  end;
close(ff);
close(fo);
}
end;


//Const numpiani=2;
{
Procedure ScriptEdifOn;
Var ff:textfile;
    buf:string;
    var i:integer;
begin
assign(ff,percorsodrive+'\edifon.scr');
rewrite(ff);
writeln(ff,'Layer '+Slayer);
writeln(ff,'0');
for i:=1 to numpiani do
  begin
  writeln(ff,'ON');
  writeln(ff,'P'+inttostr(i));
  end;
writeln(ff,'');
close(ff);
end;

Procedure ScriptEdifOFF;
Var ff:textfile;
    buf:string;
    var i:integer;
begin
assign(ff,percorsodrive+'\edifOFF.scr');
rewrite(ff);
writeln(ff,'Layer '+Slayer);
writeln(ff,'0');
for i:=1 to numpiani do
  begin
  writeln(ff,'OFF');
  writeln(ff,'P'+inttostr(i));
  end;
writeln(ff,'');
close(ff);
end;

Procedure ScriptTUBIOFF;
Var ff:textfile;
    buf:string;
    var i:integer;
begin
assign(ff,percorsodrive+'\TUBIOFF.scr');
rewrite(ff);
writeln(ff,'Layer '+Slayer);
writeln(ff,'0');
for i:=1 to numpiani do
  begin
  writeln(ff,'OFF');
  writeln(ff,'P'+inttostr(i)+'_TUBI,'+'P'+inttostr(i)+'_TUBISIMB,'+'P'+inttostr(i)+'_RITORNO,'+'P'+inttostr(i)+'_QUOTE,'
  +'P'+inttostr(i)+'_COLLE,'+'P'+inttostr(i)+'_TUBICOL');
  end;
writeln(ff,'');
close(ff);
end;

Procedure ScriptDISTUBION;
Var ff:textfile;
    buf:string;
    var i:integer;
begin
assign(ff,percorsodrive+'\DISTUBION.scr');
rewrite(ff);
writeln(ff,'Layer '+Slayer);
writeln(ff,'0');
for i:=1 to numpiani do
  begin
  writeln(ff,'OFF');
  writeln(ff,'P'+inttostr(i)+'_TUBI,'+'P'+inttostr(i)+'_TUBISIMB,'+'P'+inttostr(i)+'_RITORNO,'+'P'+inttostr(i)+'_QUOTE,'
  +'P'+inttostr(i)+'_COLLE,'+'P'+inttostr(i)+'_TUBICOL');

  writeln(ff,'ON');
  writeln(ff,'P'+inttostr(i)+'_TUBISIMB,'+'P'+inttostr(i)+'_RITORNO,'+'P'+inttostr(i)+'_QUOTE,'
  +'P'+inttostr(i)+'_COLLE');

  end;
writeln(ff,'');
close(ff);
end;

Procedure ScriptINPTUBION;
Var ff:textfile;
    buf:string;
    var i:integer;
begin
assign(ff,percorsodrive+'\INPTUBION.scr');
rewrite(ff);
writeln(ff,'Layer '+Slayer);
writeln(ff,'0');
for i:=1 to numpiani do
  begin
  writeln(ff,'OFF');
  writeln(ff,'P'+inttostr(i)+'_TUBI,'+'P'+inttostr(i)+'_TUBISIMB,'+'P'+inttostr(i)+'_RITORNO,'+'P'+inttostr(i)+'_QUOTE,'
  +'P'+inttostr(i)+'_COLLE,'+'P'+inttostr(i)+'_TUBICOL');

  writeln(ff,'ON');
  writeln(ff,'P'+inttostr(i)+'_TUBI,'+'P'+inttostr(i)+'_TUBISIMB,'+'P'+inttostr(i)+'_QUOTE,'
  +'P'+inttostr(i)+'_TUBICOL,'+'P'+inttostr(i)+'_COLLE');

  end;
writeln(ff,'');
close(ff);
end;

}
Procedure ScriptNord(piano:string);
Var ff:textfile;
begin
assign(ff,percorsodrive+'\Nord.scr');
rewrite(ff);
writeln(ff,'Layer '+Slayer);
writeln(ff,Piano);
writeln(ff,'');
writeln(ff,'insert nord');
writeln(ff,'S 1');
close(ff);
end;

Procedure ScriptAllinea(piano:string);
Var ff:textfile;
begin
assign(ff,percorsodrive+'\allinea.scr');
rewrite(ff);
writeln(ff,'Layer '+Slayer);
writeln(ff,Piano);
writeln(ff,'');
writeln(ff,'_insert allinea.dwg');
writeln(ff,'S 1');
writeln(ff,'R 0');
close(ff);
end;

Procedure ScriptPianta(piano:string);
Var ff:textfile;
begin
assign(ff,percorsodrive+'\Pianta.scr');
rewrite(ff);
writeln(ff,'Layer '+Slayer);
writeln(ff,Piano);
writeln(ff,'');
writeln(ff,'_Xattach 0,0');
writeln(ff,'Zoom E');
writeln(ff,'_ai_selall');
writeln(ff,'draworder _b');
close(ff);
end;
Procedure ScriptSalvaChiudi;
Var ff:textfile;
begin
assign(ff,percorsodrive+'\salvachiudi.scr');
rewrite(ff);
writeln(ff,'filedia 0');
writeln(ff,'_saveas');
writeln(ff,'DXF');
writeln(ff,'V');
writeln(ff,'r12');
writeln(ff,'');
writeln(ff,'');
writeln(ff,ssi);
//writeln(ff,'_close');
//writeln(ff,sno);
writeln(ff,'-vbarun CloseVba');
writeln(ff,'_quit');
close(ff);
{
writeln(ff,'_close');
writeln(ff,'_saveas');
writeln(ff,'2000');
writeln(ff,'');
writeln(ff,ssi);
writeln(ff,'Filedia 1');
close(ff);
}
end;

Procedure ScriptSalva;
Var ff:textfile;
begin
scriptsalvachiudi;
assign(ff,percorsodrive+'\salva.scr');
rewrite(ff);
writeln(ff,'filedia 0');
writeln(ff,'_saveas');
writeln(ff,'DXF');
writeln(ff,'V');
writeln(ff,'r12');
writeln(ff,'');
writeln(ff,'');
writeln(ff,ssi);
close(ff);
assign(ff,percorsodrive+'\ritorna.scr');
rewrite(ff);
writeln(ff,'filedia 0');
writeln(ff,'_saveas');
writeln(ff,'DXF');
writeln(ff,'V');
writeln(ff,'r12');
writeln(ff,'');
writeln(ff,'');
writeln(ff,ssi);
writeln(ff,'_close');
close(ff);
end;


{ TODO -oDiego -cNavigazione : Script ProjectBrowser }
Procedure ScriptProjectBRS;
Var ff:textfile;
begin
assign(ff,percorsodrive+'\ProjectBRS.scr');
rewrite(ff);
writeln(ff,'filedia 0');
writeln(ff,'_saveas');
writeln(ff,'DXF');
writeln(ff,'V');
writeln(ff,'r12');
writeln(ff,'');
writeln(ff,'');
writeln(ff,ssi);
writeln(ff,'_saveas');
writeln(ff,'2000');
writeln(ff,'');
writeln(ff,ssi);
writeln(ff,'Filedia 1');
writeln(ff,'_open');
writeln(ff,'"'+percorsodrive+'\Projectbrowser.DWG"');
close(ff);
end;

Procedure Scriptriprendi;
Var ff:textfile;
begin
assign(ff,i_sl(percorsodrive)+'riprendi.scr');
rewrite(ff);
writeln(ff,'filedia 0');
writeln(ff,'_saveas');
writeln(ff,'2000');
writeln(ff,'"'+i_sl(percorsodrive)+'p.dwg"');
writeln(ff,ssi);
//writeln(ff,'_save');
//writeln(ff,'');
//writeln(ff,ssi);
writeln(ff,'_close');
writeln(ff,'_open');
{$Ifdef acadVba}
writeln(ff,'"'+Disegnocorrente+'"');
{$else}
writeln(ff,'"'+i_sl(percorsodrive)+'disegno.DXF"');
{$Endif}
writeln(ff,'_saveas');
writeln(ff,'2000');
writeln(ff,'');
writeln(ff,ssi);
writeln(ff,'Filedia 1');
writeln(ff,'_zoom E');
//writeln(ff,'script goloop');
close(ff);
end;
Procedure Script_CadInterno(nomescr:string);
Var ff:textfile;
begin
assign(ff,percorsodrive+'\'+nomescr+'.scr');
rewrite(ff);
writeln(ff,'filedia 0');
writeln(ff,'_save');
writeln(ff,'');
writeln(ff,ssi);
writeln(ff,'_close');
writeln(ff,'_open');
writeln(ff,'"'+i_sl(percorsodrive)+'Hello Autocad.dwg"');
writeln(ff,'Filedia 1');
close(ff);
end;
Procedure ScriptCadInterno;
begin
Script_CadInterno('Aggiorna');
Script_CadInterno('Parete');
Script_CadInterno('Finestra');
Script_CadInterno('Locale');
Script_CadInterno('Ponte');
end;



Procedure ScriptNuovo;
Var ff:textfile;
begin
assign(ff,percorsodrive+'\Nuovo.scr');
rewrite(ff);
writeln(ff,'filedia 0');
writeln(ff,'_wmfout');
writeln(ff,'');
writeln(ff,'T');
writeln(ff,'');

//esegue il salvataggio per evitare la domanda

writeln(ff,'_save');

writeln(ff,'Filedia 1');
writeln(ff,'esci');
close(ff);
end;

Procedure ScriptLoop;
Var ff:textfile;
begin
assign(ff,percorsodrive+'\Loop.scr');
rewrite(ff);
writeln(ff,'script loop');
close(ff);
end;

Procedure Scriptapri;
Var ff:textfile;
begin
assign(ff,percorsodrive+'\Apri.scr');
rewrite(ff);
writeln(ff,'filedia 0');
writeln(ff,'_PSOUT');
writeln(ff,'');
writeln(ff,'E');
writeln(ff,'');
writeln(ff,'Filedia 1');
close(ff);
end;

Procedure ScriptapriDiscor;
Var ff:textfile;
begin
assign(ff,i_sl(percorsodrive)+'ApriDisCor.scr');
rewrite(ff);
writeln(ff,'filedia 0');
writeln(ff,'_open');
writeln(ff,'"'+i_sl(percorsodrive)+'disegno.DXF"');
writeln(ff,'_Zoom');
writeln(ff,'E');
writeln(ff,'Filedia 1');
close(ff);
end;

Procedure ScriptStopLoop;
Var ff:textfile;
begin
assign(ff,percorsodrive+'\Loop.scr');
rewrite(ff);
writeln(ff,'script aggiorna');
close(ff);
end;


Procedure ScriptComando(comando:string;chiudidis:boolean);
Var ff:textfile;
begin
assign(ff,I_sl(percorsodrive)+comando+'.scr');
rewrite(ff);
writeln(ff,'filedia 0');
writeln(ff,'_saveas');
writeln(ff,'DXF');
writeln(ff,'V');
writeln(ff,'r12');
writeln(ff,'');
//writeln(ff,'"'+i_sl(percorsodrive)+comando+'.DXF"');
writeln(ff,'"'+comando+'.DXF"');
writeln(ff,ssi);
if uppercase(comando)='ESCI' then
writeln(ff,'_quit')
else
if chiudidis then writeln(ff,'_Close');
{
writeln(ff,'_saveas');
writeln(ff,'DXF');
writeln(ff,'V');
writeln(ff,'r12');
writeln(ff,'');
writeln(ff,'"'+disegnocorrente+'"');
writeln(ff,ssi);
writeln(ff,'Filedia 1');
}
close(ff);

end;
Procedure ScriptCalcoli;
begin
//scriptcomando('Calcoli');
end;
Procedure ScriptInterfaccia;
Var i:integer;
begin
for i:=1 to Maxcomandi do
with data_com[i] do
scriptcomando(Nomecomando,chiudiD);
{
scriptcomando('Calcoli');
scriptcomando('Proprieta');
scriptcomando('Esci');
scriptcomando('Salvaprog');
scriptcomando('Apriprog');
scriptcomando('Salvanome');
}
end;

Procedure ScriptAggiorna;
Var ff:textfile;
begin
assign(ff,I_sl(percorsodrive)+'aggiorna.scr');
rewrite(ff);
writeln(ff,'filedia 0');
writeln(ff,'_open');
writeln(ff,'"'+i_sl(percorsodrive)+'disegno.DXF"');
writeln(ff,'Filedia 1');
//writeln(ff,'script goloop');
close(ff);
end;
{
begin
assign(ff,I_sl(percorsodrive)+'aggiorna.scr');
rewrite(ff);
writeln(ff,'filedia 0');
writeln(ff,'_saveas');
writeln(ff,'2000');
writeln(ff,'"'+I_sl(percorsodrive)+'p.dwg"');
writeln(ff,ssi);
//writeln(ff,'_save');
//writeln(ff,'');
//writeln(ff,ssi);
writeln(ff,'_close');
writeln(ff,'_open');
writeln(ff,'"'+i_sl(percorsodrive)+'disegno.DXF"');
writeln(ff,'_saveas');
writeln(ff,'2000');
writeln(ff,'');
writeln(ff,ssi);
writeln(ff,'Filedia 1');
//writeln(ff,'script goloop');
close(ff);
end;
}
Procedure ScriptIniziorete(piano:string);
Var ff:textfile;
begin
assign(ff,percorsodrive+'\Iniziorete.scr');
rewrite(ff);
writeln(ff,'Layer '+Slayer);
//writeln(ff,Piano+'_TUBISIMB');
writeln(ff,'RETE');
writeln(ff,'');
writeln(ff,'insert irete');
writeln(ff,'S 1');
close(ff);
end;


Procedure ScriptParete(Piano,colore,Tlinea:string);
Var ff:textfile;
begin
piano:='Edificio';
if uppercase(copy(colore,1,6))='COLORE' then colore:=copy(colore,8,length(colore)-7);
//with FPannelloclima do
  begin
  assign(ff,percorsodrive+'\parete.scr');
  rewrite(ff);
  writeln(ff,'elev 0 3');
  writeln(ff,'_Color '+col(Colore));
  writeln(ff,'_Layer '+Slayer);
  writeln(ff,Piano);
  writeln(ff,'');
  writeln(ff,'_Linetype _S '+tipolinea(Tlinea,2)+' ');
  writeln(ff,'_Line');
  close(ff);
  end;
end;

Procedure Save_conf;
Var Ft:Textfile;
begin
assignfile(ft,percorsodrive+'\Conf.txt');
rewrite(ft);
writeln(ft,PercAcad);
closefile(ft);
end;

Procedure Read_conf;
Var Ft:Textfile;
begin
if fileexists(percorsodrive+'\Conf.txt') then
  begin
  assignfile(ft,percorsodrive+'\Conf.txt');
  reset(ft);
  readln(ft,PercAcad);
  closefile(ft);
  end;
end;


Procedure Init_Cadesterno;
begin
acadok:=true;
percacad:='';
Read_conf;
Percorsodis:=PercorsoDrive;
estens:='dwg';
//scriptparete;
//scriptfinestra;
//scriptLocale;
end;

Procedure run_cadesterno;
begin
 //Eseguiautocad;
end;
Procedure CreaBlocco16(Nomemod,NomeBl,P1,V1,p2,V2,p3,v3,p4,v4,p5,v5,p6,v6,p7,v7,p8,v8,p9,v9,p10,v10,
                       p11,v11,p12,v12,p13,v13,p14,v14,p15,v15,p16,v16:string);
Var ftin,ftout:text;
    Buf,nomeout:string;
    trovato:boolean;
begin

P1:=formst('*'+P1+'*');
P2:=formst('*'+P2+'*');
P3:=formst('*'+P3+'*');
P4:=formst('*'+P4+'*');
P5:=formst('*'+P5+'*');
P6:=formst('*'+P6+'*');
P7:=formst('*'+P7+'*');
P8:=formst('*'+P8+'*');
P9:=formst('*'+P9+'*');
P10:=formst('*'+P10+'*');
P11:=formst('*'+P11+'*');
P12:=formst('*'+P12+'*');
P13:=formst('*'+P13+'*');
P14:=formst('*'+P14+'*');
P15:=formst('*'+P15+'*');
P16:=formst('*'+P16+'*');

if not fileexists(Percorsodrive+'\H_'+NomeMod+'.dxf') then
  begin
  //showmessage('Il modello del simbolo:'+Percorsodrive+'\H_'+NomeMod+'.dxf ,non esiste.');
  exit;
  end;
assign(ftin,Percorsodrive+'\H_'+NomeMod+'.dxf');
reset(ftin);
//if p8<>'**' then
//nomeout:=Percorsodrive+'\'+Nomebl+'§'+Pul(V1)+'§'+Pul(V2)+'§'+Pul(V3)+'§'+Pul(V4)+'§'+Pul(V5)+'§'+Pul(V6)+'§'+Pul(V7)+'§'+Pul(V8)+'§'+Pul(V9)+'§'+Pul(V10)+'.dxf'
//else
//nomeout:=Percorsodrive+'\'+Nomebl+'§'+Pul(V1)+'§'+Pul(V2)+'§'+Pul(V3)+'§'+Pul(V4)+'§'+Pul(V5)+'§'+Pul(V6)+'§'+Pul(V7)+'.dxf';
nomeout:=Percorsodrive+'\'+Nomebl+'§'+inttostr(countblocchi)+'.dxf';
assign(ftout,nomeout);
rewrite(ftout);
trovato:=false;
while not eof(ftin) do
  begin
  readln(ftin,buf);
  if buf='ENTITIES' then
  trovato:=true;
  IF trovato then
  if pos('*',buf)<>0 then
    begin
    if (P1<>'**')and(P1=formst(buf)) then buf:=V1
    else
    if (P2<>'**')and(P2=formst(buf)) then buf:=V2
    else
    if (P3<>'**')and(P3=formst(buf)) then buf:=V3
    else
    if (P4<>'**')and(P4=formst(buf)) then buf:=V4
    else
    if (P5<>'**')and(P5=formst(buf)) then buf:=V5
    else
    if (P6<>'**')and(P6=formst(buf)) then buf:=V6
    else
    if (P7<>'**')and(P7=formst(buf)) then buf:=V7
    else
    if (P8<>'**')and(P8=formst(buf)) then buf:=V8
    else
    if (P9<>'**')and(P9=formst(buf)) then buf:=V9
    else
    if (P10<>'**')and(P10=formst(buf)) then buf:=V10
    else
    if (P11<>'**')and(P11=formst(buf)) then buf:=V11
    else
    if (P12<>'**')and(P12=formst(buf)) then buf:=V12
    else
    if (P13<>'**')and(P13=formst(buf)) then buf:=V13
    else
    if (P14<>'**')and(P14=formst(buf)) then buf:=V14
    else
    if (P15<>'**')and(P15=formst(buf)) then buf:=V15
    else
    if (P16<>'**')and(P15=formst(buf)) then buf:=V16;
    end;
  writeln(ftout,buf);
  end;
close(ftin);
close(ftout);
end;
Procedure CreaBlocco10(Nomemod,NomeBl,P1,V1,p2,V2,p3,v3,p4,v4,p5,v5,p6,v6,p7,v7,p8,v8,p9,v9,p10,v10:string);
begin
CreaBlocco16(Nomemod,NomeBl,P1,V1,p2,V2,p3,v3,p4,v4,p5,v5,p6,v6,p7,v7,p8,v8,p9,v9,p10,v10,'','','','','','','','','','','','');
end;
Procedure CreaBlocco(Nomemod,NomeBl,P1,V1,p2,V2,p3,v3,p4,v4,p5,v5,p6,v6,p7,v7:string);
begin
CreaBlocco10(Nomemod,NomeBl,P1,V1,p2,V2,p3,v3,p4,v4,p5,v5,p6,v6,p7,v7,'','','','','','');
end;
{
Procedure copiaprototipo;
Var ff,fo:textfile;
    buf,bufprec:string;
    i:integer;
procedure scrivipiano(nomep:string);
begin
writeln(fo,'  2');
writeln(fo,nomeP);
writeln(fo,' 70');
writeln(fo,'     0');
writeln(fo,' 62');
writeln(fo,'     7');
writeln(fo,'  6');
writeln(fo,'CONTINUOUS');
writeln(fo,'  0'); // serviranno per il layer successivo
writeln(fo,'LAYER');
end;
begin

assign(ff,percorsodrive+'\prototipo.dxf');
assign(fo,percorsodrive+'\disegno.dxf');
reset(ff);
rewrite(fo);
buf:='';
bufprec:='';
while (not(eof(ff)))and((buf<>'LAYER')or(bufprec<>'  0')) do
  begin
  bufprec:=buf;
  readln(ff,buf);
  writeln(fo,buf)
  end;
if not(eof(ff) )then
  begin
  for i:=1 to numpiani do
    begin
    scrivipiano('P'+inttostr(i));
    scrivipiano('P'+inttostr(i)+'_TUBI');
    scrivipiano('P'+inttostr(i)+'_TUBISIMB');
    scrivipiano('P'+inttostr(i)+'_TUBICOL');
    scrivipiano('P'+inttostr(i)+'_RITORNO');
    scrivipiano('P'+inttostr(i)+'_COLLE');
    scrivipiano('P'+inttostr(i)+'_QUOTE');
    end;
  while (not(eof(ff))) do
    begin
    readln(ff,buf);
    writeln(fo,buf)
    end;
  end;
close(ff);
close(fo);
end;
}
end.
