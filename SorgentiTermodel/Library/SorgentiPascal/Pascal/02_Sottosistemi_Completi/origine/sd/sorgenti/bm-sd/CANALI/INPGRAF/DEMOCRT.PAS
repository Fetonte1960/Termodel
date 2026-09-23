{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}


Unit DemoCrt;

Interface

Uses

  Crt, {Unit found in TURBO.TPL}
  Dos, {Unit found in TURBO.TPL}
  Turbo3; {Unit found in TURBO3.TPU}

{$I Varplay}

function keypressed_n:boolean;
Procedure ReadKbd(Var ch:Char);
function timecorr:real;

Implementation


function timecorr:real;
var ora,minuto,secondo,sec100:word;
begin
  gettime(ora,minuto,secondo,sec100);
  timecorr:=(ora*36000+minuto*600+secondo*10+sec100 div 10)-timeiniz;
end;

procedure Closeplay;
var Fer:file;
begin
play:=false;
close(Fnastro);
assign(fer,Demo_Drive+'play.sci');
erase(fer);
end;



function keypressed_n:boolean;
begin
  if play and keypressed then
    begin
    clrscr;
    halt;
    end;
  if play then keypressed_n:= (nastro.tempo<=timecorr) and (not nastro.mouse)
  else  keypressed_n:=keypressed;
end;

Procedure ReadKbd(Var ch:Char);
Begin
if play then
  begin
  repeat until timecorr >Nastro.Tempo;
  ch:=nastro.car;
  if not eof(fnastro) then
    begin
    read(fnastro,nastro);
    NumStep:=NumStep+1;
    end
  else closeplay;
  end
else
  begin
  if rec then
  if Not(Composto) then nastro.tempo:=timecorr;
  READKBD(CH);
  if rec then
    begin
    If (ord(ch)=27)and(keypressed) then composto:=true else composto:=false;
    nastro.car:=ch;
    nastro.mouse:=false;
    write(fnastro,nastro);
    end;
  end;
end;

end.