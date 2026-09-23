unit Grafica;    ggdfgd
interface
uses graphics,Windows,extctrls,Udb,dbtables,UDataLink,sysutils,libreriagenerale,forms,controls,types
{$Ifdef Tubi}
,Definiz,collettori
{$endif}
{$Ifdef carichi}
,uVariabililettura,LetturaDisegnoBidimensionale
, Letturadisegno
{$endif}

;
Function Y_EFF(Var Yscr:integer):real;
Function X_EFF(Var xscr:integer):real;
Procedure Zoom_estens;
Procedure Zoom_in(xcen,ycen,LPanel,Hpanel:integer);
Procedure set_Cursor(NCur:integer);
Procedure Redraw(Canv:Tcanvas;Var Dis:TImage;panel:Tpanel;Xs,Ys:integer);
Procedure InitGrafica;
Procedure Caricacursore(Percorso_Ris:string);
Procedure ModiCord1(var Cordx,Cordy:real;Dx,Dy,Rot,ing:real);
Procedure DisTerm(Cnv:Tcanvas;Xori,Yori,L,H,Rot,ing:real);
Procedure linea(x1,y1,x2,y2:real);
Procedure Lim(v:real;var Max,Min:real);

Const MaxFig=4600;
      CURZoom=-30;
      alx_sin=-1;
      alx_cen=0;
      alx_des=1;
      aly_sopra=-1;
      aly_cen=0;
      aly_sotto=1;
      spes_sel=3;
      spes_dis=1;

Var NFig:integer;
    Xprec,Yprec:real;
    ColCor,brushcor:Tcolor;
    ItemCor:integer;
    TlineaCor:TPenStyle;
    SpesCor,Altcor,AlXCor,AlyCor,Tronco_sel:Integer;
    piano_cor:string[30];
    Contesto:string;
    Rete_sel: Byte;
Type RecFig=record
            tipo:char;
            x1,y1,x2,y2,r,L,H,RoTaz:real;
            Colore:Tcolor;
            TLinea:TPenStyle;
            Spes:Integer;
            brush:Tcolor;
            Testo:string[30];
            alx,aly:integer;
            Item:integer;
            end;
     ArFig=Array [1..Maxfig]of recfig;
Var  D_Fig:^arFig;
     Buf:Array[1..100]of Tpoint;
     NBuf:Integer;
     maxX,Minx,Maxy,Miny,HFin,Lfin,aprtemp,apr,Spo_X,Spo_Y,Ing:real;
     Xsel,Ysel:integer;
     Puntosel:boolean;
     Primavolta,stopweel:Boolean;
     spXpia,spypia:integer;
     ingpia,ing_zoom_in:real;
Type
FRONTHT = Record
                Item    :integer;
                Colore  :Tcolor;
                NZon    :integer;
                NAmb    :string[10];
                NAmb2    :string[10];
                x0      : real;
                y0      : real;
                x1      : real;
                y1      : real;
           end;
Var metaf:Tmetafile;
Const D_input='Disegno utente';
Var  vecchiocontesto:string;
Procedure Cambiacontesto(contesto:string);


implementation
{$Ifdef Tubi}
Uses UMain_CalcTubi;
{$Endif}
{$Ifdef carichi}
uses
UcaricaTabelle,Ulettura;
{$Endif}
{$Ifdef rebuli}
Uses UClientform,umainform;
{$Endif}

{$I Funzionigrafiche1}
Procedure Cambiacontesto(contesto:string);
begin
{$Ifdef rebuli}
cambia_contesto(contesto);
{$Endif}
end;

{$Ifdef rebuli}
Procedure Dislinea(Cnv:Tcanvas;x1,y1,x2,y2:real;Item:integer);
Var XX,YY:real;
    res,amb:integer;
    trovato:boolean;
begin
if (puntosel)and(item<>0) then
  begin
  aprtemp:=apr;
  apr:=3;
  inters(xx,yy,res,x1,x2,xsel-3,xsel+3,y1,y2,ysel-3,ysel+3);
  if res=0 then
  inters(xx,yy,res,x1,x2,xsel+3,xsel-3,y1,y2,ysel+3,ysel-3);
  apr:=aprtemp;
  if res<>0 then
    begin
    HostMainform.PageControl1.ActivePageIndex:=1;
    cnv.Pen.Width:=Spes_sel;
    puntosel:=false;
    trovato:=false;
    if VecchioContesto=D_input then
      begin
      dm1.TT3.First;
      while (not dm1.TT3.eof)and(V_RecPPiano.Item<>Item) do dm1.TT3.next;
      end
    else
      begin
      dm1.TT1.First;
      while (not trovato)and(not dm1.TT1.Eof) do
        begin
          begin
          dm1.TT3.First;
          if V_recamb.Piano=Piano_cor then
          while (not dm1.TT3.Eof)and(item<>v_recPar.Item)do dm1.TT3.next;
          trovato:=item<>v_recPar.Item;
          if not trovato then dm1.TT1.Next;
          end;
        end;
      end;
    end;

  end;
//if Ft^[item].error then   cnv.Pen.Width:=spes_sel;
cnv.Moveto(Round(x1),Round(y1));
cnv.Lineto(Round(x2),Round(y2));
end;

Procedure DisCerchio(Cnv:Tcanvas;x1,y1,R,an1,an2:real;Item:integer);
begin
if r<0 then r:=-R;
cnv.Arc(round(x1-r),round(y1-r),round(x1+r),round(y1+r),round(x1-r),round(y1-r),round(x1-r),round(y1-r));
end;
{$Else}
{$Endif}
Procedure DisTerm(Cnv:Tcanvas;Xori,Yori,L,H,Rot,ing:real);
Procedure Lineaterm(xp1,yp1,xp2,yp2:real);
begin
ModiCord1(xp1,yp1,Xori,Yori,Rot,ing);
ModiCord1(xp2,yp2,Xori,Yori,Rot,ing);
cnv.Moveto(Round(xp1),Round(Hfin-yp1));
cnv.Lineto(Round(xp2),Round(Hfin-yp2));
end;
begin
//xori:=xori+0.5;
Lineaterm(0,H/2,L,H/2);
Lineaterm(L,H/2,L,-H/2);
Lineaterm(L,-H/2,0,-H/2);
Lineaterm(0,-H/2,0,H/2);
end;

