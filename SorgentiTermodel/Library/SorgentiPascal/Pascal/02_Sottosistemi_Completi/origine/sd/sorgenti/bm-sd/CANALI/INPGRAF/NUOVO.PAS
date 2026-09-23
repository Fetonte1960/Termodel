program nuovo;
uses wincrt;
type
  pprova=^tprova;
         tprova=object
         procedure iter(i:integer);
  end;
  var p:pprova;

 procedure tprova.iter(i:integer);
 var s:string;
 begin
   inc(i);
   writeln(i);
   iter(i);
 end;
begin
 new(p);
 p^.iter(0);
end.