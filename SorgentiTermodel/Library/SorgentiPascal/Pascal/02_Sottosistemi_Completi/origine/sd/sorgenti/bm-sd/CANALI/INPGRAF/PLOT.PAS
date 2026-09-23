{$A+,B-,D+,E-,F+,I+,L+,N-,O+,R+,S+,V+}

{$C DEMANDLOAD}
unit plot;

interface

uses definiz,angoli,genproc,globfunz,diseg,esiste;



procedure plotter(sp,dim:integer;fs:real;nome:string);

implementation

procedure plotter(sp,dim:integer;fs:real;nome:string);




const MaxEpiante=20;
      MaxSez    =20;

colp:array[1..15]of integer=(1,2,3,4,5,6,8,8,1,2,3,4,5,7,8);
type

    RecPiante = record
                    NomeP  : string[8];
                    ZPMin  : real;
                    ZPMax  : real;
                end;

    EPianteAr = array[1..maxEPiante] of RecPiante;


var  EPt       :EPianteAr;
     Fept      :file of EPianteAr;
     nomepianta:string;

var     ft:text;
type recdis=record mov:boolean;x,y:integer end;

type indici= record
                iniz:integer;
                fin:integer;
                dx:integer;
                end;
arInd=array[0..255] of indici;
dlttype=array[0..10000] of recdis;

var ind:^arInd;
    fIND:file of ArInd;
    linech:^dlttype;
    fFont:file of recdis;
    adattato:boolean;
    st2:string;
    A0,alzata:BOOLEAN;
    ch:char;

var Ii,k,v:integer;
    f:text;
    pxi3,pyi3,xt,yt:real;
    real5:real;
    spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2,xinfp,yinfp,xsupP,ysupP:real;
    fp,fx:real;
    fr:integer;
    tratt:boolean;
    AltN,AltNC:real;
    A0X,A0Y:REAL;



const a='PA';
      d='PD;';
      u='PU;';
      i='IP;';
      p='SP';
      fct=0.018;




{************************** Xgp    *****************************************}
Function XgP(x:real):real;
begin

  Xgp:=((x-Xinfp)*1000/(xsupp-xinfp))
end;


{************************** Ygp    *****************************************}
Function YgP(Y:real):real;
begin
  Ygp:=((Y-YinfP)*750/(Ysupp-Yinfp))
end;


{************************** Xg3    *****************************************}
Function Xg3(x,y:real):real;
begin
  Xg3:=(x-y/2*sin(pi/4))
end;

{************************** Yg3    *****************************************}
Function Yg3(Y,z:real):real;
begin
  Yg3:=(z+y/2*cos(pi/4))
end;


{************************** converticord   *****************************************}


Procedure converticord(var Xscal,Yscal:real;P1x,P1y,P2x,P2y,U1x,U1y,U2x,U2y:real);
begin

  Xscal:=(P2x-P1x)/(U2x-U1x)*Xscal+P1X-(U1x*(P2x-P1x)/(U2x-U1x));
  Yscal:=(P2Y-P1Y)/(U2Y-U1Y)*Yscal+P1Y-(U1Y*(P2Y-P1Y)/(U2Y-U1Y));

end;







procedure s_Char(Ch:char;Ix,Iy:real;Dir:integer;Ht:real);


var i:integer;
    coeffM:real;
    lx,ly:real;


