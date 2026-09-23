{$A+,B-,D+,E+,F+,I+,L+,N-,O-,R+,S+,V+}
{$M 16384,0,655360}


Unit ut_zoom;

Interface

Uses Graph,definiz,Ut_loca1,ridis_u,halotp4;

Procedure CambiaZoom(zx,zy:real);


implementation
Uses genproc;
{-----------------------------------------------------------------------------}

procedure delln;
begin
setcolor(8);
SetLinestyle(0,0,1);
setwritemode(1);
if RBLine then
  begin
  RBLine:=False;
  line(xrb,yrb,xrb1,yrb1);
  SetWriteMode(0);
  end;{ else begin sound(500); delay(400); nosound; end;}
end;


procedure delhcur;
Begin
setcolor(4);
SetLinestyle(0,0,1);
setwritemode(1);
if cur then
  begin
  Cur:=False;
  line(xcur-dimcur,ycur,xcur+DimCur,ycur);
  line(xcur,ycur-dimcur,xcur,ycur+dimcur);
  SetWriteMode(0);
  end;
end;

procedure rbox( orc0,orc1,orc2,orc3 :ptr_real);

Begin


setcolor(14);
setwritemode(1);
if Rbx then D_Rectangle(xrx,yrx,xrx1,yrx1)
else
  begin
  RBx:=true;
  SetWriteMode(1);
  end;

Xrx:=round(orc0^*inx);
Yrx:=round(ysp-orc1^*iny);
Xrx1:=round(orc2^*inx);
Yrx1:=round(ysp-orc3^*iny);
D_Rectangle(xrx,yrx,xrx1,yrx1);
end;

procedure delbox;
begin
setcolor(14);
{setwritemode(1);}
if rbx then
  begin
  rbx:=false;
  D_Rectangle(xrx,yrx,xrx1,yrx1);
  SetWriteMode(0);
  end;
end;


Procedure CambiaZoom(zx,zy:real);

Var XBox,YBox,xb1,xb2,yb1,yb2,W_zoom:real;
    CodeBox:Integer;
    yinf1,ysup1,xinf1,xsup1,zinf1,zsup1:real;
    Xprov,yprov,zprov:real;


begin
rinfr_menu:=false;
if piccolo then
  begin
  isocur(x,y,2);
  xprov:=xe(xp);
  yprov:=ye(xp,yp);
  zprov:=ze(yp);
  delhcur;
  delln;
  delbox;

  piccolo:=false;
  xinf:=xinfp;
  yinf:=yinfp;
  xsup:=xsupp;
  ysup:=ysupp;
  zinf:=zinfp;
  zsup:=zsupp;
  Memo_pi:=true;
  ridis;
  xp:=xg(xprov,yprov);
  yp:=yg(yprov,zprov);
  end
else
  begin
  repeat
{  readlocator(@Xbox,@YBox,@Codebox);}
{dav.ins.}  readlocator(@Xbox,@YBox,@Codebox);
  if Codebox=129  then
    begin
    IF Xbox>900 THEN Xbox:=900;
    IF Ybox>748 THEN Ybox:=748;
    IF Ybox<45  THEN Ybox:=45;
    IF Xbox<0   THEN Xbox:=0;

    w_zoom:=abs(XBox-zx);

    if zX+W_zoom >900  then W_zoom:=900-zX;
    if zX-W_zoom <0    then W_zoom:=zX;
    if zY+W_zoom*750/1000 >750  then W_zoom:=(750-zY)*1000/750;
    if zY-W_zoom*750/1000 <40   then W_zoom:=(zY-40)*1000/750;


    xb1:=zx-W_zoom;
    xb2:=zx+W_zoom;
    yb1:=zy-W_zoom*750/1000;
    yb2:=zy+W_zoom*750/1000;


    rbox(@xb1,@yb1,@xb2,@yb2);
    end;
  until (codebox in[130,132]);

  delbox;

  if codebox=132 then
    begin
    piccolo:=true;
    isocur(x,y,2);
    delln;
    delhcur;

    xprov:=xe(xp);
    yprov:=ye(xp,yp);
    zprov:=ze(yp);


    xinfp:=xinf;yinfp:=yinf;xsupp:=xsup;
    ysupp:=ysup;zinfp:=zinf;zsupp:=zsup;

    yinf1:=ye(xb1,yb1);
    ysup1:=ye(xb2,yb2);
    xinf1:=xe(xb1);
    xsup1:=xe(xb2);
    zinf1:=ze(yb1);
    zsup1:=ze(yb2);


    xinf:=xinf1;
    yinf:=yinf1;
    xsup:=xsup1;
    ysup:=ysup1;
    zinf:=zinf1;
    zsup:=zsup1;
    ridis;

    xp:=xg(xprov,yprov);
    yp:=yg(yprov,zprov);
    end;
  end;
rinfr_menu:=true;
end;

end.