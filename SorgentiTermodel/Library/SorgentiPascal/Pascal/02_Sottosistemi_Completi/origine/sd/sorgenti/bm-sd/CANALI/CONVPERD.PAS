 program convperd;
 Type perd1=record
               cod:String[8];
               descr:String[20];
               leq:real;
               zeta:real;
               kw:real;
            end;
      perd2=record
               cod:String[8];
               descr:string[20];
               leq:real;
               zeta:real;
               rit:String[1];
            end;
var
f1:file of perd1;
f2:file of perd2;
var b1:perd1;
    b2:perd2;
 begin
 assign(f1,'Archivio.prd');
 assign(f2,'archivio.pr1');
 reset(f1);
 rewrite(f2);
 while not eof(f1) do
   begin
   read(f1,b1);
   b2.cod:=b1.cod;
   b2.descr:=b1.descr;
   b2.leq:=b1.leq;
   B2.ZETA:=b1.zeta;
   b2.rit:='';
   write(f2,b2);
   end;

close(f1);
close(f2);
end.