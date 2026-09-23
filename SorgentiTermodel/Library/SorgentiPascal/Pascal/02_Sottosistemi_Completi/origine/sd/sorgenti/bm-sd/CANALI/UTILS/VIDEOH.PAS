Procedure Write_Video(NomeF:String);
Var Linea,i,j,colore,verr:Integer;
    Buf:String;
    FMess,frame:Text;
    Fine,Tasto:Boolean;
    ch:Char;


Begin
If EXist(Nomef) then
  begin

    { Titolo }
  cursoron(false);
  Window(1,1,80,25);
  TextColor(Col[9]);
  TextBackGround(Col[8]);
  Assign(Fmess,NomeF);
  reset(FMess);
  if eof(Fmess) then exit;
  readln(Fmess,Buf);
  gotoxy(1,1);
  write(Buf);Clreol;

     { riquadro }

  gotoxy(1,2);

  if exist('frame.msk') then
    begin
    assign(frame,'Frame.msk');
    reset(Frame);
    TextColor(Col[2]);
    TextBackGround(Col[1]);
    i:=0;
    while not eof(Frame) do
      begin
      i:=i+1;
      if i>22 then
        begin
        TextColor(Col[20]);
        TextBackGround(Col[19]);
        end;
      readln(frame,buf);
      gotoxy(1,i+1);
      write(buf);
      clreol;
      end;
    close(frame);
    end;


  Linea:=1;
  Fine:=False;
  Window(3,3,78,22);
  TextBackGround(Col[1]);
  TextColor(Col[4]);
  repeat
    reset(FMess);
    for i:=1 to linea do Readln(Fmess,Buf);
    GotoXy(1,1);
    for i:=1 to 20 do
      begin
      GotoXy(1,i);
      if eof(Fmess) then clreol
      else
        begin
        Readln(FMess,Buf);
	for j:=1 to length(buf) do
	begin
	  if buf[j] <> 'ù' then Write(Buf[j])
	  else
	  begin
	    j:=j+1;
	    val(buf[j],colore,verr);
	    textcolor(colore);
	    j:=j+1;
	    while (buf[j] <> 'ù')  do
	    begin
	      write(buf[j]);
	      j:=j+1;
	    end;
            textcolor(col[4]);
	  end;
	end;
        ClrEol;
        end;
      end;
      Tasto:=False;
      repeat
      readKbd(ch);
      if ord(ch)=27 then
        begin
        if keypressed_N then
        begin
          readkbd(ch);
          case (ord(ch)) of
          81:begin
               if eof(Fmess) then Write(Chr(7))
               else
               begin
                 linea:=linea+20;
                 Tasto:=true;
               end;
             end;
          73:begin
               if linea<=20 then Write(Chr(7))
               else
               begin
                 linea:=linea-20;
                 Tasto:=true;
               end;
             end;
          72:begin
               if linea=1 then Write(Chr(7))
               else
               begin
                 linea:=linea-1;
                 Tasto:=true;
               end;
             end;
          80:begin
               if eof(Fmess) then Write(Chr(7))
               else
               begin
                 linea:=linea+1;
                 Tasto:=true;
               end;
             end;
          end;
        end
        else fine:=true;
        end;
      until (Tasto)or (fine);

  until fine;
  close(FMess);
  end;
  cursoron(true);
end;