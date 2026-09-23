for j:=128 to 165 do
  begin
    s1:='';
    s1:=chr(j);
    strpcopy(p1,s1);
    oemtoansi(p1,p1);
    s1:=strpas(p1);
    ch:=s1[1];
    i:=ord(ch);
    writeln(f1,i,':=',j);
  end;