begin
 write(f,u);
 lx:=0;ly:=0;
 coeffM:=0.1*ht*fct;
 with ind^[ord(ch)] do
 if Iniz<> 0 then
 begin
   for i:=Iniz to fin do
   begin
     if dir=0 then
     begin
       if linech^[i].mov then
       begin

          lx:=round(linech^[i].x);
          ly:=round(linech^[i].Y);
          write(f,U);
          real1:=(lx*CoeffM)+Ix;
          real2:=(ly*coeffM)+Iy;

          if dim=0 then
          converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2)
          else
          if a0 then
          begin
            real1:=real1-a0x;
            real2:=real2-a0y;
          end;

          write(f,a,round(real1*fs),',',round(real2*fs),';');
       end
       else
       begin
          lx:=round(linech^[i].x);
          ly:=round(linech^[i].Y);
          real1:=((lx)*coeffM)+Ix;
          real2:=((ly)*CoeffM)+Iy;
          write(f,d);
          if dim=0 then
          converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2)
          else
          if a0 then
          begin
            real1:=real1-a0x;
            real2:=real2-a0y;
          end;

          write(f,a,round(real1*fs),',',round(real2*fs),';');
       end;
     end
     else
     begin
       if linech^[i].mov then
       begin
         lx:=round(linech^[i].x);
         lY:=round(linech^[i].Y);
         real1:=-(ly*CoeffM)+Ix;
         real2:=(lx*CoeffM)+Iy;
         write(f,U);
         if dim=0 then
          converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2)
          else
          if a0 then
          begin
            real1:=real1-a0x;
            real2:=real2-a0y;
          end;

          write(f,a,round(real1*fs),',',round(real2*fs),';');
       end
       else
       begin
         lx:=round(linech^[i].x);
         lY:=round(linech^[i].Y);
         real1:=-(ly*coeffM)+Ix;
         real2:=(lx*coeffM)+Iy;
         write(f,d);
         if dim=0 then
          converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2)
          else
          if a0 then
          begin
            real1:=real1-a0x;
            real2:=real2-a0y;
          end;

          write(f,a,round(real1*fs),',',round(real2*fs),';');
       end;
     end;
   end;
 end;
 write(f,u);
end;

procedure s_String(st:string;Ix,Iy:real;Dir:integer;Ht:real);

var i:integer;
    spostX:real;

begin
spostX:=0;
for i:= 1 to length(st) do
begin
  if dir=0 then
    begin
     S_char(st[i],Ix+spostX,Iy,Dir,Ht);
     if st[i] <>' ' then
     spostX:=Round(spostX+ind^[ord(st[i])].dx*ht*0.1*fct) else
     spostX:=Round(spostX+ind^[ord('A')].dx*ht*0.1*fct)
    end
    else
    begin
     S_char(st[i],Ix,Iy+spostX,Dir,Ht);
     if st[i] <>' ' then
       spostX:=Round(spostX+ind^[ord(st[i])].dx*ht*0.1*fct)
     else
       spostX:=Round(spostX+ind^[ord('A')].dx*ht*0.1*fct)
    end
end;
end;





{***************************  DISNUMERI      *******************************}

Procedure DisNumeriS(Colore:integer);

Procedure DisNum(tri:integer);

var k,est:integer;
    altNodi:real;

begin
if (dati^[tri]^.ti<>0) then
    begin

    k:=dati^[tri]^.ti;
      while dis^[k]^.nlinea<>0 do k:=dis^[k]^.nlinea;

    if  (dati^[tri]^.x=0)and(dati^[tri]^.y=0) then

      begin

      dati^[tri]^.x:=dis^[k]^.x2;
      dati^[tri]^.y:=dis^[k]^.y2;

      end;


    (*if (Dis^[k].flag)or
       ((not sezione)and(dis^[k].z2=RisultCalc.quota))or
       (App_Sez(k,2,est)) then*)

      begin

      real1:=xgp(xg3(dati^[tri]^.x*fx,dati^[tri]^.y*fx));
      real2:=ygp(yg3(dati^[tri]^.y*fx,Dis^[k]^.Z2*fx));
      st1:='';
      str(dati^[tri]^.num,st1);
      if dati^[tri]^.num=0 then
        begin
        str(tri,st1);
        st1:='N'+st1
        end;
      s_string(st1,real1,real2,0,10);
      end;
    end;


end;


var i,k,est:integer;
    altNodi:real;

begin
  for i:=1 to ulttronco do
  DisNum(i);
end;



{***************************  DISBOCS      *******************************}

Procedure DisBocS(NL:integer);

Var NPZ:integer;
    Trovato:Boolean;
    Dir,Dirz:Real;
    X1L,Y1L:real;
    DimSim:real;

begin

