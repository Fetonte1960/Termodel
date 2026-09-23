unit Config_Var;

interface
uses sysutils,libreriagenerale,classes;
Function leggi_var(NomeVar:string):string;
Procedure Salva_var(NomeVar,Valore:string);

implementation
Const fileconf='Configurazione Projectbrower.txt';
      carsep='§';
Function E_nome(riga:string):string;
begin
result:='';
if pos(carsep,riga)<>0 then
result:=copy(riga,1,pos(carsep,riga)-1);
end;
Function E_Valore(riga:string):string;
begin
result:='';
if pos(carsep,riga)<>0 then
result:=copy(riga,pos(carsep,riga)+1,length(riga)-pos(carsep,riga));
end;
Function leggi_var(NomeVar:string):string;
Var FF:text;
    trov:boolean;
    buf:string;
begin
nomevar:=uppercase(nomevar);
result:='';
if fileexists(I_sl(percorsodrive)+fileconf) then
  begin
  assign(ff,I_sl(percorsodrive)+fileconf);
  reset(ff);
  trov:=false;
  while (not eof(FF)) and (not trov) do
    begin
    readln(ff,buf);
    trov:=E_Nome(buf)=Nomevar;
    if trov then result:=E_valore(Buf);
    end;
  close(ff);
  end;
end;
Procedure Salva_var(NomeVar,Valore:string);
Var SL:TstringList;
    ff:Text;
    Buf,nomev,valv:string;
    trov:boolean;
    i:integer;
begin
nomevar:=uppercase(nomevar);
if fileexists(I_sl(percorsodrive)+fileconf) then
  begin
  sl:=TstringList.Create;
  assign(ff,I_sl(percorsodrive)+fileconf);
  reset(ff);
  trov:=false;
  while not eof(ff) do
    begin
    readln(ff,buf);
    nomev:=E_nome(buf);
    if uppercase(Nomev)=nomevar then
      begin
      sl.Add(nomevar+Carsep+Valore);
      trov:=true;
      end
    else sl.Add(buf)
    end;
  rewrite(ff);
  for i:=1 to sl.Count do
    begin
    Nomev:=E_nome(sl.Strings[i-1]);
    Valv:=E_valore(sl.Strings[i-1]);
    writeln(FF,nomev+Carsep+Valv);
    end;
  if not trov then
  writeln(FF,nomevar+Carsep+Valore);
  close(ff);
  sl.Free;
  end
else
  begin
  assign(ff,I_sl(percorsodrive)+fileconf);
  rewrite(ff);
  writeln(FF,nomevar+Carsep+Valore);
  close(ff);
  end;
end;
end.
