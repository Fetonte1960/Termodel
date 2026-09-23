
unit driver;
interface
uses dos,crt;

{$i halotp4.p}
var command:string;
procedure plottaggio;
implementation
procedure plottaggio;
begin
  closegraphics;
  command:='/C'+'halo7475 lista.plt > p.p';
  swapvectors;
  exec(getenv('COMSPEC'),COMMAND);
  swapvectors;
end;
end.