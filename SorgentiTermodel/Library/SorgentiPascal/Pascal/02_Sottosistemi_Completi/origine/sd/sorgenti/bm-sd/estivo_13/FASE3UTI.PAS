
{---------------------- LOADMASK --------------------------------------------}
PROCEDURE LOADMASK;

VAR F:TEXT;
    BUF :STRING[80];
    fn:BOOLEAN;

BEGIN
  {$ifdef dos}
  TEXTCOLOR(7);
  CLRSCR;
  ASSIGN(F,'RTAMB.MSK');RESET(F);
  REPEAT
  READLN(F,BUF);
  FN:=EOF(F);
  IF NOT FN THEN WRITELN(BUF) ELSE WRITE(BUF)
  UNTIL FN;
  TEXTCOLOR(15);
  close(F)
  {$endif}
END;

{--------------------------- CLRMASK ----------------------------------------}

PROCEDURE CLRMASK;

VAR X,Y:INTEGER;

BEGIN
  {$ifdef dos}
  GOTOXY(41,2);WRITE('   ');
  GOTOXY(46,2);WRITE('                   ');
  GOTOXY(7,4);WRITE('     ');
  GOTOXY(32,4);WRITE('       ');
  GOTOXY(59,4);WRITE('              ');
  GOTOXY(3,7);WRITE('            ');
  GOTOXY(20,7);WRITE('  ');

  X:=26;
  REPEAT
    FOR Y:= 9 TO 14 DO
    BEGIN
    GOTOXY(X,Y);
    WRITE('      ')
    END;
    GOTOXY(X,16);
    WRITE('      ');
    X:=X+13
  UNTIL X > 65;

  GOTOXY(28,18);WRITE('          ');
  GOTOXY(47,18);WRITE('  ');
  GOTOXY(73,18);WRITE('  ');
  GOTOXY(22,20);WRITE('      ');
  GOTOXY(36,20);WRITE('      ');
  GOTOXY(58,20);WRITE('      ');
  {$endif}
END;


{------------------------ TASTOPAUSA ---------------------------------------}

PROCEDURE TASTOPAUSA;
BEGIN
END;