{$Ifdef Tubi}
Procedure Dislinea(Cnv:Tcanvas;x1,y1,x2,y2:real;Item:integer);
Var XX,YY:real;
    res,i:integer;
begin
//if (item<>0)and(dis^[item].tronco=tronco_sel) then cnv.Pen.Width:=6;
if (puntosel)and(item<>0) then
  begin
  aprtemp:=apr;
  apr:=3;
  inters(xx,yy,res,x1,x2,xsel-3,xsel+3,y1,y2,ysel-3,ysel+3);
  if res=0 then
  inters(xx,yy,res,x1,x2,xsel+3,xsel-3,y1,y2,ysel+3,ysel-3);
  apr:=aprtemp;
  if res<>0 then
    begin
    cnv.Pen.Width:=spes_sel;
   // rete_Sel := dis^[item]^.indRete;
    puntosel:=false;
    Case Tipo_rete of
    {$IFDEF CANALI}
    trCanali:
    with Vpezzi^[item]^ do
      begin
      FMainTubi.PC_DatiRete.ActivePageIndex:=2;
      tronco_sel:=item;
      FMainTubi.LIndpcan.caption:=' ( pezzo:'+inttostr(item)+' )';
      FMainTubi.ECodiceCan.text:=codP;
      FMainTubi.EACan.text:=Float_to_str(A,0);
      FMainTubi.EBCan.text:=Float_to_str(B,0);
      FMainTubi.ERCan.text:=Float_to_str(R,0);
      end;
    {$ENDIF}
    TrTubi:
    with dis^[item]^ do
      begin
      tronco_sel:=tronco;
      FMainTubi.PC_DatiRete.ActivePageIndex:=1;
      FMainTubi.label10.Caption:=inttostr(Dati^[tronco]^.codicetubo);
      // Emanuela introdotta la formattazione dei dati affinchè non compaiono molti
      // valori dopo la virgola
      //FMainTubi.edit1.Text:=Floattostr(Dati^[tronco]^.Lungh);
      FMainTubi.edit1.Text := Format('%1.2f', [Dati^[tronco]^.Lungh]);
      FMainTubi.ED_TipoTubo.Text := Dati^[tronco]^.Tipo;
      FMainTubi.edit4.Text:=Dati^[tronco]^.CodDiam;
      FMainTubi.lfisso.caption:=Dati^[tronco]^.SWDiam;
      // Emanuela introdotta la formattazione dei dati affinchè non compaiono molti
      // valori dopo la virgola
      //FMainTubi.edit5.Text:= Floattostr(Dati^[tronco]^.PortEff);
      FMainTubi.edit5.Text:= Format('%1.4f', [Dati^[tronco]^.PortEff]);
      FMainTubi.Ed_Velocita.Text:= Format('%1.4f', [Dati^[tronco]^.Velocita]);
      FMainTubi.Ed_PCar.Text:= Format('%1.2f', [Dati^[tronco]^.pd]);
      FMainTubi.Edit8.Text:= Format('%1.2f', [Dati^[tronco]^.pl]);
      FMainTubi.mperdite.Lines.Clear;
      for i:=1 to Maxpconc do
        begin
        if Dati^[tronco]^.Pconc[i].N<>0 then  FMainTubi.mperdite.Lines.Add('COD : '+Dati^[tronco]^.Pconc[i].Cod+'    N°: '+Inttostr(Dati^[tronco]^.Pconc[i].N));
        end;
     // if Dati^[tronco]^.Pconc[1].N<>0 then FMainTubi.edit8.Text:=Inttostr(Dati^[tronco]^.Pconc[1].N)
      //else FMainTubi.edit8.Text:='';
      //FMainTubi.edit7.Text:=Dati^[tronco]^.Pconc[1].Cod;
      //if Dati^[tronco]^.Pconc[2].N<>0 then FMainTubi.edit10.Text:=Inttostr(Dati^[tronco]^.Pconc[2].N)
      //else FMainTubi.edit10.Text:='';
      //FMainTubi.edit9.Text:=Dati^[tronco]^.Pconc[2].Cod;
      if {(Nlinea=0)and}(dati^[tronco]^.Term<>0) then
      begin
        FMainTubi.Groupbox5.Visible:=true;
        // Emanuela introdotta la formattazione dei dati affinchè non compaiono molti
        // valori dopo la virgola
        {FMainTubi.edit2.Text:=floattostr(Gterm^[dati^[tronco]^.Term]^.port);
        FMainTubi.edit3.Text:=floattostr(Gterm^[dati^[tronco]^.Term]^.perd);
        FMainTubi.edit6.Text:=floattostr(Gterm^[dati^[tronco]^.Term]^.pot);  }
        FMainTubi.edit2.Text := Format('%1.4f', [Gterm^[dati^[tronco]^.Term]^.port]);
        FMainTubi.edit3.Text := Format('%1.2f', [Gterm^[dati^[tronco]^.Term]^.perd]);      {KPa}
        FMainTubi.edit7.Text := Format('%1.2f', [((risultcalc^.perdita / 2) - dati^[tronco]^.pp)]);   {KPa}
        if (CompareStr(UpperCase(Gterm^[dati^[tronco]^.Term]^.TipoTerm), Uppercase('Fancoil')) = 0) and
           (Gterm^[dati^[tronco]^.Term]^.potE <> 0)
        then
          FMainTubi.edit6.Text := Format('%1.0f', [Gterm^[dati^[tronco]^.Term]^.potE])
        else
          FMainTubi.edit6.Text := Format('%1.0f', [Gterm^[dati^[tronco]^.Term]^.pot]);
      end
      else FMainTubi.Groupbox5.Visible:=false;
      if CL then
      cnv.Pen.Color:=clyellow;

      end;
    end; //case

    end
    else
    begin
      //if Rete_Sel <> dis^[item]^.indRete then
      //   cnv.Pen.Color := clYellow;

    end
  end;

