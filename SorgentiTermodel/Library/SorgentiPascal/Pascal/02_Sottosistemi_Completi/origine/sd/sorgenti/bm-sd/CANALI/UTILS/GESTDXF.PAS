Unit gestDXF;
Interface
procedure lined(x1,y1,x2,y2:real;tline,col:integer;Pian:string);
Procedure OpenDXF(Nome,Prototipo:string);
procedure closedxf;
implementation

Var f,f1:text;
const

    Piano='  8';
    Nomi ='  2';
    Test ='  1';
    TLin ='  6';
    Pxi  ='  10';
    Pyi  ='  20';
    pzi  ='  30';
    AltT ='  40';
    pxf  ='  11';
    pyf  ='  21';
    pzf  ='  31';
    Color=' 62';
    Fine ='  0';
    FX=0.025;
    FY=0.025;
    {col:array[1..15] of integer=(4,3,4,1,6,7,7,8,13,11,12,9,14,2,7);}
var s1,s2,s3,s4,s5,sb1,sb2,estens,estens1,pianodxf,scolman,scolrip:string[20];
    real1,real2,real3,real4:real;
procedure lined(x1,y1,x2,y2:real;tline,col:integer;Pian:string);
begin
  writeln(f1,'LINE');
  writeln(f1,piano);
  writeln(f1,pian);
  writeln(f1,color);
  writeln(f1,col);
  writeln(f1,tlin);
  case tline of
    1:writeln(f1,'BYLAYER');
    2:writeln(f1,'DASHED');
    3:writeln(f1,'HIDDEN');
  END;
  writeln(f1,pxi);
  real1:=x1;
  str(real1:5:4,S4);
  writeln(f1,s4);
  s4:='';
  writeln(f1,pyi);
  real2:=y1;
  str(real2:5:4,S4);
  writeln(f1,s4);
  s4:='';
  writeln(f1,pxf);
  real1:=x2;
  str(real1:5:4,S4);
  writeln(f1,s4);
  s4:='';
  writeln(f1,pyf);
  real2:=y2;
  str(real2:5:4,S4);
  writeln(f1,s4);
  writeln(f1,fine);
end;


Procedure OpenDXF(Nome,Prototipo:string);

begin
  assign(f,prototipo);
  reset(f);
  assign(f1,nome);
  rewrite(f1);
  while NOT eof(f) do
  begin
    readln(f,s1);
    if (s1 <> 'ENTITIES')  then writeln(f1,s1) else
    begin
      readln(f,S2);
      readln(f,S3);
      writeln(f1,s1);
      writeln(f1,fine);
      exit;
    end;
  end;
end;
procedure closedxf;
begin
  writeln(f1,s3);
  writeln(f1,'  0');
  writeln(f1,'EOF');

  close(f);
  close(f1);
end;
end.