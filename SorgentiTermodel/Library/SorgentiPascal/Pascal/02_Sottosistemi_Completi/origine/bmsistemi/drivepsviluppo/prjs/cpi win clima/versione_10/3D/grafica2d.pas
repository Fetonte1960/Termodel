unit Grafica2d;
interface
uses graphics,Windows,extctrls,UDbT,udb,UDataLink,{Udb,dbtables,}sysutils,libreriagenerale,
     forms,controls,types
//{$Ifdef Tubi}
,Definiz
//,collettori
//{$endif}
{$Ifdef carichi}
,uVariabililettura{,LetturaDisegnoBidimensionale
, Letturadisegno  }
{$endif}
;
Function Y_EFF(Var Yscr:integer):real;
Function X_EFF(Var xscr:integer):real;
Procedure Zoom_estens;
Procedure Zoom_in(xcen,ycen,LPanel,Hpanel:integer);
Procedure set_Cursor(NCur:Integer;var Image:TImage);
Procedure Redraw(Canv:Tcanvas;Var Dis:TImage;panel:Tpanel;Xs,Ys:integer);
Procedure InitGrafica;
Procedure Caricacursore(Percorso_Ris:string);
Procedure ModiCord1(var Cordx,Cordy:real;Dx,Dy,Rot,ing:real);
Procedure DisTerm(Cnv:Tcanvas;Xori,Yori,L,H,Rot,ing:real;item:integer);
Procedure linea(x1,y1,x2,y2:real);
Procedure Lim(v:real;var Max,Min:real);
Function cord_Osnap(var XOs,YOs:real):boolean;
Procedure annullaosnap;
Procedure Cursore(x,y:integer);
Procedure Add_blocco(xx,yy:integer);
Procedure Caricadistubi(nomePr,nomepia:string;Ris_Calc:Boolean);
Procedure InitPunttubi;
Procedure Progettovuoto;
Procedure Aggiorna_dati(pagsel:integer);
Function colore_CAD(ind:integer):string;
Function indcolore(nomecolore:string):integer;
function IndTlinea(Tlinea:string):integer;
function TlineaCad(indTlinea:integer):string;
Function Item_calc(item_input:integer;Piano:string):integer;

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
      clsfondo:tcolor=clwhite;
      clblocchi:tcolor=clblack;
Var NFig:integer;
    Xprec,Yprec:real;
    ColCor,brushcor:Tcolor;
    ItemCor:integer;
    TlineaCor:TPenStyle;
    SpesCor,Altcor,AlXCor,AlyCor,Tronco_sel:Integer;
    OrigCor:char;
    piano_cor:string[30];
    Contesto:string;
    Rete_sel: Byte;
    itemseledif:integer=0;
    itemseledif_C:integer=0;
    itemselreti:integer=0;
    edit_In_Cad:boolean=false;
    controlla_dis:boolean=false;
    UltAllineaX:real=0;
    UltallineaY:real=0;
    aggiorna_DXF:boolean=true;
    dis_esecutivo:boolean=false;
    VNumpar:boolean=false;
    solonord:boolean=false;
Type RecFig=record
            orig,tipo:char;
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
     Prima_volta,stopweel,controllo,vis_input:Boolean;
     spXpia,spypia:integer;
     ingpia,ing_zoom_in:real;
     Colprec:Tcolor;
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
     ultblocco,ultimafrontiera,ultblocco_I,ultimafrontiera_I:integer;
     Set_finestra:integer=0;
     Set_POnte:integer=0;
     Xtarget,YTarget:real;
     target,zoom_ing:boolean;
     spx_prec,spy_prec,ingprec:real;
     X_temp,Y_temp:real;
     L_infX,L_InfY,L_SupX,L_supY:real;
     Zoom_estensione:boolean;
     MMove:boolean=true;
     MPan:boolean=false;
     X0_pan,Y0_pan:integer;
type Tosnap=(nessuno,estremo,vicino,perpendicolare);
var  osnap:Tosnap;
{ TODO -ografica2d -cNavigazione grafica2d : Variabili grafica2d}
type TModo=(Seleziona,Linea1,Linea2,locale,finestra,ponte);
Var modo:Tmodo;
const Nfin=2;
type recpar=record
            end;
var recfin:array[1..nfin]of recpar;
    errore_grafo:boolean=false;
    errore_grafo_X:real=0;
    errore_grafo_Y:real=0;
Procedure PDes(fin:Integer;x,Y:integer;Panel:Tpanel);
Procedure PSin(fin:Integer;x,Y:integer);
Procedure Cambiacontesto(contesto:string);
Procedure Add_linea(x2,y2:integer);
Procedure Cerchio(x,y,pr:real);
Procedure DisCerchio(Orig:char;Cnv:Tcanvas;x1,y1,R,an1,an2:real;Item:integer);
Procedure Pan_ON(Xpan,YPan:integer);
Procedure Pan_Off(Xpan,YPan:integer);
Procedure Linea_pan(xpan,YPan:integer;Cnv:TCanvas);
implementation
uses
{$Ifdef 3D}
u3dsd,init_cad3d,
Tool_Visualizza3d,
copialetturadisegno3d;
{$else}
Tool_2d,
copialetturadisegno;
{$endif}

{$I Funzionigrafiche1}
Procedure Cambiacontesto(contesto:string);
begin
{$Ifdef rebuli}
cambia_contesto(contesto);
{$Endif}
end;

Procedure Linea_pan(xpan,YPan:integer;Cnv:TCanvas);
begin
//if MPan then
//with canv do
//  begin
//  color:=clred;
//  end;
end;
Procedure Pan_ON(Xpan,YPan:integer);
begin
X0_pan:=XPan;
Y0_Pan:=YPan;
MPan:=true;
end;
Procedure Pan_Off(Xpan,YPan:integer);
begin
if MPan then
  begin
  MPan:=false;
  spo_x:=spo_x+(XPan-X0_pan){/ing};
  spo_y:=spo_y-(yPan-y0_pan){/ing};
  ridisegna;
  end;
end;

function coloreparete(cod:string):tcolor;
begin
with dmtutti.T_strutture do
  begin
  if not active then open;
  first;
  while (not eof) and (V_TabStruttura.NFile<>cod)do next;
  result:=clred;
    case Indcolore(V_TabStruttura.ColCAD) of
    1:Result:=clred;
    2:Result:=clyellow;
    3:Result:=clgreen;
    4:Result:=clPurple ;
    5:Result:=clblue;
    6:Result:=clFuchsia	;
    7:Result:=clblack;
    end;
  end;
end;
function colorepareteIta(cod:string):string;
begin
with dmtutti.T_strutture do
  begin
  first;
  while (not eof) and (V_TabStruttura.NFile<>cod)do next;
  result:=V_TabStruttura.ColCAD;
  end;
end;




Function CercaAmb1(Namb:string):boolean;
Begin
with dmtutti.T_Locali  do
  begin
  first;
  while not(eof) and (V_recAmb.CodNum<>Namb) do Next;
  end;
form1.groupbox9.Caption:='Locale:'+V_recamb.Denom;  
result:=(V_recAmb.CodNum=Namb) ;
end;
 
 { TODO -oGrafica2d -cNavigazione grafica2d : Interspuntolinea }
Function Iterspuntolinea(x1,y1,x2,y2:real;Var X_sel,Y_sel:real;toll:real):boolean;
Var xx,YY:real;
    res:integer;
