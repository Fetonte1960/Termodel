{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit Demo;

INTERFACE

uses Dos;

{$I Varplay}

Procedure InitNastro(demo_dr:String);
Procedure CloseNastro;
Procedure Interrompi;
function timecorr:real;
procedure Closeplay;

{---------------------------------------------------------------------------}
implementation


{************************** EXIST *****************************************}

 function Exist(Nome:string):boolean;
 var f:file;
 begin
    exist:=false;
    {$I-} assign(f,Nome);reset(f);{$I+}
    if (ioresult=0) then
    begin
      close(f);
      Exist:=true
    end;
 end;


function timecorr:real;
var ora,minuto,secondo,sec100:word;
begin
 // gettime(ora,minuto,secondo,sec100);
  {timecorr:=(ora*36000+minuto*600+secondo*10+sec100 div 10)-timeiniz;}
end;

procedure Closeplay;
var Fer:file;
begin
play:=false;
close(Fnastro);
assign(fer,Demo_Drive+'play.sci');
erase(fer);
end;


Procedure Interrompi;
var Ftxt:text;
    F_R:file of real;
    tmin:real;
begin
write(chr(7));
if rec then
  begin
  close(Fnastro);
  rec:=false;
  assign(F_r,Demo_Drive+'oldtime.sci');
  rewrite(F_r);
  tmin:=timecorr;
  write(F_r,tmin);
  Close(F_r);
  end
else
if (not play)and(exist(Demo_Drive+'nastro.dat'))and
   (exist(Demo_Drive+'oldtime.sci')) then
  begin
  rec:=true;
  assign(fnastro,Demo_Drive+'nastro.dat');
  reset(fnastro);

  seek(Fnastro,Filesize(Fnastro));

  assign(ftxt,Demo_Drive+'rec.sci');
  rewrite(ftxt);
  write(ftxt,'pippo');
  close(ftxt);

  assign(F_r,Demo_Drive+'oldtime.sci');
  reset(F_r);
  read(F_r,tmin);
  Close(F_r);
  timeiniz:=0;
  timeiniz:=timecorr;
  timeiniz:=timeiniz-tmin;
  end;
end;

Procedure InitNastro(demo_dr:String);
begin
Demo_Drive:=demo_Dr;
rec:=exist(Demo_Drive+'rec.sci');

  if exist(Demo_Drive+'play.sci') then
    begin
    play:=true;
    if exist(Demo_Drive+'time.sci') then
      begin
      assign(F_t,Demo_Drive+'time.sci');
      reset(F_T);
      read(F_T,NumStep);
      Close(F_t);
      end
    else Numstep:=0;
    end
  else play:=false;

  timeiniz:=0;
  timeiniz:=timecorr;
  if play then
  begin
    assign(fnastro,Demo_Drive+'nastro.dat');
    reset(fnastro);
    if NumStep<>0 then Seek(Fnastro,Numstep-1);
    read(fnastro,nastro);
  end
  else
  begin
  if rec then
    begin
    if exist(Demo_Drive+'nastro.dat')then
      begin
      assign(fnastro,Demo_Drive+'nastro.dat');
      reset(fnastro);
      seek(Fnastro,Filesize(Fnastro));
      end
    else
      begin
      assign(fnastro,Demo_Drive+'nastro.dat');
      rewrite(fnastro);
      end;
    end;
  end;
End;

Procedure CloseNastro;
begin
if rec or play then
  begin
  assign(F_t,Demo_Drive+'time.sci');
  rewrite(F_T);
  write(F_T,NumStep);
  Close(F_t);
  close(fnastro);
  rec:=false;
  play:=false;
  end;
End;

end.