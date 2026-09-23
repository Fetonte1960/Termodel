
function IntToHex(IntNum:longint):St4;
const
    HexCar: array[0..15] of char = '0123456789ABCDEF' ;




VAR
   i,ind:integer;
   A1,A2:real;
   TempStr:string[4];

begin
   TempStr:='    ';
   for i:=4 downto 1 do
    begin
       A2:=IntNum/16;
       A1:=A2-trunc(A2);
       Ind:=Trunc(A1*16);
       TempStr[i]:=HexCar[Ind];
       IntNum:=trunc(A2-A1);
    end;
   IntToHex:=TempStr;
end;


procedure Gesterror;
var ft:text;
    buf,str1:st80;
    ch:char;
    i:integer;
    primo,secondo:st4;
    punt:longint;
    Pp:^longint;
begin



ExitProc:=VecchiaExit;
if (ErrorAddr<>nil)and(ExitCode<>4) then
  begin
  {$ifdef dos}
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


  pp:=@erroraddr;

  Punt:=pp^;

  primo:=IntToHex(hiword(punt));
  secondo:=IntToHex(loword(Punt));

  TextColor(col[4]);TextBackground(col[3]);
  gotoxy(53,3);write(primo,':',secondo(*seg(erroraddr),':',ofs(erroraddr)*));
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
    write('Contattare l`ufficio assistenza della MC4 Software');
    end;
  close(ft);

  while keypressed do ch:=readkey;
  ch:=readkey;
  Window(1,1,80,25);
  Textcolor(15);textbackground(0);clrscr;
  gotoxy(1,80);
  {$endif}
  {$ifdef win}
  postmessage(pmainwin^.hwindow,wm_command,124,0);
  {$endif}
  end;


end;

procedure errori(rap,cs,rim:st8);
begin
 rapporto:=rap;
 causa:=cs;
 rimedio:=rim;
 vecchiaexit:=ExitProc;
 Exitproc:=@Gesterror;
end;