begin
result:=false;
aprtemp:=apr;
apr:=toll;
inters(xx,yy,res,x1,x2,x_sel-Toll,x_sel+Toll,y1,y2,y_sel-3,y_sel+3);
if res=0 then
inters(xx,yy,res,x1,x2,x_sel+Toll,x_sel-Toll,y1,y2,y_sel+Toll,y_sel-Toll);
apr:=aprtemp;
if res<>0 then
  begin
  X_sel:=xx;
  Y_sel:=yy;
  result:=true;
  end;
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
Procedure DisTerm(Cnv:Tcanvas;Xori,Yori,L,H,Rot,ing:real;item:integer);
Const Orig=0.1;
var L_x,L_y:real;
Procedure Lineaterm(xp1,yp1,xp2,yp2:real);
begin
ModiCord1(xp1,yp1,Xori,Yori,Rot,ing);
ModiCord1(xp2,yp2,Xori,Yori,Rot,ing);
cnv.Moveto(Round(xp1),Round(Hfin-yp1));
cnv.Lineto(Round(xp2),Round(Hfin-yp2));
end;
begin
//xori:=xori+0.5;
L_x:=orig;
L_y:=0;
ModiCord1(L_x,l_y,Xori,Yori,Rot,ing);
DisCerchio('R',cnv,L_x,hfin-L_y,3,0,2*pi,item);
Lineaterm(Orig,H/2,L+Orig,H/2);
Lineaterm(L+Orig,H/2,L+Orig,-H/2);
Lineaterm(L+Orig,-H/2,Orig,-H/2);
Lineaterm(Orig,-H/2,Orig,H/2);
Lineaterm(0,0,Orig,0);
//cnv.Pen.Color:=clblack;
end;

Procedure Dislinea_R(Cnv:Tcanvas;x1,y1,x2,y2:real;Item:integer);
Var XX,YY:real;
    res,i,I_calc:integer;
    nchg:boolean;
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
    itemselreti:=item;
    cnv.Pen.Width:=spes_sel;
    //cnv.Pen.Width:=spes_dis;
   // rete_Sel := dis^[item]^.indRete;
    puntosel:=false;
    if vis_input then
        begin
        nchg:=nocambia;
        nocambia:=true;
        form1.PageControl1.ActivePageIndex:=2;
        form1.PageControl3.ActivePageIndex:=1;
        form1.PageControl25.visible:=true;
        form1.PageControl25.ActivePageIndex:=0;
        form1.groupbox7.Visible:=false;

        dmtutti.T_ConfCad.Edit;
        V_recconfcad.Set_CarCostruttRete(dis_I^[item]^.Tipo);
        dmtutti.T_ConfCad.POst;
        settacoloreTubo;
        nocambia:=nchg;
        end

    (*
    Case Tipo_rete of
    {$IFDEF CANALI}
    trCanali:
    with Vpezzi^[item]^ do
      begin
      {2d-3d
      FMainTubi.PC_DatiRete.ActivePageIndex:=2;
      tronco_sel:=item;
      FMainTubi.LIndpcan.caption:=' ( pezzo:'+inttostr(item)+' )';
      FMainTubi.ECodiceCan.text:=codP;
      FMainTubi.EACan.text:=Float_to_str(A,0);
      FMainTubi.EBCan.text:=Float_to_str(B,0);
      FMainTubi.ERCan.text:=Float_to_str(R,0);
      }
      end;
    {$ENDIF}

    TrTubi:
    with dis^[item]^ do
      begin

      tronco_sel:=tronco;

      Form1.Panel_base.ActivePageIndex:=6;
      Form1.label10.Caption:=inttostr(Dati^[tronco]^.codicetubo);
      // Emanuela introdotta la formattazione dei dati affinchè non compaiono molti
      // valori dopo la virgola
      //FMainTubi.edit1.Text:=Floattostr(Dati^[tronco]^.Lungh);
      Form1.edit1.Text := Format('%1.2f', [Dati^[tronco]^.Lungh]);
      Form1.ED_TipoTubo.Text := Dati^[tronco]^.Tipo;
      Form1.edit4.Text:=Dati^[tronco]^.CodDiam;
      Form1.lfisso.caption:=Dati^[tronco]^.SWDiam;
      // Emanuela introdotta la formattazione dei dati affinchè non compaiono molti
      // valori dopo la virgola
      //FMainTubi.edit5.Text:= Floattostr(Dati^[tronco]^.PortEff);
      Form1.edit5.Text:= Format('%1.4f', [Dati^[tronco]^.PortEff]);
      Form1.Ed_Velocita.Text:= Format('%1.4f', [Dati^[tronco]^.Velocita]);
      Form1.Ed_PCar.Text:= Format('%1.4f', [Dati^[tronco]^.pd * 1000]);
      Form1.Edit8.Text:= Format('%1.4f', [Dati^[tronco]^.pl * 1000]);
      Form1.mperdite.Lines.Clear;
      for i:=1 to Maxpconc do
        begin
        if Dati^[tronco]^.Pconc[i].N<>0 then  Form1.mperdite.Lines.Add('COD : '+Dati^[tronco]^.Pconc[i].Cod+'    N°: '+Inttostr(Dati^[tronco]^.Pconc[i].N));
        end;
     // if Dati^[tronco]^.Pconc[1].N<>0 then FMainTubi.edit8.Text:=Inttostr(Dati^[tronco]^.Pconc[1].N)
      //else FMainTubi.edit8.Text:='';
      //FMainTubi.edit7.Text:=Dati^[tronco]^.Pconc[1].Cod;
      //if Dati^[tronco]^.Pconc[2].N<>0 then FMainTubi.edit10.Text:=Inttostr(Dati^[tronco]^.Pconc[2].N)
      //else FMainTubi.edit10.Text:='';
      //FMainTubi.edit9.Text:=Dati^[tronco]^.Pconc[2].Cod;
      if {(Nlinea=0)and}(dati^[tronco]^.Term<>0) then
      begin
        //FMainTubi.Groupbox5.Visible:=true;
        // Emanuela introdotta la formattazione dei dati affinchè non compaiono molti
        // valori dopo la virgola
        {FMainTubi.edit2.Text:=floattostr(Gterm^[dati^[tronco]^.Term]^.port);
        FMainTubi.edit3.Text:=floattostr(Gterm^[dati^[tronco]^.Term]^.perd);
        FMainTubi.edit6.Text:=floattostr(Gterm^[dati^[tronco]^.Term]^.pot);  }
        Form1.edit2.Text := Format('%1.4f', [Gterm^[dati^[tronco]^.Term]^.port]);
        Form1.edit3.Text := Format('%1.4f', [Gterm^[dati^[tronco]^.Term]^.perd]);
        Form1.edit7.Text := Format('%1.4f', [(risultcalc^.perdita / 2) - dati^[tronco]^.pp]);
        if (CompareStr(UpperCase(Gterm^[dati^[tronco]^.Term]^.TipoTerm), Uppercase('Fancoil')) = 0) and
           (Gterm^[dati^[tronco]^.Term]^.potE <> 0)
        then
          Form1.edit6.Text := Format('%1.0f', [Gterm^[dati^[tronco]^.Term]^.potE])
        else
          Form1.edit6.Text := Format('%1.0f', [Gterm^[dati^[tronco]^.Term]^.pot]);
      end;

      //else FMainTubi.Groupbox5.Visible:=false;
      if CL then
      cnv.Pen.Color:=clyellow;

      end;

    end; //case
    *)
    end
    else
    begin
      //if Rete_Sel <> dis^[item]^.indRete then
      //   cnv.Pen.Color := clYellow;

    end
  end;

