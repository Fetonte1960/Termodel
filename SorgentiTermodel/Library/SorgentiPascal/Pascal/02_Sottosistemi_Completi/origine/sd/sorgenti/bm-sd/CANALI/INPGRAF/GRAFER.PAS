{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit Grafer;

INTERFACE

uses halotp4,definiz,genproc,Load_d,esiste;

type st8=string[8];
     st4=string[4];
     st80=string[80];



procedure errori(rap,cs,rim:st8);

{---------------------------------------------------------------------------}
implementation

Var vecchiaex:pointer;
    Rapporto,causa,rimedio:string;


function IntToHex(IntNum:integer):St4;
const
    HexCar: array[0..15] of char = '0123456789ABCDEF' ;

VAR
   Temp   :byte;
   TempStr:string[2];
begin
   Temp    := hi(IntNum);
   TempStr := HexCar[Temp shr 4] + HexCar[Temp and $0F];
   Temp    := lo(IntNum);
   IntToHex:= TempStr + HexCar[Temp shr 4] + HexCar[Temp and $0F]
   end;

procedure Gesterror;
var ft:text;
    buf,str1:st80;
    ch:char;
    i:integer;
    primo,secondo:st4;
begin
(*
ExitProc:=VecchiaEx;
closegraphics;
if (ErrorAddr<>nil)and(ExitCode<>4) then
  begin
  textcolor(col[2]);
  textbackground(col[1]);
  clrscr;
  assign(ft,'errori.msk');
  reset(ft);
  while not eof(ft) do
    begin
    readln(ft,buf);
    writeln(buf);
    end;
  close(Ft);

  primo:=IntToHex(seg(ErrorAddr^));
  secondo:=IntToHex(ofs(ErrorAddr^));
  TextColor(col[4]);TextBackground(col[3]);
  gotoxy(53,3);write(primo,':',secondo{seg(erroraddr),':',ofs(erroraddr)});
  gotoxy(29,3);write(EXitCode);
  str(ExitCode,Str1);
  ErrorAddr:=nil;

  {** Rapporto **}

  assign(ft,rapporto+'.msg');
  reset(ft);
  repeat readln(ft,buf) until (Upstring(Buf)='E'+Str1)or (eof(ft));

  if not eof(ft) then
    begin
    readln(ft,buf);gotoxy(3,4);write(buf);
   close(ft);
    end;

  {** Causa **}

  assign(ft,Causa+'.msg');
  reset(ft);
  repeat readln(ft,buf) until (Upstring(Buf)='E'+Str1)or (eof(ft));

  i:=0;
  if not eof(ft) then
  while buf<>'<**>'Do
    begin
    readln(ft,buf);gotoxy(3,7+i);
    if buf<>'<**>' Then write(buf);
    i:=i+1
    end
  else
    begin
    gotoxy(3,7);
    write('Non identificabile')
    end;

  close(ft);
  {** Rimedio **}

  assign(ft,Rimedio+'.msg');
  reset(ft);
  repeat readln(ft,buf) until (Upstring(Buf)='E'+Str1)or (eof(ft));

  i:=0;
  if not eof(ft) then
  while buf<>'<**>'Do
    begin
    readln(ft,buf);gotoxy(3,15+i);
    if buf<>'<**>' Then write(buf);
    i:=i+1
    end
  else
    begin
    gotoxy(3,15);
    write('Contattare l`ufficio assistenza della MC4 Software');{*TR*}
    end;
  close(ft);

  while keypressed do ch:=readkey;
  ch:=readkey;
  clrscr;

  Window(1,1,80,25);
  gotoxy(10,6);
  write(salva_val:6:1);
  {gotoxy(10,8);
  write(salva_val1:6:1);}
  gotoxy(10,10);

  write('Volete salvare le modifiche [s/n]');{*TR*}
  repeat
  ch:=readkey;
  if not(upcase(ch) IN ['S','N']) then write(chr(7));{*TR*}
  until upcase(ch) IN ['S','N'];                     {*TR*}
  clrscr;
  if  upcase(ch)='S' then Savedis(DataDrive+NomeProg); {*TR*}

  Textcolor(15);textbackground(0);clrscr;
  gotoxy(1,80);
  end;
*)

end;

procedure errori(rap,cs,rim:st8);
begin
(*
 rapporto:=rap;
 causa:=cs;
 rimedio:=rim;
 vecchiaex:=ExitProc;
 Exitproc:=@Gesterror;
 *)
end;

end.