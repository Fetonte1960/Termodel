unit Dummyfunction;
interface
uses sysutils;
type tmessage=record end;
var st_8:string[8];
    a_w,drivemask:string;
    Tab_testo,stampe_word,flagstampa:boolean;
    LenTitolo:integer;
    glst:textfile;
    col:array[1..16]of integer;
procedure GOTOXY(x, y:integer);
procedure CLREOL;
procedure textcolor(c:integer);
Function Keypressed:boolean;
Function Exist(nome:string):boolean;
Function Up_s(Var nome:string):string;
procedure textbackground(c:integer);
procedure window(x, y,x2,y2:integer);
procedure CLRscr;
Function Upstring(nome:string):string;
Function setleft(nome:string):string;
Function format(nome:string;lung:integer):string;
Function oem_ans(nome:string):string;
procedure eliminadir(c:string);
procedure LeggiMask(Nome:string);
procedure writetitolo;
procedure writecampi(a,b:integer);
function seg(a:pointer):integer;
function ofs(a:pointer):integer;
procedure writeult;
procedure writemessage(ms:string;ind:integer);
procedure write_m(mess:string);
procedure richiesta(mess:string);
implementation
procedure GOTOXY(x, y:integer);
begin
end;
procedure writeult;
begin
end;
procedure write_m(mess:string);
begin
end;
procedure richiesta(mess:string);
begin
end;
procedure writemessage(ms:string;ind:integer);
begin
end;
procedure window(x, y,x2,y2:integer);
begin
end;
procedure writecampi(a,b:integer);
begin
end;
procedure CLREOL;
begin
end;
function seg(a:pointer):integer;
begin
end;
function ofs(a:pointer):integer;
begin
end;
procedure CLRscr;
begin
end;
procedure writetitolo;
begin
end;
procedure LeggiMask(Nome:string);
begin
end;

procedure textcolor(c:integer);
begin
end;
procedure eliminadir(c:string);
begin
end;
Function Keypressed:boolean;
begin
end;
Function Exist(nome:string):boolean;
begin
result:=fileexists(nome);
end;
Function Up_s(Var nome:string):string;
begin
result:=Uppercase(nome);
Nome:=Uppercase(nome);
end;
Function setleft(nome:string):string;
Var i:integer;
    trovato:boolean;
begin
result:='';
trovato:=false;
for i:=1 to length(nome) do
if (nome[i]<>' ')or( trovato) then
  begin
  result:=result+nome[i];
  trovato:=true;
  end;
end;
procedure textbackground(c:integer);
begin
end;
Function Upstring(nome:string):string;
begin
result:=uppercase(nome);
end;
Function oem_ans(nome:string):string;
begin
result:=nome;
end;
Function format(nome:string;lung:integer):string;
begin
result:=copy(nome,1,lung);
end;

end.
