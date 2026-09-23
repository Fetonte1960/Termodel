
program a2o;
uses dos,crt;
var arch:searchrec;

procedure trfile(nome:string);
const s2:string='asc';
var f,f1:text;
    s,s1:string;
    i,j:integer;
    ch:char;
    trovato:boolean;
begin
  assign(f,nome);
  reset(f);
  (*s1:='';
  s:='';
  i:=1;
  trovato:=false;
  while not trovato do
  begin
  trovato:=nome[i]='.';
  if not trovato then s:=s+nome[i];
  inc(i);
  end;
  j:=length(nome)-(i-1);
  s1:=copy(nome,i,j);
  for i:=1 to j do
  if not (s1[i] in['0'..'9']) then s1[i]:=s2[i];
  s:=s+'.'+s1;*)
  s:='conv.oem';
  assign(f1,s);
  rewrite(f1);
  while not eof(f) do
  begin
    read(f,ch);
    case ord(ch) of
      199:ch:=chr(128);
      252:ch:=chr(129);
      233:ch:=chr(130);
      226:ch:=chr(131);
      228:ch:=chr(132);
      224:ch:=chr(133);
      229:ch:=chr(134);
      231:ch:=chr(135);
      234:ch:=chr(136);
      235:ch:=chr(137);
      232:ch:=chr(138);
      239:ch:=chr(139);
      238:ch:=chr(140);
      236:ch:=chr(141);
      196:ch:=chr(142);
      197:ch:=chr(143);
      201:ch:=chr(144);
      230:ch:=chr(145);
      198:ch:=chr(146);
      244:ch:=chr(147);
      246:ch:=chr(148);
      242:ch:=chr(149);
      251:ch:=chr(150);
      249:ch:=chr(151);
      255:ch:=chr(152);
      214:ch:=chr(153);
      220:ch:=chr(154);
      162:ch:=chr(155);
      163:ch:=chr(156);
      225:ch:=chr(160);
      237:ch:=chr(161);
      243:ch:=chr(162);
      250:ch:=chr(163);
      241:ch:=chr(164);
      209:ch:=chr(165);
    end;
    write(f1,ch);
  end;
  close(f1);
  close(f);
  assign(f,nome);
  erase(f);
  assign(f1,s);
  rename(f1,nome);
end;

begin
  if paramcount>0 then
  begin
    findfirst(paramstr(1),Archive,arch);
    while doserror=0 do
    begin
      trfile(arch.name);
      findnext(arch);
    end;
  end
  else
  begin
  clrscr;
  write('Lanciare il programma seguito dal nome o da *.estensione');
  end;
end.