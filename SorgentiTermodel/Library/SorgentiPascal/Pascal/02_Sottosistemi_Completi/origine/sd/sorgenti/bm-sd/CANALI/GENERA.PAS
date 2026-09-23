program genera;
type rechlp= record
             descr:string[60];
             val  :string[18];
             end;
 var
 f:file of rechlp;
   hlp:rechlp;
   st,st1:string;
   i:integer;
begin
  assign(f,'archprog.l2');
  rewrite(f);
  hlp.descr:='40';
  hlp.val:='18';
  write(f,hlp);
  for i:= 1 to 20 do
  begin
  with hlp do
  begin
    str(i,st);
    descr:='Progetto numero '+st+'                  : ';
    val:='Progetti\prog'+st;
  end;
  write(f,hlp);
  end;
  close(f);
end.