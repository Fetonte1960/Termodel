unit UInterattiva;


interface
uses   Graphics,controls;

Procedure M_DOWN(button:Tmousebutton;x,y:integer);
Procedure M_Move(X,Y:integer);
Procedure init_Interattiva;
Procedure M_UP(button:Tmousebutton;x,y:integer);

const Niente=0;
      L_PrimoP=1;
      L_SecondoP=2;
      Cancella_P=3;
      D_Finestra=4;
Var modo:integer;
ultx,ulty:integer;
I_xprec,I_yprec:integer;
PrimavoltaGrafica:boolean;
canvcor:Tcanvas;
ofx,ofy:integer;
implementation
uses sofrad,grafica;

Procedure init_Interattiva;
begin
ingfisso:=false;
ultx:=-10;
ulty:=0;
Modo:=Niente;
PrimavoltaGrafica:=true;
canvcor:=form1.Disegno.Canvas;
ofx:=0;
ofy:=0;
end;

Procedure orto(var x,y:integer);
begin
if (form1.chorto.checked)and(modo=L_secondop) then
  begin
  if abs(x-I_xprec)>abs(Y-I_Yprec) then y:=I_Yprec
  else x:=I_Xprec;
  end;
end;

Procedure Croce(x,Y:integer);
begin
 with canvcor do
  begin
  pen.mode:=pmnotxor;
  Pen.Color:=clblack;
  Pen.Style:=PsSolid;
  Pen.Width:=1;
  if (x>=0) then
    begin
    Moveto(x-10,y);
    Lineto(x+10,y);
    Moveto(x,y-10);
    Lineto(x,y+10);
    end;
  end;
end;

Procedure Linea(x,y:integer);
begin
with canvcor do
  begin
  pen.mode:=pmnotxor;
  Pen.Color:=clblack;
  Pen.Style:=PsSolid;
  Pen.Width:=1;
  Moveto(I_xprec,I_yprec);
  Lineto(x,y);
  end;
end;

Procedure Minibox(x,y:integer);
begin
with canvcor do
  begin
  pen.mode:=pmnotxor;
  Pen.Color:=clblack;
  Pen.Style:=PsSolid;
  Pen.Width:=1;
  Moveto(x-5,y-5);
  Lineto(x+5,y-5);
  Lineto(x+5,y+5);
  Lineto(x-5,y+5);
  Lineto(x-5,y-5);
  end;
end;

Procedure Cursore(x,y:integer);
begin
case modo of
L_primoP:croce(x,y);
L_secondoP:Linea(x,y);
cancella_P,D_finestra:MiniBox(x,y);
end;
end;

Procedure muoviCursore(x,y:integer);
begin
if (ultx>=0) then Cursore(ultx,ulty);
ultx:=x;
ulty:=y;
if (x>=0) then Cursore(x,y);
end;

Procedure M_DOWN(button:Tmousebutton;x,y:integer);
var bloccaredraw:boolean;
    tlamp:integer;
    xr,yr,xpr,ypr:real;
begin
orto(x,y);
bloccaredraw:=false;
case button of
mbLeft:
  begin
  cursore(x,y);
  ultx:=-10;
  xr:=xreal(x);
  yr:=yreal(y);
  xpr:=xreal(I_xprec);
  Ypr:=Yreal(I_Yprec);
  ingfisso:=true;
  ing:=ing*10;
  spoX:=form1.PanelLente.Width/2-xr*ing;
  spoY:=form1.PanelLente.Height/2-yr*ing;
  ofx:=round(form1.PanelLente.Width/2-x);
  ofy:=round(form1.PanelLente.Height/2-y);
  Redraw(bloccaredraw,form1.Lente.Canvas,form1.lente,form1.PanelLente,tlamp);
  canvcor:=form1.Lente.Canvas;
  I_xprec:=xgraf(xpr);
  I_Yprec:=Ygraf(Ypr);

    case modo of
    L_secondoP:begin
               end;
    end;
  end;
mbright:begin
        cursore(x,y);
        ultx:=-10;
        modo:=niente;
        end;
end;
end;

Procedure M_UP(button:Tmousebutton;x,y:integer);
var bloccaredraw:boolean;
    tlamp:integer;
    xr,yr,xpr,ypr:real;
begin
x:=x+ofx;
y:=y+ofy;
orto(x,y);
if button=mbleft then
  begin
  cursore(x,y);
  ultx:=-10;
  case modo of
  L_primoP:Modo:=L_secondoP;
  L_secondoP:
    begin
    {cursore(x,y);}
    grafica.linea(xreal(I_xprec),Yreal(I_yprec),xreal(x),yreal(y));
    end;
  Cancella_P:CancellaLinea(canvcor,xreal(x),yreal(y));
  D_Finestra:DisegnaBlocco(canvcor,xreal(x),yreal(y),'FIN');
  end;
  xpr:=xreal(x);
  ypr:=Yreal(y);
  ofx:=0;
  ofy:=0;
  ingfisso:=false;
  Redraw(bloccaredraw,form1.Disegno.Canvas,form1.Disegno,form1.Panel1,tlamp);
  canvcor:=form1.Disegno.Canvas;
  I_xprec:=xgraf(xpr);
  I_Yprec:=Ygraf(Ypr);
  end;
end;

Procedure M_Move(X,Y:integer);
begin
x:=x+ofx;
y:=y+ofy;
orto(x,y);
Muovicursore(x,y);
end;

end.
