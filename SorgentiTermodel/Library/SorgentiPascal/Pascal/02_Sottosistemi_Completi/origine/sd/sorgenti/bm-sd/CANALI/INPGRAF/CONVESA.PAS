program convindec;
uses wincrt,winprocs;
var n:longint;
    i:integer;
    s:string;
    f:text;
begin
  assign(f,'tool.txt');
  rewrite(f);
  repeat
  s:='';
  write('Inserire il numero esadecimale:');
  readln(s);
  if (s[1]<>'$') and (s<>'*') then
  s:='$'+s;
  if s<>'*' then
  begin
  val(s,n,i);
  if i=0 then
  begin
  writeln('Numero decimale:',n);
  writeln(f,s,' ',n);
  flush(f);
  end
  else
  begin
  messagebeep(10);
  write('numero errato');
  end;
  end;
  until s='*';
  close(f);
end.