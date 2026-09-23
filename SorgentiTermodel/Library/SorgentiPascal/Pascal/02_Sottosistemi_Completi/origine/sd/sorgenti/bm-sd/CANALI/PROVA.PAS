PROCEDURE Inizzializza;

procedure loadsimb(nome:string);

var Fi:file of rigatab;

begin
  nsimb:=nsimb+1;
  elsimb[nsimb].iniz:=nrighetab+1;
  assign(fi,nome);
  reset(fi);
  while (not(eof(fi))) do
  begin
    nrighetab:=nrighetab+1;
    read(fi,tabella[nrighetab]);
  end;
  elsimb[nsimb].fin:=nrighetab;
  close(fi);
end;

begin
  nsimb:=0;
  nrighetab:=0;
  elsimb[nsimb+1].nviste:=4;
  loadsimb('fc1.prv');
  loadsimb('fc2.prv');
  loadsimb('fc3.prv');
  loadsimb('fc4.prv');
  limXi:=0;
  limXs:=560*1000/750;
  limYI:=0;
  limYS:=560;
  Xsup:=limXS;
  Xinf:=LIMXI;
  YSup:=LimYS;
  YInf:=LimYI;
  Xsupp:=limXS;
  Xinfp:=LIMXI;
  YSupp:=LimYS;
  YInfp:=LimYI;
  if exist('tubi.cfg') then
  begin
    assign(fc,'tubi.cfg');
    reset(fc);
    read(fc,vrec);
    close(fc);
    device:=vrec.scheda;
    mode:=vrec.modo;
  end else
  begin
    clrscr;
    gotoxy(10,12);write('IL PROGRAMMA NON E` STATO ANCORA CONFIGURATO');
    delay(1000);
    installa;
  end;
  xw1:=0;xw2:=900;yw1:=45;yw2:=750;
  col:=15;
  tline:=1;
  new(dis);
  c1:=0;
  setdev(@device);
  initgraphics(@mode);
  setworld(@minxw,@minyw,@maxxw,@maxyw);
  int1:=1;int2:=8;
  setlocator(@int1,@int2);
  mouse_init;
  setcolor(@c1);
  clr;
  real1:=500;real2:=350;
  orglocator(@real1,@real2);
  int1:=4;real1:=10;real2:=10;
  inithcur(@real2,@real1,@int1);
  loadmenu('tubi.mnu');
  scelta:=0;
  sw:=0;
  ultcom:=0;
  iso:=false;
  stpl:='';
  fscalag:=0;
  orientg:=0;
end;