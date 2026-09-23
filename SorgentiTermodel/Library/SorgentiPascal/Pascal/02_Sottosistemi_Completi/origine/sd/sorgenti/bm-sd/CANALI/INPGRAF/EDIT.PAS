{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}
{$C DEMANDLOAD}
unit EDIT;

INTERFACE

uses definiz,globfunz,genproc,halotp4,graph,WM,esiste,controll,editquo{$ifdef win},multilin{$endif};
Procedure Edit_Dis;

{---------------------------------------------------------------------------}

implementation


{*-*-*-*-*-*-*-*-*-*-*-*-*-*  MovLine       *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure MovLine(NL:integer;NewX1,NewY1,NewZ1,NewX2,NewY2,NewZ2:real);

begin
int1:=0;
SetColor(int1);
with Dis^[NL]^ do
  begin
  Real1:=xg(x1,y1);
  Real2:=yg(y1,z1);
  MovAbs1(@real1,@real2);
  Real3:=xg(x2,y2);
  Real4:=yg(y2,z2);
  LnAbs1(@real3,@real4);
  {$ifdef win}
  multi_line(nl);
  {$endif}
  X1:=NewX1;
  Y1:=NewY1;
  Z1:=NewZ1;
  X2:=NewX2;
  Y2:=NewY2;
  Z2:=NewZ2;
  SetLcolor(NL);
  Real1:=xg(x1,y1);
  Real2:=yg(y1,z1);
  MovAbs1(@real1,@real2);
  Real3:=xg(x2,y2);
  Real4:=yg(y2,z2);
  LnAbs1(@real3,@real4);
  {$ifdef win}
  multil1(x1,y1,z1,x2,y2,z2);
  {$endif}
  end;
end;

Procedure Edit_Dis;

Var i,Sel,NewCol:integer;
    N_x,N_y,N_z:real;
    S_L:string;
    DimAtt:string; (* cippo *)

begin
 DimAtt:='';
  repeat
      S_L:=ReadCom({W_M(50)}'Colore/Sposta/Pezzo',CH27,0);
{C}  {S_L:=ReadCom(W_M(50),CH27,0);} {'Colore/Sposta','C',0);} {*TR*}
     { cippo deve diventare 'Colore/Sposta/Pezzo','C',0);} {*TR*}
  S_L:=UPString(S_L);
{C,S}  until (S_L='P') or  {*TR*} (S_L=CH27)or(S_L=CH28)or(S_L='');
  {delay(400);}

{P}(*cippo ramo edita pezzo*) if S_L='P' then   {*TR*}
                               if (RisultCalc^.DisDimens){and(not(sezione))} then
                                       Editquote
                               else Dimatt:='Dimensionato non attivato';



{C}if S_L=CH27 then
  begin
  Cod:=SelezLinea(sel);

  if Cod<>130 then
    begin

      repeat
{B}      S_L:=ReadCom(W_M(51),CH29,0);  { 'Nuovo colore Bianco/Giallo/Rosso/Colore corrente','B',0);}
      S_L:=UPString(S_L);
{B,G,R,C} until (S_L=CH29)or(S_L=CH30)or(S_L=CH31)or(S_L=CH32)or(S_L='');

    NewCol:=0;
{B}    if S_L=CH29 then NewCol:=1;
{G}    if S_L=CH30 then NewCol:=2;
{R}    if S_L=CH31 then NewCol:=3;

    with Dis^[sel]^ do
      begin
      if NewCol<>0 then
      color:=newcol
      {ModiColor(Color,NewCol,False)}
      else color:=conf^.RColore;

      SetLColor1(color);
      Real1:=xg(x1,y1);
      Real2:=yg(y1,z1);
      MovAbs1(@real1,@real2);
      Real1:=xg(x2,y2);
      Real2:=yg(y2,z2);
      LnAbs1(@real1,@real2);
      {$ifdef win}
      multi_line(sel);
      {$endif}
      end
    end
  end;
{S}if S_L=CH28 then
  begin
  Richiesta(W_M(32)); {'Selezionare punto');}
  st1:='';
  readcord(x,y,cod,scelta,st1,5);
  if cod<>130 then
    begin
    sel:=trattosel;
    with dis^[sel]^ do
      begin
      xp:=xg(x1,y1);
      yp:=yg(y1,z1);
      end;

    trattosel:=0; {-- cerca la linea su cui e attaccata --}
    i:=1;
    repeat
    if (dis^[i]^.entita='L')and(dis^[i]^.X2=Dis^[sel]^.x1)and(dis^[i]^.y2=Dis^[sel]^.y1) then
    trattosel:=i;
    i:=i+1;
    until (trattosel<>0)or(i>UltRiga);

    retino:=true;
    movabs(@xp,@yp);
    richiesta(W_M(52));  {'Nuova posizione');}
    st1:='';
    readcord(x,y,cod,scelta,st1,2);
    delln;
    setclip(@xw1,@yw1,@xw2,@yw2);
    setcolor(7);
    setwritemode(0);
    isocur(x,y,2);
    {delay(200);}

    if cod=132 then
      begin
      N_x:=xe(x);
      N_y:=Ye(x,y);
      N_z:=Ze(y);
      with Dis^[Sel]^ do
        begin
        MovLIne(Sel,X1,Y1,Z1,N_x,N_y,N_z);
        if Dis^[sel]^.nlinea<>0 then
        MovLine(nlinea,N_x,N_y,N_z,Dis^[nlinea]^.x2,Dis^[nlinea]^.y2,Dis^[nlinea]^.z2)
        else
          begin
          for i:=1 to 3  do
          if Dati^[Tronco]^.Pros[i]<>0 then
            begin
            MovLine(Dati^[Dati^[Tronco]^.Pros[i]]^.Ti,
                    N_x,N_y,N_z,
                    Dis^[Dati^[Dati^[Tronco]^.Pros[i]]^.Ti]^.X2,
                    Dis^[Dati^[Dati^[Tronco]^.Pros[i]]^.Ti]^.y2,
                    Dis^[Dati^[Dati^[Tronco]^.Pros[i]]^.Ti]^.z2);
            CancNum(Dati^[Tronco]^.Pros[i]);
            initRec(Dati^[Tronco]^.Pros[i],3);
            end;
          CancNum(Tronco);
          initRec(Tronco,3);
          end
        end;
      end;
    end;
  end;

Richiesta(Dimatt);   (* cippo *)
end;

end.