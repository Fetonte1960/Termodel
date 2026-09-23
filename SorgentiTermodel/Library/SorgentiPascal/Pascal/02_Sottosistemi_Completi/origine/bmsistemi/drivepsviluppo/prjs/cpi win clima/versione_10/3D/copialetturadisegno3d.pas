unit CopiaLetturadisegno3d;

interface
uses Varcarichi,UvariabiliLettura,copiaVariabiliGenerali,proceduregrafiche,
     Libreriagenerale,sysutils,LetturaDisegnoBidimensionale,grafica2d{,interfdxf},
     dxf_In_out,dbtables,db,UDataoutT,udbt,gestudb,udatalink,CopiaCaricatabelle,progress3d,log,
     dialogs,windows,gestione_dati,angoli,ULeggiscrividati;

procedure CaricaInput(nomepiano : string;var interrompi :boolean);
Procedure Leggidisegni(percorso:string;Rinumera:boolean);
Procedure Apripiano(I_O:Boolean;nomep:string);
Procedure Caricalistapiante;
Procedure Caricalistapiante_1(Nomefile:string);
Procedure Analisi_disegno;
procedure CaricaInputDXF(leggiarchivi,leggient,scriviarchivi:boolean);
Procedure Salvapiano_precedente(salvacomunque:boolean);
Procedure Salvapiano(nomep:string;salvain,rinumera:boolean);
Procedure Salva_piano(nomep,Nomerete:string;salvain,salvarete:boolean);
Procedure Leggi_archivi_lettura(leggient:boolean);
Procedure salva_archivi_lettura;
Procedure CMinx(vv:real);
Procedure CMinY(vv:real);
Procedure AzzeraPiano;
Procedure Spostadisegno(dx,dy:real);
Function VOl_tot_amb:real;
function NuovoNPA(PIano,codblocco:string;Xbl,Ybl:real;Var IndA:integer):integer;
Procedure Cambia_descr_amb(codamb,Descr:string);
Procedure spostaorigine;
Procedure RiPristinaorigine;
Procedure Leggi_contorni_edificio_pannelli(NomePiano:string);
Procedure Init_disegno_pannelli;
Procedure Add_disegno_pannelli(x0l,y0l,x1l,y1l:real);
Procedure Analisi_disegno_pannelli(Piano_loc:string;controlla:boolean;Var errore_pan:string;Var eex,eey:real);
Procedure Init_punt_lettura;
Procedure controlla_vuoti;
Procedure dxfdebug;


//Procedure OrientaFinestre;

//function NuovoNPA(PIano,codblocco:string;Xbl,Ybl:real):integer;


Procedure InitNumvet;

var     NBlocchi,UltBlocco,{UltFt,}ultblocco1,indpcor: integer;
        MinimoX,minimoy:real;
        POsOrigX,POsOrigY:real;
        POsOrigX1,POsOrigY1:real;
        Piano_precedente:string='';
        rete_precedente:string='';
        TipoDisegno_precedente:(Nessuno,Edificio_input,Edificio_elaborato,Rete)=nessuno;
 const letturacorretta='LETTURA ESEGUITA CORRETTAMENTE';
 Var orienta_fin:boolean=false;
implementation
//uses tool_2d,uanalisiedificio;
uses U3dsd,init_cad3d,letturainmemoria,
 {$Ifdef tubi_14}
  Funz_reti;
 {$Else}
  Interf3D_reti;
 {$endif}
 { ......................... CaricaInputSD ............................. }

Procedure controlla_vuoti;
Var count,i:integer;
     fdbloc:textfile;
begin
//assign(fdbloc,I_sl(percorsodrive)+'debugbloc.txt');
//rewrite(fdbloc);
count:=0;
for i:=1 to Nambienti do
with ambienti_d^[i]^ do
  begin
  //writeln(fdbloc,inttostr(i)+' : '+codnum+' : '+Denom);
  if codnum='' then inc(count);
  end;
if count<>0 then showmessage(inttostr(count)+ 'locali senza numerazione');
//close(fdbloc);
end;

FUNCTION UnicoAmbiente:BOOLEAN;
var j,i:integer;
begin
  j:=0;
  for i:=1 to nblocchi do
  if (bll^[i].nome='AMB')  or (copy(bll^[i].nome,1,3)='NCA') then inc(j);
  result:=j=1;
end;
{
Procedure OrientaFinestre;
Var i,j:integer;
    dir,dirz:real;
begin
for i:=1 to Ultblocco do
with bll^[i] do
if Nome='FIN' then
  begin
  with Ft^[ambienti] do
  calc_d(x0,y0,z0,x1,y1,z1,dir,dirz);
  if dir>pi then dir:=dir-pi;
  angolo:=ang_acad(dir);
  end;
end;
}
Procedure Azzerafrontiere;
 var i:integer;
 begin
 for i:= 1 to MaxFrontiere1 do
 with Ft^[i] do
   begin
   x0:=0;
   Y0:=0;
   Z0:=0;
   X1:=0;
   Y1:=0;
   z1:=0;
   error:=false;
   end;
 end;
 (*
 type Merr=record
              mess:string[250];
              ex,ey:real;
          end;
  *)
Procedure Apripiano(I_O:Boolean;nomep:string);
Var Flin:file of  FRONT;
    BufBy:front;
    Blin:file of  BLOCCHI;
    Elin:file of  Merr;
    buferr:merr;
    i:integer;
    elimina:boolean;
    est,eds:string;
begin
Caricadis_tubi;
set_finestra:=0;
MinimoX:=10E6;
MinimoY:=10E6;
erroreneldisegno:=letturacorretta;
est:='I';
if i_o then
  begin
  est:='G';//disegno di input;
  Piano_precedente:=NomeP;
  tipodisegno_precedente:=Edificio_input;
  end
else
  begin
  Piano_precedente:='';
  tipodisegno_precedente:=Edificio_elaborato;
  end;