DimSim:=(*50*100/Conf.Altnum;*)120;
if Dis^[NL]^.NLinea=0 then
if Dati^[Dis^[NL]^.tronco]^.Pros[1]=0 then
if Dati^[Dis^[NL]^.tronco]^.Pezzi[1]<>0 then
  begin
  NPZ:=0;
  Trovato:=false;
    repeat

    NPZ:=NPZ+1;
    if NPZ=PezziTr then trovato:=true
    else Trovato:=Dati^[Dis^[NL]^.tronco]^.Pezzi[NPZ+1]=0;

    until trovato;
  if VPezzi^[Dati^[Dis^[NL]^.tronco]^.Pezzi[NPZ]]^.Port<>0 then
    begin
    CalcDirez(NL,Dir,DirZ);
    (*if sezione then Dir:=Pi/2-DirZ;*)


    real1:=1;
    real2:=0;
    Modicord1(real1,real2,dis^[nl]^.x2,dis^[nl]^.y2,dir,dimsim);
   (* writeln(ft,'r1 ',real1:5:0,' r2 ',real2:5:0,' x2 ',dis^[nl].x2:5:0,' y2 ',dis^[nl].y2:5:0);*)

    real1:=xgp(xg3(real1*fx,real2*fx));
    real2:=ygp(yg3(real2*fx,dis^[nl]^.z2*fx));



    converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);
    write(f,u);
    write(f,a,round(real1),',',round(real2),';');

    real1:=-1;
    real2:=0;
    Modicord1(real1,real2,dis^[nl]^.x2,dis^[nl]^.y2,dir,dimsim);
   (* writeln(ft,'r1 ',real1:5:0,' r2 ',real2:5:0,' x2 ',dis^[nl].x2:5:0,' y2 ',dis^[nl].y2:5:0);*)

    real1:=xgp(xg3(real1*fx,real2*fx));
    real2:=ygp(yg3(real2*fx,dis^[nl]^.z2*fx));

    converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);

    write(f,d);
    write(f,a,round(real1),',',round(real2),';');




    end;
  end;
end;


{***************************  exist      *******************************}

 function Exist(Nome:string):boolean;
 var f:file;
 begin
    exist:=false;
    {$I-} assign(f,Nome);reset(f);{$I+}
    if (ioresult=0) then
    begin
      close(f);
      Exist:=true
    end;
 end;


procedure arcplt(xa1,ya1,ang1,ang2,r:real;tr:boolean);

var
    x,y,angtemp:real;
    i:integer;

begin
  i:=0;
  if ang1>ang2 then
   begin
     ang2:=ang2+2*pi;
   end;
   x:=r*COS(ang1)+xa1;
   y:=r*SIN(ang1)+ya1;
   (*converticord(x,y,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);*)
   x:=round(x);
   y:=round(y);
   write(f,u,a,round(x*fs),',',round(y*fs),';');
   write(f,d);
   repeat
     x:=r*COS(ang1)+xa1;
     y:=r*SIN(ang1)+ya1;
     ang1:=ang1+(ang2-ang1)/40;
     (*converticord(x,y,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);*)
     x:=round(x);
     y:=round(y);
     write(f,a,round(x*fs),',',round(y*fs),';')
   until (ang2)-(ang1)<=0.025;
end;







Procedure PArcP;

const Ndiv=20;

var i:integer;
    angpr,xpr,ypr,Xcor,ycor,Rcor:real;
    StepAng,StepCos:real;
begin
  with Vettore Do
  begin
    StepCos:=Pi/Ndiv;
    StepAng:=(y2-x2)/Ndiv;
    x2:=x2+2*pi;
    y2:=y2+2*pi;
    xpr:=X1+R*Cos(x2);
    ypr:=Y1+R*Sin(x2);
    xpr:=xpr;
    ypr:=ypr;
    real1:=xpr-A0X;
    real2:=ypr-A0Y;
    (*converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);*)
    write(f,u,a,round(real1*fs),',',round(real2*fs),';');


    write(f,d,'LT');
    for i:=1 to Ndiv Do
    begin

      rcor:=R2-1/2*(R2-R)*(1+Cos(StepCos*i));

              {-- Sforamento --}

    if R2>R then
      begin
      angpr:=abs(StepAng*i);
      if angpr<PI/2-0.1 then
      if rcor > R/cos(angpr) then rcor:=R/cos(angpr);
      end
    else
      begin
      angpr:=abs(StepAng*(ndiv-i));
      if angpr<PI/2-0.1 then
      if rcor > R2/cos(angpr) then rcor:=R2/cos(angpr);
      end;
      xcor:=X1+rcor*Cos(x2+StepAng*i);
      ycor:=Y1+rcor*Sin(x2+StepAng*i);
      xcor:=xcor;
      ycor:=ycor;
      real1:=xcor-A0X;
      real2:=ycor-A0Y;
      (*converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);*)
      write(f,a,round(real1*fs),',',round(real2*fs),';');
      XPr:=XCor;
      YPr:=YCor;
    end;
  end;
