unit Collettori;

interface
uses definiz,geometria,libreriagenerale,gestdim;
Procedure DisegnaCollettori(dxf:boolean);

implementation
{$Ifdef Versione_14}
 uses grafica2d,
  {$else}
 uses grafica,
  {$endif}
 leggidxf;
Procedure DisegnaCollettori(dxf:boolean);

Procedure IterdisegnaColle(tr:integer;Cll:boolean;Var dir,dirz,Xini,Yini,Max_X:real);
Var i:integer;
    cll1,inicol:boolean;
    xt,yt:real;
    PianoCol:string;

Procedure lineacol(Piano:string;x1,y1,x2,y2,rot,spx,spy:real);
begin
geometria.modicord1(x1,y1,spx,spy,rot,1);
geometria.modicord1(x2,y2,spx,spy,rot,1);
lim(x1,MaxX,Minx);
lim(x2,MaxX,Minx);
lim(y1,Maxy,Miny);
lim(y2,Maxy,Miny);
if dxf then
  begin
  linea_dim(piano,x1,y1,x2,y2,'ESECUTIVO_RETE','7','1');
  end
else
  begin
  //linea(x1,y1,x2,y2);
  end;
end;

begin
inicol:=false;
cll1:=cll;
if Dati^[Tr] <> nil then
begin
  i:=dati^[tr].Ti;
  while i<>0 do
    begin
    if dis^[i]^.cl  then
      begin
      if  not(cll1) then
        begin
        cll1:=true;
        inicol:=true;
        max_x:=0;
        with dis^[i]^ do
          begin
          Pianocol:=Pianocad;
          try
            calc_d(x1,y1,z1,x2,y2,z2,dir,dirz);
          except
            dir := 0;
            dirz := Pi/2;
          end;  
          Dir:=dir-pi/2;
          //dir:=0;
          xini:=x1;
          Yini:=y1;
          end;
        end;
      end
    else
      begin
      if  cll1 then
        begin
        cll1:=false;
        xt:=dis^[i]^.x1-xini;
        Yt:=dis^[i]^.y1-yini;
        geometria.modicord1(xt,yt,0,0,-dir,1);
        if xT>max_x then Max_x:=xt;
        end;
      end;
    i:=dis^[i].nlinea;
    end;
  cll:=cll1;
  with dati ^[tr]^ do
    begin
    i:=1;
    while (i<7)and(pros[i]<>0) do
      begin
      IterDisegnaColle(Pros[i],cll,dir,dirz,Xini,Yini,Max_x);
      inc(i);
      end
    end;
  if inicol then
    begin
    //max_x:=1;
    lineacol(PianoCol,0,-rispmanrit,max_x+rispmanrit+manrit,-rispmanrit,dir,Xini,YIni);
    lineacol(PianoCol,0,-rispmanrit,0,manrit+rispmanrit,dir,Xini,YIni);
    lineacol(PianoCol,0,manrit+rispmanrit,Max_x+rispmanrit+manrit,manrit+rispmanrit,dir,Xini,YIni);
    lineacol(PianoCol,Max_x+rispmanrit+manrit,manrit+rispmanrit,Max_x+rispmanrit+manrit,-rispmanrit,dir,Xini,YIni);
    //lineacol(PianoCol,0,-rispmanrit,Max_x+rispmanrit+manrit,rispmanrit+manrit,dir,Xini,YIni);
    end;
 end;
end;

Var dir,dirz,Xini,Yini,Max_x:real;
begin
IterDisegnaColle(risultcalc^.origine,false,dir,dirz,Xini,Yini,Max_x);
end;

end.
