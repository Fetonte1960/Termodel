unit UGest_cad;

interface
uses sysutils,windows,dialogs,libreriagenerale,HeaderDllTermico; //cadparete;

Var acadok:boolean;
    Percacad,percorsodis,estens:string;

Procedure ScriptApri;
Procedure ScriptLoop;
Procedure ScriptCalcoli;
Procedure ScriptStopLoop;
Procedure ScriptParete(Piano,colore,Tlinea:string);
Procedure ScriptTubo(Piano,colore,Tlinea:string);
Procedure ScriptLocale(piano,zona,imp,tpav,cpav,tsof,csof:string);
Procedure ScriptFinestra(piano,codice,l,h:string);
Procedure ScriptPonte(piano,codice,l:string);
Procedure ScriptTerminale(piano,simb,att,incr,lmax,Port,potenza,perd,montaggio:string);
Procedure ScriptIniziorete(piano:string);
Procedure ScriptNord(piano:string);
Procedure ScriptPianta(piano:string);
Procedure ScriptValvola(piano,simb,codperd:string);
Procedure Init_Cadesterno;
Procedure run_cadesterno;
Procedure Save_conf;
Procedure eseguiautocad;
Procedure CreaBlocco(Nomemod,NomeBl,P1,V1,p2,V2,p3,v3,p4,v4,p5,v5,p6,v6:string);
Procedure ScriptSalva;
Procedure ScriptAggiorna;
Procedure ScriptGestrete(Modello,Comando,Tiporete,piano,codice,l,nc,tc:string);
Procedure ScriptCollettore(piano,usc,att,colore:string);
Procedure ScriptEdifOn;
Procedure ScriptEdifOFF;
Procedure ScriptTUBIOFF;
Procedure ScriptDISTUBION;
Procedure ScriptINPTUBION;
Procedure copiaprototipo;
Procedure ScriptAllinea(piano:string);
Procedure puliscifile;
Procedure ScriptNuovo;

const
{$Ifdef acadltIta}
Slayer='R';
SSi='S';
{$Endif}
{$Ifdef acadeng}
Slayer='S';
SSi='Y';
{$Endif}

implementation
uses Cpi_Win_CLIMA_CadLT;

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
if Valore[i] In [' ','_','.',','] then result:=result+'%'
else result:=result+Valore[i];
end;

Procedure eseguiautocad;
Var ret:integer;
    Opendialog:Topendialog;
begin

if not acadok then exit;
//if acadok then FSuite.autocad.run;
if fileexists(Percacad{+'acad.exe'}) then
  begin
  ret:=winexec(Pchar(Percacad+{acad.exe}' "'+PercorsoDis+'\disegno.'+estens+'"'),SW_MAXIMIZE);
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
    ret:=winexec(Pchar(Percacad+{acad.exe}' "'+PercorsoDis+'\disegno.'+estens+'"'),SW_MAXIMIZE);
    end
  else acadok:=false;
  opendiaLOG.Free;
  end;
end;

Function TipoLinea(tl:string;campo:integer):string;
begin
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

Procedure ScriptFinestra(piano,codice,l,h:string);
Var ff:textfile;
begin
assign(ff,percorsodrive+'\finestra.scr');
rewrite(ff);
writeln(ff,'Layer '+Slayer);
writeln(ff,Piano);
writeln(ff,'');
writeln(ff,'insert fin§'+Pul(codice)+'§'+Pul(L)+'§'+Pul(H)+'§§§.dxf');
writeln(ff,'S 1');
writeln(ff,'Codice   ');
close(ff);
creaBlocco('Fin','Fin','TIPO',Codice,'L',l,'H',h,'','','','','','');
end;