if (item<>0)and(itemselreti<>0)and(itemselreti=item)then   cnv.Pen.Width:=spes_sel;
//if Ft^[item].error then   cnv.Pen.Width:=spes_sel;
cnv.Moveto(Round(x1),Round(y1));
cnv.Lineto(Round(x2),Round(y2));

end;

Procedure DisCerchio_R(Cnv:Tcanvas;x1,y1,R,an1,an2:real;Item:integer);
begin
if r<0 then r:=-R;
an1:=an1+pi/2;
an2:=an2+pi/2;
if (puntosel)and(item<>0) then
  begin
  if (abs(x1-xsel)<=8)and(abs(y1-ysel)<=8) then
    begin
    cnv.Pen.Width:=Spes_sel;
    puntosel:=false;
    form1.pagecontrol1.ActivePageIndex:=2;
    form1.pagecontrol3.ActivePageIndex:=2;
    dmtutti.T_ConfCad.Edit;
    with V_recconfcad do
      begin
      Set_PortataIndip(Gterm_I^[item]^.Port);
      end;
    dmtutti.T_ConfCad.POst;
    dmtutti.T_ConfCad.Edit;
    end;
  end;
//cnv.Arc(round(x1-r),round(y1-r),round(x1+r),round(y1+r),round(x1-r),round(y1-r),round(x1-r),round(y1-r));
cnv.Arc(round(x1-r),round(y1-r),round(x1+r),round(y1+r),round(x1+r*sin(an1)),round(y1+r*cos(an1)),round(x1+r*sin(an2)),round(y1+r*cos(an2)));
end;

Function colore_CAD(ind:integer):string;
begin
case ind of
1:Result:='Rosso';
2:Result:='Giallo';
3:Result:='Verde';
4:Result:='Ciano';
5:Result:='Blu';
6:Result:='Magenta';
7:Result:='Bianco';
else result:='Colore '+inttostr(ind);
end;
end;

Function indcolore(nomecolore:string):integer;
begin
nomecolore:=Lowercase(nomecolore);
if copy(nomecolore,1,6)='colore' then
result:=strtoint(copy(nomecolore,8,length(nomecolore)-7))
else
if nomecolore='rosso' then result:=1  else
if nomecolore='giallo' then result:=2  else
if nomecolore='verde' then result:=3  else
if nomecolore='ciano' then result:=4  else
if nomecolore='blu' then result:=5  else
if nomecolore='magenta' then result:=6  else
if nomecolore='bianco' then result:=7
else result:=0;
end;

function TlineaCad(indTlinea:integer):string;
begin
result:='Conf'+inttostr(Indtlinea);
//result:='ACAD_ISO0'+inttostr(Indtlinea+2)+'W100';
end;

Function estraiconfine(confine:string):string;
begin
azzeraidentif;
result:=leggiidentif1(confine);//htot
result:=leggiidentif1(confine);//h2
result:=leggiidentif1(confine);//confine
if uppercase(result)='ESTERNO' then result:='';
end;

function IndTlinea(Tlinea:string):integer;
begin
result:=-1;
if copy(tlinea,1,4)='Conf' then
if (strtoint(copy(tlinea,5,1)))<=8 then
if (strtoint(copy(tlinea,5,1)))>0 then
result:=strtoint(copy(tlinea,5,1));
{
if copy(tlinea,1,9)='ACAD_ISO0' then
if copy(tlinea,11,4)='W100' then
if (strtoint(copy(tlinea,10,1))-2)<=8 then
if (strtoint(copy(tlinea,10,1))-2)>0 then
result:=strtoint(copy(tlinea,10,1))-2;
}
end;

Procedure Dislinea_E(Cnv:Tcanvas;x1,y1,x2,y2:real;Item:integer);
Var XX,YY:real;
    res,amb:integer;
    confine:string;
    nchg:boolean;
    svc:Tcolor;
begin
if (puntosel)and(item<>0)and(itemseledif=0) then
  begin
  aprtemp:=apr;
  apr:=3;
  inters(xx,yy,res,x1,x2,xsel-3,xsel+3,y1,y2,ysel-3,ysel+3);
  if res=0 then
  inters(xx,yy,res,x1,x2,xsel-3,xsel+3,y1,y2,ysel+3,ysel-3);
  apr:=aprtemp;
  if res<>0 then
    begin
    svc:=cnv.pen.color;
    form1.PageControl1.visible:=True;
    form1.Panel28.visible:=True;
    
    itemseledif:=item;
    //cnv.Pen.Width:=Spes_sel;
    puntosel:=false;
    with Ft^[item] do
      begin
     { Flettura.Memo1.Lines.Add('a1='+inttostr(a1));
      Flettura.Memo1.Lines.Add('a2='+inttostr(a2));
      Flettura.Memo1.Lines.Add('x0='+floattostr(x0));
      Flettura.Memo1.Lines.Add('x1='+floattostr(x1));
      Flettura.Memo1.Lines.Add('y0='+floattostr(y0));
      Flettura.Memo1.Lines.Add('y1='+floattostr(y1));}
      if vis_input then
        begin
        nchg:=nocambia;
        //nocambia:=true;
        form1.PageControl1.ActivePageIndex:=1;
        form1.PageControl2.ActivePageIndex:=0;
        form1.PageControl22.ActivePageIndex:=0;
        dmtutti.T_ConfCad.Edit;
        V_recconfcad.Set_TipoParete(Ft^[item].Colore);
        V_recconfcad.Set_ColoreParete(colorepareteita(Ft^[item].Colore));
        confine:=estraiconfine(Ft^[item].tlinea);
        if confine='' then V_recconfcad.Set_ConfineParete('Autorilevato')
        else V_recconfcad.Set_ConfineParete(confine);
        cambiatlinea;
        cambiatipopar;
        dmtutti.T_ConfCad.POst;
        //nocambia:=nchg;
        end
      else
        begin
        if a1<>0 then amb:=a1 else amb:=a2;
        if amb<>0 then
        amb:=strtoint(bll^[amb].attrib1[1]);
        //if cercaAmb(bll^[amb].attrib1[1]) then

        // 2d-3d
        if cercaAmb1(IntToStr(amb)) then
          begin
          dmTutti.T_Pareti.First;
          while (not dmTutti.T_Pareti.Eof)and(item<>v_recPar.Item)do dmTutti.T_Pareti.next;
          form1.Panel_base.ActivePageIndex:=5;
          end;

        end;
      end;
    cnv.pen.color:=svc;
    end;

  end;
