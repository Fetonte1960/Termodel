procedure rinfresca;

var i:integer;


begin
   setwritemode(0);
   c1:=0;
   int1:=1;
   setlnstyle(@int1);
   real1:=910;real2:=40;
   movabs1(@real1,@real2);
   real1:=910;real2:=750;
   int1:=2;
   setcolor(int1);
   lnabs1(@real1,@real2);
   real1:=0;real2:=40;
   movabs1(@real1,@real2);
   real1:=1000;real2:=40;
   lnabs1(@real1,@real2);

   int1:=2;
   settextclr(@int1,@c1);
   real1:=920;real2:=730;
   movtcurabs1(@real1,@real2);
   text1(@mc4);
   deltcur;
   real1:=920;real2:=710;
   movtcurabs1(@real1,@real2);
   int1:=4;
   settextclr(@int1,@c1);
   text1(@mc4t);
   deltcur;
   int1:=15;
   settextclr(@int1,@c1);

   for i:=1 to righemenu do
    begin
     real1:=920;real2:=700-35*i;
     movtcurabs1(@real1,@real2);
     text1(@gm[i]);
     deltcur;
    end;
end;
procedure loadmenu(nomemenu:st80);

var fi:text;
    i:integer;
begin
assign(fi,nomemenu);
reset(fi);
i:=0;
  while (not(eof(fi)))and(i<maxrighe) do
    begin
    i:=i+1;
    readln(fi,gm[i]);
    end;
righemenu:=i;
close(fi);
end;


procedure writemenu(y:real;var campoprec:integer;start:boolean);
const xsin:real=900;
var   camposel:integer;
      i:integer;
begin
if start then
  begin
   real1:=910;real2:=0;
   movabs1(@real1,@real2);
   real1:=910;real2:=750;
   int1:=4;
   setcolor(int1);
   lnabs1(@real1,@real2);
   real1:=0;real2:=40;
   movabs1(@real1,@real2);
   real1:=1000;real2:=40;
   lnabs1(@real1,@real2);
{   setfont(@font);}
   int1:=1;int2:=1;int3:=0;int4:=1;
   settext(@int1,@int2,@int3,@int4);
   int1:=2;int2:=0;
   settextclr(@int1,@c1);
   real1:=920;real2:=730;
   movtcurabs1(@real1,@real2);
   text1(@mc4);
   deltcur;
   real1:=920;real2:=710;
   movtcurabs1(@real1,@real2);
   int1:=4;int2:=0;
   settextclr(@int1,@int2);
   text1(@mc4t);
   deltcur;
   rinfresca;
  end
  else
   begin
  camposel:=round((700-y)/35);
  if camposel<1 then camposel:=1;
  if camposel>righemenu then camposel:=righemenu;
  if campoprec<>camposel then
    begin
     real1:=920;real2:=700-35*campoprec;
     int1:=15;int2:=0;
     settextclr(@int1,@c1);
     movtcurabs1(@real1,@real2);
     text1(@gm[campoprec]);
     real1:=920;real2:=700-35*camposel;
     int1:=0;int2:=10;
     settextclr(@int1,@int2);
     movtcurabs1(@real1,@real2);
     text1(@gm[camposel]);
     campoprec:=camposel;
    end
  end;
end;







function Gmenu:integer;

var i,cprec:integer;
      ch:char;
begin
  int1:=15;
  settextclr(@int1,@c1);
  cprec:=2;
  i:=2;
  ch:=' ';
  y1:=680;
  x1:=950;

  repeat

   if m_attivo(x,y,sw) then
     begin
     x1:=round(x);
     y1:=round(y);
     end;

   if keypressed then
    begin
    ch:=readkey;
    if (ch=CHR(72))and(y1<=650)then y1:=y1+35;
    if (ch=CHR(80))and(y1>=710-35*righemenu)then y1:=y1-35;
    end;

  if x1>=910 then writemenu(y1,cprec,false)
  else cprec:=0;

  until (ch=chr(13))or (sw=132) or (x1<910);

  rinfresca;
  gmenu:=cprec;

end;


{******************************* INSTALLA ********************************}


procedure installa;

type frec=record
          descrscheda:string;
          scheda:string;
          modo:integer;
          end;

var a,b,c,v:integer;
    f:file of frec;
    vrec:frec;
    sn,st1,st2,st3:char;
    st:string;
    sta:string;
procedure visualizza;
begin
 assign(f,'tubi.cfg');
 reset(f);
 read(f,vrec);
 clrscr;
 gotoxy(5,7);Write('Configurazione corrente:');
 gotoxy(10,12);write('Monitor :     ',vrec.descrscheda);
 gotoxy(10,14);write('Digitizer:    ');
 gotoxy(10,16);write('Plotter:      ');
 gotoxy(10,18);write('Stampante:    ');
 gotoxy(5,22);write('Premere un tasto per continuare');
 repeat until keypressed;
 st3:=readkey;
end;




