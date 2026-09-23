unit assembla;

interface
uses sysutils,libreriagenerale,dialogs;
Procedure assemblabase(nomebase:string);

implementation
Procedure assemblabase(nomebase:string);
Var fin,fout,flink:textfile;
    path,buf,pathdb,nomedb,temp,rinom,par1,restost:string;
    trov:boolean;
    lungpar:integer;
begin
path:=extractfilepath(nomebase);
path:=i_sl(path);
assign(fout,nomebase);
rewrite(fout);
assign(fin,path+'assembla_basi.dat');
reset(fin);
while not eof(fin) do
  begin
  readln(fin,buf);
  azzeraidentif;
  pathdb:=leggiidentif1(buf);
  nomedb:=leggiidentif1(buf);
  rinom:=leggiidentif1(buf);
  assign(flink,path+pathdb+'\base.dat');
  reset(flink);
  trov:=false;
  while (not eof(flink))and(not trov) do
    begin
    readln(flink,buf);
    azzeraidentif;
    par1:=leggiidentif1(buf);
    temp:=leggiidentif1(buf);
    if (rinom<>'')and(uppercase(temp)=uppercase(nomedb)) then
      begin
      lungpar:=length(temp)+length(par1)+1;
      restost:=copy(buf,lungpar+1,length(buf)-lungpar);
      buf:=par1+':'+rinom+restost;
      end;
      repeat
      if uppercase(temp)=uppercase(nomedb) then writeln(fout,buf);
      readln(flink,buf);
      until (buf='*')or(buf='**');
    if uppercase(temp)=uppercase(nomedb) then
      begin
      trov:=true;
      if eof(flink) then  writeln(fout,'**')
      else writeln(fout,'*');
      end;
    end;
  close(flink);
  if not trov then showmessage('Database non trovato:'+chr(13)+'Percorso: '+pathdb+chr(13)+'Nome: '+nomedb);
  end;
close(fin);
close(fout);
end;
end.
