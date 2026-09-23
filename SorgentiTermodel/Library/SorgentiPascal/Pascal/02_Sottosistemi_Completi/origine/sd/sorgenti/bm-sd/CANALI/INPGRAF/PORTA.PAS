{$M $4000,0,0}




 program porta;


 uses crt,dos;

 var f,f1,f2:text;
     k:integer;
     ch:char;
     ch1:char;
     J:REAL;

begin

 ch1:=' ';
 assign(f,'com2');
 rewrite(f);
 assign(f1,'spol.plt');
 reset(f1);
 assign(f2,'com2');
 reset(f2);
 textbackground(1);
 textcolor(15);
 CLRSCR;

 while not eof(f1) do
   begin
       read(f1,ch);
       write(f,CH);
       j:=j+1;
       gotoxy(10,13);
       write('Stampa del vettore nø: ',j:6:0);

   end;
 close(f);
 close(f1);
 end.