procedure elenco;
begin
  clrscr;
  st:='';
  repeat
    gotoxy(10,2);write('1.Herchules Monocrome ');
    gotoxy(10,3);write('2.IBM Color Graphics Adapter');
    gotoxy(10,4);write('3.IBM Ehanced Graphics Adapter');
    gotoxy(10,5);write('4.IBM Video Graphics Array');
    gotoxy(10,6);write('5.Toshiba Video Plasma');
    gotoxy(10,7);write('6.');
    gotoxy(10,8);write('7.');
    gotoxy(10,9);write('8.');
    gotoxy(10,10);write('9.');
    gotoxy(9,11);write('10.');
    gotoxy(9,12);write('11.');
    gotoxy(9,13);write('12.');
    gotoxy(9,14);write('13.');
    gotoxy(9,15);write('14.');
    gotoxy(9,16);write('15.');
    gotoxy(5,22);write('--------- Premere INVIO per visualizzare l''elenco successivo-------');
    st1:=readkey;
    if (st1=chr(32))or (st1=chr(13)) then b:=0
  until (b =0);
  if b=0 then
  begin
    clrscr;
    st:='';
    repeat
      gotoxy(9,2);write('16.');
      gotoxy(9,3);write('17.');
      gotoxy(9,4);write('18.');
      gotoxy(9,5);write('19.');
      gotoxy(9,6);write('20.');
      gotoxy(9,7);write('21.');
      gotoxy(9,8);write('22.');
      gotoxy(9,9);write('23.');
      gotoxy(9,10);write('24.');
      gotoxy(9,11);write('25.');
      gotoxy(9,12);write('26.');
      gotoxy(9,13);write('27.');
      gotoxy(9,14);write('28.');
      gotoxy(9,15);write('29.');
      gotoxy(9,16);write('30.');
      gotoxy(5,22);write('Selezionare la voce ( ? per visualizzare l''elnco ): ');
      readln(st);
      if st >'' then
      begin
        val(st,b,v);
        if (not (b in[1..30]))and(st[1]<>'?') then
        begin
          gotoxy(1,22);clreol;
          gotoxy(5,22);write('Dati non validi');
          delay(2000);
          gotoxy(1,22);clreol;
        end;
      end ;
    until (b in [1..30])or (st[1]='?');
    st:='';
  end;
end;



begin
clrscr;
if exist('tubi.cfg') then visualizza;
repeat
  sta:='';
  sta[1]:=' ';
  clrscr;
  gotoxy(5,1);write('MC4 Software srl');
  gotoxy(5,2);write('Calcolo tubazioni');
  gotoxy(5,3);write('release 4.0 1990');
  gotoxy(10,8);write('Menu di configurazione');
  gotoxy(10,10);write('0.Uscita ');
  gotoxy(10,11);write('1.Configurazione corrente');
  gotoxy(10,12);write('2.Configurazione del Video');
  gotoxy(10,13);write('3.Configurazione del Digitizer');
  gotoxy(10,14);write('4.Configurazione del Plotter');
  gotoxy(10,15);write('5.Configurazione della Stampante ');
  gotoxy(5,20);write('Selezionare la voce : ');
  readln(sta);
  if sta>'' then
  begin
    val(sta,a,v);
    if not (a in[0..5]) then
    begin
      gotoxy(5,20);write('                                            ');
      gotoxy(5,20);write('Dati non validi');
      delay(2000);
      gotoxy(5,20);write('                                            ');
    end;

    case a of

     1: visualizza;
     2: begin
         elenco;
         if st[1]='?' then
         begin
           repeat
            st[1]:=' ';
            elenco;
           until b in [1..30];
           st:=''
         end;
        case b of

         1:begin
            vrec.scheda:='haloherc.dev';
            vrec.descrscheda:='Herchules Monocrome ';
            vrec.modo:=7;
           end;
         2:begin
             vrec.scheda:='haloibmg.dev';
             vrec.descrscheda:='IBM Color Graphics Adapter';
             clrscr;
              gotoxy(10,10);write('La scheda grafica CGA puo` visualizzare quattro');
              gotoxy(10,11);write('colori,con una risoluzione di  300 x 200  punti');
              gotoxy(10,12);write('mentre  se  usata  in  modo  monocromatico  la ');
              gotoxy(10,13);write('risoluzione e` di 600 x 200 punti.');
              repeat
              gotoxy(10,18);write('Desiderate il modo monocromatico ? (S/N): ');
              read(st2);
              st2:=upcase(st2);
              if not (st2 in['S','N']) then
              begin
                gotoxy(1,20);clreol;
                gotoxy(5,20);write('Si o No per favore !');
                delay(1000);
                gotoxy(1,20);clreol;
              end;
             until st2 in ['S','N'];
             if st2='S' then vrec.modo:=1 else vrec.modo:=0;
           end;
         3:begin
             vrec.descrscheda:='IBM Ehanced Graphics Adapter';
             vrec.scheda:='haloibme.dev';
             vrec.modo:=4;
           end;
         4:begin
             vrec.descrscheda:='IBM Video Graphics Array';
             vrec.scheda:='haloibmv.dev';
             vrec.modo:=7;
           end;
         5:begin
             vrec.scheda:='halotosh.dev';
             vrec.descrscheda:='Toshiba Video Plasma';
             vrec.modo:=2;
           end;
        end; {case b}
     end; {2:}
   3:;
   4:;
   5:;
  end;{case}
 end; {if sta>''}
until sta[1] =chr(48);
sta[1]:=' ';
repeat
 gotoxy(5,22);write('Volete registrare le modifiche ? (S/N):');
 read(sn);
 sn:=upcase(sn);
 if not (sn in['S','N']) then
     begin
      gotoxy(1,24);clreol;
      gotoxy(5,24);write('Si o No per favore !');
      delay(1000);
      gotoxy(1,24);clreol;
    end;
until (upcase(sn)='S') or (upcase(sn)='N');
if upcase(sn)='S' then
begin
 assign(f,'tubi.cfg');
 rewrite(f);
 write(f,vrec);
 close(f);
end;
end;{Installa}
