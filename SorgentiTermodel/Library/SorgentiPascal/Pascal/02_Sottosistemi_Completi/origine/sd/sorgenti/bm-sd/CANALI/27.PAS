program P27;
uses crt,dos;
var f:text;
    ch:integer;
begin
clrscr;
gotoxy(10,13);
write('carattere:');
read(ch);
assign(f,'esc');
rewrite(f);
write(f,chr(ch));
close(f);
end.