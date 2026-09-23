Unit scritte;

Interface

uses
{$Ifdef Windef}
  dummyfunction,
{$else}
  Crt,
  Dos,
{$endif}
definizcan,wm,utilitie;{defin_ca}

Procedure WNodo(nome:link);
Procedure WFase(nome:string);

implementation

Procedure WFase(nome:string);
begin
{$ifdef dos}
//textcolor(7);
{$else}
//nome:=oem_ans(nome);
{$endif}
//gotoxy(10,10);

//write(Nome);
//clreol;
end;

Procedure WNodo(nome:link);
begin
// nome<>nil then
  begin
  gotoxy(10,12);
 // write(w_m(53),Nome.codtab:3);{*TR*}
  clreol;
  end;
end;

end.