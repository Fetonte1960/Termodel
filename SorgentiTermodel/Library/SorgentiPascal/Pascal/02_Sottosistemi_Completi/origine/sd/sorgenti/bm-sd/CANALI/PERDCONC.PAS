{*-*-*-*-*-*-*-*-*-*-*-*-*-*  PerdConc       *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Function PerdConc(Codice:string;vel,per,diam:real;var tipoperd:integer):real;

Const Ce:array[1..5,1..3] of real=
(
  (  0           , 22.231198    ,-12.923621      ),
  (  0           , 18.76161627  ,-14.16705374    ),
  (  0           ,-12.4573011   , 12.01075396    ),
  (  0           ,  4.5278429   , -5.05522072    ),
  (  0           , -0.6247295728,  0.763505331456)
);

{ 1960  REM  Filecoef:
1970          FOR I=1 TO 5
1980          FOR J=1 TO 3
1990          READ CE(I,J)
2000          NEXT J
2010          NEXT I
2020          DATA 0,22.231198,-12.923621,0,18.76161627,-14.16705374,0
2030          DATA -12.4573011,12.01075396,0,4.5278429,-5.05522072,0
2040          DATA -.6247295728,.763505331456
2050         RETURN  }

var i,j:integer;
    bc:array[1..3]of real;
    VX,LQ:real;
    M1,T :integer;

begin

tipoperd:=0;
PerdConc:=0;
Codice:=UpString(Codice);   {-- Ricerca del codice --}
j:=0;
  repeat
  j:=J+1;
  until (UpString(Perd_D^[j].Cod)=(Codice))or
                               (j=Maxperd);

if (UpString(Perd_D^[j].Cod)<>codice)and
                         (j=Maxperd)  then
writeln(' perdita ',codice,' non trovata')

else

  begin
  if Perd_d^[j].Leq<>0 then      {-- LEq --}
    begin
    for M1:=1 TO 3 do    {-- INTEGRALMENTE PRESO DA VECCHIO TUBI --}
    BC[M1]:=CE[5,M1];
    Vx:=vel;
    IF Vel<0.3 THEN VX:=0.3;
    IF Vel>3 THEN  VX:=3;
    FOR M1:=3 DownTO 1 do
    FOR  T:=4 DownTO 1 do
    BC[M1]:=VX*BC[M1]+CE[T,M1];

    LQ:=BC[3];
    FOR T:=2 DownTO 1 do
    LQ:=(Diam/1000)*LQ+BC[T]; {-- LUNGHEZZA EQ. IN DIAMETRI DELLA CURVA DI RIFERIMENTO--}

    PerdConc:=LQ*Perd_d^[j].Leq*Per;
    tipoperd:=2;
    end
  else
    begin
    if Perd_d^[j].Zeta<>0 then   {
    -- Zeta --}
      begin
      tipoperd:=1;
      PerdConc:=FluM_D^.Dens*Sqr(Vel)/2*Perd_d^[j].Zeta;
      end
    else
        begin                   {-- Perdite Tabulate --}
        end;
    end
  end

end;