cnv.Moveto(Round(x1),Round(y1));
cnv.Lineto(Round(x2),Round(y2));
end;

Procedure DisCerchio(Cnv:Tcanvas;x1,y1,R,an1,an2:real;Item:integer);
begin
if r<0 then r:=-R;
an1:=an1+pi/2;
an2:=an2+pi/2;
//cnv.Arc(round(x1-r),round(y1-r),round(x1+r),round(y1+r),round(x1-r),round(y1-r),round(x1-r),round(y1-r));
cnv.Arc(round(x1-r),round(y1-r),round(x1+r),round(y1+r),round(x1+r*sin(an1)),round(y1+r*cos(an1)),round(x1+r*sin(an2)),round(y1+r*cos(an2)));
end;

{$endif}
{$Ifdef carichi}


Procedure Dislinea(Cnv:Tcanvas;x1,y1,x2,y2:real;Item:integer);
Var XX,YY:real;
    res,amb:integer;
begin
if (puntosel)and(item<>0) then
  begin
  aprtemp:=apr;
  apr:=3;
  inters(xx,yy,res,x1,x2,xsel-3,xsel+3,y1,y2,ysel-3,ysel+3);
  if res=0 then
  inters(xx,yy,res,x1,x2,xsel+3,xsel-3,y1,y2,ysel+3,ysel-3);
  apr:=aprtemp;
  if res<>0 then
    begin
    cnv.Pen.Width:=Spes_sel;
    puntosel:=false;
    with Ft^[item] do
      begin
     { Flettura.Memo1.Lines.Add('a1='+inttostr(a1));
      Flettura.Memo1.Lines.Add('a2='+inttostr(a2));
      Flettura.Memo1.Lines.Add('x0='+floattostr(x0));
      Flettura.Memo1.Lines.Add('x1='+floattostr(x1));
      Flettura.Memo1.Lines.Add('y0='+floattostr(y0));
      Flettura.Memo1.Lines.Add('y1='+floattostr(y1));}

      if a1<>0 then amb:=a1 else amb:=a2;
      amb:=strtoint(bll^[amb].attrib1[1]);
      //if cercaAmb(bll^[amb].attrib1[1]) then
      if cercaAmb1(IntToStr(amb)) then
        begin
        dm1.TT3.First;
        while (not dm1.TT3.Eof)and(item<>v_recPar.Item)do dm1.TT3.next;
        end;
      end;

    end;

  end;
if Ft^[item].error then   cnv.Pen.Width:=spes_sel;
cnv.Moveto(Round(x1),Round(y1));
cnv.Lineto(Round(x2),Round(y2));
end;

Procedure DisCerchio(Cnv:Tcanvas;x1,y1,R,an1,an2:real;Item:integer);
Var Item1:integer;
    ylsel:real;
begin
y1:=y1-4;
if r=0 then r:=5;
if r < 0 then r:=-r;
if (puntosel)and(item<>0) then
  begin
  Ylsel:=ysel-4;
  if (abs(x1-xsel)<=8)and(abs(y1-ylsel)<=8) then
    begin
    cnv.Pen.Width:=Spes_sel;
    puntosel:=false;
    if bll^[item].Nome='AMB' then
     cercaAmb1(bll^[item].attrib1[1]);
    if (bll^[item].Nome='FIN')OR(bll^[item].Nome='PON') then
      begin
      item1:=bll^[item].ambienti;
      if Ft^[item1].a1<>0 then item1:=Ft^[item1].a1 else item1:=Ft^[item1].a2;
      cercaAmb1(bll^[item1].attrib1[1]);
      dm1.TT3.First;
      while (not dm1.TT3.Eof)and(-item<>v_recPar.Item)do
      dm1.TT3.next;
      end;
    end;
  end;
cnv.Arc(round(x1-r),round(y1-r),round(x1+r),round(y1+r),round(x1-r),round(y1-r),round(x1-r),round(y1-r));
// Emanuela 29/7/2004 inserito modifica dei combo
FLettura.ModificaVolumeVC;
end;
{$endif}


Procedure Caricacursore(Percorso_Ris:string);
Var Cur:Hcursor;
begin
Cur:=LoadImage(0,Pchar(Percorso_Ris +'\Immagini\Cursori\Zoomfinestra.cur'),IMAGE_CURSOR,0,0,LR_DEFAULTSIZE or LR_LOADFROMFILE);
if cur<>0 then screen.cursors[CurZoom]:=cur;
end;
Procedure InitGrafica;
begin
Caricacursore(Percorso_RisorseGen);
New(d_fig);
NFig:=0;
Minx:=0;
MinY:=0;
MaxX:=800;
Maxy:=600;
Primavolta:=true;
tronco_sel:=0;
Metaf:=Tmetafile.Create;
{$IFDEF REBULI}
metaf.LoadFromFile('C:\programmi\autocad lt 2002 ita\disegno1.wmf');
{$ENDIF}
//metaf.LoadFromFile('C:\progetticpiwinclima\Esempi DXF\pianoterra-master.wmf');
spxpia:=0;
spypia:=0;
ingpia:=1;
stopweel:=false;
end;

Procedure Zoom_estens;
begin
//{$Ifdef Tubi}
primavolta:=true;
ingpia:=1;
spxpia:=0;
spypia:=0;
Ridisegna;
//{$Endif}
end;

Procedure Zoom_in(xcen,ycen,LPanel,Hpanel:integer);
Var LL,HH,ing1:real;

begin
ing_zoom_in := 2;
ing1:=ing*ing_zoom_in;
if ing_zoom_in<2 then
  begin
  spo_x:=Xcen-(X_eff(Xcen)*ing1);
  spo_y:=Hfin-Ycen-(Y_eff(Ycen)*ing1);
  //spo_x:=Lfin/2-( X_eff(round(Lfin/2)) *ing1);
  //spo_y:=Hfin/2-( Y_eff(round(Hfin/2)) *ing1);
  end
