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
    risp:string;
    punt:longint;
    Pp:^longint;
    me_p:array[0..180] of char;
    str_s:string[180];
    fd:text;
begin
ExitProc:=VecchiaExit;

if (ErrorAddr<>nil)and(ExitCode<>4) then
  begin
  {$ifdef dos}
  Closegraphics;
  textcolor(7);
  textbackground(1);
  clrscr;
  assign(ft,'errori.msk');
  reset(ft);
  while not eof(ft) do
    begin
    readln(ft,buf);
    writeln(buf);
    end;
  close(Ft);
  {$endif}

  pp:=@erroraddr;

  Punt:=pp^;

  primo:=IntToHex(hiword(punt));
  secondo:=IntToHex(loword(Punt));
  {$ifdef dos}
  TextColor(15);TextBackground(1);
  gotoxy(53,3);write(primo,':',secondo(*seg(erroraddr),':',ofs(erroraddr)*));
  gotoxy(29,3);write(EXitCode);
  assign(fd,'error.deb');
  rewrite(fd);
  writeln(fd,'indirizzo : ',primo,':',secondo);
  writeln(fd,'codice: ',exitcode);
  close(fd);
  {$endif}
  str(ExitCode,Str1);
  ErrorAddr:=nil;
  {$ifdef dos}
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

  Window(1,1,80,25);clrscr;
    repeat
    gotoxy(10,10);
    write('                                                   ');
    gotoxy(10,10);
    write('Volete salvare le modifiche ? [s/n]:');
    readln(risp);
    until (upstring(risp)='S')or(upstring(risp)='N');
  if upstring(risp)='S' then savedis(driveprog+NomeProg);
   Textcolor(15);textbackground(0);clrscr;
   {$endif}
   {$ifdef win}
   str_s:=
   'Si Š verificato un errore di tipo: '+str1+' all''indirizzo '+primo+':'+secondo+' il programma non pu• proseguire';{*TR*}
   strpcopy(me_p,str_s);
   oemtoansi(me_p,me_p);
   bwccmessagebox(0,me_p,'Segnalazione di errore di Run-time',{*TR*}
                  Mb_ok or Mb_systemModal or MB_ICONEXCLAMATION);
   pdw^.salva_disegno;
   pmainwin^.done;
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