if (item<>0)and(itemseledif<>0)and(itemseledif=item)then
cnv.Pen.Width:=spes_sel;
if Ft^[item].error then   cnv.Pen.Width:=spes_sel;
cnv.Moveto(Round(x1),Round(y1));
cnv.Lineto(Round(x2),Round(y2));
end;
Procedure Aggiorna_dati(pagsel:integer);
Var indblocco:integer;
begin
if ed_reti then
  case pagsel of
  0:if itemseledif<>0 then
    if vis_input then
    with Ft^[itemseledif] do
    begin
    colore:=V_recconfcad.TipoParete;
    if V_recconfcad.ConfineParete='Autorilevato' then Tlinea:='3:3::'
    else Tlinea:='3:3:'+V_recconfcad.ConfineParete+':';
    end;
  3:if form1.Label182.Caption<>'' then
    begin
    dmtutti.T_confcad.Edit;
    dmtutti.T_confcad.POst;
    dmtutti.T_confcad.Edit;
    if cercaAmb1(form1.Label182.Caption) then
      begin
      dmtutti.T_Locali.Edit;
      V_recamb.Set_Denom(v_recconfcad.DescrAmb);
      V_recamb.Set_CodZona(v_recconfcad.TipoZonaLoc);
      V_recamb.Set_Impianto(v_recconfcad.ImpZonaLoc);
      V_recamb.Set_T_Pav(v_recconfcad.TipoPavLoc);
      V_recamb.Set_T_soff(v_recconfcad.TiposoffLoc);
      V_recamb.Set_C_Pav(v_recconfcad.ConfPavLoc);
      V_recamb.Set_C_soff(v_recconfcad.ConfSoffLoc);
      dmtutti.T_Locali.POst;
      end;

    indblocco:=1;
    while (indblocco<Ultblocco)and(bll^[indblocco].attrib1[1]<>form1.Label182.Caption)do inc(indblocco);
    with bll^[indblocco] do
      begin
      attrib1[2]:=v_recconfcad.DescrAmb;
      attrib1[4]:=v_recconfcad.TipoZonaLoc+':'+v_recconfcad.ImpZonaLoc+':';
      attrib1[5]:=v_recconfcad.TipoPavLoc+':'+v_recconfcad.ConfPavLoc+':';
      attrib1[6]:=v_recconfcad.TiposoffLoc+':'+v_recconfcad.ConfSoffLoc+':';
      end;
    ridisegna;
    end;
  1:begin
    if (set_finestra<>0)and (bll^[set_finestra].Nome='FIN') then
      begin
      bll^[set_finestra].Attrib1[1]:=v_recconfcad.TipoFinestra;
      ridisegna;
      end;
    end;
  2:begin
    if (set_ponte<>0)and (bll^[set_POnte].Nome='PON') then
      begin
      bll^[set_Ponte].Attrib1[1]:=v_recconfcad.TipoPOntitermici;
      bll^[set_Ponte].Attrib1[2]:=Float_tostr(v_recconfcad.LunghPonteTerm);
      ridisegna;
      end;
    end;
  end
else
  begin
  with form1 do
    begin
    //Tubi
    if (PageControl1.ActivePageIndex=2)and(PageControl3.ActivePageIndex=1)and(PageControl25.visible)and
       (itemselreti<>0) then
      begin
      dis_I^[itemselreti]^.Tipo:=V_recconfcad.CarCostruttRete;
      end;
    end;
  end;
end;
Procedure DisCerchio_E(Cnv:Tcanvas;x1,y1,R,an1,an2:real;Item:integer);
Var Item1:integer;
    ylsel:real;
    ncmb:boolean;
begin
ncmb:=nocambia;
//nocambia:=true;
y1:=y1-4;
if r=0 then r:=5;
if r < 0 then r:=-r;
if (puntosel)and(item<>0)and(itemseledif_C=0) then
  begin
  Ylsel:=ysel-4;
  if (abs(x1-xsel)<=8)and(abs(y1-ylsel)<=8) then
    begin
    cnv.Pen.Width:=Spes_sel;
    itemseledif_C:=item;
    puntosel:=false;
    //2d-3d
    if bll^[item].Nome='AMB' then
    //if vis_input then
      begin
      dmtutti.T_ConfCad.Edit;
      form1.PageControl1.ActivePageIndex:=1;
      form1.PageControl2.ActivePageIndex:=3;
      if form1.CheckBox4.checked then
        begin
        form1.CheckBox4.checked:=false;
        v_recconfcad.set_DescrAmb('Aggre-'+bll^[item].attrib1[1]);
        end
      else
        begin
        form1.Label182.Caption:=bll^[item].attrib1[1];
        form1.Edit12.text:=form1.Label182.Caption;
        v_recconfcad.set_DescrAmb(bll^[item].attrib1[2]);
        if not (form1.CheckBox5.checked) then
          begin
          azzeraidentif;
          V_recconfcad.Set_TipoZonaLoc(leggiidentif1(bll^[item].attrib1[4]));
          V_recconfcad.Set_ImpZonaLoc(leggiidentif1(bll^[item].attrib1[4]));
          azzeraidentif;
          V_recconfcad.Set_TipoPavLoc(leggiidentif1(bll^[item].attrib1[5]));
          V_recconfcad.Set_ConfPavLoc(leggiidentif1(bll^[item].attrib1[5]));
          azzeraidentif;
          V_recconfcad.Set_TiposoffLoc(leggiidentif1(bll^[item].attrib1[6]));
          V_recconfcad.Set_ConfSoffLoc(leggiidentif1(bll^[item].attrib1[6]));
          end;
        end;
      dmtutti.T_ConfCad.POst;
      dmtutti.T_confcad.Refresh;
      dmtutti.T_ConfCad.Edit;
      end
    else
      begin
      cercaAmb1(bll^[item].attrib1[1]);
      form1.Panel_base.ActivePageIndex:=4;
      end;
    if (bll^[item].Nome='FIN')OR(bll^[item].Nome='PON') then
      begin
      if Vis_input then
        begin
        form1.PageControl1.ActivePageIndex:=1;
        dmtutti.T_ConfCad.edit;
        if bll^[item].Nome='FIN' then
          begin
          form1.PageControl2.ActivePageIndex:=1;
          set_finestra:=item;
          v_recconfcad.set_TipoFinestra(bll^[item].Attrib1[1]);
          CambiatipoF;
          end
        else
          begin
          form1.PageControl2.ActivePageIndex:=2;
          set_Ponte:=item;
          v_recconfcad.set_TipoPontiTermici(bll^[item].Attrib1[1]);
          if bll^[item].Attrib1[2]<>'' then
          v_recconfcad.set_LunghPonteTerm(str_tofloat(bll^[item].Attrib1[2]));
          CambiaPOnte;
          end;
        dmtutti.T_ConfCad.POst;
        dmtutti.T_ConfCad.edit;
        end
      else
        begin
        form1.Panel_base.ActivePageIndex:=5;
        item1:=bll^[item].ambienti;
        if Ft^[item1].a1<>0 then item1:=Ft^[item1].a1 else item1:=Ft^[item1].a2;
        if cercaAmb1(bll^[item1].attrib1[1]) then
          begin
          dmTutti.T_Pareti.First;
          while (not dmTutti.T_Pareti.Eof)and(-item<>v_recPar.Item)do dmTutti.T_Pareti.next;
          end;
        end;
      {
      dmtutti.TT3.First;
      while (not dm1.TT3.Eof)and(-item<>v_recPar.Item)do
      dm1.TT3.next;
      }
      end;
     form1.groupbox9.Caption:='Locale:'+V_recamb.Denom;

    end;
  end;
if (item<>0)and(itemseledif_C<>0)and(itemseledif_C=item)then   cnv.Pen.Width:=spes_sel;
cnv.Arc(round(x1-r),round(y1-r),round(x1+r),round(y1+r),round(x1-r),round(y1-r),round(x1-r),round(y1-r));
// Emanuela 29/7/2004 inserito modifica dei combo
// 2d-3d FLettura.ModificaVolumeVC;
//nocambia:=ncmb;
end;
Procedure DisCerchio(Orig:char;Cnv:Tcanvas;x1,y1,R,an1,an2:real;Item:integer);
begin
case orig of
'E':DisCerchio_E(Cnv,x1,y1,R,an1,an2,Item);
'R':DisCerchio_R(Cnv,x1,y1,R,an1,an2,Item);
end;
end;
Procedure Dislinea(Orig:char;Cnv:Tcanvas;x1,y1,x2,y2:real;Item:integer);
begin
case orig of
'E':Dislinea_E(Cnv,x1,y1,x2,y2,Item);
'R':Dislinea_R(Cnv,x1,y1,x2,y2,Item);
end;
end;