else
  begin
  spo_x:=Lfin/2-(X_eff(Xcen)*ing1);
  spo_y:=Hfin/2-(Y_eff(Ycen)*ing1);
  end;
//spxpia:=round(spxpia-(xcen-FLettura.Panel5.Width/2)*ingpia);
//spypia:=round(spypia+(ycen-FLettura.Panel5.height/2)*ingpia);
//spxpia:=round(spxpia-(xcen-FLettura.Panel5.Width/2)*ingpia);
//spypia:=round(spypia+(ycen-FLettura.Panel5.height/2)*ingpia);

//spxpia:=round(FLettura.Panel5.Width/2-(xcen-spxpia)*2);
//spypia:=round(FLettura.Panel5.height/2-(ycen-spypia)*2);
if ing_zoom_in<2 then
  begin
  spxpia:=round(xcen-(xcen-spxpia)*2);
  spypia:=round(Hfin-ycen-(ycen-spypia)*2);
  end
else
  begin
  spxpia:=round(Lpanel/2-(xcen-spxpia)*2);
  spypia:=round(Hpanel/2-(ycen-spypia)*2);
  end;
ingpia:=ingpia*ing_zoom_in;

//LL:=Maxx-Minx;
//HH:=Maxy-Miny;
ing:=ing*ing_zoom_in;
{$Ifdef Tubi}
FMainTubi.Image1.cursor:=CRDefault;
{$Endif}
{$Ifdef Carichi}
FLettura.Image1.cursor:=CRDefault;
{$Endif}
{$Ifdef rebuli}
Hostmainform.Image1.cursor:=CRDefault;
{$Endif}
end;

Procedure set_Cursor(NCur:Integer);
begin
{$Ifdef Tubi}
FMainTubi.Image1.cursor:=NCur;
{$Endif}
{$Ifdef Carichi}
Flettura.Image1.cursor:=NCur;
{$Endif}
{$Ifdef rebuli}
HostMainform.Image1.cursor:=NCur;
{$Endif}
end;

Procedure inc1(ind:integer);
begin
// Emanuela 6/6/2004 Inserito un controllo affinchè Nfig non super la
// dimensione di Maxfig e quindi dello spazio associato alla struttura
if NFig < MAxFig then
   inc(Nfig);
with D_fig^[NFig] do
  begin
  x1:=0;
  y1:=0;
  x2:=0;
  y2:=0;
  end;
end;

