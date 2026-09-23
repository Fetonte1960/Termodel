unit UUtigen;

interface
//Function W_m(ss:integer):string;
//Function Exist(ss:string):boolean;
//Function SETLEFT(ss:string):string;
//Function SetRight(ss:string):string;
//Function UpString(ss:string):string;
Procedure Saltopag;
Procedure StampaMask(tseg,TOFS:integer;Mask:string;bool:boolean);
Procedure WriteTesto(ss:string);
Function Formst(ss:string):string;
Function Eliminadir(ss:string):string;
Procedure initprogram;
procedure Messagebeep(dd:integer);
Procedure gotoxy(x,y:integer);
Function Get_drive:string;
Var dicitura,circ1,circ2,
    drivemess,drivemask:string;
    //CYes:char;
    lst,glst:text;
    St_8:string[8];
    stampe_word,flagstampa:boolean;
Type st126=string[126];
     st4=string[4];
     st3=string[3];
     st60=string[60];
     st30=string[30];
Const cno='*';
      ch17='?';
      ch63='tubi';
      ch18='?';
      CYes='S';
implementation
uses {UMain_calcTubi,}sysutils;
Function Get_drive:string;
begin
result:='c:\ded';
end;
Function W_m(ss:integer):string;
begin
//echo('errore:'+inttostr(SS));
Result := inttostr(SS);
end;
Function Exist(ss:string):boolean;
begin
 Result := FileExists(ss);
end;
Function SETLEFT(ss:string):string;
begin
end;
Function UpString(ss:string):string;
begin
end;
Procedure Saltopag;
begin
end;
Procedure StampaMask(tseg,TOFS:integer;Mask:string;bool:boolean);
begin
end;
Procedure WriteTesto(ss:string);
begin
end;
Function SetRight(ss:string):string;
begin
end;
Function Formst(ss:string):string;
begin
end;
Function Eliminadir(ss:string):string;
begin
end;
Procedure initprogram;
begin
end;
procedure Messagebeep(dd:integer);
begin
end;
Procedure gotoxy(x,y:integer);
begin
end;
end.