procedure settafin(Nfin:Integer);
begin
end;
{ TODO -oGrafica2d -cNavigazione grafica2d : Cursore }
Procedure cursoregrande(crxx,cryy:integer;attiva:boolean);
begin
{$Ifdef 3d}

{$else}
with FTool_visualizza do
  begin
  shape1.Top:=cryy;
  shape1.left:=crxx;
  shape2.Top:=cryy-1200;
  shape2.left:=crxx;
  shape3.Top:=cryy;
  shape3.left:=crxx;
  shape4.Top:=cryy;
  shape4.left:=crxx-1200;
  shape1.Visible:=attiva;
  shape2.Visible:=attiva;
  shape3.Visible:=attiva;
  shape4.Visible:=attiva;
  end
{$endif}
end;
Procedure cursorePiccolo(crxx,cryy:integer;attiva:boolean);
Var X_temp,y_temp:real;
begin
{$Ifdef 3d}

{$else}
with FTool_visualizza do
  begin
  shape5.Top:=cryy;
  shape5.left:=crxx-30;
  shape6.Top:=cryy-30;
  shape6.left:=crxx;
  shape5.Visible:=attiva;
  shape6.Visible:=attiva;
  end
{$endif}
end;
Procedure Cursore(x,y:integer);
begin
if target then
  begin
  cursoregrande(x,y,true);
  X_temp:=xtarget
  //Modicord1(X_temp,y_temp,spo_x,spo_y,0,ing);
  //cursorePiccolo(xtarget,yTarget,true);
  end
else
  begin
  cursoregrande(x,y,false);
  cursorePiccolo(x,y,true);
  end
end;
Procedure set_target(Nfin:integer;Xm,Ym:integer);
begin
target:=true;
settafin(1);
Xtarget:=X_eff(Xm);
Ytarget:=Y_eff(Ym);
cord_Osnap(Xtarget,Ytarget);
annullaosnap;
//ridisegna;
end;
{ TODO -odiego -cNavigazione grafica2d : Pulsante sinistro }


Procedure PSin(fin:Integer;x,Y:integer);
begin
  case modo of
  Linea1:begin
         set_target(1,x,y);
         modo:=linea2;
         end;
  linea2:add_linea(x,Y);
  locale:add_blocco(x,y);
  end;
ridisegna;
end;
Procedure PDes(fin:Integer;x,Y:integer;Panel:Tpanel);
begin
if zoom_ing then
  begin
  spo_x:=spy_prec;
  spo_y:=spy_prec;
  ing:=ingprec;
  end
else
  begin
  spx_prec:=spo_x;
  spy_prec:=spo_y;
  ingprec:=ing;
  Zoom_in(x,y,Panel.Width,panel.Height);
  end;
zoom_ing:=not(zoom_ing);
ridisegna;
end;


Procedure Caricacursore(Percorso_Ris:string);
Var Cur:Hcursor;
begin
Cur:=LoadImage(0,Pchar(Percorso_Ris +'\Immagini\Cursori\Zoomfinestra.cur'),IMAGE_CURSOR,0,0,LR_DEFAULTSIZE or LR_LOADFROMFILE);
if cur<>0 then screen.cursors[CurZoom]:=cur;
end;
{ TODO -odiego -cNavigazione grafica2d : InitGrafica }

Procedure Progettovuoto;
begin
ultft:=0;
ultblocco:=0;
ultimafrontiera:=0;
ultriga:=0;
ultriga_I:=0;
nquote:=0;
Ulttronco:=0;
NGterm:=0;
NGterm_I:=0;
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
Prima_volta:=true;
tronco_sel:=0;
Metaf:=Tmetafile.Create;
{$IFDEF REBULI}
metaf.LoadFromFile(percorsodrive+'\villetta11.wmf');
{$ENDIF}
//metaf.LoadFromFile('C:\progetticpiwinclima\Esempi DXF\pianoterra-master.wmf');
spxpia:=0;
spypia:=0;
ingpia:=1;
stopweel:=false;
ultblocco:=0;
ultimafrontiera:=0;
ultblocco_I:=0;
ultimafrontiera_I:=0;
controllo:=false;
Target:=false;
zoom_ing:=false;
L_infX:=0;
L_InfY:=0;
L_SupX:=10000;
L_supY:=10000;
Zoom_estensione:=true;
Osnap:=nessuno;
vis_input:=true;
end;

Procedure Zoom_estens;
begin
//{$Ifdef Tubi}
prima_volta:=true;
ingpia:=1;
spxpia:=0;
spypia:=0;
//Ridisegna;
//{$Endif}
end;
{ TODO -odiego -cNavigazione grafica2d : zoom }
Procedure Zoom_in(xcen,ycen,LPanel,Hpanel:integer);
Var LL,HH,ing1,centroY:real;
    Pmouse:integer;
     
begin
//ing_zoom_in := 5;
ing1:=ing*ing_zoom_in;
if ing_zoom_in<2 then
  begin
  spo_x:=Xcen-(X_eff(Xcen)*ing1);
  spo_y:=Hfin-Ycen-(Y_eff(Ycen)*ing1);
  //Pmouse:=round(Hfin-Ycen);
  //centroY:=Y_eff(Pmouse);
  //spo_y:=-(centroY-Hfin/2/ing1);
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
{
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
 }
//LL:=Maxx-Minx;
//HH:=Maxy-Miny;
ing:=ing*ing_zoom_in;
//Image.cursor:=CRDefault;
end;

Procedure set_Cursor(NCur:Integer;var Image:TImage);
begin
Image.cursor:=NCur;
end;
Procedure annullaosnap;
begin
osnap:=nessuno;
{$Ifdef 3d}
{$else}
FTool_visualizza.RBosNessuno.Checked:=true;
{$endif}
end;
{ TODO -oGrafica2d -cNavigazione grafica2d : osnap }

Function cord_Osnap(var XOs,YOs:real):boolean;
Var Distmin,dist:real;
    Indvicino,I:integer;
    xmin,ymin:real;
begin
{$Ifdef 3d}
{$else}

result:=true;
//x:=0;
//y:=0;
if (target)and(FTool_visualizza.CBOrto.Checked)and(osnap<>estremo) then
  begin
  if abs(Xos-Xtarget)>abs(yos-ytarget) then
  Yos:=Ytarget
  else Xos:=XTarget;
  end;

  case osnap of
  vicino:begin
         i:=1;
         while( not (Iterspuntolinea(FT_i^[i].x0,FT_i^[i].y0,FT_i^[i].x1,FT_i^[i].y1,Xos,Yos,3/ing)))and(i<ultimafrontiera_I)do
         inc(i);
         with FT_i^[i] do
         result:=Iterspuntolinea(x0,y0,x1,y1,Xos,Yos,3/ing);
         end;
  estremo:begin
          xmin:=xOs;
          ymin:=yOs;
          distmin:=10E6;
          for i:=1 to  ultimafrontiera_I do
          with FT_i^[i] do
            begin
            dist:=abs(xOs-x0)+abs(yOs-y0);
            if dist<distmin then
              begin
              distmin:=dist;
              xmin:=x0;
              ymin:=y0;
              end;
            dist:=abs(xOs-x1)+abs(yOs-y1);
            if dist<distmin then
              begin
              distmin:=dist;
              xmin:=x1;
              ymin:=y1;
              end;
            end;
          xOs:=xmin;
          YOs:=ymin;
          end;

  end;
{$endif}
end;
 { TODO -oGrafica2d -cNavigazione grafica2d : Add_linea }
