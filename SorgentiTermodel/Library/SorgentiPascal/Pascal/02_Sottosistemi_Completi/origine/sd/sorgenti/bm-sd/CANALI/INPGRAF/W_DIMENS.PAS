program w_dimens;
uses dimens,
  inituti,
  wincrt,
  strings,
  utilitie,
  winprocs,
  wintypes {$ifdef delphi},
  messages {$endif},
  Interf3d ;
var f:text;                 
    st:string[200];
    pc:array[0..200] of char;
begin
  chdir(get_drive+'\cca\inpgraf');
  {$ifdef francia}
  StrCopy(WindowTitle,'Mc4 Software: Generation dessin dimensionné');
  {$endif}
  {$ifdef italia}
  StrCopy(WindowTitle,'Mc4 Software: Generazione disegno dimensionato');
  {$endif}
  {$ifdef spagna}
  StrCopy(WindowTitle,'Mc4 Software: Generar dibujo dimensionado');
  {$endif}
  {$ifdef inglese}
  StrCopy(WindowTitle,'Mc4 Software: Size drawing generation');
  {$endif}

  InitWinCrt;
  initprogram;
  main_dim;
  assign(f,'wintxt.dat');
  reset(f);
  read(f,st);
  strpcopy(pc,st);
  hd:=0;
  hd:=findwindow('TurboWindow',pc);
  if hd<> 0 then
  sendmessage(hd,wm_command,10101,0);
  donewincrt;
end.
