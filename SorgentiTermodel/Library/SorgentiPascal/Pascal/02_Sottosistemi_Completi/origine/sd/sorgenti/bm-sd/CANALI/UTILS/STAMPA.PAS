PROGRAM STAMPAFILE;
USES WINCRT,WINPRN,winprocs,winapi,wintypes;
VAR SOURCE,PRN:TEXT;
    Line:string;
    name:array[0..80]of char;
BEGIN
  write('Inserisci il nome del file da stampare:');
  readln(name);
  assign(source,name);
  reset(source);
  AssignDefPrn(prn);
  Titleprn(prn,name);
  setprnfont(prn,getstockobject(device_default_font));
  rewrite(prn);
  while not eof(source) do
  begin
    readln(source,line);
    writeln(prn,line);
    if keypressed and (readkey=#27) then
    begin
      abortprn(prn);
      break;
    end;
  end;
  close(prn);
  close(source);
END.