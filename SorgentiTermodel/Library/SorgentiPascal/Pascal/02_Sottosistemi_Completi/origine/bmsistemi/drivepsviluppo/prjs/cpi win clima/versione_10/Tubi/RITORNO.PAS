{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit Ritorno;

INTERFACE

uses Definiz,angoli, UGrafoDXF;
//printer,definiz,globfunz,genproc,Angoli,Load_D,wm,controll;

Procedure DisRit;
Var i:Integer;

{---------------------------------------------------------------------------}
implementation
uses leggidxf;

Procedure DisRit;
Var St1Dist  :string;
    DistRit  :Real;
    CodEr    :integer;
    XOri,YOri:ReaL;
    Ori      :Integer;
    Ud       :Real;
    Vert     :Boolean;
    ManritPr :Boolean;

Var Dir,Dir1,DirZ:Real;

{---------------------------------------------------------------------------}

Procedure IterRid(Tr:integer;Spostx,Xpr,YPr,ZPr,UD:Real);
Var i,j:Integer;
    Spx,spy:real;
    X1P,Y1P:real;
    Croce:Boolean;
    DirBr:Real;
    SetX2:Boolean;

begin

X1p:=XPr;
Y1p:=YPr;

Dati^[tr]^.x:=0;
Dati^[tr]^.Y:=0;

i:=Dati^[tr]^.Ti;

While Dis^[i]^.NLinea<>0 do    {-- Spostamento tronco --}
  begin
  CalcAng(i,Dis^[i]^.NLinea,Dir1,DirZ,Ori,Vert,UD);
  if not(ug(dirz,0,1)) then
    begin
    Dir1:=Pi/2;
    if Dirz<0 then Dir1:=-Dir1;
    end;

  CalcDirez(i,Dir,DirZ);
  spx:=spostx;
  spy:=-spostx*Sin(Dir1);

  if ug(abs(dirz),Pi/2,1) then
    begin
    Dis^[i]^.X2:=X1P;
    Dis^[i]^.Y2:=Y1P;
    end
  else
    begin
    UD:=Dir;
    Modicord1(spx,spy,0,0,dir,1);
    Dis^[i]^.X2:=Dis^[i]^.x2+spx;
    Dis^[i]^.Y2:=Dis^[i]^.Y2+spy;
    end;

  Dis^[i]^.X1:=X1p;
  Dis^[i]^.Y1:=Y1p;

  i:=Dis^[i]^.NLinea;

  if Not(ug(abs(dirz),Pi/2,1)) then
    begin
    X1p:=Dis^[i]^.x1+Spx;
    Y1p:=Dis^[i]^.Y1+Spy;
    end;
  end;



if Dati^[Dis^[i]^.Tronco]^.Pros[1]=0 then  {-- Terminale --}
  begin
  CalcDirez(i,Dir,DirZ);
  if Not(ug(abs(dirz),Pi/2,1)) then
    begin
    UD:=Dir;
    spx:=spostx;
    Spy:=0;

    Modicord1(spx,spy,0,0,dir,1);

    Dis^[i]^.X2:=Dis^[i]^.x2+spx;
    Dis^[i]^.Y2:=Dis^[i]^.Y2+spy;
    end
  else
    begin
    Dis^[i]^.X2:=X1p;
    Dis^[i]^.Y2:=Y1p;
    end;
  Dis^[i]^.X1:=X1p;
  Dis^[i]^.Y1:=Y1p;
  end
else
 begin
  j:=1;
  DirBr:=-Pi/2;

  While (j<=6)and(Dati^[tr]^.Pros[j]<>0) Do
  begin
    CalcAng(i,Dati^[Dati^[tr]^.Pros[j]]^.Ti,Dir,DirZ,Ori,Vert,UD);  {-- Cerca Croci e TEE  -}

    if not(ug(dirz,0,1)) then  Dirbr:=Pi/2
    else
      begin
      If ((Dir>0.1)or(Dir<-0.1)) then
      if Dir>DirBr Then DirBr:=dir;
      end;
    j:=J+1;
  end;

  spx:=spostx;
  spy:=-spostx*Sin(DirBr);
  CalcDirez(i,Dir,DirZ);
  if Not(ug(abs(dirz),Pi/2,1)) then
  begin
    Ud:=Dir;
    Modicord1(spx,spy,0,0,dir,1);

    Dis^[i]^.X2:=Dis^[i]^.x2+spx;
    Dis^[i]^.Y2:=Dis^[i]^.Y2+spy;
  end
  else
    begin
     Dis^[i]^.X2:=X1p;
     Dis^[i]^.Y2:=Y1p;
    end;

  Xpr:=Dis^[i]^.X2;
  Ypr:=Dis^[i]^.Y2;
  Zpr:=Dis^[i]^.Z2;

  Dis^[i]^.X1:=X1p;
  Dis^[i]^.Y1:=Y1p;

  j:=1;
  While (j<=6)and(Dati^[tr]^.Pros[j]<>0) Do
  begin
    CalcAng(i,Dati^[Dati^[tr]^.Pros[j]]^.Ti,Dir,DirZ,Ori,Vert,UD);
    spx:=spostx;
    if (Dir < -0.1)and(DirBr>0.1)and(ug(dirz,0,1))then SpX:=-SpostX;
    IterRid(Dati^[tr]^.Pros[j],Spx,Xpr,Ypr,Zpr,UD);
    j:=J+1;
  end;
 end;
end;

Var i,ultr:integer;
Begin

  DistRit:=0.06;

  if RisultCalc^.Origine<>0 then
  begin
    XOri:=-DistRit;//*40/conf^.AltNum;
    YOri:=0;
    CalcDirez(Dati^[RisultCalc^.Origine]^.Ti,Dir,DirZ);
    ModiCord1(XOri,YOri,Dis^[Dati^[RisultCalc^.Origine]^.Ti]^.X1,Dis^[Dati^[RisultCalc^.Origine]^.Ti]^.Y1,Dir,1);

    ITerRid(RisultCalc^.Origine,-DistRit{*40/conf^.AltNum},XOri,YOri,
          Dis^[Dati^[RisultCalc^.Origine]^.Ti]^.Z1,0);

    ultr:=ultriga;
    for i:=1 to ultr do
      with dis^[i]^ do
      begin
       {if UltRiga < LungDis then
          inc(ultriga);
       if dis^[ultriga]=nil then new(dis^[ultriga]);
       dis^[ultriga]^ := dis^[i]^;  }
       if PianoCAD <> '' then
          G_Linea(x1,y1,z1,x2,y2,z2,'P1_QUOTE', PianoCAD);
      end;
  end;

End;


end.