if fileexists(percorsodrive+'\'+nomep+'.ig'+est) then
  begin
  assign(flin,I_sl(percorsodrive)+nomep+'.ig'+est);
  reset(Flin);
  ultft:=0;
  while not eof(flin) do
    begin
    inc(ultft);
    read(Flin,Ft^[ultft]);
    if i_o then
    with Ft^[ultft]  do
      begin
      CMinx(X0);
      CMinx(X1);
      CMinY(Y0);
      CMinY(Y1);
      end;
    end;
  close(flin);

  assign(Blin,percorsodrive+'\'+nomep+'.Bg'+est);
  reset(Blin);
  ultblocco:=0;
  while not eof(Blin) do
    begin
    inc(ultblocco);
    read(Blin,Bll^[ultblocco]);
    with Bll^[ultblocco] do
    if (nome='FIN')or(nome='PON')or(nome='AMB') then
      begin
      CMinx(X);
      CMinY(Y);
      end;
    end;
  close(Blin);

  if fileexists(percorsodrive+'\'+nomep+'.Egi') then
    begin
    assign(Elin,percorsodrive+'\'+nomep+'.Egi');
    reset(Elin);
    read(Elin,buferr);
    erroreneldisegno:=buferr.mess;
    ErroreX:=buferr.EX;
    ErroreY:=buferr.EY;
    if uppercase(erroreneldisegno)=uppercase(letturacorretta)
    then form1.Label389.Caption:='Disegno interpretato correttamente'
    else
      begin
      eds:=lowercase(erroreneldisegno);
      if eds<>'' then
      eds[1]:=upcase(eds[1]);
      form1.Label389.Caption:=eds;
      end;
    close(Elin)
    end
  else
    begin
    if nomep<>'' then
    form1.Label389.Caption:='Realizzare un disegno nel CAD esterno'
    else form1.Label389.Caption:='Selezionare un piano';
    buferr.mess:='';
    buferr.ex:=0;
    buferr.ey:=0;
    end;

  //form1.Memo1.Lines.Clear;
  //form1.Memo1.Lines.add(buferr.mess);

  if {I_O}false then
    begin
    errorex:=0;
    errorey:=0;
    end
  else
    begin
    errorex:=buferr.ex;
    erroreY:=buferr.ey;
    //erroreneldisegno:=letturacorretta;
    end;
  grafica2d.ultblocco:=ultblocco;
  grafica2d.ultimafrontiera:=ultft;
  end
else
  begin
  grafica2d.ultblocco:=0;
  grafica2d.ultimafrontiera:=0;
  ultblocco:=0;
  ultft:=0;
  errorex:=0;
  erroreY:=0;
  if nomep<>'' then
  form1.Label389.Caption:='Realizzare un disegno nel CAD esterno'
  else form1.Label389.Caption:='Selezionare un piano';
  end;
Direznord:=V_recconfcad.angnord;  
end;
Procedure Caricalistapiante_1(Nomefile:string);
Var
Elin:file of  merr;
buferr:merr;
begin
(*
buferr.mess:='';
if fileexists(percorsodrive+'\'+nomefile+'.Egi')
then
  begin
  assign(Elin,percorsodrive+'\'+nomefile+'.Egi');
  reset(Elin);
  read(Elin,buferr);
  close(Elin);
  end;
//ftool_visualizza.ListBox1 .Items.Add(nomefile{+':'+buferr.mess});
if uppercase(buferr.mess)='LETTURA ESEGUITA CORRETTAMENTE' then
ftool_visualizza.ListBox1 .Items.Add(nomefile+':OK')
else ftool_visualizza.ListBox1 .Items.Add(nomefile+':ERRORI');
*)
end;
Procedure Caricalistapiante;
Var perc:string;
    sr:Tsearchrec;
    trovato:integer;
    nomefile:string;

begin
perc:=percorsodrive+'\*.Egi';
Trovato := FindFirst(perc,faarchive,sr);
while Trovato = 0 do
  begin
  NomeFile := copy(sr.Name,1,length(sr.Name)-4);
  Caricalistapiante_1(Nomefile);
  Trovato := FindNext(sr);
  end;
end;

Function VOl_tot_amb:real;
Var i:integer;
begin
Leggi_Locali(dmtutti.T_Locali,dmtutti.T_Pareti,dmtutti.ds_Locali);
result:=0;
for i:=1 to Nambienti do
with ambienti_d^[i]^ do
result:=result+superficie*hsoffitto;
end;



Procedure Analisi_disegno;
var elimina:boolean;
    i:integer;
begin
pathdebug:=i_sl(percorsodrive);
//ultblocco:=ultblocco_I;
//ultimafrontiera:=ultimafrontiera_I;
//Ft^:=Ft_I^;
erroreneldisegno:=letturacorretta;
driveplt:=percorsodrive;
ultimafrontiera:=ultft;
ultft:=ultimafrontiera;
controllodoppielinee(ultft);
fts^:=ft^;
for i:=ultft+1 to MaxFrontiere1 do
with ft^[i] do
  begin
  x0:=0;
  x1:=0;
  Y0:=0;
  Y1:=0;
  end;
for i:=ultblocco+1 to Maxblocchi do
BlL^[i].Nome:='';

i:=Ultblocco+1;
NBLOCCHI := ULTBLOCCO;
Ultblocco1:=UltBlocco;
Numero_blocchi:=UltBlocco;
unicoamb:=unicoambiente;
unicoamb1:=false;
Num_blocchi:=UltBlocco;
if (grafica2d.ultimafrontiera<=0)and(not LnSovrap) then erroreneldisegno:='Disegna una parete'
else
if (grafica2d.ultimafrontiera<3)and(not LnSovrap) then erroreneldisegno:='Disegna una perimetro chiuso'
else
  begin
  LeggiDXF('',elimina);
  ultft:=LetturadisegnoBidimensionale.Ultimafrontiera;
  Grafica2d.Ultimafrontiera:=ultft;
  end;
//grafica2d.ultblocco:=ultblocco;
grafica2d.ultimafrontiera:=ultft;
if erroreneldisegno='' then
erroreneldisegno:=letturacorretta
else
  begin
  //dxfdebug;
  end;
end;


Procedure Salva_file_Disegno(NomeP:string;tipo:char);
Var Flin:file of  FRONT;
    Blin:file of  BLOCCHI;
    Elin:file of  merr;
    buferr:merr;
    i:integer;
begin
assign(flin,percorsodrive+'\'+nomep+'.ig'+Tipo);
rewrite(Flin);
for i:=1 to ultft do
write(Flin,Ft^[i]);
close(flin);
assign(Blin,percorsodrive+'\'+nomep+'.Bg'+Tipo);
rewrite(Blin);
for i:=1 to ultblocco do
write(Blin,Bll^[i]);
close(Blin);
end;

Procedure Salvapiano_precedente(salvacomunque:boolean);
Var
    pip:integer;
    nomeP:string;
begin
nomeP:=Piano_precedente;
SalvaRete_I(rete_precedente,Nomep);
if (not salvacomunque)and((nomep='')or(form1.RadioButton2.Checked)) then exit;
if tipodisegno_precedente=edificio_elaborato then salva_file_disegno(NomeP,'I')
else salva_file_disegno(NomeP,'G');
end;

Procedure AzzeraPiano;
begin
ultblocco:=0;
ultft:=0;
InitFrontiere1;
InitBlocchi;
Azzerafrontiere;
end;

Procedure Salva_piano(nomep,Nomerete:string;salvain,salvarete:boolean);
begin
{$Ifdef tubi_14}
if salvarete then SalvaRete_I(Nomerete,Nomep)
else
{$endif}
Salvapiano(nomep,salvain,true);
end;

Function confrontainput(nomep:string;salva:boolean):boolean;
Var Flin:file of  FRONT;
    Blin:file of  BLOCCHI;
    Elin:file of  merr;
    i:integer;
    ult_blocco,Ult_ft:integer;
    BufF:fronT;
    BufB:Blocchi;
    messaggio:string;

procedure show_message(mss:string);
begin
messaggio:=mss;
end;
function confr(ff1,ff2:front):boolean;
begin
result:=(ff1.x0=ff2.x0)and(ff1.y0=ff2.y0)and(ff1.z0=ff2.z0)and
        (ff1.x1=ff2.x1)and(ff1.y1=ff2.y1)and(ff1.z1=ff2.z1);
end;
begin
if salva then
  begin
  assign(flin,I_sl(percorsodrive)+nomep+'.tmF');
  rewrite(Flin);
  for i:=1 to ultft do
  write(Flin,Ft^[i]);
  close(flin);
  {
  assign(Blin,percorsodrive+'\tempBg.tmp');
  rewrite(Blin);
  for i:=1 to ultblocco do
  write(Blin,Bll^[i]);
  close(Blin);
  }
  end
else
  begin
  messaggio:='';
  assign(flin,I_sl(percorsodrive)+nomep+'.tmF');
  reset(Flin);
  ult_ft:=0;
  while not eof(flin) do
    begin
    inc(ult_ft);
    read(Flin,BufF);
    if ult_ft>ultft then show_message('Numero frontiere maggiori')
    else
    if not confr(bufF,Ft^[ult_ft]) then
    show_message('Linea diversa')
    end;
  if ult_ft<Ultft then show_message('Numero frontiere minori');
  close(flin);
  if messaggio<>'' then showmessage(messaggio);
  {
  assign(Blin,percorsodrive+'\tempBg.tmp');
  reset(Blin);
  ult_blocco:=0;
  while not eof(Blin) do
    begin
    inc(ult_blocco);
    read(Blin,Bll^[ult_blocco]);
    end;
  close(Blin);
  }
  end;
end;
Procedure Spostadisegno(dx,dy:real);
Var I:integer;
begin
minimox:=minimox+dx;
minimoy:=minimoy+dy;
    for i:= 1 to ultblocco do
      begin
      blL^[i].x:=blL^[i].x+dx;
      blL^[i].y:=blL^[i].y+dy;
      end;
    for i:= 1 to ultft do
      begin
      Ft^[i].x1:=Ft^[i].x1+dx;
      Ft^[i].x0:=Ft^[i].x0+dx;
      Ft^[i].y1:=Ft^[i].y1+dy;
      Ft^[i].y0:=Ft^[i].y0+dy;
      end;

end;

Procedure spostaorigine;
Var i:integer;
begin
  If (minimox<=0)or(minimoy<=0) then
    begin
    if minimox>0 then minimox:=0;
    if minimoy>0 then minimoy:=0;
    for i:= 1 to ultblocco do
      begin
      blL^[i].x:=blL^[i].x-Minimox+0.1;
      blL^[i].y:=blL^[i].y-Minimoy+0.1;
      end;
    for i:= 1 to ultft do
      begin
      Ft^[i].x1:=Ft^[i].x1-Minimox+0.1;
      Ft^[i].x0:=Ft^[i].x0-Minimox+0.1;
      Ft^[i].y1:=Ft^[i].y1-Minimoy+0.1;
      Ft^[i].y0:=Ft^[i].y0-Minimoy+0.1;
      end;
    end
  else
    begin
    minimox:=0;
    minimoy:=0;
    end;
end;
Procedure RiPristinaorigine;
Var i:integer;
begin
If (minimox<>0)or(minimoy<>0) then
    begin
    for i:= 1 to ultblocco do
      begin
      blL^[i].x:=blL^[i].x+Minimox-0.1;
      blL^[i].y:=blL^[i].y+Minimoy-0.1;
      end;
    for i:= 1 to LetturaDisegnoBidimensionale.ultimafrontiera do
      begin
      Ft^[i].x1:=Ft^[i].x1+Minimox-0.1;
      Ft^[i].x0:=Ft^[i].x0+Minimox-0.1;
      Ft^[i].y1:=Ft^[i].y1+Minimoy-0.1;
      Ft^[i].y0:=Ft^[i].y0+Minimoy-0.1;
      end;
    errorex:=errorex+Minimox-0.1;
    errorey:=errorey+Minimoy-0.1;
    end;
end;



Procedure risolviaggregati;
Var i,j,k,Coda1,coda2,inda1,inda2,tmp:integer;
    master,princ:array[1..maxblocchi]of boolean;
    CodMaster,codmaster2,cod_amb:string;
    finito:boolean;
begin
//Inizializzazione
for i:=1 to ultblocco do
with Bll^[i] do
if (pos('AGGRE-',Uppercase(attrib1[2]))<>0)or(attrib1[2]='') then
princ[i]:=false
else princ[i]:=true;
(*
for i:=1 to ultblocco do
with Bll^[i] do
if nome='AMB' then
  begin
  if pos('AGGRE-',Uppercase(attrib1[2]))<>0 then
    begin
    attrib1[2]:='-Alloggio N°'+Attrib1[1];
    {
    attrib1[2]:='-';
    exit;
    Master[i]:=true;
    for j:=1 to ultblocco do
    if Bll^[j].Attrib1[1]=CodAggre(attrib1[2]) then Master[j]:=true;
    }
    end;
  //else
  Master[i]:=false;
  Princ[i]:=false;
  //mette come principali i locali con la descrizione assegnata
  if (attrib1[2]<>'')and(attrib1[2][1]<>'-')then
  Princ[i]:=True;
  end;
*)



finito:=true;
  repeat
  finito:=true;
  for i:=1 to ultft do
  with Ft^[i] do
  if Uppercase(colore)='FITTIZIA' then
    begin
    if (a1<>0)and(a2<>0) then
    if (princ[a1])or(princ[a2])then
    if (not princ[a1])or(not princ[a2])then
      begin
      inda1:=a1;
      inda2:=a2;
      if Princ[a2] then
        begin
        tmp:=inda1;
        Inda1:=inda2;
        inda2:=tmp;
        end;
      if pos('AGGRE-',Bll^[Inda1].attrib1[2])=0 then
      Bll^[Inda2].attrib1[2]:='AGGRE-'+Bll^[Inda1].attrib1[1]
      else Bll^[Inda2].attrib1[2]:='AGGRE-'+codaggre(Bll^[Inda1].attrib1[2]);
      princ[Inda2]:=true;
      finito:=false;
      end;
    end;
  until finito;
//manca il controllo due locali master non permessi

(*
for i:=1 to ultft do
with Ft^[i] do
if Uppercase(colore)='FITTIZIA' then
  begin
  if (a1<>0)and(a2<>0) then
    begin
    inda1:=a1;
    inda2:=a2;
    if Princ[a2] then
      begin
      tmp:=inda1;
      Inda1:=inda2;
      inda2:=tmp;
      end;
    Bll^[Inda2].attrib1[2]:='AGGRE-'+Bll^[Inda1].attrib1[1];
    //if Bll^[Inda1].attrib1[1]='3004' then
    //showmessage('qui');
    //if Bll^[Inda2].attrib1[1]='3004' then
    //showmessage('qui');

      //if (master[a1] and master[a2])or(princ[a2])  then
        begin
        //se due catene di master si incontrano viene privilegiata quella con il principale
        if (Princ[a2])or(master[a2] and not(master[a1])) then
          begin
          tmp:=inda1;
          Inda1:=inda2;
          inda2:=tmp;
          end;
        Codmaster:=Bll^[inda1].attrib1[1];
        if pos('AGGRE-',Uppercase(Bll^[inda1].attrib1[2]))<>0 then
        Codmaster:=codaggre(Bll^[inda1].attrib1[2]);

        Codmaster2:=Bll^[inda2].attrib1[1];
        if pos('AGGRE-',Uppercase(Bll^[inda2].attrib1[2]))<>0 then
        Codmaster2:=codaggre(Bll^[inda2].attrib1[2]);

        if codmaster<>Codmaster2 then  //salta le coppie già associate
          begin
          //Disattivato anche se cooretto
          {if (princ[inda1])and(princ[inda2]) then
          showmessage('Un solo locale traaggregati può contenere la descrizione');}

          if master[inda2] then
          for j:=1 to ultblocco do //Due catene di aggregati si incontrano ,viene modificata la seconda
          with Bll^[j] do
          if nome='AMB' then
            begin
            if pos('AGGRE-',Uppercase(attrib1[2]))<>0 then
            if codaggre(attrib1[2])=Bll^[Inda2].attrib1[1] then
            attrib1[2]:='AGGRE-'+codmaster;
            princ[j]:=Princ[inda1];
            end;
          Bll^[Inda2].attrib1[2]:='AGGRE-'+codmaster;
          princ[Inda2]:=Princ[inda1];
          master[inda1]:=true;
          master[Inda2]:=true;
          end;
        end ;

   {
      else
        begin //disattivato
        if master[a2] then
          begin
          tmp:=inda1;
          inda1:=inda2;
          inda2:=tmp;
          end;
        Codmaster:=Bll^[inda1].attrib1[1];
        if pos('AGGRE-',Uppercase(Bll^[inda1].attrib1[2]))<>0 then
        Codmaster:=codaggre(Bll^[inda1].attrib1[2]);
        if  codmaster<>'' then
        Bll^[Inda2].attrib1[2]:='AGGRE-'+Codmaster;
        master[inda1]:=true;
        master[Inda2]:=true;
        princ[inda2]:=princ[inda1]
        end;
      }
    end;
  end;
 *)
 (*
for i:=1 to ultblocco do
with Bll^[i] do
if nome='AMB' then
if pos('AGGRE-',Uppercase(attrib1[2]))<>0 then
  begin
  j:=i;
    repeat
    k:=1;
    cod_amb:=codaggre(Bll^[j].attrib1[2]);
    while (k<ultblocco)and((Bll^[k].nome<>'AMB')or(cod_amb<>Bll^[k].attrib1[1]))do inc(k);
    j:=k;
    until pos('AGGRE-',Bll^[j].attrib1[2])=0;
  attrib1[2]:='AGGRE-'+Bll^[j].attrib1[1];
  end;
*)
end;

Procedure RinumeraLocali(NomeP:string);
Var i,inda:integer;
begin
exit;//esclusa rinumerazione
InitNumvet;
for i:=1 to ultblocco do //Cambia indirizzamento aggregati
with Bll^[i] do
if nome='AMB' then
  begin
  Attrib1[1]:=inttostr(NuovoNPA(nomep,'',Bll^[i].x,Bll^[i].y,IndA));
  if ((attrib1[2]<>'')and(attrib1[2][1]='-'))or(pos(uppercase(attrib1[2]),'GGRE')<>0) then
  attrib1[2]:='-Alloggio N°'+Attrib1[1];
  end;
end;


Procedure Reindirizza_aggregati;
Var i,j,indbll,indbll1:integer;
    trovato:boolean;
begin
//Cambia indirizzamento aggregati assegnando l'indice dell'array blocchi
//al posto del codice del blocco per permettere la rinumerazione
for i:=1 to ultblocco do
with Bll^[i] do
if nome='AMB' then
if is_aggre(Attrib1[2],IndBll) then
  begin
  j:=1;
  trovato:=false;
  while(j<=Ultblocco)and(not trovato)do
    begin
    if Bll^[j].Nome='AMB' then
      begin
      Indbll1:=str_toint(Bll^[j].Attrib1[1]);
      trovato:=indbll1=Indbll;
      end;
    if not trovato then  inc(j);
    end;
  if trovato then
  Attrib1[2]:='AGGRE-'+inttostr(j);
  //else  eliminato perche non sempre congruo
  //  begin
  //  showmessage('Vietato usare aggregati ad altri piani nei piani clone :'+Attrib1[2]);
  //  Attrib1[2]:='';
  //  end;
  //else eliminato su ruchiesta di Carlo
  //showmessage('Avvertimento di sicurezza:'+chr(13)+'Il locale'+Attrib1[1]+' è aggregato ad un locale di un altro piano'+chr(13)+
  //            Attrib1[2]+chr(13)+
  //            'assicurarsi che dopo la rinumerazione dei locali il riferimento rimanga corretto');
  end;
end;

Procedure ScriviDxferrore(ssx,ssy:real);
Var i,count:integer;
    nomef:string;
begin
Nentita:=0;
count:=0;
for i:=1 to LetturaDisegnoBidimensionale.ultimafrontiera do
with Ft^[i] do
if error then
  begin
  inc(count);
  end;
nomef:=I_sl(percorsodrive)+'errorelettura.dxf';
if count>1 then
output_dxf(nomef)
else deletefile(Pchar(nomef));
end;

{----- gestione locali pannelli radianti ----}
Procedure Init_punt_lettura;
begin
new(ft);//lettura disegno per pannelli
new(BlL);
//new(fts^);
end;
Procedure Init_disegno_pannelli;
begin
ultft:=0;
end;
Procedure Add_disegno_pannelli(x0l,y0l,x1l,y1l:real);
const FattoreDiscala=100;
begin
inc(ultft);
with ft^[ultft] do
  begin
  x0:=x0l*FattoreDiscala;
  y0:=y0l*FattoreDiscala;
  z0:=0;
  x1:=x1l*FattoreDiscala;
  y1:=y1l*FattoreDiscala;
  z1:=0;
  end;
end;
Procedure dxfdebug;
var i:integer;
begin
nentita:=0;
for i:=1 to ultft do
//if (ft^[i].A1=4)or(ft^[i].A2=4) then
begin
if ft^[i].error then
Add_LineaDxf(ft^[i].x0,ft^[i].y0,0,ft^[i].x1,ft^[i].y1,0,'0','3','Continuous')
else  Add_LineaDxf(ft^[i].x0,ft^[i].y0,0,ft^[i].x1,ft^[i].y1,0,'0','1','Continuous');
Add_TestoDxf((ft^[i].x0+ft^[i].x1)/2,(ft^[i].y0+ft^[i].y1)/2,0,0,inttostr(i),'0','1');
end;
for i:=1 to ultblocco do
if uppercase(BlL^[i].Nome)='AMB' then
//Add_BloccoDxf_Col_ing(xl1,yl1,zl1,LAng,lingX,lingY:real;LNomebl,llayer,LColore:string);
//Add_BloccoDxf(xl1,yl1,zl1,LAng:real;LNomebl,llayer:string);
Add_BloccoDxf_col_ing(BlL^[i].x,BlL^[i].y,0,0,100,100,'Allinea','0','3');
begin
end;

//Add_BloccoDxf(errorex,errorey,0,0,'Allinea','0');
output_dxf(i_sl(percorsodrive)+'debuglettura.dxf');
end;

Procedure Crea_file_interfaccia(nomep:string);
Var i,j,esterno:integer;
    strest:string;
    fo:file of FRONTHT;
    buf:FRONTHT;
    dsp:real;
    fo1:file of areaLoc;
    ba:arealoc;
const ftscala=100;
begin
esterno:=1; //trova il perimetro esterno
for i:=2 to MaxAmbienti1 do
if Ar^[i]>Ar^[esterno] then esterno:=i;
strest:=inttostr(esterno);

assign(fo, IncludeTrailingPathDelimiter(percorsoDrive) + nomep + '.inp');
rewrite(fo);
If (minimox<0)or(minimoy<0) then dsp:=0.1 else dsp:=0;

for j:=1 to countlocali_pannelli do
for i:=1 to ultft do
with ft^[i] do
if (a1=j)or(a2=j) then
  begin
  if (a1<>0)and(a1<>esterno)and(a1=j) then
    begin
    buf.x0:=(x0+Minimox-dsp)/ftscala;
    buf.y0:=(y0+Minimoy-dsp)/ftscala;
    buf.x1:=(x1+Minimox-dsp)/ftscala;
    buf.y1:=(y1+Minimoy-dsp)/ftscala;

    //eliminato perchè sfalsava le superfici
    //if a1< esterno then  //essendo arbitraria la numerazione eloimino il buco creato dall'ambiente esterno
    buf.NAmb  := inttostr(a1);
    //else  buf.NAmb  := inttostr(a1-1);

    //if a2< esterno then
    buf.NAmb2 := inttostr(a2);
    //else buf.NAmb2 := inttostr(a2-1);
    write(fo,buf);
    end;
  if (a2<>0)and(a2<>esterno)and(a2=j) then  //p1 e p2 invertiti
    begin
    buf.x1:=(x0+Minimox-dsp)/ftscala;
    buf.y1:=(y0+Minimoy-dsp)/ftscala;
    buf.x0:=(x1+Minimox-dsp)/ftscala;
    buf.y0:=(y1+Minimoy-dsp)/ftscala;

    //if a2< esterno then  //essendo arbitraria la numerazione eloimino il buco creato dall'ambiente esterno
    buf.NAmb  := inttostr(a2);
    //else  buf.NAmb  := inttostr(a2-1);

    //if a1< esterno then
    buf.NAmb2 := inttostr(a1);
    //else buf.NAmb2 := inttostr(a1-1);

    write(fo,buf);
    end;
  end;
close(fo);


assign(fo1, IncludeTrailingPathDelimiter(percorsoDrive) + nomep + '.ina');
rewrite(fo1);
for i:=1 to MaxAmbienti1 do
if Ar^[i]<>0 then
  begin
  ba.locale:=i;
  ba.area:=ar^[i]/10000;
  write(fo1,ba);
  end;
close(fo1);
end;

Procedure Analisi_disegno_pannelli(Piano_loc:string;controlla:boolean;Var errore_pan:string;Var eex,eey:real);
Var i:integer;
begin
Leggi_contorni_edificio_pannelli(Piano_loc);
spostaorigine;//disegno con coordinate < 0
lettura_pannelli:=true;
countlocali_pannelli:=0;
for i:=1 to MaxFrontiere1 do
  begin
  ft^[i].A1:=0;
  ft^[i].A2:=0;
  end;
Analisi_disegno;
lettura_pannelli:=false;
dxfdebug;
if (uppercase(erroreneldisegno)=letturacorretta){OR(pos('SIMBOLO',uppercase(erroreneldisegno))<>0)} then erroreneldisegno:='';
if not controlla then Crea_file_interfaccia(Piano_loc);
RipristinaOrigine;
errore_pan:=erroreneldisegno;
eex:=errorex;
eey:=errorey;
end;

Procedure Leggi_contorni_edificio_pannelli(NomePiano:string);
Var i:integer;
const fattorediscala=100;

procedure Settamin(px,py:real);
begin
if px<minimox then minimox:=px;
if py<minimoy then minimoy:=py;
end;

begin
Nentita:=0;
input_dxf(perc_work+'edificio_'+nomepiano+'.dxf',false);
for i:=1 to Nentita do
if entita_d^[i].cod='L' then
if uppercase(entita_d^[i].Tlinea)<>'FITTIZIA' then
  begin
  inc(ultft);
  with Ft^[ultft] do
    begin    
    x0:=(entita_d^[i].X1-reccontrollo.Or_x)*FattoreDiscala;
    y0:=(entita_d^[i].y1-reccontrollo.Or_y)*FattoreDiscala;
    x1:=(entita_d^[i].X2-reccontrollo.Or_x)*FattoreDiscala;
    y1:=(entita_d^[i].y2-reccontrollo.Or_y)*FattoreDiscala;
    settamin(x0,y0);
    settamin(x1,y1);
    end
  end;
end;

Procedure Salvapiano(nomep:string;salvain,rinumera:boolean);


Var Flin:file of  FRONT;
    Blin,blin2:file of  BLOCCHI;
    Elin:file of  merr;
    erinpgraf:textfile;
    bbe:string;
    buferr:merr;
    bufbll:Blocchi;
    i,j,pip,IndA,IndBll,indbll1,count:integer;
    ar1:recArea;
    trovato:boolean;
    pianodup:string;
begin
//if orienta_fin then orientafinestre;
Direznord:=V_recconfcad.angnord;
pip:=posind;
if nomep='' then exit;
 //ScriviInterfDXF;
if rinumera then RinumeraLocali(NomeP);
//spostato sotto
// spostato qui per fare in modo che si salvano gli aggregati
if salvain then
  begin
  if salvain then
  begin
  assign(flin,percorsodrive+'\'+nomep+'.igg');
  rewrite(Flin);
  for i:=1 to ultft do
  write(Flin,Ft^[i]);
  close(flin);
  assign(Blin,percorsodrive+'\'+nomep+'.Bgg');
  rewrite(Blin);
  for i:=1 to ultblocco do
  write(Blin,Bll^[i]);
  close(Blin);
  end;
  //Gestione piani simili
  with  dmtutti.T_Piani do
    begin
    first;
    while (not eof)do
      begin
      if uppercase(V_recpia.Copiadi)=uppercase(Nomep) then
        begin
        copyfile(Pchar(percorsodrive+'\'+nomep+'.igg'),Pchar(percorsodrive+'\'+V_recpia.cod+'.igg'),false);
        copyfile(Pchar(percorsodrive+'\'+nomep+'.Bgg'),Pchar(percorsodrive+'\'+V_recpia.cod+'.Bgg'),false);
        end;
      next;
      end;
    end;
  end;

//Spostadisegno(-POsOrigX,-POsorigY);  // diego emergenza
Spostaorigine;

Pianocor:=NomeP;
//confrontainput(nomep,false);
if uppercase(erroreneldisegno)=letturacorretta then
  begin
  errorex:=0;
  errorey:=0;
  Analisi_disegno;
  end;
//erroreneldisegno:='lettura abolita';
erroreneldisegno:=uppercase(erroreneldisegno);
if erroreneldisegno=letturacorretta then
  begin
  RisolviAggregati;
  Caricatabelle;
  end;
//confrontainput(nomep,false);

RipristinaOrigine;
//Spostadisegno(POsOrigX,POsorigY);  // diego emergenza


assign(flin,percorsodrive+'\'+nomep+'.igi');
rewrite(Flin);
for i:=1 to LetturaDisegnoBidimensionale.ultimafrontiera do
write(Flin,Ft^[i]);
close(flin);

//per consolidate gli aggregati nell'input
assign(Blin,percorsodrive+'\'+nomep+'.Bgg');
assign(Blin2,percorsodrive+'\'+nomep+'.Bgi');
reset(Blin);
rewrite(Blin2);
count:=0;
while not eof(blin) do
  begin
  inc(count);
  read(blin,bufbll);
  bufbll.Attrib1[2]:=Bll^[count].Attrib1[2];
  write(blin2,bufbll);
  end;
close(Blin);
close(Blin2);
copyfile(Pchar(percorsodrive+'\'+nomep+'.Bgi'),Pchar(percorsodrive+'\'+nomep+'.Bgg'),false);



assign(Blin,percorsodrive+'\'+nomep+'.Bgi');
rewrite(Blin);
for i:=1 to ultblocco do
write(Blin,Bll^[i]);
close(Blin);


assign(Elin,percorsodrive+'\'+nomep+'.Egi');
rewrite(Elin);
buferr.mess:=erroreneldisegno;
buferr.ex:=errorex;
buferr.ey:=errorey;
Write(Elin,buferr);
close(Elin);

//assign(Erinpgraf,percorsodrive+'\errori input edificio.txt');
assign(Erinpgraf,percorsodrive+'\errori_'+pianocor+'.txe');
rewrite(Erinpgraf);
Writeln(Erinpgraf,pianocor);
bbe:=erroreneldisegno;
bbe:=lowercase(bbe);
bbe[1]:=upcase(bbe[1]);
Writeln(Erinpgraf,bbe);

count:=0;   //alcuni locali non identificati con l'apposito simbolo
for i:=1 to LetturaDisegnoBidimensionale.ultimafrontiera do
if Ft^[i].error then inc(count);
if count>1 then
  begin
  errorex:=0;
  errorey:=0;
  end;
if controlla_dis then
  begin
  Writeln(Erinpgraf,floattostr(errorex/100+POsorigX1)); //diego emergenza
  Writeln(Erinpgraf,floattostr(errorey/100+POsorigY1));
  for i:=1 to LetturaDisegnoBidimensionale.ultimafrontiera do
  with Ft^[i] do
  if error then
    begin
    Writeln(Erinpgraf,floattostr(x0/100+POsorigX1));
    Writeln(Erinpgraf,floattostr(y0/100+POsorigy1));
    Writeln(Erinpgraf,floattostr(x1/100+POsorigX1));
    Writeln(Erinpgraf,floattostr(y1/100+POsorigy1));
    end;
  WCordLog('Coordinate dell''errore ',errorex/100,errorey/100);
  WCordLog('Scrittura nel file POsorig1',POsorigX1,POsorigY1);
  end
else
  begin
  Writeln(Erinpgraf,floattostr(errorex/100));
  Writeln(Erinpgraf,floattostr(errorey/100));
  for i:=1 to LetturaDisegnoBidimensionale.ultimafrontiera do
  with Ft^[i] do
  if error then
    begin
    Writeln(Erinpgraf,floattostr(x0/100));
    Writeln(Erinpgraf,floattostr(y0/100));
    Writeln(Erinpgraf,floattostr(x1/100));
    Writeln(Erinpgraf,floattostr(y1/100));
    end;
  end;
POsOrigX1:=0;
POsorigY1:=0;
close(Erinpgraf);


{  non so perche non funziona bene
with  dmtutti.T_Piani do
  begin
  first;
  while (not eof)and(uppercase(nomep)<>uppercase(V_recpia.cod)) do
    begin
    inc(indice_clone);
    next;
    end;
  end;
 }
indice_clone:=1;  //utilizzato in copiacaricatabelle
while  (indice_clone<Npiani)and(uppercase(nomep)<>uppercase(piani_D^[indice_clone].cod)) do inc(indice_clone);
//Gestione piani simili
//if false then
  with  dmtutti.T_Piani do
    begin
    first;
    Reindirizza_Aggregati;

    while (not eof)do
      begin
      if uppercase(V_recpia.Copiadi)=uppercase(Nomep) then
        begin
        Pianodup:=V_recpia.cod;
        //Duplica il report lettura
        copyfile(Pchar(percorsodrive+'\'+nomep+'.Egi'),Pchar(percorsodrive+'\'+V_recpia.cod+'.Egi'),false);
        assignfile(flin,percorsodrive+'\'+V_recpia.cod+'.igi');
        rewrite(Flin);
        for i:=1 to LetturaDisegnoBidimensionale.ultimafrontiera do
        write(Flin,Ft^[i]);
        closefile(flin);
        assignfile(Blin,percorsodrive+'\'+V_recpia.cod+'.Bgi');
        rewrite(Blin);
        InitNumvet;
        for i:=1 to ultblocco do
          begin
          bufbll:=Bll^[i];
          with Bll^[i] do
          if Bll^[i].nome='AMB' then
          if strtoint(Attrib1[1])<>0 then
            begin
            //Attrib1[1]:=inttostr(NuovoNPA(V_recpia.cod,'',Bll^[i].x,Bll^[i].y,IndA));
            Attrib1[1]:=inttostr(V_recpia.indice*1000+(strtoint(Attrib1[1])mod 1000));
            ar1[strtoint(Bll^[i].Attrib1[1])]:=ar^[strtoint(bufbll.Attrib1[1])];
            if length(Attrib1[2])>0 then
              begin
              if Attrib1[2][1]='-' then
              Attrib1[2]:='- Alloggio N° '+Attrib1[1];
              end;
            end;
          end;
        //Ripristina indirizzamento aggregati
        for i:=1 to ultblocco do
        with Bll^[i] do
          begin
          bufbll:=Bll^[i];
          if nome='AMB' then
          if Is_aggre(Attrib1[2],IndBll) then
            begin
            IndBll:=strtoint(codAggre(attrib1[2]));
            if (indbll<>0)and(Bll^[indbll].Nome='AMB') then
            bufbll.Attrib1[2]:='AGGRE-'+Bll^[indbll].attrib1[1]
            else
            showmessage('1:Ricerca aggregati:irregolarità nel disegno '+attrib1[2]);
            end;
          Bll^[i]:=bufbll;
          write(Blin,bufbll);
          end;
        closefile(Blin);
        ar^:=ar1;
        Pianocor:=V_recpia.cod;
        if uppercase(erroreneldisegno)=letturacorretta then
          begin
          spostaOrigine;
          Caricatabelle;
          RiPristinaOrigine;
          end;
        end;
      next;
      end;
    end;

indice_clone:=0; //utilizzato in copiacaricatabelle



Pianocor:=NomeP;

azzeraPiano;
POsind:=pip;
//ftool_visualizza.ListBox1.Items.Add(nomep+':'+erroreneldisegno)
 dmtutti.T_ConfCad.Edit;
 V_RecConfcad.Set_PIANOCOR(Nomep);
 dmtutti.T_ConfCad.POst;
MinimoX:=10E6;
MinimoY:=10E6;
end;

Procedure CMinx(vv:real);
begin
if vv<Minimox then minimox:=vv;
end;
Procedure CMinY(vv:real);
begin
if vv<Minimoy then minimoy:=vv;
end;

Procedure SalvaPianoInport(nomep:string;salvain:boolean);
Var i,j:integer;
begin
inc(npiani);
with piani_d^[npiani] do
  begin
  altl:=2.7;
  Cod:=nomep;
 end;
SalvaPiano(nomep,salvain,false);

apripiano(true,Nomep);

//Carica gli attributi dai locali nei simboli
if uppercase(erroreneldisegno)=letturacorretta then
for i:= 1 to ULTBLOCCO do
with BlL^[i] do
if nome='AMB' then
  begin
  j:=1;
  if nambienti>0 then
    begin
    while (j<Nambienti)and(attrib1[1]<>ambienti_d^[j]^.CodNum)do inc(j);
    if attrib1[1]=ambienti_d^[j]^.CodNum then
    with ambienti_d^[j]^ do
      begin
      Attrib1[2]:=denom;
      Attrib1[4]:=codzona+':'+impianto+':';
      Attrib1[5]:=T_pav+':'+C_pav+':';
      Attrib1[6]:=T_soff+':'+C_soff+':';
      end;
    end;  
  end;
salvapiano_precedente(true);
MinimoX:=10E6;
MinimoY:=10E6;
azzerapiano;
end;
procedure CaricaInput(nomepiano : string;var interrompi :boolean);

var fbl : file of blocchi;
    fft : file of front;
    m,i,j : integer;

    vic :integer;


var fdeb:text;
    //O: POggetto;
    FattoreDiscala:real;
    err:Integer;
    Tipo:char;
    Colore:string;
    CodiceEnt:string;
    x1,y1,x2,y2:real;
    entita,tpp:string;
    finePiano,primopiano:boolean;

{Coordinate minori di 0 }





BEGIN
     // Modifica by Piero
     if NomePiano <> '' then
        pianocor:=Form1.DBCombobox1.text;

 // val(FormTesto.edit1.text,FattoreDiScala,err);
  //fattorediscala:=fattorediscala/100;
  fattorediscala:=100;
  InitFrontiere1;
  InitBlocchi;
  Azzerafrontiere;
  UltBlocco:=0;
  ultft:=0;
  FinePiano:=false;
  MinimoX:=10E6;
  MinimoY:=10E6;
  primopiano:=true;
  erroreneldisegno:=letturacorretta;
  //InitVariabili;
  Driveplt:=percorsodrive+'\';
  while (not eof(fdis))and(not finepiano) do
    begin
    readln(fdis,Bufdis);
    azzeraIdentif;
    entita:=Leggiidentif1(Bufdis);
    Tipo:='-';
    If upstring(entita)='PIANO' then
      begin
      if Nomepiano='' then
        begin
        if not primopiano then salvapianoInport(Pianocor,true);
        primopiano:=false;
        pianocor:=Form1.DBCombobox1.text;
        TPP:=Uppercase(Leggiidentif1(Bufdis));
        //if length(tpp)>10 then tpp:=copy(tpp,1,10);
        Form1.DBCombobox1.text:=tpp;
        //Form1.DBCombobox1.Items.Add(Form1.DBCombobox1.text);
        {
        i:=1;
        while (i<Npiani)and(Uppercase(Flettura.ComboBox1.Text)<>uppercase(Piani_d^[i].Cod)) do inc(i);
        if (NPiani=0)or(Uppercase(Flettura.ComboBox1.Text)<>uppercase(Piani_d^[i].Cod)) then
          begin
          Inc(NPiani);
          Piani_d^[Npiani].NPPiano:=0;
          Piani_d^[Npiani].Cod:=Flettura.ComboBox1.Text;
          indpcor:=Npiani;
          end
         else indpcor:=i;
        Piani_d^[Indpcor].NPPiano:=0;
        }
        end;
      //if ultft<>0 then finepiano:=true
      //else
         pianocor:=Form1.DBCombobox1.text;
      end
    else
      begin
      If upstring(entita)='NORD' then
        begin
        direzNord:=360-str_tofloat(Leggiidentif1(Bufdis))+90;
        end
      else
        begin
        tipo:=entita[1];
        CodiceEnt:=Leggiidentif1(Bufdis);
        end;
      end;

   //with Buffig do
      case Tipo of
      'M':begin
          Colore:=Leggiidentif1(Bufdis);
          x1:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          y1:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          x2:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          y2:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          cminx(x1);cminx(x2);cminy(y1);cminy(y2);
          controllodoppielinee(ultft);
          inc(ultFt);
          Ft^[ultft].colore:=colore;
          Ft^[ultft].x0:=x1;
          Ft^[ultft].y0:=y1;
          Ft^[ultft].z0:=0;
          Ft^[ultft].x1:=x2;
          Ft^[ultft].y1:=y2;
          Ft^[ultft].z1:=0;
          Ft^[ultft].error:=false;
          Ft^[ultft].TLinea:=Restoidentif(Bufdis);//Leggiidentif1(Bufdis); modifica doppia parete
          //PareteSemp(x1,y1,x2,y2,0.001,0.1);
          {
          if Nomepiano='' then
            begin
            inc(Piani_d^[indpcor].NPPiano);
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].Tipo:='Parete';
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].Cod:=colore;
            azzeraidentif;
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].Alt:=str_tofloat(leggiidentif1(Ft^[ultft].TLinea));
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].Alt2:=str_tofloat(leggiidentif1(Ft^[ultft].TLinea));
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].Confine:=leggiidentif1(Ft^[ultft].TLinea);
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].X1:=x1/fattorediscala;
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].Y1:=Y1/fattorediscala;
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].X2:=X2/fattorediscala;
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].Y2:=Y2/fattorediscala;
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].Item:=Piani_d^[indpcor].NPPiano;
            end;
          }
          end;
      'L':begin
          x1:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          y1:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          cminx(x1);cminy(y1);
          inc(ultblocco);
           with blL^[Ultblocco] do
             begin
             Nome:='AMB';
             Attrib1[1]:=CodiceEnt;
             Attrib1[2]:=Leggiidentif1(Bufdis); //Descrizione
             Attrib1[3]:=Leggiidentif1(Bufdis); //altezza
             Attrib1[4]:=Leggiidentif1(Bufdis)+':'+Leggiidentif1(Bufdis)+':'; //zona-impianto
             Attrib1[5]:=Leggiidentif1(Bufdis)+':'+Leggiidentif1(Bufdis)+':'; //Pavimento
             Attrib1[6]:=Leggiidentif1(Bufdis)+':'+Leggiidentif1(Bufdis)+':'; //Soffitto
             X:=X1;
             y:=Y1;
             end;
          end;
      'F':begin
          x1:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          y1:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          cminx(x1);cminy(y1);
          inc(ultblocco);
           with blL^[Ultblocco] do
             begin
             Nome:='FIN';
             //Attrib1[1]:=inttostr(CodiceEnt);
             Attrib1[1]:=Leggiidentif1(Bufdis);
             Attrib1[3]:= Leggiidentif1(Bufdis);
             Attrib1[4]:= Leggiidentif1(Bufdis);
             Attrib1[2]:=Float_to_str(str_tofloat(Attrib1[3])*str_tofloat(Attrib1[4]),3);

             //Attrib1[1]:=Leggiidentif1(Bufdis);
             //Attrib1[2]:=Leggiidentif1(Bufdis);
             X:=X1;
             y:=Y1;
             end;
          end;
      'P':begin
          x1:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          y1:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          cminx(x1);cminy(y1);
          inc(ultblocco);
           with blL^[Ultblocco] do
             begin
             Nome:='PON';
             //Attrib1[1]:=inttostr(CodiceEnt);
             Attrib1[1]:=Leggiidentif1(Bufdis);
             Attrib1[2]:=Leggiidentif1(Bufdis);
             X:=X1;
             y:=Y1;
             end;
          end;
      end;
    end;
  salvapianoInport(pianocor,true);


  //AssignFile(ffig,drivprg+'\Prova2.d02');
  //Rewrite(ffig);

end;


Procedure Leggi_archivi_lettura(leggient:boolean);
begin
Leggi_Piani(dmtutti.T_Piani,dmtutti.T_PPiano,dmtutti.ds_Piani);
Leggi_Zone(dmtutti.T_Zone,dmtutti.T_zone,dmtutti.ds_zone);
Leggi_Strutture(dmtutti.T_Strutture,dmtutti.T_Strati,dmtutti.ds_Strutture);
Leggi_finestre(dmtutti.T_finestre,dmtutti.T_setti,dmtutti.ds_finestre);
//if leggient then Leggi_Entita(dmtutti.T_Entita,dmtutti.T_attributi,dmtutti.ds_entita);
Leggi_Locali(dmtutti.T_Locali,dmtutti.T_Pareti,dmtutti.ds_Locali);
Leggi_confine(dmtutti.T_confine,dmtutti.T_confine,dmtutti.ds_confine);
Leggi_mem_ParetiSpeciali;

end;
Procedure salva_archivi_lettura;
begin
//closeudbt;
//Salva_Entita(dmtutti.T_Entita,dmtutti.T_attributi,dmtutti.ds_entita);
Salva_Locali(dmtutti.T_Locali,dmtutti.T_Pareti,dmtutti.ds_Locali);
Salva_Piani(dmtutti.T_Piani,dmtutti.T_PPiano,dmtutti.ds_Piani);
//OpenUdbT;
end;

function Campo_Valido(param:string):boolean;
begin
param:=uppercase(param);
result:=(param<>''){and(param<>'NESSUNO')};
end;

Function CercaCodPar(colp,T_LN:string):string;
var i:integer;
    indcol:integer;
begin
result:='?'+colp;
if not(numvalido(colp)) then exit;
indcol:=strtoint(colp);
i:=1;
colp:=uppercase(colore_cad(indcol));
if uppercase(T_LN)<>'SPECIALE' then
  begin
  while (i>0)and(i<Nstrutture)and((uppercase(strutture_D^[i].ColCAD)<>colp)or(uppercase(strutture_D^[i].parsof)<>'PARETE'))do inc(i);
  if uppercase(strutture_D^[i].ColCAD)=colp then result:=strutture_D^[i].NFile
  else showmessage('Parete  di colore :'+colp+' non trovata in archivio');
  end
else
  begin
  while (i<NParSpeciali)and(uppercase(ParSpeciali_D^[i].ColCAD)<>colp)do inc(i);
  if (i<>0)and(i<=NParSpeciali)and(uppercase(ParSpeciali_D^[i].ColCAD)=colp) then result:='§'+inttostr(ParSpeciali_D^[i].Codice)
  else showmessage('Parete speciale di colore :'+colp+' non trovata in archivio');
  end;
end;

Procedure Cambia_descr_amb(codamb,Descr:string);
Var i:integer;
begin
if Nambienti=0 then exit;
codamb:=Uppercase(codamb);
i:=1;
while (i<Nambienti)and(uppercase(ambienti_d^[i]^.CodNum)<>codamb)do inc(i);
if uppercase(ambienti_d^[i]^.CodNum)=codamb then ambienti_d^[i]^.Denom:=descr;
end;


Function Settaconf(Tln:string):string;
begin
result:='';
//if Uppercase(tln)='FITTIZIA' then
//  begin
//  result:='
//  end;
if Uppercase(tln)='NONSC' then
  begin
  result:='NON SC';
  exit;
  end;
if length(tln)>4 then
if uppercase(copy(tln,1,4))='CONF' then
if numValido(copy(tln,5,1)) then
  begin
  i:=1;
  //tln:=copy(tln,5,1);
  while (i<Nconfini)and(Confine_D^[i].TLinea<>tln)do inc(i);
  if Confine_D^[i].TLinea=tln then
  result:=Confine_D^[i].Codice{+':'};
  end;
end;


Var vett_num:array[1..maxambienti]of integer;
    numvet:integer;
Procedure InitNumvet;
begin
numvet:=0;
end;
function Nuovo_NPA(PIano,codblocco:string):integer;
Var ind_a,err,i,j:integer;
     trovato:boolean;
     ss:string;
begin
val(codblocco,ind_a,err);
result:=ind_a;
//if err<>0 then  valgono le coordinate
  begin
  j:=1;
    Repeat
    i:=1;
    while (i<Nambienti)and(strtoint(ambienti_d^[i]^.CodNum)<>j) do inc(i);
    if i<=Nambienti then
      begin
      val(ambienti_d^[i]^.CodNum,ind_a,err);
      trovato:=(err<>0)or(ind_a<>j);
      end
    else trovato:=true;
    if trovato then
      begin
      i:=1;
      while (i<Numvet)and(vett_num[i]<>j) do inc(i);
      trovato:=vett_num[i]<>j;
      end;
    if not trovato then inc(j);
    Until trovato;
  inc(numvet);
  vett_num[numvet]:=j;
  result:=j;
  end;
end;
function NuovoNPA(PIano,codblocco:string;Xbl,Ybl:real;Var IndA:integer):integer;
Var I:integer;
Function UGL(a,b:real):boolean;
begin
result:=abs(a-b)<0.1;
end;
begin
IndA:=0;
if Nambienti=0 then
  result:=Nuovo_NPA(PIano,codblocco)
else
  begin
  i:=1;
  while (I<Nambienti)and((Ambienti_D^[i].Piano<>Piano)or(not Ugl(Ambienti_D^[i].x1,Xbl))or(not Ugl(Ambienti_D^[i].y1,YBl)))do Inc(i);
  if (Ambienti_D^[i].Piano=Piano)and(Ugl(Ambienti_D^[i].x1,Xbl))and(Ugl(Ambienti_D^[i].y1,YBl)) then
    begin
    result:=strtoint(Ambienti_D^[i].CodNum);
    IndA:=i;
    end
  else
  result:=Nuovo_NPA(PIano,codblocco);
  end;
end;



procedure CaricaInputDXF(leggiarchivi,leggient,scriviarchivi:boolean);


Var Fattorediscala:real;
    i,j,k,npa,IndA:Integer;
    TZona,TImp,TT_pav,TC_Pav,TT_soff,TC_Soff,Piano_corr,rete_corr,sstemp:string;
    Unaent,UnDisegno,set_undisegno:boolean;
    DisInp:(LReti,LEdificio);
    trovatoallinea:boolean;
Function valoreint(ss:string):Integer;
Var cod:integer;
begin
val(ss,result,cod);
if cod<>0 then result:=0;
end;

Function Layer_piano(layer:string):string;
Var und1,und2,i:integer;
begin
und1:=0;
und2:=0;
i:=1;
while und2=0 do
  begin
  if layer[i]='_' then
  if und1=0 then und1:=i else und2:=i;
  inc(i);
  end;
result:=uppercase(piani_d^[strtoint(copy(layer,und2+3,length(layer)-und2-2))].Cod);
end;
Function Layer_rete(layer:string):string;
Var und1,und2,i:integer;
begin
und1:=0;
und2:=0;
i:=1;
while und2=0 do
  begin
  if layer[i]='_' then
  if und1=0 then und1:=i else und2:=i;
  inc(i);
  end;
result:=uppercase(GENERALITA_D1^[strtoint(copy(layer,und1+1,und2-und1-1))].Codice);
end;

Procedure Salva_piano_dxf(nomep,Nomerete:string;salvain,salvarete:boolean);

function Piano_rete(layer:string):boolean;
begin
layer:=uppercase(layer);
result:=(copy(layer,1,4)='RETE') or
        ((layer[1]='R')and(layer_piano(layer)=uppercase(Piano_corr))and(layer_rete(layer)=uppercase(rete_corr)))
end;

Var i:integer;
begin
if salvarete then
for i:=1 to Nentita do
with entita_D^[i]^ do
if Piano_rete(layer) then
if cod[1]='B' then
  begin
  if (copy(uppercase(nomebl),1,7)='RIMRETE')or(copy(uppercase(nomebl),1,7)='RIPRETE') then
  Add_Rim_rete(i);
  end;
Salva_piano(nomep,Nomerete,salvain,salvarete);
end;

Function PianoVal(nomep:string):boolean;

Procedure set_Piano_corr(NuovoP,nuovarete:string);
begin
Piano_corr:=nuovop;
dmtutti.T_Piani.First;
while not  (dmtutti.T_Piani.eof)and  (uppercase(V_recpia.Cod)<>uppercase(PIANO_CORR))do
dmtutti.T_Piani.next;
Rete_corr:=nuovarete;
dmtutti.T_reti.First;
while not  (dmtutti.T_Reti.eof)and  (uppercase(V_recgen.Codice)<>uppercase(rete_CORR))do
dmtutti.T_reti.next;
piano_corr:=Nuovop;
rete_corr:=Nuovarete;
end;

begin
nomep:=uppercase(nomep);
result:=false;
if (copy(nomeP,2,1)<>'_')and(Nomep<>'EDIFICIO')and(Nomep<>'RETE') then exit;
if set_undisegno then
  begin
  if undisegno then
    begin
    if (Nomep='EDIFICIO')or(Nomep='RETE') then result:=true;
    if (Nomep='EDIFICIO') then DisInp:=LEdificio
    else DisInp:=LReti;
    rete_corr:=v_recconfcad.ColoreTipoReteIRR;
    end
  else
    begin
    if (copy(nomeP,2,1)='_')and (nomep[1]='E') then
      begin
      result:=true;
      if uppercase(copy(nomep,3,length(nomep)-2))<>uppercase(Piano_corr) then
        begin
        salva_piano_dxf(piano_corr,rete_corr,true,DisInp=LReti);
        set_piano_corr(copy(nomep,3,length(nomep)-2),rete_corr);
        end;
      disInp:=LEdificio;
      end
    Else
      begin
      result:=true;
      if (disInp=LEdificio)or(layer_piano(nomep)<>uppercase(Piano_corr))or(layer_rete(nomep)<>uppercase(rete_corr)) then
        begin
        salva_piano_dxf(piano_corr,rete_corr,true,DisInp=LReti);
        if DisInp=LReti then Azzera_inp_tubi(true);
        set_piano_corr(layer_piano(nomep),layer_rete(nomep));
        end;
      disInp:=LReti;
      end;
    end;
  end
else
  begin
  result:=true;
  set_undisegno:=true;
  undisegno:=true;
  Piano_corr:='';
  //rete_corr:='';
  if copy(nomeP,2,1)='_' then
    begin
    IF nomep[1]='E'  then disInp:=LEdificio Else disInp:=LReti;
    Undisegno:=false;
    set_Piano_corr(copy(nomep,3,length(nomep)-2),rete_corr);
    end
  else
    begin
    if (Nomep='EDIFICIO') then DisInp:=LEdificio
    else DisInp:=LReti;
    set_Piano_corr(Pianocor,rete_corr);
    end;
  end;
end;



Var Ind_piano,ind_termin,amb_corr,resval:integer;
    ttreal:real;
   st01:string;
   dati_pers_loc:boolean;
BEGIN
if leggiarchivi then leggi_archivi_lettura(leggient)
else Leggi_Piani(dmtutti.T_Piani,dmtutti.T_PPiano,dmtutti.ds_Piani);
Leggi_reti(dmtutti.T_reti,dmtutti.T_reti,dmtutti.ds_reti);
Leggi_TipiRete(dmtutti.T_TipiRete,dmtutti.T_DiametriB,dmtutti.ds_TipiRete);

  Nlabsosp:=0;
  set_Undisegno:=false;
  fattorediscala:=100;
  InitFrontiere1;
  InitBlocchi;
  Azzerafrontiere;
  UltBlocco:=0;
  ultft:=0;
  {$Ifdef Tubi_14}
  Azzera_inp_tubi(not dis_esecutivo);
  {$endif}
  MinimoX:=10E6;
  MinimoY:=10E6;
  numvet:=0;
  npa:=0;
  POsOrigX:=0;
  POsOrigY:=0;
  POsOrigX1:=0;
  POsOrigY1:=0;
  trovatoallinea:=false;
  erroreneldisegno:=letturacorretta;
  rete_corr:=v_recconfcad.ColoreTipoReteIRR;
  Driveplt:=percorsodrive+'\';
    begin
    unaent:=false;
    //pianocor:=V_RecPia.Cod;
    pianocor:=V_recconfcad.PIANOCOR;
    ind_piano:=1;
    while (ind_piano<Npiani)and(uppercase(pianocor)<>uppercase(Piani_d^[ind_piano].Cod))do inc(ind_piano);
    set_pianocor(ind_piano);//serve per caricaamb

    for i:=1 to Nentita do
    with entita_D^[i]^ do
    //if pos('_',Layer)=0 then
    //if uppercase(layer)='EDIFICIO' then
    if Pianoval(layer) then
    //if valoreint(copy(layer,2,length(layer)-1))<>0 then
    //if valoreint(copy(layer,2,length(layer)-1))=V_recpia.indice then
      case cod[1] of
       {
       Attrib:Ar_RecAttrib;
       NAttrib:Integer;
       Num:INTEGER;
       Cod:STRING[1];
       Layer:STRING[30];
       Colore:STRING[30];
       Tlinea:STRING[30];
       X1:REAL;
       Y1:REAL;
       Z1:REAL;
       X2:REAL;
       Y2:REAL;
       Z2:REAL;
       CodEnt:STRING[10];
       NomeBl:STRING[70];
       Valido:STRING[1];
       Ang:REAL;
       }
      'L':begin
          unaent:=true;
          if DisInp=LEdificio  then
            begin
            //controllodoppielinee(ultft);
            inc(ultFt);
            Ft^[ultft].N1:=0;
            Ft^[ultft].N2:=0;
            Ft^[ultft].D:='';
            Ft^[ultft].S:='';
            Ft^[ultft].A1:=0;
            Ft^[ultft].A2:=0;
            Ft^[ultft].colore:=CercaCodPar(colore,tlinea);
            if uppercase(Tlinea)='FITTIZIA' then Ft^[ultft].colore:='FITTIZIA';
            Ft^[ultft].x0:=x1*FattoreDiscala;;
            Ft^[ultft].y0:=y1*FattoreDiscala;;
            Ft^[ultft].z0:=0;
            Ft^[ultft].x1:=x2*FattoreDiscala;;
            Ft^[ultft].y1:=y2*FattoreDiscala;;
            Ft^[ultft].z1:=0;
            if Ft^[ultft].colore[1]='?' then
              begin
              if not (numvalido(colore)) then
              erroreneldisegno:='Colore irregolare'
              else erroreneldisegno:='Colore '+colore_cad(strtoint(colore))+' non assegnato a nessun tipo di parete:1:';
              Ft^[ultft].error:=true;
              end;
            Ft^[ultft].error:=false;
            Ft^[ultft].TLinea:='3:3:'+settaconf(Tlinea)+':';//Restoidentif(Bufdis);
            cminx(Ft^[ultft].x0);cminx(Ft^[ultft].x1);cminy(Ft^[ultft].Y0);cminy(Ft^[ultft].y1);
            end
          {$Ifdef Tubi_14}
          else
            begin
            if Uppercase(tlinea)='QUOTE' then
            Add_quota(x1,y1,x2,y2)
            else
            Add_Tubo_Inp(pianocor,x1,y1,z1,x2,y2,z2,colore,tlinea);
            end;
          {$endif}
          end;
      'B':begin
          if uppercase(nomebl)='ALLINEA' then
            begin
            if trovatoallinea then
              begin
              showmessage('E'' permesso solo un simbolo di allineamento (il cerchio con una croce inserito nell''origine del disegno 0,0),probabilmente è stato inavvertitamente duplicato, tutti quelli oltre al primo verranno eliminati.');
              //V_recpia.Set_AllineaX(V_recpia.AllineaX-POsOrigX/FattoreDiScala);
              //V_recpia.Set_AllineaY(V_recpia.AllineaY-POsOrigY/FattoreDiScala);
              end
            else
              begin
              //dmtutti.T_Piani.edit;
              trovatoallinea:=true;
              UltAllineaX:=piani_d^[ind_piano].AllineaX;
              UltAllineaY:=piani_d^[ind_piano].AllineaY;
              if not controlla_dis then
                begin
                piani_d^[ind_piano].AllineaX:=piani_d^[ind_piano].AllineaX+x1;
                piani_d^[ind_piano].AllineaY:=piani_d^[ind_piano].AllineaY+Y1;
                //V_recpia.Set_AllineaX(V_recpia.AllineaX+x1);
                //V_recpia.Set_AllineaY(V_recpia.AllineaY+Y1);
                end;
              POsOrigX:=X1*FattoreDiscala;
              POsOrigY:=Y1*FattoreDiscala;
              POsOrigX1:=X1;
              POsOrigY1:=Y1;
              WCordLog('Caricamento da simbolo POsorig1',POsorigX1,POsorigY1);
              //dmtutti.T_Piani.post;
              end;
            end;
          if copy(uppercase(nomebl),1,3)='LOC' then
              begin
              unaent:=true;
              inc(ultblocco);
              cminx(x1);cminy(y1);
              with blL^[Ultblocco] do
              if uppercase(nomebl)='LOCCORT' then
                begin
                X:=X1*FattoreDiscala;
                y:=Y1*FattoreDiscala;
                Nome:='AMB';
                TZona:='';
                TImp:='';
                Attrib1[1]:='0';
                Attrib1[2]:='CORTILE';
                end
              else
                begin
                X:=X1*FattoreDiscala;
                y:=Y1*FattoreDiscala;
                Nome:='AMB';
                TZona:='';
                TImp:='';
                dati_pers_loc:=false;
                For j:=1 to nattrib do
                  begin
                  if Uppercase(attrib[j].CodA)='INSMAN' then
                  if Uppercase(attrib[j].valore)='TRUE' then  dati_pers_loc:=true;

                  if Uppercase(attrib[j].CodA)='COD' then
                    begin
                    //Npa:=NuovoNPA(Piano_corr,attrib[j].valore,x1*FattoreDiscala,y1*FattoreDiscala,inda);
                    blL^[Ultblocco].Attrib1[1]:=attrib[j].valore;
                    if not numvalido(attrib[j].valore) then
                    showmessage('Errore interno :locale senza numerazione')
                    else
                    if (strtoint(attrib[j].valore)<Piani_d^[ind_piano].indice*1000)or
                        (strtoint(attrib[j].valore)>=(Piani_d^[ind_piano].indice+1)*1000)then
                    showmessage('Errore interno'+chr(13)+'La numerazione del locale: '+attrib[j].valore+' è errata '+chr(13)+
                                 'in quanto l''indice del piano  è : '+inttostr(Piani_d^[ind_piano].indice)+chr(13)+
                                 ' contattare l'' assistenza');
                    //attrib[j].valore:=Numeralocale(Ultblocco,ind_piano);
                    //blL^[Ultblocco].Attrib1[1]:=inttostr(Npa);
                    //attrib[j].valore:=inttostr(NpA);
                    end;
                  if Uppercase(attrib[j].CodA)='DESCR.' then
                    begin
                    Attrib1[2]:=attrib[j].valore;
                    if pos(':',Attrib1[2])<>0 then
                       begin
                       azzeraidentif;
                       st01:=leggiidentif1(Attrib1[2]);
                       if st01<>'' then
                       Attrib1[2]:=st01+'§'+leggiidentif1(Attrib1[2])
                       else
                         begin
                         st01:=leggiidentif1(Attrib1[2]);
                         Attrib1[2]:=st01;
                         end;
                       end;
                    if length(Attrib1[2])>0 then
                      begin
                      if Attrib1[2][1]='-' then
                      Attrib1[2]:='- App:'+Attrib1[1];
                      end;
                    end;
                  if Uppercase(attrib[j].CodA)='ZONA' then TZona:=attrib[j].valore;
                  if Uppercase(attrib[j].CodA)='IMPIANTO' then TImp:=attrib[j].valore;
                  
                  //Attrib1[2]:=Leggiidentif1(Bufdis); //Descrizione
                  //Attrib1[3]:=Leggiidentif1(Bufdis); //altezza
                   if Uppercase(attrib[j].CodA)='TSOF' then
                   if campo_valido(attrib[j].valore)then TT_soff:=attrib[j].valore
                   else TT_soff:='';
                   if Uppercase(attrib[j].CodA)='CSOF' then
                   if campo_valido(attrib[j].valore)then TC_soff:=attrib[j].valore
                   else TC_soff:='';
                   if Uppercase(attrib[j].CodA)='TPAV' then
                   if campo_valido(attrib[j].valore)then TT_Pav:=attrib[j].valore
                   else TT_Pav:='';
                   if Uppercase(attrib[j].CodA)='CPAV' then
                   if campo_valido(attrib[j].valore)then TC_Pav:=attrib[j].valore
                   else TC_Pav:='';
                  end;
                if  uppercase(copy(nomebl,1,5))='LOCNR ' then
                  begin
                  Timp:='nessuno';
                  TZona:='non risc';
                  end;
                Attrib1[4]:=TZona+':'+TImp+':'; //zona-impianto
                Attrib1[6]:=TT_soff+':'+TC_soff+':';
                Attrib1[5]:=TT_pav+':'+TC_pav+':';
                if numvalido(blL^[Ultblocco].Attrib1[1]) then
                  begin
                  amb_corr:=CaricaAmb(Ultblocco);
                  For j:=1 to nattrib do
                  with ambienti_D^[Amb_corr]^ do
                    begin
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

                    if dati_pers_loc then
                      begin
                      if Uppercase(attrib[j].CodA)='SENSPERS' then
                      SensibilePersona:=str_tofloat(attrib[j].valore);
                      if Uppercase(attrib[j].CodA)='LATPERS' then
                      LatentePersona:=str_tofloat(attrib[j].valore);
                      if Uppercase(attrib[j].CodA)='SENSAP' then
                      SensApparecch:=str_tofloat(attrib[j].valore);
                      if Uppercase(attrib[j].CodA)='LATAP' then
                      LatenteApparecch:=str_tofloat(attrib[j].valore);
                      if Uppercase(attrib[j].CodA)='POTLAMP' then
                      TotWattlampDat:=str_tofloat(attrib[j].valore);
                      if Uppercase(attrib[j].CodA)='POTMOTEL' then
                      TotWattMatElettr:=str_tofloat(attrib[j].valore);
                      if Uppercase(attrib[j].CodA)='RICARIAPERS' then
                      RicambioPersona:=str_tofloat(attrib[j].valore);
                      if Uppercase(attrib[j].CodA)='NUMPERS' then
                      NPersone:=str_toInt(attrib[j].valore);
                      if Uppercase(attrib[j].CodA)='NUMLAMP' then
                      NumAppElettr:=str_toInt(attrib[j].valore);
                      if Uppercase(attrib[j].CodA)='NUMMOTEL' then
                      NumMacch:=str_toInt(attrib[j].valore);
                      if Uppercase(attrib[j].CodA)='PROFAP' then
                      CodPRApparecch:=attrib[j].valore;
                      if Uppercase(attrib[j].CodA)='PROFPERS' then
                      CodPROccupaz:=attrib[j].valore;
                      end;
                    end;
                  if dati_pers_loc then
                  with ambienti_D^[Amb_corr]^ do
                    begin
                    TotWattlampDat:=NumAppElettr*TotWattlampDat;
                    TotWattMatElettr:=TotWattMatElettr*NumMacch;
                    SensApparecch:=SensApparecch+TotWattMatElettr;
                    DatiManEstivo:=1;
                    end
                  else ambienti_D^[Amb_corr]^.DatiManEstivo:=0;


                  //Caricamento parametri locale non riscaldato
                  if  uppercase(copy(nomebl,1,5))='LOCNR' then
                  For j:=1 to nattrib do
                  with ambienti_D^[Amb_corr]^ do
                    begin
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
                    end
                  else ambienti_D^[Amb_corr]^.TipoCalcTempNR:='';
                  end;
                end;
              end;
          if copy(uppercase(nomebl),1,3)='FIN' then
            begin
            unaent:=true;
            inc(ultblocco);
            cminx(x1);cminy(y1);
            with blL^[Ultblocco] do
              begin
              Attrib1[5]:='';
              if copy(Uppercase(nomebl),1,8)='FINLUCUP' then Attrib1[5]:='1';
              if copy(Uppercase(nomebl),1,9)='FINLUCDWN' then Attrib1[5]:='2';
              angolo:=-ang;
              X:=X1*FattoreDiscala;
              y:=Y1*FattoreDiscala;
              Nome:='FIN';
              For j:=1 to nattrib do
                  begin
                  if Uppercase(attrib[j].CodA)='TIPO' then  Attrib1[1]:=attrib[j].valore;
                  //Larghezza ed altezza lasciati in sospeso
                  end;
              end;
            end;
          if copy(uppercase(nomebl),1,3)='PON' then
            begin
            unaent:=true;
            inc(ultblocco);
            cminx(x1);cminy(y1);
            with blL^[Ultblocco] do
              begin
              X:=X1*FattoreDiscala;
              y:=Y1*FattoreDiscala;
              Nome:='PON';
              For j:=1 to nattrib do
                  begin
                  if Uppercase(attrib[j].CodA)='TIPO' then  Attrib1[1]:=attrib[j].valore;
                  if Uppercase(attrib[j].CodA)='LUNG' then  Attrib1[2]:=attrib[j].valore;
                  end;
              end;
            end;
          if copy(uppercase(nomebl),1,5)='IRETE' then
            begin
            dmtutti.T_Reti.Edit;
            v_recgen.Set_Xori(X1);
            v_recgen.Set_Yori(Y1);
            v_recgen.Set_angolo(ang);
            v_recgen.Set_Piano(Piano_corr);
            dmtutti.T_Reti.POst;
            dmtutti.T_Reti.Edit;
            set_tipo_rete('TUBAZIONI');
            end;
          {$Ifdef Tubi_14}
          if IS_Term(nomebl)and(not dis_esecutivo) then
          ADD_Term_inp(i);

          ind_termin:=0;
          if pos('ETICHETTA',uppercase(nomebl))<>0 then
          For j:=1 to nattrib do
          if (Uppercase(attrib[j].CodA)='LINK')then
            begin
            if (attrib[j].valore<>'') then  ind_termin:=strtoint(attrib[j].valore);
            if ind_termin=0 then
              begin
              for k:=1 to nattrib do
              if (attrib[k].coda='RIF') then sstemp:=attrib[k].valore;
              for k:=1 to nattrib do
              if (attrib[k].coda='POTENZA') then Pos_etichetta(ind_termin,x1,y1,attrib[k].valore,sstemp)
              end
            else
            Pos_etichetta(ind_termin,x1,y1,'','');
            end;
          {$endif}
          end;
       end;//case

     if (erroreneldisegno=letturacorretta)and(POsOrigX<>0)and(POsOrigY<>0) then
     Spostadisegno(-POsOrigX,-POsorigY);
     POsOrigX:=0;
     POsorigY:=0;
     //if unaent then
     if undisegno then
     salva_piano_dxf(pianocor,rete_corr,true,DisInp=LReti)
     else salva_piano_dxf(piano_corr,rete_corr,true,DisInp=LReti);
     //dmtutti.T_Piani.next;
     end; //while
if scriviarchivi then salva_archivi_lettura;
end;

Procedure Leggidisegni(percorso:string;Rinumera:boolean);
var inter:boolean;
//{$I MappaDB}
//{$I CreaDB}
//{$I DataOut}
begin
Progress_3d(50,'Lettura piante');
//form1.listbox1.items.Clear;
//form1.Memo1.Lines.Clear;
Leggi_Zone(dmtutti.T_Zone,dmtutti.T_zone,dmtutti.ds_zone);
if  fileexists(percorso+'\disegno.txt') then
  begin
  orienta_fin:=true;
  assign(fdis,percorso+'\disegno.txt');
  reset(fdis);
  CaricaInput('',inter);
  close(fdis);
  deletefile(pchar(percorso+'\disegno.txt'));
  orienta_fin:=false;
  end
else
if  fileexists(percorso+'\disegno.dxf') then
  begin
  Input_dxf(percorso+'\disegno.dxf',false);
  CaricaInputDxf(true,false,true);
  end;
//else form1.listbox1.items.add('Edificio:Nessun disegno');

end;

end.
