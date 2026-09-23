{$M 8192,0,221184}
{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}


unit crdummy;


{--------------------------------------------------------------------}
{			INTERFACE				     }
{--------------------------------------------------------------------}
interface


Var ContPezzi:integer;

procedure InitCr;
procedure CloseCr;

procedure DisegnaNumPezzo(X1,Y1,Offset:real);
procedure WritePezzoSpecialeCr(Cod:string;Ang,Curv,Lung,Rap,Rap1,B1,H1,B2,H2,B3,H3,B4,H4,D1,D2,D3,D4:real);
Procedure Pezzi_Dritti(Tr,trat:integer;x1,y1,x2,y2,x3,y3,x4,y4:real);

{--------------------------------------------------------------------}
{			IMPLEMENTATION				     }
{--------------------------------------------------------------------}
implementation

procedure InitCr;
begin
end;

procedure CloseCr;
begin
end;

procedure DisegnaNumPezzo(X1,Y1,Offset:real);
begin
end;

procedure WritePezzoSpecialeCr(Cod:string;Ang,Curv,Lung,Rap,Rap1,B1,H1,B2,H2,B3,H3,B4,H4,D1,D2,D3,D4:real);
begin
end;

Procedure Pezzi_Dritti(Tr,trat:integer;x1,y1,x2,y2,x3,y3,x4,y4:real);
begin
end;

{-------------------------------------------------------------------}
end.