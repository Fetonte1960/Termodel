unit UtilsGen;

interface
Function separaNomeFile(path:string):string;
Function separaPercorsoFile(path:string):string;
Function TogliEstensioneFile(path:string):string;

implementation
 Function separaNomeFile(path:string):string;
 Var i:integer;
 begin
 result:='';
 if path='' then exit;
 i:=length(path);
 while (path[i]<>'\')and(path[i]<>':') do dec(i);
 result:=copy(path,i+1,length(path)-i);
 end;
 Function separaPercorsoFile(path:string):string;
 Var i:integer;
 begin
 result:='';
 if path='' then exit;
 i:=length(path);
 while (path[i]<>'\')and(path[i]<>':') do dec(i);
 result:=copy(path,1,i-1);
 end;
 Function TogliEstensioneFile(path:string):string;
 Var i:integer;
 begin
 result:='';
 if path='' then exit;
 i:=length(path);
 while (path[i]<>'.') do dec(i);
 result:=copy(path,1,i-1);
 end;

end.