Procedure ScriptGestrete(Modello,Comando,Tiporete,piano,codice,l,nc,tc:string);
Var ff:textfile;
begin
assign(ff,percorsodrive+'\'+comando+'.scr');
rewrite(ff);
writeln(ff,'Layer '+Slayer);
writeln(ff,Piano);
writeln(ff,'');
writeln(ff,'insert '+Comando+'§'+Modello+'§'+Tiporete+'§'+Pul(codice)+'§'+Pul(L)+'§'+Pul(nc)+'§'+Pul(Tc)+'§.dxf');
writeln(ff,'S 1');
close(ff);
creaBlocco(Modello,comando+'§'+Modello,'TIPORETE',Tiporete,'CODICE',Codice,'L',l,'NC',NC,'TC',TC,'','');
end;


Procedure ScriptPonte(piano,codice,l:string);
Var ff:textfile;
begin
assign(ff,percorsodrive+'\POnte.scr');
rewrite(ff);
writeln(ff,'Layer '+Slayer);
writeln(ff,Piano);
writeln(ff,'');
writeln(ff,'insert Pon§'+Pul(codice)+'§'+Pul(L)+'§§§§.dxf');
writeln(ff,'S 1');
writeln(ff,'R 0');
close(ff);
creaBlocco('Pon','Pon','COD',Codice,'L',l,'','','','','','','','');
end;


Procedure ScriptLocale(piano,zona,imp,tpav,cpav,tsof,csof:string);
Var ff:textfile;
begin
assign(ff,percorsodrive+'\Locale.scr');
rewrite(ff);
writeln(ff,'Layer '+Slayer);
writeln(ff,Piano);
writeln(ff,'');
//writeln(ff,'insert '+percorsodrive+'\amb.dwg');
writeln(ff,'insert loc§'+pul(zona)+'§'+pul(imp)+'§'+pul(tsof)+'§'+pul(csof)+'§'+pul(tpav)+'§'+pul(cpav)+'.dxf');
writeln(ff,'S 1');
writeln(ff,'R 0');
//writeln(ff,'');
//writeln(ff,'R 0');
//writeln(ff,'filedia 0');
//writeln(ff,'script locale');
close(ff);
creaBlocco('Loc','Loc','ZONA',Zona,'IMP',imp,'TSOF',Tsof,'CSOF',Csof,'TPAV',Tpav,'CPAV',Cpav);
end;

Procedure ScriptTubo(Piano,colore,Tlinea:string);
Var ff:textfile;
begin
if uppercase(copy(colore,1,6))='COLORE' then colore:=copy(colore,8,length(colore)-7);
//with FPannelloclima do
  begin
  assign(ff,percorsodrive+'\Tubo.scr');
  rewrite(ff);
  writeln(ff,'-Color '+col(Colore));
  //writeln(ff,'-Color '+colore);
  writeln(ff,'Layer '+Slayer);
  writeln(ff,Piano+'_TUBI');
  writeln(ff,'');
  writeln(ff,'Line');
  close(ff);
  end;
end;

Procedure ScriptTerminale(piano,simb,att,incr,lmax,Port,potenza,perd,montaggio:string);
Var ff:textfile;
begin
assign(ff,percorsodrive+'\Terminale.scr');
rewrite(ff);
writeln(ff,'Layer '+Slayer);
writeln(ff,Piano+'_TUBISIMB');
writeln(ff,'');
writeln(ff,'insert rad§'+simb+att+'§'+pul(incr)+'§'+pul(lmax)+'§'+pul(port)+'§'+pul(potenza)+'§'+pul(perd)+'§'+pul(montaggio)+'.dxf');
writeln(ff,'S 1');
close(ff);
creaBlocco(Simb+ATT,'RAD'+'§'+Simb+ATT,'INCR',incr,'LMAX',lmax,'PORT',POrt,'POTENZA',POtenza,'PERD',Perd,'MONTAGGIO',Montaggio);

end;


Procedure ScriptValvola(piano,simb,codperd:string);
Var ff:textfile;
begin
assign(ff,percorsodrive+'\Valvola.scr');
rewrite(ff);
writeln(ff,'Layer '+Slayer);
writeln(ff,Piano+'_TUBISIMB');
writeln(ff,'');
writeln(ff,'insert VAL§'+simb+'§'+pul(codperd)+'§§§§§.dxf');
writeln(ff,'S 1');
close(ff);
creaBlocco(Simb,'VAL'+'§'+Simb,'PERDITA',codperd,'','','','','','','','','','');
end;


Procedure ScriptCollettore(piano,usc,att,colore:string);
Var ff,fo:textfile;
    buf:string;
begin
assign(ff,percorsodrive+'\Collettore.scr');
rewrite(ff);
writeln(ff,'-Color '+colore);
writeln(ff,'Layer '+Slayer);
writeln(ff,Piano+'_TUBI');
writeln(ff,'');
writeln(ff,'Snap 0.1');
writeln(ff,'Snap ON');
writeln(ff,'griglia snap');
writeln(ff,'griglia ON');
writeln(ff,'insert *Colle'+USC+att+'.dxf');
//writeln(ff,'1');
close(ff);
assign(ff,percorsodrive+'\H_Colle'+usc+att+'.dxf');
assign(fo,percorsodrive+'\Colle'+USC+att+'.dxf');
reset(ff);
rewrite(fo);
while not eof(ff) do
  begin
  readln(ff,buf);
  if buf='COLLE' then writeln(fo,Piano+'_TUBICOL')
  else
  if buf='DISCOLLE' then writeln(fo,Piano+'_COLLE')
  else
  if buf=' 62' then
    begin
    writeln(fo,buf);
    readln(ff,buf);
    if buf='     3'then buf:=colore;
    writeln(fo,buf);
    end
  else writeln(fo,buf);
  end;
close(ff);
close(fo);
end;

//Const numpiani=2;

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
writeln(ff,'insert allinea');
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
Procedure ScriptSalva;
Var ff:textfile;
begin
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
writeln(ff,'_saveas');
writeln(ff,'2000');
writeln(ff,'');
writeln(ff,ssi);
writeln(ff,'Filedia 1');
close(ff);
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


Procedure ScriptStopLoop;
Var ff:textfile;
begin
assign(ff,percorsodrive+'\Loop.scr');
rewrite(ff);
writeln(ff,'script aggiorna');
close(ff);
end;


Procedure ScriptCalcoli;
Var ff:textfile;
begin
assign(ff,percorsodrive+'\Calcoli.scr');
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

writeln(ff,'_bmpout');
writeln(ff,'');
writeln(ff,'T');
writeln(ff,'');
writeln(ff,'Filedia 1');
close(ff);
end;

Procedure ScriptAggiorna;
Var ff:textfile;
begin
assign(ff,percorsodrive+'\aggiorna.scr');
rewrite(ff);
writeln(ff,'filedia 0');
writeln(ff,'_saveas');
writeln(ff,'2000');
writeln(ff,'"'+percorsodrive+'\p.dwg"');
writeln(ff,ssi);
//writeln(ff,'_save');
//writeln(ff,'');
//writeln(ff,ssi);
writeln(ff,'_close');
writeln(ff,'_open');
writeln(ff,'"'+percorsodrive+'\disegno.DXF"');
writeln(ff,'_saveas');
writeln(ff,'2000');
writeln(ff,'');
writeln(ff,ssi);
writeln(ff,'Filedia 1');
//writeln(ff,'script goloop');
close(ff);
end;

Procedure ScriptIniziorete(piano:string);
Var ff:textfile;
begin
assign(ff,percorsodrive+'\Iniziorete.scr');
rewrite(ff);
writeln(ff,'Layer '+Slayer);
writeln(ff,Piano+'_TUBISIMB');
writeln(ff,'');
writeln(ff,'insert irete');
writeln(ff,'S 1');
close(ff);
end;


Procedure ScriptParete(Piano,colore,Tlinea:string);
Var ff:textfile;
begin
if uppercase(copy(colore,1,6))='COLORE' then colore:=copy(colore,8,length(colore)-7);
//with FPannelloclima do
  begin
  assign(ff,percorsodrive+'\parete.scr');
  rewrite(ff);
  writeln(ff,'elev 0 3');
  writeln(ff,'-Color '+col(Colore));
  writeln(ff,'Layer '+Slayer);
  writeln(ff,Piano);
  writeln(ff,'');
  writeln(ff,'-Linetype S '+tipolinea(Tlinea,2)+' ');
  writeln(ff,'Line');
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
Procedure CreaBlocco(Nomemod,NomeBl,P1,V1,p2,V2,p3,v3,p4,v4,p5,v5,p6,v6:string);
Var ftin,ftout:text;
    Buf:string;
begin
P1:=formst('*'+P1+'*');
P2:=formst('*'+P2+'*');
P3:=formst('*'+P3+'*');
P4:=formst('*'+P4+'*');
P5:=formst('*'+P5+'*');
P6:=formst('*'+P6+'*');
assign(ftin,Percorsodrive+'\H_'+NomeMod+'.dxf');
reset(ftin);
assign(ftout,Percorsodrive+'\'+Nomebl+'§'+Pul(V1)+'§'+Pul(V2)+'§'+Pul(V3)+'§'+Pul(V4)+'§'+Pul(V5)+'§'+Pul(V6)+'.dxf');
rewrite(ftout);
while not eof(ftin) do
  begin
  readln(ftin,buf);
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
  if (P6<>'**')and(P6=formst(buf)) then buf:=V6;

  writeln(ftout,buf);
  end;
close(ftin);
close(ftout);
end;
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

end.