end;





{***************************  MAIN      *******************************}

var rapp,ampx,xcen,ycen,fht:real;


begin
  new(ind);
  new(linech);
  fht:=1;
  rapp:=1000/750;
  if exist('stamp.cfg') then
  begin
    assign(fstamp,'stamp.cfg');
    reset(fstamp);
    read(fstamp,vstamp);
    close(fstamp);
  end;
if exist('plot.cfg') then
  begin
    assign(fplot,'plot.cfg');
    reset(fplot);
    read(fplot,vplot);
    close(fplot);
  end;

  adattato:=true;
  fr:=0;
  fx  :=0.025;
  sux1:=0;
  suy1:=0;
  sux2:=1000;
  suy2:=750;


  if sp=0 then
  begin
    spxi:=0;
    spyi:=0;
    spxf:=15700;
    spyf:=11680;
  end
  else
  begin
    if upcase(vplot.tipocarta[1])='A'then
    begin
      st1:='';
      st1[1]:=' ';
      st1[1]:=vplot.tipocarta[2];
      case st1[1] of
    '4':begin
        if vplot.tipo <=2 then
        begin
          spxi:=0;
          spyi:=0;
          spxf:=280*40;
          spyf:=193*40;
        end
        else
        begin
          spxi:=-280*20;
          spyi:=-193*20;
          spxf:=280*20;
          spyf:=193*20;
        end;
      end;
   '3':begin
        if vplot.tipo<=2 then
        begin
          spxi:=0;
          spyi:=0;
          spxf:=390*40;
          spyf:=266*40;
        end
        else
        begin
          spxi:=-390*20;
          spyi:=-266*20;
          spxf:=390*20;
          spyf:=266*20;
        end;
      end;
    '2':begin
        spxi:=-565*20;
        spyi:=-391*20;
        spxf:=565*20;
        spyf:=391*20;
      end;
    '1':begin
        spxi:=-812*20;
        spyi:=-565*20;
        spxf:=812*20;
        spyf:=565*20;
      end;
    '0':begin
        spxi:=-round(1125.89*20);
        spyi:=-round(886.88*20);
        spxf:=round(1125.89*20);
        spyf:=round(886.88*20);
      end;
    end;
    end
    else
    begin
      st1:='';
      st2:='';
      for ii := 1 to length(vplot.tipocarta) do
      begin
        if vplot.tipocarta[ii]=','then
        begin
          st1 :=st2;
          st2:='';
        end;
        if vplot.tipocarta[ii]<>','then st2:=st2+vplot.tipocarta[ii];
      end;
      val(st1,spxf,ii);
      val(st2,spyf,ii);

      if vplot.tipo <=2 then
        begin
          spxi:=0;
          spyi:=0;
          spxf:=spxf*40;
          spyf:=spyf*40;
        end
        else
        begin
          spxi:=-spxf*20;
          spyi:=-spyf*20;
          spxf:=spxf*20;
          spyf:=spyf*20;
        end;
      spxi:=0;
      spyi:=0;

    end;

  end;

  real1:=sux1;
  real2:=suy1;
  real3:=sux2;
  real4:=suy2;



  for ii:=1 to ultriga do
  begin
    if Dis^[ii]^.Entita<>'' then
    Case Dis^[ii]^.Entita[1] of
    'L' :begin
          if real1< xg3(dis^[ii]^.x2*fx,dis^[ii]^.y2*fx) then real1:=xg3(dis^[ii]^.x2*fx,dis^[ii]^.y2*fx);
          if real2< yg3(dis^[ii]^.y2*fx,dis^[ii]^.z2*fx) then real2:=yg3(dis^[ii]^.y2*fx,dis^[ii]^.z2*fx);
          if real1< xg3(dis^[ii]^.x1*fx,dis^[ii]^.y1*fx) then real1:=xg3(dis^[ii]^.x1*fx,dis^[ii]^.y1*fx);
          if real2< yg3(dis^[ii]^.y1*fx,dis^[ii]^.z1*fx) then real2:=yg3(dis^[ii]^.y1*fx,dis^[ii]^.z1*fx);

          if real3> xg3(dis^[ii]^.x2*fx,dis^[ii]^.y2*fx) then real3:=xg3(dis^[ii]^.x2*fx,dis^[ii]^.y2*fx);
          if real4> yg3(dis^[ii]^.y2*fx,dis^[ii]^.z2*fx) then real4:=yg3(dis^[ii]^.y2*fx,dis^[ii]^.z2*fx);
          if real3> xg3(dis^[ii]^.x1*fx,dis^[ii]^.y1*fx) then real3:=xg3(dis^[ii]^.x1*fx,dis^[ii]^.y1*fx);
          if real4> yg3(dis^[ii]^.y1*fx,dis^[ii]^.z1*fx) then real4:=yg3(dis^[ii]^.y1*fx,dis^[ii]^.z1*fx);
         end;

    end;
  end;
   if abs(real1-real3)/abs(real2-real4)>=rapp then ampx:=abs(real1-real3)/2
             else ampx:=abs(real2-real4)*rapp/2;
             xcen:=(real1+real3)/2;
             ycen:=(real2+real4)/2;

    xinfp:=(xcen-ampx)-1.5;
    yinfp:=(ycen-ampx/rapp)-1.5;
    xsupp:=(xcen+ampx)+1.5;
    ysupp:=(ycen+ampx/rapp)+1.5;

  assign(ffont,'roman.fnt');
  reset(ffont);
  assign(find,'font.ind^');
  reset(find);
  read(find,ind^);
  close(find);
  ii:=1;
  while not eof(ffont) do
  begin
    read(ffont,linech^[ii]);
    ii:=ii+1;
  end;
  close(ffont);
  ii:=0;
  tratt:=false;
{S}  if upcase (vplot.ruotata[1])=CH1 then fr:=90 else fr:=0;




  assign(f,'Spool.plt');
  rewrite(f);
  write(f,'RO',fr,';','SP1;','SC;',i,'LT;');

  if dim = 0 then
  begin
  for ii:=1 to ultriga do
  begin
    if Dis^[ii]^.Entita<>'' then
    Case Dis^[ii]^.Entita[1] of
    'L' :begin
          case dis^[ii]^.tlinea of
            1:write(f,'LT;');
            2:write(f,'LT2;');
            3:write(f,'LT4;');
          end;
          write(f,U);

          real1:=xgp(xg3(dis^[ii]^.x1*fx,dis^[ii]^.y1*fx));

          real2:=ygp(yg3(dis^[ii]^.y1*fx,dis^[ii]^.z1*fx));

          converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);
          write(f,a,round(real1),',',round(real2),';');
          write(f,d);
          real1:=xgp(xg3(dis^[ii]^.x2*fx,dis^[ii]^.y2*fx));
          real2:=ygp(yg3(dis^[ii]^.y2*fx,dis^[ii]^.z2*fx));
          converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);
          write(f,a,round(real1),',',round(real2),';');
          disbocs(ii);
         end;



    end;

  end;

  DisNumeris(15);
  end

  else
  begiN  (*   DIMENSIONATO       *****)


          IF (VPLOT.TIPO>2)and (sp>0) THEN
          BEGIN
            A0X:=22717;
            A0Y:=17937;
            a0:=true;
          END
          ELSE
          BEGIN
            A0X:=0;
            A0Y:=0;
            a0:=false;
          END;

          if exist(Driveplt+Nomecommessa+'.pnt') then
          begin
            assign(fept,(Driveplt+Nomecommessa+'.pnt'));
            reset(fept);
            read(fept,Ept);
           close(Fept);
           ii:=1;
           repeat
             with EpT[ii] do
             begin
              if (RisultCalc^.Quota*conf^.AltNum/40000>=ZPmin)and(RisultCalc^.Quota*conf^.AltNum/40000<=ZPmax) then
              begin
                Nomepianta:=NomeP;
              end;
             end;
             ii:=Ii+1;
           until (ii>MaxEPiante)or(Nomepianta<>'');
         end;
          if exist(Driveplt+NomePianta+'.plt') then
          begin
            assign(ft,DrivePlt+NomePianta+'.plt');
            reset(ft);
            alzata:=true;
            st1:='';
            st2:='';
            while not eof(ft) do
            begin
              read(ft,ch);
              if a0 then
              begin
                case ch of
               'U':alzata:=true;

               'D':alzata:=false;

               'A':begin
                     repeat
                      read(ft,ch);
                      if ch<>','then st1:=st1+ch;
                     until ch=',';
                     repeat
                       read(ft,ch);
                       if ch <>';' then st2:=st2+ch;
                     until (ch=';') or (eoln(ft));

                     val(st1,xt,v);
                     val(st2,yt,v);
                     st1:='';
                     st2:='';

                     if alzata then
                     begin
                       if (xt <> 0)and(yt <> 0) then
                       begin
                         xt:=xt*fs;
                         yt:=yt*fs;
                       end;
                       write(f,u,a,round(xt),',',round(yt),';');
                     end
                     else
                     begin
                       if (xt <> 0)and(yt <> 0) then
                       begin
                         xt:=xt*fs;
                         yt:=yt*fs;
                       end;
                       write(f,d,a,round(xt),',',round(yt),';');
                     end;


                   end;
                end;
              end
              else
              begin
                case ch of
               'U':alzata:=true;

               'D':alzata:=false;

               'A':begin
                     repeat
                      read(ft,ch);
                      if ch<>','then st1:=st1+ch;
                     until ch=',';
                     repeat
                       read(ft,ch);
                       if ch <>';' then st2:=st2+ch;
                     until (ch=';') or (eoln(ft));

                     val(st1,xt,v);
                     val(st2,yt,v);
                     st1:='';
                     st2:='';

                     if alzata then
                     begin
                       if (xt <> 0)and(yt <> 0) then
                       begin
                         xt:=(xt+22717)*fs;
                         yt:=(yt+17937)*fs;
                       end;
                       write(f,u,a,round(xt),',',round(yt),';');
                     end
                     else
                     begin
                       if (xt <> 0)and(yt <> 0) then
                       begin
                         xt:=(xt+22717)*fs;
                         yt:=(yt+17937)*fs;
                       end;
                       write(f,d,a,round(xt),',',round(yt),';');
                     end;


                   end;
                end;
              end;
            end;
            close(ft);
          end;

          tratt:=false;
          fht:=160;

          Assign(Fdim,nome);
          Reset(Fdim);
          While not(eof(Fdim)) do
          begin
            read(Fdim,Vettore);

           if(
           ((Vettore.z1>=Zmin_p)and(Vettore.z1<=Zmax_p))or
           ((Vettore.z2>=Zmin_p)and(Vettore.z2<=Zmax_p))
           ) then
           BEGIN

           Case Vettore.Entita[1] of
            'L':begin

                 {case vettore.tlinea of
                    1:writeln(f,'LT;');
                    2:writeln(f,'LT2;');
                    3:writeln(f,'LT4;');
                  end;}
                  if vettore.colore=costant.colcan then
                  begin
                    write(f,'SP',vplot.penne[colp[vettore.colore]],';');
                    write(f,U);
                    real1:=(Vettore.x1)-A0X;
                    real2:=(Vettore.y1)-A0Y;

                    write(f,a,round(real1*fs),',',round(real2*fs),';');
                    write(f,d);

                    real3:=(Vettore.x2)-A0X;
                    real4:=(Vettore.y2)-A0Y;

                    write(f,a,round(real3*fs),',',round(real4*fs),';');
                  end;
                end;
         'F','*':begin
                   if vettore.entita[1]<>'*' then
                   begin

                     k:=0;
                     write(f,'SP',vplot.penne[colp[vettore.colore]],';');
                     pxi3:=(Vettore.x1)-A0X;
                     pyi3:=(Vettore.y1)-A0Y;
                     write(f,U,'LT');
                     write(f,a,round(pxi3*fs),',',round(pyi3*fs),';');
                   end
                   else
                   begin
                     k:=k+1;
                     case k of
                       1:begin
                           write(f,d);
                           real1:=(Vettore.x1)-A0X;
                           real2:=(Vettore.y1)-A0Y;
                           {converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);}
                           write(f,a,round(real1*fs),',',round(real2*fs),';');
                         end;
                       2:begin
                           write(f,d);
                           real1:=(Vettore.x1)-A0X;
                           real2:=(Vettore.y1)-A0Y;
                           {converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);}
                           write(f,a,round(real1*fs),',',round(real2*fs),';');
                         end;
                       3:begin
                           write(f,d);
                           real1:=(Vettore.x1)-A0X;
                           real2:=(Vettore.y1)-A0Y;
                           {converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);}
                           write(f,a,round(real1*fs),',',round(real2*fs),';');
                           write(f,a,round(pxi3*fs),',',round(pyi3*fs),';');
                         end;
                     end;
                   end;
                 end;

              'A':begin

                  {
                   case vettore.tlinea of
                     1:tratt:=false;
                   2,3:tratt:=true;
                  end;
                  writeln(f,'SP',vettore.colore);}
                  write(f,'SP',vplot.penne[colp[vettore.colore]],';');

                  real1:=((Vettore.x1)-A0X);
                  real2:=((Vettore.y1)-A0Y);
                  real3:=((Vettore.R));
                  real4:=(Vettore.x2);
                  real5:=(Vettore.y2);
                  arcplt(real1,real2,real4,real5,real3,false);
                 end;

              'C':begin
                  { case vettore.tlinea of
                    1:tratt:=false;
                  2,3:tratt:=true;
                  end;}

                  write(f,'SP',vplot.penne[colp[vettore.colore]],';');
                  real1:=(Vettore.x1)-A0X;
                  real2:=(Vettore.y1)-A0Y;
                  real3:=(Vettore.R);
                  real4:=0;
                  real5:=2*pi;
                  arcplt(real1,real2,real4,real5,real3,false);
                end;

            'P':PArcP;






  end;
 END;
 end;

 close(fdim);

 Assign(Fdim,nome);
 Reset(Fdim);

 While not(eof(Fdim)) do
          begin
            read(Fdim,Vettore);

           if(
           ((Vettore.z1>=Zmin_p)and(Vettore.z1<=Zmax_p))or
           ((Vettore.z2>=Zmin_p)and(Vettore.z2<=Zmax_p))
           ) then
           BEGIN

           Case Vettore.Entita[1] of
           'Q':begin

                   st1:=outtextN(vettore.r,vettore.x2);
                   write(f,'SP',vplot.penne[colp[Costant.colQ]],';');
                   s_String(st1,vettore.x1,vettore.y1,round(vettore.y2),costant.altQuo*40);

                end;
           'L':begin

                 {case vettore.tlinea of
                    1:writeln(f,'LT;');
                    2:writeln(f,'LT2;');
                    3:writeln(f,'LT4;');
                  end;}
                  if vettore.colore=costant.colQ then
                  begin
                    write(f,'SP',vplot.penne[colp[vettore.colore]],';');
                    write(f,U);
                    real1:=(Vettore.x1)-A0X;
                    real2:=(Vettore.y1)-A0Y;

                    write(f,a,round(real1*fs),',',round(real2*fs),';');
                    write(f,d);

                    real3:=(Vettore.x2)-A0X;
                    real4:=(Vettore.y2)-A0Y;

                    write(f,a,round(real3*fs),',',round(real4*fs),';');
                  end;
                end;
           end;
           end;
         end;
 close(fdim);

END;
  write(f,U,P,'0;');
  close(f);
  dispose(ind);
  dispose(linech);
end;
end.

