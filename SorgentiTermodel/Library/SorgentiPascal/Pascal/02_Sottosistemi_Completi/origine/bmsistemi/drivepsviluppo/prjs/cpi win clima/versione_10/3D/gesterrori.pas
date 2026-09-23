unit GestErrori;

interface
uses Uvariabililettura,udbt,sysutils,libreriagenerale,udatalink,CopiaLetturadisegno3d,grafica2d,dialogs;
const  ELettura_corretta=1;

Type
     Tdescrerr=record
               codE:Integer;
               messE,helpcont:string[50];
               Azionecons:integer;
               end;
const errori:Array[1..1] of TDescrerr=((codE:1;messE:'';helpcont:'';Azionecons:0));

Procedure DescrErrore(err:string);
Procedure AggiornaErrori;
Procedure DettaglioErrore;
Procedure AggiornaErroriEdificio;
Var errorecor:integer=0;
implementation
uses u3dsd;


Procedure DescrErrore(err:string);
begin
end;
 
Procedure DettaglioErrore;
Var rg,rigae,piano,tipoer,coder,descer:string;
    i,riga,err:Integer;
begin
with form1 do
  begin
  for i:=0 to listbox1.Items.Count-1 do
  if listbox1.Selected[i]then rg:=listbox1.Items.Strings[i];
  azzeraidentif;
  form1.Memo1.Clear;
  tipoer:=leggiidentif1(rg);
  if uppercase(tipoer)='LETTURA' then
    begin
    Piano:=leggiidentif1(rg);
    Coder:=leggiidentif1(rg);
    if coder<>'' then errorecor:=strtoint(coder);
    Descer:=leggiidentif1(rg);
    if piano<>'' then
      begin
      dmtutti.T_ConfCad.Edit;
      v_recconfcad.set_PIANOCOR(piano);
      dmtutti.T_ConfCad.POst;
      dmtutti.T_ConfCad.Edit;
      form1.CheckBox2.Checked:=true;
      form1.pagecontrol4.ActivePageIndex:=1;
      form1.radiobutton2.checked:=true;
      Apripiano(form1.RadioButton1.Checked,Piano);
      prima_volta:=true;
      ridisegna;
      form1.Memo1.Lines.Clear;
      form1.Memo1.Lines.Add(erroreneldisegno);
      end
    else
      begin
      form1.pagecontrol4.activepageindex:=0;
      form1.Memo1.Lines.Clear;
      form1.Memo1.Lines.Add(descer);
      end;
    end;
  if uppercase(tipoer)='RETI' then
    begin
    rigae:=leggiidentif1(rg);
    val(rigae,riga,err);
    if (err=0)and(riga<>0) then
      begin
      rigae:=leggiidentif1(rg);
      dmtutti.T_ConfCad.Edit;
      errore_grafo:=true;
      V_recconfCad.set_ColoreTipoReteIRR(rigae);
      dmtutti.T_ConfCad.POst;
      dmtutti.T_ConfCad.Edit;
      rigae:=leggiidentif1(rg);
      form1.Memo1.Clear;
      form1.Memo1.Lines.Add(rigae);
      form1.Memo1.Refresh;
      rigae:=leggiidentif1(rg);
      errore_Grafo_X:=str_tofloat(rigae);
      rigae:=leggiidentif1(rg);
      errore_Grafo_Y:=str_tofloat(rigae);
      ridisegna;
      end;
    form1.checkbox3.Checked:=true;
    form1.radiobutton2.Checked:=true;
    end;
  end
end;

Procedure AggiornaErroriEdificio;
Var i:Integer;
    Elin:file of  Merr;
    buferr:merr;
    undisegno,Un_errore,una_pianta:boolean;

begin
Undisegno:=false;
Un_errore:=false;
una_pianta:=false;
form1.memo1.Lines.Clear;
form1.listbox1.Items.Clear;
with dmtutti.T_Piani do
  begin
  first;
  while not eof do
    begin
    if V_recpia.Cod<>'' then
      begin
      una_pianta:=true;
      if fileexists(percorsodrive+'\'+V_recpia.Cod+'.Egi') then
        begin
        undisegno:=true;
        assignfile(Elin,percorsodrive+'\'+V_recpia.Cod+'.Egi');
        reset(Elin);
        read(Elin,buferr);
        closefile(Elin);
        if (uppercase(buferr.mess)<>uppercase(letturacorretta))and(buferr.mess<>'') then
          begin
          form1.listbox1.Items.Add('Lettura:'+V_recpia.Cod+'::Errori');
          un_errore:=true;
          end;
        end;
      end;
    next;
    end;
  if not(una_pianta) then
    begin
    un_errore:=true;
    form1.listbox1.Items.Add('Lettura::3:Nessuna pianta definita nelle''elenco piani:');
    end
  else  
  if not(undisegno) then
    begin
    un_errore:=true;
    form1.listbox1.Items.Add('Lettura::2:Nessun disegno:');
    end;
  end;
if not(Un_errore) then  form1.listbox1.Items.Add('Lettura:::corretta '+float_to_str(vol_tot_amb,0)+' mc:')
else errorecor:=1;

end;

Procedure AggiornaErrori;
Var Tt:textfile;
    buf:string;
    i:Integer;
begin
errorecor:=0;
AggiornaErroriEdificio;
if fileexists(I_sl(percorsodrive)+NomeFile_Errori_Impianti) then
  begin
  assign(tt,I_sl(percorsodrive)+NomeFile_Errori_Impianti);
  reset(tt);
  i:=0;
  while not eof(tt) do
    begin
    Inc(i);
    {
    if i=1 then //risultato generale
      begin
      readln(tt,buf);
      if buf=Str_Calc_OK  then
      form1.ListBox1.Items.Add('Reti:Calcolo corretto:');
      //else form1.ListBox1.Items.Add('Reti:'+inttostr(i)+':'+buf+':');
      end
    else }
      begin
      readln(tt,buf);
      form1.ListBox1.Items.Add('Reti:'+inttostr(i)+':'+buf+':');
      end;
    end;
  close(tt);
  end;
end;
end.