Procedure Add_linea(x2,y2:integer);
begin
with Ft_I^[ultimafrontiera_I+1] do
  begin
  error:=false;
  x1:=X_eff(X2);
  Y1:=Y_eff(Y2);
  if cord_Osnap(X1,Y1) then
    begin
    x0:=XTarget;
    Y0:=YTarget;
    Z0:=0;
    Z1:=0;
    XTarget:=x1;
    YTarget:=y1;
    inc(ultimafrontiera_I);
    Annullaosnap;
    end;
  end;
end;
Procedure Add_Blocco(xx,yy:integer);
begin
inc(ultblocco_I);
with Bll^[ultblocco_I] do
  begin
  x:=X_eff(XX);
  Y:=Y_eff(YY);
  case modo of
  locale:begin
         attrib1[1]:=inttostr(ultblocco_I);
         Nome:='AMB';
         end;
  finestra,ponte:begin
                 if modo=finestra then Nome:='Fin'
                 else Nome:='Ponte';
                 if not cord_Osnap(X,Y) then
                 dec(ultblocco_I);
                 end;
  end;
  end;
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
result:=ang*pi/180+pi;
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
  orig:=origcor;
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
  orig:=origcor;
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
  orig:=origcor;
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
  orig:=origcor;
  Tipo:='E';
  setattrib;
  end;
end;

Procedure Cerchio(x,y,pr:real);
begin
inc1(Nfig);
with D_fig^[NFig] do
  begin
  orig:=origcor;
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
  orig:=origcor;
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
        Dislinea(orig,cnv,x1,y1,x2,y2,Item);
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
        DisCerchio(orig,cnv,x1,y1,r,0,2*pi,Item);
        end;
    'A':begin
        cnv.Pen.Color:=Colore;
        cnv.Pen.Style:=TLinea;
        cnv.Pen.Width:=spes;
        DisCerchio(orig,cnv,x1,y1,r*ing,x2,y2,Item);
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
         Disterm(cnv,x1,y1,L,H,rotaz+rot,ing,item);
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