Function angolo_bm(ang:real):real;
begin
result:=ang*pi/180;
end;
{*-*-*-*-*-*-*-*-*-*-*-*-*-*  X_Eff        *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
Function X_EFF(Var xscr:integer):real;
begin
result:=(xscr-spo_x)/ing;
end;
{*-*-*-*-*-*-*-*-*-*-*-*-*-*  X_Eff        *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
Function Y_EFF(Var Yscr:integer):real;
begin
result:=((HFin-Yscr)-spo_Y)/ing;
end;
{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Modicord1        *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure ModiCord1(var Cordx,Cordy:real;Dx,Dy,Rot,ing:real);
Var Dist,Ang:real;
begin
if CordY=0 then
  begin
  if Cordx>=0 then ang:=pi/2 else ang:=(3/2)*pi;
  end
else
  begin
  if Cordy>0 then
    begin
    ang:=arctan(Cordx/abs(Cordy));
    end
  else
  ang:=(pi-arctan(Cordx/abs(Cordy)));
  end;
if ang<0 then ang:=2*pi+ang;

Dist:=sqrt(sqr(Cordx)+sqr(Cordy))*ing;
Ang:=Ang+Rot;
CordX:=sin(ang)*Dist+Dx;
Cordy:=Hfin-(Cos(ang)*Dist+Dy);
end;

Procedure SetAttrib;
begin
with D_fig^[NFig] do
  begin
  Colore:=colcor;
  TLinea:=Tlineacor;
  Spes:=spescor;
  brush:=brushcor;
  Item:=itemcor;
  alx:=alxcor;
  aly:=alycor;
  end;
end;

Procedure lineaRel(px2,py2:real);
begin
inc1(Nfig);
with D_fig^[NFig] do
  begin
  Tipo:='L';
  x1:=Xprec;
  Y1:=Yprec;
  X2:=px2;
  Y2:=Py2;
  XPrec:=pX2;
  YPrec:=Py2;
  setattrib;
  end;
end;

Procedure testo(x,y:real;tst:string);
begin
inc1(Nfig);
with D_fig^[NFig] do
  begin
  Tipo:='T';
  x1:=X;
  Y1:=Y;
  X2:=0;
  Y2:=0;
  XPrec:=X1;
  YPrec:=Y1;
  setattrib;
  spes:=altcor;
  Testo:=tst;

  end;
end;


Procedure linea(x1,y1,x2,y2:real);
begin
xPrec:=x1;
yPrec:=Y1;
LineaRel(x2,y2);
end;

Procedure Forma(x,y:Real);
begin
inc1(Nfig);
with D_fig^[NFig] do
  begin
  Tipo:='F';
  x1:=x;
  Y1:=y;
  end;
XPrec:=X;
YPrec:=Y;
end;
Procedure EndForma;
begin
inc1(Nfig);
with D_fig^[NFig] do
  begin
  Tipo:='E';
  setattrib;
  end;
end;

Procedure Cerchio(x,y,pr:real);
begin
inc1(Nfig);
with D_fig^[NFig] do
  begin
  Tipo:='C';
  X1:=x;
  Y1:=y;
  r:=Pr;
  setattrib;
  end;
end;
Procedure Arco(x,y,pr,a1,a2:real);
begin
inc1(Nfig);
with D_fig^[NFig] do
  begin
  Tipo:='A';
  X1:=x;
  Y1:=y;
  X2:=a1;
  Y2:=a2;
  r:=Pr;
  setattrib;
  end;
end;

Procedure Disegna(Cnv:Tcanvas;spx,spy,ing,rot:real);
Var i:integer;
    Poly:boolean;
    xtst,ytst:integer;
    ltesto,htesto: integer;
Function FTipo(Tipo:char):char;
begin
If (POly)and(Tipo='L') then Tipo:='O';
Result:=Tipo;
end;
begin
POly:=False;
For i:=1 to Nfig do
with  D_fig^[i] do
  begin
  Modicord1(X1,y1,spx,spy,rot,ing);
  if Ftipo(Tipo)<>'A' then Modicord1(X2,y2,spx,spy,rot,ing);
    case Ftipo(Tipo) of

    'L':begin
        cnv.Pen.Color:=Colore;
        cnv.Pen.Style:=TLinea;
        cnv.Pen.Width:=spes;
        Dislinea(cnv,x1,y1,x2,y2,Item);
        end;
    'T':begin
        cnv.Pen.Color:=Colore;
        cnv.brush.Color:=brush;
        cnv.Pen.Style:=TLinea;
        if spes=0 then spes:=10;
        cnv.font.height:=spes;
        cnv.font.color:=Colore;
        xtst:=round(X1);
        ytst:=round(y1);
        ltesto:=round(spes*length(testo)*0.65/2);
        htesto:=round(spes/2*1.4);
        if alx=alx_des then xtst:=xtst-ltesto;
        if alx=alx_cen then xtst:=xtst-ltesto;
        if aly=aly_cen then   ytst:=ytst-htesto;
        if aly=aly_sotto then ytst:=ytst+htesto*2;

        //Rectang := Rect(0,0,20,20);
        //cnv.textrectRect(Rectang,xtst,ytst,testo,AlignHCenter + AlignVCenter);
        cnv.TextOut(xtst,Ytst,Testo);
        end;
    'C':begin
        cnv.Pen.Color:=Colore;
        cnv.Pen.Style:=TLinea;
        cnv.Pen.Width:=spes;
        DisCerchio(cnv,x1,y1,r,0,2*pi,Item);
        end;
    'A':begin
        cnv.Pen.Color:=Colore;
        cnv.Pen.Style:=TLinea;
        cnv.Pen.Width:=spes;
        DisCerchio(cnv,x1,y1,r*ing,x2,y2,Item);
        end;
    'O':Begin
        Inc(Nbuf);
        Buf[Nbuf].X:=Round(x2);
        Buf[Nbuf].Y:=Round(Y2);
        end;
    'F':Begin
        Poly:=true;
        NBuf:=1;
        Buf[Nbuf].X:=Round(x1);
        Buf[Nbuf].Y:=Round(Y1);
        end;
    'E':Begin
        Poly:=False;
        cnv.Brush.Color:=brush;
        cnv.Pen.Color:=Colore;
        cnv.Pen.Width:=spes;
        cnv.Polygon(slice(Buf,Nbuf));
        end;
     'R':begin
         cnv.Pen.Color:=Colore;
         cnv.Pen.Style:=TLinea;
         cnv.Pen.Width:=spes;
         Disterm(cnv,x1,y1,L,H,rotaz+rot,ing);
         end;
    end;
  end;
end;

Procedure CaricaNord;
begin
brushcor:=clTeal;
Forma(0,-25);
colcor:=clblack;
lineaRel(25,25);
lineaRel(0,5);
lineaRel(-25,25);
lineaRel(0,-25);
EndForma;
colcor:=clblack;
Cerchio(0,0,20);
end;

Procedure Lim(v:real;var Max,Min:real);
begin
if v>max then max:=v;
if v<min then min:=v;
end;

Procedure Leggipianta;

Var fo:file of FRONTHT;
buf:FRONTHT;

begin
itemcor:=0;
spescor:=1;
colcor:=clblack;
if fileexists(IncludeTrailingPathDelimiter(percorsoDrive) + piano_cor + '.int') then
  begin
  assign(fo,IncludeTrailingPathDelimiter(percorsoDrive) + piano_cor + '.int');
  try
    reset(fo);
    while not eof(fo) do
      begin
      read(fo,buf);
      with buf do
        begin
        colcor:=colore;
        {$Ifdef rebuli}
        itemcor:=item;
        {$endif}
        linea(x0,y0,x1,y1);
        lim(x0,MaxX,Minx);
        lim(x1,MaxX,Minx);
        lim(y0,Maxy,Miny);
        lim(y1,Maxy,Miny);
        end;
      end;
    close(fo);
   except
    close(fo);
   end;
  end;
end;
{$Ifdef Tubi}
{$else}
Procedure LeggiEdificioInput;
Begin
itemcor:=0;
spescor:=1;
colcor:=clblack;
with dm1.TT3 do
if active then
  begin
  first;
  while not eof do
    begin
    with V_RecPPiano do
      begin
      itemcor:=round(item);
      linea(x1,y1,x2,y2);
      lim(x1,MaxX,Minx);
      lim(x2,MaxX,Minx);
      lim(y1,Maxy,Miny);
      lim(y2,Maxy,Miny);
      end;
    next;
    end;
  end;
end;
{$endif}
{$Ifdef Tubi}

Procedure Ins_term(xo,yo,L,h,rot:real);
begin
if NFig < MaxFig then
   Inc(Nfig);
D_fig^[Nfig].tipo:='R';
D_fig^[Nfig].x1:=xo;
D_fig^[Nfig].y1:=Yo;
D_fig^[Nfig].Colore:=Clred;
D_fig^[Nfig].TLinea:=Tlineacor;
D_fig^[Nfig].brush:=Brushcor;
D_fig^[Nfig].L:=L;
D_fig^[Nfig].H:=H;
D_fig^[Nfig].RoTaz:=Rot;
D_fig^[Nfig].Spes:=spescor;
D_fig^[Nfig].Item:=0;
end;

Procedure LeggiDisegno_tubi(canv : TCanvas);
Var i:integer;
    xmedio,Ymedio:real;
    pp:integer;
    st: string;
    Posizione: Integer;
    //Emanuela 29/6/2006 variabile che serve per scrivere una volta sola il diametro del collettore
    Collet: Boolean;
begin
//Emanuela 29/6/2006 variabile che serve per scrivere una volta sola il diametro del collettore
Collet := False;
if ultriga<>0 then
begin
MaxX:=-10E6;
Minx:=10E6;
Maxy:=-10E6;
Miny:=10E6;
end;
If uppercase(FMainTubi.ComboBox2.Text)='RETE PRINCIPALE' then
Piano_cor:=V_recgen.piano;
leggiPianta;
//for i:=1 to ultriga do
//if Dis^[i]^.piano<>'' then
//pianocor:=Dis^[i]^.piano;
st := FMainTubi.ComboBox2.Text;
colcor:=clblue;
spescor:=spes_dis;
{$IF Defined(VERSIONE_11)}

{$ELSE}
disegnacollettori(false);
{$IFEND}
for i:=1 to ultriga do
with Dis^[i]^ do
if FMainTubi.ComboBox2.Text = Filtro then
begin
if true then
  begin
  if (pianocad<>'')and(filtro<>'') then
  piano_cor:=pianocad;
  colcor:=clred;
  lim(x2,MaxX,Minx);
  lim(x1,MaxX,Minx);
  lim(y2,Maxy,Miny);
  lim(y1,Maxy,Miny);
  Itemcor:=i;
  spescor:=1;
  xmedio:=(x1+x2)/2{+10};
  ymedio:=(y1+y2)/2{+10};
  if (Nlinea<>0)and(dis^[Nlinea]^.rimando<>'')then
  //Emanuela Inserisco un intorno per spostarlo un pochino
    begin
    colcor:=clgreen;
    alycor:=alY_Cen;
    testo(x2 {- 1},y2,'> VA A : '+dis^[Nlinea]^.rimando);
    alycor:=alY_sopra;
    colcor:=clred;
    end;
  if (tronco<>0)and(dati^[tronco].ti=i)and (dati^[tronco].Coddiam<>'')
  then if (dis^[i]^.Coll) and (not Collet) then
       begin
         //Emanuela 29/6/2006 modalità trovata che serve per scrivere una volta sola il diametro del collettore
         colcor:=clgreen;
         Collet := True;
         testo(xmedio + 0.02,ymedio,'Diametro collettore: ' + dati^[tronco].Coddiam);
         colcor:=clred;
       end
       else if not dis^[i]^.Coll then
               testo(xmedio,ymedio,dati^[tronco].Coddiam);
  //else {If FMainTubi.CheckBox1.Checked then} testo(xmedio,ymedio,inttostr(i));linea(x1,y1,x2,y2);
  if (tronco=tronco_sel)then spescor:=spes_sel;
  linea(x1,y1,x2,y2);

  if nLinea=0 then
    begin

    if (tronco<>0)and(dati^[tronco]^.Npros=1) then
      begin
      pp:=dati^[tronco]^.pros[1];
      pp:=dati^[PP]^.Ti;
      if Dis^[pp]^.Settore<>'' then testo(x2,y2,Dis^[pp]^.Settore)
      end;
    //if (tronco<>0)and(dati^[tronco]^.Npros=0) then cerchio(x2,y2,-8);
    if (tronco<>0)and(dati^[tronco]^.Term<>0) then
      begin
      //cerchio(x2,y2,-10);
      //testo(x2+0.3,y2,Gterm^[dati^[tronco]^.Term].cod)
      //testo(x2+0.03,y2,Gterm^[dati^[tronco]^.Term].cod);
      alxcor:=alx_sin;
      alycor:=aly_cen;
      colcor:=clblack;
      Posizione := dati^[tronco]^.Term;
      if (CompareStr(UpperCase(Gterm^[Posizione]^.TipoTerm), Uppercase('Fancoil')) = 0)
      then
      begin
       if (Gterm^[Posizione]^.potE <> 0) then
         testo(Gterm^[Posizione]^.XEtic,Gterm^[dati^[tronco]^.Term]^.YEtic,Format('%1.0f', [Gterm^[Posizione]^.potE])+' [W]')
       else
         testo(Gterm^[Posizione]^.XEtic,Gterm^[dati^[tronco]^.Term]^.YEtic,Format('%1.0f', [Gterm^[Posizione]^.pot])+' [W]')
      end
      else
         testo(Gterm^[Posizione]^.XEtic,Gterm^[dati^[tronco]^.Term]^.YEtic,Format('%1.0f', [Gterm^[Posizione]^.pot])+' [W]');

      alycor:=alY_sopra;
      alxcor:=alx_sin;
      ins_term(x2,y2,1,0.2,angolo_bm(Gterm^[Posizione]^.Angolo));
      end;
    spescor:=3;
    colcor:=clred;
    cerchio(x2,y2,-3);
    end;
  end;
end
else
  begin
  lim(x2,MaxX,Minx);
  lim(x1,MaxX,Minx);
  lim(y2,Maxy,Miny);
  lim(y1,Maxy,Miny);
  Itemcor:=0;
  spescor:=1;
  //colcor:=clyellow;
  colcor:=clwhite;
  linea(x1,y1,x2,y2);
  end;
end;

procedure Leggidisegno_canali(canv : TCanvas);
type
      VetDim=record
             Codpezzo,gruppo:integer;
             Entita:string[1];
             Piano:string[30];
             Tlinea,Colore:integer;
             X1,Y1,X2,Y2,Z1,Z2:real;
             R,R2:real;
             end;
Var fDim:file of vetdim;
    bufdim:vetdim;
begin
if ultriga<>0 then
begin
MaxX:=-10E6;
Minx:=10E6;
Maxy:=-10E6;
Miny:=10E6;
end;
If uppercase(FMainTubi.ComboBox2.Text)='RETE PRINCIPALE' then
Piano_cor:=V_recgen.piano;
colcor:=clred;
Itemcor:=0;
spescor:=1;

leggiPianta;
if fileexists(IncludeTrailingPathDelimiter(PercorsoDrive) + 'disegnocanali.dsc') then
  begin
  assignfile(fdim,IncludeTrailingPathDelimiter(PercorsoDrive) + 'disegnocanali.dsc');
  try
    reset(fdim);
    while not eof(Fdim)do
      begin
      read(fdim,bufdim);
      itemcor:=bufdim.codpezzo;
      if tronco_sel=itemcor then spescor:=spes_sel else spescor:=1;
      with bufdim do
      case upcase(entita[1]) of
      'L','F','*':begin
          linea(x1,y1,x2,y2);
          lim(x2,MaxX,Minx);
          lim(x1,MaxX,Minx);
          lim(y2,Maxy,Miny);
          lim(y1,Maxy,Miny);
          end;
      'Q':Begin
          Testo(x1,y1,float_to_str(x2,2));
          end;
      'A':Arco(x1,y1,R,x2,y2);
      'C':Arco(x1,y1,R,0,2*pi);
      end;
      end;
    close(Fdim);
  except
    close(Fdim);
  end;
  end;
end;
procedure Leggidisegno(canv : TCanvas);
begin
Case Tipo_rete of
{$IFDEF CANALI}
TrCanali:leggidisegno_Canali(canv);
{$ENDIF}
TrTubi:leggidisegno_Tubi(canv);
end;
end;
{$endif}
{$Ifdef carichi}
Procedure leggiDisegnoEdificioElaborato(canv : TCanvas);
Var i:integer;
begin
CaricaNord;
brushcor:=clwhite;
Disegna(canv,40,Hfin-40,1,(direznord+180)*pi/180);
Nfig:=0;
Maxx:=-10E6;
Maxy:=-10E6;
Minx:=10E6;
Miny:=10E6;
brushcor:=clTeal;
alycor:=aly_sopra;
alxcor:=alx_sin;
(*
Forma(0,-25);
lineaRel(25,25);
lineaRel(0,5);
lineaRel(-25,25);
lineaRel(0,-25);
EndForma;
*)
//Cerchio(0,0,20);
Altcor:=0;{ TODO -oDiego -cImportante : pippo }
Brushcor:=clWhite;
for i:=1 to ultblocco do
with Bll^[i] do
  begin
  Itemcor:=i;
  alxcor:=alx_sin;

  If (nome='FIN')or (nome='PON') then Testo(x,y,attrib1[1]);
  If nome='AMB' then
    begin
    alxcor:=alx_cen;
    Testo(x,y,attrib1[1]+' - '+attrib1[2]);
    end;
  Cerchio(x,y,0);
  end;

for i:=1 to ultimafrontiera do
with Ft^[i] do
  begin
  colcor:=clred;
  if (a1<>0)and(a2<>0) then colcor:=clgreen;
  lim(x0,MaxX,Minx);
  lim(x1,MaxX,Minx);
  lim(y0,Maxy,Miny);
  lim(y1,Maxy,Miny);
  Itemcor:=i;
  linea(x0,y0,x1,y1);
  end;
Itemcor:=0;
(*
 Ft^[ultft].colore:=colore;
 Ft^[ultft].x0:=x1;
 Ft^[ultft].y0:=y1;
 Ft^[ultft].z0:=0;
          Ft^[ultft].x1:=x2;
          Ft^[ultft].y1:=y2;
          Ft^[ultft].z1:=0;
 *)
if  (erroreX<>0)or(erroreY<>0) then
begin
Itemcor:=0;
colcor:=clred;
Cerchio(erroreX,errorey,-15);
end;

end;
Procedure LeggiDisegno(canv : TCanvas);
begin
LeggidisegnoEdificioElaborato(Canv);
end;
{$endif}


Procedure Rettangolo(L,H:real);
begin
Linea(-L/2,-H/2,L/2,-H/2);
LineaRel(L/2,H/2);
LineaRel(-L/2,H/2);
LineaRel(-L/2,-H/2);
end;

Procedure Rett_pieno(L,h,Px,Py:real;Color:TColor);
Begin
brushcor:=Color;
colcor:=color;
l:=l/2;
h:=h/2;
Forma(-L+Px,-H+Py);
lineaRel(L+Px,-H+Py);
lineaRel(L+Px,H+Py);
lineaRel(-L+Px,H+Py);
lineaRel(-L+Px,-H+Py);
EndForma;
end;


Procedure Redraw(Canv:Tcanvas;Var Dis:TImage;panel:Tpanel;Xs,Ys:integer);
var rett:trect;
    XCFin,YCFin,Risp:Real;
    i,j,NVert,NVertL,Norizz,NorizzL,restoLoriz,restoLvert,sporizz,spvert,MezzaL ,
    MaxLoriz,MaxLVert:integer;
    RestoVert,RestoOrizz,lq,hq,LLamp,Hlamp,sc:Real;
    all:string;
begin
Puntosel:=(xs<>0)or(ys<>0);
Xsel:=xs;
Ysel:=ys;
{DM1.TT1.Databasename:=tab.DatabaseName;
DM1.TT1.Tablename:=tab.TableName;
DM1.TT1.Open;}
HFin:=panel.height;
YCFin:=Hfin/2;
LFin:=panel.Width;
XCFin:=Lfin/2;
rett.top:=0;
rett.Left:=0;
rett.Right:=1200;
rett.Bottom:=1024;
canv.Brush.Color:=clwhite;
canv.fillrect(rett);
NFig:=0;
Risp:=80;
//totlamp:=0;
colcor:=clblack;
Itemcor:=0;
TLineacor:=PsSolid;
altcor:=10;
SpesCor:=1;
brushcor:=clwhite;
colcor:=clblack;
{$Ifdef rebuli}
If contesto='LETTURA' then
  begin
  if primavolta then
    begin
    MaxX:=-10E6;
    Minx:=10E6;
    Maxy:=-10E6;
    Miny:=10E6;
    end;
  if vecchiocontesto=D_input then LeggiEdificioInput
  else leggiPianta;
  if primavolta then
    begin
    if Maxy-Miny>0.01 then
    ing:=(Hfin-150)/(Maxy-Miny)
    else ing:=10E6;
    if Maxx-Minx>0.01 then
    if ing > (Lfin-150)/(Maxx-Minx) then ing:=(Lfin-150)/(Maxx-Minx);
    Spo_x:=(LFin/2)-(Minx+Maxx)*ing/2;
    Spo_y:=(HFin/2)-(Miny+Maxy)*ing/2;
    Primavolta:=false;
    end;
  if (Xsel<>0)or(ysel<>0) then tronco_sel:=0;
  Disegna(canv,Spo_X,Spo_Y,ing,0);
  exit;
  end;
with V_amb1 do
  begin
  lq:=lq1/1000;
  Hq:=Hq1/1000;
  Llamp:=LLamp1/1000;
  Hlamp:=HLamp1/1000;
  Disegna(canv,40,40,1,Direz*pi/180);
  if (h>0) and (L>0) then
    begin
    Ing:=(HFin-risp*2)/H;
    if (LFin-risp*2)/L < Ing then Ing:=(LFin-risp*2)/L;
    NFig:=0;
    ColCor:=clred;
    Rettangolo(L,H);
    ColCor:=clBlue;
    TlineaCor:=psDot;
    sc:=h/80;
    linea(-L/2-L/20,0,L/2+L/20,0);
    linea(0,-H/2-H/20,0,H/2+H/20);
    testo(0-sc,H/2+H/20,'3    5=Pavimento');
    testo(0-sc,-H/2-H/20-sc*4,'1');
    testo(-L/2-L/20-sc,0-sc*2,'4');
    testo(L/2+L/20+sc,0-sc*2,'2');

    if (Lq>0)and(Lq<L)and(Hq>0)and(Hq<H) then
      begin
      TlineaCor:=psSolid;
      ColCor:=clBlack;
      all:=allinea;
      if all='' then all:='CC';
      NvertL:=Trunc(h/hQ);
      NVert:=NVertL;
      Restovert:=h-(Nvert*hQ);
      if all[1]='C' then
        begin
        restovert:=restovert/2;
        inc(nvert);
        end;
      if all[1]='A' then
        begin
        restovert:=0;
        inc(nvert);
        end;

      For i:=1 to NVert do
      linea(-L/2,restovert+(I-1)*Hq-H/2,L/2,restovert+(I-1)*Hq-H/2);

      NOrizzL:=Trunc(L/LQ);
      NOrizz:=NOrizzL;
      RestoOrizz:=L-(NOrizz*LQ);
      if all[2]='C' then
        begin
        restoorizz:=restoorizz/2;
        inc(norizz);
        end;
      if all[2]='S' then
        begin
        restoorizz:=0;
        inc(norizz);
        end;

      For i:=1 to NOrizz do
      linea(restoorizz+(I-1)*Lq-L/2,-H/2,restoorizz+(I-1)*Lq-L/2,H/2);
      MaxLoriz:=0;
      MaxLVert:=0;
      MezzaL:=(Nlamp-1) div 2;
      if (Nlamp>0)and(LLamp>0)and(Hlamp>0) then
        begin
        restoLoriz:=NorizzL+MezzaL mod nlamp;
        sporizz:={Nlamp div 2}0;
        restoLvert:=NvertL+MezzaL mod nlamp ;
        spvert:={Nlamp div 2}0;
        for i:=1 to nvertL do
        for j:= 1 to NOrizzL do
          begin
          if ( ( (i+mezzaL ) mod nlamp)=0) and(((j+MezzaL) mod nlamp)=0) then
            begin
            MaxlOriz:=j;
            MaxLvert:=i;
            end;
          end;
        RestoLoriz:=Norizz-MaxLoriz;
        sporizz:=(RestoLoriz-(Nlamp-1-MezzaL))div 2;
        if (RestoLoriz-(Nlamp-1-MezzaL))mod 2 <>0 then
          begin
          if all[2]='S' then inc(sporizz);
          end;
        RestoLVert:=NVert-MaxLOriz;
        spVert:=(RestoLVert-(Nlamp-1-MezzaL))div 2;
        if  (RestoLVert-(Nlamp-1-MezzaL))Mod 2 <>0 then
          begin
          if all[1]='A' then inc(spVert);
          end;
        for i:=1 to nvertL do
        for j:= 1 to NOrizzL do
          begin
          if ( ( (i+mezzaL-spvert ) mod nlamp)=0) and(((j+MezzaL-sporizz) mod nlamp)=0) then
            begin
            //inc(totlamp);
            Rett_pieno(LLamp,HLamp,-L/2+Lq/2+restoOrizz+(j-1)*Lq,-H/2+Hq/2+restoVert+(i-1)*Hq,clYellow);
            end;
          end;
         //br:=true;
         {set_Tlamp(totlamp);}
         //br:=false;
        end;
      end;

    Disegna(canv,XCFin,YCFin,Ing,0);
    end;
  end;
{DM1.TT1.close;}
{$else}
LeggiDisegno(canv);
if primavolta then
  begin
  if Maxy-Miny>0.01 then
  ing:=(Hfin-150)/(Maxy-Miny)
  else ing:=10E6;
  if Maxx-Minx>0.01 then
  if ing > (Lfin-150)/(Maxx-Minx) then ing:=(Lfin-150)/(Maxx-Minx);
  Spo_x:=(LFin/2)-(Minx+Maxx)*ing/2;
  Spo_y:=(HFin/2)-(Miny+Maxy)*ing/2;
  Primavolta:=false;
  end;
if (Xsel<>0)or(ysel<>0) then tronco_sel:=0;
Disegna(canv,Spo_X,Spo_Y,ing,0);
//spxpia:=-200;
//spypia:=0;
//ingpia:=1;
//canv.StretchDraw(rect(0+spxpia,0+spypia,round(metaf.Width*ingpia+spxpia),round(metaf.height*ingpia+spypia)),metaf);

{$endif}
{$ifdef tubi}
LeggiDisegno(canv);
canv.Brush.Color:=clwhite;
canv.fillrect(rett);
Disegna(canv,Spo_X,Spo_Y,ing,0);
{$endif}

end;
end.
