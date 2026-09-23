var registri:registers;

{--------------------------- INIT MOUSE ------------------------------------}

function  initmouse(var mousetype:string):integer;
begin
registri.AX:=0;
intr(51,registri);

if registri.AX<>0 then
   begin
   initmouse:=1;
   if registri.BX=2 then mousetype:='Microsoft mouse:2 pulsanti'
                    else mousetype:='Mouse sistem mouse:3 pulsanti';
   end
else
   begin
   initmouse:=0;
   Mousetype:='Mouse non installato ';
   end
end;

{------------------------- get mouse   -------------------------------------}


procedure getmouse(var x,y:integer;var pd,pc,ps:boolean);
var bmask:word;
    count:real;
    interrotto:Boolean;
begin
registri.ax:=3;
intr(51,registri);
x:=registri.cx div MIngX;
y:=registri.dx div MingY;




bmask:=1;
if (registri.bx and bmask)>0 then
  begin
  ps:=true;
  repeat
   registri.ax:=3;
   intr(51,registri);
   until (registri.bx and bmask)=0
  end
else ps:=false;

bmask:=2;
if (registri.bx and bmask)>0 then
  begin
  pd:=true;
  repeat
   registri.ax:=3;
   intr(51,registri);
   until (registri.bx and bmask)=0
  end
else pd:=false;

bmask:=4;
if (registri.bx and bmask)>0 then
  begin
  pc:=true;
  count:=0;
  interrotto:=false;
   repeat
   count:=count+1;
   registri.ax:=3;
   intr(51,registri);
   if (count>10000)and(not interrotto) then
     begin
     interrompi;
     interrotto:=true;
     pc:=false;
     end;
   until ((registri.bx and bmask)=0)
   end
else pc:=false;

{gotoxy(1,24);write('x:',x,'  y:',y,'  ps:',ps,'  pc:',pc,'  pd:',pd,'    ');}
end;


{-------------------------- M_Attivo --------------------------------------}
function M_attivo:boolean;
var mat:boolean;
begin

Mat:=false;

if not play  then
getmouse(M_X,M_Y,PDes,Pcen,Psin)
else
begin
  if (timecorr > nastro.tempo) and (nastro.mouse) then
    begin
      mat:=true;
      M_x:=round(nastro.x);
      M_y:=round(nastro.y);
      pdes:=nastro.pdes;
      pcen:=nastro.pcen;
      psin:=nastro.psin;
      if not (eof(fnastro)) then
        begin
        read(fnastro,nastro);
        NumStep:=NumStep+1;
        end
      else closeplay;
    end;
end;

If Not play then

  begin

if (pdes)or(pcen)or(psin) then Mat:=true;

if ((M_x<>xprec)or(M_y<>yprec))and(mousepres) then
    begin
    xprec:=M_X;
    YPrec:=M_Y;
    Mat:=true;
    end;
  if (rec)and(mat) and (not play) then
  begin
    nastro.mouse:=true;
    nastro.tempo:=timecorr;
    nastro.x:=M_x;
    nastro.y:=M_y;
    nastro.pdes:=pdes;
    nastro.pcen:=pcen;
    nastro.psin:=psin;
    write(fnastro,nastro);
  end;

  end;

  m_attivo:=mat;
end;

{-------------------------- cursor off -------------------------------------}
procedure cursor_off;
begin
registri.ax:=2;
intr(51,registri);
end;

{-------------------------- cursor on  -------------------------------------}

Procedure cursor_on;
begin
registri.ax:=1;
intr(51,registri);
end;

{------------------------  setpos ------------------------------------------}

procedure setpos(x,y:integer);
begin
registri.ax:=4;
registri.cx:=x;
registri.dx:=y;
intr(51,registri);
end;


{------------------------  rangex ------------------------------------------}

procedure rangex(xmin,xmax:integer);
begin
registri.ax:=7;
registri.cx:=xmin;
registri.dx:=xmax;
intr(51,registri);
end;
{------------------------  rangey ------------------------------------------}

procedure rangey(ymin,ymax:integer);
begin
registri.ax:=8;
registri.cx:=ymin;
registri.dx:=ymax;
intr(51,registri);
end;

{------------------------- Mouse init --------------------------------------}
procedure mouse_init;

begin
  if initmouse(mouset)=0 then mousepres:=false
  else
  begin
  mousepres:=true;
  rangex(1,MIngX*80);
  rangey(1,MIngY*25);
  cursor_off;
  getmouse(xprec,yprec,pdes,pcen,psin)
  end
end;

{--------------------------- M_On ------------------------------------------}
procedure M_ON;
begin
mousepres:=mousetemp;
end;
{--------------------------- M_Off ------------------------------------------}
procedure M_Off;
begin
mousetemp:=mousepres;
mousepres:=false;
end;

{----------------- Fine utilities del mouse --------------------------------}