Procedure CaricaTarget;
begin
spescor:=spes_dis;
linea(-20,0,20,0);
linea(0,20,0,-20);
colcor:=clblack;
Cerchio(0,0,5);
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
if fileexists(percorsoDrive+'\'+piano_cor+'.int') then
  begin
  assign(fo,percorsoDrive+'\'+piano_cor+'.int');
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
{
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
}  
end;
{$endif}
//{$Ifdef Tubi}

Procedure Ins_term(xo,yo,L,h,rot:real);
begin
if NFig < MaxFig then
   Inc(Nfig);
D_fig^[Nfig].orig:=origcor;
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
D_fig^[Nfig].Item:=Itemcor;
end;
Procedure InitPunttubi;
Var I:integer;
begin
new(dis);
for i:=1 to lungdis do new(dis^[i]);
new(Dati);
for i:=1 to lungDati do new(dati^[i]);
new(GTerm);
for i:=1 to Maxgterm do new(Gterm^[i]);
new(Risultcalc);
end;

Function Item_calc(item_input:integer;Piano:string):integer;
begin
result:=0;
if (V_recgen.Report<>Str_Calc_OK)or(ultriga=0)  then exit;
result:=1;
while (result<ultriga)and((dis^[result]^.Item_input<>item_input)or(Uppercase(dis^[result]^.PianoCad)<>Uppercase(Piano)))do inc(result);
end;

Procedure Caricadistubi(nomePr,nomepia:string;Ris_Calc:Boolean);
Var FU3d:file of definiz.cadrec;
    FD3d:file of calcrec;
    FT3d:file of recGterm;
    FO3d:file of DatiInt;
    Fq2d:file of recquo;
    i:integer;
begin
retecor:=nomePr;
if nomepr='' then
  begin
  ultriga:=0;
  Ulttronco:=0;
  NGterm:=0;
  exit;
  end;

Nquote:=0;
if fileexists(I_Sl(PercorsoDrive) + Nomepr +'-'+nomepia+ '.Q2D')  then
  begin
  assign(Fq2d,I_Sl(PercorsoDrive) + Nomepr +'-'+nomepia+ '.Q2D');
  reset(Fq2d);
  while not eof(Fq2d) do
    begin
    inc(Nquote);
    read(Fq2d,quote^[Nquote]);
    end;
  close(Fq2d);
  end;
Ultriga_I:=0;
if fileexists(I_Sl(PercorsoDrive) + Nomepr +'-'+nomepia+ '.U2D')  then
  begin
  assign(FU3d,I_Sl(PercorsoDrive) + Nomepr +'-'+nomepia+ '.U2D');
  reset(FU3d);
  while not eof(fu3d) do
    begin
    inc(ultriga_I);
    if dis_I^[ultriga_I]=Nil then new(dis_I^[ultriga_I]);
    read(fU3d,Dis_I^[ultriga_I]^);
    end;
  close(Fu3d);
  end;
NGterm_I:=0;
if fileexists(I_Sl(PercorsoDrive) + Nomepr +'-'+nomepia+ '.T2D')  then
  begin
  assign(FT3d,I_Sl(PercorsoDrive) + Nomepr +'-'+nomepia+ '.T2D');
  reset(FT3d);
  while not eof(fT3d) do
    begin
    inc(NGterm_I);
    if Gterm_I^[NGterm_I]=Nil then new(Gterm_I^[NGterm_I]);
    read(fT3d,Gterm_I^[NGterm_I]^);
    end;
  close(FT3d);
  end;

Ultriga:=0;
if fileexists(I_SL(PercorsoDrive) + Nomepr + '.U3D') then
  begin
  assign(FU3d,IncludeTrailingPathDelimiter(PercorsoDrive) + Nomepr + '.U3D');
  reset(FU3d);
  while not eof(fu3d) do
    begin
    inc(ultriga);
    if dis^[ultriga]=Nil then new(dis^[ultriga]);
    read(fU3d,Dis^[ultriga]^);
    end;
  close(Fu3d);
  end;

if ris_calc then
  begin
  Ulttronco:=0;
  if fileexists(I_SL(PercorsoDrive) + Nomepr + '.D3D') then
    begin
    assign(FD3d,IncludeTrailingPathDelimiter(PercorsoDrive) + Nomepr + '.D3D');
    reset(FD3d);
    while not eof(fD3d) do
      begin
      inc(Ulttronco);
      if dati^[Ulttronco]=Nil then new(dati^[Ulttronco]);
      read(fD3d,Dati^[Ulttronco]^);
      end;
    close(FD3d);
    end;

  NGTerm:=0;
  if fileexists(I_Sl(PercorsoDrive) + Nomepr + '.T3D') then
    begin
    assign(FT3d,IncludeTrailingPathDelimiter(PercorsoDrive) + Nomepr + '.T3D');
    reset(FT3d);
    while not eof(fT3d) do
      begin
      inc(NGTerm);
      if GTerm^[NGTerm]=Nil then new(GTerm^[NGTerm]);
      read(fT3d,GTerm^[NGTerm]^);
      end;
    close(FT3d);
    end;
  if fileexists(I_SL(PercorsoDrive) + Nomepr + '.O3D') then
    begin
    assign(FO3d,IncludeTrailingPathDelimiter(PercorsoDrive) + Nomepr + '.O3D');
    reset(FO3d);
    read(fO3d,RisultCalc^);
    close(FO3d);
    end;
  end;
set_tipo_rete('TUBAZIONI');
end;

{ TODO -ografica2d -cNavigazione grafica2d : Disegno reti }
Procedure LeggiDisegno_tubi_I(canv : TCanvas);
Var i,I_calc:integer;
    pxt,pyt,hterm,lTerm:real;
begin
//primavolta:=true;
leggiPianta;
pianocor:=V_recconfcad.PIANOCOR;
for i:=1 to ultriga_I  do
with dis_I^[i]^ do
  begin
  lim(x2,MaxX,Minx);
  lim(x1,MaxX,Minx);
  lim(y2,Maxy,Miny);
  lim(y1,Maxy,Miny);
  Itemcor:=i;
  spescor:=1;
  colcor:=clred;
  //colcor:=clwhite;
  linea(x1,y1,x2,y2);
  if (rimando<>'')then
    begin
    cerchio(x1,y1,-3);
    if (rimando[1]='B') then
      begin
      Testo(x1,y1-10/ing,'Ripresa');
      end
    else
      begin
      Testo(x1,y1-10/ing,'Rimando');
      end;
    end;
  I_calc:=Item_calc(i,Pianocor);
  if I_calc<>0 then
  if dis^[i_calc]^.nlinea=0 then
  if dis^[i_calc]^.tronco<>0 then
  with dati^[dis^[i_calc]^.tronco]^ do
  if(x<>0)or(y<>0) then
    begin
    colprec:=colcor;
    colcor:=clblack;
    Testo(x,y,coddiam);
    Testo(x,y+14/ing,float_to_str(velocita,2)+' m/s');
    colcor:=colprec;
    end;
  end;
for i:=1 to NGTerm_I  do
with GTerm_I^[i]^ do
  begin
  Itemcor:=i;
  spescor:=1;
  colcor:=clred;
  //colcor:=clwhite;
  Hterm:=0.2;
  LTerm:=1;
  if uppercase(copy(Nomeblocco,1,7))='TERMPAN' then Lterm:=Hterm;
  ins_term(xTerm,yTerm,LTerm,Hterm,angolo_bm(Angolo));
  //Testo(xTerm+24/ing,yTerm+72/ing,float_to_str(GTerm_I^[i]^.angolo,2));
  end;
for i:=1 to NGTerm  do
with GTerm^[i]^ do
  begin
  pxt:=Xetic;
  pyt:=Yetic;
  colcor:=clblack;
  Testo(pxt,pyt+24/ing,float_to_str(pot,0)+' W');
  Testo(pxt,pyt+36/ing,float_to_str(port,3)+' l/s');
  Testo(pxt,pyt+48/ing,serie);
  if numelementi<>0 then
  Testo(pxt,pyt+60/ing,inttostr(numelementi)+' elementi')
  else Testo(pxt,pyt+60/ing,modello);
  end;
end;
Procedure LeggiDisegno_tubi_C(canv : TCanvas);
Var i:integer;
    xmedio,Ymedio:real;
    pp:integer;
    st: string;
    Posizione: Integer;
    //Emanuela 29/6/2006 variabile che serve per scrivere una volta sola il diametro del collettore
    Collet: Boolean;
begin

OrigCor:='R';
//Emanuela 29/6/2006 variabile che serve per scrivere una volta sola il diametro del collettore
Collet := False;

If uppercase(Form1.ComboBox2.Text)='RETE PRINCIPALE' then
  begin
  Piano_cor:=V_recconfcad.PIANOCOR;
  end;
leggiPianta;
//for i:=1 to ultriga do
//if Dis^[i]^.piano<>'' then
//pianocor:=Dis^[i]^.piano;
st := Form1.ComboBox2.Text;
colcor:=clblue;
spescor:=spes_dis;
{$IF Defined(VERSIONE_11)}

{$ELSE}
//disegnacollettori(false);
{$IFEND}
for i:=1 to ultriga do
with Dis^[i]^ do
//if uppercase(Form1.ComboBox2.Text) = Uppercase(Filtro) then
if uppercase(Piano_cor) = Uppercase(PianoCad) then
begin
if true then
  begin
  //if (pianocad<>'')and(filtro<>'') then
  //piano_cor:=pianocad;
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
  if (tronco<>0)and(tronco<=UltTronco)and(dati^[tronco].ti=i)and (dati^[tronco].Coddiam<>'')
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
  if errore_Grafo then
    begin
    if visitato then spescor:=spes_sel;
    end
  else
  if (tronco=tronco_sel)then spescor:=spes_sel;
  linea(x1,y1,x2,y2);

  if nLinea=0 then
    begin

    if (tronco<>0)and(tronco<=UltTronco)and(dati^[tronco]^.Npros=1) then
      begin
      pp:=dati^[tronco]^.pros[1];
      pp:=dati^[PP]^.Ti;
      if Dis^[pp]^.Settore<>'' then testo(x2,y2,Dis^[pp]^.Settore)
      end;
    //if (tronco<>0)and(dati^[tronco]^.Npros=0) then cerchio(x2,y2,-8);
    if (tronco<>0)and(tronco<=UltTronco)and(dati^[tronco]^.Term<>0) then
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
    spescor:=spes_sel;
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
Procedure LeggiDisegno_tubi(canv : TCanvas);
begin
OrigCor:='R';
Nfig:=0;
Maxx:=-10E6;
Maxy:=-10E6;
Minx:=10E6;
Miny:=10E6;
//primavolta:=true;
//leggiPianta;


if ((V_recgen.Xori<>0)or(V_recgen.Yori<>0))and(uppercase(V_recgen.Piano)=uppercase(V_recconfcad.PIANOCOR))and(uppercase(V_recgen.codice)=uppercase(Retecor)) then
  begin
  cerchio(V_recgen.Xori,V_recgen.Yori,-3);
  colprec:=colcor;
  colcor:=clblack;
  testo(V_recgen.Xori,V_recgen.Yori,'Inizio rete');
  if (V_recgen.Report=Str_Calc_OK)and(ultriga<>0)  then
  testo(V_recgen.Xori,V_recgen.Yori+12/ing,float_to_str(V_recgen.Portata,3)+ ' l/s');
  testo(V_recgen.Xori,V_recgen.Yori+24/ing,float_to_str(V_recgen.Prevalenza,1)+ ' kPa');
  colcor:=colprec;
  end;
If (errore_grafo_x<>0)or(errore_grafo_y<>0)then
begin
Itemcor:=0;
colcor:=clred;
spescor:=spes_sel;
Cerchio(errore_grafo_X,errore_grafo_Y,-15);
end;
if vis_input then LeggiDisegno_tubi_I(canv)
else LeggiDisegno_tubi_C(canv);
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
OrigCor:='R';
{
if ultriga<>0 then
begin
MaxX:=-10E6;
Minx:=10E6;
Maxy:=-10E6;
Miny:=10E6;
end;
}
If uppercase(Form1.ComboBox2.Text)='RETE PRINCIPALE' then
Piano_cor:=V_recgen.piano;
colcor:=clred;
Itemcor:=0;
spescor:=1;

//leggiPianta;
if fileexists(PercorsoDrive+'\disegnocanali.dsc') then
  begin
  assignfile(fdim,PercorsoDrive+'\disegnocanali.dsc');
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
(*
procedure Leggidisegno(canv : TCanvas);
begin
Case Tipo_rete of
{$IFDEF CANALI}
TrCanali:leggidisegno_Canali(canv);
{$ENDIF}
TrTubi:leggidisegno_Tubi(canv);
end;
end;
*)
//{$endif}
{$Ifdef carichi}
{ TODO -ografica2d -cNavigazione grafica2d : Disegno edificio }
Procedure leggiDisegnoEdificioElaborato(canv : TCanvas);
Var i:integer;
    nn:string;
const ftsc=100;
begin
Origcor:='E';
CaricaNord;
brushcor:=clsfondo;
Disegna(canv,40,Hfin-40,1,(direznord+180)*pi/180);
Nfig:=0;
Maxx:=-10E6;
Maxy:=-10E6;
Minx:=10E6;
Miny:=10E6;
brushcor:=clTeal;
alycor:=aly_sopra;
alxcor:=alx_sin;
if solonord then exit;
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
colcor:=clblocchi;
for i:=1 to ultblocco do
with Bll^[i] do
  begin
  Itemcor:=i;
  alxcor:=alx_sin;
  nn:='';
  if VNumpar then nn:='('+inttostr(-i)+')';
  If (nome='FIN')or (nome='PON') then Testo(x/ftsc,y/ftsc,attrib1[1]+nn);
  If nome='AMB' then
    begin
    alxcor:=alx_cen;
    Testo(x/ftsc,y/ftsc,attrib1[1]+' - '+attrib1[2]);
    end;
  Cerchio(x/ftsc,y/ftsc,0);
  end;

for i:=1 to ultimafrontiera do
with Ft^[i] do
  begin
  if (estraiconfine(Ft^[i].tlinea)<>'')and(vis_input) then TlineaCor:=psDashDot;

  if vis_input then
    begin
    colcor:=coloreparete(Ft^[i].colore);
    end
  else
    begin
    colcor:=clred;
    if (a1<>0)and(a2<>0) then colcor:=clgreen;
    end;
  if (Uppercase(Ft^[i].Colore)='FITTIZIA') then
    begin
    if vis_input then
    colcor:=clred;
    TlineaCor:=psDot;
    end;
  lim(x0/ftsc,MaxX,Minx);
  lim(x1/ftsc,MaxX,Minx);
  lim(y0/ftsc,Maxy,Miny);
  lim(y1/ftsc,Maxy,Miny);
  Itemcor:=i;
  if VNumpar then
  Testo(((x0+x1)/2+15)/ftsc,((y0+Y1)/2-10)/ftsc,inttostr(i));
  linea(x0/ftsc,y0/ftsc,x1/ftsc,y1/ftsc);
  TLineacor:=PsSolid;
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
if  ((erroreX<>0)or(erroreY<>0))and(uppercase(erroreneldisegno)<>letturacorretta) then
begin
Itemcor:=0;
colcor:=clred;
spescor:=spes_sel;
Cerchio(erroreX/ftsc,errorey/ftsc,-15);
end;

end;
Procedure LeggiDisegno(canv : TCanvas);
begin
if form1.checkbox2.Checked then
LeggidisegnoEdificioElaborato(Canv)
else leggiPianta;

if form1.checkbox3.Checked then
Case Tipo_rete of
{$IFDEF CANALI}
TrCanali:leggidisegno_Canali(canv);
{$ENDIF}
TrTubi:leggidisegno_Tubi(canv);
end;

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
    savesize:integer;
    Tempmessaggio:string;
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
rett.Right:=1800;
rett.Bottom:=1024;
canv.Brush.Color:=clsfondo;
canv.fillrect(rett);

NFig:=0;
Risp:=80;
//totlamp:=0;
colcor:=clsfondo;
Itemcor:=0;
TLineacor:=PsSolid;
altcor:=10;
SpesCor:=1;
brushcor:=clwhite;
colcor:=clblack;
canv.Pen.Color:=clblack;
//Analisi_disegno;
LeggiDisegno(canv);
{$Ifdef 3d}
{$else}
//ultblocco:=ultblocco_I;
//ultimafrontiera:=ultimafrontiera_I;
//Ft^:=Ft_I^;
metaf.LoadFromFile(percorsodrive+'\villetta1.wmf');
canv.StretchDraw(rect(0,0,round(metaf.Width),round(metaf.height)),metaf);
consiglio(erroreneldisegno);
{$endif}

{ TODO -odiego -cNavigazione grafica2d : esegui disegno 2d }
if prima_volta then
  begin

  if not(zoom_estensione) then
    begin
    Minx:=L_infX;
    Miny:=L_InfY;
    Maxx:=L_SupX;
    Maxy:=L_supY;
    end;
  if Maxy-Miny>0.01 then
  ing:=(Hfin-150)/(Maxy-Miny)
  else ing:=10E6;
  if Maxx-Minx>0.01 then
  if ing > (Lfin-150)/(Maxx-Minx) then ing:=(Lfin-150)/(Maxx-Minx);
  Spo_x:=(LFin/2)-(Minx+Maxx)*ing/2;
  Spo_y:=(HFin/2)-(Miny+Maxy)*ing/2;
  Prima_volta:=false;
  end;
if (Xsel<>0)or(ysel<>0) then tronco_sel:=0;



Disegna(canv,Spo_X,Spo_Y,ing,0);
if target then
  begin
  Nfig:=0;
  CaricaTarget;
  brushcor:=clsfondo;
  X_temp:=Xtarget;
  Y_temp:=Ytarget;
  Modicord1(X_temp,y_temp,spo_x,spo_y,0,ing);
  Disegna(canv,X_temp,Hfin-y_temp,1,0);
  end;
//spxpia:=-200;
//spypia:=0;
//ingpia:=1;
//canv.StretchDraw(rect(0+spxpia,0+spypia,round(metaf.Width*ingpia+spxpia),round(metaf.height*ingpia+spypia)),metaf);


{$ifdef tubi}
LeggiDisegno(canv);
canv.Brush.Color:=clwhite;
canv.fillrect(rett);
Disegna(canv,Spo_X,Spo_Y,ing,0);

{$endif}
Piano_cor:=V_recconfcad.PIANOCOR;
if (edit_in_CAD)or((Pianisimili(Piano_cor)<>''){and(vis_input)}) then
  begin
  savesize:=canv.font.size;
  canv.Brush.Color:=clwhite;
  canv.pen.Color:=clBlack;
  canv.font.size:=15;
  if edit_in_CAD then Tempmessaggio:='Disegno in elaborazione nel CAD esterno'
  else Tempmessaggio:='Copia di: '+ Pianisimili(Piano_cor);
  canv.TextOut(100,30,Tempmessaggio);
  canv.font.size:=savesize;
  end;
{$IfNdef dllbm}
form1.PageControl1.visible:=(itemseledif<>0)or(itemseledif_C<>0)or(form_prop)or(edit_in_cad);
form1.Panel28.visible:=((itemseledif<>0)or(itemseledif_C<>0)or(form_prop))and(not edit_in_cad);
{$Endif}
end;
end.
